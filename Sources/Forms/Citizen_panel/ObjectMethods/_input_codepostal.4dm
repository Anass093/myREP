C_POINTER:C301($ptr_cp)

$ptr_cp:=OBJECT Get pointer:C1124(Object named:K67:5;"_input_codepostal")
$ptr_city:=OBJECT Get pointer:C1124(Object named:K67:5;"_input_city")
$cp:=Substring:C12($ptr_cp->+("0"*5);1;5)
$ptr_cp->:=$cp
If (Form:C1466.postalcodes[$cp]#Null:C1517)
	$ptr_city->:=Form:C1466.postalcodes[$cp].orderBy()[0]
	Form:C1466.entity.address.address[0].detail.postcode:=$ptr_cp->
	Form:C1466.entity.address.address[0].detail.city:=$ptr_city->
	GOTO OBJECT:C206(*;"_input_codepostal")
End if 