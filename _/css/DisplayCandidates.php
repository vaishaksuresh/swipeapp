<?php
//session_start();
require_once('..\lib\Session.php');

if(!isset($_SESSION['studentId']) || !isset($_SESSION['role']) || $_SESSION['role']!='student' 
	|| !isset($_SESSION['electionId']) || !isset($_SESSION['isVote']))
{
	include('RedirectLogin.php');
	exit();
}

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>A.S. Elections 2013</title>
<link href="../css/content_frame_layout.css" rel="stylesheet" type="text/css" media="all" />
<SCRIPT type="text/javascript">
    window.history.forward();
	//window.location="Confirmation.php"; 
    function noBack() { 
	window.history.forward(); 
	//window.location="Confirmation.php"; 
	}
</SCRIPT>
<style type="text/css">
body {
	font:76% verdana;
}
.divoverlayBox {
	border:7px solid #B1B1B1;
	position:fixed;
	display:none;
	width:500;
	height:auto;
	min-height:300px;
	background:#fff;
	border-radius: 25px;
	-moz-border-radius: 25px;
	-webkit-border-radius: 25px;
	-khtml-border-radius: 25px;
	box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.8);
	-moz-box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.8);
	-webkit-box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.8);
	z-index:1000;
	overflow:visible;
	margin-left: 200px;
}
.bgCover {
	background:#000;
	position:absolute;
	left:0;
	top:0;
	display:none;
	overflow:visible;
	z-index:900;
}
/*#overlay{ position: absolute; top: 0; left: 0; z-index: 90; width: 100%; height: 500px; background-color: #000; }*/

.overlayContent {
	padding:0px;
}
.overlaybuttons {
	padding:10px 80px 10px 0px;
    float: right;
	width: auto;
}
.overlayMain {
	height:auto;
	max-height:450px;
	width:450px;
	border:none;
	font:16px/26px Georgia, Garamond, Serif;
	padding: 0px 20px 20px 20px;
}
.overlayMain img {
	border: 8px solid #FFF;
	box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.3);
	-moz-box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.3);
	-webkit-box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.3);
}
/*.closeLink {
	color:red;
	float: right;
}*/
.closeLink {
	width: 50px;
	height: 50px;
	margin-top: -25px;
	margin-left: 465px;
	z-index: 3;
	position: absolute;
	background: url("../images/close3.png") 0 0 no-repeat;
	display: inline-table;
	vertical-align: middle;
	float: right;
}
.closeLink :hover {
	opacity:0.7;
}
.finalVote :hover {
	opacity:0.7;
}
.voteLink :hover {
	opacity:0.7;
}
.confirmLink :hover {
	opacity: 0.7;
}
.backLink :hover {
	opacity: 0.7;
}
.logoutLink :hover{
	opacity:0.7;
}
a:hover {
	text-decoration:none;
}
h2 {
	padding:5px;
	margin:0;
}
img.floatLeft {
	float: left;
	margin-right: 15px;
}
</style>
</head>
<div class="bgCover"></div>
<body class="BgColourSublinksColumn" onload="noBack();" onpageshow="if (event.persisted) noBack();" onunload="">

<!-- Bring the header in -->
<link href="../css/master.css" rel="stylesheet" type="text/css" media="all" />
<link href="../css/vote_style.css" rel="stylesheet" type="text/css" media="all" />
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"></script> 
<script type="text/javascript" src="..\lib\jquery.min.js"></script> 
<script type="text/javascript" src="..\lib\jquery.form.js"></script>
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="Thu, 01 Jan 1970 00:00:00 GMT">
<meta http-equiv="pragma" content="no-cache">
<div style="color:#800"> 
  <!--[if lte IE 6]> The "Departments" dropdown menu may not work with IE 6 or less. <![endif]--> 
