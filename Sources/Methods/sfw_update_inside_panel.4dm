//%attributes = {}
C_OBJECT:C1216($formula;$result)

If (Form:C1466.changeItem)
	Form:C1466.changeItem:=False:C215
	$formula:=Form:C1466.currentTable.callback.load
	If ($formula#Null:C1517)
		$result:=$formula.call()
	End if 
End if 



FORM GET OBJECTS:C898($_widget)
For ($w;1;Size of array:C274($_widget);1)
	If ($_widget{$w}="@_input_@")
		If (item_is_in_modification) & (Form:C1466.locked)
			OBJECT SET RGB COLORS:C628(*;$_widget{$w};Foreground color:K23:1;Light shadow color:K23:4)
			OBJECT SET BORDER STYLE:C1262(*;$_widget{$w};Border System:K42:33)
			OBJECT SET ENTERABLE:C238(*;$_widget{$w};True:C214)
			
		Else 
			OBJECT SET RGB COLORS:C628(*;$_widget{$w};Foreground color:K23:1;Background color none:K23:10)
			OBJECT SET BORDER STYLE:C1262(*;$_widget{$w};Border None:K42:27)
			OBJECT SET ENTERABLE:C238(*;$_widget{$w};False:C215)
			
		End if 
	End if 
End for 