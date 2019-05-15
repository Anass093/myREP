C_OBJECT:C1216($entitySel;$book;$album)
C_COLLECTION:C1488($bookColl;$albumColl)

If (Form:C1466.cart=Null:C1517)
	$entitySel:=Form:C1466.entity.carts.items
Else 
	$entitySel:=Form:C1466.cart.items
End if 

Form:C1466.borrowing_items:=New collection:C1472
$bookColl:=$entitySel.book.toCollection("";dk with primary key:K85:6+dk with stamp:K85:28)
For each ($book;$bookColl)
	$book.kind:="Livre"
End for each 
Form:C1466.borrowing_items:=Form:C1466.borrowing_items.concat($bookColl)
$albumColl:=$entitySel.album.toCollection("";dk with primary key:K85:6+dk with stamp:K85:28)
For each ($album;$albumColl)
	$album.kind:="Album"
End for each 
Form:C1466.borrowing_items:=Form:C1466.borrowing_items.concat($albumColl)