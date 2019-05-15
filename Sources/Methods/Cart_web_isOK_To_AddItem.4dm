//%attributes = {}

C_TEXT:C284($1;$itemKind)
C_BOOLEAN:C305($0;$addItem)

C_LONGINT:C283($totalItemInCurrentCart;\
$totalItem;\
$totalItemIprogress)


$itemKind:=$1
$addItem:=False:C215

Case of 
	: ($itemKind="Book")
		
		$totalItemInCurrentCart:=routing_session.carts.currentCart.query("kind = :1";"Book").length
		$totalItemIprogress:=ds:C1482.Borrowing_cart.query("UUID_Citizen = :1 AND current_state # :2";routing_session.user.UUID;6).items.toCollection("book.UUID").filter("Cart_web_filter_empty_obj").length
		
		$totalItem:=$totalItemIprogress+$totalItemInCurrentCart
		
		If ($totalItem<Storage:C1525.settings.numberMaxBooks)
			$addItem:=True:C214
		End if 
		
	: ($itemKind="Album")
		
		$totalItemInCurrentCart:=routing_session.carts.currentCart.query("kind = :1";"Album").length
		$totalItemIprogress:=ds:C1482.Borrowing_cart.query("UUID_Citizen = :1 AND current_state # :2";routing_session.user.UUID;6).items.toCollection("album.UUID").filter("Cart_web_filter_empty_obj").length
		
		$totalItem:=$totalItemInCurrentCart+$totalItemIprogress
		
		If ($totalItem<Storage:C1525.settings.numberMaxAlbums)
			$addItem:=True:C214
		End if 
		
End case 


$0:=$addItem