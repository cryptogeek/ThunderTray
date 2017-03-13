#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance ignore

;title must contain
SetTitleMatchMode, 2

Run, thunderbird.exe
WinWait, ahk_exe thunderbird.exe
WinHide


OnExit, ExitSub

OnMessage(0x404, "AHK_NOTIFYICON")
 
AHK_NOTIFYICON(wParam, lParam)
{
    if (lParam = 0x202) ; WM_LBUTTONUP
	{
		WinShow, - Mozilla Thunderbird
		WinMaximize, - Mozilla Thunderbird
	}
}

ProcessExist(Name){
	Process,Exist,%Name%
	return Errorlevel
}

Loop
{
	If !ProcessExist("thunderbird.exe")
	{
		ExitApp
	}
	
	WinGet, winState, MinMax, ahk_exe thunderbird.exe
	if (winState = -1) {
		WinHide, - Mozilla Thunderbird
	}
   
	sleep 500
}

ExitSub:
WinClose, ahk_exe thunderbird.exe
ExitApp