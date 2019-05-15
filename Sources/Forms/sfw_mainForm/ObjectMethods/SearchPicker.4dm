$evt:=Form event:C388
Case of 
	: ($evt=On Data Change:K2:15)
		$ptr_search:=OBJECT Get pointer:C1124(Object current:K67:2)
		Form:C1466.currentSearch:=$ptr_search->
		sfw_fill_lb_items 
		
	: ($evt=On Losing Focus:K2:8)
		$ptr_search:=OBJECT Get pointer:C1124(Object current:K67:2)
		Form:C1466.currentSearch:=$ptr_search->
		sfw_fill_lb_items 
		
End case 