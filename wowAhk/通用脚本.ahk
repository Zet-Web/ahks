#Persistent
#NoEnv
#EscapeChar \
#SingleInstance, force
;===============================================

;=================
;=================
;=================

winTitle:="ħ������"
;winTitle:="�ޱ��� - ���±�"

wow_account=
wow_password=


PLabelStatus:=0
;���� Send �� ControlSend ����͵����ΰ����¼������ʱ,��һ��3��ʾ������Ӧ����ʱΪ3ms���ڶ���3��ʾ��������ʱ��Ϊ5ms
SetKeyDelay,0,30
;Ĭ��ְҵѡ����
Profession:="100000"
;================================



Menu,Tray,Icon,e:\\games\\wow\\wow.exe,0

;=============================����
Gui, font, s9, ����
;Gui,+ToolWindow
Gui,1:Add,Tab,x 10 y 10 w250 h170 Choose1,����|˵��|������Ϸ

Gui,Tab,1
Gui, Add, GroupBox, w60 h120 , ְҵѡ��
Gui, Add, Radio, vG1 gSetPro xp+10 yp+16  Checked, ����
Gui, Add, Radio, vG2 gSetPro , ����
Gui, Add, Radio, vG3 gSetPro  , սʿ
Gui, Add, Radio, vG4 gSetPro  , ��ʦ
Gui, Add, Radio, vG5 gSetPro  , ��ʿ
Gui, Add, Radio, vG6 gSetPro  , ��ʿ


Gui, Add, GroupBox, x90 y16 w145 h130 , �����ӳ�ѡ��,��λ����
Gui, Add, Text,xp+10 yp+20, ��С�ӳ�:
Gui, Add,DropDownList ,gCmin vCmin xp+60 yp+0 w60 Choose4 ,5|10|30|50|70|90|100
Gui, Add, Text,xp-60 yp+30, ����ӳ�:
Gui, Add,DropDownList ,gCmax vCmax xp+60 yp+0 w60 Choose5 ,10|30|50|90|100|150|170|190|200

Gui,Add,Text,xp-60 yp+30,��������:
Gui,Add,DropDownList,gChSend vChSend w100 Choose1,ħ������|�ޱ��� - ���±�
;Gui,Add,CheckBox,vChTest gChTest yp+25 xp-60,�ű�����ѡ��
;Gui,Add, Button,x200 y158 gApplyButton, Ӧ��

Gui,Tab,2
/*
Gui,Add,Text,,���´�������ּ�200���������
Gui,Add,Text,,������ѡְҵ���ò�ͬ��ǩ
Gui,Add,Text,Shift+����Ϲ��Զ�����- =��,\nShift+����¹�ֹͣ
*/


Gui,Tab,3
Gui,Add,Button,gRunGame,������Ϸ
Gui,Add,Button,gBackUpWTF,����WTF

Gui,Submit,NoHide
Gui,Show,,

GuiClose:
return
;===========================================








RunGame:
Run,e:\\games\\wow\\run.bat,"e:\\games\\wow\\",Hide
return

BackUpWTF:
Run,e:\\games\\wow\\update-wtf.bat,"e:\\games\\wow\\",Hide
return

ChSend:
Gosub,SubmitGui
;MsgBox,%ChSend%
winTitle=%ChSend%
return



;========================
;���ⰴ��ӳ��
;�����ϴ���ҳ 172 Browser_Home
;�ʼ� 180 Launch_Mail
;���� 170 Browser_Search
;========================
/*
Browser_Home::
Launch_Mail::
Browser_Search::
MsgBox, %A_ThisHotKey% �����¡�
return
*/
;=================
;=================
;=================
;������������
;===============================================

PLabel:
{
	PLabelStatus=1
	Gosub,GetRandSleep
	GoSub,Label_%Profession%

}

Label_100000:
{
	;MsgBox,ѡ������ �����%randSleep%
	ControlSend ,,{-},%winTitle%,,,
	;Gosub,GetRandSleep
	;Sleep, %randSleep%
	ControlSend ,,{=},%winTitle%,,,
	Gosub,GetRandSleep
	Sleep, %randSleep%
}
return

Label_010000:
{
	;MsgBox,ѡ������ �����%randSleep%
	
		ControlSend ,,{4},%winTitle%,,,
		Gosub,GetRandSleep	
		Sleep, %randSleep%
	
		ControlSend ,,{-},%winTitle%,,,
		Gosub,GetRandSleep	
		Sleep, %randSleep%
	
		ControlSend ,,{=},%winTitle%,,,
		Gosub,GetRandSleep
		Sleep, %randSleep%
	

	
}
return

