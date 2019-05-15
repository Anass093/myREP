//%attributes = {}


  //4DRouting {"path" : "/books", "restrict" : true}

C_LONGINT:C283($page)
C_OBJECT:C1216($booksEntitySelection;$currentCart;$categories)

  // Test if there is a query param 'page', if not we fix it to the first page.
If (OB Is defined:C1231(routing_request.queryParams;"page"))
	$page:=Num:C11(routing_request.queryParams.page)
Else 
	$page:=1
End if 

  // Filter items by search
If (OB Is defined:C1231(routing_request.queryParams;"search"))
	$booksEntitySelection:=ds:C1482.Book.query("title = :1 or owners.author.firstName = :1 or owners.author.lastName = :1";"@"+routing_request.queryParams.search+"@")
	routing_request.mainTitle:="Search : <b>"+routing_request.queryParams.search+"</b></br>"+String:C10($booksEntitySelection.length)+" Results."
Else 
	$booksEntitySelection:=ds:C1482.Book.all()
	routing_request.mainTitle:="All books"
End if 

  // Get a collection of items by pagination
$totalItem:=$booksEntitySelection.length
swfw_pagination_build ($totalItem;$page)
$booksEntitySelection:=$booksEntitySelection.slice(routing_request.pagination.startItem;routing_request.pagination.endItem)
routing_request._books:=$booksEntitySelection.toCollection("UUID, title, images, owners.author.firstName, owners.author.lastName")

  // Build the current cart to fixe it on modal to be showen.
Cart_web_display_currendCart 


  // Build Categoru menu
$categories:=Category_web_build_items ("";"Book")
routing_request.categoriesMenu:=$categories.categories
routing_request.htmlSections.categoriesHtml:=swfw_load_section ("pages/categories.shtml")

routing_request.ItemsKindInSectionBody:="Book"
routing_request.htmlSections.body:=swfw_load_section ("pages/books.shtml")
WEB SEND FILE:C619("pages/container.shtml")