C_OBJECT:C1216($form;$result)
C_LONGINT:C283($position)

$ref_menu:=Create menu:C408

APPEND MENU ITEM:C411($ref_menu;"Passer en visulisation")
SET MENU ITEM PARAMETER:C1004($ref_menu;-1;"--visu")
If (Not:C34(item_is_in_modification))
	DISABLE MENU ITEM:C150($ref_menu;-1)
End if 

If (item_is_in_modification)
	$titre:="Recharger les valeurs"
Else 
	$titre:="Passer en modification"
End if 
APPEND MENU ITEM:C411($ref_menu;$titre)
SET MENU ITEM PARAMETER:C1004($ref_menu;-1;"--modif")

APPEND MENU ITEM:C411($ref_menu;"-")

APPEND MENU ITEM:C411($ref_menu;"Ouvrir dans une nouvelle fenêtre")
SET MENU ITEM PARAMETER:C1004($ref_menu;-1;"--newWindow")

APPEND MENU ITEM:C411($ref_menu;"-")

If (Form:C1466.twinsMode=Null:C1517)
	APPEND MENU ITEM:C411($ref_menu;"Garder pour dédoublannage ...")
	SET MENU ITEM PARAMETER:C1004($ref_menu;-1;"--startTwins")
Else 
	APPEND MENU ITEM:C411($ref_menu;"Arrêter le dédoublonnage ...")
	SET MENU ITEM PARAMETER:C1004($ref_menu;-1;"--stopTwins")
End if 
$choix:=Dynamic pop up menu:C1006($ref_menu)
RELEASE MENU:C978($ref_menu)

$subForm:=OBJECT Get pointer:C1124(Object named:K67:5;"sf_panel")
Case of 
	: ($choix="--visu")
		item_is_in_modification:=False:C215
		$subForm->UUID:=""
		GOTO OBJECT:C206(*;"")
		$result:=$subForm->entity.unlock()
		$subForm->locked:=False:C215
		sfw_resize_panels 
		sfw_display_item 
		
	: ($choix="--modif")
		item_is_in_modification:=True:C214
		$subForm->UUID:=""
		sfw_resize_panels 
		sfw_display_item 
		
	: ($choix="--newWindow")
		$form:=New object:C1471
		$form.UUID:=$subForm->UUID
		$form.currentTable:=Form:C1466.currentTable
		$ref_window:=Open form window:C675("sfw_secondaryForm")
		DIALOG:C40("sfw_secondaryForm";$form;*)
		
		
	: ($choix="--startTwins")
		Form:C1466.twinsMode:=New object:C1471
		$subForm:=OBJECT Get pointer:C1124(Object named:K67:5;"sf_panel_twin")
		If ($subForm->=Null:C1517)
			$subForm->:=New object:C1471
		End if 
		$subForm->UUID:=""
		sfw_resize_panels 
		sfw_display_item 
		
	: ($choix="--stopTwins")
		Form:C1466.twinsMode:=Null:C1517
		$subForm:=OBJECT Get pointer:C1124(Object named:K67:5;"sf_panel_twin")
		$subForm->:=Null:C1517
		sfw_resize_panels 
		$subForm:=OBJECT Get pointer:C1124(Object named:K67:5;"sf_panel")
		$position:=$subForm->entity.indexOf(Form:C1466.lb_items)
		LISTBOX SELECT ROW:C912(*;"lb_items";$position+1;lk replace selection:K53:1)
		OBJECT SET SCROLL POSITION:C906(*;"lb_items";$position+1)
End case 


