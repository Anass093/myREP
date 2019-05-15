//%attributes = {}

  //4DRouting {"path" : "/categories", "restrict" : true}

C_TEXT:C284($categoriesInput;$categoriesOutput)
C_OBJECT:C1216($_categories)



If (OB Is defined:C1231(routing_request.queryParams;"categoriesToSearch"))
	$_categories:=Category_web_build_items (routing_request.queryParams.categoriesToSearch;routing_request.itemKind)
Else 
	$_categories:=Category_web_build_items ("";routing_request.itemKind)
End if 

routing_request.ItemsKindInSectionBody:=routing_request.queryParams.itemKind

routing_request.categoriesMenu:=$_categories.categories
$categoriesInput:=swfw_load_section ("pages/categories.shtml")
PROCESS 4D TAGS:C816($categoriesInput;$categoriesOutput)

WEB SEND TEXT:C677(JSON Stringify:C1217(New object:C1471("categories";$categoriesOutput)))