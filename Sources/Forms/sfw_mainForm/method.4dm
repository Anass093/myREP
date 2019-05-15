$evt:=Form event:C388

Case of 
	: ($evt=On Load:K2:1)
		sfw_init_mainForm 
		
	: ($evt=On Resize:K2:27)
		sfw_resize_panels 
		
End case 

sfw_displayBtn_modifyItem 

