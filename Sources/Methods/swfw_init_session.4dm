//%attributes = {}
  // Init the session if the object doesn't existe.
If (Not:C34(OB Is defined:C1231(routing_session)))
	routing_session:=New object:C1471
End if 