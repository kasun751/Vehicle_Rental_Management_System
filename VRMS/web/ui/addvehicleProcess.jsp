<%@page import="java.io.File"%>
<%@page import="java.lang.*"%>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@page import="vrms.classes.DbConnector"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="javax.servlet.http.Part"%>
<%@ page import="javax.servlet.annotation.MultipartConfig"%>
<%@ page import = "org.apache.commons.fileupload.*" %>
<%@ page import = "org.apache.commons.fileupload.disk.*" %>
<%@ page import = "org.apache.commons.fileupload.servlet.*" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Processing</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            #addVehicleProcess-body{
                height: 60vh;
            }
        </style>
    </head>
    <body>
        <jsp:include page="../components/headerComponent.jsp" />
        <div class="container mt-5" id="addVehicleProcess-body">
            <h2>Processing...</h2>
            <%
                String email = (session != null) ? (String) session.getAttribute("userName") : "";
                if (email == null || email.isEmpty()) {
                    response.sendRedirect("login.jsp");
                }
                String vehicleBrand = "";
                String model = "";
                int year = 0;
                int seatingCapacity = 0;
                double mileage = 0.0;
                double rentalPrice = 0.0;
                boolean availability = false;
                boolean airCondition = false;
                boolean airbags = false;
                boolean electricWindow = false;
                String img_url = "";
                String vehicleType = "";
                String fuelType = "";
                String transmissionType = "";
                String features = "";
                String color = "";
                String insuranceInfo = "";

                Connection conn = null;
                PreparedStatement pstmt = null;

                try {
                    boolean isMultipart = ServletFileUpload.isMultipartContent(request);

                    if (isMultipart) {
                        DiskFileItemFactory factory = new DiskFileItemFactory();
                        ServletFileUpload upload = new ServletFileUpload(factory);

                        List<FileItem> items = upload.parseRequest(request);

                        for (FileItem item : items) {
                            if (item.isFormField()) {
                                String fieldName = item.getFieldName();
                                String fieldValue = item.getString();
                                
                                if ("vehicleBrand".equals(fieldName)) {
                                    vehicleBrand = fieldValue;
                                } else if ("model".equals(fieldName)) {
                                    model = fieldValue;
                                } else if ("year".equals(fieldName)) {
                                    year = Integer.parseInt(fieldValue);
                                } else if ("seatingCapacity".equals(fieldName)) {
                                    seatingCapacity = Integer.parseInt(fieldValue);
                                } else if ("mileage".equals(fieldName)) {
                                    mileage = Double.parseDouble(fieldValue);
                                } else if ("rentalPrice".equals(fieldName)) {
                                    rentalPrice = Double.parseDouble(fieldValue);
                                } else if ("availability".equals(fieldName)) {
                                    availability = Boolean.parseBoolean(fieldValue);
                                } else if ("airCondition".equals(fieldName)) {
                                    airCondition = Boolean.parseBoolean(fieldValue);
                                } else if ("airbags".equals(fieldName)) {
                                    airbags = Boolean.parseBoolean(fieldValue);
                                } else if ("electricWindow".equals(fieldName)) {
                                    electricWindow = Boolean.parseBoolean(fieldValue);
                                }else if ("vehicleType".equals(fieldName)) {
                                    vehicleType = fieldValue;
                                } else if ("fuelType".equals(fieldName)) {
                                    fuelType = fieldValue;
                                } else if ("transmissionType".equals(fieldName)) {
                                    transmissionType = fieldValue;
                                } else if ("features".equals(fieldName)) {
                                    features = fieldValue;
                                } else if ("color".equals(fieldName)) {
                                    color = fieldValue;
                                } else if ("insuranceInfo".equals(fieldName)) {
                                    insuranceInfo = fieldValue;
                                }
                            } else {
                                String fileName = new File(item.getName()).getName();
                                //String filePath = application.getRealPath("") + File.separator + "uploads" + File.separator + fileName;
                                String uniqueID = UUID.randomUUID().toString();

                                // Extract file extension
                                String fileExtension = "";
                                if (fileName.lastIndexOf(".") != -1) {
                                    fileExtension = fileName.substring(fileName.lastIndexOf("."));
                                }

                                // Create a new unique file name
                                String newFileName = uniqueID + fileExtension;

                                // Define the file path
                                String filePath = "E:/RAD-Project/Vehicle_Rental_Management_System/VRMS/web/" + File.separator + "uploads" + File.separator + newFileName;
                                File uploadedFile = new File(filePath);
                                item.write(uploadedFile);
                                img_url = newFileName;
                                //out.println("File " + filePath + " has been uploaded successfully!");
                            }
                        }

                        conn = DbConnector.getConnection();
                        String sql = "INSERT INTO vehicleinfo (ownerId, vehicleBrand, model, year, vehicleType, seatingCapacity, fuelType, transmissionType, mileage, rentalPrice, availability, features, color, insuranceInfo, airCondition, airbags, electricWindow, img_url) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, email);
                        pstmt.setString(2, vehicleBrand);
                        pstmt.setString(3, model);
                        pstmt.setInt(4, year);
                        pstmt.setString(5, vehicleType);
                        pstmt.setInt(6, seatingCapacity);
                        pstmt.setString(7, fuelType);
                        pstmt.setString(8, transmissionType);
                        pstmt.setDouble(9, mileage);
                        pstmt.setDouble(10, rentalPrice);
                        pstmt.setBoolean(11, availability);
                        pstmt.setString(12, features);
                        pstmt.setString(13, color);
                        pstmt.setString(14, insuranceInfo);
                        pstmt.setBoolean(15, airCondition);
                        pstmt.setBoolean(16, airbags);
                        pstmt.setBoolean(17, electricWindow);
                        pstmt.setString(18, img_url);
                        pstmt.executeUpdate();

                        out.println("<div class='alert alert-success'>Vehicle added successfully!</div>");
                    } else {
                        out.println("This request is not a file upload request.");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
                } finally {
                    if (pstmt != null) {
                        try {
                            pstmt.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                    if (conn != null) {
                        try {
                            conn.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                }
            %>
            <a href="http://localhost:8080/VRMS/ui/manageVehicle.jsp" class="btn btn-primary mt-3">Back to Manage Vehicles</a>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
         <jsp:include page="../components/footerComponent.jsp" />
    </body>
   
</html>
