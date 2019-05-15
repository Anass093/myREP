//%attributes = {}


C_OBJECT:C1216($1;$settings)
C_LONGINT:C283($angle1;$angle2;$angle3)

C_TEXT:C284($svgXML;$0)

$settings:=$1

$angle1:=$settings.Cercle1.ItemSelected*360/$settings.Cercle1.TotalItemBook
$angle2:=$settings.Cercle2.ItemSelected*360/$settings.Cercle2.TotalItemAlbum
$angle3:=$settings.Cercle3.ItemSelected*360/$settings.Cercle3.TotalItem

$refRoot:=SVG_New 
$refCercle1:=SVG_New_circle ($refRoot;60;60;60;"rgb(179, 179, 179)";"white";1)
$path:=SVG_New_arc ($refRoot;60;60;60;0;$angle1;"black";$settings.Cercle1.ColorItemSelected)

$refCercle2:=SVG_New_circle ($refRoot;60;60;45;"rgb(179, 179, 179)";"white";2)
$path:=SVG_New_arc ($refRoot;60;60;45;0;$angle2;"black";$settings.Cercle2.ColorItemSelected)

$refCercle3:=SVG_New_circle ($refRoot;60;60;30;"rgb(179, 179, 179)";"white";2)
$path:=SVG_New_arc ($refRoot;60;60;30;0;$angle3;"black";$settings.Cercle3.ColorItemSelected)

$refCercle4:=SVG_New_circle ($refRoot;60;60;15;"rgb(179, 179, 179)";"rgb(228, 228, 231)";2)

  //SVGTool_SHOW_IN_VIEWER ($refRoot)
$svgXML:=SVG_Export_to_XML ($refRoot)
SVG_CLEAR ($refRoot)


$0:=$svgXML