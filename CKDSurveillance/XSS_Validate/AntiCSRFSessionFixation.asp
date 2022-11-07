<%
	'This constant string should only contain numbers and should be at least 10 digits long
	SecurityConstant="3194729085"
	
	ckie = Request.ServerVariables("HTTP_COOKIE")
	
	If ckie <> Empty then
		ckiename = Mid(ckie,1,(Instr(ckie,"=")-1))
    End if
	
	Function Crypt(word)
		Set ObjCrypt = Server.CreateObject("SecurityWeb.Encrypt")
		Crypt = objCrypt.TwoWayCrypt(word)
	End Function

	Function GetDigest()
		datetime = cstr(DatePart("m",Date)) & cstr(DatePart("d",Date)) & cstr(DatePart("yyyy",Date)) & GetTimeStr
		GetDigest=Cstr(Crypt(SecurityConstant)) & Cstr(Crypt(datetime))
	End Function
	
	Function GetTimeStr()
		If len(cstr(DatePart("h",Time))) = 1 then
			hr= 0 & cstr(DatePart("h",Time))
		Else
			hr= cstr(DatePart("h",Time))
		End if
		
		If len(cstr(DatePart("n",Time))) = 1 then
			min= 0 & cstr(DatePart("n",Time))
		Else
			min= cstr(DatePart("n",Time))
		End if
		
		If len(cstr(DatePart("s",Time))) = 1 then
			sec= 0 & cstr(DatePart("s",Time))
		Else
			sec= cstr(DatePart("s",Time))
		End if
		
		GetTimeStr=hr & min & sec
	End Function
		
	Function IsFormTampered(EncryptedValue,RequestExpirationTime)
			rtnVal= False
			decryptedVal=Crypt(EncryptedValue) 
			
			dConstantstr=Left(decryptedVal,len(SecurityConstant))
			
			If SecurityConstant = dConstantstr then
					'curdatetime = cstr(DatePart("m",Date)) & cstr(DatePart("d",Date)) & cstr(DatePart("yyyy",Date)) & cstr(DatePart("h",Time)) & cstr(DatePart("n",Time)) & cstr(DatePart("s",Time))
					
					curdate = cstr(DatePart("m",Date)) & cstr(DatePart("d",Date)) & cstr(DatePart("yyyy",Date)) 
					LoginDatetime=Right(decryptedVal,len(decryptedVal)-len(SecurityConstant))
					
					If Instr(LoginDatetime,curdate) > 0 Then
							LoginTime=Right(LoginDatetime,len(LoginDatetime)-len(curdate))
							LoginHr=Left(LoginTime,2)
							LoginMin=Mid(LoginTime,3,2)
							LoginSec=Right(LoginTime,2)
							
							LoginDateTime=Date & " " & LoginHr & ":" & LoginMin & ":" & LoginSec
															
							If DateDiff("s",LoginDateTime,Now) > RequestExpirationTime Then
									rtnVal = True
							End if
														
					Else
							rtnVal = True
					End if
					
			Else
					rtnVal = True
			End if
								
			IsFormTampered=rtnVal
	End Function
%>