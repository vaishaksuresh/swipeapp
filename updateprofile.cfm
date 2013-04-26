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
<link rel="stylesheet" href="/cf/vaishak/_/css/style.css">
<link href='http://fonts.googleapis.com/css?family=Leckerli+One|Rokkitt:700,400|Luckiest+Guy' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css" />
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
<script src="/cf/vaishak/_/js/modernizr-1.7.min.js"></script>
<script src="http://code.jquery.com/jquery-1.8.3.js"></script>
<script src="http://code.jquery.com/ui/1.9.2/jquery-ui.js"></script>
<script src="/cf/vaishak/_/js/functions.js"></script>
<cfapplication sessionmanagement="yes" sessiontimeout="#CreateTimeSpan(0,0,30,0)#">
<cfinclude template="messages.cfm">
<script src="/cf/vaishak/_/js/ui.dropdownchecklist-1.4-min.js"></script>
<link rel="stylesheet" href="/cf/vaishak/_/css/ui.dropdownchecklist.standalone.css">
<style>
.ui-multiselect ui-widget ui-state-default ui-corner-all {
    padding: 3px 8px;
	font-size: 20px;
	width: 280px;
	-moz-border-radius: 10px;
	-webkit-border-radius: 10px;
	border-radius: 10px;
}
</style>
</head>
<body>
<div id="user_session_box"> Hi
  <cfif #StructKeyExists(session,"user")#>
    <cfoutput>#listFirst(session.user," ")#!</cfoutput>
  </cfif>
  <input type='button' value='Logout' class='logout_button' id='logout_button'>
