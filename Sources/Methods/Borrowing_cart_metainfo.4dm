//%attributes = {}
C_OBJECT:C1216($0)
C_TEXT:C284($fillColor;$strokeColor)

$0:=New object:C1471

$current_state:=This:C1470.current_state
Case of 
	: ($current_state=1)
		$fillColor:="#44FF44"
	: ($current_state=7)
		$fillColor:="#ff4444"
		$strokeColor:="#ffffff"
End case 

If ($fillColor#"")
	$0.fill:=$fillColor
End if 
If ($strokeColor#"")
	$0.stroke:=$strokeColor
End if 
