sfw_formMethod_panel 


$evt:=Form event:C388
Case of 
	: ($evt=On Load:K2:1)
		$texte:=Document to text:C1236(Get 4D folder:C485(Current resources folder:K5:16)+"Data"+Folder separator:K24:12+"FrenchPostalCodes.json")
		Form:C1466.postalcodes:=JSON Parse:C1218($texte)
		
		$ptr_cp:=OBJECT Get pointer:C1124(Object named:K67:5;"_input_codepostal")
		$ptr_city:=OBJECT Get pointer:C1124(Object named:K67:5;"_input_city")
		$ptr_cp->:=Form:C1466.entity.address.address[0].detail.postcode
		$ptr_city->:=Form:C1466.entity.address.address[0].detail.city
		
End case 

$nomObjetFocus:=OBJECT Get name:C1087(Object with focus:K67:3)
$pupVisible:=item_is_in_modification
Case of 
	: ($nomObjetFocus="_input_codepostal")
	: ($nomObjetFocus="_input_city")
	Else 
		$pupVisible:=False:C215
End case 
OBJECT SET VISIBLE:C603(*;"bOtherCP";$pupVisible)

