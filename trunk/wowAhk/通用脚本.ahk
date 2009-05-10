#Persistent
#NoEnv
#EscapeChar \
#SingleInstance, force
;===============================================

;=================
;=================
;=================

winTitle:="魔兽世界"
;winTitle:="无标题 - 记事本"

wow_account=
wow_password=


PLabelStatus:=0
;设置 Send 和 ControlSend 命令发送的两次按键事件间的延时,第一个3表示按键响应的延时为3ms，第二个3表示按键持续时间为5ms
SetKeyDelay,0,30
;默认职业选萨满
Profession:="100000"
;================================



Menu,Tray,Icon,e:\\games\\wow\\wow.exe,0

;=============================窗体
Gui, font, s9, 宋体
;Gui,+ToolWindow
Gui,1:Add,Tab,x 10 y 10 w250 h170 Choose1,设置|说明|运行游戏

Gui,Tab,1
Gui, Add, GroupBox, w60 h120 , 职业选择
Gui, Add, Radio, vG1 gSetPro xp+10 yp+16  Checked, 萨满
Gui, Add, Radio, vG2 gSetPro , 猎人
Gui, Add, Radio, vG3 gSetPro  , 战士
Gui, Add, Radio, vG4 gSetPro  , 法师
Gui, Add, Radio, vG5 gSetPro  , 术士
Gui, Add, Radio, vG6 gSetPro  , 骑士


Gui, Add, GroupBox, x90 y16 w145 h130 , 按键延迟选择,单位毫秒
Gui, Add, Text,xp+10 yp+20, 最小延迟:
Gui, Add,DropDownList ,gCmin vCmin xp+60 yp+0 w60 Choose4 ,5|10|30|50|70|90|100
Gui, Add, Text,xp-60 yp+30, 最大延迟:
Gui, Add,DropDownList ,gCmax vCmax xp+60 yp+0 w60 Choose5 ,10|30|50|90|100|150|170|190|200

Gui,Add,Text,xp-60 yp+30,按键发送:
Gui,Add,DropDownList,gChSend vChSend w100 Choose1,魔兽世界|无标题 - 记事本
;Gui,Add,CheckBox,vChTest gChTest yp+25 xp-60,脚本测试选择
;Gui,Add, Button,x200 y158 gApplyButton, 应用

Gui,Tab,2
/*
Gui,Add,Text,,按下大键盘数字键200毫秒后连发
Gui,Add,Text,,根据所选职业调用不同标签
Gui,Add,Text,Shift+鼠标上滚自动调用- =键,\nShift+鼠标下滚停止
*/


Gui,Tab,3
Gui,Add,Button,gRunGame,进入游戏
Gui,Add,Button,gBackUpWTF,备份WTF

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
;特殊按键映射
;键盘上打开首页 172 Browser_Home
;邮件 180 Launch_Mail
;搜索 170 Browser_Search
;========================
/*
Browser_Home::
Launch_Mail::
Browser_Search::
MsgBox, %A_ThisHotKey% 被按下。
return
*/
;=================
;=================
;=================
;环境变量设置
;===============================================

PLabel:
{
	PLabelStatus=1
	Gosub,GetRandSleep
	GoSub,Label_%Profession%

}

Label_100000:
{
	;MsgBox,选中萨满 随机数%randSleep%
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
	;MsgBox,选中猎人 随机数%randSleep%
	
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
	;MsgBox,选中战士 随机数%randSleep%
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
	;MsgBox,选中法师 随机数%randSleep%
	ControlSend ,,{-},%winTitle%,,,
	;Gosub,GetRandSleep
	;Sleep, %randSleep%
	ControlSend ,,{=},%winTitle%,,,
	Gosub,GetRandSleep
	Sleep, %randSleep%
}
return


/**
* 术士专区 BEGIN
*/
Label_000010:
{
	;MsgBox,选中术士 随机数%randSleep%
	ControlSend ,,{-},%winTitle%,,,
	;Gosub,GetRandSleep
	;Sleep, %randSleep%
	ControlSend ,,{=},%winTitle%,,,
	Gosub,GetRandSleep
	Sleep, %randSleep%	
}
return


/**
* 术士专区 END
*/

Label_000001:
{
	;MsgBox,选中骑士 随机数%randSleep%
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
	;MsgBox,随机数 %randSleep%
return


;设置职业
SetPro:
Gosub,SubmitGui
;MsgBox %G1% %G2% %G3% %G4% %G5% %G6%
;萨满100000
;猎人010000
;.....类推
Profession=%G1%%G2%%G3%%G4%%G5%%G6%
;MsgBox,职业 %Profession%
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
;设置鼠标获取模式为全屏
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
	;MsgBox,随机sleep %randSleep%
	ControlSend ,,{%KP_c%},%winTitle%,,,
	Sleep, %randSleep%
}
return


$Capslock::
tc=0
SetKeyDelay,0,50
if(Profession="000100" or Profession="000010" or Profession="010000")
{
	;ControlSend ,,{t},%winTitle%,,,;法师，术士，猎人按住T出发标签时，多发送一次T
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


;鼠标侧键，下1，上2
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

;鼠标侧键调用标签0 Ctrl
^XButton2::
$F4::
Launch_Mail::
{
	;MsgBox "鼠标侧上"
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
	;MsgBox "鼠标侧下"
	SetKeyDelay,0,50
	PLabelStatus=0
	SetTimer,PLabel,Off

}
return




;==========================================
;==========================================
pause::Suspend
;^!r::Reload  ;指定 Ctrl-Alt-R 作为重启脚本的热键。
