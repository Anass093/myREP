//%attributes = {}

  //4DRouting {"path" : "/pictures/:UUID_picture", "restrict" : true}

  //C_TEXT($1;$uuidImg)
C_PICTURE:C286($img)
C_BLOB:C604($blobImg)

  //$uuidImg:=$1


$img:=ds:C1482.Image.get(routing_request.pathParams.UUID_picture).thumbnail
PICTURE TO BLOB:C692($img;$blobImg;"image/jpg")
WEB SEND BLOB:C654($blobImg;"image/jpg")