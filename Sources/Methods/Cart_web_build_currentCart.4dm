//%attributes = {}

C_LONGINT:C283($bookSelected;$totalBooksSelected;$booksCartsInProgress;\
$albumSelected)
C_TEXT:C284($svg_cart;$modalCurrentModalIn;$modalCurrentModalOut)
C_OBJECT:C1216($0)

$bookSelected:=routing_session.carts.currentCart.query("kind = :1";"Book").length
$albumSelected:=routing_session.carts.currentCart.query("kind = :1";"Album").length


$svg_cart:=Cart_web_drawPict_ProgressCarts ($bookSelected;$albumSelected)


$modalCurrentModalIn:=swfw_load_section ("pages/itemsCart.shtml")
PROCESS 4D TAGS:C816($modalCurrentModalIn;$modalCurrentModalOut)


$0:=New object:C1471("currentCartModal";$modalCurrentModalOut;\
"svgCurrentCart";$svg_cart)
