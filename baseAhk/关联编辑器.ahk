/*
AutoHotkey 版本: 1.x
操作系统: WinXP
作者: 甲壳虫<jdchenjian@gmail.com>
博客: http://hi.baidu.com/jdchenjian
脚本说明： 此工具用来修改 AutoHotkey 脚本的右键菜单关联，适用于 AutoHotkey 安装版、绿色版。
脚本版本： 2009-01-21
*/

#NoEnv
#SingleInstance, force
SendMode Input
SetWorkingDir %A_ScriptDir%

; 版本(仅用于显示）
Script_Version=v1.0.3

; AutoHotkey 原版的相关信息写在注册表HKCR主键中，
; 尝试是当前用户否有权操作该键，如果无权操作HKCR键（受限用户），
; 可通过操作注册表HKCU键来实现仅当前用户关联AHK脚本。
IsLimitedUser:=0
RegWrite, REG_SZ, HKCR, .test
If ErrorLevel
IsLimitedUser:=1
RegDelete, HKCR, .test
If ErrorLevel
IsLimitedUser:=1

If IsLimitedUser=0 ; 非受限用户操作HKCR键
{
RootKey=HKCR
Subkey=
}
Else ; 受限用户操作HKCU键
{
RootKey=HKCU
Subkey=Software\Classes\ ; <-- 为简化后面的脚本，此子键须以“\”结尾
}

; 检查是否存在AHK注册表项
RegRead, FileType, %RootKey%, %Subkey%.ahk
If FileType<>
{
RegRead, value, %RootKey%, %Subkey%%FileType%\Shell\Open\Command ;AHK路径
AHK_Path:=PathGetPath(value)
RegRead, value, %RootKey%, %Subkey%%FileType%\Shell\Edit\Command ;编辑器路径
Editor_Path:=PathGetPath(value)
RegRead, value, %RootKey%, %Subkey%%FileType%\Shell\Compile\Command ;编译器路径
Compiler_Path:=PathGetPath(value)
RegRead, Template_Name, %RootKey%, %Subkey%.ahk\ShellNew, FileName ;模板文件名
}
Else
FileType=AutoHotkeyScript

If AHK_Path=
{
IfExist, %A_ScriptDir%\AutoHotkey.exe
AHK_path=%A_ScriptDir%\AutoHotkey.exe
}

If Editor_Path=
{
IfExist, %A_WinDir%\notepad.exe
Editor_Path=%A_WinDir%\notepad.exe
}

If Compiler_Path=
{
IfExist, %A_ScriptDir%\Compiler\Ahk2Exe.exe
Compiler_Path=%A_ScriptDir%\Compiler\Ahk2Exe.exe
}

If Template_Name=
Template_Name=Template.ahk

Gui, Add, Tab, x10 y10 w480 h250 Choose1, 设置|说明
Gui, Tab, 1
Gui, Add, GroupBox, x20 y40 w460 h50 , “运行脚本”关联的 AutoHotkey
Gui, Add, Edit, x35 y60 w340 h20 vAHK_Path, %AHK_path%
Gui, Add, Button, x385 y60 w40 h20 gFind_AHK, 浏览

Gui, Add, GroupBox, x20 y100 w460 h50 , “编辑脚本”关联的编辑器
Gui, Add, Edit, x35 y120 w340 h20 vEditor_Path, %Editor_Path%
Gui, Add, Button, x385 y120 w40 h20 gChoose_Editor, 浏览
Gui, Add, Button, x430 y120 w40 h20 gDefault_Editor, 默认

Gui, Add, GroupBox, x20 y160 w460 h50 , “编译脚本”关联的编译器
Gui, Add, Edit, x35 y180 w340 h20 vCompiler_Path, %Compiler_Path%
Gui, Add, Button, x385 y180 w40 h20 gChoose_Compiler, 浏览
Gui, Add, Button, x430 y180 w40 h20 gDefault_Compiler, 默认

Gui, Add, Checkbox, x35 y230 w270 h20 Checked gNew_Script vNew_Script, 右键“新建”菜单中增加“AutoHotkey 脚本”
Gui, Add, Button, x310 y230 w80 h20 vEdit_Template gEdit_Template, 编辑脚本模板
Gui, Add, Button, x400 y230 w80 h20 vDelete_Template gDelete_Template, 删除脚本模板

Gui, Tab, 2
Gui, Font, bold
Gui, Add, Text,, AutoHotkey 脚本关联工具 ScriptSetting %Script_Version%
Gui, Font
Gui, Font, CBlue Underline
Gui, Add, Text, gWebsite, 作者：甲壳虫 <jdchenjian@gmail.com>`n`n博客：http://hi.baidu.com/jdchenjian
Gui, Font
Gui, Add, Text, w450, 此工具用来修改 AutoHotkey 脚本的右键菜单关联，适用于 AutoHotkey 安装版、绿色版。
Gui, Add, Text, w450, 您可以用它来修改默认脚本编辑器、编译器，修改默认的新建脚本模板。设置后，在右键菜单中添加“运行脚本”、“编辑脚本”、“编译脚本”和“新建 AutoHotkey 脚本”等选项。
Gui, Add, Text, w450, 要取消脚本的系统关联，请按“卸载”。注意：卸载后您将无法通过双击来运行脚本，也不能通过右键菜单来启动脚本编辑器...

Gui, Tab
Gui, Add, Button, x100 y270 w60 h20 Default gInstall, 设置
Gui, Add, Button, x200 y270 w60 h20 gUninstall, 卸载
Gui, Add, Button, x300 y270 w60 h20 gCancel, 取消

Gui, Show, x250 y200 h300 w500 Center, ScriptSetting %Script_Version%
IfNotExist, %A_WinDir%\ShellNew\%Template_Name%
GuiControl, Disable, Delete_Template ; 使“删除脚本模板”按钮无效

; 当鼠标指向链接时，指针变成手形
hCurs:=DllCall("LoadCursor","UInt",NULL,"Int",32649,"UInt") ;IDC_HAND
OnMessage(0x200,"WM_MOUSEMOVE")
Return

; 改变鼠标指针为手形
WM_MOUSEMOVE(wParam,lParam)
{
Global hCurs
MouseGetPos,,,,ctrl
If ctrl in Static2
DllCall("SetCursor","UInt",hCurs)
Return
}
Return

GuiClose:
GuiEscape:
Cancel:
ExitApp

; 查找 AutoHotkey 主程序
Find_AHK:
Gui +OwnDialogs
FileSelectFile, AHK_Path, 3, , 查找 AutoHotkey.exe, AutoHotkey.exe
If AHK_Path<>
GuiControl,,AHK_Path, %AHK_Path%
Gosub Default_Compiler
Return

; 选择脚本编辑器
Choose_Editor:
Gui +OwnDialogs
FileSelectFile, Editor_Path, 3, , 选择脚本编辑器, 程序(*.exe)
If Editor_Path<>
GuiControl,,Editor_Path, %Editor_Path%
Return

; 默认脚本编辑器
Default_Editor:
IfExist, %A_WinDir%\notepad.exe
Editor_Path=%A_WinDir%\notepad.exe
Else IfExist, %A_WinDir%\system32\notepad.exe
Editor_Path=%A_WinDir%\system32\notepad.exe
GuiControl,, Editor_Path, %Editor_Path%
Return

; 选择脚本编译器
Choose_Compiler:
Gui +OwnDialogs
FileSelectFile, Compiler_Path, 3, , 选择脚本编译器, 程序(*.exe)
If Compiler_Path<>
GuiControl,,Compiler_Path, %Compiler_Path%
Return

; 默认脚本编译器
Default_Compiler:
GuiControlGet, AHK_Path
SplitPath, AHK_Path, ,AHK_Dir
IfExist, %AHK_Dir%\Compiler\Ahk2Exe.exe
{
Compiler_Path=%AHK_Dir%\Compiler\Ahk2Exe.exe
GuiControl,, Compiler_Path, %Compiler_Path%
}
Return

; 设置
Install:
Gui, Submit
IfNotExist, %AHK_Path%
{
MsgBox, 16, ScriptSetting %Script_Version%, AutoHotkey 路径错误 ！
Return
}

IfNotExist, %Editor_Path%
{
MsgBox, 16, ScriptSetting %Script_Version%, 编辑器路径错误 ！
Return
}

IfNotExist, %Compiler_Path%
{
MsgBox, 16, ScriptSetting %Script_Version%, 编译器路径错误 ！
Return
}

; 写入注册表
RegWrite, REG_SZ, %RootKey%, %Subkey%.ahk,, %FileType%
If New_Script=1
{
RegWrite, REG_SZ, %RootKey%, %Subkey%.ahk\ShellNew, FileName, %Template_Name%
IfNotExist, %A_WinDir%\ShellNew\%Template_Name%
Gosub Create_Template
}
Else
{
RegDelete, %RootKey%, %Subkey%.ahk\ShellNew
IfExist, %A_WinDir%\ShellNew\%Template_Name%
Gosub Delete_Template
}

RegWrite, REG_SZ, %RootKey%, %Subkey%%FileType%,, AutoHotkey 脚本
RegWrite, REG_SZ, %RootKey%, %Subkey%%FileType%\DefaultIcon,, %AHK_Path%`,1
RegWrite, REG_SZ, %RootKey%, %Subkey%%FileType%\Shell,, Open
RegWrite, REG_SZ, %RootKey%, %Subkey%%FileType%\Shell\Open,, 运行脚本
RegWrite, REG_SZ, %RootKey%, %Subkey%%FileType%\Shell\Open\Command,, "%AHK_Path%" "`%1" `%*
RegWrite, REG_SZ, %RootKey%, %Subkey%%FileType%\Shell\Edit,, 编辑脚本
RegWrite, REG_SZ, %RootKey%, %Subkey%%FileType%\Shell\Edit\Command,, "%Editor_Path%" "`%1"
RegWrite, REG_SZ, %RootKey%, %Subkey%%FileType%\Shell\Compile,, 编译脚本
IfInString, Compiler_Path, Ahk2Exe.exe
RegWrite, REG_SZ, %RootKey%, %Subkey%%FileType%\Shell\Compile\Command,, "%Compiler_Path%" /in "`%1"
Else
RegWrite, REG_SZ, %RootKey%, %Subkey%%FileType%\Shell\Compile\Command,, "%Compiler_Path%" "`%1"
MsgBox, 64, ScriptSetting %Script_Version%, 设置完毕 ！
ExitApp

; 卸载
Uninstall:
MsgBox, 36, ScriptSetting %Script_Version%
, 注意：卸载后您将无法通过双击来运行脚本，也不能通过右键菜单来启动脚本编辑器...`n`n确定要取消 AHK 脚本的系统关联吗 ？
IfMsgBox, Yes
{
RegDelete, %RootKey%, %Subkey%.ahk
RegDelete, %RootKey%, %Subkey%%FileType%
Gosub Delete_Template
ExitApp
}
Return

; 编辑脚本模板
Edit_Template:
GuiControlGet, Editor_Path
IfNotExist, %Editor_Path%
{
MsgBox, 64, ScriptSetting %Script_Version%, 脚本编辑器路径错误 ！
Return
}
IfNotExist, %A_WinDir%\ShellNew\%Template_Name%
Gosub Create_Template
Run, %Editor_Path% %A_WinDir%\ShellNew\%Template_Name%
Return

; 使编辑脚本模板按钮有效/无效
New_Script:
GuiControlGet, New_Script
If New_Script=0
GuiControl, Disable, Edit_Template
Else
GuiControl, Enable, Edit_Template
Return

; 新建脚本模板
Create_Template:
GuiControlGet, AHK_Path
FileGetVersion, AHK_Ver, %AHK_Path%

FileAppend,
(
/*
AutoHotkey 版本: %AHK_Ver%
操作系统: %A_OSVersion%
作者: %A_UserName%
网站: http://www.AutoHotkey.com
脚本说明：
脚本版本： v1.0
*/

#NoEnv
SendMode Input
SetWorkingDir `%A_ScriptDir`%

), %A_WinDir%\ShellNew\%Template_Name%

GuiControl, Enable, Delete_Template ; 使“删除脚本模板”按钮有效
Return

; 删除脚本模板
Delete_Template:
MsgBox, 36, ScriptSetting %Script_Version%
, 要删除当前的 AHK 脚本模板吗 ？`n`n脚本模板被删除后，仍可通过本工具重建模板。
IfMsgBox, Yes
FileDelete, %A_WinDir%\ShellNew\%Template_Name%
GuiControl, Disable, Delete_Template ; 使“删除脚本模板”按钮无效
Return

; 打开网站
Website:
Run, http://hi.baidu.com/jdchenjian
Return

; 从注册表值字符串中提取路径
PathGetPath(pSourceCmd)
{
Local Path, ArgsStartPos = 0

If (SubStr(pSourceCmd, 1, 1) = """")
Path := SubStr(pSourceCmd, 2, InStr(pSourceCmd, """", False, 2) - 2)
Else
{
ArgsStartPos := InStr(pSourceCmd, " ")
If ArgsStartPos
Path := SubStr(pSourceCmd, 1, ArgsStartPos - 1)
Else
Path = %pSourceCmd%
}
Return Path
}
