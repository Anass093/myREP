//%attributes = {}
C_OBJECT:C1216($e;$sel)
C_TEXT:C284($cp)

$chars:="abcdefghjkmnopqrstuvwxyz1234567890"

$sel:=ds:C1482.Book.all()

For each ($e;$sel)
	Repeat 
		$permalink:=""
		For ($i;1;6)
			$permalink:=$permalink+$chars[[(Random:C100%Length:C16($chars))+1]]
		End for 
	Until (Find in field:C653([Book:1]permalink:14;$permalink)<0)
	$e.permalink:=$permalink
	
	$e.save()
End for each 