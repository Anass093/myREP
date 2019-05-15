C_TEXT:C284($1;$2;$3;$4;$5;$6)
C_OBJECT:C1216(routing_request)
C_BOOLEAN:C305($filtred)

swfw_init_session 
routing_request:=swfw_init_request ($1;$2;$3;$4;$5;$6)
$filtred:=swfw_filterRequestNotAuth (routing_request;"user";"/login")

If (Not:C34($filtred))
	swfw_dispatcher (routing_request;"/login")
End if 
routing_request:=Null:C1517