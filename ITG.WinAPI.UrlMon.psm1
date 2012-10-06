﻿Import-Module `
    (join-path `
        -path $PSScriptRoot `
        -childPath 'ITG.WinAPI.Common' `
    ) `
;

'ITG.WinAPI.UrlMon.cs' `
| % {
    Add-CSharpType `
        -Path (join-path `
            -path $PSScriptRoot `
            -childPath $_ `
        ) `
    ;
} `
;

function Get-MIME {
	<#
		.Synopsis
		    Функция определяет MIME тип файла по его содержимому и расширению имени файла.
		.Description
		    Функция определяет MIME тип файла по его содержимому и расширению имени файла
            (если файл недоступен).
            Обёртка для API FindMimeFromData.
        .Link
            http://msdn.microsoft.com/en-us/library/ms775107(VS.85).aspx
            http://social.msdn.microsoft.com/Forums/en-US/Vsexpressvcs/thread/d79e76e3-b8c9-4fce-a97d-94ded18ea4dd
		.Example
			"logo.jpg" | Get-MIME
	#>
    [CmdletBinding(
    )]
	
    param (
        # путь к файлу, MIME для которого необходимо определить
        [Parameter(
			Mandatory=$true,
			Position=0,
			ValueFromPipeline=$true
		)]
        [System.IO.FileInfo]$Path
	)

    process {
        $length = 0;
        [Byte[]] $buffer = $null;
        if ( [System.IO.File]::Exists( $Path ) ) {
            Write-Verbose "Определяем MIME тип файла по его содержимому (файл $($Path.FullName) доступен).";
            $fs = New-Object System.IO.FileStream (
                $Path, 
                [System.IO.FileMode]::Open,
                [System.IO.FileAccess]::Read,
                [system.IO.FileShare]::Read,
                256
            );
            try {
                if ( $fs.Length -ge 256) {
                    $length = 256;
                } else {
                    $length = $fs.Length;
                };
                if ( $length ) {
                    $buffer = New-Object Byte[] (256);
                    $length = $fs.Read( $buffer, 0, $length );
                };
            } finally {
                $fs.Dispose();
            };
        } else {
            Write-Verbose "Определяем MIME тип файла по расширению его имени (файл $($Path.FullName) недоступен).";
        };
        [System.UInt32] $mimeType = 0;
        $err = [ITG.WinAPI.UrlMon]::FindMimeFromData(
            0,
            $Path.FullName, 
            $buffer, 
            $length, 
            $null, 
            0x00000001 + 0x00000020, 
            [ref]$mimeType, 
            0
        );

        $mimeTypePtr = [System.IntPtr]$mimeType;
        $mime = [System.Runtime.InteropServices.Marshal]::PtrToStringUni( $mimeTypePtr );
        [System.Runtime.InteropServices.Marshal]::FreeCoTaskMem( $mimeTypePtr );
        $mime;
	}
}  

Export-ModuleMember `
    Get-MIME `
;
