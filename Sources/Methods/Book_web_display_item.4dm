//%attributes = {}


  //4DRouting {"path" : "/books/:UUID_book", "restrict" : true}

C_OBJECT:C1216($currentCart)

routing_request.book:=ds:C1482.Book.get(routing_request.pathParams.UUID_book).toObject("*, publisher.name, owners.author.firstName, owners.author.lastName")
routing_request.book.categories.names:=routing_request.book.categories.uuids.map("Category_web_get_itemByUUID")

Cart_web_display_currendCart 

  // Build Categoru menu
$categories:=Category_web_build_items ("";"Book")
routing_request.categoriesMenu:=$categories.categories
routing_request.htmlSections.categoriesHtml:=swfw_load_section ("pages/categories.shtml")


routing_request.mainTitle:=routing_request.book.title
routing_request.ItemsKindInSectionBody:="Book"
routing_request.htmlSections.body:=swfw_load_section ("pages/book.shtml")
WEB SEND FILE:C619("pages/container.shtml")