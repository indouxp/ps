
for ($i = 1; $i -le 100; $i++) {
  Write-Progress "�T���v��" "�i�s��:" -PercentComplete $i
  Start-Sleep -Milliseconds 80
}
