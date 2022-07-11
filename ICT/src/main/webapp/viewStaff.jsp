<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
    Class.forName("oracle.jdbc.OracleDriver");
    String dbURL = "jdbc:oracle:thin:@localhost:1521:XE";
    String user = "eschedule";
    String pass = "system";
    String id=request.getParameter("id");
    int num=Integer.parseInt(id);
    String sql= "select * from staff left outer join imam using(staffid) where staffid='"+num+"'";
    Connection con=DriverManager.getConnection(dbURL, user, pass);
    Statement stmt=con.createStatement();
    ResultSet rs=stmt.executeQuery(sql);
    while(rs.next())
    {
%>


<%@include file="navbar.jsp"%>
<div class="content">
    <br>
    <h2>MAKLUMAT</h2>
    <div class="">
        NAMA          : <%=rs.getString("staffname") %> <br><br>
        NO. TELEFON   : <%=rs.getString("staffphoneno")%> <br><br>
        JAWATAN		  : <%=rs.getString("STAFFROLE")%> <br><br>
        NAMA PENGGUNA : <%=rs.getString("staffusername")%> <br><br>
        KATA LALUAN   : <%=rs.getString("staffpass")%> <br><br>
        
        PENDIDIKAN	: <%=rs.getString("education")%><br><br>
        
        <%String role =rs.getString("STAFFROLE");        
       	if (role.equals("Imam")){ %>
        <form method="post">
               <button  class="action"  type="edit" formaction="imam.jsp?id=<%=rs.getString("staffid") %>">TAMBAH</button>
         </form>
         <%} %>
        
         <form method="post">
               <button  class="action"  type="edit" formaction="editStaff.jsp?id=<%=rs.getString("staffid") %>">KEMASKINI</button>
         </form>
        
        
    </div>
</div>
  <%} %>
<br><br><br>
</body>

<style type="text/css">
    h3{color: black;}
    #myInput{display: inline-block;width: 500px ;}
</style>
</html>