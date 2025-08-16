param($ScriptPath, $InfoXmlPath, $NewVersion, $NewFomodVersion)

$content = Get-Content $ScriptPath -Raw
$content = $content -replace '(?<=int Function GetModVersion\(\) global\s+)return \d+', "return $NewVersion"
$content | Set-Content $ScriptPath -NoNewline

Write-Host "Updated version to $NewVersion in $ScriptPath"


$content = Get-Content $InfoXmlPath -Raw
$content = $content -replace '(?<=<Version>).*?(?=</Version>)', "$NewFomodVersion"
$content | Set-Content $InfoXmlPath -NoNewline

Write-Host "Updated version to $NewFomodVersion in $InfoXmlPath"