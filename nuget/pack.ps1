$root = (split-path -parent $MyInvocation.MyCommand.Definition) + '\..'

Write-Host "root: $root"

$version = [System.Reflection.Assembly]::LoadFile("$root\NetSerializer\bin\Debug\NetSerializer.dll").GetName().Version
$versionStr = "{0}.{1}.{2}" -f ($version.Major, $version.Minor, $version.Build)

Write-Host "Setting .nuspec version tag to $versionStr"

$content = (Get-Content $root\NuGet\Netserializer.nuspec) 
$content = $content -replace '\$version\$',$versionStr

$content | Out-File $root\nuget\Netserializer.compiled.nuspec

& $root\NuGet\NuGet.exe pack $root\nuget\Netserializer.compiled.nuspec