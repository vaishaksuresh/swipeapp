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

			<script language="javascript">

			function getDocHeight() {
				var D = document;
				return Math.max(
					Math.max(D.body.scrollHeight, D.documentElement.scrollHeight),
					Math.max(D.body.offsetHeight, D.documentElement.offsetHeight),
					Math.max(D.body.clientHeight, D.documentElement.clientHeight)
					);
			}
			var isOpen = false;
			function doOverlayOpen() {
				isOpen = true;
				showOverlayBox();
				$('.bgCover').css({
					height: getDocHeight(),
					opacity: 0
				}).animate({
					opacity: 0.5,
					backgroundColor: '#000'
				});
				return false;
			}
			function doOverlayClose() {
				alert("Closing");
				isOpen = false;
				$('.divoverlayBox').css('display', 'none');
				$('.bgCover').animate({
					opacity: 0
				}, null, null, function() {
					$(this).hide();
				});
				return false;
			}
			function showOverlayBox() {
				if (isOpen === false) {
					return;
				}
				$('.divoverlayBox').css({
					//position: 'fixed',
					display: 'block'
				});
				$('.bgCover').css({
					display: 'block',
					width: $(window).width(),
					height: getDocHeight()	
				});
			}
			$(window).bind('resize', showOverlayBox);
			
			$('#closeLink').click(function(e){
				e.preventDefault();
				doOverlayClose();
			});

			$(document).ready(function(){

				if($(window).width()>800){
					$("#eventboxol").load('adminlogin.cfm #inputarea', function(response, status, xhr) {
						if (status != "error") {
							$("#eventboxol #inputarea").css({
								margin: '0 10%'
							});
							doOverlayOpen();
						}else{
							alert(errorMessage);
						}
					});
					$(window).on('resize',function(){
						showOverlayBox();
					});
				}

			});
			</script>
		</head>
		<body>
			<div class="bgCover">&nbsp;</div>
			<!--- <div class="divoverlayBox" style="top:29%;left:30%;width:500px;"> --->
			<div class="divoverlayBox">
				<div class="overlayContent">
					<div id="eventboxol"> </div>
				</div>
			</div>
			<cfif #isDefined("session.isadmin")# AND #session.isadmin# eq "true">
				<cflocation url="swipelogin.cfm" addtoken="false"/>
			</cfif>
			<header>
				<a href="/"><img src="./images/logo.jpg" alt="AS Logo" /></a>
				<p>Cesar E. Chavez Community Action Center</p>
				<nav id="topnav">
				</nav>
			</header>
			<div id="spinner" class="spinner" style="display:none;">
				<img id="img-spinner" src="./images/spinner.gif" alt="Loading"/>
			</div>
			<section id="pages" class="group">
				<div id="loadcontent" class="group">
					<nav id="tabs">
					</nav>
					<section class="sectionlist show" id="inputarea">
						<h2>Admin Sign In</h2>
						<p>Please enter your pin</p>
						<form name="adminsignin" id="adminsignin" action="swipelogin.cfm" method="POST">
							<input type="password" class="rounded" name="adminpin" id="adminpin" placeholder="Enter PIN" title="PIN" required="required">
							<br /><br />
							<input type="submit" value="Sign In" name="adminpinbutton" id="adminpinbutton">
						</form><br />
					</section>
				</div>
			</section>
			<footer class="group">
				<p></p>
				<nav id="bottomnav">
				</nav>
			</footer>
			<script src="_/js/functions.js"></script>
		</body>
		</html>