//%attributes = {}
C_TEXT:C284($1;$url;\
$2;$headerBody;\
$3;$IPadressClient;\
$4;$IPadressServer;\
$5;$userName;\
$6;$passWord)

C_OBJECT:C1216($0;$request)

C_COLLECTION:C1488($_pathAndQuery;\
$_queryParamTmp;\
$_parametresOfQuery;\
$_cookies)

C_OBJECT:C1216($queryParam)
C_TEXT:C284($item;$header_attr)
C_LONGINT:C283($i)

ARRAY TEXT:C222($_fieldArray;0)
ARRAY TEXT:C222($_valueArrayHeader;0)

ARRAY TEXT:C222($_nameArray;0)
ARRAY TEXT:C222($_valueArray;0)

$url:=$1
$headerBody:=$2
$IPadressClient:=$3
$IPadressServer:=$4
$userName:=$5
$passWord:=$6

$_pathAndQuery:=Split string:C1554($url;"?")

$queryParam:=New object:C1471

If ($_pathAndQuery.length>1)  // If there is 2 elements => path= /Resources?queryParam1=value1&queryParam2=value2.
	$_queryParamTmp:=Split string:C1554($_pathAndQuery[1];"&")
	
	For each ($item;$_queryParamTmp)
		$_parametresOfQuery:=Split string:C1554($item;"=")
		
		If ($_parametresOfQuery.length>1)
			$queryParam[$_parametresOfQuery[0]]:=$_parametresOfQuery[1]
		Else 
			$queryParam[$_parametresOfQuery[0]]:=""
		End if 
		
	End for each 
	
End if 

$request:=New object:C1471("path4DParametre";$_pathAndQuery[0];\
"headerBody4DParametre";$headerBody;\
"IPadresseClient4DParametre";$IPadressClient;\
"IPadressServer4DParametre";$IPadressServer;\
"userName4DParametre";$userName;\
"passWord4DParametre";$passWord;\
"queryParams";$queryParam)


  // Get all key,value from the body of request.
WEB GET VARIABLES:C683($_nameArray;$_valueArray)
For ($i;1;Size of array:C274($_nameArray);1)
	$request[$_nameArray{$i}]:=$_valueArray{$i}
End for 


  // Get all key,value from the header of request.
WEB GET HTTP HEADER:C697($_fieldArray;$_valueArrayHeader)
For ($i;1;Size of array:C274($_fieldArray);1)
	
	If ($_fieldArray{$i}="Cookie")
		$_cookies:=Split string:C1554($_valueArrayHeader{$i};"=")
		
		If (Not:C34(OB Is defined:C1231($request;"Cookie")))
			$request.Cookie:=New object:C1471
		End if 
		
		  // The cookie's name '4DSID', 
		  //it's start with a number (an attribute of an object cannot start with a number) so a '_' is added 
		$request.Cookie["_"+$_cookies[0]]:=$_cookies[1]
		
	Else 
		
		$header_attr:=Replace string:C233($_fieldArray{$i};"X-";"")  // 'X-METHOD' => METHOD
		$header_attr:=Lowercase:C14(Replace string:C233($header_attr;"-";"_"))
		
		$request[$header_attr]:=$_valueArrayHeader{$i}
	End if 
	
End for 

$request.htmlSections:=New object:C1471

$0:=$request