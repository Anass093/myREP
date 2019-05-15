//%attributes = {}
C_TEXT:C284($0)
C_LONGINT:C283($1)


Case of 
	: ($1=1)
		$0:="en préparation"
	: ($1=2)
		$0:="disponible"
	: ($1=3)
		$0:="retiré"
	: ($1=6)
		$0:="retourné"
	: ($1=7)
		$0:="en retard"
End case 
