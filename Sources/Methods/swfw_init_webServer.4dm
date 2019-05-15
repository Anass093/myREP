//%attributes = {}

  // #4D attendre l'implementation des settings pour recuperer ces valeurs de la base.
  // Mettre le code dans une methode.
  //*********************************

If (Application type:C494#4D Remote mode:K5:5)
	C_LONGINT:C283($fromSettings_totalBooks;$fromSettings_totalAlbums)
	$fromSettings_totalBooks:=10
	$fromSettings_totalAlbums:=15
	
	Use (Storage:C1525)
		
		Storage:C1525.settings:=New shared object:C1526("numberMaxBooks";$fromSettings_totalBooks;\
			"numberMaxAlbums";$fromSettings_totalAlbums)
		Storage:C1525.statusOfCart:=New shared object:C1526
	End use 
	
	
	Use (Storage:C1525.statusOfCart)
		Storage:C1525.statusOfCart["1"]:=New shared object:C1526("label";"In preparation";\
			"css";"primary")
		Storage:C1525.statusOfCart["2"]:=New shared object:C1526("label";"Available";\
			"css";"success")
		Storage:C1525.statusOfCart["3"]:=New shared object:C1526("label";"Taken Off";\
			"css";"light")
		Storage:C1525.statusOfCart["6"]:=New shared object:C1526("label";"Rendered";\
			"css";"info")
		Storage:C1525.statusOfCart["7"]:=New shared object:C1526("label";"Late";\
			"css";"danger")
	End use 
	
	Use (Storage:C1525)
		Storage:C1525.numberOfAllItems:=New shared object:C1526("Books";String:C10(ds:C1482.Book.all().length;"### ##0");\
			"Albums";String:C10(ds:C1482.Album.all().length;"### ##0"))
	End use 
	  // *********************************
	
	Category_web_init_items 
	swfw_load_router ("WebMethods")
	
End if 
