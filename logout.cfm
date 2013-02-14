<cfapplication sessionmanagement="yes" sessiontimeout="#CreateTimeSpan(0,0,30,0)#">
<cfset forwardpath = #session.signinmethod# />

<CFOUTPUT>#forwardpath#</CFOUTPUT>
<cflogout >
<cfcookie name="JSESSIONID" value="deleted" expires="NOW"/>
<cfcookie name="CFID" value="deleted" expires="NOW"/>
<cfcookie name="CFTOKEN" value="deleted" expires="NOW"/>
<cfif #forwardpath# eq 'manual'>
  <cfset session.isadmin = "false">
  <cflocation url="/vaishak/FrontPage.jsp" addtoken="no"/>
  <cfelseif #forwardpath# eq 'swipe' >
  <cflocation url="/vaishak/AdminFrontPage.jsp" addtoken="no"/>
  <cfelse>
  <cfset session.isadmin = "false">
  <cflocation url="/vaishak/AdminFrontPage.jsp" addtoken="no"/>
</cfif>
