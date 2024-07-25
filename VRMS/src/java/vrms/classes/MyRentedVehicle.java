/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vrms.classes;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author rkcp8
 */

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MyRentedVehicle {
    
    private String orderId ;
    private String username;
    private int vehicleID;
    private String rentStartDay;
    private int no_of_days;
    private double order_income	;
    private String order_status;

    // Retrieve vehicle list from database
    public List<Integer> getRentedVehicleIDList(Connection conn, String search) {
        List<Integer> vehicleList = new ArrayList<>();
        String query;
        if (search.equals("")) {
            query = "SELECT vehicleID FROM ordertable WHERE username = ?;";
        } else {
            query = "SELECT vehicleID FROM ordertable WHERE username = ? AND"
                    + " LOWER(vehicleBrand) LIKE ? OR LOWER(model) LIKE ?;";
        }
        try {
            PreparedStatement pstmt = conn.prepareStatement(query);
            if (!search.equals("")) {
                search = '%' + search + '%';
                pstmt.setString(1, this.username);
                pstmt.setString(2, search);
                pstmt.setString(3, search);
            }
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                int vid = rs.getInt("vehicleID");
                vehicleList.add(vid);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return vehicleList;
    }
    
    public Vehicle getObjectByID(Connection conn, int vehicleID){
        Vehicle vehicle = null;
        String query = "select * from vehicleInfo where vehicleID = ? ;";
        try{
            PreparedStatement pstmt = conn.prepareStatement(query);
            ResultSet rs = pstmt.executeQuery();
            if(rs.next()){
                vehicle = new Vehicle(
                        rs.getInt("vehicleID"),
                        rs.getString("vehicleBrand"),
                        rs.getString("model"),
                        rs.getInt("year"),
                        rs.getString("vehicleType"),
                        rs.getInt("seatingCapacity"),
                        rs.getString("fuelType"),
                        rs.getString("transmissionType"),
                        rs.getDouble("mileage"),
                        rs.getDouble("rentalPrice"),
                        rs.getBoolean("availability"),
                        rs.getString("features"),
                        rs.getString("color"),
                        rs.getString("insuranceInfo"),
                        rs.getBoolean("airCondition"),
                        rs.getBoolean("airBags"),
                        rs.getBoolean("electricWindow")
                );
            }
            
        }catch(Exception e){
            System.out.println(e);
        }
        return vehicle;
        
    }
}
