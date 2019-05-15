//%attributes = {}
C_LONGINT:C283($1)

If (Count parameters:C259=0)
	
	If (Shift down:C543)
		$processRef:=New process:C317(Current method name:C684;0;"mainForm"+String:C10(Random:C100);1)
	Else 
		$processRef:=New process:C317(Current method name:C684;0;"mainForm";1;*)
	End if 
	BRING TO FRONT:C326($processRef)
	
Else 
	
	SET MENU BAR:C67("mainMenuBar")
	$windowRef:=Open form window:C675("sfw_mainForm";Plain form window:K39:10)
	DIALOG:C40("sfw_mainForm")
	CLOSE WINDOW:C154($windowRef)
	
End if 