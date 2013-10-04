
$EmailFrom = gindou.tsystem@gmail.comh 
$EmailTo =h1064bw29@mcea.jph 
$Subject = "ƒ^ƒCƒgƒ‹" 
$Body = "–{•¶"  
$SMTPServer = "smtp.gmail.com" 
$SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, 587) 
$SMTPClient.EnableSsl = $true 
$SMTPClient.Credentials = New-Object System.Net.NetworkCredential("indou.tsystem@gmail.com", "ahdzkuzfflqdgfvy")
$SMTPClient.Send($EmailFrom, $EmailTo, $Subject, $Body)

