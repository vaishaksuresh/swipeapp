<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Update Profile</title>
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
		});
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
    <cfldap action="query" name="results" start="ou=sjsupeople,dc=sjsuad,dc=sjsu,dc=edu" 
       attributes="cn,samaccountname,mail,dn,info" server="130.65.3.134" port="636" password="def678AD" 
       username="cn=phpldap2,ou=users,ou=administration,dc=sjsuad,dc=sjsu,dc=edu" secure="CFSSL_BASIC" filter="samaccountname=008646222">
    <cfoutput>#results.recordCount# matches found </cfoutput> <cfoutput>#results.columnlist# is the ColumnList</cfoutput>
    <CFLOOP list="#results.columnlist#" index="column_name">
      <cfoutput>#column_name#</cfoutput>
    </CFLOOP>
    <table border="1">
      <cfoutput query = "results">
        <tr>
          <td>#samaccountname#</td>
          <td>#cn#</td>
          <td>#mail#</td>
          <td>#dn#</td>
          <td>#info#</td>
        </tr>
      </cfoutput>
    </table>
    <cftry>
      <cfldap action="query" name="results2" start="ou=sjsupeople,dc=sjsuad,dc=sjsu,dc=edu" 
       attributes="cn,samaccountname,mail,dn,mobile" server="130.65.3.134" port="636" password="amma@a123" 
       username="CN=Vaishak Suresh, OU=Employees, ou=sjsupeople, dc=sjsuad, dc=sjsu, dc=edu" secure="CFSSL_BASIC" filter="cn=Vaishak Suresh">
       <cfoutput>#results2.recordCount# records found </cfoutput>
      <cfcatch type="any">
        <cfoutput>Login Not Successful #cfcatch.detail# </cfoutput>
      </cfcatch>
    </cftry>
    
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
