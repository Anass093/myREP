C_OBJECT:C1216($result)

$subForm:=OBJECT Get pointer:C1124(Object named:K67:5;"sf_panel")
$subForm->UUID:=""
If ($subForm->locked)
	$result:=$subForm->entity.unlock()
	$subForm->locked:=False:C215
End if 
$subForm->entity:=$subForm->entity.reload()
sfw_display_item 