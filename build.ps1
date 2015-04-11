Add-Type -A 'System.IO.Compression.FileSystem';

$currentDirectory = Get-Location;
[IO.Directory]::SetCurrentDirectory($currentDirectory);

Remove-Item Build -recurse
New-Item Build -type directory

New-Item Build/VinkSyntaxTheme -type directory
Copy-Item VinkSyntax/* Build/VinkSyntaxTheme -recurse
[IO.Compression.ZipFile]::CreateFromDirectory('Build\VinkSyntaxTheme', 'Build\VinkSyntaxTheme.fdz');
Remove-Item Build/VinkSyntaxTheme -recurse

$hash = Get-FileHash Build/VinkSyntaxTheme.fdz -Algorithm MD5;
Write-Host 'VinkSyntaxTheme.fdz hash: ' $hash.Hash;
