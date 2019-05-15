C_OBJECT:C1216($formula)
C_LONGINT:C283($position)

C_BOOLEAN:C305($delete)

$formula:=Form:C1466.currentTable.callback.del

If ($formula=Null:C1517)
	$name:=Form:C1466.lb_items[Form:C1466.positionEntity-1][Form:C1466.currentTable.name]
	CONFIRM:C162("Voullez-vous réellement supprimer l'élément \""+$name+"\" ?";"Supprimer";"Conserver")
	$delete:=(ok=1)
	
Else 
	$delete:=$formula.call()
	
End if 

If ($delete)
	$subForm:=OBJECT Get pointer:C1124(Object named:K67:5;"sf_panel")
	Form:C1466.lb_items:=Form:C1466.lb_items.minus($subForm->entity)
	
	$subForm->entity.drop()  //drop in the table
	$subForm->entity:=Null:C1517  // remove from memory
	
	sfw_sort_lb_items 
	sfw_display_item 
	
End if 