</div>
<div id="shadowWrapper">
  <div id="header_container" > 
    <!-- AS LOGO LINK --> 
    <a href="/">
    <div class="sjsuAslink"></div>
    </a> 
    <!-- DOSA LINK -->
    <div class="dosa">An affiliate of <a href="http://sa.sjsu.edu/index.jsp"> Student Affairs</a><br>
      <br>
    </div>
    <!-- NEW icon -->
    <div class="newTab"></div>
    <!-- SEARCH -->
    <div id="header_search_box">
      <form name='formsearch' method="get" action="http://www.google.com/search" onsubmit="submitsearch()">
        <input type="text" name="q" maxlength="120" value="Search" id="seach_text_box" autocomplete="off" onclick="this.value='';"/>
        <div class="search_btn" onclick="submitsearch()"></div>
        <input type="hidden" name="ie" value="UTF-8"/>
        <input type="hidden" name="oe" value="UTF-8"/>
        <input type="hidden" name="domains" value="as.sjsu.edu"/>
        <input type="hidden" name="sitesearch" value="as.sjsu.edu"/>
      </form>
    </div>
    <!-- Top Nav Menu -->
    <div id="header_navigation">
      <ul id="nav">
        <li style="border: none;"><a href="http://as.sjsu.edu/" title="HOME">HOME</a></li>
        <li><a href="http://as.sjsu.edu/ashouse/index.jsp" title="ABOUT US">ABOUT US</a></li>
        <li><a href="#" title="DEPARTMENTS">DEPARTMENTS</a>
          <ul>
            <li><a href="http://as.sjsu.edu/ascr/index.jsp" class="footerLink">Campus Recreation</a>
              <ul>
                <li><a href="http://as.sjsu.edu/ascr/index.jsp?val=im_home">Team Sports</a></li>
                <li><a href="http://as.sjsu.edu/ascr/index.jsp?val=fit_group">Fitness Classes</a></li>
                <li><a href="http://as.sjsu.edu/ascr/index.jsp?val=fit_advent">Adventures</a></li>
                <li><a href="http://as.sjsu.edu/ascr/index.jsp?val=op_home">Wellness</a></li>
              </ul>
            </li>
            <li><a href="http://as.sjsu.edu/ascsc/index.jsp" class="footerLink">Computer Services Center </a>
              <ul>
                <li><a href="http://as.sjsu.edu/ascsc/index.jsp?val=csc_lrp">Laptop Rentals</a></li>
                <li><a href="http://as.sjsu.edu/ascsc/index.jsp?val=csc_repair">Repair Services</a></li>
                <li><a href="http://as.sjsu.edu/ascsc/index.jsp?val=csc_prices">Prices</a></li>
                <li><a href="http://as.sjsu.edu/ascsc/index.jsp?val=csc_printing">Printing Instructions</a></li>
              </ul>
            </li>
            <li><a href="http://as.sjsu.edu/asts/index.jsp" class="footerLink">Transportation Solutions </a>
              <ul>
                <li><a href="http://as.sjsu.edu/asts/index.jsp?val=eco_overview">A.S.Eco Passes</a></li>
                <li><a href="http://as.sjsu.edu/asts/index.jsp?val=trip_plan">Carpool Matching</a></li>
                <li><a href="http://as.sjsu.edu/asts/index.jsp?val=getting_started">Bicycle Enclosures</a></li>
                <li><a href="http://as.sjsu.edu/asts/index.jsp?val=asts_home">Trip Plans &amp; Maps</a></li>
              </ul>
            </li>
            <li><a href="http://as.sjsu.edu/asgov/index.jsp" class="footerLink">Government</a>
              <ul>
                <li><a href="http://as.sjsu.edu/asgov/index.jsp?val=gov_current">BOD Agendas &amp; Minutes</a></li>
                <li><a href="http://as.sjsu.edu/asgov/index.jsp?val=c_finance">Organization Funding</a></li>
                <li><a href="http://as.sjsu.edu/asgov/index.jsp?val=asgov_home">Join the Board/Committees</a></li>
                <li><a href="http://as.sjsu.edu/asdocs/OpenDoc.jsp?id=1036">A.S. Annual Report</a></li>
              </ul>
            </li>
            <li class="row"><a href="http://as.sjsu.edu/ascdc/index.jsp" class="footerLink">Child Development Center</a>
              <ul>
                <li><a href="http://as.sjsu.edu/ascdc/index.jsp" id="np_blank">Accredited Care</a> </li>
                <li><a href="http://as.sjsu.edu/ascdc/index.jsp?val=ascdc_admin_fees">Jobs and Training</a></li>
                <li><a href="http://as.sjsu.edu/ascdc/index.jsp?val=ascdc_parent">Parenting Resources</a></li>
                <li><a href="http://as.sjsu.edu/ascdc/index.jsp?val=ascdc_admin_fees">Admission & Fees</a></li>
              </ul>
            </li>
            <li class="row"><a href="http://as.sjsu.edu/asgsc/index.jsp" class="footerLink">General Services Center </a>
              <ul>
                <li><a href="http://as.sjsu.edu/asgsc/index.jsp?val=gsc_services#Domestic">Medical Insurance</a></li>
                <li><a href="http://as.sjsu.edu/asgsc/index.jsp?val=gsc_services#Accounts">Campus Trust Accounts </a></li>
                <li><a href="http://as.sjsu.edu/asgsc/index.jsp?val=gsc_book">Affordable Textbook Prog.</a></li>
                <li><a href="http://as.sjsu.edu/asgsc/index.jsp?val=gsc_services#Legal">Legal Counseling</a></li>
              </ul>
            </li>
            <li class="row"><a href="http://as.sjsu.edu/cccac/" class="footerLink">Community Action Center</a>
              <ul>
                <li><a href="http://as.sjsu.edu/cccac/index.jsp?val=cccac_altspring">Alternative Spring Break</a></li>
                <li><a href="http://as.sjsu.edu/cccac/index.jsp?val=cccac_serviceoppor">Volunteer Directory</a></li>
                <li><a href="http://as.sjsu.edu/cccac/index.jsp?val=cccac_media">Media Center</a></li>
                <li><a href="http://as.sjsu.edu/cccac/index.jsp?val=cccac_calendar">Calendar of Events</a></li>
              </ul>
            </li>
            <li class="row"><a href="http://as.sjsu.edu/asps/index.jsp" class="footerLink">Print Shop </a>
              <ul>
                <li><a href="http://as.sjsu.edu/asps/index.jsp?val=ps_services">Printing Services</a></li>
                <li><a href="http://as.sjsu.edu/asps/index.jsp?val=ps_prices">Price List</a></li>
                <li><a href="http://as.sjsu.edu/asps/index.jsp?val=ps_coursereader">Course Reader</a> </li>
              </ul>
            </li>
          </ul>
        </li>
        <li><a href="http://as.sjsu.edu/asjobs_new/index.jsp" title="JOBS">JOBS</a></li>
        <li><a href="http://as.sjsu.edu/asdocs/index.jsp?val=asforms_all" title="DOCUMENTS">DOCUMENTS</a></li>
        <li><a href="#" title="FUNDING">FUNDING</a>
          <div id="funding_nav">
            <ul class="fundingNav">
              <li><a href="http://as.sjsu.edu/funding/index.jsp" title="STUDENT ORG">Student Org</a></li>
              <li><a href="http://as.sjsu.edu/asdocs/OpenDoc.jsp?id=1113" target="_new" title="CAMPUS RFP">Campus RFP</a></li>
            </ul>
          </div>
        </li>
        <li><a href="http://as.sjsu.edu/asevents/" title="EVENTS">EVENTS</a></li>
        <li><a href="http://as.sjsu.edu/sitemap/index.jsp" title="SITEMAP">SITEMAP</a></li>
        <li><a href="http://as.sjsu.edu/ascontact/index.jsp" title="CONTACT">CONTACT</a></li>
      </ul>
      <!-- End of Nav Menu --> 
    </div>
  </div>
  
  <!-- JS for yellow tab for current page --> 
  <script>
jQuery(document).ready(function() {
	var curPath = location.pathname;
	var photoLogo = ["/aspg/index.jsp","/aspg/","/aslogos/index.jsp","/aslogos/"];
	var nonHomeDepPaths = ["/ashouse/index.jsp","/ashouse/","/asjobs_new/index.jsp","/asjobs_new/","/asdocs/index.jsp","/funding/index.jsp","/funding/","/asevents/index.jsp","/asevents/","/sitemap/index.jsp","/sitemap/","/ascontact/index.jsp","/ascontact/"];

	if (curPath === "/") {
		jQuery('#nav a:eq(0)').addClass('activeTab');
	}
	else if (jQuery.inArray(curPath, photoLogo) != -1) {
		jQuery('#nav a:eq(1)').addClass('activeTab');
	}
	else if (jQuery.inArray(curPath, nonHomeDepPaths) != -1) {
		jQuery('#nav a[href^="/' + location.pathname.split("/")[1] + '"]').addClass('activeTab');
	}
	else {
		jQuery('#nav a:eq(2)').addClass('activeTab'); 
	}
});
</script> 
  <!-- JS for search --> 
  <script>
	function submitsearch() {
		var myform = document.formsearch;
		/* 	if(myform.rsearch[0].checked) myform.action="http://www.google.com/search";
			else if(myform.rsearch[1].checked) myform.action="/cgi-bin/advsearch.pl"; */
		myform.action="http://www.google.com/search";
		myform.submit();
	}
	/*var currentUrl = document.location.href;
	var http = "http://";
	var www = "www.";
	var domain = "as.sjsu.edu";
	var trail = "/";
	var index = "index.jsp";
	var indexUrl1 = http + www + domain + trail + index;
	var indexUrl2 = http + www + domain + trail;
	var indexUrl3 = http + www + domain;
	var indexUrl4 = http + domain + trail + index;
	var indexUrl5 = http + domain + trail;
	var indexUrl6 = http + domain;
	var indexUrl7 = www + domain + trail + index;
	var indexUrl8 = www + domain + trail;
	var indexUrl9 = www + domain;
	if(	currentUrl == indexUrl1 ||  currentUrl == indexUrl2 || currentUrl == indexUrl3 ||
		currentUrl == indexUrl4 ||  currentUrl == indexUrl5 || currentUrl == indexUrl6 ||
		currentUrl == indexUrl7 ||  currentUrl == indexUrl8 || currentUrl == indexUrl9 )
		document.getElementById('promo-banner').style.display = 'none';
	function promo_alert() {
		alert("To enter the iPad contest you will need a user name and password. These have been mailed or will be mailed to you over the next few days. Please check the email account you have listed as personal email in My SJSU.  If your ISP has strong spam filters, you may have to look in the spam or junk mail folders for a message from \"elecboard@as.sjsu.edu\".  Once you have received this message you will be able to use the credentials and link provided to take the survey. Thank you for your time, opinion and patience with this process.");
	}*/
