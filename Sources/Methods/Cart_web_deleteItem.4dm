//%attributes = {}

  //4DRouting {"path" : "/carts/:UUID_Cart", "restrict" : true}


C_COLLECTION:C1488($_indices)
C_OBJECT:C1216($result)
Case of 
	: (routing_request.method="DELETE")
		
		  // #4D à voir : peut etre faire une query sur la collection d'objet et supprimer le 1er element trouvé.
		$_indices:=routing_session.carts.currentCart.indices("UUID = :1";routing_request.pathParams.UUID_Cart)
		If ($_indices.length>0)
			routing_session.carts.currentCart.remove($_indices[0])
		End if 
		
		
		$result:=Cart_web_build_currentCart 
		WEB SEND TEXT:C677(JSON Stringify:C1217($result))
		
End case 
