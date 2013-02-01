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
		<link rel="stylesheet" href="./_/css/tablet.css" media="(min-device-width:768px) and (max-device-width:1024px) " />

		<!-- Target Galaxy Tab -->
		<link rel="stylesheet" href="./_/css/tablet.css" media="(min-width:590px) and (max-width:1025px)" />
		<link rel="stylesheet" href="./_/css/tablet.css" media="(min-width:800px) and (max-width:800px)" />
		<cfapplication sessionmanagement="yes" sessiontimeout="#CreateTimeSpan(0,0,30,0)#">

		</head>
		<body>
			<cfif #IsUserLoggedIn()# eq 'YES'>
				<cflocation url="reviewprofile.cfm" addtoken="no" />
			</cfif>
			<header></br>
				<a href="/"><img src="./images/logo.jpg" alt="Mexsantos Logo" /></a>
				<p>Cesar E. Chavez Community Action Center</p>
			</header>
			<div id="spinner" class="spinner" style="display:none;">
				<img id="img-spinner" src="./images/spinner.gif" alt="Loading"/>
			</div>
			<section id="pages" class="group">
				<div id="loadcontent" class="group">
					<nav id="tabs">
					</nav>
					<section class="sectionlist show" id="inputarea">
						<h2>Sign In</h2>
						<p>Please Enter Student ID and SJSU One Password</p>
						<form name="signin" id="signin" action="reviewprofile.cfm">
							<input type="text" class="rounded" name="studentid" id="studentid" placeholder="Student ID" required="required" maxlength="9"><br /><br />
							<input type="password" class="rounded" name="studentpassword" id="studentpassword" placeholder="SJSU One Password" required="required"><br /><br />
							<input type="hidden" name="signinmethod" id="signinmethod" value="manual">
							<input type="submit" value="Sign In" name="signin" id="signinbutton">
						</form><br />
					</section>
				</div> <!-- Load Content -->
			</section> <!-- Pages-->
			<footer class="group">
				<p></p>
				<nav id="bottomnav">
				</nav>
			</footer>
				<!---<script src="//ajax.googleapis.com/ajax/libs/jquery/1.5.1/jquery.min.js"></script>
				<script>window.jQuery || document.write("<script src='_/js/jquery-1.5.1.min.js'>\x3C/script>")</script>--->
				<script src="_/js/functions.js"></script>
			</body>
			</html>