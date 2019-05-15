//%attributes = {}

C_OBJECT:C1216($1)
C_TEXT:C284($2)

$1.result:=(ds:C1482[$2].query("categories.uuids[] = :1";$1.value.UUID).length>0)
