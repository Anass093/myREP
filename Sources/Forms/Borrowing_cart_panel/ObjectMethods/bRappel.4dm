C_OBJECT:C1216($status;$server;$email)
C_TEXT:C284($monBody)


$server:=New object:C1471
$server.host:="smtp.gmail.com"  //Obligatoire
$server.port:=465
$server.user:="woroldtour2019@gmail.com"
$server.password:="20194Dworldtour"

$transporter:=:C1608($server)

$email:=New object:C1471
$email.subject:="mon premier e-mail "
$email.from:="woroldtour2019@gmail.com"
$email.to:="olivier.deschanels@4d.com;abdelhafid.elhour@4d.com"
$email.textBody:="Hello World"

$template:=Document to text:C1236("Montemplate.html")
PROCESS 4D TAGS:C816($template;$monBody;Form:C1466.entity)

$email.htmlBody:="<h1>Hello World</h1><h4>'Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...'</h4>"+\
" <p>There are many variations of passages of Lorem Ipsum available."\
+"The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.</p>"

$status:=$transporter.send($email)
If (Not:C34($status.success))
	ALERT:C41("Une erreur est survenue pendant l'envoi de l'e-mail : "+$status.message)
End if 

