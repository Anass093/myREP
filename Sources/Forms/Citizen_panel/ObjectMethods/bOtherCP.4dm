C_COLLECTION:C1488($communes;$cps)

$ptr_cp:=OBJECT Get pointer:C1124(Object named:K67:5;"_input_codepostal")
$ptr_city:=OBJECT Get pointer:C1124(Object named:K67:5;"_input_city")
Case of 
	: (OBJECT Get name:C1087(Object with focus:K67:3)="_input_codepostal")
		
		$cp:=$ptr_cp->
		$communes:=Form:C1466.postalcodes[$cp]
		If ($communes#Null:C1517)
			$communes:=$communes.orderBy()
			
			$menu:=Create menu:C408
			For each ($commune;$communes)
				APPEND MENU ITEM:C411($menu;$commune)
				SET MENU ITEM PARAMETER:C1004($menu;-1;$commune)
				If ($commune=$ptr_city->)
					SET MENU ITEM MARK:C208($menu;-1;Char:C90(18))
				End if 
			End for each 
			
			$choix:=Dynamic pop up menu:C1006($menu)
			
			RELEASE MENU:C978($menu)
			
			Case of 
				: ($choix#"")
					$ptr_city->:=$choix
					Form:C1466.entity.address.address[0].detail.city:=$ptr_city->
				Else 
					
			End case 
		End if 
		
		
	: (OBJECT Get name:C1087(Object with focus:K67:3)="_input_city")
		
		$commune:=Uppercase:C13($ptr_city->)
		$cps:=Form:C1466.postalcodes[$commune]
		If ($cps#Null:C1517)
			$cps:=$cps.orderBy()
			
			$menu:=Create menu:C408
			For each ($cp;$cps)
				APPEND MENU ITEM:C411($menu;$cp)
				SET MENU ITEM PARAMETER:C1004($menu;-1;$cp)
				If ($cp=$ptr_cp->)
					SET MENU ITEM MARK:C208($menu;-1;Char:C90(18))
				End if 
			End for each 
			
			$choix:=Dynamic pop up menu:C1006($menu)
			
			RELEASE MENU:C978($menu)
			
			Case of 
				: ($choix#"")
					$ptr_cp->:=$choix
					Form:C1466.entity.address.address[0].detail.postcode:=$ptr_cp->
				Else 
					
			End case 
		End if 
End case 
