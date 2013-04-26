
<section id="pages" class="group">
<div id="loadcontent" class="group">
<section class="sectionlist show" id="formarea">
  <cfparam name="url.pageSize" default="10">
  <cfform style="padding-left:15px;">
    <cfgrid name = "eventGrid" format="html" pagesize="#url.pageSize#" selectmode="row"
         bind="cfc:cfcomponents.listStudentsComponent.getStudentsByEvents({cfgridpagesize},{cfgridpage},{cfgridsortcolumn},{cfgridsortdirection})" autowidth="yes">
      <cfgridcolumn name="event_id" header="Event ID" width="75" />
      <cfgridcolumn name="event_name" header="Event Name" width="250" />
      <cfgridcolumn name="event_date" header="Event Date" width="200"/>
      <cfgridcolumn name="total_logins" header="Total Logins" width="100"/>
    </cfgrid>
    </br>
    </br>
  </cfform>
</section>
