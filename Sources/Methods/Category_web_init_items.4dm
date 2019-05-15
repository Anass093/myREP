//%attributes = {}
C_COLLECTION:C1488($_categories;$_AlbumsCategories;$_BooksCategories)
C_OBJECT:C1216($category;$categoryShared)

$_categories:=ds:C1482.Category.all().toCollection("UUID, name")
$_AlbumsCategories:=$_categories.filter("Category_web_filter_items";"Album")
$_BooksCategories:=$_categories.filter("Category_web_filter_items";"Book")


Use (Storage:C1525)
	Storage:C1525.categoriesBook:=New shared collection:C1527
	Storage:C1525.categoriesAlbum:=New shared collection:C1527
End use 


Use (Storage:C1525.categoriesAlbum)
	For each ($category;$_AlbumsCategories)
		
		$categoryShared:=New shared object:C1526("UUID";$category.UUID;\
			"name";$category.name)
		
		Storage:C1525.categoriesAlbum.push($categoryShared)
	End for each 
End use 


Use (Storage:C1525.categoriesBook)
	For each ($category;$_BooksCategories)
		
		$categoryShared:=New shared object:C1526("UUID";$category.UUID;\
			"name";$category.name)
		
		Storage:C1525.categoriesBook.push($categoryShared)
	End for each 
End use 