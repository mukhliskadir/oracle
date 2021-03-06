package com.example.mosque;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.annotation.MultipartConfig;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 * Servlet implementation class AnnouncementServlet
 */
@WebServlet("/AnnouncementServlet")
@MultipartConfig(maxFileSize = 16177215) // 
public class AnnouncementServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private AnnouncementDao ad;
    public void init() {
        ad = new AnnouncementDao();
    }
    
    
    public AnnouncementServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
        final String JDBC_DRIVER = "oracle.jdbc.OracleDriver";
        final String DB_URL = "jdbc:oracle:thin:@localhost:1521:XE";
        final String User = "eschedule";
        final String Password = "system";
        try {
            Class.forName(JDBC_DRIVER);
            Connection conn = DriverManager.getConnection(DB_URL, User, Password);

            PreparedStatement stmt = conn.prepareStatement("select announcementpicture from announcement where announcementid=?");
            stmt.setLong(1, Long.valueOf(request.getParameter("id")));
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                response.getOutputStream().write(rs.getBytes("announcementpicture"));
            }
            conn.close();
        } catch (Exception e) { 
            e.printStackTrace();
        }
    }


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		 response.setContentType("text/html");

	        String action = request.getParameter("action");
	        try {
	            switch (action) {
	                case "addAnnouncement":
	                	addAnnouncement(request, response);
	                    break;
	                case "deleteAnnouncement":
	                	deleteAnnouncement(request,response);
	                    break;
	                case "updateAnnouncement":
	                	updateAnnouncement(request,response);
	                    break;
	                case "cancel":
	                    cancel(request, response);
	                    break;
	               
	            }

	        } catch (SQLException e) {
	            throw new ServletException(e);
	        }
	    
	}
	private void addAnnouncement(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {

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


        Announcement anc = new Announcement();

        anc.setTitle(title);
        anc.setDescr(desc);
        anc.setDate(Date.valueOf(date));
        anc.setTime(timme);
        anc.setPicture(inputStream);
        
        ad.addAnnouncement(anc);
        response.sendRedirect("Announcement.jsp");
    }
	private void deleteAnnouncement(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("aId"));
        ad.deleteAnnouncement(id);
        response.sendRedirect("Announcement.jsp");
    }
	private void updateAnnouncement(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("aTitle");
        String desc = request.getParameter("aDesc");
        String date = request.getParameter("aDate");
        String timme = request.getParameter("aTime");
	

        
        Announcement anc = new Announcement();
        anc.setId(id);
        anc.setTitle(title);
        anc.setDescr(desc);
        anc.setDate(Date.valueOf(date));
        anc.setTime(timme);

        ad.updateAnnouncement(anc);

        response.sendRedirect("Announcement.jsp");
    }
	
	private void cancel(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
		response.sendRedirect("Announcement.jsp");
	}
}
