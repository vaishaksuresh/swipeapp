<cfapplication sessionmanagement="yes" sessiontimeout="#CreateTimeSpan(0,0,30,0)#">
<section id="pages" class="group">
  <div id="loadcontent" class="group">
    <section class="sectionlist show" id="formarea">
      <!---<cfset basicquery= "Select student_id,email,name,phone_number,major,year_in_college,area_of_interest,area_of_interest_value,
	  signup_date,last_login_date,last_update_date,last_update_mode,total_login_count, case subscribed_to_newsletter
	  when 1 THEN 'Yes' ELSE 'No' END as 'NewsLetter'
	  from ccac_registered_users">
      <cfquery name="getAllUsers" datasource="cccac_swipe" result="UserDetailsResult">
		  <cfoutput>#preserveSingleQuotes(basicquery)#</cfoutput>
		</cfquery>--->
      <cfparam name="url.pageSize" default="10">
      <cfform style="padding-left:15px;">
        <cfgrid name = "FirstGrid" format="html" pagesize="#url.pageSize#" selectmode="row"
         bind="cfc:cfcomponents.listStudentsComponent.getStudents({cfgridpagesize},{cfgridpage},{cfgridsortcolumn},{cfgridsortdirection})" align="left" autowidth="yes">
          <cfgridcolumn name="student_id" header="Student ID"/>
          <!---<cfgridcolumn name="email" header="Email" >--->
          <cfgridcolumn name="name" header="Name" >
          <!---<cfgridcolumn name="phone_number" header="Phone Number" >
          <cfgridcolumn name="major" header="Major" >
          <cfgridcolumn name="year_in_college" header="year_in_college" >--->
          <cfgridcolumn name="area_of_interest" header="area_of_interest" >
          <cfgridcolumn name="area_of_interest_value" header="Other Interest">
          <!---<cfgridcolumn name="signup_date" header="signup_date" >--->
          <!---<cfgridcolumn name="last_login_date" header="Last Login" >
          <cfgridcolumn name="last_update_date" header="Last Update" >--->
          <!---<cfgridcolumn name="last_update_mode" header="last_update_mode" >--->
          <cfgridcolumn name="total_login_count" header="Total Login" >
          <cfgridcolumn name="NewsLetter" header="NewsLetter Subscription" >
        </cfgrid>
        </br>
        <input type="button" class="blue_button" name="Download" value="Download" onclick="javascript:exporttoexcel()">
        </br>
        </br>
        <cfinvoke component="cfcomponents.listStudentsComponent" method="getStudents" returnvariable="userStruct">
        <cfinvokeargument name="pageSize" value="#url.pageSize#">
        <cfinvokeargument name="pageNo" value="1">
        <cfinvokeargument name="gridsortcolumn" value="student_id">
        <cfinvokeargument name="gridsortdirection" value="ASC">
        </cfinvoke>
        <!--- <cfoutput query="userStruct.Query"> <div id="#trim(userStruct.Query.student_id)#" style="display:none">
        Name: #userStruct.Query.name#<br>
        Subscription: #userStruct.Query.NewsLetter#<br><br>
        </div></cfoutput>--->
        <div id="details"> </div>
      </cfform>
    </section>
  </div>
  <cfajaxproxy bind="javascript:noteChange({FirstGrid.name},{FirstGrid.email},{FirstGrid.last_login_date},{FirstGrid.last_update_date},{FirstGrid.last_update_mode},{FirstGrid.NewsLetter},{FirstGrid.attendedevents})">
  <script>
	function noteChange(name,email,lastlogin,lastupdate,lastupdatemode,subscription,attendedevents) {
		$('#details').html("<p>Name: "+name+"<br>Email: "+email+"<br>Last Login: "+lastlogin+"<br>Attended Events: "+attendedevents+"<br>Last Update: "+lastupdate+","+lastupdatemode+"<br>Newsletter Subscription: "+subscription+"</p>");
	}
	function exporttoexcel() { 
	  var mygrid = ColdFusion.Grid.getGridObject('FirstGrid'); 
	  var mydata = mygrid.getStore(); 
	  var params = mydata.lastOptions.params; 
	  var sort = params.sort; 
	  var dir = params.dir; 
	  page = params.start/params.limit+1; 
	  window.open('download.cfm?page='+page+'&sort='+sort+'&dir='+dir+'&size='+params.limit); 
	} 
</script>
  <!-- Load Content -->
</section>
