Import-Module `
    (join-path `
        -path $PSScriptRoot `
        -childPath 'ITG.WinAPI.Common' `
    ) `
    -Force `
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

Export-ModuleMember `
;
