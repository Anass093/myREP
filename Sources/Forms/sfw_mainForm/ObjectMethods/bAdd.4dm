
C_OBJECT:C1216($formula;$newEntity)
C_LONGINT:C283($position)

$formula:=Form:C1466.currentTable.callback.add

If ($formula=Null:C1517)
	$rep:=Request:C163("Entrez le nom du nouvel "+Form:C1466.currentTable.label+" :";Form:C1466.currentTable.label)
	If (ok=1)
		  //todo ...
	End if 
Else 
	
	$newEntity:=$formula.call()
	If ($newEntity#Null:C1517)
		Form:C1466.lb_items.add($newEntity)
		sfw_sort_lb_items 
		
		$position:=$newEntity.indexOf(Form:C1466.lb_items)
		LISTBOX SELECT ROW:C912(*;"lb_items";$position+1;lk replace selection:K53:1)
		OBJECT SET SCROLL POSITION:C906(*;"lb_items";$position+1)
		sfw_display_item 
		
	End if 
End if 