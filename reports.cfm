<!doctype html>
  <!--[if lt IE 7 ]> <html class="ie ie6 no-js" lang="en"> <![endif]-->
  <!--[if IE 7 ]>    <html class="ie ie7 no-js" lang="en"> <![endif]-->
  <!--[if IE 8 ]>    <html class="ie ie8 no-js" lang="en"> <![endif]-->
  <!--[if IE 9 ]>    <html class="ie ie9 no-js" lang="en"> <![endif]-->
  <!--[if gt IE 9]><!--><html class="no-js" lang="en"><!--<![endif]-->
  <!-- tde "no-js" class is for Modernizr. -->

  <head id="swipeapp" data-template-set="html5-reset">
    <meta charset="utf-8">
    <!-- Pulled from http://code.google.com/p/html5shiv/ -->
<!--[if lt IE 9]>
<script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
  <!-- Always force latest IE rendering engine (even in intranet) & Chrome Frame -->
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
  <title>C.C.A.C Swipe Application</title>
  <meta name="viewport" content="width=device-width, maximum-scale=1.0" />
  <link rel="stylesheet" href="_/css/style.css">
  <script src="_/js/modernizr-1.7.min.js"></script>
  <!--<link href='http://fonts.googleapis.com/css?family=Leckerli+One|Rokkitt:700,400|Luckiest+Guy' rel='stylesheet' type='text/css'>-->
  <link href='http://fonts.googleapis.com/css?family=Rokkitt:700,400' rel='stylesheet' type='text/css'>

  <script src="http://code.jquery.com/jquery-1.8.3.js"></script>
  <link rel="stylesheet" href="http://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css" />
  <script src="http://code.jquery.com/ui/1.9.2/jquery-ui.js"></script>


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

    <!--Load the AJAX API-->
    <!---<script type="text/javascript" src="https://www.google.com/jsapi"></script>--->
    <script type="text/javascript"
    src='https://www.google.com/jsapi?autoload={"modules":[{"name":"visualization","version":"1","packages":["corechart","table"]}]}'>
    </script>
    <script type="text/javascript">
    // Load the Visualization API and the piechart package.
    google.load('visualization', '1', {'packages':['corechart']});

    // Set a callback to run when the Google Visualization API is loaded.
    google.setOnLoadCallback(drawChart);

    function drawChart() {
      $.ajax({
        url: "getJSON.cfm",
        data: "startDate="+$("#startDateText").val()+"&endDate="+$("#endDate").val(),
        //data: "startDate=01/16/2013&endDate=01/23/2013",
        dataType: "json",
        success: function (jsonData) {
          // if (!$.browser.msie) {
          //   console.log(jsonData);
          // }
            // Create our data table out of JSON data loaded from server. 
            var data = new google.visualization.DataTable(jsonData);

            // Instantiate and draw our chart, passing in some options. 
            var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
            chart.draw(data, {
              pieSliceText: 'value'
            });
          },
          error: function (jqXHR, textStatus, errorThrown) {
            // if (!$.browser.msie) {
            //   console.log(jqXHR);
            // }
          }
        });
    } 

    google.load('visualization', '1', {packages:['table']});
    google.setOnLoadCallback(drawTable);
    function drawTable() {
     $.ajax({
      url: "getJSON.cfm",
      data: "startDate="+$("#startDateText").val()+"&endDate="+$("#endDate").val(),
        //data: "startDate=01/16/2013&endDate=01/23/2013",
        dataType: "json",
        success: function (jsonData) {
          // if (!$.browser.msie) {
          //   console.log(jsonData);
          // }
            // Create our data table out of JSON data loaded from server. 
            var data = new google.visualization.DataTable(jsonData);

            // Instantiate and draw our chart, passing in some options. 
            var table = new google.visualization.Table(document.getElementById('table_div'));
            table.draw(data, {showRowNumber: true});
          },
          error: function (jqXHR, textStatus, errorThrown) {
            // if (!$.browser.msie) {
            //   console.log(jqXHR);
            // }
          }
        });


   }

   $(document).ready(function() {
    $("#startDateText").datepicker();
    $("#endDate").datepicker();
    $("#generateReportButton").click(function(e){
      e.preventDefault();
      drawChart();
      drawTable();
    });

    $('#startDateText, #endDate').change(function(){
      drawChart();
      drawTable();
    });

  });

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

      <form name="generateReportForm">
        <input type="text" class="rounded" name="startDate" id="startDateText" placeholder="Start Date" title="Start Date" ><br /><br />
        <input type="text" class="rounded" name="endDate" id="endDate" placeholder="End Date" title="End Date"><br /><br />
        <!---  <input type="submit" value="Generate Report" name="generateReportButton" id="generateReportButton"> --->
      </form><br />

      <div id="chart_div"></div><br>
      <div id='table_div'></div>
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