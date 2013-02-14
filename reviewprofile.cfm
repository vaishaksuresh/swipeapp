<!doctype html>
  <!--[if lt IE 7 ]> <html class="ie ie6 no-js" lang="en"> <![endif]-->
  <!--[if IE 7 ]>    <html class="ie ie7 no-js" lang="en"> <![endif]-->
  <!--[if IE 8 ]>    <html class="ie ie8 no-js" lang="en"> <![endif]-->
  <!--[if IE 9 ]>    <html class="ie ie9 no-js" lang="en"> <![endif]-->
  <!--[if gt IE 9]><!--><html class="no-js" lang="en"><!--<![endif]-->
  <!-- the "no-js" class is for Modernizr. -->
  <head id="swipeapp" data-template-set="html5-reset">
    <meta charset="utf-8">
    <cfcontent type="text/html; charset=utf-8">
    <!-- Always force latest IE rendering engine (even in intranet) & Chrome Frame -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
    <title>C.C.A.C Swipe Application</title>
    <meta name="viewport" content="width=device-width, maximum-scale=1.0" />
    <link rel="stylesheet" href="/cf/vaishak_/css/style.css">
    <script src="/cf/vaishak/_/js/modernizr-1.7.min.js"></script>
    <link href='http://fonts.googleapis.com/css?family=Leckerli+One|Rokkitt:700,400|Luckiest+Guy' rel='stylesheet' type='text/css'>
    <script src="http://code.jquery.com/jquery-1.8.3.js"></script>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css" />
    <script src="http://code.jquery.com/ui/1.9.2/jquery-ui.js"></script>
    <!-- Stylesheets -->
    <link rel="stylesheet" href="/cf/vaishak/_/css/style.css" />
    <link rel="stylesheet" href="/cf/vaishak/_/css/desktop.css" />
    <!-- Target iPhone -->
    <link rel="stylesheet" href="/cf/vaishak/_/css/handheld.css" media="(max-device-width:480px)" />
    <!-- Target iPad -->
    <link rel="stylesheet" href="/cf/vaishak/_/css/tablet.css" media="(min-device-width:768px) and (max-device-width:1024px)" />
    <!-- Target Galaxy Tab -->
    <link rel="stylesheet" href="/cf/vaishak/_/css/tablet.css" media="(min-width:1280px) and (max-width:1280px)" />
    <link rel="stylesheet" href="/cf/vaishak/_/css/tablet.css" media="(min-width:800px) and (max-width:800px)" />
    <cfapplication sessionmanagement="yes" sessiontimeout="#CreateTimeSpan(0,0,30,0)#">
    </head>
    <body>
    
    <div id="user_session_box">
        Hello Admin |      <a href="../controller/LogoutController.php"><b>Logout</b></a>
    </div>
      <header> <!--- <a href="/"><img src="/cf/vaishak/images/logo.jpg" alt="CCAC Logo" /></a> --->
      <p>Cesar E. Chavez Community Action Center</p>
      <nav id="topnav"> </nav>
    </header>
    <section id="pages" class="group">
      <div id="loadcontent" class="group">
        <nav id="tabs"> </nav>
        <section class="sectionlist show" id="formarea">
          <cfif cgi.request_method Eq 'post'>
            <cfset session.user = "" />
            <cfset session.studentid = "" />
            <cfset session.email = "" />
            <cfset session.phone = "" />
            <cfset session.major = "" />
            <cfset session.year = "" />
            <cfset session.yearinschool = "" />
            <cfset session.area_of_interest = "" />
            <cfset session.other_interest = "" />
            <cfset session.newslettercheckbox = ""/>
            <cfquery name="getUserFromDB" datasource="cccac_swipe" result="UserDetailsResult">
            Select * from ccac_registered_users WHERE student_id = #form.studentid#
          </cfquery>
          <!---Check if there is a user already--->
          <cfif #UserDetailsResult.recordcount# gt 0>
            <!--- If there is a user, get his details --->
            <cftry>
              <cfloop query="getUserFromDB">
                <cfset session.user = #name#/>
                <cfset session.studentid = #student_id# />
                <cfset session.email = #email# />
                <cfset session.phone = #phone_number# />
                <cfset session.major = #major# />
                <cfset session.yearinschool = #year_in_college# />
                <cfset session.area_of_interest = #area_of_interest# />
                <cfset session.other_interest = #area_of_interest_value# />
                <cfset total_login_count = #total_login_count#/>
                <cfset session.newslettercheckbox = #subscribed_to_newsletter#/>
                <cfset session.signinmethod = #form.signinmethod# />
              </cfloop>
              <!---Set a flag to indicate that there is a user in the database--->
              <cfset databaseRecordFound = true/>
              <cfset myDateTime = CreateODBCDateTime(#Now()#)>
              <!--- Updating the last login timestamp --->
              <cfquery name="updateUserInDB" datasource="cccac_swipe">
              UPDATE ccac_registered_users set last_login_date = #myDateTime#, total_login_count = #total_login_count#+1 WHERE student_id = #session.studentid#
            </cfquery>
            <cfcatch type = "Database">
            <cfoutput>
              <p>Following Error Occured while Querying/Updating ccac_registered_users #cfcatch.message#</p>
              <p>#cfcatch.detail# #cfcatch.Sql#</p>
            </cfoutput>
            <!---Set a flag to indicate that the user from the database could not be retrieved --->
            <cfset databaseRecordFound = false/>
          </cfcatch>
        </cftry>
        <cfelse>
          <!---Set a flag to indicate that there is no matching user in the database and the user needs to be registered --->
          <cfset databaseRecordFound = false/>
        </cfif>
        <!---IF the user is not found in the database, look up  the details in the LDAP --->
        <cfif #databaseRecordFound# eq false>
          <cftry>
            <cfinvoke component="cfcomponents.utilComponent" method="getStudentDetails" returnvariable="name">
            <cfinvokeargument name="studentID" value="#form.studentid#"/>
          </cfinvoke>
          <cfif #name# eq " $$ ">
            <cfthrow type="Database"/>
          </cfif>
          <cfset session.user=#listFirst(name,'$$')#>
          <cfset session.studentid = #form.studentid# />
          <cfset session.email = #listLast(name,'$$')# />
          <cfset session.signinmethod = #form.signinmethod# />
          <!---After querying the LDAP, insert the user's data into the database --->
          <cfquery name="registerUserInDB" datasource="cccac_swipe" >
          INSERT INTO `ccac_registered_users` (`student_id`, `email`, `name`, `phone_number`, `major`, `year_in_college`, `area_of_interest`, `subscribed_to_newsletter`, `signup_date`, `last_login_date`, `last_update_date`, `last_update_mode`, `total_login_count`, `isactive`) 
          VALUES ('#form.studentid#', '#session.email#', '#session.user#', '', '', '', NULL, 1, #Now()#, #Now()#, #Now()#, '#form.signinmethod#', 1, 1);
        </cfquery>
        <cfcatch type="any" >
        <cfoutput>Error: The student ID is not present. Please go <a href="/vaishak/FrontPage.jsp">back</a> and verify the student ID.</cfoutput>
        <cfabort>
      </cfcatch>
    </cftry>
  </cfif>
  <cfset  ValidationStatus=""/>
  <cflogin idletimeout="30">
  <!--- Once the details have been obtained, check if the user is trying to login or swipe. --->
  <cfif #form.signinmethod# eq 'manual'>
    <!---If it is a manual login (The user has supplied ID and password, authenticate and login the user against the LDAP --->
    <cftry>
      <cfinvoke component="cfcomponents.utilComponent" method="validateUser" returnvariable="ValidationStatus">
      <cfinvokeargument name="studentID" value="#form.studentid#"/>
      <cfinvokeargument name="studentName" value="#session.user#"/>
      <cfinvokeargument name="studentPassword" value="#form.studentpassword#"/>
    </cfinvoke>
    <cfif #ValidationStatus# eq '1'>
      <cfloginuser name="#form.studentid#" password="#session.user#" roles="user" />
      <cftry>
        <!--- Inserting a new record for the login activity --->
        <cfquery name="insertLoginDataInDB" datasource="cccac_swipe">
        INSERT INTO login_activity (student_id,login_mode) values(#form.studentid#,'#form.signinmethod#')
      </cfquery>
      <cfcatch type = "Database">
      <cfoutput>
        <p>#cfcatch.message#</p>
        <p>#cfcatch.detail#</p>
      </cfoutput>
    </cfcatch>
  </cftry>
</cfif>
<cfcatch type="any">
<cfoutput>"Error, Could Not Sign In: #session.user#"</cfoutput>
</cfcatch>
</cftry>
<cfelse>
  <!--- If the user has swiped, then there is no password associated with the login. Authentication not required since the card is present.--->
  <cfset  ValidationStatus="1"/>
  <!--- Simply login the user with a fake password. --->
  <cfloginuser name="#form.studentid#" password="fakepassword" roles="user" />
  <cftry>
    <!--- Inserting a new record for the login activity --->
    <cfquery name="insertLoginDataInDB" datasource="cccac_swipe">
    INSERT INTO login_activity (student_id,login_mode) values(#form.studentid#,'#form.signinmethod#')
  </cfquery>
  <cfcatch type = "Database">
  <cfoutput>
    <p>#cfcatch.message#</p>
    <p>#cfcatch.detail#</p>
  </cfoutput>
</cfcatch>
</cftry>
</cfif>
</cflogin>
</cfif>
<cfif #IsUserLoggedIn()# eq 'YES'>
  <h2>Greetings <cfoutput>, #session.user#</cfoutput></h2>
  <p>Review or Update your profile information</p>
  <cfif #isDefined("session.message")#>
    <cfoutput>
      <p>
        #session.message#</p></cfoutput>
        <cfset #session.message# = "" />
      </cfif>
      
      <div id="info_div">      
        <table id="rounded-corner">
          <thead>
            <tr>
              <th class="rounded-topleft" scope="col"></th>
              <th class="rounded-topright" scope="col"></th>
            </tr>
          </thead>
          <tfoot>
            <tr>
              <td class="rounded-foot-left">
                <em></em>
              </td>
              <td class="rounded-foot-right"> </td>
            </tr>
          </tfoot>
          <tbody>
            <tr>
              <td>Name</td>
              <td><cfoutput><cfif #session.user# neq ''>
              #session.user#<cfelse> - 
            </cfif></cfoutput></td>
          </tr>
          <tr>
            <td>Email</td>
            <td><cfoutput>#session.email#</cfoutput></td>
          </tr>
          <tr>
            <td>Phone</td>
            <td><cfoutput><cfif #session.phone# neq ''>
            #session.phone#<cfelse> - 
          </cfif></cfoutput></td>
        </tr>
        <tr>
          <td>Major</td>
          <td><cfoutput><cfif #session.major# neq ''>
          #session.major#<cfelse> - 
        </cfif>
      </cfoutput></td>
    </tr>
    <tr>
      <td>Year in school</td>
      <td><cfoutput><cfif #session.yearinschool# neq ''>
      #session.yearinschool#<cfelse> - 
    </cfif></cfoutput></td>
  </tr>
  <tr>
    <td>Area of Interest</td>
    <td><cfoutput><cfif #session.area_of_interest# neq ''>
    #session.area_of_interest#<cfelse> - 
  </cfif><cfif #session.other_interest# neq ''>
  , #session.other_interest# 
</cfif></cfoutput></td>
</tr>
</tbody>
</table>



</div>
<img src="/cf/vaishak/images/update.png" id="reviewUpdateButton">
<img id="logoutbutton" name="logoutbutton" src="/cf/vaishak/images/logout.png" onClick="javascript:window.location.href='/cf/vaishak/logout.cfm'"/>
<cfelse>
  <p>Entered Student ID and Password combination is invalid or the session has expired, please correct and <a href="/vaishak/FrontPage.jsp">login</a> again.</p>
</cfif>

</section>
</div>
<!-- Load Content -->
</section>
<!-- Pages-->
<footer class="group">
  <p></p>
  <nav id="bottomnav"> </nav>
</footer>
<!--- <script src="//ajax.googleapis.com/ajax/libs/jquery/1.5.1/jquery.min.js"></script>
<script>window.jQuery || document.write("<script src='_/js/jquery-1.5.1.min.js'>\x3C/script>")</script>--->
<script src="/cf/vaishak/_/js/functions.js"></script>
</body>
</html>