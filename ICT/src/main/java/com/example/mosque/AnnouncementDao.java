package com.example.mosque;


import javax.servlet.annotation.MultipartConfig;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Properties;


public class AnnouncementDao {
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
    public void addAnnouncement (Announcement anc) throws SQLException {

        // try-with-resource statement will auto close the connection.
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement
                     ("insert into announcement(announcementpicture,announcementtitle,announcementdesc,announcementdate,announcementtime) values(?,?,?,?,?)"))
        {

            ps.setBlob(1, (Blob) anc.getPicture());
            ps.setString(2, anc.getTitle());
            ps.setString(3, anc.getDescr());
            ps.setDate(4, anc.getDate());
            ps.setString(5, anc.getTime());

            ps.executeUpdate();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
    public boolean deleteAnnouncement(int id) throws SQLException, IOException {
        boolean rowDeleted;
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement("delete from announcement where announcementid=?");) {
            statement.setInt(1, id);
            rowDeleted = statement.executeUpdate() > 0;
        }
        return rowDeleted;
    }
    public boolean updateAnnouncement(Announcement anc) throws SQLException, IOException {
        boolean rowUpdated;
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement("update announcement set announcementtitle=?,announcementdesc=?,announcementdate=?,announcementtime=? where announcementid=?");) {

            ps.setString(1, anc.getTitle());
            ps.setString(2, anc.getDescr());
            ps.setDate(3, anc.getDate());
            ps.setString(4, anc.getTime());
        	ps.setInt(5, anc.getId());
            rowUpdated = ps.executeUpdate() > 0;
        }
        return rowUpdated;
    }
}
	
