//%attributes = {"executedOnServer":true}

C_TEXT:C284($body)
C_BLOB:C604($response)
C_PICTURE:C286($pict)

ARRAY TEXT:C222($_headerAttr;0)
ARRAY TEXT:C222($_headerVal;0)

ARRAY TEXT:C222($_documentBooks;0)
C_LONGINT:C283($i)
C_TEXT:C284($booksFolder;\
$author;$category)

C_OBJECT:C1216($objBooks;\
$item)

C_COLLECTION:C1488($_Col_industryIdentifiers;\
$_categories;$_authors)

$booksFolder:=Get 4D folder:C485(Database folder:K5:14)+"books"+Folder separator:K24:12

DOCUMENT LIST:C474($booksFolder;$_documentBooks)


For ($i;1;Size of array:C274($_documentBooks);1)
	If (Test path name:C476($booksFolder+$_documentBooks{$i})=Is a document:K24:1)
		
		$textDoc:=Document to text:C1236($booksFolder+$_documentBooks{$i};UTF8 text without length:K22:17)
		$objBooks:=JSON Parse:C1218($textDoc)
		
		If ($objBooks.totalItems>0)
			If (OB Is defined:C1231($objBooks;"items"))
				For each ($item;$objBooks.items)
					
					If ($item.volumeInfo.readingModes.image)
						If (OB Is defined:C1231($item.volumeInfo;"authors"))
							If (OB Is defined:C1231($item.volumeInfo;"industryIdentifiers"))
								If (OB Is defined:C1231($item.volumeInfo;"publisher"))
									$_Col_industryIdentifiers:=$item.volumeInfo.industryIdentifiers.query("type = :1";"ISBN_13")
									If ($_Col_industryIdentifiers#Null:C1517) & ($_Col_industryIdentifiers.length>0)
										
										QUERY:C277([Book:1];[Book:1]ISBN13:7=$_Col_industryIdentifiers[0].identifier)
										If (Records in selection:C76([Book:1])=0)
											$uuid_book:=Generate UUID:C1066
											
											CREATE RECORD:C68([Book:1])
											[Book:1]UUID:1:=$uuid_book
											[Book:1]title:2:=$item.volumeInfo.title
											
											QUERY:C277([Publisher:11];[Publisher:11]name:2=$item.volumeInfo.publisher)
											If (Records in selection:C76([Publisher:11])=0)
												$uuid_publisher:=Generate UUID:C1066
												CREATE RECORD:C68([Publisher:11])
												[Publisher:11]UUID:1:=$uuid_publisher
												[Publisher:11]name:2:=$item.volumeInfo.publisher
												SAVE RECORD:C53([Publisher:11])
											Else 
												$uuid_publisher:=[Publisher:11]UUID:1
											End if 
											
											[Book:1]UUID_Publisher:4:=$uuid_publisher
											[Book:1]description:5:=$item.volumeInfo.description
											[Book:1]publishedDate:6:=Date:C102($item.volumeInfo.publishedDate)
											[Book:1]ISBN13:7:=$_Col_industryIdentifiers[0].identifier
											[Book:1]language:9:=$item.volumeInfo.language
											[Book:1]pageCount:10:=Num:C11($item.volumeInfo.pageCount)
											
											
											  // IMAGES Start
											[Book:1]images:8:=New object:C1471("smallThumbnail";New object:C1471;\
												"thumbnail";New object:C1471)
											
											$statusImg:=HTTP Request:C1158(HTTP GET method:K71:1;$item.volumeInfo.imageLinks.smallThumbnail;$body;$response;$_headerAttr;$_headerVal)
											If ($statusImg=200)
												BLOB TO PICTURE:C682($response;$pict)
												$uuid_img:=Generate UUID:C1066
												CREATE RECORD:C68([Image:12])
												[Image:12]UUID:1:=$uuid_img
												[Image:12]thumbnail:2:=$pict
												[Image:12]source:3:=$item.volumeInfo.imageLinks.smallThumbnail
												SAVE RECORD:C53([Image:12])
												
												[Book:1]images:8.smallThumbnail.link:=$item.volumeInfo.imageLinks.smallThumbnail
												[Book:1]images:8.smallThumbnail.record:=$uuid_img
											End if 
											
											CLEAR VARIABLE:C89($response)
											CLEAR VARIABLE:C89($pict)
											CLEAR VARIABLE:C89($_headerAttr)
											CLEAR VARIABLE:C89($_headerVal)
											
											$statusImg:=HTTP Request:C1158(HTTP GET method:K71:1;$item.volumeInfo.imageLinks.thumbnail;$body;$response;$_headerAttr;$_headerVal)
											If ($statusImg=200)
												BLOB TO PICTURE:C682($response;$pict)
												$uuid_img:=Generate UUID:C1066
												CREATE RECORD:C68([Image:12])
												[Image:12]UUID:1:=$uuid_img
												[Image:12]thumbnail:2:=$pict
												[Image:12]source:3:=$item.volumeInfo.imageLinks.thumbnail
												SAVE RECORD:C53([Image:12])
												
												[Book:1]images:8.thumbnail.link:=$item.volumeInfo.imageLinks.thumbnail
												[Book:1]images:8.thumbnail.record:=$uuid_img
											End if 
											
											  // Categories, ça a revoir !!!!!
											$_categories:=$item.volumeInfo.categories
											[Book:1]categories:11:=New object:C1471("uuids";New collection:C1472)
											If ($_categories#Null:C1517)
												For each ($category;$_categories)
													QUERY:C277([Category:10];[Category:10]name:3=$category)
													If (Records in selection:C76([Category:10])=0)
														$uuid_category:=Generate UUID:C1066
														CREATE RECORD:C68([Category:10])
														[Category:10]UUID:1:=$uuid_category
														[Category:10]name:3:=$category
														SAVE RECORD:C53([Category:10])
													Else 
														$uuid_category:=[Category:10]UUID:1
													End if 
													
													[Book:1]categories:11.uuids.push($uuid_category)
												End for each 
											End if 
											
											
											
											  // authors
											$_authors:=$item.volumeInfo.authors
											If ($_authors#Null:C1517)
												$order:=1
												For each ($author;$_authors)
													QUERY:C277([Author:2];[Author:2]lastName:3=$author)
													If (Records in selection:C76([Author:2])=0)
														$uuid_author:=Generate UUID:C1066
														CREATE RECORD:C68([Author:2])
														[Author:2]UUID:1:=$uuid_author
														[Author:2]lastName:3:=$author
														SAVE RECORD:C53([Author:2])
													Else 
														$uuid_author:=[Author:2]UUID:1
													End if 
													
													CREATE RECORD:C68([Owner:8])
													[Owner:8]UUID_Book:3:=$uuid_book
													[Owner:8]UUID_Author:2:=$uuid_author
													[Owner:8]order:4:=$order
													SAVE RECORD:C53([Owner:8])
													
													$order:=$order+1
												End for each 
											End if 
											
											SAVE RECORD:C53([Book:1])
										End if 
									End if 
									
									$_Col_industryIdentifiers:=Null:C1517
								End if 
								
								
							End if 
						End if 
					End if 
				End for each 
			End if 
			
		End if 
		
	End if 
End for 
zzzzzMAJ_Donnees_Author 
ALERT:C41("fin")