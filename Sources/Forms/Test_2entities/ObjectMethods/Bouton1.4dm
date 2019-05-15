
Form:C1466.currentItem:=Form:C1466.currentItem+1
If (Form:C1466.currentItem=Form:C1466.entitySel.length)
	Form:C1466.currentItem:=0
End if 

Form:C1466.people1:=Form:C1466.entitySel[Form:C1466.currentItem]
$nextone:=Form:C1466.currentItem+1
If ($nextone=Form:C1466.entitySel.length)
	$nextone:=0
End if 
Form:C1466.people2:=Form:C1466.entitySel[$nextone]