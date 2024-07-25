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
public class VehicleOrder {

    private String orderID;
    private double payment;
    private String username;
    private String startDay;
    private int vehicleId;
    private int days;
    private String status;

    public VehicleOrder() {
    }

    public VehicleOrder(int vehicleId, String startDay, int days) {
        this.startDay = startDay;
        this.vehicleId = vehicleId;
        this.days = days;
    }

    public VehicleOrder(String orderID, double payment, String username, String startDay, int vehicleId, int days) {
        this.orderID = orderID;
        this.payment = payment;
        this.username = username;
        this.startDay = startDay;
        this.vehicleId = vehicleId;
        this.days = days;
    }

    public String getOrderID() {
        return orderID;
    }

    public void setOrderID(String orderID) {
        this.orderID = orderID;
    }

    public double getPayment() {
        return payment;
    }

    public void setPayment(double payment) {
        this.payment = payment;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getStartDay() {
        return startDay;
    }

    public void setStartDay(String startDay) {
        this.startDay = startDay;
    }

    public int getVehicleId() {
        return vehicleId;
    }

    public void setVehicleId(int vehicleId) {
        this.vehicleId = vehicleId;
    }

    public int getDays() {
        return days;
    }

    public void setDays(int days) {
        this.days = days;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public boolean checkDateAvailability(Connection conn) throws SQLException {
        String query = "SELECT orderId FROM ordertable WHERE vehicleID = ? AND (rentStartDay BETWEEN ? AND DATE_ADD(?, INTERVAL ? DAY) OR DATE_ADD(rentStartDay, INTERVAL no_of_days DAY) BETWEEN ? AND DATE_ADD(?, INTERVAL ? DAY) OR (rentStartDay <= ? AND DATE_ADD(rentStartDay, INTERVAL no_of_days DAY) >= DATE_ADD(?, INTERVAL ? DAY)));";
    try (PreparedStatement pstmt = conn.prepareStatement(query)) {
        pstmt.setInt(1, this.vehicleId);
        pstmt.setString(2, this.startDay);
        pstmt.setString(3, this.startDay);
        pstmt.setInt(4, this.days);
        pstmt.setString(5, this.startDay);
        pstmt.setString(6, this.startDay);
        pstmt.setInt(7, this.days);
        pstmt.setString(8, this.startDay);
        pstmt.setString(9, this.startDay);
        pstmt.setInt(10, this.days);

        ResultSet rs = pstmt.executeQuery();
        return !rs.next(); // Returns true if no overlapping dates are found
    }
        
    }
    public boolean addOrder(Connection conn) throws SQLException{
        String query = "Insert into ordertable(orderID, username, vehicleID, rentStartDay, no_of_days, order_income, order_status) values(?,?,?,?,?,?,'pending')";
        try(PreparedStatement pstmt = conn.prepareStatement(query)){
            pstmt.setString(1, this.orderID);
            pstmt.setString(2, this.username);
            pstmt.setInt(3, this.vehicleId);
            pstmt.setString(4, this.startDay);
            pstmt.setInt(5, this.days);
            pstmt.setDouble(6, this.payment);
            
            return pstmt.executeUpdate()>0;
        } catch (Exception e) {
            e.printStackTrace(); // Use logging in a real-world scenario
            return false;
        }        
    }
    
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
            }else{
                pstmt.setString(1, this.username);
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
}
