<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>C.C.A.C Visitor Registration</title>
<link href="style.css" rel="stylesheet" type="text/css" />
<link href="http://fonts.googleapis.com/css?family=Corben:bold" rel="stylesheet" type="text/css">
<link href="http://fonts.googleapis.com/css?family=Nobile" rel="stylesheet" type="text/css">
<script src="/home_js/home_contents/jquery-1.8.2.js"></script>
<script src="javascript/PlaceholderJS/placeholder.js"></script>
</head>
<script language="javascript">
$(function() {

	$(document).ready(function() {
	   if( /Android|webOS|iPhone|iPad|iPod|BlackBerry/i.test(navigator.userAgent) ) {
 		alert("Mobile Device");
		}
		Placeholder.init({
    		wait: true
		})
		$("#studentid").focus();
	});
});
</script>
<body class="oneColElsCtrHdr">
<div id="container">
  <div id="header">
    <h1>C.C.A.C Visitor Registration</h1>
    <!-- end #header -->
  </div>
  <div id="mainContent">
  <a href="userDetails.cfm">008646222</a>
    <h3>Please Swipe Card or Enter Student ID</h3>
    <cfform name="signin" action="signin.cfm">
	<cfinput type="text" class="rounded" name="studentid" placeholder="Student ID"><br /><br />
    <cfinput type="submit" value="Sign In" name="signin">
    </cfform><br />
    <!-- end #mainContent -->
  </div>
  <div id="footer">
    <p></p>
    <!-- end #footer -->
  </div>
  <!-- end #container -->
</div>
</body>
</html>