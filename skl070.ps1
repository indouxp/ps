###############################################################################
# É\Å[ÉXÇÃì«Ç›çûÇ›
#
###############################################################################
[string]$MyPath = $MyInvocation.MyCommand.Path
[string]$MyDir = $MyPath -replace "\\[^\\]+$", ""
[string]$Module = $MyDir + "\" + "mod070.ps1"

Import-Module $Module

Get-Hello
