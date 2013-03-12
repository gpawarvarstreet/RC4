<%Option Explicit%>
<!-- #include file="RC4.asp" -->
<%
Dim EncCCNum
EncCCNum = RC4("7415123615465466",Session.SessionID)
Response.Write EncCCNum & "<br>"
Response.Write Now()
Response.End 
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
Response.Write "test"
Response.End 
%>
