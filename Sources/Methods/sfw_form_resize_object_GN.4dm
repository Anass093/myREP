//%attributes = {}

C_TEXT:C284($1;$reference_object)
C_TEXT:C284(${2};$form_object)  //following object

C_LONGINT:C283($form_width;$form_height;$width_instruction;$height_instruction)

$reference_object:=$1

OBJECT GET SUBFORM CONTAINER SIZE:C1148($form_width;$form_height)

ARRAY LONGINT:C221($_m;0)
$gap:=5
$ppm:=Position:C15("#[";$reference_object)
If ($ppm>0)
	$gap:=0
	$ppmf:=Position:C15("]";$reference_object;$ppm+2)
	If ($ppmf>0)
		$instruction_pm:=Substring:C12($reference_object;$ppm+2;$ppmf-$ppm-2)
		$reference_object:=Delete string:C232($reference_object;$ppm;$ppmf-$ppm+1)
		Repeat 
			$pv:=Position:C15(",";$instruction_pm)
			If ($pv>0)
				APPEND TO ARRAY:C911($_m;Num:C11(Substring:C12($instruction_pm;1;$pv-1)))
				$instruction_pm:=Substring:C12($instruction_pm;$pv+1)
			Else 
				APPEND TO ARRAY:C911($_m;Num:C11($instruction_pm))
			End if 
		Until ($pv=0)
		Case of 
			: (Size of array:C274($_m)=1)
				APPEND TO ARRAY:C911($_m;$_m{1})
		End case 
	End if 
End if 

$ppc:=Position:C15("%[";$reference_object)
Case of 
	: ($ppc>0)
		$ppcf:=Position:C15("]";$reference_object;$ppc+2)
		If ($ppcf>0)
			$instruction_pc:=Substring:C12($reference_object;$ppc+2;$ppcf-$ppc-2)
			$reference_object:=Delete string:C232($reference_object;$ppc;$ppcf-$ppc+1)
			$instruction_pch:=$instruction_pc
			
			$pt:=Position:C15("-";$instruction_pch)
			Case of 
				: ($pt=0)
					$width_instruction:=Num:C11($instruction_pch)
				: ($pt=1) & (Length:C16($instruction_pch)=1)
					$width_instruction:=100
				: ($pt=1)
					$left_instruction_pc:=0
					$right_instruction_pc:=Num:C11(Substring:C12($instruction_pch;2))
					$width_instruction:=-1
				: ($pt=Length:C16($instruction_pch))
					$left_instruction_pc:=Num:C11(Substring:C12($instruction_pch;1;$pt-1))
					$right_instruction_pc:=100
					$width_instruction:=-1
				Else 
					$left_instruction_pc:=Num:C11(Substring:C12($instruction_pch;1;$pt-1))
					$right_instruction_pc:=Num:C11(Substring:C12($instruction_pch;$pt+1))
					$width_instruction:=-1
			End case 
			
		End if 
		OBJECT GET COORDINATES:C663(*;$reference_object;$g_ref;$h_ref;$d_ref;$b_ref)
		$g_ref_init:=$g_ref
		$h_ref_init:=$h_ref
		$d_ref_init:=$d_ref
		$b_ref_init:=$b_ref
		
		Case of 
			: ($width_instruction>0)
				$g_ref_new:=0
				$d_ref_new:=$form_width*$width_instruction/100
			: ($width_instruction=-1)
				$g_ref_new:=$form_width*$left_instruction_pc/100
				$d_ref_new:=$form_width*$right_instruction_pc/100
		End case 
		
		$h_ref_new:=$h_ref
		$b_ref_new:=$b_ref
		
	Else 
		OBJECT GET COORDINATES:C663(*;$reference_object;$g_ref;$h_ref;$d_ref;$b_ref)
		$g_ref_init:=$g_ref
		$h_ref_init:=$h_ref
		$d_ref_init:=$d_ref
		$b_ref_init:=$b_ref
		
		$g_ref_new:=$g_ref
		$h_ref_new:=$h_ref
		$d_ref_new:=$form_width-$gap
		$b_ref_new:=$b_ref
End case 

If (Size of array:C274($_m)>0)
	$g_ref_new:=$g_ref_new+$_m{1}
	$d_ref_new:=$d_ref_new-$_m{2}
End if 

OBJECT SET COORDINATES:C1248(*;$reference_object;$g_ref_new;$h_ref_new;$d_ref_new;$b_ref_new)

For ($o;2;Count parameters:C259;1)
	$form_object:=${$o}
	Case of 
		: ($form_object="M:@")
			$action:="move"
			$form_object:=Substring:C12($form_object;3)
		: ($form_object="G:@")
			$action:="grow"
			$form_object:=Substring:C12($form_object;3)
		Else 
			$action:="grow"
	End case 
	
	OBJECT GET COORDINATES:C663(*;$form_object;$g2;$h2;$d2;$b2)
	
	Case of 
		: ($action="grow")
			$g2_new:=$g_ref_new+($g2-$g_ref_init)
			$d2_new:=$d_ref_new+($d2-$d_ref_init)
		: ($action="move")
			$g2_new:=$d_ref_new-($d_ref_init-$g2)
			$d2_new:=$d_ref_new-($d_ref_init-$d2)
	End case 
	
	If ($g2_new>$d2_new)
		$swap:=$d2_new
		$d2_new:=$g2_new
		$g2_new:=$swap
	End if 
	
	$h2_new:=$h2
	$b2_new:=$b2
	
	OBJECT SET COORDINATES:C1248(*;$form_object;\
		$g2_new;\
		$h2_new;\
		$d2_new;\
		$b2_new)
	
End for 
