<cffunction name="getStudentDetails" access="public" returntype="string">
    <cfargument name="studentID" type="string" required="yes">
    <cfldap action="query" name="results" start="ou=sjsupeople,dc=sjsuad,dc=sjsu,dc=edu" 
    attributes="cn,samaccountname,mail,dn,mobile,ou" server="130.65.3.134" port="636" password="def678AD" 
    username="cn=phpldap2,ou=users,ou=administration,dc=sjsuad,dc=sjsu,dc=edu" secure="CFSSL_BASIC" filter="samaccountname=#studentID#">
    <cfset myResult=" $$ ">
    <cfoutput query = "results">
      <cfset myResult=#ou#>
    </cfoutput>
    <cfreturn myResult>
  </cffunction>

  <cfinvoke method="getStudentDetails" returnvariable="name">
      <!--- <cfinvokeargument name="studentID" value="008663109"/> --->
      <cfinvokeargument name="studentID" value="008646235"/>
  </cfinvoke>
  <cfoutput>#name#</cfoutput>