//%attributes = {}
READ WRITE:C146([Author:2])

QUERY:C277([Author:2];[Author:2]firstName:4="")

While (Not:C34(End selection:C36([Author:2])))
	$parties:=Split string:C1554([Author:2]lastName:3;" ")
	Case of 
		: ($parties.length=2)
			[Author:2]firstName:4:=$parties[0]
			[Author:2]lastName:3:=$parties[1]
			SAVE RECORD:C53([Author:2])
		: ($parties.length=3)
			Case of 
				: ($parties[1]="@.")
					[Author:2]firstName:4:=$parties[0]+" "+$parties[1]
					[Author:2]lastName:3:=$parties[2]
					SAVE RECORD:C53([Author:2])
					
				Else 
					[Author:2]firstName:4:=$parties[0]+" "+$parties[1]
					[Author:2]lastName:3:=$parties[2]
					SAVE RECORD:C53([Author:2])
					
			End case 
			
			
		Else 
			
	End case 
	
	NEXT RECORD:C51([Author:2])
End while 
