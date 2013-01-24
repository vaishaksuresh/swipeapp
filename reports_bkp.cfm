<!doctype html>
  <!--[if lt IE 7 ]> <html class="ie ie6 no-js" lang="en"> <![endif]-->
  <!--[if IE 7 ]>    <html class="ie ie7 no-js" lang="en"> <![endif]-->
  <!--[if IE 8 ]>    <html class="ie ie8 no-js" lang="en"> <![endif]-->
  <!--[if IE 9 ]>    <html class="ie ie9 no-js" lang="en"> <![endif]-->
  <!--[if gt IE 9]><!--><html class="no-js" lang="en"><!--<![endif]-->
  <!-- tde "no-js" class is for Modernizr. -->
  <head id="swipeapp" data-template-set="html5-reset">
    <meta charset="utf-8">
    <cfcontent type="text/html; charset=utf-8">
    <!-- Always force latest IE rendering engine (even in intranet) & Chrome Frame -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
    <title>C.C.A.C Swipe Application</title>
    <meta name="viewport" content="widtd=device-widtd, maximum-scale=1.0" />
    <link rel="stylesheet" href="_/css/style.css">
    <script src="_/js/modernizr-1.7.min.js"></script>
    <link href='http://fonts.googleapis.com/css?family=Leckerli+One|Rokkitt:700,400|Luckiest+Guy' rel='stylesheet' type='text/css'>

    <script src="http://code.jquery.com/jquery-1.8.3.js"></script>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.9.2/tdemes/base/jquery-ui.css" />
    <script src="http://code.jquery.com/ui/1.9.2/jquery-ui.js"></script>


    <!-- Stylesheets -->
    <link rel="stylesheet" href="./_/css/style.css" />
    <link rel="stylesheet" href="./_/css/desktop.css" />
    <!-- Target iPhone -->
    <link rel="stylesheet" href="./_/css/handheld.css" media="(max-device-widtd:480px)" />
    <!-- Target iPad -->
    <link rel="stylesheet" href="./_/css/tablet.css" media="(min-device-widtd:768px) and (max-device-widtd:1024px)" />
    <!-- Target Galaxy Tab -->
    <link rel="stylesheet" href="./_/css/tablet.css" media="(min-widtd:1280px) and (max-widtd:1280px)" />
    <link rel="stylesheet" href="./_/css/tablet.css" media="(min-widtd:800px) and (max-widtd:800px)" />
    <cfapplication sessionmanagement="yes" sessiontimeout="#CreateTimeSpan(0,0,30,0)#">





      <!--Load the AJAX API-->
      <script type="text/javascript" src="https://www.google.com/jsapi"></script>
      <script src="http://code.jquery.com/jquery-1.8.3.js"></script>
      <script type="text/javascript">

    // Load the Visualization API and the piechart package.
    google.load('visualization', '1', {'packages':['corechart']});

    // Set a callback to run when the Google Visualization API is loaded.
    google.setOnLoadCallback(drawChart);

    function drawChart() {
      $.ajax({
        url: "getJSON.cfm",
        dataType: "json",
        success: function (jsonData) {
          if (!$.browser.msie) {
            console.log(jsonData);

          }
            // Create our data table out of JSON data loaded from server. 
            var data = new google.visualization.DataTable(jsonData);
            
            // Instantiate and draw our chart, passing in some options. 
            var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
            chart.draw(data, {
              width: 400,
              height: 240,
              pieSliceText: 'value'
            });
          },
          error: function (jqXHR, textStatus, errorThrown) {
            if (!$.browser.msie) {
              console.log(jqXHR);
            }
          }
        });
    } 

    </script>


  </head>
  <body>
    <header> <a href="/"><img src="./images/logo.jpg" alt="CCAC Logo" /></a>
    <p>Cesar E. Chavez Community Action Center</p>
    <nav id="topnav"> </nav>
  </header>
  <section id="pages" class="group">
    <div id="loadcontent" class="group">
      <nav id="tabs"> </nav>
      <section class="sectionlist show" id="formarea">

        <cfquery name="getAllUsers" datasource="cccac_swipe" result="UserDetailsResult">
        Select login_mode,count(login_mode) as total from login_activity,ccac_registered_users where login_activity.student_id=ccac_registered_users.student_id GROUP BY login_mode
      </cfquery>

      <cfform>
        <cfgrid  name="getAllUsers"
        format="html"
        query="getAllUsers"
        selectmode="row" width="300px">
      </cfgrid>
    </cfform>
    <br>
    <cfchart showborder="yes" show3d="yes"> 
      <cfchartseries type="bar" query="getAllUsers" 
      itemcolumn="login_mode"  valuecolumn="total">
    </cfchartseries>
  </cfchart>
  <br>
  <div id="chart_div"></div>
<!--- <cfheader name="Content-Disposition" value="inline; filename=download.pdf">
<cfdocument format="pdf">
<table>
    <tr>
        <th>Student ID</th>
        <th>Student Name</th>
        <th>Login Mode</th>
        <th>Total</th>
    </tr>
    <cfoutput query="getAllUsers">
      <tr>
        <td>#student_id#</td>
        <td>#name#</td>
        <td>#login_mode#</td>
        <td>#total#</td>
      </tr>
    </cfoutput>
</table>
</cfdocument>
--->
</section>
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