//%attributes = {"executedOnServer":true}
C_LONGINT:C283($i;$j)
C_TEXT:C284($body;$category)
C_BLOB:C604($response)
C_PICTURE:C286($pict)

C_COLLECTION:C1488($_categories)

ARRAY TEXT:C222($_documentAlbums;0)
ARRAY OBJECT:C1221($_albumsObj;0)

ARRAY TEXT:C222($_headerAttr;0)
ARRAY TEXT:C222($_headerVal;0)

$albumsFolder:=Get 4D folder:C485(Database folder:K5:14)+"albums"+Folder separator:K24:12

DOCUMENT LIST:C474($albumsFolder;$_documentAlbums)


For ($i;1;Size of array:C274($_documentAlbums);1)
	If (Test path name:C476($albumsFolder+$_documentAlbums{$i})=Is a document:K24:1)
		
		$textDoc:=Document to text:C1236($albumsFolder+$_documentAlbums{$i};UTF8 text without length:K22:17)
		JSON PARSE ARRAY:C1219($textDoc;$_albumsObj)
		
		For ($j;1;Size of array:C274($_albumsObj);1)
			
			QUERY:C277([Album:7];[Album:7]title:2=$_albumsObj{$j}.title)
			If (Records in selection:C76([Album:7])=0)
				
				$uuid:=Generate UUID:C1066
				CREATE RECORD:C68([Album:7])
				[Album:7]UUID:1:=$uuid
				[Album:7]label:3:=$_albumsObj{$j}.label
				[Album:7]publishedDate:4:=Date:C102($_albumsObj{$j}.date_sortie)
				[Album:7]title:2:=$_albumsObj{$j}.title
				
				  // Images.
				[Album:7]images:5:=New object:C1471("smallThumbnail";New object:C1471;\
					"thumbnail";New object:C1471)
				
				If (True:C214)
					$statusImg:=0
					$repeat:=0
					
					Repeat 
						ON ERR CALL:C155("_errCall")
						HTTP SET OPTION:C1160(HTTP timeout:K71:10;300)
						$statusImg:=HTTP Request:C1158(HTTP GET method:K71:1;$_albumsObj{$j}.pic_url;$body;$response;$_headerAttr;$_headerVal)
						ON ERR CALL:C155("")
						$repeat:=$repeat+1
						If ($statusImg#200)
							DELAY PROCESS:C323(Current process:C322;2)
						End if 
					Until ($statusImg=200) | ($repeat=10)
					
					
					
					If ($statusImg=200)
						BLOB TO PICTURE:C682($response;$pict)
						$uuid_img:=Generate UUID:C1066
						CREATE RECORD:C68([Image:12])
						[Image:12]UUID:1:=$uuid_img
						[Image:12]thumbnail:2:=$pict
						[Image:12]source:3:=$_albumsObj{$j}.pic_url
						SAVE RECORD:C53([Image:12])
						
						[Album:7]images:5.thumbnail.link:=$_albumsObj{$j}.pic_url
						[Album:7]images:5.thumbnail.record:=$uuid_img
					End if 
				End if 
				
				If (True:C214)
					CLEAR VARIABLE:C89($body)
					CLEAR VARIABLE:C89($response)
					CLEAR VARIABLE:C89($_headerAttr)
					CLEAR VARIABLE:C89($_headerVal)
					CLEAR VARIABLE:C89($pict)
					
					$statusImg:=0
					$repeat:=0
					
					Repeat 
						ON ERR CALL:C155("_errCall")
						HTTP SET OPTION:C1160(HTTP timeout:K71:10;300)
						$statusImg:=HTTP Request:C1158(HTTP GET method:K71:1;$_albumsObj{$j}.minipic_url;$body;$response;$_headerAttr;$_headerVal)
						ON ERR CALL:C155("")
						$repeat:=$repeat+1
						If ($statusImg#200)
							DELAY PROCESS:C323(Current process:C322;2)
						End if 
					Until ($statusImg=200) | ($repeat=10)
					
					If ($statusImg=200)
						BLOB TO PICTURE:C682($response;$pict)
						$uuid_img:=Generate UUID:C1066
						CREATE RECORD:C68([Image:12])
						[Image:12]UUID:1:=$uuid_img
						[Image:12]thumbnail:2:=$pict
						[Image:12]source:3:=$_albumsObj{$j}.minipic_url
						SAVE RECORD:C53([Image:12])
						
						[Album:7]images:5.smallThumbnail.link:=$_albumsObj{$j}.minipic_url
						[Album:7]images:5.smallThumbnail.record:=$uuid_img
					End if 
				End if 
				
				
				  // Author
				QUERY:C277([Author:2];[Author:2]lastName:3=$_albumsObj{$j}.author)
				If (Records in selection:C76([Author:2])=0)
					$uuid_author:=Generate UUID:C1066
					CREATE RECORD:C68([Author:2])
					[Author:2]UUID:1:=$uuid_author
					[Author:2]lastName:3:=$_albumsObj{$j}.author
					SAVE RECORD:C53([Author:2])
				Else 
					$uuid_author:=[Author:2]UUID:1
				End if 
				CREATE RECORD:C68([Artist:9])
				[Artist:9]UUID_Album:3:=$uuid
				[Artist:9]UUID_Author:2:=$uuid_author
				SAVE RECORD:C53([Artist:9])
				
				$_categories:=Split string:C1554($_albumsObj{$j}.category;",";sk ignore empty strings:K86:1+sk trim spaces:K86:2)
				[Album:7]categories:6:=New object:C1471("uuids";New collection:C1472)
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
						
						[Album:7]categories:6.uuids.push($uuid_category)
					End for each 
				End if 
				
				
				SAVE RECORD:C53([Album:7])
			End if 
			
		End for 
		
	End if 
	
	
End for 
zzzzzMAJ_Donnees_Author 
ALERT:C41("fin")
