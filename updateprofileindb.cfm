<!doctype html>
  <!--[if lt IE 7 ]> <html class="ie ie6 no-js" lang="en"> <![endif]-->
  <!--[if IE 7 ]>    <html class="ie ie7 no-js" lang="en"> <![endif]-->
  <!--[if IE 8 ]>    <html class="ie ie8 no-js" lang="en"> <![endif]-->
  <!--[if IE 9 ]>    <html class="ie ie9 no-js" lang="en"> <![endif]-->
  <!--[if gt IE 9]><!--><html class="no-js" lang="en"><!--<![endif]-->
  <!-- the "no-js" class is for Modernizr. -->
  <head id="swipeapp" data-template-set="html5-reset">
    <meta charset="utf-8">
    <cfcontent type="text/html; charset=utf-8">
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
    <link rel="stylesheet" href="./_/css/tablet.css" media="(min-device-width:768px) and (max-device-width:1024px)" />
    <!-- Target Galaxy Tab -->
    <link rel="stylesheet" href="./_/css/tablet.css" media="(min-width:1280px) and (max-width:1280px)" />
    <link rel="stylesheet" href="./_/css/tablet.css" media="(min-width:800px) and (max-width:800px)" />
    <cfapplication sessionmanagement="yes" sessiontimeout="#CreateTimeSpan(0,0,30,0)#">
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



          <cfif cgi.request_method Eq 'post'>
            <cftry>
              <cfset myDateTime = CreateODBCDateTime(#Now()#)>
              <cfif #StructKeyExists(form,"newslettercheckbox")#>
                <cfset newsletter = 1>
                <cfelse>
                  <cfset newsletter = 0>
                </cfif>
                <cfif #form.areaofinterest# neq 'others' >
                  <cfset session.other_interest = "" />
                  <cfquery name="UpdateStudentProfile" datasource="cccac_swipe">
                  update ccac_registered_users
                    set
                    email = '#form.email#',phone_number = '#form.phone#', major = '#form.major#', year_in_college = '#form.year#', area_of_interest = '#form.areaofinterest#',area_of_interest_value ='', last_update_date = #myDateTime#,last_update_mode = '#session.signinmethod#', subscribed_to_newsletter=#newsletter#
                    where
                    student_id = #session.studentid#
                  </cfquery>
                  <cfelse>
                    <cfset session.other_interest = #form.otherinterest# />
                    <cfquery name="UpdateStudentProfile" datasource="cccac_swipe">
                    update ccac_registered_users
                      set
                      email = '#form.email#',phone_number = '#form.phone#', major = '#form.major#', year_in_college = '#form.year#', area_of_interest = '#form.areaofinterest#', area_of_interest_value ='#form.otherinterest#', last_update_date = #myDateTime#,last_update_mode = '#session.signinmethod#', subscribed_to_newsletter=#newsletter#
                      where
                      student_id = #session.studentid#
                    </cfquery>
                  </cfif>

                  <cfset session.email = #form.email# />
                  <cfset session.phone = #form.phone# />
                  <cfset session.major = #form.major# />
                  <cfset session.yearinschool = #form.year# />
                  <cfset session.area_of_interest = #form.areaofinterest# />
                  <cfset session.newslettercheckbox = #newsletter# />
                  <cfset session.message = "Profile Updated Successfuly" />
                  <CFLOCATION URL="updateprofile.cfm" ADDTOKEN="no"/>
                  <cfcatch type="Database">
                  <cfoutput>
                    <p>#cfcatch.message#</p>
                    <p>#cfcatch.detail# #cfcatch.Sql#</p>
                  </cfoutput>
                </cfcatch>
              </cftry>
            </cfif>
          </section>
        </div>
      </section>
      <footer class="group">
        <p></p>
        <nav id="bottomnav"> </nav>
      </footer>
      <script src="_/js/functions.js"></script>
    </body>
    </html>