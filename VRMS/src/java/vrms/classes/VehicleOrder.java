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

    public VehicleOrder(String orderID, double payment, String username, String startDay, int vehicleId, int days, String status) {
        this.orderID = orderID;
        this.payment = payment;
        this.username = username;
        this.startDay = startDay;
        this.vehicleId = vehicleId;
        this.days = days;
        this.status = status;
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

    public boolean addOrder(Connection conn) throws SQLException {
        String query = "Insert into ordertable(orderID, username, vehicleID, rentStartDay, no_of_days, order_income, order_status) values(?,?,?,?,?,?,'pending')";
        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, this.orderID);
            pstmt.setString(2, this.username);
            pstmt.setInt(3, this.vehicleId);
            pstmt.setString(4, this.startDay);
            pstmt.setInt(5, this.days);
            pstmt.setDouble(6, this.payment);

            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace(); // Use logging in a real-world scenario
            return false;
        }
    }

    public List<OrderObject> getRentedVehicleIDList(Connection conn, String search) {
        List<OrderObject> orderObjectList = new ArrayList<>();
        String query;
        if (search.equals("")) {
            query = "SELECT vehicleID,orderId FROM ordertable WHERE username = ?;";
        } else {
            query = "SELECT vehicleID,orderId FROM ordertable WHERE username = ? AND"
                    + " LOWER(vehicleBrand) LIKE ? OR LOWER(model) LIKE ?;";
        }
        try {
            PreparedStatement pstmt = conn.prepareStatement(query);
            if (!search.equals("")) {
                search = '%' + search + '%';
                pstmt.setString(1, this.username);
                pstmt.setString(2, search);
                pstmt.setString(3, search);
            } else {
                pstmt.setString(1, this.username);
            }
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                String oid = rs.getString("orderId");
                int vid = rs.getInt("vehicleID");
                OrderObject o = new OrderObject(oid, vid);
                orderObjectList.add(o);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderObjectList;
    }

    public VehicleOrder getOrderDetails(Connection conn,String orderID) throws SQLException {
        String query = "SELECT * FROM ordertable WHERE orderid = ?;";
        VehicleOrder vo = null;
        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, orderID);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                vo = new VehicleOrder(rs.getString("orderID"), rs.getDouble("order_income"), rs.getString("username"), rs.getString("rentStartDay"), rs.getInt("vehicleID"), rs.getInt("no_of_days"), rs.getString("order_status"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return vo;
    }
    public boolean updateOrderStatus(Connection conn,String orderID) throws SQLException{
        String query = "update ordertable set order_status = 'complete' where orderId = ?";
        try(PreparedStatement pstmt = conn.prepareStatement(query)){
            pstmt.setString(1, orderID);
            return pstmt.executeUpdate()>0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public VehicleOrder getOrderDetailsByVid(Connection conn,int vid) throws SQLException {
        String query = "SELECT * FROM ordertable WHERE vehicleID = ?;";
        VehicleOrder vo = null;
        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, vid);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                vo = new VehicleOrder(rs.getString("orderID"), rs.getDouble("order_income"), rs.getString("username"), rs.getString("rentStartDay"), rs.getInt("vehicleID"), rs.getInt("no_of_days"), rs.getString("order_status"));
            }else{
                
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return vo;
    }
    
//    public Double getIncomeDetails(Connection conn,String status,String start,String end){
//        Double payment = 0.0 ; 
//        String query = "select sum(order_income) as income from ordertable where order_status = ? and rentStartDay between ? and ? "
//                + "and vehicleID in ();";
//        try{
//            PreparedStatement pstmt = conn.prepareStatement(query);
//            pstmt.setString(1, status);
//            pstmt.setString(2, start);
//            pstmt.setString(3, end);
//            ResultSet rs = pstmt.executeQuery();
//            if(rs.next()){
//                payment = rs.getDouble("income");
//            }
//        }catch(Exception e){
//            System.out.println(e);
//        }        
//        return payment;
//    }
}
