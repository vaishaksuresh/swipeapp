<cfparam name="url.page" default="1">
<cfparam name="url.limit" default="10">
<cfparam name="url.sort" default="student_id">
<cfparam name="url.dir" default="">

<cfinvoke component="cfcomponents.listStudentsComponent" method="getStudents" pageNo="#url.page#" 
            pageSize="#url.size#" gridsortcolumn="#url.sort#" gridsortdirection="#url.dir#"
            returnVariable="result">
<cfheader name="Content-Disposition" value="inline; filename=download.xls">
<cfcontent type="application/vnd.ms-excel">
<table>
  <tr>
    <th>Student ID</th>
    <th>Name</th>
    <th>Email</th>
    <th>Phone Number</th>
    <th>Major</th>
    <th>Year in College</th>
    <th>Areas of Interest</th>
    <th>Other Areas</th>
    <th>Total Logins</th>
    <th>Signup Date</th>
    <th>Last Login Date</th>
    <th>Last Update Date</th>
    <th>Last Update Mode</th>
    <th>Newsletter Subscription</th>
    <th>Attended Events</th>
  </tr>
  <cfoutput query="result.query">
    <tr>
      <td>#student_id#</td>
      <td>#name#</td>
      <td>#email#</td>
      <td>#phone_number#</td>
      <td>#major#</td>
      <td>#year_in_college#</td>
      <td>#area_of_interest#</td>
      <td>#area_of_interest_value#</td>
      <td>#total_login_count#</td>
      <td>#signup_date#</td>
      <td>#last_login_date#</td>
      <td>#last_update_date#</td>
      <td>#last_update_mode#</td>
      <td>#NewsLetter#</td>
      <td>#attendedevents#</td>
    </tr>
  </cfoutput>
</table>
</cfcontent>
