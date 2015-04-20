Add-Type -A 'System.IO.Compression.FileSystem';

$currentDirectory = Get-Location;
[IO.Directory]::SetCurrentDirectory($currentDirectory);

#Make Build Directory
Remove-Item Build -recurse
New-Item Build -type directory

#Create initial syntax theme fdz
New-Item Build/VinkSyntaxTheme -type directory
Copy-Item VinkSyntax/* Build/VinkSyntaxTheme -recurse
[IO.Compression.ZipFile]::CreateFromDirectory('Build\VinkSyntaxTheme', 'Build\VinkSyntaxTheme.fdz');

#Copy syntax theme so it will be deployed with other syntax themes
New-Item 'Build/VinkSyntaxTheme/$(BaseDir)/Settings/Themes/SyntaxThemes' -type directory
Move-Item Build/VinkSyntaxTheme.fdz 'Build/VinkSyntaxTheme/$(BaseDir)/Settings/Themes/SyntaxThemes/VinkSyntaxTheme.fdz'

#Recreate syntax theme fdz
[IO.Compression.ZipFile]::CreateFromDirectory('Build\VinkSyntaxTheme', 'Build\VinkSyntaxTheme.fdz');
Remove-Item Build/VinkSyntaxTheme -recurse

#Print hash for adding to appman.xml
$hash = Get-FileHash Build/VinkSyntaxTheme.fdz -Algorithm MD5;
Write-Host 'VinkSyntaxTheme.fdz hash: ' $hash.Hash;
