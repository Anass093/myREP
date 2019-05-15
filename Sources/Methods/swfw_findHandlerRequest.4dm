//%attributes = {}

C_OBJECT:C1216($1)
C_TEXT:C284($path;$2)
C_LONGINT:C283($i)

C_COLLECTION:C1488($_col_pathParams;$_col_storagePathParams)


$path:=$2  // The path of the request

$1.result:=True:C214

If (Position:C15(":";$1.value.path)>0)  // If the path contains ':' => contains a pathParam '/Books/:uuid_book'
	
	  //["Books", ":AAFLSKDF6121321G"]
	$_col_pathParams:=Split string:C1554($path;"/";sk ignore empty strings:K86:1+sk trim spaces:K86:2)
	
	  //["Books", ":uuid_book"]
	$_col_storagePathParams:=Split string:C1554($1.value.path;"/";sk ignore empty strings:K86:1+sk trim spaces:K86:2)
	
	
	
	If ($_col_pathParams.length=$_col_storagePathParams.length)
		For ($i;0;$_col_pathParams.length-1;1)
			
			If (Position:C15(":";$_col_storagePathParams[$i])=0) & ($_col_storagePathParams[$i]#$_col_pathParams[$i])
				$1.result:=False:C215
				$i:=$_col_pathParams.length
			End if 
			
		End for 
	Else 
		$1.result:=False:C215
	End if 
	
Else 
	$1.result:=$1.value.path=$2
End if 