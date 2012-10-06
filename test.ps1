[CmdletBinding(
	SupportsShouldProcess=$true,
	ConfirmImpact="Medium"
)]
param ()

Import-Module `
    (join-path `
        -path ( ( [System.IO.FileInfo] ( $myinvocation.mycommand.path ) ).directory ) `
        -childPath 'ITG.WinAPI.UrlMon' `
    ) `
	-Force `
;

$fileInfo = [System.IO.FileInfo]'test\logo.jpg';

$length = 0;
[Byte[]] $buffer = $null;
if ( [System.IO.File]::Exists( $fileInfo ) ) {
    $fs = New-Object System.IO.FileStream (
        $fileInfo, 
        [System.IO.FileMode]::Open,
        [System.IO.FileAccess]::Read,
        [system.IO.FileShare]::Read,
        256
    );
    try {
        $buffer = New-Object Byte[] (256);
        if ( $fs.Length -ge 256) {
            $length = 256;
        } else {
            $length = $fs.Length;
        };
        if ( $length ) {
            $length = $fs.Read( $buffer, 0, $length );
        };
    } finally {
        $fs.Dispose();
    };
};

[System.UInt32] $mimeType = 0;

$err = [ITG.WinAPI.UrlMon]::FindMimeFromData(
    0,
    $fileInfo.FullName, 
    $buffer, 
    $length, 
    $null, 
    0x00000001 + 0x00000020, 
    [ref]$mimetype, 
    0
);

$mimeTypePtr = [System.IntPtr]$mimeType;
$mime = [System.Runtime.InteropServices.Marshal]::PtrToStringUni( $mimeTypePtr );
[System.Runtime.InteropServices.Marshal]::FreeCoTaskMem( $mimeTypePtr );
$mime;