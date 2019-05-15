//%attributes = {}
C_COLLECTION:C1488($columns)
C_OBJECT:C1216($column)
C_LONGINT:C283($colonne;$ligne;$width;$nb_automColumn;$reserved_width)
C_POINTER:C301($nil)

LISTBOX GET CELL POSITION:C971(*;"lb_tables";$colonne;$ligne)
$subForm:=OBJECT Get pointer:C1124(Object named:K67:5;"sf_panel")

If ($ligne=0)
	Form:C1466.currentTable:=Null:C1517
	Form:C1466.lb_items:=Null:C1517
	LISTBOX DELETE COLUMN:C830(*;"lb_items";1;100)  //100 is enought ! 
	OBJECT SET SUBFORM:C1138(*;"sf_panel";"sfw_sf_empty")
	OBJECT SET VISIBLE:C603(*;"lb_items";False:C215)
	
Else 
	If (Form:C1466.currentTable=Null:C1517)
		$theDataclassIsChanged:=True:C214
	Else 
		$theDataclassIsChanged:=Not:C34(Form:C1466.currentTable.dataclass=Form:C1466.lb_tables[$ligne-1].dataclass)
	End if 
	Form:C1466.currentTable:=Form:C1466.lb_tables[$ligne-1]
	If ($theDataclassIsChanged)
		$subForm->:=New object:C1471
		$subForm->UUID:=""
		Form:C1466.twinsMode:=Null:C1517
		sfw_resize_panels 
		LISTBOX DELETE COLUMN:C830(*;"lb_items";1;100)  //100 is enough ! 
		$columns:=Form:C1466.currentTable.lb.columns
		If ($columns=Null:C1517)
			LISTBOX INSERT COLUMN FORMULA:C970(*;"lb_items";100;"lb_items_col_0";"This."+Form:C1466.currentTable.name;Is text:K8:3;"lb_items_ent_0";$nil)
		Else 
			OBJECT GET COORDINATES:C663(*;"lb_items";$g;$h;$d;$b)
			$width:=$d-$g-LISTBOX Get property:C917(*;"lb_items";lk ver scrollbar width:K53:9)
			$i:=0
			$reserved_width:=$columns.sum("width")
			$width:=$width-$reserved_width
			$nb_automColumn:=$columns.countValues(Null:C1517;"width")
			For each ($column;$columns)
				LISTBOX INSERT COLUMN FORMULA:C970(*;"lb_items";100;\
					"lb_items_col_"+String:C10($i);\
					$column.field;\
					Is text:K8:3;\
					"lb_items_ent_"+String:C10($i);$nil)
				If ($column.width=Null:C1517)
					$width_column:=$width/$nb_automColumn
				Else 
					$width_column:=$column.width
				End if 
				LISTBOX SET COLUMN WIDTH:C833(*;"lb_items_col_"+String:C10($i);$width_column;0;1000)
				
				$i:=$i+1
			End for each 
		End if 
	End if 
	
	sfw_search_lb_items 
	sfw_sort_lb_items 
	
	If (Form:C1466.lb_items.length>0) & (Form:C1466.currentTable.panel#Null:C1517)
		LISTBOX SELECT ROW:C912(*;"lb_items";0;lk remove from selection:K53:3)
		sfw_display_item 
		
	Else 
		OBJECT SET SUBFORM:C1138(*;"sf_panel";"sfw_sf_empty")
		
	End if 
	OBJECT SET VISIBLE:C603(*;"lb_items";True:C214)
	
	If (Form:C1466.currentTable.countFormat#Null:C1517)
		OBJECT SET FORMAT:C236(*;"vCount";Form:C1466.currentTable.countFormat)
	Else 
		OBJECT SET FORMAT:C236(*;"vCount";"")
	End if 
	
End if 

sfw_displayBtn_modifyItem 