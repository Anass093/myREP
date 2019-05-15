//%attributes = {}
C_OBJECT:C1216($1;$request;\
$objectPath;$objectDefaultPath;$storagePathParams)

C_TEXT:C284($2;$defaultPath;\
$result;\
$pathToMethod;\
$itemPathParams)

C_COLLECTION:C1488($_col_pathToMethod;$_col_pathParams)

$request:=$1
If (Count parameters:C259>1)
	$defaultPath:=$2
Else 
	$defaultPath:=""
End if 


  // Get the object from 'Storage.Router' which contains the handler request (method)
$objectPath:=Storage:C1525.Router.find("swfw_findHandlerRequest";$request.path4DParametre)

If (OB Is defined:C1231($objectPath;"method"))
	
	
	If (Position:C15(":";$objectPath.path)>0)  // If the path contains a parametres.
		
		  // ["books", ":ABCDEFGH12345678"] path recieved from the client.
		$_col_pathParams:=Split string:C1554($request.path4DParametre;"/";sk ignore empty strings:K86:1+sk trim spaces:K86:2)
		
		For each ($itemPathParams;$objectPath.pathParams)  // {"uuid_book", 1} added by routing_load_router
			
			If (Not:C34(OB Is defined:C1231($request;"pathParams")))
				$request.pathParams:=New object:C1471
			End if 
			$request.pathParams[$itemPathParams]:=$_col_pathParams[$objectPath.pathParams[$itemPathParams]]
			  //$request.pathParams["uuid_book"]:=$_col_pathParams[$objectPath.pathParams["uuid_book"]]
		End for each 
		
	End if 
	
	  // Execute the handler request.
	EXECUTE METHOD:C1007($objectPath.method;$result;$request)
Else 
	
	  // Execute the default path if there is no method to handle the request.
	$objectDefaultPath:=Storage:C1525.Router.find("swfw_findHandlerRequest";$defaultPath)
	If ($objectDefaultPath=Null:C1517)
		ASSERT:C1129(False:C215;"There is no method mapped to this path "+$defaultPath)
	Else 
		WEB SEND HTTP REDIRECT:C659($defaultPath)
	End if 
	
End if 