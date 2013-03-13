<cfparam name="url.page" default="1">
<cfparam name="url.limit" default="10">
<cfparam name="url.sort" default="student_id">
<cfparam name="url.dir" default="">

<cfinvoke component="cfcomponents.listStudentsComponent" method="getStudents" pageNo="#url.page#" 
            pageSize="#url.size#" gridsortcolumn="#url.sort#" gridsortdirection="#url.dir#"
            returnVariable="result">

<cfheader name="Content-Disposition" value="inline; filename=download.pdf">
<cfdocument format="pdf">
   <table width="100%" border="1">
    <tr>
        <th>Student ID</th>
        <th>Name</th>
        <th>Areas of Interest</th>
        <th>Other Areas</th>
        <th>Total Logins</th>
        <th>Signup Date</th>
        <th>Last Update Date</th>
        <th>Last Update Mode</th>
        
    </tr>
    <cfoutput query="result.query">
    <tr>
        <td>#student_id#</td>
        <td>#name#</td>
        <td>#area_of_interest#</td>
        <td>#area_of_interest_value#</td>
        <td>#total_login_count#</td>
        <td>#signup_date#</td>
        <td>#last_update_date#</td>
        <td>#last_update_mode#</td>
    </tr>
    </cfoutput>
</table>

</cfdocument>