//%attributes = {}
C_LONGINT:C283($1;$totalItem;\
$2;$currentPage;\
$3;$itemOnPage)

C_OBJECT:C1216($pagination)
C_LONGINT:C283($difference;$totalPages;$end)
C_TEXT:C284($attributQueryParams)
C_BOOLEAN:C305($differentFromPage)

$totalItem:=$1
$currentPage:=$2

If (Count parameters:C259>2)
	$itemOnPage:=$3
Else 
	$itemOnPage:=18
End if 


$pagination:=New object:C1471("visiblePages";8;\
"itemOnPage";$itemOnPage)

  // Calcul of total Pages
$totalPages:=Int:C8($totalItem/$pagination.itemOnPage)
If (Mod:C98($totalItem;$pagination.itemOnPage)#0)
	$totalPages:=$totalPages+1
End if 

If ($currentPage<1)
	$currentPage:=1
End if 

If ($currentPage>$totalPages)
	$currentPage:=$totalPages
End if 

$pagination.currentPage:=$currentPage
$pagination.totalPages:=$totalPages
$pagination.first:=1
$pagination.last:=$totalPages


  // Calcul start visible page
If ($pagination.currentPage>Int:C8($pagination.visiblePages/2))
	$start:=Int:C8($pagination.visiblePages/2)
	$start:=$pagination.currentPage-$start
Else 
	$start:=1
End if 


  // Calcul end visible page
$end:=$start+$pagination.visiblePages-1
If ($end>$pagination.totalPages)
	$difference:=$end-$pagination.totalPages
	$end:=$pagination.totalPages
	
	If ($start-$difference>0)
		$start:=$start-$difference
	End if 
	
End if 

$pagination.start:=$start
$pagination.end:=$end


  // Calcul number of Item
$pagination.startItem:=($currentPage-1)*$pagination.itemOnPage
$pagination.endItem:=$currentPage*$pagination.itemOnPage


  // Construction of the url used on the pagination file. 
$differentFromPage:=False:C215
$urlPagination:=routing_request.path4DParametre+"?"
If (Not:C34(OB Is empty:C1297(routing_request.queryParams)))
	
	For each ($attributQueryParams;routing_request.queryParams)
		If ($attributQueryParams#"page")
			$urlPagination:=$urlPagination+$attributQueryParams+"="+routing_request.queryParams[$attributQueryParams]
			$differentFromPage:=True:C214
		End if 
	End for each 
	
	If ($differentFromPage)
		$urlPagination:=$urlPagination+"&"
	End if 
End if 

$pagination.urlPagination:=$urlPagination

If ($pagination.totalPages>1)
	routing_request.htmlSections.pagination:=swfw_load_section ("pages/pagination.shtml")
End if 
routing_request.pagination:=$pagination