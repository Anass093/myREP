//%attributes = {}
C_OBJECT:C1216($chrono;$book;$album)
C_COLLECTION:C1488($states;$bookColl;$albumColl)
C_LONGINT:C283($state)

Form:C1466.borrowing_items:=New collection:C1472
$bookColl:=Form:C1466.entity.items.book.toCollection("";dk with primary key:K85:6+dk with stamp:K85:28)
For each ($book;$bookColl)
	$book.kind:="Livre"
End for each 
Form:C1466.borrowing_items:=Form:C1466.borrowing_items.concat($bookColl)
$albumColl:=Form:C1466.entity.items.album.toCollection("";dk with primary key:K85:6+dk with stamp:K85:28)
For each ($album;$albumColl)
	$album.kind:="Album"
End for each 
Form:C1466.borrowing_items:=Form:C1466.borrowing_items.concat($albumColl)

Borrowing_cart_buildChrono 


OBJECT SET VISIBLE:C603(*;"bDisponible";(Form:C1466.entity.current_state=1) & (item_is_in_modification))
OBJECT SET VISIBLE:C603(*;"bRappel";Form:C1466.entity.current_state=7)
