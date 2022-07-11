<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
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
    <h2>IMAM</h2>
    <div class="custform">
        <form class="staff" method="post">
            <input type="hidden" name="id" value='<%=rs.getString("staffid") %>'/>
            <div class="dataa">
                <label>   Nama </label>
                <input type="text" name="staffName" value='<%=rs.getString("staffname") %>' >
            </div>
            <div class="dataa">
                <label>No Telefon</label>
                <input type="text" name="staffPhone" value='<%=rs.getString("staffphoneno") %>'>
            </div>
            <div class="dataa">
                <label>Nama pengguna</label>
                <input type="text" name="staffUsername" value='<%=rs.getString("staffusername") %>'>
            </div>
              <div class="dataa">
                <label>Kata Laluan</label>
                <input type="password" name="staffPassword" value='<%=rs.getString("staffpass") %>'>
            </div>
           
            <%} %>
            <div id="mybutton" class="button">
                <button type="cancel" name="action"  value="cancel" formaction="StaffServlet">BATAL</button>
                <input type="hidden" name="action" value="updateStaff">
                <button type="submit" formaction="StaffServlet" onclick="return confirm('Yakin untuk simpan ?');">SIMPAN</button>
                <br><br>
            </div>
        </form>
    </div>
</div>
<br><br><br>
</body>

<style type="text/css">
    h3{color: black;}
    #myInput{display: inline-block;width: 500px ;}
</style>
</html>