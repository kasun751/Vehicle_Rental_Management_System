package vrms.classes;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Vehicle {

    private int vehicleID;
    private String ownerID;
    private String vehicleBrand;
    private String model;
    private int year;
    private String vehicleType;
    private int seatingCapacity;
    private String fuelType;
    private String transmissionType;
    private double mileage;
    private double rentalPrice;
    private boolean availability;
    private String features;
    private String color;
    private String insuranceInfo;
    private boolean airCondition;
    private boolean airBags;
    private boolean electricWindow;
    private String imageURL;


    public Vehicle() {
    }

    public Vehicle(int vehicleID, String vehicleBrand, String model, int year, String vehicleType, int seatingCapacity, String fuelType, String transmissionType, double mileage, double rentalPrice, boolean availability, String features, String color, String insuranceInfo, boolean airCondition, boolean airBags, boolean electricWindow) {
        this.vehicleID = vehicleID;
        this.vehicleBrand = vehicleBrand;
        this.model = model;
        this.year = year;
        this.vehicleType = vehicleType;
        this.seatingCapacity = seatingCapacity;
        this.fuelType = fuelType;
        this.transmissionType = transmissionType;
        this.mileage = mileage;
        this.rentalPrice = rentalPrice;
        this.availability = availability;
        this.features = features;
        this.color = color;
        this.insuranceInfo = insuranceInfo;
        this.airCondition = airCondition;
        this.airBags = airBags;
        this.electricWindow = electricWindow;
    }
    
    public Vehicle(int vehicleID, String vehicleBrand, String model, int year, String vehicleType, int seatingCapacity, double price, String transmissionType, boolean airBags, boolean airCondition, boolean electricWindow) {
        this.vehicleID = vehicleID;
        this.vehicleBrand = vehicleBrand;
        this.model = model;
        this.year = year;
        this.vehicleType = vehicleType;
        this.seatingCapacity = seatingCapacity;
        this.rentalPrice = price;
        this.transmissionType = transmissionType;
        this.airBags = airBags;
        this.airCondition = airCondition;
        this.electricWindow = electricWindow;
    }
public Vehicle(int vehicleID, String vehicleBrand, String model, int year, String vehicleType, int seatingCapacity, String fuelType, String transmissionType, double mileage, double rentalPrice, boolean availability, String features, String color, String insuranceInfo, boolean airCondition, boolean airBags, boolean electricWindow, String imageURL) {
        this.vehicleID = vehicleID;
        this.vehicleBrand = vehicleBrand;
        this.model = model;
        this.year = year;
        this.vehicleType = vehicleType;
        this.seatingCapacity = seatingCapacity;
        this.fuelType = fuelType;
        this.transmissionType = transmissionType;
        this.mileage = mileage;
        this.rentalPrice = rentalPrice;
        this.availability = availability;
        this.features = features;
        this.color = color;
        this.insuranceInfo = insuranceInfo;
        this.airCondition = airCondition;
        this.airBags = airBags;
        this.electricWindow = electricWindow;
        this.imageURL = imageURL;
    }
    // Getters and Setters
    public int getVehicleID() {
        return vehicleID;
    }

    public void setVehicleID(int vehicleID) {
        this.vehicleID = vehicleID;
    }

    public String getVehicleBrand() {
        return vehicleBrand;
    }

    public void setVehicleBrand(String vehicleBrand) {
        this.vehicleBrand = vehicleBrand;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }
    
    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public String getVehicleType() {
        return vehicleType;
    }

    public void setVehicleType(String vehicleType) {
        this.vehicleType = vehicleType;
    }

    public int getSeatingCapacity() {
        return seatingCapacity;
    }

    public void setSeatingCapacity(int seatingCapacity) {
        this.seatingCapacity = seatingCapacity;
    }

    public String getFuelType() {
        return fuelType;
    }

    public void setFuelType(String fuelType) {
        this.fuelType = fuelType;
    }

    public String getOwnerID() {
        return ownerID;
    }

    public void setOwnerID(String ownerID) {
        this.ownerID = ownerID;
    }

    public String getTransmissionType() {
        return transmissionType;
    }

    public void setTransmissionType(String transmissionType) {
        this.transmissionType = transmissionType;
    }

    public double getMileage() {
        return mileage;
    }

    public void setMileage(double mileage) {
        this.mileage = mileage;
    }

    public double getRentalPrice() {
        return rentalPrice;
    }

    public void setRentalPrice(double rentalPrice) {
        this.rentalPrice = rentalPrice;
    }

    public boolean isAvailability() {
        return availability;
    }

    public void setAvailability(boolean availability) {
        this.availability = availability;
    }

    public String getFeatures() {
        return features;
    }

    public void setFeatures(String features) {
        this.features = features;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getInsuranceInfo() {
        return insuranceInfo;
    }

    public void setInsuranceInfo(String insuranceInfo) {
        this.insuranceInfo = insuranceInfo;
    }

    public boolean isAirCondition() {
        return airCondition;
    }

    public void setAirCondition(boolean airCondition) {
        this.airCondition = airCondition;
    }

    public boolean isAirBags() {
        return airBags;
    }

    // Assuming a fixed path for now. You might want to generate a path based on vehicle attributes.
    public String getImagePath() {
        if (imageURL == ""){
            return "defaultVehicle.png";
        }else{
            return imageURL;
        }
    }

    public String getTitle() {
        return vehicleBrand + " " + model; // Combining vehicleBrand and model as the title
    }
    public String getBrand() {
        return vehicleBrand;
    }

    public String getDescription() {
        return "Engine Type: " + fuelType + ", Transmission: " + transmissionType + ", Price Per Day: LKR " + rentalPrice*9 + ", Features: " + features;
    }
    
    public void setAirBags(boolean airBags) {
        this.airBags = airBags;
    }

    public boolean isElectricWindow() {
        return electricWindow;
    }

    public void setElectricWindow(boolean electricWindow) {
        this.electricWindow = electricWindow;
    }
    
    public Vehicle getVehicleDetailsByID(Connection conn, int ID){
        Vehicle vehicle = null;
        String query = "select * from vehicleInfo where vehicleID=? ;";
        try{
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, ID);
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
                        rs.getBoolean("electricWindow"),
                        rs.getString("img_url")
                );
            }
        }catch(Exception e){
            System.out.println(e);
        }
        
        return vehicle;
    }

    // Retrieve vehicle list from database
    public List<Vehicle> getVehicleList(Connection conn, String search) {
        List<Vehicle> vehicleList = new ArrayList<>();
        String query;
        if (search.equals("")) {
            query = "SELECT * FROM vehicleInfo;";
        } else {
            query = "SELECT * FROM vehicleInfo WHERE LOWER(vehicleBrand) LIKE ? OR LOWER(model) LIKE ?;";
        }
        try {
            PreparedStatement pstmt = conn.prepareStatement(query);
            if (!search.equals("")) {
                search = '%' + search + '%';
                pstmt.setString(1, search);
                pstmt.setString(2, search);
            }
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Vehicle vehicle = new Vehicle(
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
                        rs.getBoolean("electricWindow"),
                        rs.getString("img_url")
                );
                vehicleList.add(vehicle);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return vehicleList;
    }

    public List<Vehicle> getSortedVehicleList(Connection connection, double min, double max, boolean airBags, boolean airCondition, boolean electricWindow, String transmissionType) throws SQLException {
        List<Vehicle> vehicleList = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM vehicleInfo WHERE 1=1");
        
        if (min > 0) sql.append(" AND rentalPrice >= ").append(min);
        if (max > 0) sql.append(" AND rentalPrice <= ").append(max);
        if (transmissionType != null && !transmissionType.isEmpty()) sql.append(" AND transmissionType = '").append(transmissionType).append("'");
        if (airBags) sql.append(" AND airBags = 1");
        if (airCondition) sql.append(" AND airCondition = 1");
        if (electricWindow) sql.append(" AND electricWindow = 1");

        try (PreparedStatement stmt = connection.prepareStatement(sql.toString())) {
//            stmt.setString(1, "%" + search + "%");
//            stmt.setString(2, "%" + search + "%");
//            stmt.setString(3, "%" + search + "%");

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Vehicle vehicle = new Vehicle(
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
                        rs.getBoolean("electricWindow"),
                        rs.getString("img_url")
                );
                vehicleList.add(vehicle);
            }
        }
        System.out.println(sql);
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
    public int getVehicleRate(Connection conn, int vehicleID) throws SQLException{
       // String query = "select sum(rate)/count(rate) as rating from vehicleratetable where vehicleID = ?";
        String query = "SELECT SUM(totalrate) / COUNT(totalrate) AS average_of_averages " +
               "FROM ( " +
               "  SELECT SUM(rate) / COUNT(rate) AS totalrate " +
               "  FROM vehicleratetable " +
               "  WHERE vehicleID = ? " +
               "  GROUP BY username " +
               ") AS subquery";

        try(PreparedStatement pstmt = conn.prepareStatement(query) ){
           pstmt.setInt(1, vehicleID);
           ResultSet rs = pstmt.executeQuery();
           if(rs.next()){
               double temp =rs.getDouble("average_of_averages");
               return (int) Math.floor(temp);
           }
        }catch(Exception e){
            System.out.println(e);
        }
        return 0;
    }
    public boolean setVehicleRating(Connection conn, int vehicleID, int rate, String username){
          String query = "insert into vehicleratetable values(null,?,?,?);";   
          try(PreparedStatement pstmt = conn.prepareStatement(query) ){
           pstmt.setInt(1, vehicleID);
           pstmt.setString(2, username);
           pstmt.setInt(3, rate);
           return pstmt.executeUpdate()>0;
        }catch(Exception e){
            System.out.println(e);
        }
        return false;
    }
    
    public List<Vehicle> getVehicleIdListByuserName(Connection conn,String start, String end){
        List<Vehicle> vehicleIdList = new ArrayList<>();
        String query = "";
        if(start.isEmpty() || end.isEmpty()){
            query = "select vehicleID from vehicleinfo where ownerId = ? and vehicleID in (select vehicleID from ordertable) ;";
        }else{
            query = "select vehicleID from vehicleinfo where ownerId = ? and vehicleID in (select vehicleID from ordertable where rentStartDay between ? and ?) ;";
        }       
        try{
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, this.ownerID);
            if(!start.isEmpty() || !end.isEmpty()){
                pstmt.setString(2, start);
                pstmt.setString(3, end);
            }
            ResultSet rs = pstmt.executeQuery();
            while(rs.next()){
                Vehicle v = new Vehicle();
                v.setVehicleID(rs.getInt("vehicleID"));
                vehicleIdList.add(v);
            }
        }catch(Exception e){
            System.out.println(e);
        }
        
        return vehicleIdList;
    }
    
    public boolean deleteVehicle(Connection conn, int vehicleID) throws SQLException {
        String query = "DELETE FROM vehicleinfo WHERE vehicleId = ?";
        try (PreparedStatement pstm = conn.prepareStatement(query)) {
            pstm.setInt(1, vehicleID);
            return pstm.executeUpdate() > 0;
        }
    }

}
