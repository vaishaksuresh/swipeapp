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
    <link rel="stylesheet" href="_/css/style.css">
    <script src="_/js/modernizr-1.7.min.js"></script>
    <link href='http://fonts.googleapis.com/css?family=Leckerli+One|Rokkitt:700,400|Luckiest+Guy' rel='stylesheet' type='text/css'>
 
    <script src="http://code.jquery.com/jquery-1.8.3.js"></script>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css" />
    <script src="http://code.jquery.com/ui/1.9.2/jquery-ui.js"></script>
    
    <!-- Stylesheets -->
    <link rel="stylesheet" href="./_/css/style.css" />
    <link rel="stylesheet" href="./_/css/desktop.css" />
    <!-- Target iPhone -->
    <link rel="stylesheet" href="./_/css/handheld.css" media="(max-device-width:480px)" />
    <!-- Target iPad -->
    <link rel="stylesheet" href="./_/css/tablet.css" media="(min-device-width:768px) and (max-device-width:1024px)" />
    <!-- Target Galaxy Tab -->
    <link rel="stylesheet" href="./_/css/tablet.css" media="(min-width:1280px) and (max-width:1280px)" />
    <link rel="stylesheet" href="./_/css/tablet.css" media="(min-width:800px) and (max-width:800px)" />
    <cfapplication sessionmanagement="yes" sessiontimeout="#CreateTimeSpan(0,0,30,0)#">
    </head>
    <body>
      <header> <a href="/"><img src="./images/logo.jpg" alt="Mexsantos Logo" /></a>
      <p>Cesar E. Chavez Community Action Center</p>
      <nav id="topnav">
    <!---    <ul>
          <li><a href="/cf/vaishak">Home</a></li>
          <li ><a id="profilelink" href="updateprofilechange.cfm">Profile</a></li>
          <li id="logoutlink"><a href="logout.cfm">Logout</a></li>
        </ul> --->
      </nav>
    </header>
    <section id="pages" class="group">
      <div id="loadcontent" class="group">
        <nav id="tabs">
      <!--- <ul>
            <li  id="tabhome">Home</li>
            <li class="tapped" id="tabupdateprofile">Profile</li>
          </ul> --->
        </nav>
        <section class="sectionlist show" id="formarea">
          <cfif cgi.request_method Eq 'post'>
            <cfset session.user = "" />
            <cfset session.studentid = "" />
            <cfset session.email = "" />
            <cfset session.phone = "" />
            <cfset session.major = "" />
            <cfset session.year = "" />
            <cftry>
              <cfinvoke component="cfcomponents.utilComponent" method="getStudentDetails" returnvariable="name">
              <cfinvokeargument name="studentID" value="#form.studentid#"/>
            </cfinvoke>
            <cfset session.user=#listFirst(name,'$$')#>
            <cfset session.studentid = #form.studentid# />
            <cfset session.email = #listLast(name,'$$')# />
            <cfset session.signinmethod = #form.signinmethod# />
            <cfcatch type="any" >
            <cfoutput>"Error"</cfoutput>
          </cfcatch>
        </cftry>
        <cfset  ValidationStatus=""/>
        <cflogin idletimeout="30">
        <cfif #form.signinmethod# eq 'manual'>
          <cftry>
            <cfinvoke component="cfcomponents.utilComponent" method="validateUser" returnvariable="ValidationStatus">
            <cfinvokeargument name="studentID" value="#form.studentid#"/>
            <cfinvokeargument name="studentName" value="#session.user#"/>
            <cfinvokeargument name="studentPassword" value="#form.studentpassword#"/>
          </cfinvoke>
          <cfif #ValidationStatus# eq '1'>
            <cfloginuser name="#form.studentid#" password="#session.user#" roles="user" />
          </cfif>
          <cfcatch type="any">
          <cfoutput>"Error, Could Not Sign In"</cfoutput>
        </cfcatch>
      </cftry>
      <cfelse>
        <cfset  ValidationStatus="1"/>
        <cfloginuser name="#form.studentid#" password="fakepassword" roles="user" />
      </cfif>
    </cflogin>
  </cfif>
  <cfif #IsUserLoggedIn()# eq 'YES'>
    <h2>Greetings <cfoutput>, #session.user#</cfoutput></h2>
    <p>Review or Update your profile information</p>
    <form name="updateprofile" action="updateprofile.cfm">
      <input type="text" class="rounded" name="name" placeholder="Name" title="Name" value="<cfoutput>#session.user#</cfoutput>"/>
      <br />
      <br />
      <!--- <input type="text" class="rounded" name="studentid" placeholder="Student ID" value="<cfoutput>#session.studentid#</cfoutput>"/> --->
      <input type="text" class="rounded" name="email" placeholder="Email ID" title="Email Address" value="<cfoutput>#session.email#</cfoutput>"/>
      <br />
      <br />
      <input type="text" class="rounded" name="phone" title="Phone Number" placeholder="Phone Number"/>
      <br />
      <br />
      <input type="text" class="rounded" name="major" title="Major" placeholder="Major"/>
      <br />
      <br />
      <input type="text" class="rounded" name="year" title="Year In School" placeholder="Year"/>
      <br />
      <br />
      <select class="rounded" id = "areaofinterest" title="Area of Interest">
        <option value = "selectone" selcted="selected">Select Area of Interest</option>
        <option value = "fe">FE</option>
        <option value = "strive">Strive</option>
        <option value = "legacytours">Legacy Tours</option>
        <option value = "volunteer">Volunteer</option>
        <option value = "workshops">Workshops</option>
        <option value = "Others">Others</option>
      </select>
      <br />
      <br />
      <input type="checkbox" name="newsletter" value="subscribe" checked="yes"/>
      Subscribe to the newsletter <br />
      <br />
      <input type="submit"  value="Update" name="updateprofile"/>
      <input type="button"  value="Logout" name="logoutbutton" onClick="javascript:window.location.href='logout.cfm'" />
    </form>
    <cfelse>
      <p>Entered Student ID and Password combination is invalid, please correct and login again.</p>
    </cfif>
  </section>
  <!-- Appetizers -->
  <section class="sectionlist hide" id="sides"> </section>
  <!-- Sides -->
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
<script src="_/js/functions.js"></script>
</body>
</html>