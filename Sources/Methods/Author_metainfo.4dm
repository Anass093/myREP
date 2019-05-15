//%attributes = {}
C_OBJECT:C1216($0)

$0:=New object:C1471

$nbBooks:=This:C1470.writers.book.length
Case of 
	: ($nbBooks<=1)
		$fillColor:="#56A5BE"
	: ($nbBooks=2)
		$fillColor:="#5AAEC7"
	: ($nbBooks=3)
		$fillColor:="#5DB4CF"
	: ($nbBooks=4)
		$fillColor:="#61BBD6"
	: ($nbBooks=5)
		$fillColor:="#64C2DE"
	: ($nbBooks=6)
		$fillColor:="#68C8E5"
	: ($nbBooks=7)
		$fillColor:="#6BCFED"
	Else 
		$fillColor:="#73DFFF"
End case 

$0.fill:=$fillColor




  //$0.cell:=Créer objet("lb_items_col_1";Créer objet("fill";$fillColor))