Param($path, $day)

function main {
  Param($path, $day)
  $due_date = (Get-Date).AddDays($day)
  Get-ChildItem -recurse $path |
    Where-Object {
      $_.LastWriteTime -lt $due_date
    }
}

try {
  main $path $day
} catch [Exception] {
  $error[0]
  exit 9
}
exit 0
