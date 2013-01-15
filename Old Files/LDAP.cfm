<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>

<body>

<h3>cfldap Example</h3>
<p>Provides an interface to LDAP directory servers. The example uses the 
University of Connecticut public LDAP server. For more public LDAP servers,
see <a href="http://www.emailman.com">http://www.emailman.com</a>.</p>
<p>Enter a name and search the public LDAP resource. 
An asterisk before or after the name acts as a wildcard.</p>
<!--- If form.name exists, the form was submitted; run the query. --->
<cfif IsDefined("form.name")>
    <!--- Check to see that there is a name listed. --->
    <cfif form.name is not "">
        <!--- Make the LDAP query. --->
        <cfldap 
             server = "ldap.virginia.edu"
             action = "query"
             name = "results"
             start = "o=University of Virginia,c=US"
             filter = "cn=#name#"
             attributes = "cn,uid,ou,mobile,mailForwardingAddress"
<!---             attributes = "cn,o,title,mail,telephonenumber"--->
             sort = "cn ASC">
        <!--- Display results. --->
        <center>
        <table border = 1 cellspacing = 2 cellpadding = 2>
            <tr>
                <th colspan = 5>
                    <cfoutput>#results.recordCount# matches found </cfoutput></TH>
            </tr>
            <tr>
                <th><font size = "-1">Name</font></TH>
                <th><font size = "-1">User ID</font></TH>
                <th><font size = "-1">Department</font></TH>
                <th><font size = "-1">Email</font></TH>
                <th><font size = "-1">Phone</font></TH>
            </tr>
            <cfoutput query = "results">
                <tr>
                    <td><font size = "-1">#cn#</font></td>
                    <td><font size = "-1">#uid#</font></td>
                    <td><font size = "-1">#ou#</font></td>
                    <td><font size = "-1">
                        <A href = "mailto:#mailForwardingAddress#">#mailForwardingAddress#</A></font></td>
                    <td><font size = "-1">#mobile#</font></td>
                </tr>
            </cfoutput>
            </table>
            </center>
        </cfif>
</cfif>

<cfform action="#cgi.script_name#" method="POST">
    <p>Enter a name to search in the database.</p>
    <cfinput type="Text" name="name">
    <cfinput type="Submit" value="Search" name="">
</cfform>

</body>
</html>
