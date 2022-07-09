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


<sql:setDataSource 
				   var="ic" driver="oracle.jdbc.OracleDriver"
                   url="jdbc:oracle:thin:@localhost:1521:XE"
                   user = "eschedule"
                   password="system"/>
                   
<sql:query dataSource="${ic}" var="staff">
    SELECT RANK() OVER(ORDER BY staffid) "rank",staffid,staffname,staffphoneno,staffusername,staffpass,staffrole from staff
</sql:query>

<%@include file="navbar.jsp"%>

<div class="content" >
    <br>
    <h2>USRUS AKAUN</h2>
    <div id="mybutton" class="button">
        <button class="add" type="add" value="add" onclick="location.href='addStaff.jsp'">TAMBAH</button>
    </div>
    <input type="text" id="myInput" onkeyup="cariPenceramah()" placeholder="Cari penceramah.." title="Type in a name">
    <div style="overflow-x:auto;">
        <table style="text-align: center;" id="listPenceramah">
            <tr>
                <th onclick="sortTable(0)" style="width: 80px; height: 50px;">⥯ No.</th>
                <th onclick="sortTable(1)" style="width:400px;">⥯ Nama</th>
                <th onclick="sortTable(2)" style="width: 300px;">⥯ No. Telefon</th>
                <th onclick="sortTable(4)" style="width: 450px;">⥯ Jawatan</th>
                <th style="width: 100px;">Tindakan</th>
            </tr>
            <c:forEach var="result" items="${staff.rows}">
                <tr>
                    <td >
                        <c:out value="${result.rank}"/>
                    </td>
                    <td >
                        <c:out value="${result.staffname}"/>
                    </td>
                    <td>
                        <c:out value="${result.staffphoneno}"/>
                    </td>
                    <td>
                        <c:out value="${result.staffrole}"/>
                    </td>
                 
                    <td>
                                     <c:if test="${result.staffid!='1'}">
                    
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
                                          </c:if>
                        
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
    <br><br><br>
</div>

</body>
<style>
    h3{color: black;}
    #myInput{display: inline-block;width: 500px ;}
</style>

</html>