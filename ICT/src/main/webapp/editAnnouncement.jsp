<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>

<%@ page import="java.sql.*"%>

<%@ page import="java.io.*"%>
<!DOCTYPE html>
<html>
<head>
  <title></title>
  <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="css/style.css">
  <script src="https://kit.fontawesome.com/9bff21277a.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  
</head>
<body>
<%
Blob image = null;byte[ ] imgData = null ;

Class.forName("oracle.jdbc.OracleDriver");
String dbURL = "jdbc:oracle:thin:@localhost:1521:XE";
String user = "eschedule";
String pass = "system";
String id=request.getParameter("id");
int num=Integer.parseInt(id);
String date="announcementdate";
String sql= "select to_char(announcementdate,'YYYY-MM-DD')"+date+",announcementid,announcementtitle,announcementdesc,announcementtime from announcement where announcementid='"+num+"'";
Connection con=DriverManager.getConnection(dbURL, user, pass);
Statement stmt=con.createStatement();
ResultSet rs=stmt.executeQuery(sql);
while(rs.next())
{


%>
    
<%@include file="navbar.jsp"%>

<div class="content">
  
  <br>
  <h2>PENCERAMAH</h2>   

 
        
      <div class="ANNOUNCEMENTFORM">
         <form class="announcement" method="post" enctype="multipart/form-data">
      <div class="dataa">
 
    <div class="dataa">
     <label>   Tajuk </label>
        <input type="text" name="aTitle" value='<%=rs.getString("announcementtitle") %>' >
    </div>
    <div class="dataa">
    <label>    Tarikh</label>
        <input type="date" name="aDate" value='<%=rs.getString("announcementdate") %>'>
    </div>
    <div class="dataa">
    <label>    Masa</label>
        <input type="time" name="aTime" value='<%=rs.getString("announcementtime") %>'>
  	</div><div class="dataa">
      <label>  Maklumat</label>
        <textarea type="text" name="aDesc" style="height:200px;" > <%=rs.getString("announcementdesc") %></textarea>
    </div>
        <div class="dataa">
    <input type="hidden" name="id" value='<%=rs.getString("announcementid") %>'/>  </div>
  
    <%} %>
    
     <div id="mybutton" class="button">
             <button type="cancel" name="action"  value="cancel" formaction="AnnouncementServlet">CANCEL</button>
          <input type="hidden" name="action" value="updateAnnouncement">
                        <button type="submit" formaction="AnnouncementServlet">Update</button>
                         </div>
  </form>
<br><br>
 </div>


    
          
<br><br><br>

 

</body>
<script type="text/javascript">{var dt = new Date();
document.getElementById("datetime").innerHTML = dt.toLocaleString();}

 function functionAlert(msg, myYes) {
        
            var confirmBox = $("#confirm");
            confirmBox.find(".message").text(msg);
            confirmBox.find(".yes").unbind().click(function() {
              alert("Success! Changes has been saved succesfully!");
              window.location.href = "cth.html";
               confirmBox.hide();
            });
            confirmBox.find(".no").unbind().click(function() {
               confirmBox.hide();
            });
            confirmBox.find(".yes").click(myYes);
            confirmBox.show();}
 var loadFile = function(event) {
	  var image = document.getElementById('output');
	  image.src = URL.createObjectURL(event.target.files[0]);
	};

</script>
<style type="text/css">
  h3{color: black;}
  #myInput{display: inline-block;width: 500px ;}
    .ANNOUNCEMENTFORM{display:inline-block;}
  .divposter{padding:1px;background-color:#7F7F7F;height:440px;width:660px; box-shadow: 0px 5px 10px 0px rgba(0, 0, 0, 0.5);}
  #output{max-width:600px;}
</style>
</html>