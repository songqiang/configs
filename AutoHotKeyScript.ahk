; http://ahkscript.org/

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Maps Caps lock key to Ctrl. However Shift+Cap will turn on the upcase 
+Capslock::Capslock
Capslock::Ctrl
