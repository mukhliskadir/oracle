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
    <meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/style.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="JS/script.js"></script>
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
                <link rel="stylesheet" href="css/style.css">
            <link rel="stylesheet" href="css/indexcss.css">
    

    <title>MASJUD ABU UBAIDAH</title>
   
  <div class="headerr">
        <img src="IMG/logo.png" style="width: 500px;max-height: 110px;">
        <button class="account" name="login" type="login" onclick="signAlert()">LOG MASUK</button>
    </div>


<form id="signform" action="LoginServlet" method="post">
    <div class="mssg"> LOG MASUK <br>
        <input type="text" name="username" placeholder="Masukkan nama pengguna" value="" required>
        <input type="password" name="password" placeholder="Masukkan kata laluan" value="" required>
        <button type="cancel" class="cancel" onclick="location.href='index.jsp'">BATAL</button>
        <input type="hidden" name="action" value="login">
        <button type="signin" class="signIn" name="submit">LOG MASUK</button>
    </div>
    </form>
    
</head>
<style>
 #signform .mssg,
    #signupform .msssg {
        font-size: 15px;
    }
</style>
<body>


         
 <div id="navbar" >
    <a  href="#home">JADUAL</a>
    <a href="#slide">PENGUMUMAN</a>
</div>
   
   
 <sql:setDataSource var="ic" driver="oracle.jdbc.OracleDriver"
  								url="jdbc:oracle:thin:@localhost:1521:XE"
								user = "eschedule"
								password="system"/>
<sql:query dataSource="${ic}" var="oc">
	select scheduleid,scheduledate,scheduletime,speakername,topicname,topictheme 
	from schedule s 
	join speaker q 
	on s.speakerid = q.speakerid 
	join topic t 
	on s.topicid = t.topicid 
	where scheduledate >= 
							(select TRUNC(sysdate, 'iw') -1 AS ahad from dual)
	and scheduledate <=
						(SELECT TRUNC(sysdate, 'iw') + 6 - 1/86400 AS sabtu from dual) 
	order by scheduleid
</sql:query>

 <sql:query dataSource="${ic}" var="od">
         SELECT RANK() OVER(ORDER BY announcementid)  "rank",announcementpicture,announcementid,announcementtitle,announcementdesc,to_char(announcementdate,'YYYY-MM-DD')"announcementdate",announcementtime from announcement
 </sql:query>
 


<div class="prayertime">
<iframe src="https://timesprayer.com/widgets.php?frame=2&amp;lang=en&amp;name=kuala-lumpur&amp;avachang=true&amp;fcolor=FCF9BB&amp;scolor=000000&amp;tcolor=C2B069&amp;frcolor=AD901D" style="border: none; overflow: hidden; width: 100%; height: 314px;"></iframe></div>

 <div class="content" ><br>    
  <div id="home">
  <div style="overflow-x:auto;">
  	<p style="font-family: 'Brush Script MT';margin-left:auto;text-align:center;margin-right:auto;font-size:40px">Jadual Kuliah Mingguan</p>
<table id="main">
	<tbody>
		<tr>
			<th style="height:20px;width:100px;">HARI</th>
			<td rowspan="8" style="padding:0px;">
			<table style="text-align: center; margin:0px;width:100%;" id="kuliah">
               <tr>
                <th style="width: 15%;">WAKTU</th>
               	<th style="width: 35%;">PENCERAMAH</th>
               	<th style="width: 40%;">TAJUK</th>
               	<th style="width: 10%;">TEMA</th>
               
               </tr>

