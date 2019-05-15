

C_OBJECT:C1216($book)

Case of 
	: (Form event:C388=On Load:K2:1)
		
		$book:=ds:C1482.Book.query("title = :1";"20,000 Leagues Under the Sea").first()
		WP SET ATTRIBUTES:C1342(Form:C1466.bookFullText;wk text align:K81:49;wk justify:K81:100;\
			wk font size:K81:66;14)
		
		$firstSection:=WP Get section:C1581(Form:C1466.bookFullText;1)
		$rangeSection:=WP Create range:C1341($firstSection;wk start text:K81:165;wk end text:K81:164)
		
		
		  //$text:=Sous chaîne($book.fulltext;1;Ent(Longueur($book.fulltext)/10))
		$text:=$book.fulltext
		
		WP SET TEXT:C1574($rangeSection;$text;wk append:K81:179)
		
		
		
		
		$footer:=WP Get footer:C1504($firstSection)
		
		If ($footer=Null:C1517)
			$footer:=WP New footer:C1587($firstSection)
		End if 
		
		
		ST INSERT EXPRESSION:C1281($footer;"$wp_pageNumber";ST End text:K78:16;ST End text:K78:16)
		ST SET TEXT:C1115($footer;"/";ST End text:K78:16;ST End text:K78:16)
		ST INSERT EXPRESSION:C1281($footer;"$wp_pageCount";ST End text:K78:16;ST End text:K78:16)
		
		  //Form.bookFullText:=WP Import document(Get 4D folder(Database folder)+"fullText.4wp")
		
		
End case 