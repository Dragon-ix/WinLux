#Requires AutoHotkey v2.0
#SingleInstance Force

StateFile := A_ScriptDir "\state.txt"

SetState(val) {
    try {
        if FileExist(StateFile)
            FileDelete(StateFile)
        FileAppend(val, StateFile, "UTF-8-RAW")
        ToolTip("Desktop " val " Active")
        SetTimer(() => ToolTip(), -1000)
    }
}

; Create state.txt immediately on startup if missing
if !FileExist(StateFile) {
    SetState("0")
}

~^#Left::SetState("0")
~^#Right::SetState("1")