<cfset basicquery= "Select distinct(login_activity.student_id) as studentid,name,count(login_activity.student_id) as logincount
from login_activity,ccac_registered_users 
where login_activity.student_id=ccac_registered_users.student_id ">
<cfif #StructKeyExists(url,'startDate')# AND #url['startDate']# neq ''>
  <cfset basicquery = #basicquery#&"AND login_date >= STR_TO_DATE('#DateFormat(CreateODBCDate(startDate),'mm/dd/yyyy')#','%m/%d/%Y')"  />
</cfif>
<cfif #StructKeyExists(url,'endDate')# AND #url['endDate']# neq ''>
  <cfset basicquery = #basicquery#&" AND login_date <= STR_TO_DATE('#DateFormat(CreateODBCDate(endDate),'mm/dd/yyyy')#','%m/%d/%Y') + INTERVAL 1 DAY "  />
</cfif>

<cfset basicquery = #basicquery#&" GROUP BY name,login_activity.student_id"/>
<cftry>
  <cfquery name="getSwipeDate" datasource="cccac_swipe" result="UserDetailsResult">
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
{"id":"","label":"Student ID","pattern":"","type":"string"},
{"id":"","label":"Name","pattern":"","type":"string"},
{"id":"","label":"Login Count","pattern":"","type":"string"}
],
"rows": [
<cfloop query="getSwipeDate">
 <cfif #getSwipeDate.currentRow# neq #getSwipeDate.RecordCount#>

   {"c":[{"v":<CFOUTPUT>"#getSwipeDate.studentid#"</CFOUTPUT>,"f":null},{"v":<CFOUTPUT>"#getSwipeDate.name#"</CFOUTPUT>,"f":null},{"v":<CFOUTPUT>"#getSwipeDate.logincount#"</CFOUTPUT>,"f":null}]},
   <cfelse>
    {"c":[{"v":<CFOUTPUT>"#getSwipeDate.studentid#"</CFOUTPUT>,"f":null},{"v":<CFOUTPUT>"#getSwipeDate.name#"</CFOUTPUT>,"f":null},{"v":<CFOUTPUT>"#getSwipeDate.logincount#"</CFOUTPUT>,"f":null}]}
  </cfif>
</cfloop>
]
}
