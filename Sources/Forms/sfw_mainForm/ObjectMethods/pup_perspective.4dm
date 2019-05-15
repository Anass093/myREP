$ptr_perspective:=OBJECT Get pointer:C1124(Object named:K67:5;"pup_perspective")
If (Form:C1466.currentPerspective.position#$ptr_perspective->)
	Form:C1466.currentPerspective.position:=$ptr_perspective->
	  //%W-533.3
	Form:C1466.currentPerspective.name:=$ptr_perspective->{$ptr_perspective->}
	  //%W+533.3
	sfw_fill_lb_tables 
End if 
