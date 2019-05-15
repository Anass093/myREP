//%attributes = {}
$evt:=Form event:C388
Case of 
	: ($evt=On Load:K2:1)
		sfw_update_inside_panel 
		
	: ($evt=On Bound Variable Change:K2:52)
		
	: ($evt=On Data Change:K2:15)
		CALL SUBFORM CONTAINER:C1086(-1000)  //update buttons
		
End case 
