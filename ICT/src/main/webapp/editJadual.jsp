<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
     <sql:setDataSource
         var="ic"
        driver="oracle.jdbc.OracleDriver"
url="jdbc:oracle:thin:@localhost:1521:XE"
user = "eschedule"
password="system"
      />
      <sql:query dataSource="${ic}" var="oc">
         SELECT * from speaker where speakerid>0
      </sql:query>
      <sql:query dataSource="${ic}" var="oe">
         SELECT * from topic where topicid>0
      </sql:query>
<%
    Class.forName("oracle.jdbc.OracleDriver");
    String dbURL = "jdbc:oracle:thin:@localhost:1521:XE";
    String user = "eschedule";
    String pass = "system";
    String id=request.getParameter("id");
    int num=Integer.parseInt(id);
    String date="scheduledate";
    String sql= "select scheduleid,to_char(scheduledate,'YYYY-MM-DD')"+date+",scheduletime from schedule where scheduleid='"+num+"'";
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
    <div class="custform">
        <form class="speaker" method="post">
            <input type="hidden" name="id" value='<%=rs.getString("scheduleid") %>'/>
            <div class="dataa">
                <label>   Tarikh </label>
                <input type="date" name="scDate"  value='<%=rs.getString("scheduledate") %>' disabled>
            </div>
            <div class="dataa">
                <label>  Masa</label>
                <input type="text" name="scTime" value='<%=rs.getString("scheduletime") %>' disabled>
            </div>
            <div class="dataa">
            <label>  Penceramah</label>
                	<select name="scSpeaker">
                           <option value="0">Pilih Penceramah...</option>
                           <c:forEach var="result" items="${oc.rows}">
                              <option value="${result.speakerid}">${result.speakername}</option>
                           </c:forEach>
                        </select>
            </div>
            <div class="dataa">
            <label>  Tajuk</label>
                	<select name="scTopic">
                           <option value="0">Pilih Tajuk...</option>
                           <c:forEach var="result" items="${oe.rows}">
                              <option value="${result.topicid}">${result.topicname}</option>
                           </c:forEach>
                        </select>
            </div>
            <%} %>
            <div id="mybutton" class="button">
                <button type="cancel" name="action"  value="cancel" formaction="ScheduleServlet">BATAL</button>
                <input type="hidden" name="action" value="updateSchedule">
                <button type="submit" formaction="ScheduleServlet" onclick="return confirm('Yakin untuk simpan ?');">KEMASKINI</button>
                <br><br>
            </div>
        </form>
    </div>
</div>

</body>
</html>