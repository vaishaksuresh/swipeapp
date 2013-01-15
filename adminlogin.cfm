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
		<link rel="stylesheet" href="_/css/style.css">
		<script src="_/js/modernizr-1.7.min.js"></script>
		<link href='http://fonts.googleapis.com/css?family=Leckerli+One|Rokkitt:700,400|Luckiest+Guy' rel='stylesheet' type='text/css'>

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
				<cflocation url="updateprofile.cfm" addtoken="no" />
			</cfif>
			<header>
				<a href="/"><img src="./images/logo.jpg" alt="Mexsantos Logo" /></a>
				<p>Cesar E. Chavez Community Action Center</p>
				<nav id="topnav">
						<!-- <ul>
							<li><a href="/cf/vaishak">Home</a></li>
							<li ><a id="profilelink" href="updateprofilechange.cfm">Profile</a></li>
							<li id="logoutlink"><a href="logout.cfm">Logout</a></li>
						</ul> -->
					</nav>
				</header>
				<div id="spinner" class="spinner" style="display:none;">
					<img id="img-spinner" src="./images/spinner.gif" alt="Loading"/>
				</div>
				<section id="pages" class="group">
					<div id="loadcontent" class="group">
						<nav id="tabs">
							<ul>
								<li class="tapped" id="tabhome">Home</li>
								<li  id="tabupdateprofile">Profile</li>
							</ul>
						</nav>
						<section class="sectionlist show" id="inputarea">
							<h2>Sign In</h2>
							<p>Please Swipe Card</p>
							<cfform name="adminsignin" action="updateprofile.cfm">
								<input type="text" class="rounded" name="studentid" id="studentid" placeholder="Student ID" required="required">
								<br /><br />
								<input type="hidden" name="signinmethod" id="signinmethod" value="swipe">
								<input type="submit" value="Sign In" name="signin" id="adminsigninbutton">
								<input type="button" value="Manual Login" name="manualsignin" id="manualsigninbutton">
							</cfform><br />
						</section> <!-- Appetizers -->

					</div> <!-- Load Content -->
				</section> <!-- Pages-->
				<footer class="group">
					<p></p>
					<nav id="bottomnav">
					</nav>
				</footer>

				<script src="//ajax.googleapis.com/ajax/libs/jquery/1.5.1/jquery.min.js"></script>
				<script>window.jQuery || document.write("<script src='_/js/jquery-1.5.1.min.js'>\x3C/script>")</script>
				<script src="_/js/functions.js"></script>
			</body>
			</html>