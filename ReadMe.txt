Due to the nature of HTML and the inability to represent
specific characters (ie NULL) in the ASCII table, you 
may run into a situation where you can encrypt your
data, but decrypting it will not yield the original
results.  Don't be alarmed - the algorithm works.  
The problem is that it is not receiving the same 
encrypted characters that it originally returned.

Try this.  Take the key and the clear text message that 
you were trying to encrypt and do the following:

<%
Dim StrMyKey
Dim StrMyMessage

StrMyKey = "INSERT YOUR KEY HERE"
StrMyMessage = "INSERT YOUR MESSAGE HERE"

Response.Write(RC4(RC4(StrMyMessage, StrMyKey), StrMyKey))
%>


This should return the original message that you were
having problems decrypting the results.  If you "must"
display the results in the clients browser, then you
may want to consider other alternatives of storing the
information on the client.  (Such as a hex format of the
encrypted data in a hidden field)

Hopefully this has helped answer any problems that you
may run into.