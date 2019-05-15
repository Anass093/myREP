//%attributes = {}



  //4DRouting {"path" : "/login"}

C_OBJECT:C1216($1;$request)

C_OBJECT:C1216($users)
$request:=$1



If (OB Is defined:C1231(routing_session;"user"))
	
	WEB SEND HTTP REDIRECT:C659("/books")
	
Else 
	
	If (OB Is defined:C1231($request;"email") & OB Is defined:C1231($request;"password"))
		
		$users:=ds:C1482.Citizen.query("email_login = :1 & password = :2";$request.email;$request.password)
		
		If ($users.length>0)
			routing_session.user:=$users[0].toObject("UUID, firstName, lastName, civility")
			routing_session.carts:=New object:C1471
			routing_session.carts.currentCart:=New collection:C1472
			WEB SEND HTTP REDIRECT:C659("/books")
		Else 
			WEB SEND FILE:C619("pages/login.html")
		End if 
		
	Else 
		
		WEB SEND FILE:C619("pages/login.html")
	End if 
	
	
End if 