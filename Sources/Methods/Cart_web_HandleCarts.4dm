//%attributes = {}

  //4DRouting {"path" : "/carts", "restrict" : true}

C_OBJECT:C1216($item;$result)
C_TEXT:C284($svg_cart;$modalCurrentModalIn;$modalCurrentModalOut)
C_LONGINT:C283($bookSelected;$albumSelected)
C_TEXT:C284($uuid_BorrowingCart)

C_OBJECT:C1216($borrowingCart_entity;\
$borrowingItem_entity)

ARRAY TEXT:C222($_attr;0)
ARRAY TEXT:C222($_val;0)

Case of 
	: (routing_request.method="put")
		
		If (Cart_web_isOK_To_AddItem (routing_request.itemKind))  // routing_request.itemKind => "Book" OU "Albums"
			
			
			Case of 
				: (routing_request.itemKind="Book")
					
					  // Get the book by UUID.
					$item:=ds:C1482.Book.get(routing_request.UUID).toObject("*, publisher.name, owners.author.firstName, owners.author.lastName")
				: (routing_request.itemKind="Album")
					
					  // Get the book by UUID.
					$item:=ds:C1482.Album.get(routing_request.UUID).toObject("*, artists.author.firstName, artists.author.firstName")
			End case 
			
			$item.categories.names:=$item.categories.uuids.map("Category_web_get_itemByUUID")
			
			  // Set the book's kind.
			$item.kind:=routing_request.itemKind
			
			  // Add the book to the current cart.
			routing_session.carts.currentCart.push($item)
			
			$result:=Cart_web_build_currentCart 
			WEB SEND TEXT:C677(JSON Stringify:C1217($result))
		Else 
			
			APPEND TO ARRAY:C911($_attr;"X-STATUS")
			APPEND TO ARRAY:C911($_val;"201")
			
			WEB SET HTTP HEADER:C660($_attr;$_val)
			WEB SEND TEXT:C677(JSON Stringify:C1217(New object:C1471("message";"You cannot add this Item to the cart.")))
			
		End if 
		
		
	: (routing_request.method="post")
		
		If (routing_session.carts.currentCart.length=0)
			APPEND TO ARRAY:C911($_attr;"X-STATUS")
			APPEND TO ARRAY:C911($_val;"201")
			
			WEB SET HTTP HEADER:C660($_attr;$_val)
			WEB SEND TEXT:C677(JSON Stringify:C1217(New object:C1471("message";"Your cart is empty.")))
		Else 
			
			$uuid_BorrowingCart:=Generate UUID:C1066
			
			$borrowingCart_entity:=ds:C1482.Borrowing_cart.new()
			$borrowingCart_entity.UUID:=$uuid_BorrowingCart
			$borrowingCart_entity.UUID_Citizen:=routing_session.user.UUID
			$borrowingCart_entity.current_state:=1
			$borrowingCart_entity.save()
			
			For each ($item;routing_session.carts.currentCart)
				$borrowingItem_entity:=ds:C1482.Borrowing_Item.new()
				$borrowingItem_entity.UUID_Citizen:=routing_session.user.UUID
				$borrowingItem_entity.UUID_Borrowing_cart:=$uuid_BorrowingCart
				
				Case of 
					: ($item.kind="Book")
						$borrowingItem_entity.UUID_Book:=$item.UUID
					: ($item.kind="Album")
						$borrowingItem_entity.UUID_Album:=$item.UUID
				End case 
				
				$borrowingItem_entity.save()
			End for each 
			
			routing_session.carts.currentCart.clear()
			$result:=Cart_web_build_currentCart 
			WEB SEND TEXT:C677(JSON Stringify:C1217($result))
			
		End if 
		
		
	: (routing_request.method="get")
		$result:=Cart_web_display_validatedCarts 
		WEB SEND TEXT:C677(JSON Stringify:C1217($result))
		
End case 


