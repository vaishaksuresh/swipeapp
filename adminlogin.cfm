<!doctype html>
<!--[if lt IE 7 ]> <html class="ie ie6 no-js" lang="en"> <![endif]-->
<!--[if IE 7 ]>    <html class="ie ie7 no-js" lang="en"> <![endif]-->
<!--[if IE 8 ]>    <html class="ie ie8 no-js" lang="en"> <![endif]-->
<!--[if IE 9 ]>    <html class="ie ie9 no-js" lang="en"> <![endif]-->
<!--[if gt IE 9]><!--><html class="no-js" lang="en"><!--<![endif]-->
<!-- the "no-js" class is for Modernizr. -->
<head id="swipeapp" data-template-set="html5-reset">
<!--- <cfhtmlhead text='id="swipeapp" data-template-set="html5-reset"' /> --->
<meta charset="utf-8">
<!-- Always force latest IE rendering engine (even in intranet) & Chrome Frame -->
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
<title>C.C.A.C Swipe Application</title>
<meta name="viewport" content="width=device-width, maximum-scale=1.0" />
<link rel="stylesheet" href="/cf/vaishak/_/css/style.css">
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
<link rel="stylesheet" href="/cf/vaishak/_/css/tablet.css" media="(min-device-width:768px) and (max-device-width:1024px) " />
<!-- Target Galaxy Tab -->
<link rel="stylesheet" href="/cf/vaishak/_/css/tablet.css" media="(min-width:590px) and (max-width:1025px)" />
<link rel="stylesheet" href="/cf/vaishak/_/css/tablet.css" media="(min-width:800px) and (max-width:800px)" />
<cfapplication sessionmanagement="yes" sessiontimeout="#CreateTimeSpan(0,0,30,0)#">
</head>
<body>
<cfinclude template="messages.cfm">
<div id="user_session_box">
  <!--- Hello Admin | <a href="/cf/vaishak/logout.cfm"><b>Logout</b></a> --->
</div>
<cfif #IsUserLoggedIn()# eq 'YES'>
  <cflocation url="/cf/vaishak/updateprofile.cfm" addtoken="no" />
</cfif>
<div class="bgCover">&nbsp;</div>
<cfif #isDefined("session.isadmin")# AND #session.isadmin# eq "true">
  <cflocation url="/cf/vaishak/swipelogin.cfm" addtoken="false"/>
</cfif>
<div id="header"> </div>
<div id="spinner" class="spinner" style="display:none;"> <img id="img-spinner" src="/cf/vaishak/images/spinner.gif" alt="Loading"/> </div>
<section id="pages" class="group">
  <div id="loadcontent" class="group">
    <nav id="tabs"> </nav>
    <section class="sectionlist show" id="inputarea">
      <h2>Admin Sign In</h2>
      <p>Please enter your pin</p>
      <div id="message_box">
        <cfif #isDefined("session.message")#>
          <cfoutput> #session.message#</cfoutput>
          <cfset #session.message# = "" />
        </cfif>
      </div>
      <form name="adminsignin" id="adminsignin" action="#" method="POST">
        <input type="password" class="rounded_login" name="adminpin" id="adminpin" placeholder="Enter PIN" title="PIN" required="required">
        <br />
        <br />
        <input type="checkbox" name="event" id="eventradio">
        Select or Add Event <br />
        <br />
        <div class="event_box" id="event_border_box" style="display:none;">
        <cfinvoke component="cfcomponents.utilComponent" method="getEventsForToday" returnvariable="eventsList"> </cfinvoke>
        <cfif #eventsList.RecordCount# gt 0>
          <select name="chosenEventId" class="rounded" id="eventnameSelect" style="display:none;text-align:center">
	          <option value="">Select an Event</option>
            <cfloop query="eventsList">
              <option value="<cfoutput>#eventsList.event_id#</cfoutput>"><cfoutput>#eventsList.event_name#</cfoutput></option>
            </cfloop>
          </select>
          <p id="ortext" style="display:none;">OR</p>
        </cfif>
        <input type="text" class="rounded_login" name="eventname" id="eventname" placeholder="Add A New Event" style="display:none;">
        <br />
        </div>
        <!---<div id="adminpinbutton" name="adminpinbutton" class="blue_button">Sign In</div>--->
        <input type="button" class="blue_button" id="adminpinbutton" value="Sign In">
      </form>
      <br />
    </section>
  </div>
</section>
<footer class="group">
  <p></p>
  <nav id="bottomnav"> </nav>
</footer>
<script src="/cf/vaishak/_/js/functions.js"></script>
</body>
</html>