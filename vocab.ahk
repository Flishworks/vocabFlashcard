; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Win9x/NT
; Author:         Avi Kazen
; function: reads vocab words from file vocab.txt and displays them, randomly, one at a time every 5 minutes

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


; Create the array, initially empty:
wordList := Object()
learned := Object()

; Write to the array:
i:=0
Loop, Read, vocab.txt ; This loop retrieves each line from the file, one at a time.
{  
  i+=1
  wordList[i]:=A_LoopReadLine ; Append this line to the array.
  learned[i]:=0
}

Loop {
  skipWait:=false
  
  Loop { ;find a random word, but not one marked as learned
    random, rand, 1, i
    if (learned[rand] != 1){
     line := wordList[rand]
     break
    }
  }
 
  ;set the word and definition variables
  word := ""
  definition := ""
  Loop, parse, line, -
  {
    if (word = ""){
      word = %A_LoopField%
    }
    else definition = %A_LoopField%
  }
  
  MsgBox %word% 
  MsgBox,4,, %definition% `n `n `n `nMark this word as "learned"?
  IfMsgBox Yes
    learned[rand]:=1 ; mark as learned so it doesnt repeat
  else
    loop 60000 {
      if (skipWait=false) { ;must be inside loop so we can break
        sleep, 1
      }
    }
}

Return

!n:: ;alt+n skips the wait time until next word displays
  skipWait:=true
Return
