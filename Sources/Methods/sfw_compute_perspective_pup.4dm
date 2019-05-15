//%attributes = {}
C_COLLECTION:C1488($perspectives)
C_POINTER:C301($ptr_perspective)
C_TEXT:C284($perspective)


$ptr_perspective:=OBJECT Get pointer:C1124(Object named:K67:5;"pup_perspective")

  //%W-518.5
ARRAY TEXT:C222($ptr_perspective->;0)
  //%W+518.5

If (1=2)  /// old school style
	
	COLLECTION TO ARRAY:C1562(Form:C1466.tables;$ptr_perspective->;"perspective")
	
	If (Size of array:C274($ptr_perspective->)>2)
		SORT ARRAY:C229($ptr_perspective->)
		$perspective:=$ptr_perspective->{1}
		$i:=2
		While ($i<=Size of array:C274($ptr_perspective->))
			If ($ptr_perspective->{$i}=$perspective)
				DELETE FROM ARRAY:C228($ptr_perspective->;$i;1)
			Else 
				$perspective:=$ptr_perspective->{$i}
				$i:=$i+1
			End if 
		End while 
	End if 
	
Else   // v17 development style
	
	$perspectives:=Form:C1466.tables.distinct("perspective")  //ck diacritical non utile ici
	COLLECTION TO ARRAY:C1562($perspectives;$ptr_perspective->)
	
End if 


$ptr_perspective->:=1
Form:C1466.currentPerspective:=New object:C1471("position";1;"name";$ptr_perspective->{1})
