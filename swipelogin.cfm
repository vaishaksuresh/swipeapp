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
			<header>
				<a href="/"><img src="./images/logo.jpg" alt="Mexsantos Logo" /></a>
				<p>Cesar E. Chavez Community Action Center</p>
				<nav id="topnav">
				</nav>
			</header>
			<div id="spinner" class="spinner" style="display:none;">
				<img id="img-spinner" src="./images/spinner.gif" alt="Loading"/>
			</div>
			<section id="pages" class="group">
				<div id="loadcontent" class="group">
					<section class="sectionlist show" id="inputarea">
						<cfif (#isDefined("form.adminpin")# AND #form.adminpin# eq '123456') OR (#isDefined("session.isadmin")# AND #session.isadmin# eq "true")>
							<cfset session.isadmin = "true">
							<cfset session.signinmethod = "admin">
							<h2>Sign In</h2>
							<p>Please Swipe Card</p>
							<form name="swipesignin" id="swipesignin" method="POST">
								<input type="text" class="rounded" name="studentid" id="studentid" placeholder="Swipe Card" title="Swipe Card" required="required" readonly="readonly" >
								<br /><br />
								<input type="hidden" name="signinmethod" id="signinmethod" value="swipe">
								<input type="button" value="Sign In" name="signin" id="adminsigninbutton">
								<input type="button" value="Manual Login" name="manualsignin" id="manualsigninbutton">
								<input type="button"  value="Logout" name="logoutbutton" onClick="javascript:window.location.href='logout.cfm'" />
							</form><br />
							<cfelse>
								<CFLOCATION URL="adminlogin.cfm" ADDTOKEN="no" />
							</cfif>

						</section>
					</div>
				</section>
				<footer class="group">
					<p></p>
					<nav id="bottomnav">
					</nav>
				</footer>
				<script src="_/js/functions.js"></script>
				<script type="text/javascript" charset="utf-8" src="_/js/CardReader.js"></script>

				<script type="text/javascript">
				jQuery(function () {
					$('#studentid').focus();
					var reader = new CardReader();
					reader.observe(document);
					reader.cardError(function () {
						alert("A read error occurred");
					});
					reader.cardRead(function (value) {
						$('#studentid').val(value);
						$('#studentid').val($('#studentid').val().substr(0, 9));
						$('#adminsigninbutton').click();
					});

				});
				</script>
			</body>
			</html>