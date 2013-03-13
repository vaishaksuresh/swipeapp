<cfset basicquery= "Select login_mode,count(login_mode) as total from login_activity,ccac_registered_users where login_activity.student_id=ccac_registered_users.student_id ">

<cfif #StructKeyExists(url,'studentid')# AND #url['studentid']# neq '' AND #url['studentid']# neq 'undefined'>
  <cfset basicquery = #basicquery#&"AND login_activity.student_id = '#studentid#' "  />
</cfif>
<cfif #StructKeyExists(url,'startDate')# AND #url['startDate']# neq '' AND #url['startDate']# neq 'undefined'>
  <cfset basicquery = #basicquery#&"AND login_date >= STR_TO_DATE('#DateFormat(CreateODBCDate(startDate),'mm/dd/yyyy')#','%m/%d/%Y')"  />
</cfif>
<cfif #StructKeyExists(url,'endDate')# AND #url['endDate']# neq '' AND #url['endDate']# neq 'undefined'>
  <cfset basicquery = #basicquery#&" AND login_date <= STR_TO_DATE('#DateFormat(CreateODBCDate(endDate),'mm/dd/yyyy')#','%m/%d/%Y') + INTERVAL 1 DAY "  />
</cfif>

<cfset basicquery = #basicquery#&" GROUP BY login_mode"/>
<cftry>
  <cfquery name="getAllUsers" datasource="cccac_swipe" result="UserDetailsResult">
  <cfoutput>#preserveSingleQuotes(basicquery)#</cfoutput>
</cfquery>
<cfcatch type="database">
<cfoutput>
  <p>Following Error Occured while Querying/Updating ccac_registered_users #cfcatch.message#</p>
  <p>#cfcatch.detail# #cfcatch.Sql#</p>
</cfoutput>
</cfcatch>
</cftry>
{
"cols": [
{"id":"","label":"SignIn Method","pattern":"","type":"string"},
{"id":"","label":"Count","pattern":"","type":"number"}
],
"rows": [
<cfloop query="getAllUsers">
 <cfif #getAllUsers.currentRow# neq #getAllUsers.RecordCount#>

   {"c":[{"v":<CFOUTPUT>"#getAllUsers.login_mode#"</CFOUTPUT>,"f":null},{"v":<CFOUTPUT>#getAllUsers.total#</CFOUTPUT>,"f":null}]},
   <cfelse>
    {"c":[{"v":<CFOUTPUT>"#getAllUsers.login_mode#"</CFOUTPUT>,"f":null},{"v":<CFOUTPUT>#getAllUsers.total#</CFOUTPUT>,"f":null}]}
  </cfif>
</cfloop>
]
}
