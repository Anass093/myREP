C_OBJECT:C1216($objet;$entity)

$objet:=Form:C1466.people.toObject()
OB REMOVE:C1226($objet;"UUID")

$entity:=ds:C1482.Citizen.new()
$entity.fromObject($objet)
$entity.save()


Form:C1466.people:=$entity

