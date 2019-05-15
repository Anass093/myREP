C_LONGINT:C283($position)

$subForm:=OBJECT Get pointer:C1124(Object named:K67:5;"sf_panel")
$subForm->entity.save()

sfw_sort_lb_items 
$position:=$subForm->entity.indexOf(Form:C1466.lb_items)
LISTBOX SELECT ROW:C912(*;"lb_items";$position+1;lk replace selection:K53:1)
OBJECT SET SCROLL POSITION:C906(*;"lb_items";$position+1)


sfw_display_item 