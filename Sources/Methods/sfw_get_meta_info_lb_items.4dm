//%attributes = {}
C_OBJECT:C1216($0;$formula)



$formula:=Form:C1466.currentTable.callback.metainfo

If ($formula=Null:C1517)
	  //$0:=Créer objet
	  //$0.fill:="#56A5BE"
	
Else 
	$0:=$formula.call()
	
End if 
