param($dir_dep)

Get-ChildItem $dir_dep | Where-Object { $_.PSIsContainer -eq $false -and $_.Name -ne 'README.txt' } | Remove-Item -Force