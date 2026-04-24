Invoke-Expression (&starship init powershell)

# ctrl+v でペースト（Windows Terminal が unbound にしてるため PSReadLine で処理）
Set-PSReadLineKeyHandler -Key Ctrl+v -Function Paste

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

# OCaml
& opam env | Out-String | Invoke-Expression
