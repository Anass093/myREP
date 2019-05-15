//%attributes = {}
C_DATE:C307($date)
Form:C1466.chrono:=New collection:C1472
$states:=New collection:C1472(1;2;3;6;7)
For each ($state;$states)
	$state_property:=String:C10($state)
	If (Form:C1466.entity.state_history[$state_property]#Null:C1517)
		$chrono:=New object:C1471
		$chrono.state:=Borrowing_cart_state ($state)
		$date:=Date:C102(Form:C1466.entity.state_history[$state_property])
		$chrono.date:=$date
		Form:C1466.chrono.push($chrono)
	End if 
End for each 
