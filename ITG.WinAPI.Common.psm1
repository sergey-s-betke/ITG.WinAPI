function Add-CSharpType {
	<#
		.Synopsis
		    Компилирует c# код с целью добавления классов c# в powerShell.
		.Description
		    Компилирует c# код с целью добавления классов c# в powerShell.
            Применяем для получения доступа к Windows API
		.Example
			Создание группы сервисов:
			"Бетке","Сергей","Сергеевич" | ConvertTo-Translit
	#>
    [CmdletBinding(
    	ConfirmImpact = 'Low',
        SupportsShouldProcess = $true
    )]
	
    param (
        # C# код в hereString
        [Parameter(
            ParameterSetName="FromString",
			Mandatory=$true,
			Position=0
		)]
        [string]$Code
    ,
        # путь к файлу C#
        [Parameter(
            ParameterSetName="FromFile",
			Mandatory=$true,
			Position=0,
			ValueFromPipeline=$true
		)]
        [System.IO.FileInfo]$Path
	)

    begin {
    <#
        $cp = New-Object Microsoft.CSharp.CSharpCodeProvider;
        $cpar = New-Object System.CodeDom.Compiler.CompilerParameters;
    #>
    }
    process {
        switch ($PsCmdlet.ParameterSetName) { 
            'FromString' {
                if ( $PSCmdlet.ShouldProcess( 'компилировать и добавить код c# из строки?' ) ) {
                    Write-Verbose 'Компилируем и добавляем код c# из строки';
                    # $cp.CompileAssemblyFromSource( $cpar, $Code );
                    Add-Type $Code;
                };
            } 
            'FromFile' {
                if ( $PSCmdlet.ShouldProcess( "компилировать и добавить код c# из файла $($Path.FullName)?" ) ) {
                    Write-Verbose "Компилируем и добавляем код c# из файла $($Path.FullName)";
                    # $cp.CompileAssemblyFromFile( $cpar, $Path );
                    Add-Type -Path $Path;
                };
            } 
        };
	}
    end {
    <#
        $cp.Dispose();
    #>
    }
}  

Export-ModuleMember `
    Add-CSharpType `
;
