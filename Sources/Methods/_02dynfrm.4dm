//%attributes = {}
TRACE:C157
C_OBJECT:C1216($dynfr)
$dynfr:=FORM Convert to dynamic:C1570("sfw_mainForm")
$txtall:=JSON Stringify:C1217($dynfr)
TEXT TO DOCUMENT:C1237(Get 4D folder:C485(Current resources folder:K5:16)+"reslt.json";$txtall)

$txtret:=Document to text:C1236(Get 4D folder:C485(Current resources folder:K5:16)+"reslt.json")
$dynfr:=JSON Parse:C1218($txtret)
DIALOG:C40($dynfr)
