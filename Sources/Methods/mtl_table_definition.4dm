//%attributes = {}

C_OBJECT:C1216($table;$lb;$column;$callback;$sort;$search;$result;$schema)
C_COLLECTION:C1488($tables;$columns;$sorts;$searchs)
  //C_IMAGE($pict)

Use (Storage:C1525)
	Storage:C1525.tables:=New shared collection:C1527
	
	$tables:=Storage:C1525.tables
End use 


Use ($tables)
	
	  //----------------- BOOK --------------------
	$table:=New shared object:C1526
	$tables.push($table)
	Use ($table)
		$table.dataclass:="Book"
		$table.label:="Livre"
		$table.name:="title"
		$table.perspective:="Catalogue"
		$table.panel:="Book_panel"
		$table.countFormat:="### ### ##0 books;;"
		
		
		$callback:=New shared object:C1526
		$table.callback:=$callback
		$formula:=New formula:C1597(Author_load )
		$table.callback.load:=$formula
		
		  //LIRE FICHIER IMAGE(Dossier 4D(Dossier Resources courant)+"Images"+Séparateur dossier+"Tables"+Séparateur dossier+"books.png";$pict)
		  //$table.picto:=$pict
		
		
	End use 
	
	  //----------------- ALBUM --------------------
	$table:=New shared object:C1526
	$tables.push($table)
	Use ($table)
		$table.dataclass:="Album"
		$table.label:="Album"
		$table.name:="title"
		$table.perspective:="Catalogue"
		$table.panel:="Album_panel"
		
		$callback:=New shared object:C1526
		$table.callback:=$callback
		$formula:=New formula:C1597(Album_load )
		$table.callback.load:=$formula
		
	End use 
	
	  //----------------- AUTHOR --------------------
	$table:=New shared object:C1526
	$tables.push($table)
	Use ($table)
		$table.dataclass:="Author"
		$table.label:="Auteur"
		$table.name:="lastName"
		$table.perspective:="Catalogue"
		$table.panel:="Author_panel"
		
		$lb:=New shared object:C1526
		$columns:=New shared collection:C1527
		$table.lb:=$lb
		$table.lb.columns:=$columns
		$column:=New shared object:C1526("field";"This.firstName")
		$columns.push($column)
		$column:=New shared object:C1526("field";"This.lastName")
		$columns.push($column)
		
		$callback:=New shared object:C1526
		$table.callback:=$callback
		$formula:=New formula:C1597(Author_add )
		$table.callback.add:=$formula
		$formula:=New formula:C1597(Author_del )
		$table.callback.del:=$formula
		$formula:=New formula:C1597(Author_metainfo )
		$table.callback.metainfo:=$formula
		
		$sorts:=New shared collection:C1527
		$table.sorts:=$sorts
		$sort:=New shared object:C1526("propertyPath";"lastName";"descending";False:C215)
		$sorts.push($sort)
		$sort:=New shared object:C1526("propertyPath";"firstName";"descending";False:C215)
		$sorts.push($sort)
		
		$searchs:=New shared collection:C1527
		$table.searchs:=$searchs
		$search:=New shared object:C1526("field";"lastName")
		$searchs.push($search)
		$search:=New shared object:C1526("field";"firstName")
		$searchs.push($search)
		
	End use 
	
	  //----------------- CITIZEN --------------------
	$table:=New shared object:C1526
	$tables.push($table)
	Use ($table)
		$table.dataclass:="Citizen"
		$table.label:="Citoyens"
		$table.name:="lastName"
		$table.perspective:="Emprunts"
		$table.panel:="Citizen_panel"
		
		$lb:=New shared object:C1526
		$columns:=New shared collection:C1527
		$table.lb:=$lb
		$table.lb.columns:=$columns
		$column:=New shared object:C1526("field";"This.firstName")
		$columns.push($column)
		$column:=New shared object:C1526("field";"This.lastName")
		$columns.push($column)
		
		$callback:=New shared object:C1526
		$table.callback:=$callback
		$formula:=New formula:C1597(Citizen_load )
		$table.callback.load:=$formula
		
		
	End use 
	
	  //----------------- Borrower --------------------
	$table:=New shared object:C1526
	$tables.push($table)
	Use ($table)
		$table.dataclass:="Citizen"
		$table.label:="Emprunteurs"
		$table.name:="lastName"
		$table.perspective:="Emprunts"
		$table.panel:="Citizen_panel"
		
		$lb:=New shared object:C1526
		$columns:=New shared collection:C1527
		$table.lb:=$lb
		$table.lb.columns:=$columns
		$column:=New shared object:C1526("field";"This.firstName")
		$columns.push($column)
		$column:=New shared object:C1526("field";"This.lastName")
		$columns.push($column)
		
		$callback:=New shared object:C1526
		$table.callback:=$callback
		$formula:=New formula:C1597(Citizen_load )
		$table.callback.load:=$formula
		$formula:=New formula:C1597(Borrower_subset )
		$table.callback.searchSubset:=$formula
		
		$searchs:=New shared collection:C1527
		$table.searchs:=$searchs
		$search:=New shared object:C1526("field";"lastName")
		$searchs.push($search)
		$search:=New shared object:C1526("field";"firstName")
		$searchs.push($search)
		
	End use 
	
	  //----------------- Borrowing Cart --------------------
	
	$table:=New shared object:C1526
	$tables.push($table)
	Use ($table)
		$table.dataclass:="Borrowing_cart"
		$table.label:="Lots d'emprunt"
		$table.name:="number"
		$table.perspective:="Emprunts"
		$table.panel:="Borrowing_cart_panel"
		
		$lb:=New shared object:C1526
		$columns:=New shared collection:C1527
		$table.lb:=$lb
		$table.lb.columns:=$columns
		$column:=New shared object:C1526("field";"This.borrower.lastName")
		$columns.push($column)
		$column:=New shared object:C1526("field";"This.borrower.firstName")
		$columns.push($column)
		$column:=New shared object:C1526("field";"This.number";"width";40)
		$columns.push($column)
		
		$callback:=New shared object:C1526
		$table.callback:=$callback
		$formula:=New formula:C1597(Borrowing_cart_load )
		$table.callback.load:=$formula
		$formula:=New formula:C1597(Borrowing_cart_metainfo )
		$table.callback.metainfo:=$formula
		
		$searchs:=New shared collection:C1527
		$table.searchs:=$searchs
		$search:=New shared object:C1526("field";"number")
		$searchs.push($search)
		$search:=New shared object:C1526("field";"borrower.lastName")
		$searchs.push($search)
		$search:=New shared object:C1526("field";"borrower.firstName")
		$searchs.push($search)
		
	End use 
	
	  //passer $tables à la validation pour détecter les éventuelles erreurs de définition
	$text:=Document to text:C1236(Get 4D folder:C485(Current resources folder:K5:16)+"Schema"+Folder separator:K24:12+"sfw_tables_schema.json")
	$schema:=JSON Parse:C1218($text;*)  //* pour les informations complémentaires en cas d'erreur
	For each ($table;$tables)
		$result:=JSON Validate:C1456($table;$schema)
		If ($result.success=False:C215)
			TRACE:C157
		End if 
	End for each 
	
	
End use 