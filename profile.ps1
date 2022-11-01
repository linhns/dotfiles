Import-Module -Name Terminal-Icons
Import-Module PSReadLine
Set-PSReadLineOption -PredictionSource History
$ENV:STARSHIP_CONFIG = "C:\Users\linhn\dotfiles\starship.toml"
Invoke-Expression (&starship init powershell)