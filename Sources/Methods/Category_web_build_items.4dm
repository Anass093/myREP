//%attributes = {}

C_TEXT:C284($1;$categoryToSearch;\
$2;$itemKind)
C_OBJECT:C1216($0)

C_COLLECTION:C1488($_categories;$_categoriesBook;$_categoriesAlbum)

C_LONGINT:C283($maxShownWithSearch;$maxShownWithoutSearch;$numberCatToDisplay)

$maxShownWithSearch:=15
$maxShownWithoutSearch:=10

If (Count parameters:C259>0)
	$categoryToSearch:=$1
Else 
	$categoryToSearch:=""
End if 


If (Count parameters:C259>1)
	$itemKind:=$2
Else 
	$itemKind:="Book"
End if 


If ($categoryToSearch="")
	$_categories:=Storage:C1525["categories"+$itemKind].slice(0;$maxShownWithoutSearch)
Else 
	$_categories:=Storage:C1525["categories"+$itemKind].query("name = :1";"@"+$categoryToSearch+"@").slice(0;$maxShownWithSearch)
End if 


$0:=New object:C1471("categories";$_categories)