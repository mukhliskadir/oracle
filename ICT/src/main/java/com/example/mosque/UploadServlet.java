package com.example.mosque;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;




@WebServlet("/UploadServlet")
@MultipartConfig(maxFileSize = 16177215) // upload file up to 16MB
public class UploadServlet extends HttpServlet {

	private static final long serialVersionUID = -1623656324694499109L;
	
	String dbURL = "jdbc:oracle:thin:@localhost:1521:XE";
    String user = "eschedule";
    String pass = "system";
    
    protected Connection getConnection() throws IOException {
        Connection con = null;
        try {
        	  Properties prop = new Properties();
              InputStream inputStream = AnnouncementDao.class.getClassLoader().getResourceAsStream("");
              prop.load(inputStream);
            Class.forName("oracle.jdbc.OracleDriver");
            con = DriverManager.getConnection(dbURL, user, pass);
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return con;

    }

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		// gets values of text fields
			String title = request.getParameter("aTitle");
	        String desc = request.getParameter("aDesc");
	        String date = request.getParameter("aDate");
	        String timme = request.getParameter("aTime");

		InputStream inputStream = null;

		// obtains the upload file part in this multipart request
		Part filePart = request.getPart("aPicture");
		if (filePart != null) {
			// debug messages
			System.out.println(filePart.getName());
			System.out.println(filePart.getSize());
			System.out.println(filePart.getContentType());

			// obtains input stream of the upload file
			inputStream = filePart.getInputStream();
		}

		String message = null; // message will be sent back to client

		try {Connection con = getConnection();
			// constructs SQL statement
			String sql = "insert into announcement(announcementpicture,announcementtitle,announcementdesc,announcementdate,announcementtime) values(?,?,?,?,?)";

			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(2, title);
            ps.setString(3, desc);
            ps.setDate(4, Date.valueOf(date));
            ps.setString(5, timme);

			if (inputStream != null) {
				// fetches input stream of the upload file for the blob column
				ps.setBlob(1, inputStream);
			}

			// sends the statement to the database server
			int row = ps.executeUpdate();
			if (row > 0) {
				message = "Image is uploaded successfully into the Database";
			}
		} catch (SQLException ex) {
			message = "ERROR: " + ex.getMessage();
			ex.printStackTrace();
		}
		// sets the message in request scope
        response.sendRedirect("Announcement.jsp");
	}
}