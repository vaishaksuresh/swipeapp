
<!--- <cfquery name="getAllUsers" datasource="cccac_swipe" result="UserDetailsResult">
Select login_mode,count(login_mode) as total from login_activity,ccac_registered_users where login_activity.student_id=ccac_registered_users.student_id GROUP BY login_mode
</cfquery>

<cfset data = [] />

<cfoutput query="getAllUsers">
 <cfset obj = {
  "cols" = login_mode,
  "rows" = total
  } />
  <cfset arrayAppend(data, obj) />
</cfoutput>

<cfprocessingdirective suppresswhitespace="Yes">
  <cfoutput>
    #serializeJSON(data)#
  </cfoutput>
</cfprocessingdirective>

<cfset jsondata = #serializeJSON(getAllUsers)#/>
	
<cfoutput>#jsondata#</cfoutput>
<cfoutput><br></cfoutput>
--->
<!---  {
  "cols": [
        {"id":"","label":"Topping","pattern":"","type":"string"},
        {"id":"","label":"Slices","pattern":"","type":"number"}
      ],
  "rows": [
        {"c":[{"v":"Mushrooms","f":null},{"v":3,"f":null}]},
        {"c":[{"v":"Onions","f":null},{"v":1,"f":null}]},
        {"c":[{"v":"Olives","f":null},{"v":1,"f":null}]},
        {"c":[{"v":"Zucchini","f":null},{"v":1,"f":null}]},
        {"c":[{"v":"Pepperoni","f":null},{"v":2,"f":null}]}
      ]
      } --->
      <cfset basicquery= "Select login_mode,count(login_mode) as total from login_activity,ccac_registered_users where login_activity.student_id=ccac_registered_users.student_id ">
      <cfif #StructKeyExists(url,'startDate')# AND #url['startDate']# neq ''>
        <cfset basicquery = #basicquery#&"AND login_date >= STR_TO_DATE('#DateFormat(CreateODBCDate(startDate),'mm/dd/yyyy')#','%m/%d/%Y')"  />
      </cfif>
      <cfif #StructKeyExists(url,'endDate')# AND #url['endDate']# neq ''>
        <cfset basicquery = #basicquery#&" AND login_date <= STR_TO_DATE('#DateFormat(CreateODBCDate(endDate),'mm/dd/yyyy')#','%m/%d/%Y') + INTERVAL 1 DAY "  />
      </cfif>

      <cfset basicquery = #basicquery#&" GROUP BY login_mode"/>
      <cfset sqlquery = "Select login_mode,count(login_mode) as total from login_activity,ccac_registered_users where login_activity.student_id=ccac_registered_users.student_id GROUP BY login_mode">
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
