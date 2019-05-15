//%attributes = {}

C_LONGINT:C283($1;$bookSelected;\
$2;$albumSelected;\
$totalBooksValidated;\
$totalBooks;\
$totalAlbumsValidated;\
$totalAlbums)

C_TEXT:C284($0)


  // Current Cart item selected.
$bookSelected:=$1
$albumSelected:=$2


  //#4D ne prend  pas les doublons, alors que moi je veux le nombre de livre, => je suis obligé de passer par la collection !
  //$cartsEntitySelection:=ds.Borrowing_cart.query("UUID_Citizen = :1 AND current_state # :2";routing_session.user.UUID;6).items.book
$totalBooksValidated:=ds:C1482.Borrowing_cart.query("UUID_Citizen = :1 AND current_state # :2";routing_session.user.UUID;6).items.toCollection("book.UUID").filter("Cart_web_filter_empty_obj").length
$totalBooks:=$totalBooksValidated+$bookSelected


$totalAlbumsValidated:=ds:C1482.Borrowing_cart.query("UUID_Citizen = :1 AND current_state # :2";routing_session.user.UUID;6).items.toCollection("album.UUID").filter("Cart_web_filter_empty_obj").length
$totalAlbums:=$totalAlbumsValidated+$albumSelected


$cercle1:=New object:C1471("TotalItemBook";Storage:C1525.settings.numberMaxBooks;\
"ItemSelected";$totalBooks;\
"ColorItemSelected";"rgb(200,200,200)")

$cercle2:=New object:C1471("TotalItemAlbum";Storage:C1525.settings.numberMaxAlbums;\
"ItemSelected";$totalAlbums;\
"ColorItemSelected";"rgb(190,190,190)")

$cercle3:=New object:C1471("TotalItem";4;\
"ItemSelected";4;\
"ColorItemSelected";"#F8F8F8")

$obj:=New object:C1471(\
"Cercle1";$cercle1;\
"Cercle2";$cercle2;\
"Cercle3";$cercle3)

$0:=Cart_web_drawSVGPict ($obj)