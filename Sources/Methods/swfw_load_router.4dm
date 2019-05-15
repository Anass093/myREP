//%attributes = {"executedOnServer":true}


C_TEXT:C284($1;$webFolder)
C_TEXT:C284($codeMethod;$attribute;$property;$line;$jsonInfoPathString)
C_LONGINT:C283($i;$n)

C_OBJECT:C1216($jsonInfoPath;\
$jsonInfoPathShared;\
$pathParams)

C_COLLECTION:C1488($_pathParams)
ARRAY TEXT:C222($_web_methods;0)

If (Count parameters:C259>0)
	$webFolder:=$1
Else 
	$webFolder:="WebMethods"
End if 


METHOD GET PATHS:C1163($webFolder;Path project method:K72:1;$_web_methods)

For ($i;1;Size of array:C274($_web_methods);1)
	METHOD GET CODE:C1190($_web_methods{$i};$codeMethod)
	$_linesMethod:=Split string:C1554($codeMethod;Char:C90(Carriage return:K15:38);sk ignore empty strings:K86:1+sk trim spaces:K86:2)
	
	For each ($line;$_linesMethod) Until ($line="@4DRouting@")
		
		If ($line="@4DRouting@")
			
			  // Get the tag which contains the info about the request handler.
			$jsonInfoPathString:=Replace string:C233($line;"//4DRouting";"")
			$jsonInfoPath:=JSON Parse:C1218($jsonInfoPathString)
			
			
			  // Put the method name in the object => {"path" : "", "restrict{optional}" : true/false, "method" : "Current method name"}
			$jsonInfoPath.method:=$_web_methods{$i}
			
			  // The 'Router' attribute have to be set if doesn't exist. This attribute is a 'shared' collection of tags set in the request handlers (Method web_@).
			If (Not:C34(OB Is defined:C1231(Storage:C1525;"Router")))
				Use (Storage:C1525)
					Storage:C1525.Router:=New shared collection:C1527
				End use 
			End if 
			
			  // This object is the same as $jsonInfoObject which contains info about the request handler.
			  //But this one is shared, because it will pushed in the 'shared' collection "Storage.Router". (!we CANNOT set a standart object/collection in a shared object/collection!)
			$jsonInfoPathShared:=New shared object:C1526
			
			  //This 'Shared' Object will contains path parametres (=> [myResource/:id_resource] id_resource is a path parametre)
			$pathParams:=New shared object:C1526
			
			
			For each ($attribute;$jsonInfoPath)
				
				If ($attribute="path")
					
					If (Position:C15(":";$jsonInfoPath[$attribute])>0)
						$_pathParams:=Split string:C1554($jsonInfoPath[$attribute];"/";sk ignore empty strings:K86:1+sk trim spaces:K86:2)
						
						For ($n;0;$_pathParams.length-1;1)
							
							If (Position:C15(":";$_pathParams[$n])>0)
								$property:=Replace string:C233($_pathParams[$n];":";"")
								Use ($pathParams)
									$pathParams[$property]:=$n  // A model of path parametres will be set in the Stroage.Router => {"id_resource" : 1}
								End use 
							End if 
							
						End for 
					End if 
				End if 
				
				  // copy all attributes from the standard object $jsonInfoPath to the shared object $jsonInfoPathShared.
				Use ($jsonInfoPathShared)
					$jsonInfoPathShared[$attribute]:=$jsonInfoPath[$attribute]
				End use 
				
			End for each 
			
			Use (Storage:C1525.Router)
				Storage:C1525.Router.push($jsonInfoPathShared)
			End use 
			
			
			If (Not:C34(OB Is empty:C1297($pathParams)))
				Use (Storage:C1525.Router[Storage:C1525.Router.length-1])  // Use the last shared object in Storage.Router '$jsonInfoPathShared'
					Storage:C1525.Router[Storage:C1525.Router.length-1].pathParams:=$pathParams  // add the model of path parametre to the last object in the Storage.Router.
				End use 
			End if 
			
		End if 
		
	End for each 
	
	
End for 