</div>
<div id="header"> </div>
<section id="pages" class="group">
  <div id="loadcontent" class="group">
    <section class="sectionlist show" id="formarea">
      <cfif cgi.request_method eq 'post'>
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
        <cfset session.loggedin = "false">
        <cfif #StructKeyExists(session,"eventid")#>
          <cfset eventid = #session.eventid#>
          <cfelse>
          <cfset eventid = "0">
        </cfif>
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
                <cfset session.message = #genericexception#>
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
              <cfset session.message=#idnotpresent#>
              <cflocation url="index.cfm" addtoken="no">
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
              <cfset session.loggedin = "true">
              <cftry>
                <!--- Inserting a new record for the login activity --->
                <cfquery name="insertLoginDataInDB" datasource="cccac_swipe">
                    INSERT INTO login_activity (student_id,login_mode,event_id) values('#form.studentid#','#form.signinmethod#',#Int(eventid)#)
                  </cfquery>
                <cfcatch type = "Database">
                  <cfoutput>
                    <cfset session.message = #genericexception#>
                  </cfoutput>
                </cfcatch>
              </cftry>
            </cfif>
            <cfcatch type="any">
              <cfset session.message=#genericexception#>
              <cflocation url="index.cfm" addtoken="no">
            </cfcatch>
          </cftry>
          <cfelse>
          <!--- If the user has swiped, then there is no password associated with the login. Authentication not required since the card is present.--->
          <!---          <cfset  ValidationStatus="1"/>--->
          <!--- Simply login the user with a fake password. --->
          <cfloginuser name="#form.studentid#" password="fakepassword" roles="user" />
          <cftry>
            <!--- Inserting a new record for the login activity --->
            <cfquery name="insertLoginDataInDB" datasource="cccac_swipe">
    INSERT INTO login_activity (student_id,login_mode,event_id) values('#form.studentid#','#form.signinmethod#','#eventid#')
  </cfquery>
            <cfset session.loggedin = "true">
            <cfcatch type = "Database">
              <cfoutput>
                <cfset session.message = #genericexception#>
              </cfoutput>
            </cfcatch>
          </cftry>
        </cfif>
        </cflogin>
      </cfif>
      <!---<cfif #IsUserLoggedIn()# eq 'YES'>--->
      <cfif #structKeyExists(session,'user')# AND #session.loggedin# eq 'true'>
      
        <p>Update or review your profile information</p>
        <div id="message_green">
          <cfif #isDefined("session.message")#>
            <cfoutput> #session.message#</cfoutput>
            <cfset #session.message# = "" />
          </cfif>
        </div>
        <br>
        <div id="message_box">
          <cfif #isDefined("session.message")#>
            <cfoutput> #session.message#</cfoutput>
            <cfset #session.message# = "" />
          </cfif>
        </div>
        <form name="updateprofile" id="updateprofile" action="updateprofile.cfm1">
          <input type="hidden" name="name" id="studentname" value="<cfoutput>#session.user#</cfoutput>" />
          <input type="text" class="rounded" name="email" id="email" placeholder="Email ID" title="Email Address" maxlength="50" value="<cfoutput>#session.email#</cfoutput>"/>
          <br />
          <br />
          <input type="text" class="rounded" name="phone" id="phone" title="Phone Number" maxlength="12" placeholder="Phone Number" value="<cfoutput>#session.phone#</cfoutput>"/>
          <br />
          <br />
          <input type="text" class="rounded" name="major" id="major" title="Major" placeholder="Major" maxlength="20" value="<cfoutput>#session.major#</cfoutput>"/>
          <br />
          <br />
          <select class="rounded" name="year" id = "yearinschool" title="Year In School">
            <option value = "" selcted="selected">Select Year</option>
            <option value = "freshman" <cfif #session.yearinschool# eq 'freshman'>selected='selected'</cfif>>Freshman</option>
            <option value = "sophomore" <cfif #session.yearinschool# eq 'sophomore'>selected='selected'</cfif>>Sophomore</option>
            <option value = "junior" <cfif #session.yearinschool# eq 'sophomore'>selected='selected'</cfif>>Junior</option>
            <option value = "senior" <cfif #session.yearinschool# eq 'senior'>selected='selected'</cfif>>Senior</option>
            <option value = "graduate" <cfif #session.yearinschool# eq 'graduate'>selected='selected'</cfif>>Graduate Student</option>
          </select>
          <br />
          <br />
          <select class="rounded" name="areaofinterest" id = "areaofinterest" title="Area of Interest" multiple="multiple">
            <option value = "fe" <cfif #FindNoCase("fe",session.area_of_interest)# gt 0>selected='selected'</cfif>>FE</option>
            <option value = "strive" <cfif #FindNoCase("strive",session.area_of_interest)# gt 0>selected='selected'</cfif>>Strive</option>
            <option value = "legacytours" <cfif #FindNoCase("legacytours",session.area_of_interest)# gt 0>selected='selected'</cfif>>Legacy Tours</option>
            <option value = "volunteer" <cfif #FindNoCase("volunteer",session.area_of_interest)# gt 0>selected='selected'</cfif>>Volunteer</option>
            <option value = "workshops" <cfif #FindNoCase("workshops",session.area_of_interest)# gt 0>selected='selected'</cfif>>Workshops</option>
            <option value = "others" <cfif #FindNoCase("others",session.area_of_interest)# gt 0>selected='selected'</cfif>>Other</option>
          </select>
          <br />
          <br />
          <input type="text" class="rounded" name="otherinterest" id="otherinterest" title="Other Intestest" placeholder="Others"
    value="<cfoutput>#session.other_interest#</cfoutput>" <cfif #FindNoCase("others",session.area_of_interest)# lte 0>style='display:none;'</cfif>/>
          <div id="subscribe_box">
            <input type="checkbox" name="newslettercheckbox" id="subscription" value="1" <cfif #session.newslettercheckbox# eq 1>checked='yes'</cfif> />
            Subscribe to the newsletter</div>
          <!---<div class="blue_button" id="updateprofilebutton">Update</div>--->
          <input type="button" id="updateprofilebutton" class="blue_button" value="Update">
        </form>

        <cfelse>
        <cfif cgi.request_method Eq 'post'>
          <cfset session.message = #invalidcredentials#>
          <cfset session.studentid = #form.studentid# />
          <cfelse>
          <cfset session.message = #sessionexpired#>
        </cfif>
        <cfset session.loggedin = "false"/>
        <CFLOCATION URL="/cf/vaishak/index.cfm" ADDTOKEN="no"/>
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
</body>
</html>