C_OBJECT:C1216($dynfr)
OBJECT GET SUBFORM:C1139(*;"Sousformulaire";$tablePtr;$detailSubform)
$dynfr:=FORM Convert to dynamic:C1570($detailSubform)
$txtall:=JSON Stringify:C1217($dynfr)
TEXT TO DOCUMENT:C1237(Get 4D folder:C485(Current resources folder:K5:16)+"reslt.json";$txtall)
vrn2:=$txtall