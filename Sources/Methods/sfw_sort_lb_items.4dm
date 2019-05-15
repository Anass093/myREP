//%attributes = {}
C_COLLECTION:C1488($sorts)

$sorts:=Form:C1466.currentTable.sorts

If ($sorts=Null:C1517)
	Form:C1466.lb_items:=Form:C1466.lb_items.orderBy(Form:C1466.currentTable.name)
	
Else 
	Form:C1466.lb_items:=Form:C1466.lb_items.orderBy($sorts)
	
End if 