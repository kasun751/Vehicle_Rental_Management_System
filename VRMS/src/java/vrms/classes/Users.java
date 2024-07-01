package vrms.classes;


import java.sql.*;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author rkcp8
 */
public class Users {
   private String firstname; 
   private String lastname; 
   private String phone; 
   private String email; 
   private String address; 
   private String city; 
   private String nic; 
   private String password; 

    public Users(String firstname, String lastname, String phone, String email, String address, String city, String nic, String password) {
        this.firstname = firstname;
        this.lastname = lastname;
        this.phone = phone;
        this.email = email;
        this.address = address;
        this.city = city;
        this.nic = nic;
        this.password = password;
    }
   
   public boolean addUsers(Connection conn) throws SQLException{
       
       String query = "INSERT INTO users(firstname,lastname,phoneNumber,email,address,city,nic,password) VALUES(?,?,?,?,?,?,?,?);";
       PreparedStatement pstmt = conn.prepareStatement(query);
       pstmt.setString(1, this.firstname);
       pstmt.setString(2, this.lastname);
       pstmt.setString(3, this.phone);
       pstmt.setString(4, this.email);
       pstmt.setString(5, this.address);
       pstmt.setString(6, this.city);
       pstmt.setString(7, this.nic);
       pstmt.setString(8, this.password);
       
       int result = pstmt.executeUpdate();       
       return result>0;
   }
    
}
