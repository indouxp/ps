param($if)
###############################################################################
# 192.168.0.1から、192.168.0.255まで、route addし、192.168.11.1に、
# pingが通るところで、routeを固定する
###############################################################################

$ErrorActionPreference = "Stop"
set-variable -name script -value (get-item $MyInvocation.MyCommand.path) -option constant

###############################################################################
function add-route {
  param($ip, $gw)
  [String]::Format('add-route {0} {1}', $ip, $gw)
  &route add $ip mask 255.255.255.0 $gw if $if
  return $lastexitcode
}

###############################################################################
function delete-route {
  param($ip)
  [String]::Format('delete-route {0}', $ip)
  &route delete $ip
  return $lastexitcode
}

###############################################################################
function print-route {
  [String]::Format('print-route') 
  &route print
  return $lastexitcode
}

###############################################################################
function ping2 {
  param($ip)
  [String]::Format('ping {0}', $ip)
  &ping -n 1 $ip
  return $lastexitcode
}

###############################################################################
function main {
  try {
    if ($if -eq $null) {
      throw "please set argument vector"
    }
    [String]::Format('{0}:LastWriteTime:{1}', $script.name, $script.lastwritetime)
    for ($i = 1; $i -lt 256; $i++) {
      add-route "192.168.11.0" ([String]::Format('{0}.{1}', '192.168.0', $i))
      $rc = $LastExitCode
      if ($rc -ne 0) {
        throw "add-route"
      }
      ping2 "192.168.11.1"
      $rc = $LastExitCode
      [String]::Format('ping status {0}', $rc)
      if ($rc -eq 0) {
        break
      }
      delete-route "192.168.11.0"
      $rc = $LastExitCode
      if ($rc -ne 0) {
        throw "delete-route"
      }
    }
    print-route
  } catch [Exception] {
    $error[0]
    exit 9
  }
}

###############################################################################
Set-PSDebug -strict
main | out-file -encoding default ($script.name + ".log")
exit 0
