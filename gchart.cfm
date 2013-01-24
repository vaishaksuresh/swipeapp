<html>
  <head>
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
          alert('success');
          if (!$.browser.msie) {
            console.log(jsonData);

          }
            // Create our data table out of JSON data loaded from server. 
            var data = new google.visualization.DataTable(jsonData);
            
            // Instantiate and draw our chart, passing in some options. 
            var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
            chart.draw(data, {
              width: 400,
              height: 240
            });
          },
          error: function (jqXHR, textStatus, errorThrown) {
            alert(textStatus + '\n' + errorThrown);
            if (!$.browser.msie) {
              console.log(jqXHR);
            }
          }
        });
    } 

    </script>
  </head>

  <body>
    <!--Div that will hold the pie chart-->
    <div id="chart_div"></div>
  </body>
  </html>