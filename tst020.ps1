###############################################################################
#	配列を関数に渡す
###############################################################################

function sub {
  Param($ary)
	foreach ($val in $ary) {
  	$val
	}
}
function main {
	$ary = @("192.168.0.2", "192.168.0.3", "192.168.0.4")
  sub $ary
}
Set-PSDebug -strict
main