</script> 
  <script type="text/javascript">
			
			
		var voteDetails = new Array();
		var candidateName = new Array();
		var positionName = new Array();
		var imageSrc = new Array();
		
		var candSelected = new Array();
			
		<?php
			require_once('..\controller\DisplayCandidateController.php');
			require_once('..\lib\CheckUserDetails.php');
			require_once('..\constants\Constants.php');
			require_once('..\lib\GetElectionDetails.php');
			
			if(isset($_SESSION['electionId']) && $_SESSION['electionId'] != 0)
			{
				$electionDetails = get_election_details_by_id($_SESSION['electionId']);
			}
			else
			{
				$electionDetails = null;
			}
			
			if(isset($_POST['source']))
			{
				if($_POST['source'] == 'back')
				{
					$_SESSION['voteDetails'] = $_POST['votingDetails'];
					$_SESSION['positionDeatils'] = $_POST['positionNames'];
					$_SESSION['candidateDetails'] = $_POST['candidateNames'];
					$_SESSION['imageSource'] = $_POST['imageSource'];
					
					$voteDetails = explode(',' , $_POST['votingDetails']);
					$positionDeatils = explode(',' , $_POST['positionNames']);
					$candidateDetails = explode(',' , $_POST['candidateNames']);
					$imageSource = explode(',' , $_POST['imageSource']);
							
					if(isset($voteDetails))
					{
						foreach ($voteDetails as $key => $val)
						{
								
		?>
							if(typeof voteDetails[<?php echo $key; ?>] == 'undefined')
							{
										
								voteDetails[<?php echo $key; ?>] = '<?php echo $val; ?>' ;
								positionName[<?php echo $key; ?>] = '<?php echo $positionDeatils[$key]; ?>' ;
								candidateName[<?php echo $key; ?>] = '<?php echo $candidateDetails[$key]; ?>' ;
								imageSrc[<?php echo $key; ?>] = '<?php echo $imageSource[$key]; ?>' ;
										
								//alert ('<?php echo $imageSource[$key]; ?>');
							}
		<?php
						}
					}
				}
				else
				{
		?>
					var voteDetails = new Array();
					var candidateName = new Array();
					var positionName = new Array();
					var imageSrc = new Array();
		<?php
				}
			}
			/**else if(isset($_SESSION['voteDetails']) && isset($_SESSION['positionDeatils']) && isset($_SESSION['candidateDetails']) && isset($_SESSION['imageSource']))
			{
				$voteDetails = explode(',' , $_SESSION['voteDetails']);
				$positionDeatils = explode(',' , $_SESSION['positionDeatils']);
				$candidateDetails = explode(',' , $_SESSION['candidateDetails']);
				$imageSource = explode(',' , $_SESSION['imageSource']);
							
				if(isset($voteDetails))
				{
					foreach ($voteDetails as $key => $val)
					{
								
		?>
						if(typeof voteDetails[<?php echo $key; ?>] == 'undefined')
						{
							//alert("Set");			
							voteDetails[<?php echo $key; ?>] = '<?php echo $val; ?>' ;
							positionName[<?php echo $key; ?>] = '<?php echo $positionDeatils[$key]; ?>' ;
							candidateName[<?php echo $key; ?>] = '<?php echo $candidateDetails[$key]; ?>' ;
							imageSrc[<?php echo $key; ?>] = '<?php echo $imageSource[$key]; ?>' ;
										
							//alert ('<?php echo $imageSource[$key]; ?>');
						}
		<?php
					}
				}
				
				else
				{
		?>
					var voteDetails = new Array();
					var candidateName = new Array();
					var positionName = new Array();
					var imageSrc = new Array();
		<?php
				}
			}*/
			else
			{
					
		?>
				var voteDetails = new Array();
				var candidateName = new Array();
				var positionName = new Array();
				var imageSrc = new Array();
		<?php
			}
		?>
			
		
		$(document).ready(function() 
		{ 
			var isElectionStarted = false;
			<?php
				if($electionDetails != null && sizeof($electionDetails) != 0)
				{
				?>
				var elecStartTimeStr = '<?php echo $electionDetails->getField('startDateTime');?>';
				var elecEndTimeStr = '<?php echo $electionDetails->getField('endDateTime');?>';
				var currentDate = new Date();
				
				var elecStartDate = new Date(Date.parse(elecStartTimeStr));
				var elecEndDate = new Date(Date.parse(elecEndTimeStr));
				var startTime = elecStartDate.getTime() - currentDate.getTime();
				var endTime = elecEndDate.getTime() - currentDate.getTime();
				
				//alert(startTime + " ---- " + endTime);
				if(startTime <= 0 && endTime > 0)
				{
					<?php
						if(!isset($_SESSION['isFirst']))
						{
						?>
					alert('<?php echo $userVoteInstructionMsg; ?>');
					<?php
						}
						$_SESSION['isFirst'] = 'false';
					?>
					isElectionStarted = true;
				}
				else if(startTime > 0)
				{
					alert("Sorry! Cannot vote as the election has not started!");
					isElectionStarted = false;
					window.location.href= "VoteLocked.php";
				}
				else
				{
					alert("Sorry! Cannot vote as the election has ended!");
					isElectionStarted = false;
					window.location.href= "VoteLocked.php";
				}
				<?php
				}
				?>
			
			$('a.ViewReport').live('click', (function(e)
			{
				if(!isElectionStarted)
				{
					alert("You can view the result only after election starts!");
					e.stopPropagation();
					e.preventDefault();
				}
			}));
				
			$('#footer_container').live('click',(function(e)
				{
					var answer = confirm('Clicking this link will navigate away from application. Do you want to continue?');
					
					if(!answer)
					{
						e.stopPropagation();
						e.preventDefault();
					}
				}));
				
				$('#header_container').live('click',(function(e)
				{
					var answer = confirm('Clicking this link will navigate away from application. Do you want to continue?');
					
					if(!answer)
					{
						e.stopPropagation();
						e.preventDefault();
					}
				}));
				
			/**$('a.imgLink').hover(
					
				function () {
						//mouseover
					$(this).parent().parent().children().not('span').css({ opacity: 0.3 });
					$(this).parent().css({ opacity: 1 });
					$(this).parent().children('div').show();
				},
				function () {
						// mouseout
					var positionId = $(this).parent().parent().attr("id");
					var candidateId = voteDetails[positionId];
						
					//$(this).parent().parent().children().not('span').css({ opacity: 1 });
					$(this).parent().children('div').hide();
							
					if(typeof voteDetails[positionId] == 'undefined' || voteDetails[positionId] == '')
					{
						$(this).parent().parent().children().not('span').css({ opacity: 1 });
					}
					else
					{
						$(this).parent().parent().children().not('span').css({ opacity: 0.3 });
						//$('a.imgLink').attr("id", candidateId).parent().css({ opacity: 1 });
						$('#Candidate' + candidateId).parent().parent().css({ opacity: 1 });
					}
				}	
			);
			
			var url = "../lib/GetElectionDetails.php";
					
			$.post(url, function(data)
			{
				//alert(data);
				var electionDetails = data.split("<br>");
				$('div.electionLogoImg').html(electionDetails[0]);
				$('div.electionBannerImg').html(electionDetails[1]);
				$("#election_header").html(electionDetails[2]);
				$("#election_details").html(electionDetails[3]);
			});*/
			
			for(var i = 0 ; i < voteDetails.length ; i++)
			{
				if(typeof voteDetails[i] != 'undefined' && voteDetails[i] != '')
				{
					$('#Position' + i).parent().children().not('span').css({ opacity: 0.3 });
					$('#Candidate' + voteDetails[i]).parent().parent().css({ opacity: 1 });
				}
			}
			
			$('div.candDiv').hover(
					
				function () {
						//mouseover
					$(this).parent().children().not('span').css({ opacity: 0.3 });
					$(this).css({ opacity: 1 });
					$(this).children('div').show();
				},
				function () {
						// mouseout
					var positionId = $(this).parent().attr("id");
					var candidateId = voteDetails[positionId];
						
					//$(this).parent().parent().children().not('span').css({ opacity: 1 });
					$(this).children('div').hide();
							
					if(typeof voteDetails[positionId] == 'undefined' || voteDetails[positionId] == '')
					{
						$(this).parent().children().not('span').css({ opacity: 1 });
					}
					else
					{
						$(this).parent().children().not('span').css({ opacity: 0.3 });
						//$('a.imgLink').attr("id", candidateId).parent().css({ opacity: 1 });
						$('#Candidate' + candidateId).parent().parent().css({ opacity: 1 });
					}
				}	
			);
				
				$('a.imgLink').live('click', (function(e)
				{
					e.preventDefault();
					
					$(this).parent().parent().children().not('span').css({ opacity: 0.3 });
					//$(this).parent().parent().children().not('span').css('border', 'none');
					//alert(this.id + " - " + $(this).parent().parent().attr("id"));
					//alert($(this).attr("id"));
					
					//$(this).parent().parent().children().not($(this).attr("id")).css('opacity', 0.5);
					//$(this).css({ opacity: 1 });
					
					var candidateId = this.id;
					var positionId = $(this).parent().parent().attr("id");
					var posName = $(this).parent().parent().children('span.position_tab').attr("id");
					var candName = $(this).parent().children('a').text();
					var imgSrc = $(this).children('img').attr("src");
					
					//$(this).parent().children('span').hide();
					
					if(voteDetails[positionId] == candidateId)
					{
						$('span.'+positionId).hide();
						$(this).parent().parent().children().not('span').css({ opacity: 1});
						//$(this).parent().parent().children().not('span').css('border', 'none');
					}
					else
					{
						$('span.'+positionId).hide();
						$(this).parent().children('span').show();
						//$(this).parent().css('border', 'solid 1px red');
						$(this).parent().css({ opacity: 1 });
					}
					
					
					if(voteDetails[positionId] == candidateId)
					{
						voteDetails[positionId] = undefined;
						positionName[positionId] = undefined;
						candidateName[positionId] = undefined;
						imageSrc[positionId] = undefined;
					}
					else
					{
						voteDetails[positionId] = candidateId;
						positionName[positionId] = posName;
						candidateName[positionId] = candName;
						imageSrc[positionId] = imgSrc;
					}
					//$(this).css({ opacity: 1 });
					//alert($(this).closest('div').attr('id'));
				}));
				
				
				
				$('a.voteLink').live('click', (function(e)
				{	
					e.preventDefault();
					
					if(typeof candSelected[0] != 'undefined' &&
						  typeof candSelected[1] != 'undefined' &&
							typeof candSelected[2] != 'undefined' &&
								typeof candSelected[3] != 'undefined' &&
									typeof candSelected[4] != 'undefined')
					{
						var candidateId = candSelected[0];
						var positionId = candSelected[1];
						var posName = candSelected[2];
						var candName = candSelected[3];
						var imgSrc = candSelected[4];
					
						voteDetails[positionId] = candidateId;
						positionName[positionId] = posName;
						candidateName[positionId] = candName;
						imageSrc[positionId] = imgSrc;
						
						candSelected = new Array();
						
						//$('#' + positionId).children().not('span').css({ opacity: 0.3 });
						$('#Position' + positionId).parent().children().not('span').css({ opacity: 0.3 });
						$('#Candidate' + candidateId).parent().parent().css({ opacity: 1 });
						$('span.'+positionId).hide();
						$('#Span'+candidateId).show();
						//$('#Candidate' + candidateId).parent().parent().css({ opacity: 1 });
						//$('#' + candidateId).parent().css({ opacity: 1 });
						
						doOverlayClose();
					}
					
					//alert(candidateId + " - " + positionId + " - " + posName + " - " + candName + " - " + imgSrc);
				}));
				
				// close it when closeLink is clicked
				//$('a.closeLink').click( doOverlayClose );
				
				$('a.closeLink').live('click', (function(e)
				{
					e.preventDefault();
					$("#overlayDiv").html("");
					doOverlayClose();
				}));
				
				//start
				$('a.launchLink').live('click', (function(e)
				{
					//alert(this.id);
					//alert($(this).text());
					e.preventDefault();
				
					var valueToPass = this.id;
					
					var url = "../controller/ShowCandidateInfoController.php";
					
					var candidateId = this.id;
					var positionId = $(this).parent().parent().attr("id");
					var posName = $(this).parent().parent().children('span.position_tab').attr("id");
					var candName = $(this).parent().children('a').text();
					var imgSrc = $(this).parent().children('a.imgLink').children('img').attr("src");
					
					candSelected[0] = candidateId;
					candSelected[1] = positionId;
					candSelected[2] = posName;
					candSelected[3] = candName;
					candSelected[4] = imgSrc;
					
					//alert(candidateId + " - " + positionId + " - " + posName + " - " + candName + " - " + imgSrc);
					
					$.post(url, { data: valueToPass }, function(data)
					{
						$("#overlayDiv").html(data);
						//$("#overlayDiv").append("<input type='hidden' id ='candId' value='" + valueToPass + "'/>");
					});
					
					setTimeout(function() { doOverlayOpen(); }, 300);
					//doOverlayOpen();
				}));
				//end
				
				$('a.launchProfileLink').live('click', (function(e)
				{
					//alert(this.id);
					//alert($(this).text());
					e.preventDefault();
				
					var valueToPass = this.id;
					
					var url = "../controller/ShowCandidateInfoController.php";
					
					var candidateId = this.id;
					var positionId = $(this).parent().parent().parent().attr("id");
					var posName = $(this).parent().parent().parent().children('span.position_tab').attr("id");
					var candName = $(this).parent().parent().children('a').text();
					var imgSrc = $(this).parent().parent().children('a.imgLink').children('img').attr("src");
					
					candSelected[0] = candidateId;
					candSelected[1] = positionId;
					candSelected[2] = posName;
					candSelected[3] = candName;
					candSelected[4] = imgSrc;
					
					//alert(candidateId + " - " + positionId + " - " + posName + " - " + candName + " - " + imgSrc);
					
					$.post(url, { data: valueToPass }, function(data)
					{
						$("#overlayDiv").html(data);
						//$("#overlayDiv").append("<input type='hidden' id ='candId' value='" + valueToPass + "'/>");
					});
					setTimeout(function() { doOverlayOpen(); }, 300);
					//doOverlayOpen();
				}));
				
				$('a.finalVote').live('click', (function(e)
				{
				e.preventDefault();
				
				var url = "Confirmation.php";
				var studId = '<?php echo $_SESSION['studentId']; ?>';
				var studName = '<?php echo $_SESSION['userName']; ?>';
				//alert(studId);
				var votingDetails = '';
				var posName = '';
				var candName = '';
				var imgSrc = '';
				var count = 0;
				
				var form = document.createElement("form");
				form.setAttribute("method", "post");
				form.setAttribute("action", url);

				for(var i = 0 ; i < voteDetails.length ; i++)
				{
					if(i < voteDetails.length - 1)
					{
						if(typeof voteDetails[i] != 'undefined' && voteDetails[i] != '')
						{
							votingDetails = votingDetails + voteDetails[i] + ',';
							posName = posName + positionName[i] + ',';
							candName = candName + candidateName[i] + ',';
							imgSrc = imgSrc + imageSrc[i] + ',';
							count++;
						}
						else
						{
							votingDetails = votingDetails + ',';
							posName = posName + ',';
							candName = candName + ',';
							imgSrc = imgSrc + ',';
						}
					}
					else
					{
						if(typeof voteDetails[i] != 'undefined')
						{
							votingDetails = votingDetails + voteDetails[i];
							posName = posName + positionName[i];
							candName = candName + candidateName[i];
							imgSrc = imgSrc + imageSrc[i];
							count++;
						}
						else
						{
							votingDetails = votingDetails;
							posName = posName;
							candName = candName;
							imgSrc = imgSrc;
						}
					}
				}
				
				if(count == 0)
				{
					alert('<?php echo $noCandSelectedMsg; ?>');
				}
				else
				{
				//var form = new Element('form',{method: 'post', action: url});
				
				var hiddenField1 = document.createElement("input");
				hiddenField1.setAttribute("type", "hidden");
				hiddenField1.setAttribute("name", "votingDetails");
				hiddenField1.setAttribute("value", votingDetails);
				
				var hiddenField2 = document.createElement("input");
				hiddenField2.setAttribute("type", "hidden");
				hiddenField2.setAttribute("name", "studentId");
				hiddenField2.setAttribute("value", studId);
				
				var hiddenField3 = document.createElement("input");
				hiddenField3.setAttribute("type", "hidden");
				hiddenField3.setAttribute("name", "positionNames");
				hiddenField3.setAttribute("value", posName);
				
				var hiddenField4 = document.createElement("input");
				hiddenField4.setAttribute("type", "hidden");
				hiddenField4.setAttribute("name", "candidateName");
				hiddenField4.setAttribute("value", candName);
				
				var hiddenField5 = document.createElement("input");
				hiddenField5.setAttribute("type", "hidden");
				hiddenField5.setAttribute("name", "imageSource");
				hiddenField5.setAttribute("value", imgSrc);
				
				var hiddenField6 = document.createElement("input");
				hiddenField6.setAttribute("type", "hidden");
				hiddenField6.setAttribute("name", "navigation");
				hiddenField6.setAttribute("value", "proper");
				
				var hiddenField7 = document.createElement("input");
				hiddenField7.setAttribute("type", "hidden");
				hiddenField7.setAttribute("name", "studentName");
				hiddenField7.setAttribute("value", studName);
				
				form.appendChild(hiddenField1);
				form.appendChild(hiddenField2);
				form.appendChild(hiddenField3);
				form.appendChild(hiddenField4);
				form.appendChild(hiddenField5);
				form.appendChild(hiddenField6);
				form.appendChild(hiddenField7);
				
				document.body.appendChild(form);

				form.submit();
				}
				}));
			});
	
		</script> 
  <!-- <p>This is some text</p> -->
  
  <form id="voteForm" >
    <!-- Creat the frame for content-->
    <div id="full_width_shade"> <!-- This one is for the grey background-->
      <div id="shadow_wrapper"> <!-- This one gives the center frame the background of a shawod box -->
        <div id="content_frame"> <!-- This one restricts the width of the content. Put the content within this frame --> 
          <!-- Finally the content starts.. Maybe we can consider cutting this part into another included page?-->
          
          <div id="department_content_wrapper">
			<div id="user_session_box">
            <div class="appname_box">AS Voting App</div>
				Hello <?php echo $_SESSION['userName']; ?> |      <a href="../controller/LogoutController.php"><b>Logout</b></a>
			</div>
        <div id="progress_bar">
          <img src="../images/progress_bar_vote.png" alt="some_text">
		</div>
		  <?php
			
					if(null != $electionDetails && sizeof($electionDetails) != 0)
					{
						echo "<div class=\"electionInfo\" id='".$electionDetails->getField('electionId')."'>";
						echo "<div class=\"electionStartDate\" id='".$electionDetails->getField('startDateTime')."'></div>";
						echo "<div class=\"electionEndDate\" id='".$electionDetails->getField('endDateTime')."'></div>";
						echo "<div id=\"single_column_layout\">";
						if(file_exists($electionDetails->getField('logoImage')))
						{
							echo "<div id=\"election_img\" class=\"electionLogoImg\">";
							echo "<img src ='".$electionDetails->getField('logoImage') ."' width='175' height='175'/>";
							echo " </div>";
						}
						echo " </div>";
						
						//echo "<div id=\"election_img\" class=\"electionBannerImg\">";
						//echo "<img src ='".$electionDetails->getField('bannerImage') ."' width='150' height='150'/>";
						//echo " </div>";
						echo " <div id=\"election_header\">";
						echo $electionDetails->getField('title');
						echo " </div>";
						echo " <div id=\"election_details\">";
						echo $electionDetails->getField('descriptionText');
						echo " </div>";
						//echo "<span id='electionEditSpan' style='display:none'>";
						//echo "<a href='#' class='editElectionInfoLaunchLink'><img src ='../images/edit.png' alt='Edit' /></a>";
						//echo "</span>";
						
					}
					else
					{
						echo "<div id=\"electionInfoDefault\">";
						echo "<div id=\"single_column_layout\">";
						echo "<div id=\"election_img\" class=\"electionLogoImg\">";
						echo "<img src ='../images/spartan.png' alt='Logo Image' title='Logo Image' width='175' height='175'/>";
						echo " </div>";
						echo " </div>";
						//echo "<div id=\"election_img\" class=\"electionBannerImg\">";
						//echo "<img src ='../images/Banner.png' alt='Banner Image' title='Banner Image' width='150' height='150'/>";
						//echo " </div>";
						echo " <div id=\"election_header\">";
						echo "Election Title";
						echo " </div>";
						echo " <div id=\"election_details\">";
						echo "Description - Some description about the election";
						echo " </div>";
						//echo "<span id='electionAddSpan' style='display:none'>";
						//echo "<a href='#' class='addElectionInfoLaunchLink'><img src ='../images/add.png' alt='Add' /></a>";
						//echo "</span>";
					}
		?>
           <!-- <div id="single_column_layout">
              <div id="election_img" class="electionLogoImg"> <img src="../images/sjsu_horiz.png" alt="some_text"> </div>
            </div>
            <div id="election_img" class="electionBannerImg"> <img src="../images/votegraphic.png" alt="some_text"> </div>
            <div id="election_header"> WELCOME TO OUR Voting application </div>
            <div id="election_details"> Welcome to our voting application, you will be able to vote for AS candidates using this system. Just select one candidate for each position and press vote at the bottom of the page. There will be a confirmation page and an option for you to print or email your selection. </div>-->
            
			<div class="divoverlayBox">
              <div class="overlayContent"><a href="#" class="closeLink"><!--<img src="../images/iconclose.png" width="30" height="30" border="none">--></a></div>
              
              <!--                <frameset cols="50%,50%">
                  <frame src="frame_a.htm" scrolling="yes"><p>This is a description of the candidate</p>
                  <frame src="frame_b.htm">
                </frameset>
                -->
              
              <div class="overlayMain" id="overlayDiv"> <img src="../images/default.bmp" alt="some_text" width="150" height="150" class="floatLeft"> </div>
              <div class="overlaybuttons"> <a href="#" class="voteLink"><img src="../images/vote2.png" width="92" height="40" border="none"></a> <!--<a href="#" class="closeLink"><img src="../images/close2.png" width="92" height="40" border="none"></a>--></div>

          </div>
		  
          <?php
					$votedPosCount = 0;
					$displayCandCount = 0;
					
					if(isset($_SESSION['studentId']))
					{
						$studentId = $_SESSION['studentId'];
					}
					else
					{
						$studentId = 0;
						//header('Location: http://130.65.61.30/voteapp/pages/Login.php');
					}
					if(isset($_POST['source']))
					{
						if($_POST['source'] == 'back')
						{
							$voteDetails = explode(',' , $_POST['votingDetails']);
							//foreach($voteDetails as $k=>$v)
							//{
								//echo "<script type=\"text/javascript\">";
								//echo "voteDetails[".$k."]=".$v.";";
								//echo "</script>";
							//}
						}
						else
						{
							$voteDetails = array();
						}
						
					}
					else if(isset($_SESSION['voteDetails']))
					{
						$voteDetails = explode(',' , $_SESSION['voteDetails']);	
					}
					else
					{
						$voteDetails = array();
					}
					//echo $studentId . "<br>";
					$userDetail = get_user_details($studentId);	
					//echo sizeof($userDetail);
					if(sizeof($userDetail) > 0)
					{
						$positionsVoted = explode(',', $userDetail->getField('positionsVoted'));
					}
					else
					{
						$positionsVoted = array();
					}
					
					foreach($positionsVoted as $k => $v)
					{
						//echo $k . " - " . $v."<br>";
					}
					$records = get_positions();
					
					if(sizeof($records) > 0 && null != $electionDetails && sizeof($electionDetails) != 0)
					{
					$end = max(array_keys($records));
					//$sortedPos = sort_position($records);
					for( $j = 0 ; $j <= $end ; $j++)
					{
						
						if(isset($records[$j]) && !in_array($records[$j]->getField('positionId'), $positionsVoted))
						{
						$votedPosCount++;
						//echo $records[$j]->getField('positionId')."<br>";
						
						$candidateArray = display_candidate($records[$j]->getField('positionId'));
						//$candidateArray = display_candidate(1);
						$totalCandidate = sizeof($candidateArray);
						
						if($totalCandidate != 0)
						{
							$displayCandCount++;
							if(isset($_POST['source']) && $_POST['source'] == 'back' && 
									isset($voteDetails[$records[$j]->getField('positionId')]) && 
									$voteDetails[$records[$j]->getField('positionId')] != '')
							{
								//echo $records[$j]->getField('positionTitle'). " - " . $voteDetails[$records[$j]->getField('positionId')];
								$isSelected = true;
							}
							/**else if(isset($_SESSION['voteDetails']) && isset($voteDetails[$records[$j]->getField('positionId')]) && 
									$voteDetails[$records[$j]->getField('positionId')] != '')
							{
								//echo $records[$j]->getField('positionTitle'). " - " . $voteDetails[$records[$j]->getField('positionId')];
								$isSelected = true;
							}*/
							else
							{
								$isSelected = false;
							}
							
							echo " <div id=\"position_box\">";
							echo "<div id='".$records[$j]->getField('positionId')."'>";
							echo "<div id='Position".$records[$j]->getField('positionId')."'></div>";
							
							echo "<span class=\"position_tab\" id='".strtoupper($records[$j]->getField('positionTitle'))."'>";
							echo strtoupper($records[$j]->getField('positionTitle'));
							echo "</span>";
							
							for($i = 0 ; $i < $totalCandidate ; $i++)
							{
								if(isset($voteDetails) && in_array($candidateArray[$i]->getField('candidateId'), $voteDetails) && $isSelected)
								{
									echo "<div id=\"candidate_box\" style=\"opacity:1;\" class='candDiv'>";
								}
								else if($isSelected)
								{
									echo "<div id=\"candidate_box\" style=\"opacity:0.3;\" class='candDiv'>";
								}
								else
								{	
									echo "<div id=\"candidate_box\" class='candDiv'>";
								}
								//echo "<div id='".$candidateArray[$i]->getField('candidateId')."' class=\"imgDiv\">";
								//echo "<div id=\"image_box\">";
								//echo "<div id='".$records[$j]->getField('positionId')."'>";
								echo "<a id='".$candidateArray[$i]->getField('candidateId')."' href='#' class=\"imgLink\">";
								//echo "<input type='hidden' id='".$candidateArray[$i]->getField('candidateId')."' 
										//	value='".$records[$j]->getField('positionId')."'/>";
								echo "<div id='Candidate".$candidateArray[$i]->getField('candidateId')."'> </div>";	
								if(file_exists($candidateArray[$i]->getField('displayImage')))
								{
									echo "<img src='".$candidateArray[$i]->getField('displayImage')."' height=150 width=150>";
									//echo "<input style='display:none' type='radio' id='".$records[$j]->getField('positionId')."' 
										//value='".$candidateArray[$i]->getField('displayImage')."'/>";
								}
								else
								{
									echo "<img src='..\images\default.bmp' alt='No Image!' height=150 width=150>";
									//echo "<input style='display:none' type='radio' id='".$records[$j]->getField('positionId')."' 
										//value='..\images\default.bmp'/>";
								}
								echo "</a>";
								echo "<div style='display:none'>";
								echo "<div id=\"candidate_greycheckmark\"></div>";
								echo "<a id = '".$candidateArray[$i]->getField('candidateId')."' href='#' class=\"launchProfileLink\">";
								echo "<div id=\"candidate_profile\"></div></a>";
								echo "</div>";
								
								if(isset($_POST['source']) && $_POST['source'] == 'back' && 
											in_array($candidateArray[$i]->getField('candidateId') , $voteDetails))
								{
								echo "<span style='' class='".$records[$j]->getField('positionId')."' id='Span".$candidateArray[$i]->getField('candidateId')."'>";
								}
								/**else if(isset($_SESSION['voteDetails']) && in_array($candidateArray[$i]->getField('candidateId') , $voteDetails))
								{
								echo "<span style='' class='".$records[$j]->getField('positionId')."' id='Span".$candidateArray[$i]->getField('candidateId')."'>";
								}*/
								else
								{
								echo "<span style='display:none' class='".$records[$j]->getField('positionId')."' id='Span".$candidateArray[$i]->getField('candidateId')."'>";
								}
								echo "<div id=\"candidate_greencheckmark\"></div>";
								echo "</span>";
								
								//echo "</div>";
								//echo "</div>";
								echo "<a id = '".$candidateArray[$i]->getField('candidateId')."' href='#' class=\"launchLink\">";
								echo $candidateArray[$i]->getField('candidateFullName');
								echo "</a>";
								echo "</div>";
							}
							echo "</div>";
							echo "</div>";
						}
						}
					}
					}
					
					if(isset($_POST['source']))
					{
						unset($_POST['source']);
					}
					
					if($displayCandCount == 0 && $votedPosCount == 0)
					{
						echo " <div id=\"position_box\">";
						echo "<h4><center>".$allPosVotedMsg."</center></h4>";
						echo "</div>";
					}
					else if($displayCandCount == 0 && $votedPosCount != 0)
					{
						echo " <div id=\"position_box\">";
						echo "<h4><center>".$allPosVotedMsg."</center></h4>";
						echo "</div>";
					}
				?>
        </div>
        <div align="center" id="vote_container">
          <?php 
			if($displayCandCount == 0 && $votedPosCount != 0)
			{
				echo "<a href=\"#\" class=\"finalVote\"><img src=\"../images/submit_button.png\" width=\"92\" height=\"35\" border=\"none\" style='display:none'></a>";
			}
			else if($displayCandCount == 0 && $votedPosCount == 0)
			{
				echo "<a href=\"#\" class=\"finalVote\"><img src=\"../images/submit_button.png\" width=\"92\" height=\"35\" border=\"none\" style='display:none'></a>";
			}
			else
			{
				echo "<a href=\"#\" class=\"finalVote\"><img src=\"../images/submit_button.png\" width=\"92\" height=\"40\" border=\"none\"></a>";
			}
		
		  ?>
          <!-- <a href="../controller/LogoutController.php" class="logout"><img src="../images/logout.png" width="114" height="42" border="none"></a> 
          <input type="button" value="Vote"  onclick="confirmForm()"/> --> 
        </div>
        <div id="department_header"> </div>
      </div>
      <!-- end of "content_frame" --> 
    </div>
    <!-- end of "shadow_wrapper"-->
  </form>
  <!-- Footer -->
  
  <div id="footer_container">
    <div class="gradient"></div>
    <div id="footer_links">
      <div class="col"> <a href="http://as.sjsu.edu/ascr/index.jsp" class="footerLink">Campus Recreation</a>
        <ul>
          <li><a href="http://as.sjsu.edu/ascr/index.jsp?val=im_home">Team Sports</a></li>
          <li><a href="http://as.sjsu.edu/ascr/index.jsp?val=fit_group">Fitness Classes</a></li>
          <li><a href="http://as.sjsu.edu/ascr/index.jsp?val=fit_advent">Adventures</a></li>
          <li><a href="http://as.sjsu.edu/ascr/index.jsp?val=op_home">Wellness</a></li>
        </ul>
        <a href="http://as.sjsu.edu/ascdc/index.jsp" class="footerLink">Child Development Center</a>
        <ul>
          <li><a href="http://as.sjsu.edu/ascdc/index.jsp" id="np_blank">Accredited Care</a> </li>
          <li><a href="http://as.sjsu.edu/ascdc/index.jsp?val=ascdc_admin_fees">Jobs and Training</a></li>
          <li><a href="http://as.sjsu.edu/ascdc/index.jsp?val=ascdc_parent">Parenting Resources</a></li>
          <li><a href="http://as.sjsu.edu/ascdc/index.jsp?val=ascdc_admin_fees">Admission & Fees</a></li>
        </ul>
      </div>
      <div class="col"> <a href="http://as.sjsu.edu/ascsc/index.jsp" class="footerLink">Computer Services Center </a>
        <ul>
          <li><a href="http://as.sjsu.edu/ascsc/index.jsp?val=csc_lrp">Laptop Rentals</a></li>
          <li><a href="http://as.sjsu.edu/ascsc/index.jsp?val=csc_repair">Repair Services</a></li>
          <li><a href="http://as.sjsu.edu/ascsc/index.jsp?val=csc_prices">Prices</a></li>
          <li><a href="http://as.sjsu.edu/ascsc/index.jsp?val=csc_printing">Printing Instructions</a></li>
          </li>
        </ul>
        <a href="http://as.sjsu.edu/asgsc/index.jsp" class="footerLink">General Services Center </a>
        <ul>
          <li><a href="http://as.sjsu.edu/asgsc/index.jsp?val=gsc_services#Domestic">Medical Insurance</a></li>
          <li><a href="http://as.sjsu.edu/asgsc/index.jsp?val=gsc_services#Accounts">Campus Trust Accounts </a></li>
          <li><a href="http://as.sjsu.edu/asgsc/index.jsp?val=gsc_book">Affordable Textbook Prog.</a></li>
          <li><a href="http://as.sjsu.edu/asgsc/index.jsp?val=gsc_services#Legal">Legal Counseling</a></li>
        </ul>
      </div>
      <div class="col"> <a href="http://as.sjsu.edu/asts/index.jsp" class="footerLink">Transportation Solutions </a>
        <ul>
          <li><a href="http://as.sjsu.edu/asts/index.jsp?val=eco_overview">A.S.Eco Passes</a></li>
          <li><a href="http://as.sjsu.edu/asts/index.jsp?val=trip_plan">Carpool Matching</a></li>
          <li><a href="http://as.sjsu.edu/asts/index.jsp?val=getting_started">Bicycle Enclosures</a></li>
          <li><a href="http://as.sjsu.edu/asts/index.jsp?val=asts_home">Trip Plans &amp; Maps</a></li>
        </ul>
        <a href="http://as.sjsu.edu/cccac/" class="footerLink">Community Action Center</a>
        <ul>
          <li><a href="http://as.sjsu.edu/cccac/index.jsp?val=cccac_altspring">Alternative Spring Break</a></li>
          <li><a href="http://as.sjsu.edu/cccac/index.jsp?val=cccac_serviceoppor">Volunteer Directory</a></li>
          <li><a href="http://as.sjsu.edu/cccac/index.jsp?val=cccac_media">Media Center</a></li>
          <li><a href="http://as.sjsu.edu/cccac/index.jsp?val=cccac_calendar">Calendar of Events</a></li>
        </ul>
      </div>
      <div class="col"> <a href="http://as.sjsu.edu/asgov/index.jsp" class="footerLink">Government</a>
        <ul>
          <li><a href="http://as.sjsu.edu/asgov/index.jsp?val=gov_current">BOD Agendas &amp; Minutes</a></li>
          <li><a href="http://as.sjsu.edu/asgov/index.jsp?val=c_finance">Organization Funding</a></li>
          <li><a href="http://as.sjsu.edu/asgov/index.jsp?val=asgov_home">Join the Board/Committees</a></li>
          <li><a href="http://as.sjsu.edu/asdocs/OpenDoc.jsp?id=1076">A.S. Annual Report</a></li>
        </ul>
        <a href="http://as.sjsu.edu/asps/index.jsp" class="footerLink">Print Shop </a>
        <ul>
          <li><a href="http://as.sjsu.edu/asps/index.jsp?val=ps_services">Printing Services</a></li>
          <li><a href="http://as.sjsu.edu/asps/index.jsp?val=ps_prices">Price List</a></li>
          <li><a href="http://as.sjsu.edu/asps/index.jsp?val=ps_coursereader">Course Reader</a> </li>
        </ul>
      </div>
      <div id="col5" class="col"> <a href="#" class="footerLink">Other Resources</a>
        <ul id="employeeMenu">
          <li><a href="http://blogs.sjsu.edu/today/tag/associated-students/">A.S. in SJSU Today</a></li>
          <li><a href="http://as.sjsu.edu/spartansquad/">Spartan Squad</a></li>
          <li><a href="http://as.sjsu.edu/legacy/" >The TSJC Project</a></li>
          <li><a href="http://as.sjsu.edu/ashouse/index.jsp?val=conference_rooms">Conference Room/BBQ</a></li>
          <li><a href="http://as.sjsu.edu/asevents/" >Events</a></li>
          <li><a href="http://as.sjsu.edu/aslogos/index.jsp">Download A.S. Logos </a></li>
          <li><a href="http://as.sjsu.edu/emptimecard/index1.jsp?val=esign#">Employee</a>
            <ul>
              <li><a title="Applications" href="http://as.sjsu.edu/emptimecard/welcomepage.jsp">APPLICATIONS</a></li>
              <li><a title="Ultimate" target="_blank" href="http://130.65.61.157">ULTIMATE</a></li>
              <li><a title="HelpDesk" href="http://130.65.61.15/tiweb80">HELPDESK</a></li>
              <li><a title="Old Timecard" href="http://as.sjsu.edu/timecard/jsp/index.jsp?val=as_em_signin">WorkStudy TC</a></li>
              <li><a title="Applications" href="http://as.sjsu.edu/uploadLogin/index.jsp">Other Apps</a></li>
              <li><a title="E-mail Access" href="http://mail.as.sjsu.edu">E-MAIL</a></li>
            </ul>
          </li>
        </ul>
      </div>
      <a class="footerlogo" target="_blank" href="http://sjsu.edu" title="San Jose State University"></a> </div>
    <div class="copyright">Copyright &copy; Associated Students, SJSU. All rights reserved. </div>
  </div>
