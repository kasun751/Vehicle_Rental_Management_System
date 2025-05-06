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
   private int userID;
   private String firstname; 
   private String lastname; 
   private String phone; 
   private String email; 
   private String address; 
   private String city; 
   private String nic; 
   private String password; 
   private String account_type; 

    public Users() {
    }

    public Users(String email, String password) {
        this.email = email;
        this.password = MD5.getMd5(password);
    }  

    public int getUserID() {
        return userID;
    }
    
    public String getFirstname() {
        return firstname;
    }

    public String getLastname() {
        return lastname;
    }

    public String getPhone() {
        return phone;
    }

    public String getEmail() {
        return email;
    }

    public String getAddress() {
        return address;
    }

    public String getCity() {
        return city;
    }

    public String getNic() {
        return nic;
    }

    public String getPassword() {
        return password;
    }

    public String getAccount_type() {
        return account_type;
    }

    public Users(String firstname, String lastname, String phone, String email, String address, String city, String nic, String account_type) {
        this.firstname = firstname;
        this.lastname = lastname;
        this.phone = phone;
        this.email = email;
        this.address = address;
        this.city = city;
        this.nic = nic;
        this.account_type = account_type;
    }
    

    public Users(String firstname, String lastname, String phone, String email, String address, String city, String nic, String password,String account_type) {
        this.firstname = firstname;
        this.lastname = lastname;
        this.phone = phone;
        this.email = email;
        this.address = address;
        this.city = city;
        this.nic = nic;
        this.account_type = account_type;
        this.password = MD5.getMd5(password);
    }

    public Users(int userID, String firstname, String lastname, String phone, String email, String address, String city, String nic, String account_type) {
        this.userID = userID;
        this.firstname = firstname;
        this.lastname = lastname;
        this.phone = phone;
        this.email = email;
        this.address = address;
        this.city = city;
        this.nic = nic;
        this.password = password;
        this.account_type = account_type;
    }

    public Users(int userID,String firstname, String lastname, String phone, String address, String city, String nic) {
        this.userID = userID;
        this.firstname = firstname;
        this.lastname = lastname;
        this.phone = phone;
        this.address = address;
        this.city = city;
        this.nic = nic;
    }
    
   
   public boolean addUsers(Connection conn) throws SQLException{
       
       String query = "INSERT INTO users(firstname,lastname,phoneNumber,email,address,city,nic,password,account_type) VALUES(?,?,?,?,?,?,?,?,?);";
       PreparedStatement pstmt = conn.prepareStatement(query);
       pstmt.setString(1, this.firstname);
       pstmt.setString(2, this.lastname);
       pstmt.setString(3, this.phone);
       pstmt.setString(4, this.email);
       pstmt.setString(5, this.address);
       pstmt.setString(6, this.city);
       pstmt.setString(7, this.nic);
       pstmt.setString(8, this.password);
       pstmt.setString(9, this.account_type);
       
       int result = pstmt.executeUpdate();       
       return result>0;
   }
   public boolean updateUsers(Connection conn) throws SQLException{
       
       //String query = "INSERT INTO users(firstname,lastname,phoneNumber,address,city,nic) VALUES(?,?,?,?,?,?);";
       String query = "UPDATE users SET firstname = ?,"
               + "lastname= ?"
               + ",phoneNumber= ?"
               + ",address= ?"
               + ",city= ?"
               + ",nic= ?"
               + "WHERE userID = ?;";
       PreparedStatement pstmt = conn.prepareStatement(query);
       pstmt.setString(1, this.firstname);
       pstmt.setString(2, this.lastname);
       pstmt.setString(3, this.phone);
       pstmt.setString(4, this.address);
       pstmt.setString(5, this.city);
       pstmt.setString(6, this.nic);
       pstmt.setInt(7, this.userID);
       
       int result = pstmt.executeUpdate();       
       return result>0;
   }
   
   public boolean validateUser(Connection conn) throws SQLException{
       String password="";
       String query = "select password from users where email=?;";
       PreparedStatement pstmt = conn.prepareStatement(query);
       pstmt.setString(1, this.email);
       ResultSet rs = pstmt.executeQuery();
       if(rs.next()){
           password = rs.getString("password");
       }
       if(this.password.equals(password)){
           return true;
       }else{
           return false;
       }
   }
   public boolean checkEmailAvailability(Connection conn,String email) throws SQLException{
       String query = "select * from users where email=?;";
       PreparedStatement pstmt = conn.prepareStatement(query);
       pstmt.setString(1, email);
       ResultSet rs = pstmt.executeQuery();
       return !rs.next();
   }
   public Users getUserByID(Connection conn, int ID) {
    Users user = null;
    String query = "SELECT * FROM users WHERE userID = ?";

    try (PreparedStatement pstmt = conn.prepareStatement(query)) {
        pstmt.setInt(1, ID);

        try (ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                user = new Users(
                    rs.getString("firstname"),
                    rs.getString("lastname"),
                    rs.getString("phoneNumber"),
                    rs.getString("email"),
                    rs.getString("address"),
                    rs.getString("city"),
                    rs.getString("nic"),
                    rs.getString("account_type")
                );
            }
        }
    } catch (Exception e) {
        e.printStackTrace(); // Use logging in a real-world scenario
    }

    return user;
}
   public Users getUserByUserName(Connection conn, String username) {
    Users user = null;
    String query = "SELECT * FROM users WHERE email = ?";

    try (PreparedStatement pstmt = conn.prepareStatement(query)) {
        pstmt.setString(1, username);

        try (ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                user = new Users(
                    rs.getInt("userID"),
                    rs.getString("firstname"),
                    rs.getString("lastname"),
                    rs.getString("phoneNumber"),
                    rs.getString("email"),
                    rs.getString("address"),
                    rs.getString("city"),
                    rs.getString("nic"),
                    rs.getString("account_type")
                );
            }
        }
    } catch (Exception e) {
        e.printStackTrace(); // Use logging in a real-world scenario
    }

    return user;
}
   public String getUserTypebyUsername(Connection conn,String username) throws SQLException{
       String query = "select account_type from users where email=?;";
       try(PreparedStatement pstmt = conn.prepareStatement(query)){
           pstmt.setString(1, username);
           ResultSet rs = pstmt.executeQuery();
           if(rs.next()){
               return rs.getString("account_type");
           }
       }
       return "";
   }

    
}
