param($ScriptPath, $NewVersion)

$content = Get-Content $ScriptPath -Raw
$content = $content -replace '(?<=int Function GetModVersion\(\) global\s+)return \d+', "return $NewVersion"
$content | Set-Content $ScriptPath -NoNewline

Write-Host "Updated version to $NewVersion in $ScriptPath"