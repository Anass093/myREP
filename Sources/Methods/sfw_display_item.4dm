//%attributes = {}
C_POINTER:C301($ptrTable)
C_TEXT:C284($panel)
C_OBJECT:C1216($result)

If (Form:C1466.twinsMode=Null:C1517)
	$subFormName:="sf_panel"
Else 
	$subFormName:="sf_panel_twin"
End if 
$subForm:=OBJECT Get pointer:C1124(Object named:K67:5;$subFormName)

If (Form:C1466.positionEntity=0)
	OBJECT SET SUBFORM:C1138(*;$subFormName;"sfw_sf_empty")
	$subForm->:=New object:C1471
	$subForm->UUID:=""
Else 
	$launchUpdate:=True:C214
	OBJECT GET SUBFORM:C1139(*;$subFormName;$ptrTable;$panel)
	If ($panel#Form:C1466.currentTable.panel)
		$panel:=Form:C1466.currentTable.panel
		OBJECT SET SUBFORM:C1138(*;$subFormName;$panel)
		$launchUpdate:=False:C215
	End if 
	
	
	If ($subForm->=Null:C1517)
		$subForm->:=New object:C1471
		$subForm->UUID:=""
	End if 
	If ($subForm->UUID#Form:C1466.lb_items[Form:C1466.positionEntity-1].UUID)
		$subForm->entity:=Form:C1466.lb_items[Form:C1466.positionEntity-1]
		$subForm->UUID:=$subForm->entity.UUID
		$subForm->currentTable:=Form:C1466.currentTable
		$subForm->changeItem:=True:C214
	End if 
	If (item_is_in_modification)
		$result:=$subForm->entity.lock(dk reload if stamp changed:K85:15)
		If ($result.success=False:C215)
			$subForm->locked:=False:C215
		Else 
			$subForm->locked:=True:C214
		End if 
	Else 
		$subForm->locked:=False:C215
	End if 
	OBJECT SET VISIBLE:C603(*;"bLock";Not:C34($subForm->locked) & item_is_in_modification)
	
	If ($launchUpdate)
		EXECUTE METHOD IN SUBFORM:C1085($subFormName;"sfw_update_inside_panel")
	End if 
End if 



