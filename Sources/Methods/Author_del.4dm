//%attributes = {}
C_BOOLEAN:C305($0)

$fullName:=Form:C1466.lb_items[Form:C1466.positionEntity-1].firstName+" "+Form:C1466.lb_items[Form:C1466.positionEntity-1].lastName
CONFIRM:C162("Voullez-vous réellement supprimer l'élément \""+$fullName+"\" ?";"Supprimer";"Conserver")

If (ok=1)
	
	$0:=True:C214
	
End if 