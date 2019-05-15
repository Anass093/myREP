//%attributes = {}
C_OBJECT:C1216($1;$request;\
$objectPath;$objectDefaultPath)

C_TEXT:C284($2;$defaultPath;\
$3;$attributSession;\
$result)


C_BOOLEAN:C305($0;$access;\
$restrict)
$restrict:=False:C215  // By Default the request aren't restricted => not need authentication.

$request:=$1

If (Count parameters:C259>1)
	$attributSession:=$2
Else 
	$attributSession:=""
End if 

If (Count parameters:C259>2)
	$defaultPath:=$3
Else 
	$defaultPath:=""
End if 

  // Find the Object that contains the handler request (method).
$objectPath:=Storage:C1525.Router.find("swfw_findHandlerRequest";$request.path4DParametre)



If (OB Is defined:C1231($objectPath;"method") & OB Is defined:C1231($objectPath;"restrict"))
	
	  // Get the value of restrict True/False
	$restrict:=$objectPath.restrict
	
	  // If the request is filtred and there is no session, the request is redirected to the default path '$defaultPath'.
	If ($restrict) & Not:C34(OB Is defined:C1231(routing_session;$attributSession))
		
		  // Get the Object which contains the method to handle the default path.
		$objectDefaultPath:=Storage:C1525.Router.find("swfw_findHandlerRequest";$defaultPath)
		
		
		If ($objectDefaultPath=Null:C1517)
			
			  // If there is no method to handle the default path, => assert.
			ASSERT:C1129(False:C215;"There is no method mapped to this path "+$defaultPath)
		Else 
			WEB SEND HTTP REDIRECT:C659($defaultPath)
		End if 
		
	Else 
		$restrict:=False:C215
	End if 
	
End if 

$0:=$restrict