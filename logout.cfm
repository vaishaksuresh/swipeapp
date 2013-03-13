<cfapplication sessionmanagement="yes" sessiontimeout="#CreateTimeSpan(0,0,30,0)#">

<cfif #StructKeyExists(session,"signinmethod")#>
  <cfset forwardpath = #session.signinmethod# />
  <cfoutput>#StructDelete(session,"user")#</cfoutput> <cfoutput>#StructDelete(session,"loggedin")#</cfoutput> <CFOUTPUT>#forwardpath#</CFOUTPUT>
  <cflogout >
  <cfcookie name="JSESSIONID" value="deleted" expires="NOW"/>
  <cfcookie name="CFID" value="deleted" expires="NOW"/>
  <cfcookie name="CFTOKEN" value="deleted" expires="NOW"/>
  <cfif #forwardpath# eq 'manual'>
  	<cfoutput>Manual Signout</cfoutput>
    <cflocation url="/vaishak/swpIndex.jsp" addtoken="no"/>
  <cfelseif #forwardpath# eq 'swipe' >
    <cfoutput>Swipe Signout</cfoutput>
    <cflocation url="/vaishak/swpAdmin.jsp" addtoken="no"/>
  <cfelse>
    <cfoutput>Else Signout</cfoutput>
    <cfset session.isadmin = "false">
    <cfset StructClear(Session)>
    <cflocation url="/vaishak/swpAdmin.jsp" addtoken="no"/>
  </cfif>
<cfelse>
	<cfoutput>Without Session Signout</cfoutput>
  <cflocation url="/vaishak/swpIndex.jsp" addtoken="no"/>
</cfif>
