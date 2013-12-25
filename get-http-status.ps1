function Get-HttpStatusCode
{
  param(
    [string]$Code
  )
  begin {
    $enumType = [System.Net.HttpStatusCode]
    $codeNames = [enum]::GetNames($enumType)
    $codes = $codeNames |
    %{
      [pscustomobject]@{
        Code = [string][long][enum]::Parse($enumType, $_)
        Description = $_ -creplace "([a-z])([A-Z])",'$1 $2'
      }
    }
  }
  process {
    if(![string]::IsNullOrEmpty($code)) {
      $codes|?{$_.Code.IndexOf($Code) -eq 0 -or $_.Description.IndexOf($Code) -eq 0}
    } else {
      $codes
    }
  }
}
