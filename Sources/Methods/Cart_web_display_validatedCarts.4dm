//%attributes = {}

C_TEXT:C284($cartsInput;$cartsOutput)
C_OBJECT:C1216($cartsEntitySelection;$0)

$cartsEntitySelection:=ds:C1482.Borrowing_cart.query("UUID_Citizen = :1 AND current_state # :2";routing_session.user.UUID;6)  // non rendu
routing_request.cartsInProgress:=$cartsEntitySelection.toCollection("current_state, items.book.title, items.album.title")

  // #4D Attendre l'implementation des settings pour recuperer le label des statuts
routing_request.cartsInProgress.map("Cart_web_get_status_label")

$cartsInput:=swfw_load_section ("pages/cartsOfUser.shtml")
PROCESS 4D TAGS:C816($cartsInput;$cartsOutput)

$0:=New object:C1471("cartsInProgress";$cartsOutput)

