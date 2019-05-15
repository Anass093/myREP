//%attributes = {}
C_COLLECTION:C1488($searchs)
C_OBJECT:C1216($search;$entitySel;$formula)


$searchValue:=Form:C1466.currentSearch
If ($searchValue=Null:C1517)
	$searchValue:=""
End if 

$formula:=Form:C1466.currentTable.callback.searchSubset
If ($formula#Null:C1517)
	$entitySel:=$formula.call()
Else 
	$entitySel:=ds:C1482[Form:C1466.currentTable.dataclass].all()
End if 

If ($searchValue#"")
	$searchs:=Form:C1466.currentTable.searchs
	If ($searchs=Null:C1517)
		$critera:=Form:C1466.currentTable.name+" = :1"  //anti-injection
	Else 
		If (1=2)
			$critera:=""
			For each ($search;$searchs)
				If ($critera#"")
					$critera:=$critera+" OR "
				End if 
				$critera:=$critera+$search.field+" = :1"
			End for each 
		Else 
			$critera:=$searchs.extract("field").join(" = :1 OR ")+" = :1"
		End if 
		
	End if 
	$searchValue:="@"+$searchValue+"@"
	Form:C1466.lb_items:=$entitySel.query($critera;$searchValue)
Else 
	Form:C1466.lb_items:=$entitySel
End if 