<c:forEach var="result" items="${oc.rows}">
                  <tr>
                  	<c:if test="${result.scheduletime=='Dhuha'}">
    				  <td style="background-color: #e6ffcc;">${result.scheduletime}</td>
					</c:if>
					<c:if test="${result.scheduletime=='Maghrib'}">
    				  <td style="background-color: #b3ffff;">${result.scheduletime}</td>
					</c:if>
					
					<!--   -->
					
                     <td >
                        <c:out value="${result.speakername}"/>
                     </td>
                     <td >
                        <c:out value="${result.topicname}"/>
                     </td>
                     <!--   -->
                     
                     <c:if test="${result.topictheme=='Fiqh'}">
     						 <td style="background-color: #ffb3d9;">${result.topictheme}</td>
					</c:if>
					 <c:if test="${result.topictheme=='Akhlak'}">
     						 <td style="background-color: #ffc6b3;">${result.topictheme}</td>
					</c:if>
					 <c:if test="${result.topictheme=='Sirah'}">
     						 <td style="background-color: #e0e0d1;">${result.topictheme}</td>
					</c:if>
					 <c:if test="${result.topictheme=='Tafsir'}">
     						 <td style="background-color: #ffccff;">${result.topictheme}</td>
					</c:if>
					 <c:if test="${result.topictheme=='Akidah'}">
     						 <td style="background-color: #c2c2f0;">${result.topictheme}</td>
					</c:if>
					 <c:if test="${result.topictheme=='-'}">
     						 <td style="background-color: black;">${result.topictheme}</td>
					</c:if>
                   </tr>
                   
          </c:forEach>
          </table>
			</td>
		</tr>
		<tr>
			<td style="background-color:#e6e6e6;">AHAD</td>
		</tr>
		<tr>
			<td style="background-color:#bfbfbf;">ISNIN</td>
		</tr>
		<tr>
			<td style="background-color:#e6e6e6;">SELASA</td>
		</tr>
		<tr>
			<td style="background-color:#bfbfbf;">RABU</td>
		</tr>
		<tr>
			<td style="background-color:#e6e6e6;">KHAMIS</td>
		</tr>
		<tr>
			<td style="background-color:#bfbfbf;">JUMAAT</td>
		</tr>
		<tr>
			<td style="background-color:#e6e6e6;">SABTU</td>
		</tr>
	</tbody>
</table>
  </div>
  
  
  
  <div id="slide">
  	<p style="font-family: 'Brush Script MT';margin-left:auto;text-align:center;margin-right:auto;font-size:40px">Pengumuman</p>
 
 <div class="w3-display-container" style="border:2px solid black;width:1200px;text-align:center;margin-left:auto;margin-right:auto;padding-top:10px;">
<c:forEach var="result" items="${od.rows}">

<div class="w3-display-container mySlides">
          <img style="width:800px;height:500px;" src="${pageContext.servletContext.contextPath }/AnnouncementServlet?id=${result.announcementid}" />
  <div class="description">
         <c:out value="${result.announcementtitle}"/><br>
          <c:out value="${result.announcementdesc}"/><br>
           <c:out value="${result.announcementdate}"/><br>
            <c:out value="${result.announcementtime}"/><br>
  </div>
</div>
</c:forEach>


<button class="w3-button w3-display-left w3-black" onclick="plusDivs(-1)">&#10094;</button>
<button class="w3-button w3-display-right w3-black" onclick="plusDivs(1)">&#10095;</button>

</div>
          
        </div>  
    </div>
          
</div>
<div class="footer" style="height:80px;">


</div>
</body>

<script>
    window.onscroll = function() {
        myFunction()
    };
    var navbar = document.getElementById("navbar");
    var sticky = navbar.offsetTop;

    function myFunction() {
        if (window.pageYOffset >= sticky) {
            navbar.classList.add("sticky")
        } else {
            navbar.classList.remove("sticky");
        }
    }

    function signAlert(msg, myYes) {
        var confirmBox = $("#signform");
        confirmBox.find(".mssg").text(msg);
        confirmBox.find(".signIn").unbind().click(function() {
            confirmBox.hide();
        });
        confirmBox.find(".cancel").unbind().click(function() {
            confirmBox.hide();
        });
        confirmBox.find(".signIn").click(myYes);
        confirmBox.show();
    }
   
</script>
 <script>
    var slideIndex = 1;
    showDivs(slideIndex);

    function plusDivs(n) {
      showDivs(slideIndex += n);
    }

    function showDivs(n) {
      var i;
      var x = document.getElementsByClassName("mySlides");
      if (n > x.length) {slideIndex = 1}
      if (n < 1) {slideIndex = x.length}
      for (i = 0; i < x.length; i++) {
         x[i].style.display = "none";  
      }
      x[slideIndex-1].style.display = "block";  
    }
    </script>
</html>