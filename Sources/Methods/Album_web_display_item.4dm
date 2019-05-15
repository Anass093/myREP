//%attributes = {}


  //4DRouting {"path" : "/albums/:UUID_album", "restrict" : true}

C_OBJECT:C1216($currentCart)

routing_request.album:=ds:C1482.Album.get(routing_request.pathParams.UUID_album).toObject("*, artists.author.firstName, artists.author.lastName")
routing_request.album.categories.names:=routing_request.album.categories.uuids.map("Category_web_get_itemByUUID")

Cart_web_display_currendCart 

  // Build Category menu
$categories:=Category_web_build_items ("";"Album")
routing_request.categoriesMenu:=$categories.categories
routing_request.htmlSections.categoriesHtml:=swfw_load_section ("pages/categories.shtml")


routing_request.mainTitle:=routing_request.album.title
routing_request.ItemsKindInSectionBody:="Album"
routing_request.htmlSections.body:=swfw_load_section ("pages/album.shtml")
WEB SEND FILE:C619("pages/container.shtml")