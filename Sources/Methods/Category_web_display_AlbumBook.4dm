//%attributes = {}
  //4DRouting {"path" : "/categories/:UUID_category", "restrict" : true}


If (True:C214)
	
	C_LONGINT:C283($page)
	C_OBJECT:C1216($itemsEntitySelection)
	Case of 
		: (routing_request.method="get")
			
			  // Test if there is a query param 'page', if not we fix it to the first page.
			If (OB Is defined:C1231(routing_request.queryParams;"page"))
				$page:=Num:C11(routing_request.queryParams.page)
			Else 
				$page:=1
			End if 
			
			If (OB Is defined:C1231(routing_request.queryParams;"itemsKind"))
				
				If (routing_request.queryParams.itemsKind#"Album") & (routing_request.queryParams.itemsKind#"Book")
					routing_request.queryParams.itemsKind:="Book"
				End if 
				
			Else 
				routing_request.queryParams.itemsKind:="Book"
			End if 
			
			
			$itemsEntitySelection:=ds:C1482[routing_request.queryParams.itemsKind].query("categories.uuids[] = :1";routing_request.pathParams.UUID_category)
			
			$totalItem:=$itemsEntitySelection.length
			
			routing_request.mainTitle:="Category : <b>"+ds:C1482.Category.get(routing_request.pathParams.UUID_category).name+"</b>"
			Case of 
				: (routing_request.queryParams.itemsKind="Book")
					
					swfw_pagination_build ($totalItem;$page)
					$itemsEntitySelection:=$itemsEntitySelection.slice(routing_request.pagination.startItem;routing_request.pagination.endItem)
					
					
					routing_request._books:=$itemsEntitySelection.toCollection("UUID, title, images, owners.author.firstName, owners.author.lastName")
					routing_request.htmlSections.body:=swfw_load_section ("pages/books.shtml")
					
				: (routing_request.queryParams.itemsKind="Album")
					
					swfw_pagination_build ($totalItem;$page;24)
					$itemsEntitySelection:=$itemsEntitySelection.slice(routing_request.pagination.startItem;routing_request.pagination.endItem)
					
					
					routing_request._albums:=$itemsEntitySelection.toCollection("UUID, title, images, artists.author.firstName, artists.author.firstName")
					routing_request.htmlSections.body:=swfw_load_section ("pages/albums.shtml")
					
			End case 
			
			
			
			
			  //Build the current cart to fixe it on modal to be showen.
			Cart_web_display_currendCart 
			
			
			  // Build Categoru menu
			$categories:=Category_web_build_items ("";routing_request.queryParams.itemsKind)
			routing_request.categoriesMenu:=$categories.categories
			routing_request.htmlSections.categoriesHtml:=swfw_load_section ("pages/categories.shtml")
			
			routing_request.ItemsKindInSectionBody:=routing_request.queryParams.itemsKind
			WEB SEND FILE:C619("pages/container.shtml")
			
	End case 
	
	
	
	
Else 
	
	C_LONGINT:C283($page)
	C_OBJECT:C1216($itemsEntitySelection)
	Case of 
		: (routing_request.method="get")
			
			  // Test if there is a query param 'page', if not we fix it to the first page.
			If (OB Is defined:C1231(routing_request.queryParams;"page"))
				$page:=Num:C11(routing_request.queryParams.page)
			Else 
				$page:=1
			End if 
			
			
			$itemsEntitySelection:=ds:C1482.Book.query("categories.uuids[] = :1";routing_request.pathParams.UUID_category)
			
			  // Get a collection of items by pagination
			$totalItem:=$itemsEntitySelection.length
			swfw_pagination_build ($totalItem;$page)
			$itemsEntitySelection:=$itemsEntitySelection.slice(routing_request.pagination.startItem;routing_request.pagination.endItem)
			routing_request._books:=$itemsEntitySelection.toCollection("UUID,title,images,owners.author.name")
			
			  //Build the current cart to fixe it on modal to be showen.
			Cart_web_display_currendCart 
			
			
			  // Build Categoru menu
			$categories:=Category_web_build_items ("";"Book")
			routing_request.categoriesMenu:=$categories.categories
			routing_request.htmlSections.categoriesHtml:=swfw_load_section ("pages/categories.shtml")
			
			routing_request.ItemsKindInSectionBody:="Book"
			routing_request.htmlSections.body:=swfw_load_section ("pages/books.shtml")
			WEB SEND FILE:C619("pages/container.shtml")
			
	End case 
	
End if 