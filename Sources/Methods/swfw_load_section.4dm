//%attributes = {}
C_TEXT:C284($1;$sectionName;\
$0;$sectionHTML;$sectionHTML_out;\
$webPage_path)

C_BLOB:C604($blobDoc)

$sectionName:=$1

$sectionName:=Replace string:C233($sectionName;"/";Folder separator:K24:12)

$webPage_path:=Get 4D folder:C485(HTML Root folder:K5:20)+$sectionName
If (Test path name:C476($webPage_path)=Is a document:K24:1)
	DOCUMENT TO BLOB:C525($webPage_path;$blobDoc)
	$sectionHTML:=BLOB to text:C555($blobDoc;UTF8 text without length:K22:17)
Else 
	ASSERT:C1129(False:C215;"Page '"+$webPage_path+"' Not found")
End if 

$0:=$sectionHTML