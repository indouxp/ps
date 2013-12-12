$ie = new-object -com "InternetExplorer.Application"
$ie.navigate("http://localhost/MiniCalc/Default.aspx")
$ie.visible = $true
$ie | get-member
