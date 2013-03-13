<!doctype html>
<!--[if lt IE 7 ]> <html class="ie ie6 no-js" lang="en"> <![endif]-->
<!--[if IE 7 ]>    <html class="ie ie7 no-js" lang="en"> <![endif]-->
<!--[if IE 8 ]>    <html class="ie ie8 no-js" lang="en"> <![endif]-->
<!--[if IE 9 ]>    <html class="ie ie9 no-js" lang="en"> <![endif]-->
<!--[if gt IE 9]><!--><html class="no-js" lang="en"><!--<![endif]-->
<!-- tde "no-js" class is for Modernizr. -->
<head>
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
<link rel="stylesheet" href="/cf/vaishak/_/css/style.css">
<script src="/cf/vaishak/_/js/modernizr-1.7.min.js"></script>
<!--<link href='http://fonts.googleapis.com/css?family=Leckerli+One|Rokkitt:700,400|Luckiest+Guy' rel='stylesheet' type='text/css'>-->
<link href='http://fonts.googleapis.com/css?family=Rokkitt:700,400' rel='stylesheet' type='text/css'>
<script src="http://code.jquery.com/jquery-1.8.3.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css" />
<script src="http://code.jquery.com/ui/1.9.2/jquery-ui.js"></script>
<!-- Stylesheets -->
<link rel="stylesheet" href="/cf/vaishak/_/css/style.css" />
<link rel="stylesheet" href="/cf/vaishak/_/css/desktop.css" />
<!-- Target iPhone -->
<link rel="stylesheet" href="/cf/vaishak/_/css/handheld.css" media="(max-device-width:480px)" />
<!-- Target iPad -->
<link rel="stylesheet" href="/cf/vaishak/_/css/tablet.css" media="(min-device-width:768px) and (max-device-width:1024px)" />
<!-- Target Galaxy Tab -->
<link rel="stylesheet" href="/cf/vaishak/_/css/tablet.css" media="(min-width:1280px) and (max-width:1280px)" />
<link rel="stylesheet" href="/cf/vaishak/_/css/tablet.css" media="(min-width:800px) and (max-width:800px)" />
<cfapplication sessionmanagement="yes" sessiontimeout="#CreateTimeSpan(0,0,30,0)#">
<cfajaximport tags="cfform,cfgrid">
<!--Load the AJAX API-->
<!---<script type="text/javascript" src='https://www.google.com/jsapi?autoload={"modules":[{"name":"visualization","version":"1","packages":["corechart","table"]}]}'>
    </script>--->
<script type="text/javascript" src='https://www.google.com/jsapi'></script>
<script type="text/javascript">
  // Load the Visualization API and the piechart package.
  google.load('visualization', '1', {
      'packages': ['corechart', 'table']
  });
  function drawChart() {
      $.ajax({
          url: "/cf/vaishak/getJSON.cfm",
          data: "startDate=" + $("#startDateText").val() + "&endDate=" + $("#endDate").val() + "&studentid=" + $("#selectedstudent").val(),
          dataType: "json",
          success: function (jsonData) {
              var data = new google.visualization.DataTable(jsonData);
              var options = {
                  'title': 'Sign-in Method Breakdown',
                      'width': 300,
                      'height': 200,
                      'position': 'absolute',
                  pieSliceText: 'value',
                  is3D: true,
                      'chartArea.width': 360
              };

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
  function drawTable() {
      $.ajax({
          url: "/cf/vaishak/getJSONwithDetails.cfm",
          data: "startDate=" + $("#startDateText").val() + "&endDate=" + $("#endDate").val(),
          dataType: "json",
          success: function (jsonData) {
              data = new google.visualization.DataTable(jsonData);
              options = {
                  'width': 500
              };
              table = new google.visualization.Table(document.getElementById('table_div'));
              table.draw(data, options);

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
      var str = '';
      for (var i = 0; i < selection.length; i++) {
          var item = selection[i];
          if (item.row !== null && item.column !== null) {
              str = data.getFormattedValue(item.row, item.column);
              message += str + '\n';
          } else if (item.row !== null) {
              str = data.getFormattedValue(item.row, 0);
              message += str + '\n';
          } else if (item.column !== null) {
              str = data.getFormattedValue(0, item.column);
              message += str + '\n';
          }
      }
      if (message === '') {
          message = 'nothing';
      }
      $('#selectedstudent').val(message);
      drawChart();
  }

  $(document).ready(function () {
      drawChart();
	  drawTable();
      $('#filterReportButton').click(function () {
          drawChart();
          drawTable();
      });
      $('#resetReportButton').click(function () {
          $("#startDateText").val("");
          $("#endDate").val("");
          $("#selectedstudent").val("");
          drawChart();
          drawTable();
      });
  });
</script>
</head>
<body>
<div id="header"> </div>
<section id="pages" class="group">
  <div id="loadcontent" class="group">
    <section class="sectionlist show" id="formarea">
      <cflayout type="tab" tabHeight="600" align="center" >
        <cflayoutarea title="Login Breakdown">
          <form name="generateReportForm">
            <br/>
            <br/>
            <input type="text" class="rounded" name="startDate" id="startDateText" placeholder="Start Date" title="Start Date" >
            <br />
            <br />
            <input type="text" class="rounded" name="endDate" id="endDate" placeholder="End Date" title="End Date">
            <br />
            <br />
            <input type="hidden" id="selectedstudent" value="">
            <input type="button" class="blue_button" value=" Submit " name="filterReportButton" id="filterReportButton">
            <input type="button" class="blue_button" value=" Reset " name="resetReportButton" id="resetReportButton">
          </form>
          <br />
          <div id="chart_div"></div>
          <br>
          <div id='table_div'></div>
        </cflayoutarea>
        <cflayoutarea title="Registered Users" source = "/cf/vaishak/listAllRegisteredStudents.cfm"> </cflayoutarea>
        <cflayoutarea title="Login BreakDown by Events" source = "/cf/vaishak/listUsersByEvent.cfm"> </cflayoutarea>
      </cflayout>
    </section>
  </div>
  <!-- Load Content -->
</section>
<!-- Pages-->
<footer class="group"> </footer>
<script src="/cf/vaishak/_/js/functions.js"></script>
</body>
</html>