//%attributes = {}

C_OBJECT:C1216($e;$sel)
C_TEXT:C284($cp)

$sel:=ds:C1482.Citizen.all()

$domaines:=New collection:C1472("orange.fr";"gmail.com";"free.fr";"hotmail.com";"sfr.fr";"yahoo.fr";"yahoo.com";"cegetel.fr";"laposte.net")


For each ($e;$sel)
	  //$cp:=$e.address.address[0].detail.postcode
	  //$e.address.address[0].detail.postcode:=Chaîne($cp)
	  //$e.address.address[0].detail.city:=Majusc($e.address.address[0].detail.city)
	$domaine:=$domaines[Random:C100%$domaines.length]
	$cas:=Random:C100%3
	Case of 
		: ($cas=0)
			$mail:=$e.firstName+$e.lastName+"@"+$domaine
		: ($cas=1)
			$mail:=$e.firstName+"."+$e.lastName+"@"+$domaine
		: ($cas=2)
			$mail:=$e.lastName+"."+$e.firstName+"@"+$domaine
		: ($cas=3)
			$mail:=Substring:C12($e.firstName;1;1)+"."+$e.lastName+"@"+$domaine
	End case 
	$mail:=Replace string:C233($mail;" ";"")
	$e.email_login:=Lowercase:C14($mail)
	$e.save()
End for each 