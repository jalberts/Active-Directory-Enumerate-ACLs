#Returns a CSV list of users and groups with permissions on a recursive folder search. Also lists inheritence.

$OutFile = [environment]::getfolderpath("mydocuments") + "\enum-ACL.csv"
$Header = "Folder Path;IdentityReference;AccessControlType;IsInherited;InheritanceFlags;PropagationFlags"
if (Test-Path $OutFile) {
	Remove-Item $OutFile
}

Add-Content -Value $Header -Path $OutFile 

$RootPath = "U:\HBHE\PRC"

$Folders = dir $RootPath -recurse | where {$_.psiscontainer -eq $true}

foreach ($Folder in $Folders){
	$ACLs = get-acl $Folder.fullname | ForEach-Object { $_.Access  }
	Foreach ($ACL in $ACLs){
	$OutInfo = $Folder.Fullname + ";" + $ACL.IdentityReference  + ";" + $ACL.AccessControlType + ";" + $ACL.IsInherited + ";" + $ACL.InheritanceFlags + ";" + $ACL.PropagationFlags
	Add-Content -Value $OutInfo -Path $OutFile
	}}