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


<%@include file="navbar.jsp"%>
<div class="content">
    <br>
    <h2>URUS AKAUN</h2>
    <div class="custform">
        <form class="speaker" method="post" action="UploadStaff"  enctype="multipart/form-data">
        <div class="dataa">
     		<label>   Profile </label>
       			 <input type="file"  name="staffPic" id="file"  onchange="loadFile(event)" >
   			</div>
            <div class="dataa">
                <label>   Nama </label>
                <input type="text" name="staffName" value="" >
            </div>
            <div class="dataa">
                <label>No Telefon</label>
                <input type="text" name="staffPhone" value="">
            </div>
            <div class="dataa">
                <label>Nama pengguna</label>
                <input type="text" name="staffUsername" value="">
            </div>
              <div class="dataa">
                <label>Kata Laluan</label>
                <input type="password" name="staffPassword" value="">
            </div>
            <div class="dataa">
                <label>Jawatan</label>
					<select id="select" name="staffRole">
					<option value="Imam">Imam</option>
					<option value="AJK">Ahli Jawatankuasa</option>
					<option value="AJK Multimedia">AJK Multimedia</option>
					
					</select>
			</div>
		
            <div id="mybutton" class="button">
                <button type="cancel" name="action"  value="cancel" formaction="StaffServlet">BATAL</button>
                <input type="hidden" name="action" value="addStaff">
                <button type="submit" class="button button1" name="submit" >TAMBAH</button><br><br>
            </div>
        </form>
    </div>
</div>
<br><br><br>
</body>


</html>