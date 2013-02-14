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
        data: "startDate="+$("#startDateText").val()+"&endDate="+$("#endDate").val()+"&studentid="+$("#selectedstudent").val(),
        dataType: "json",
        success: function (jsonData) {
          var data = new google.visualization.DataTable(jsonData);
          var options = {'title':'Sign-in Method Breakdown',
          'width':300,
          'height':200,
          'position':'absolute',
          pieSliceText: 'value',
          is3D:true,
          'chartArea.width':360};

          var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
          chart.draw(data, options);
        },
        error: function (jqXHR, textStatus, errorThrown) {
          if (!$.browser.msie) {
            console.log(jqXHR);
          }
        }
      });
    } 

    google.load('visualization', '1', {packages:['table']});
    google.setOnLoadCallback(drawTable);
    function drawTable() {
     $.ajax({
      url: "getJSONwithDetails.cfm",
      data: "startDate="+$("#startDateText").val()+"&endDate="+$("#endDate").val(),
      dataType: "json",
      success: function (jsonData) {
       data = new google.visualization.DataTable(jsonData);
       options = {'width':500
     };
     table = new google.visualization.Table(document.getElementById('table_div'));
     table.draw(data,options);

     google.visualization.events.addListener(table, 'select', selectHandler);
   },
   error: function (jqXHR, textStatus, errorThrown) {
    if (!$.browser.msie) {
      console.log(jqXHR);
    }
  }
});
   }
   // The selection handler.
// Loop through all items in the selection and concatenate
// a single message from all of them.
function selectHandler() {
  var selection = table.getSelection();
  var message = '';
  for (var i = 0; i < selection.length; i++) {
    var item = selection[i];
    if (item.row != null && item.column != null) {
      var str = data.getFormattedValue(item.row, item.column);
      message +=  str + '\n';
    } else if (item.row != null) {
      var str = data.getFormattedValue(item.row, 0);
      message += str + '\n';
    } else if (item.column != null) {
      var str = data.getFormattedValue(0, item.column);
      message +=  str + '\n';
    }
  }
  if (message == '') {
    message = 'nothing';
  }
  $('#selectedstudent').val(message);
  drawChart();
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

  $('#resetReportButton').click(function(){
    $("#startDateText").val("");
    $("#endDate").val("");
    $("#selectedstudent").val("");
    drawChart();
    drawTable();
  });

  // $(window).bind('resize', function() { location.reload(); }); 

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
        <input type="hidden" id="selectedstudent" value="">
        <input type="button" value="Reset" name="resetReportButton" id="resetReportButton">
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