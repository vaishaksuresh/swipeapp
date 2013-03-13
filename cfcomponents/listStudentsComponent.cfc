<cfcomponent>
<cffunction name="getStudents" access="remote" returntype="struct">
  <cfargument name="pageSize" required="true" />
  <cfargument name="pageNo" required="true" />
  <cfargument name="gridsortcolumn" required="true"  />
  <cfargument name="gridsortdirection" required="true"/>
  <cfif arguments.gridsortcolumn EQ "" OR arguments.gridsortcolumn EQ "undefined">
    <cfset arguments.gridsortcolumn = "student_id" />
  </cfif>
  <cftry>
    <cfset local.getAllUsers = queryNew("") />
    <cfquery name="getAllUsers" datasource="cccac_swipe">
    Select concat(' ',student_id)as student_id,email,name,phone_number,major,year_in_college,area_of_interest,area_of_interest_value,
	  signup_date,last_login_date,last_update_date,last_update_mode,total_login_count, case subscribed_to_newsletter
	  when 1 THEN 'Yes' ELSE 'No' END as 'NewsLetter'
	  from ccac_registered_users
      order by #gridsortcolumn# #arguments.gridsortdirection#
   </cfquery>
    <cfreturn queryConvertForGrid(local.getAllUsers, arguments.pageNo, arguments.pageSize) />
    <cfcatch type="database">
      <cfoutput>#cfcatch.Sql#</cfoutput>
    </cfcatch>
  </cftry>
</cffunction>
<cffunction name="getStudentsByEvents" access="remote" returntype="struct">
  <cfargument name="pageSize" required="true" />
  <cfargument name="pageNo" required="true" />
  <cfargument name="gridsortcolumn" required="true"  />
  <cfargument name="gridsortdirection" required="true"/>
  <cfif arguments.gridsortcolumn EQ "" OR arguments.gridsortcolumn EQ "undefined">
    <cfset arguments.gridsortcolumn = "event_date" />
  </cfif>
  <cftry>
    <cfset local.getAllUsersByEvents = queryNew("") />
    <cfquery name="getAllUsersByEvents" datasource="cccac_swipe">
    SELECT l.event_id as event_id,e.event_name as event_name,e.event_date as event_date, count(student_id) as total_logins FROM login_activity l INNER JOIN event_details e ON l.event_id = e.event_id
GROUP BY l.event_id order by #gridsortcolumn# #arguments.gridsortdirection#
   </cfquery>
    <cfreturn queryConvertForGrid(local.getAllUsersByEvents, arguments.pageNo, arguments.pageSize) />
    <cfcatch type="database">
      <cfoutput>#cfcatch.Sql#</cfoutput>
    </cfcatch>
  </cftry>
</cffunction>
</cfcomponent>
