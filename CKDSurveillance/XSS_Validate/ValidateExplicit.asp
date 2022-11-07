<!--<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">-->
<%
'03/24/08 (SD): Made changes based on the latest code from ValidateMaster; Turned ON SQL Injection by default.
Dim XSS_Validated
If trim(XSS_Validated) = "" then

	XSS_Validated = "Y"
	
	Dim objRE 
	Dim chkSQLInj
	Dim BlockedPage
	Dim varValidateURL
	Dim varValidatePrefix
	Dim arrValidateSubFolders
	Dim intValidateDepth
	Dim intValidateCounter
	varValidateURL = Request.ServerVariables("URL")
	arrValidateSubFolders = Split(varValidateURL,"/")
	intValidateDepth = Ubound(arrValidateSubFolders) - 3
	For intValidateCounter = 0 to intValidateDepth
		varValidatePrefix = varValidatePrefix & "../"
	Next
	
	'Set objRE = Server.CreateObject("VBScript.RegExp")
	Set objRE = New RegExp
	
	'Added to accomodate server.execute(conditional include for DMIS)
	'08/11/08: Turned SQL Injection to OFF by default, based on Amy's suggestion. Issue #17
	If Session("chkSQLInj") <> "" Then
		chkSQLInj = True
		Session("chkSQLInj") = ""
	ElseIf trim(chkSQLInj) = "" or isNULL(chkSQLInj) then
		chkSQLInj = False
	End if
	
	If trim(BlockedPage)= "" or isNULL(BlockedPage) then
		BlockedPage = varValidatePrefix & "Blocked.asp"
	End if
	
	'Call Validate
	ValidateInput BlockedPage, True, chkSQLInj 
	
	Function FoundSuspectTags(Byval InputString, Byval chkCSS, Byval chkSQLInj, ByVal chkQueryStr)
		
		
		'Response.Write "Called RegExp"
		'Response.End
		
		Dim REPattern
		
		'Closing and opening angled brackets; forward slash; alphanumeric string inside the tag or its hex equivalent
		If cbool(chkCSS) Then
			REPattern = "(?:(\%3C)|<|(&lt;)|(\+ADw-)|(\+ADz-)|(\+AD4APA-)).+(?:(\%3E)|>|(&gt;)|(\+AD4-)|(\+AD7-))"
			REPattern = REPattern & "|" & "\s*(?:CMCDLLNAME|javascript|vbscript|charset|content-type|content-length)\s*"
			
			'07/25/07 - Removed and moved the validation to the Query string as it was blocking legitmate CR and LF entered into a textbox
			'REPattern = REPattern & "|" & chr(10) & "|" & chr(13)
			
			'Javascript events
			REPattern = REPattern & "|" & "\s*(?:onAbort\s*=|onBlur\s*=|onChange\s*=|onClick\s*=|onDblClick\s*=|onDragDrop\s*=|onError\s*=|onFocus\s*=|onKeyDown\s*=|onKeyPress\s*=|onKeyUp\s*=|onLoad\s*=|onMouseDown\s*=|onMouseMove\s*=|onMouseOut\s*=|onMouseOver\s*=|onMouseUp\s*=|onMove\s*=|onReset\s*=|onResize\s*=|onSelect\s*=|onSubmit\s*=|onUnload\s*=)\s*"		
			
			'Javascript functions
			REPattern = REPattern & "|" & "\s*(?:escape\s*\(|eval\s*\(|unescape\s*\(|isFinite\s*\(|isNaN\s*\(|parseFloat\s*\(|parseInt\s*\(|taint\s*\(|untaint\s*\(|alert\s*\(|blur\s*\(|clearInterval\s*\(|clearTimeout\s*\(|close\s*\(|confirm\s*\(|createPopup\s*\(|focus\s*\(|moveBy\s*\(|moveTo\s*\(|open\s*\(|print\s*\(|prompt\s*\(|resizeBy\s*\(|resizeTo\s*\(|scrollBy\s*\(|scrollTo\s*\(|setInterval\s*\(|setTimeout\s*\(|atob\s*\(|back\s*\(|btoa\s*\(|captureEvents\s*\(|crypto\.random\s*\(|crypto\.signText\s*\(|disableExternalCapture\s*\(|enableExternalCapture\s*\(|enableExternalCapture\s*\(|find\s*\(|forward\s*\(|handleEvent\s*\(|home\s*\(|releaseEvents\s*\(|routeEvent\s*\(|setHotKeys\s*\(|setResizable\s*\(|setZOptions\s*\(|reset\s*\(|submit\s*\()\s*"			
			
			'VBscript functions
			REPattern = REPattern & "|" & "\s*(?:Abs\s*\(|Array\s*\(|Asc\s*\(|Atn\s*\(|CBool\s*\(|CByte\s*\(|CCur\s*\(|CDate\s*\(|CDbl\s*\(|Chr\s*\(|CInt\s*\(|CLng\s*\(|Cos\s*\(|CreateObject\s*\(|CSng\s*\(|CStr\s*\(|DateAdd\s*\(|DateDiff\s*\(|DatePart\s*\(|DateSerial\s*\(|DateValue\s*\(|Day\s*\(|Eval\s*\(|Exp\s*\(|Filter\s*\(|Fix\s*\(|FormatCurrency\s*\(|FormatDateTime\s*\(|FormatNumber\s*\(|FormatPercent\s*\(|GetLocale\s*\(|GetObject\s*\(|GetRef\s*\(|Hex\s*\(|Hour\s*\(|InputBox\s*\(|InStr\s*\(|InStrRev\s*\(|Int\s*\(|IsArray\s*\(|IsDate\s*\(|IsEmpty\s*\(|IsNull\s*\(|IsNumeric\s*\(|IsObject\s*\(|Join\s*\(|LBound\s*\(|LCase\s*\(|Left\s*\(|Len\s*\(|LoadPicture\s*\(|Log\s*\(|LTrim\s*\(|Mid\s*\(|Minute\s*\(|Month\s*\(|MonthName\s*\(|MsgBox\s*\(|Now\s*\(|Oct\s*\(|Replace\s*\(|RGB\s*\(|Right\s*\(|Rnd\s*\(|Round\s*\(|RTrim\s*\(|ScriptEngine|ScriptEngineBuildVersion|ScriptEngineMajorVersion|ScriptEngineMinorVersion|Second\s*\(|Sgn\s*\(|Sin\s*\(|Space\s*\(|Split\s*\(|Sqr\s*\(|StrComp\s*\(|String\s*\(|StrReverse\s*\(|Tan\s*\(|Time\s*\(|Timer\s*\(|TimeSerial\s*\(|TimeValue\s*\(|Trim\s*\(|TypeName\s*\(|UBound\s*\(|UCase\s*\(|VarType\s*\(|Weekday\s*\(|WeekdayName\s*\(|Year\s*\()\s*" 

			'Check this pattern only for the QueryStrings
			If cbool(chkQueryStr) then
				REPattern = REPattern & "|" & "(http\://|https\://|ftp\://|www\.)([^ ]+)(. | |\)|\'|$)" 
				REPattern = REPattern & "|" & "\s*(?:0x0a|%0a|0x10|0x0d|%0d|0x13)\s*"
				REPattern = REPattern & "|" & chr(10) & "|" & chr(13)
			End if			
		End if
				
		'Pattern for SQL Injection
		'SQL Meta-Characters like = (Equal), ' (Single quote), -- (Double Dash), ; (Semi-colon)
		'REPattern = REPattern & "|" & "((\%3D)|(=))[^\n]*((\%27)|(\')|(\-\-)|(\%3B)|(;))"
		'07/16/07 - Removed the / (forward slash) from the list based on discussion with Priya and testing
		'03/28/08 - Removed the # sign from theSQL Injection check as the # was being blocked when passed in the URL of the (BRFSS) application.
		'08/11/08: Only single quotes, xp_, sp_, and double hyphens were decided to be implemented based on meeting with Amy and Priya.
		If cbool(chkSQLInj) then
			If REPattern = "" then
				'REPattern = "\s*((?:\%25|\%)|(?:\%5C|\\)|(?:\%27|\')|(?:\%2D\%2D|\-\-)|(?:;|\%3B)|xp_|sp_|(?:\%3A|\:)|(?:\%28|\()|(?:\%29|\))|(?:\%26|&)|(?:\%24|\$)|(?:\%5E|\^)|(?:\%2A|\*)|(?:\%2B|\+)|(?:\%3D|=))\s*"
				REPattern = "\s*((?:\%27|\')|(?:\%2D\%2D|\-\-)|xp_|sp_)\s*"
			Else
				'REPattern = REPattern & "|" & "\s*((?:\%25|\%)|(?:\%5C|\\)|(?:\%27|\')|(?:\%2D\%2D|\-\-)|(?:;|\%3B)|xp_|sp_|(?:\%3A|\:)|(?:\%28|\()|(?:\%29|\))|(?:\%26|&)|(?:\%24|\$)|(?:\%5E|\^)|(?:\%2A|\*)|(?:\%2B|\+)|(?:\%3D|=))\s*"
				REPattern = REPattern & "|" & "\s*((?:\%27|\')|(?:\%2D\%2D|\-\-)|xp_|sp_)\s*"
			End if
		End if
		'Response.Write "REPattern=" & REPattern & "<BR>"
		
		'Response.Write "InputString: " & InputString & "<BR>"
		
		objRE.Pattern = REPattern
			
		objRE.IgnoreCase = True 'ignore case of string
		objRE.Global = False 'stop on first hit

		FoundSuspectTags = objRE.Test(InputString)
		
		
	End Function
	
	Public Sub ValidateInput(Byval BlockedPage, Byval chkCSS, Byval chkSQLInj)
		'Loop thru Forms Collection
		Dim frmItem, iCount
		Dim iNameValue
		
		If trim(chkCSS) = "" OR IsNULL(chkCSS) then
			chkCSS = True
		End if
		
		If trim(chkSQLInj) = "" OR IsNULL(chkSQLInj) then
			chkSQLInj = True
		End if
				
		For each frmItem in Request.Form
			For iCount = 1 to Request.Form(frmItem).Count
				iNameValue = cstr(frmItem) & " " & Request.Form(frmItem)(iCount)
				If FoundSuspectTags(iNameValue, chkCSS, chkSQLInj, False) then
					'Response.End
					Set objRE = Nothing
					If trim(BlockedPage) <> "" then
						Response.Redirect BlockedPage
					Else
						Response.End	
					End if					
				End if
			Next
		Next
		
		'Loop thru QueryString Collection
		Dim qryItem		
		For each qryItem in Request.QueryString
			For iCount = 1 to Request.QueryString(qryItem).Count
				iNameValue = cstr(qryItem) & " " & Request.QueryString(qryItem)(iCount)
				'Response.Write "iNameValue " & iNameValue & "<BR>"
				If FoundSuspectTags(iNameValue, chkCSS, chkSQLInj, True) then
					'Response.End
					Set objRE = Nothing
					If trim(BlockedPage) <> "" then
						Response.Redirect BlockedPage
					Else
						Response.End
					End if
				End if
			Next
		Next
		
		'Loop thru Cookies Collection
		'Commented this out for DOHDRC - The static page sets cookies with invalid characters
		'Dim ckItem, ckItemKey
		'For each ckItem in Request.Cookies
		'	If Request.Cookies(ckItem).HasKeys then
		'		For each ckItemKey in Request.Cookies(ckItem)
		'			If Instr(1,Request.Cookies(ckItem)(ckItemKey),"apstoken=",1) = 0 then
		'				If FoundSuspectTags(Request.Cookies(ckItem)(ckItemKey), chkCSS, chkSQLInj, False) then
		'					'Response.End
		'					Set objRE = Nothing
		'					If trim(BlockedPage) <> "" then
		'						Response.Redirect BlockedPage
		'					Else
		'						Response.End
		'					End if
		'				End if
		'			End if
		'		Next			
		'	Else
		'		If Instr(1,Request.Cookies(ckItem),"apstoken=",1) = 0 then
		'			If FoundSuspectTags(Request.Cookies(ckItem), chkCSS, chkSQLInj, False) then
		'				'Response.End
		'				Set objRE = Nothing
		'				If trim(BlockedPage) <> "" then
		'					Response.Redirect BlockedPage
		'				Else
		'					Response.End
		'				End if
		'			End if
		'		End if
		'	End if 
		'Next
		
		'Response.Write "<H3>No Errors were found.</H3>"
		
		Set objRE = Nothing
	End Sub
End if
%>
