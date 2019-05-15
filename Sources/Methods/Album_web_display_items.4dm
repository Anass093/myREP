//%attributes = {}


  //4DRouting {"path" : "/albums", "restrict" : true}



C_LONGINT:C283($page)
C_OBJECT:C1216($albumsEntitySelection;$currentCart;$categories)

  // Test if there is a query param 'page', if not we fix it to the first page.
If (OB Is defined:C1231(routing_request.queryParams;"page"))
	$page:=Num:C11(routing_request.queryParams.page)
Else 
	$page:=1
End if 

  // Filter items by search
If (OB Is defined:C1231(routing_request.queryParams;"search"))
	$albumsEntitySelection:=ds:C1482.Album.query("title = :1 or artists.author.firstName = :1 or artists.author.lastName = :1";"@"+routing_request.queryParams.search+"@")
	routing_request.mainTitle:="Search : <b>"+routing_request.queryParams.search+"</b></br>"+String:C10($albumsEntitySelection.length)+" Results."
Else 
	routing_request.mainTitle:="All albums"
	$albumsEntitySelection:=ds:C1482.Album.all()
End if 

  // Get a collection of items by pagination
$totalItem:=$albumsEntitySelection.length
swfw_pagination_build ($totalItem;$page;24)
$albumsEntitySelection:=$albumsEntitySelection.slice(routing_request.pagination.startItem;routing_request.pagination.endItem)
routing_request._albums:=$albumsEntitySelection.toCollection("UUID,title,images,artists.author.firstName,artists.author.lastName")

  // Build the current cart to fixe it on modal to be showen.
Cart_web_display_currendCart 


  // Build Categoru menu
$categories:=Category_web_build_items ("";"Album")
routing_request.categoriesMenu:=$categories.categories
routing_request.htmlSections.categoriesHtml:=swfw_load_section ("pages/categories.shtml")



routing_request.ItemsKindInSectionBody:="Album"
routing_request.htmlSections.body:=swfw_load_section ("pages/albums.shtml")
WEB SEND FILE:C619("pages/container.shtml")