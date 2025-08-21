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
public class SignUp {
    private String email;

    public SignUp(String email) {
        this.email = email;
    }
    
    public String getHashPassword(Connection conn) throws SQLException{
        String query = "SELECT password FROM users WHERE email=?;";
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setString(1, this.email);
        ResultSet rs = pstmt.executeQuery();
        if(rs.next()){
            return rs.getString("password");
        }else{
            return "";
        }
    }
}
