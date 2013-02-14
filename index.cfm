<!doctype html>
<!--[if lt IE 7 ]> <html class="ie ie6 no-js" lang="en"> <![endif]-->
<!--[if IE 7 ]>    <html class="ie ie7 no-js" lang="en"> <![endif]-->
<!--[if IE 8 ]>    <html class="ie ie8 no-js" lang="en"> <![endif]-->
<!--[if IE 9 ]>    <html class="ie ie9 no-js" lang="en"> <![endif]-->
<!--[if gt IE 9]><!--><html class="no-js" lang="en"><!--<![endif]-->
<!-- the "no-js" class is for Modernizr. -->
<head id="swipeapp" data-template-set="html5-reset">
<meta charset="utf-8">
<!-- Always force latest IE rendering engine (even in intranet) & Chrome Frame -->
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
<title>C.C.A.C Swipe Application</title>
<meta name="viewport" content="width=device-width, maximum-scale=1.0" />
<script src="/cf/vaishak/_/js/modernizr-1.7.min.js"></script>
<link href='http://fonts.googleapis.com/css?family=Leckerli+One|Rokkitt:700,400|Luckiest+Guy' rel='stylesheet' type='text/css'>
<script src="http://code.jquery.com/jquery-1.8.3.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css" />
<script src="http://code.jquery.com/ui/1.9.2/jquery-ui.js"></script>
<!-- Stylesheets -->
<link rel="stylesheet" href="/cf/vaishak/_/css/style.css" />
<link rel="stylesheet" href="/cf/vaishak/_/css/desktop.css" />
<!-- Target iPad -->
<link rel="stylesheet" href="/cf/vaishak/_/css/tablet.css" media="(min-device-width:768px) and (max-device-width:1024px)" />
<!-- Target Galaxy Tab -->
<link rel="stylesheet" href="/cf/vaishak/_/css/tablet.css" media="(min-width:590px) and (max-width:1024px)" />
<link rel="stylesheet" href="/cf/vaishak/_/css/tablet.css" media="(min-width:800px) and (max-width:800px)" />
<!-- Target iPhone -->
<link rel="stylesheet" href="/cf/vaishak/_/css/handheld.css" media="(min-device-width:320px) and (max-device-width:480px)" />
<cfapplication sessionmanagement="yes" sessiontimeout="#CreateTimeSpan(0,0,30,0)#">
</head>
<body>
<div id="user_session_box"><!--- Hello Admin | <a href="/cf/vaishak/logout.cfm"><b>Logout</b></a> ---></div>
<cfif #IsUserLoggedIn()# eq 'YES'>
  <cflocation url="/cf/vaishak/updateprofile.cfm" addtoken="no" />
</cfif>
</br>
</br>
<div id="header"></br>
  <p>Cesar E. Chavez Community Action Center</p>
</div>
<div id="spinner" class="spinner" style="display:none;"> <img id="img-spinner" src="/cf/vaishak/images/spinner.gif" alt="Loading"/> </div>
<section id="pages" class="group">
  <div id="loadcontent" class="group">
    <section class="sectionlist show" id="inputarea">
      <p>Please Enter Student ID and SJSU One Password</p>
      <cfif #isDefined("session.message")#>
        <cfoutput> #session.message#</cfoutput>
        <cfset #session.message# = "" />
      </cfif>
      <div id="signinpagemessages" style="display:none;"></div>
      <form name="signinform" id="signinform" action="#" method="POST">
        <input type="text" class="rounded_login" name="studentid" id="studentid" placeholder="Student ID" required="required" maxlength="9 ">
        <br />
        <br />
        <input type="password" class="rounded_login" name="studentpassword" id="studentpassword" placeholder="SJSU One Password" required="required" tooltip="Password">
        <br />
        <br />
        <input type="hidden" name="signinmethod" id="signinmethod" value="manual">
        <!--- <input type="submit" value="Sign In" name="signin" id="signinbutton"> --->
        <!--- <img src="/cf/vaishak/images/login.png" name="signinbutton" id="signinbutton" > --->
        <div id="signinbutton">Sign In</div>
      </form>
      <br />
    </section>
  </div>
  <!-- Load Content -->
</section>
<!-- Pages-->
<footer class="group">
  <p></p>
  <nav id="bottomnav"> </nav>
</footer>
<script src="/cf/vaishak/_/js/functions.js"></script>
</body>
</html>