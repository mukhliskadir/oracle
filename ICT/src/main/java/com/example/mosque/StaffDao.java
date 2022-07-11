package com.example.mosque;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;

import static java.lang.System.out;

public class StaffDao {
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
    public void addStaff (Staff stf) throws SQLException {

        // try-with-resource statement will auto close the connection.
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement
            		 ("insert into staff(staffname,staffphoneno,staffrole,staffusername,staffpass,supervisorid) values(?,?,?,?,?,?)"))

        {
        	ps.setString(1,stf.getStaffName());
        	ps.setString(2,stf.getStaffPhone());
        	ps.setString(3,stf.getStaffRole());
        	ps.setString(4,stf.getStaffUsername());
        	ps.setString(5,stf.getStaffPassword());
        	ps.setInt(6, stf.getSvid());
        	


      
            out.println(ps);
            ps.executeUpdate();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
    public boolean deleteStaff(int id) throws SQLException {
        boolean rowDeleted;
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement("delete from staff where staffid=?");) {
            statement.setInt(1, id);
            rowDeleted = statement.executeUpdate() > 0;
        }
        return rowDeleted;
    }
    public void addEdu (Imam i) throws SQLException {

        // try-with-resource statement will auto close the connection.
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement
            		 ("insert into imam(staffid,education) values(?,?)"))

        {
        	ps.setInt(1, i.getId());
        	ps.setString(2, i.getEducation());
        	
      
            out.println(ps);
            ps.executeUpdate();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
    public void updateStaff (Staff stf) throws SQLException {

        // try-with-resource statement will auto close the connection.
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement
            		 ("update staff set staffname=?,staffphoneno=?,staffusername=?,staffpass=?,supervisorid=? where staffid=?"))

        {
        	ps.setString(1,stf.getStaffName());
        	ps.setString(2,stf.getStaffPhone());
        	ps.setString(3,stf.getStaffUsername());
        	ps.setString(4,stf.getStaffPassword());
        	ps.setInt(5, stf.getSvid());
        	ps.setInt(6, stf.getId());
        	


      
            out.println(ps);
            ps.executeUpdate();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
}
