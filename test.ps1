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

'test\logo.jpg' `
, 'test\logo2.jpg' `
| % {
    (join-path `
        -path ( ( [System.IO.FileInfo] ( $myinvocation.mycommand.path ) ).directory ) `
        -childPath $_ `
    ) `
} `
| Get-MIME `
;
