//%attributes = {}
$modif:=False:C215
$subForm:=OBJECT Get pointer:C1124(Object named:K67:5;"sf_panel")
If (item_is_in_modification)
	OBJECT SET TITLE:C194(*;"bModify";"Visualiser")
	If ($subForm->entity#Null:C1517)
		$modif:=$subForm->entity.touched()
	End if 
	OBJECT SET TITLE:C194(*;"bMode";"Mode modification")
Else 
	OBJECT SET TITLE:C194(*;"bModify";"Modifier")
	
End if 


OBJECT SET VISIBLE:C603(*;"bValidate";$modif)
OBJECT SET VISIBLE:C603(*;"bCancel";$modif)

$visible:=True:C214
$titre:=""
Case of 
	: (Form:C1466.currentTable=Null:C1517)
		$visible:=False:C215
	: ($subForm->entity=Null:C1517)
		$visible:=False:C215
	: (item_is_in_modification)
		$titre:="Mode modification"
	Else 
		$titre:="Mode visualisation"
End case 

OBJECT SET VISIBLE:C603(*;"bMode";$visible)
OBJECT SET TITLE:C194(*;"bMode";$titre)

