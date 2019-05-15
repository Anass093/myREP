//%attributes = {}

  //4DRouting {"path" : "/logout"}

routing_session:=Null:C1517
WEB CLOSE SESSION:C1208(WEB Get current session ID:C1162)
WEB SEND HTTP REDIRECT:C659("/login")