//%attributes = {}
C_COLLECTION:C1488($bookColl;$albumColl)
C_OBJECT:C1216($book;$album)

$ptr_cp:=OBJECT Get pointer:C1124(Object named:K67:5;"_input_codepostal")
$ptr_city:=OBJECT Get pointer:C1124(Object named:K67:5;"_input_city")
$ptr_cp->:=Form:C1466.entity.address.address[0].detail.postcode
$ptr_city->:=Form:C1466.entity.address.address[0].detail.city

Form:C1466.borrowing_items:=New collection:C1472
$bookColl:=Form:C1466.entity.carts.items.book.toCollection("";dk with primary key:K85:6+dk with stamp:K85:28)
For each ($book;$bookColl)
	$book.kind:="Livre"
End for each 
Form:C1466.borrowing_items:=Form:C1466.borrowing_items.concat($bookColl)
$albumColl:=Form:C1466.entity.carts.items.album.toCollection("";dk with primary key:K85:6+dk with stamp:K85:28)
For each ($album;$albumColl)
	$album.kind:="Album"
End for each 
Form:C1466.borrowing_items:=Form:C1466.borrowing_items.concat($albumColl)