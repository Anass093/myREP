C_TEXT:C284($panel)

$evt:=Form event:C388
Case of 
	: ($evt=On Load:K2:1)
		$subForm:=OBJECT Get pointer:C1124(Object named:K67:5;"sf_panel")
		
		$panel:=Form:C1466.currentTable.panel
		OBJECT SET SUBFORM:C1138(*;"sf_panel";$panel)
		
		$subForm->:=New object:C1471
		$subForm->entity:=ds:C1482[Form:C1466.currentTable.dataclass].get(Form:C1466.UUID)
		$subForm->UUID:=$subForm->entity.UUID
		$subForm->locked:=False:C215
		
		
End case 
