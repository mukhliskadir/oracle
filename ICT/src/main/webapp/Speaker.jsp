<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<div id="delete">
    <div class="message">ADAKAH ANDA PASTI UNTUK BUANG?</div>
    <br>
    <button type="cancel" class="no">BATAL</button>
    <button type="delete" class="yes">BUANG</button>
</div>

<div class="sidebar">
    <div class="img"><img src="IMG/contoh.jpg" style="width:120px;height: 120px; margin-top: 50px;margin-left: 40px;border-radius: 50%;border: 2px solid black;">
    </div>
    <%     Object name = session.getAttribute("staffname"); %>
    <div class="profname" style="margin-left: 10px;margin-top: -35px;font-weight: bold;font-size: 20px;margin-bottom: 20px;margin-right: 30px;text-align:center;"><%=name %></div>
    <button type="urusakaun" href="urusakaun.html" value="urusakaun" style="margin-left: 40px;margin-bottom: 40px;">URUS AKAUN</button>
    <a  class="active" href="Speaker.jsp"><i class="fa-solid fa-user"></i>  Penceramah</a>
    <a href="Topic.jsp"><i class="fa-solid fa-moon"></i>  Tajuk</a>
    <a  href="Jadual.jsp"><i class="fa-solid fa-calendar-days"></i>  Jadual</a>
    <a href="Announcement.jsp"><i class="fa-solid fa-volume-high"></i> Pengumuman</a>
    <form method="get" action="StaffServlet">
        <input type="hidden" name="action" value="logout">
        <button id="logot" type="logout">LOGOUT</button>
    </form>
</div>
<sql:setDataSource 
				   var="ic" driver="oracle.jdbc.OracleDriver"
                   url="jdbc:oracle:thin:@localhost:1521:XE"
                   user = "eschedule"
                   password="system"/>
<sql:query dataSource="${ic}" var="oc">
    SELECT RANK() OVER(ORDER BY speakerid) "rank",speakerid,speakername,speakerphoneno,speakereducation from speaker where speakerid>0
</sql:query>
<%@include file="navbar.jsp"%>
<div class="content" >
    <br>
    <h2>PENCERAMAH</h2>
    <div id="mybutton" class="button">
        <button class="add" type="add" value="add" onclick="location.href='addSpeaker.jsp'">TAMBAH</button>
    </div>
    <input type="text" id="myInput" onkeyup="cariPenceramah()" placeholder="Cari penceramah.." title="Type in a name">
    <div style="overflow-x:auto;">
        <table style="text-align: center;" id="listPenceramah">
            <tr>
                <th onclick="sortTable(0)" style="width: 80px; height: 50px;">⥯ No.</th>
                <th onclick="sortTable(1)" style="width:400px;">⥯ Nama</th>
                <th onclick="sortTable(2)" style="width: 300px;">⥯ No. Telefon</th>
                <th onclick="sortTable(4)" style="width: 450px;">⥯ Pendidikan</th>
                <th style="width: 100px;">Tindakan</th>
            </tr>
            <c:forEach var="result" items="${oc.rows}">
                <tr>
                    <td class="no">
                        <c:out value="${result.rank}"/>
                    </td>
                    <td class="name">
                        <c:out value="${result.speakername}"/>
                    </td>
                    <td class="no">
                        <c:out value="${result.speakerphoneno}"/>
                    </td>
                    <td class="id">
                        <c:out value="${result.speakereducation}"/>
                    </td>
                    <td>
                        <form method="post">
                            <button  class="action"  type="edit" formaction="editSpeaker.jsp?id=${result.speakerid}"
                            >KEMASKINI
                            </button>
                        </form>
                        <form method="post">
                            <input type="hidden" name="speakers" value="${result.speakerid}">
                            <input type="hidden" name="action" value="deleteSpeaker">
                            <button  class="action"  type="delete" formaction="SpeakerServlet"  onclick="return confirm('Yakin untuk buang <c:out value="${result.speakername}"/> ?');">BUANG</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
    <br><br><br>
</div>
<style >
    h3{color: black;}
    #myInput{display: inline-block;width: 500px ;}
</style>
</body>
</html>