</div>

<!--employee drop down menu--> 

<script>

   // Use jQuery via jQuery(...)

	jQuery(document).ready(function () {

			jQuery('#employeeMenu li').hover(

					function () {

						//show its submenu

						jQuery('ul', this).fadeIn();

					},

					function () {

						//hide its submenu

						jQuery('ul', this).delay(400).fadeOut('slow');

					}

			);

	}); 

</script> 
<script language="javascript">

function getDocHeight() {
    var D = document;
    return Math.max(
        Math.max(D.body.scrollHeight, D.documentElement.scrollHeight),
        Math.max(D.body.offsetHeight, D.documentElement.offsetHeight),
        Math.max(D.body.clientHeight, D.documentElement.clientHeight)
    );
}

function showOverlayBox() {
	//if box is not set to open then don't do anything
	if( isOpen == false ) return;
	// set the properties of the overlay box, the left and top positions
    $('.divoverlayBox').css({
        //left:( $(window).width() - $('.divoverlayBox').width() )/2-100,
        //top: ($(window).height() - $('.divoverlayBox').height()) / 2,
        position: 'fixed',
		display: 'block'
	});
	// set the window background for the overlay. i.e the body becomes darker
    $('.bgCover').css({
        display: 'block',
        width: $(window).width(),
        height: getDocHeight()	
    });
	
}
function doOverlayOpen() {
	//set status to open
	isOpen = true;
	showOverlayBox();
	
	if ($.browser.msie) {

    $('.bgCover').css("opacity", 0.5);

} else {

    $('.bgCover').css({

        opacity:0

    }).animate( {

        opacity:0.5,
        backgroundColor:'#000'

    }); //end of animate

}
	return false;
}
function doOverlayClose() {
	//set status to closed
	isOpen = false;
	$('.divoverlayBox').css( 'display', 'none' );
	// now animate the background to fade out to opacity 0
	// and then hide it after the animation is complete.
	//$('.bgCover').animate( {opacity:0}, null, null, function() { $(this).hide(); } );
	$('.bgCover').css( 'display', 'none' );
}
// if window is resized then reposition the overlay box
$(window).bind('resize',showOverlayBox);
// activate when the link with class launchLink is clicked
//$('a.launchLink').click( doOverlayOpen );
// close it when closeLink is clicked
//$('a.closeLink').click( doOverlayClose );

</script>
</body>
</html>
