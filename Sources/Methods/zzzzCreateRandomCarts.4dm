//%attributes = {}
C_OBJECT:C1216($state_history)
C_LONGINT:C283($numberMaxBooks;$numberMaxAlbums)

$nbCarts:=Num:C11(Request:C163("Je dois créer combien de carts ? ";"100";"Créer";"Annuler"))
If (ok=1) & ($nbCarts>0)
	TRUNCATE TABLE:C1051([Borrowing_cart:6])
	TRUNCATE TABLE:C1051([Borrowing_Item:5])
	
	ARRAY INTEGER:C220($_statut;0)
	APPEND TO ARRAY:C911($_statut;1)  //en préparation
	APPEND TO ARRAY:C911($_statut;2)  //Disponible
	APPEND TO ARRAY:C911($_statut;3)  //Retité
	APPEND TO ARRAY:C911($_statut;6)  //Retourné
	APPEND TO ARRAY:C911($_statut;7)  //en retard
	$numberMaxBooks:=Storage:C1525.settings.numberMaxBooks
	$numberMaxAlbums:=Storage:C1525.settings.numberMaxAlbums
	
	ALL RECORDS:C47([Book:1])
	ORDER BY FORMULA:C300([Book:1];Random:C100)
	$book_order:=1
	ALL RECORDS:C47([Album:7])
	ORDER BY FORMULA:C300([Album:7];Random:C100)
	$album_order:=1
	
	$dateSuivant:=!00-00-00!
	
	$make_search:=0
	QUERY:C277([Citizen:4];[Citizen:4]lastName:3="Martin";*)
	QUERY:C277([Citizen:4];[Citizen:4]firstName:4="Eric")
	For ($c;1;$nbCarts)
		
		If ($dateSuivant#!00-00-00!)
			$dateCreation:=$dateSuivant
		Else 
			Case of 
				: ($make_search=0)
					$make_search:=1
					$dateCreation:=Current date:C33-200+(Random:C100%100)
					
				: ($make_search=1)
					$dateCreation:=Current date:C33-100+(Random:C100%100)
					$make_search:=2
					QUERY:C277([Citizen:4];[Citizen:4]lastName:3#"Martin";*)
					QUERY:C277([Citizen:4];[Citizen:4]firstName:4#"Eric")
					ORDER BY FORMULA:C300([Citizen:4];Random:C100)
					$citizen_order:=1
				Else 
					$dateCreation:=Current date:C33-100+(Random:C100%100)
					$citizen_order:=$citizen_order+1
					GOTO SELECTED RECORD:C245([Citizen:4];$citizen_order)
					$max_state:=(Random:C100%8)+1
			End case 
		End if 
		$dateSuivant:=!00-00-00!
		$state_history:=New object:C1471
		$state_history["1"]:=$dateCreation
		$current_state:=1
		$dateDispo:=$dateCreation+(Random:C100%3)
		If ($dateDispo<=Current date:C33)
			$state_history["2"]:=$dateDispo
			$current_state:=2
			$dateRetrait:=$dateDispo+(Random:C100%3)
			If ($dateRetrait<=Current date:C33)
				$state_history["3"]:=$dateRetrait
				$current_state:=3
				$dateRetour:=$dateRetrait+(Random:C100%50)
				$dateRetourTheorique:=$dateRetrait+30
				If ($dateRetour<=Current date:C33)
					$state_history["6"]:=$dateRetour
					$current_state:=6
					$dateSuivant:=$dateRetour
				Else 
					If ($dateRetourTheorique<Current date:C33)
						$state_history["7"]:=$dateRetourTheorique
						$current_state:=7
					End if 
				End if 
			End if 
		End if 
		
		CREATE RECORD:C68([Borrowing_cart:6])
		[Borrowing_cart:6]number:3:=0
		[Borrowing_cart:6]current_state:4:=$current_state
		[Borrowing_cart:6]state_history:5:=$state_history
		[Borrowing_cart:6]UUID_Citizen:2:=[Citizen:4]UUID:1
		SAVE RECORD:C53([Borrowing_cart:6])
		$borrowing_cart_uuid:=[Borrowing_cart:6]UUID:1
		
		Repeat 
			$nbBooks:=Random:C100%$numberMaxBooks
			$nbAlbums:=Random:C100%$numberMaxAlbums
		Until (($nbAlbums+$nbBooks)>0)
		
		$book_order:=1
		For ($i;1;$nbBooks;1)
			Repeat 
				GOTO SELECTED RECORD:C245([Book:1];$book_order)
				QUERY:C277([Borrowing_Item:5];[Borrowing_Item:5]UUID_Book:4=[Book:1]UUID:1)
				$dispo:=True:C214
				While (Not:C34(End selection:C36([Borrowing_Item:5])) & $dispo)
					RELATE ONE:C42([Borrowing_Item:5]UUID_Borrowing_cart:3)
					$dateDebut_emprunt:=[Borrowing_cart:6]state_history:5["1"]
					If ([Borrowing_cart:6]state_history:5["6"]=Null:C1517)
						$dateFin_Emprunt:=$dateDebut_emprunt+50
					Else 
						$dateFin_Emprunt:=[Borrowing_cart:6]state_history:5["6"]
					End if 
					If ($dateCreation>=$dateDebut_emprunt) & ($dateCreation<=$dateFin_Emprunt)
						$dispo:=False:C215
					End if 
					NEXT RECORD:C51([Borrowing_Item:5])
				End while 
				If (Not:C34($dispo))
					$book_order:=$book_order+1
				End if 
			Until ($dispo) | ($book_order>Records in table:C83([Book:1]))
			If ($dispo)
				CREATE RECORD:C68([Borrowing_Item:5])
				[Borrowing_Item:5]UUID_Book:4:=[Book:1]UUID:1
				[Borrowing_Item:5]UUID_Borrowing_cart:3:=$borrowing_cart_uuid
				[Borrowing_Item:5]UUID_Citizen:2:=[Citizen:4]UUID:1
				SAVE RECORD:C53([Borrowing_Item:5])
			End if 
			$book_order:=$book_order+1
			If ($book_order>Records in table:C83([Book:1]))
				$i:=$nbBooks+1
			End if 
		End for 
		
		$album_order:=1
		For ($i;1;$nbalbums;1)
			Repeat 
				GOTO SELECTED RECORD:C245([Album:7];$album_order)
				QUERY:C277([Borrowing_Item:5];[Borrowing_Item:5]UUID_Album:5=[Album:7]UUID:1)
				$dispo:=True:C214
				While (Not:C34(End selection:C36([Borrowing_Item:5])) & $dispo)
					RELATE ONE:C42([Borrowing_Item:5]UUID_Borrowing_cart:3)
					$dateDebut_emprunt:=[Borrowing_cart:6]state_history:5["1"]
					If ([Borrowing_cart:6]state_history:5["6"]=Null:C1517)
						$dateFin_Emprunt:=$dateDebut_emprunt+50
					Else 
						$dateFin_Emprunt:=[Borrowing_cart:6]state_history:5["6"]
					End if 
					If ($dateCreation>=$dateDebut_emprunt) & ($dateCreation<=$dateFin_Emprunt)
						$dispo:=False:C215
					End if 
					NEXT RECORD:C51([Borrowing_Item:5])
				End while 
				If (Not:C34($dispo))
					$album_order:=$album_order+1
				End if 
			Until ($dispo) | ($album_order>Records in table:C83([Album:7]))
			If ($dispo)
				CREATE RECORD:C68([Borrowing_Item:5])
				[Borrowing_Item:5]UUID_Album:5:=[Album:7]UUID:1
				[Borrowing_Item:5]UUID_Borrowing_cart:3:=$borrowing_cart_uuid
				[Borrowing_Item:5]UUID_Citizen:2:=[Citizen:4]UUID:1
				SAVE RECORD:C53([Borrowing_Item:5])
			End if 
			$album_order:=$album_order+1
			If ($album_order>Records in table:C83([Album:7]))
				$i:=$nbalbums+1
			End if 
		End for 
		
		
	End for 
	
	ALL RECORDS:C47([Borrowing_cart:6])
	$cart_number:=(Random:C100%1000)+1000
	ORDER BY ATTRIBUTE:C1407([Borrowing_cart:6];[Borrowing_cart:6]state_history:5;"1";>)
	
	While (Not:C34(End selection:C36([Borrowing_cart:6])))
		$cart_number:=$cart_number+1
		[Borrowing_cart:6]number:3:=$cart_number
		SAVE RECORD:C53([Borrowing_cart:6])
		NEXT RECORD:C51([Borrowing_cart:6])
	End while 
	
	
End if 
