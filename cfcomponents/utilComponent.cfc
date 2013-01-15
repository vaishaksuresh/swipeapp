<cfcomponent>
  <!---Function to get Student Details --->
  <cffunction name="getStudentDetails" access="public" returntype="string">
    <cfargument name="studentID" type="string" required="yes">
    <cfldap action="query" name="results" start="ou=sjsupeople,dc=sjsuad,dc=sjsu,dc=edu" 
    attributes="cn,samaccountname,mail,dn,mobile" server="130.65.3.134" port="636" password="def678AD" 
    username="cn=phpldap2,ou=users,ou=administration,dc=sjsuad,dc=sjsu,dc=edu" secure="CFSSL_BASIC" filter="samaccountname=#studentID#">
    <cfset myResult=" $$ ">
    <cfoutput query = "results">
      <cfset myResult=#cn#&"$$"&#mail#>
    </cfoutput>
    <cfreturn myResult>
  </cffunction>

  <!---Function to validate a user--->
  <cffunction name="validateUser" access="public" returntype="string">
    <cfargument name="studentID" type="string" required="yes">
    <cfargument name="studentName" type="string" required="yes">
    <cfargument name="studentPassword" type="string" required="yes">
    <cfset myResult="Not Validated">
    <cftry>
      <cfldap action="query" name="results" start="ou=sjsupeople,dc=sjsuad,dc=sjsu,dc=edu" 
      attributes="cn,samaccountname,mail,dn,mobile" server="130.65.3.134" port="636" password="#studentPassword#" 
      username="CN=#studentName#, OU=Employees, ou=sjsupeople, dc=sjsuad, dc=sjsu, dc=edu" secure="CFSSL_BASIC" filter="samaccountname=#studentID#">
        <cfoutput query = "results">
          <cfset myResult=#results.recordCount#>
        </cfoutput>
        <cfcatch type="any">
        <cfset myResult="Not Validated">
      </cfcatch>
    </cftry>
    <cfreturn myResult>
  </cffunction>
  </cfcomponent>
