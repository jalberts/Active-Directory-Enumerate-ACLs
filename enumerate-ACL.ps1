#Returns a CSV list of users and groups with permissions on a recursive folder search. Also lists inheritence.

$OutFile = "C:\users\jra\documents\prc-permissions.csv"
$Header = "Folder Path;IdentityReference;AccessControlType;IsInherited;InheritanceFlags;PropagationFlags"
Del $OutFile
Add-Content -Value $Header -Path $OutFile 

$RootPath = "u:\hbhe\prc\"

$Folders = dir $RootPath -recurse | where {$_.psiscontainer -eq $true}

foreach ($Folder in $Folders){
	$ACLs = get-acl $Folder.fullname | ForEach-Object { $_.Access  }
	Foreach ($ACL in $ACLs){
	$OutInfo = $Folder.Fullname + ";" + $ACL.IdentityReference  + ";" + $ACL.AccessControlType + ";" + $ACL.IsInherited + ";" + $ACL.InheritanceFlags + ";" + $ACL.PropagationFlags
	Add-Content -Value $OutInfo -Path $OutFile
	}}