//%attributes = {}
C_OBJECT:C1216($0;$newEntity;$form)

$form:=New object:C1471
$ref_windows:=Open form window:C675("Author_add";Sheet form window:K39:12)
DIALOG:C40("Author_add";$form)
CLOSE WINDOW:C154($ref_windows)

If (ok=1)
	
	$newEntity:=ds:C1482.Author.new()
	$newEntity.firstName:=$form.firstName
	$newEntity.lastName:=$form.lastName
	$newEntity.save()
	
	$0:=$newEntity
End if 
