<%
Function RC4(ByRef pStrMessage, ByRef pStrKey)

	Dim lBytAsciiAry(255)
	Dim lBytKeyAry(255)
	Dim lLngIndex
	Dim lBytJump
	Dim lBytTemp
	Dim lBytY
	Dim lLngT
	Dim lLngX
	Dim lLngKeyLength
	
	' Validate data
	If Len(pStrKey) = 0 Then Exit Function
	If Len(pStrMessage) = 0 Then Exit Function

	' transfer repeated key to array
	lLngKeyLength = Len(pStrKey)
	For lLngIndex = 0 To 255
	    lBytKeyAry(lLngIndex) = Asc(Mid(pStrKey, ((lLngIndex) Mod (lLngKeyLength)) + 1, 1))
	Next

	' Initialize S
	For lLngIndex = 0 To 255
	    lBytAsciiAry(lLngIndex) = lLngIndex
	Next

	' Switch values of S arround based off of index and Key value
	lBytJump = 0
	For lLngIndex = 0 To 255
	
		' Figure index to switch
	    lBytJump = (lBytJump + lBytAsciiAry(lLngIndex) + lBytKeyAry(lLngIndex)) Mod 256
	    
	    ' Do the switch
	    lBytTemp				= lBytAsciiAry(lLngIndex)
	    lBytAsciiAry(lLngIndex)	= lBytAsciiAry(lBytJump)
	    lBytAsciiAry(lBytJump)	= lBytTemp
	    
	Next

	
	lLngIndex = 0
	lBytJump = 0
	For lLngX = 1 To Len(pStrMessage)
	    lLngIndex = (lLngIndex + 1) Mod 256 ' wrap index
	    lBytJump = (lBytJump + lBytAsciiAry(lLngIndex)) Mod 256 ' wrap J+S()
	    
		' Add/Wrap those two	    
	    lLngT = (lBytAsciiAry(lLngIndex) + lBytAsciiAry(lBytJump)) Mod 256
	    
	    ' Switcheroo
	    lBytTemp				= lBytAsciiAry(lLngIndex)
	    lBytAsciiAry(lLngIndex)	= lBytAsciiAry(lBytJump)
	    lBytAsciiAry(lBytJump)	= lBytTemp

	    lBytY = lBytAsciiAry(lLngT)
	
		' Character Encryption ...    
	    RC4 = RC4 & Chr(Asc(Mid(pStrMessage, lLngX, 1)) Xor lBytY)
	Next
	
End Function

function MaskCCNo(ECCNO)
    Dim XString
    Dim iCount
    for iCount=1 to len(ECCNO)-4
        XString = XString & "X"
    next
    MaskCCNo = XString & Right(RC4(ECCNO,Session.SessionID),4)
end function

function UnMaskCCNo(DCCNO)
    UnMaskCCNo = RC4(DCCNO,Session.SessionID)
end function
%>