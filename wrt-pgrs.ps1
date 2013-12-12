
for ($i = 1; $i -le 100; $i++) {
  Write-Progress "サンプル" "進行状況:" -PercentComplete $i
  Start-Sleep -Milliseconds 80
}