Label_001000:
{
	;MsgBox,ѡ��սʿ �����%randSleep%
	ControlSend ,,{-},%winTitle%,,,
	Gosub,GetRandSleep
	Sleep, %randSleep%
	ControlSend ,,{=},%winTitle%,,,
	Gosub,GetRandSleep
	Sleep, %randSleep%
}
return

Label_000100:
{
	;MsgBox,ѡ�з�ʦ �����%randSleep%
	ControlSend ,,{-},%winTitle%,,,
	;Gosub,GetRandSleep
	;Sleep, %randSleep%
	ControlSend ,,{=},%winTitle%,,,
	Gosub,GetRandSleep
	Sleep, %randSleep%
}
return


/**
* ��ʿר�� BEGIN
*/
Label_000010:
{
	;MsgBox,ѡ����ʿ �����%randSleep%
	ControlSend ,,{-},%winTitle%,,,
	;Gosub,GetRandSleep
	;Sleep, %randSleep%
	ControlSend ,,{=},%winTitle%,,,
	Gosub,GetRandSleep
	Sleep, %randSleep%	
}
return


/**
* ��ʿר�� END
*/

Label_000001:
{
	;MsgBox,ѡ����ʿ �����%randSleep%
	ControlSend ,,{-},%winTitle%,,,
	;Gosub,GetRandSleep
	;Sleep, %randSleep%
	ControlSend ,,{=},%winTitle%,,,
	Gosub,GetRandSleep
	Sleep, %randSleep%
}
return



GetRandSleep:
	Random,randSleep,%Cmin%,%Cmax%
	;MsgBox,����� %randSleep%
return


;����ְҵ
SetPro:
Gosub,SubmitGui
;MsgBox %G1% %G2% %G3% %G4% %G5% %G6%
;����100000
;����010000
;.....����
Profession=%G1%%G2%%G3%%G4%%G5%%G6%
;MsgBox,ְҵ %Profession%
return


SubmitGui:
Gui,Submit,NoHide
return

Cmax:
Gosub,SubmitGui
LoopDelayMin:=%Cmax%
return

Cmin:
Gosub,SubmitGui
LoopDelayMax:=%Cmin%
return

;=======================
;=======================

~`::
~1::
~2::
~3::
~4::
~5::
~6::
~7::
~8::
~9::
~0::
~q::
~e::
~r::
~c::
count=0
SetKeyDelay,0,10
StringRight, KP_c, A_ThisHotkey, 1
;��������ȡģʽΪȫ��
CoordMode,Mouse,Screen
MouseGetPos, xpos, ypos ,,,1
;Msgbox, The cursor is at X%xpos% Y%ypos%.

While GetKeyState(KP_c, "P")
{
	if (count=0)
	{
		;ControlSend ,,{%KP_c%},%winTitle%,,,
		Sleep,120
		count=1
		continue
	}
	GoSub,GetRandSleep
	;MsgBox,���sleep %randSleep%
	ControlSend ,,{%KP_c%},%winTitle%,,,
	Sleep, %randSleep%
}
return


$Capslock::
tc=0
SetKeyDelay,0,50
if(Profession="000100" or Profession="000010" or Profession="010000")
{
	;ControlSend ,,{t},%winTitle%,,,;��ʦ����ʿ�����˰�סT������ǩʱ���෢��һ��T
}
While GetKeyState("Capslock","P")
{
	if(tc=0)
	{
		Sleep,150
		tc=1
		continue
	}
	;ControlSend ,,{SHIFTUP},%winTitle%,,,
	GoSub,Label_%Profession%
}
return


;���������1����2
/*
XButton1::
{
	ControlSend ,,{1},%winTitle%,,,
}
return

XButton2::
{
	ControlSend ,,{2},%winTitle%,,,
}
return
*/

;��������ñ�ǩ0 Ctrl
^XButton2::
$F4::
Launch_Mail::
{
	;MsgBox "������"
	SetKeyDelay,0,50
	if(PLabelStatus=0)	{
		SetTimer,PLabel,5
	}

}
return

^XButton1::
$F5::
Browser_Search::
{
	;MsgBox "������"
	SetKeyDelay,0,50
	PLabelStatus=0
	SetTimer,PLabel,Off

}
return




;==========================================
;==========================================
pause::Suspend
;^!r::Reload  ;ָ�� Ctrl-Alt-R ��Ϊ�����ű����ȼ���
