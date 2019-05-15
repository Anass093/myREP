C_POINTER:C301($ptr_cp)

$ptr_cp:=OBJECT Get pointer:C1124(Object named:K67:5;"_input_codepostal")
$ptr_city:=OBJECT Get pointer:C1124(Object named:K67:5;"_input_city")
$city:=Uppercase:C13($ptr_city->)
$ptr_city->:=$city
If (Form:C1466.postalcodes[$city]#Null:C1517)
	$ptr_cp->:=Form:C1466.postalcodes[$city].orderBy()[0]
	Form:C1466.entity.address.address[0].detail.postcode:=$ptr_cp->
	Form:C1466.entity.address.address[0].detail.city:=$ptr_city->
	GOTO OBJECT:C206(*;"_input_city")
End if 