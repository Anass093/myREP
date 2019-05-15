//%attributes = {}
$margin:=5
$widthscrollBar:=16
OBJECT GET COORDINATES:C663(*;"bkgd_panel";$gp;$hp;$dp;$bp)

If (Form:C1466.twinsMode=Null:C1517)
	OBJECT SET VISIBLE:C603(*;"bkgd_panel_twin";False:C215)
	OBJECT SET VISIBLE:C603(*;"sf_panel_twin";False:C215)
	OBJECT SET VISIBLE:C603(*;"bMerge";False:C215)
	OBJECT SET SCROLLBAR:C843(*;"sf_panel@";False:C215;False:C215)
	
	OBJECT SET COORDINATES:C1248(*;"sf_panel";\
		$gp+$margin;\
		$hp+$margin;\
		$dp-$margin;\
		$bp-$margin)
	
Else 
	OBJECT SET VISIBLE:C603(*;"bkgd_panel_twin";True:C214)
	OBJECT SET VISIBLE:C603(*;"sf_panel_twin";True:C214)
	OBJECT SET VISIBLE:C603(*;"bMerge";item_is_in_modification)
	
	OBJECT SET SCROLLBAR:C843(*;"sf_panel@";False:C215;True:C214)
	
	OBJECT SET COORDINATES:C1248(*;"bkgd_panel_twin";\
		$gp;\
		$hp+(($bp-$hp)/2);\
		$dp;\
		$bp)
	
	OBJECT SET COORDINATES:C1248(*;"sf_panel";\
		$gp+$margin;\
		$hp+$margin;\
		$dp-$margin-$widthscrollBar;\
		$hp+(($bp-$hp)/2)-$margin)
	
	OBJECT SET COORDINATES:C1248(*;"sf_panel_twin";\
		$gp+$margin;\
		$hp+(($bp-$hp)/2)+$margin;\
		$dp-$margin-$widthscrollBar;\
		$bp-$margin)
	
	OBJECT SET COORDINATES:C1248(*;"bMerge";\
		$gp+($margin*5);\
		$hp+(($bp-$hp)/2)-15;\
		$gp+($margin*5)+100;\
		$hp+(($bp-$hp)/2)+15)
	
	
	
End if 