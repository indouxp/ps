$ErrorActionPreference = "Stop"
set-variable -name script -value (get-item $MyInvocation.MyCommand.path) -option constant

function main {
  try {
    [String]::Format('{0}:LastWriteTime:{1}', $script.name, $script.lastwritetime)
    . ".\ut-lib.ps1"
  } catch [Exception] {
    $error[0]
    exit 9
  }
}

Set-PSDebug -strict
main | tee ($script.name + ".log")
exit 0
