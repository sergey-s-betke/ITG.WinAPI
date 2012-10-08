[CmdletBinding(
	SupportsShouldProcess=$true,
	ConfirmImpact="Medium"
)]
param ()

Import-Module `
	(Join-Path `
        -Path ( ( [System.IO.FileInfo] ( $MyInvocation.MyCommand.Path ) ).Directory ) `
        -ChildPath 'ITG.WinAPI' `
    ) `
	-Force `
;

'ITG.WinAPI.UrlMon\test\logo.jpg' `
, 'ITG.WinAPI.UrlMon\test\logo2.jpg' `
| % {
    (join-path `
        -path ( ( [System.IO.FileInfo] ( $myinvocation.mycommand.path ) ).directory ) `
        -childPath $_ `
    ) `
} `
| Get-MIME -ErrorAction Continue `
;
