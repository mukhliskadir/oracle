package com.example.mosque;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;

import static java.lang.System.out;

public class SpeakerDao {
    String dbURL = "jdbc:oracle:thin:@localhost:1521:XE";
    String user = "eschedule";
    String pass = "system";

    protected Connection getConnection() {
        Connection con = null;
        try {
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
    public void addSpeaker (Speaker spk) throws SQLException {

        // try-with-resource statement will auto close the connection.
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement
                     ("insert into speaker(speakername,speakerphoneno,speakereducation) values(?,?,?)"))
        {

            ps.setString(1, spk.getSpeakerName());
            ps.setString(2, spk.getSpeakerPhone());
            ps.setString(3, spk.getSpeakerEdu());
            out.println(ps);
            ps.executeUpdate();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
    public boolean deleteSpeaker(int id) throws SQLException {
        boolean rowDeleted;
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement("delete from speaker where speakerid=?");) {
            statement.setInt(1, id);
            rowDeleted = statement.executeUpdate() > 0;
        }
        return rowDeleted;
    }
    public void updateSpeaker (Speaker spk) throws SQLException {

        // try-with-resource statement will auto close the connection.
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement
                     ("update speaker set speakername=?,speakerphoneno=?,speakereducation=?WHERE speakerid = ?"))
        {

            ps.setString(1, spk.getSpeakerName());
            ps.setString(2, spk.getSpeakerPhone());
            ps.setString(3, spk.getSpeakerEdu());
            ps.setInt(4, spk.getId());
            ps.executeUpdate();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

}