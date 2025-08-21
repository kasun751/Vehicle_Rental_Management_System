<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="java.util.UUID"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="vrms.classes.DbConnector"%>
<%@page import="java.io.File"%>
<%@page import="java.io.IOException"%>
<%@page import="javax.servlet.ServletException"%>
<%@page import="javax.servlet.http.Part"%>
<%
    String email = (session != null) ? (String) session.getAttribute("userName") : "";
    if (email == null || email.isEmpty()) {
        response.sendRedirect("login.jsp");
    }
    String vehicleBrand = "";
    int vehicleID = 0;
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
                    } else if ("vehicleID".equals(fieldName)) {
                        vehicleID = Integer.parseInt(fieldValue);
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
                    } else if ("vehicleType".equals(fieldName)) {
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
            String sql = "UPDATE vehicleinfo SET vehicleBrand = ?, model = ?, year = ?, vehicleType = ?, seatingCapacity = ?, fuelType = ?, transmissionType = ?, mileage = ?, rentalPrice = ?, availability = ?, features = ?, color = ?, insuranceInfo = ?, airCondition = ?, airbags = ?, electricWindow = ?, img_url= ? WHERE vehicleID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, vehicleBrand);
            pstmt.setString(2, model);
            pstmt.setInt(3, year);
            pstmt.setString(4, vehicleType);
            pstmt.setInt(5, seatingCapacity);
            pstmt.setString(6, fuelType);
            pstmt.setString(7, transmissionType);
            pstmt.setDouble(8, mileage);
            pstmt.setDouble(9, rentalPrice);
            pstmt.setBoolean(10, availability);
            pstmt.setString(11, features);
            pstmt.setString(12, color);
            pstmt.setString(13, insuranceInfo);
            pstmt.setBoolean(14, airCondition);
            pstmt.setBoolean(15, airbags);
            pstmt.setBoolean(16, electricWindow);
            pstmt.setString(17, img_url);
            pstmt.setInt(18, vehicleID);
            pstmt.executeUpdate();

            //out.println("<div class='alert alert-success'>Vehicle added successfully!</div>");
            response.sendRedirect("editVehicle.jsp?id="+vehicleID+"&e=1");
        } else {
            //out.println("This request is not a file upload request.");
            response.sendRedirect("editVehicle.jsp?id="+vehicleID+"&e=0");
        }
    } catch (Exception e) {
        e.printStackTrace();
        //out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
        response.sendRedirect("editVehicle.jsp?id="+vehicleID+"&e=0");
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
