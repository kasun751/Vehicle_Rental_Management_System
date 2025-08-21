
<%@page import="java.sql.Connection"%>
<%@page import="vrms.classes.DbConnector"%>
<%@page import="vrms.classes.Vehicle"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    
    String idStr = request.getParameter("id");
    Connection conn=null;
    if (idStr != null) {
        try {
            int id = Integer.parseInt(idStr);
            conn = DbConnector.getConnection();

            // Create an instance of VehicleInfo
            Vehicle vehicle = new Vehicle();

            // Call the deleteVehicle method
            boolean success = vehicle.deleteVehicle(conn,id);

            if (success) {
                response.sendRedirect("manageVehicle.jsp?message=Vehicle Deleted Successfully");
            } else {
               response.sendRedirect("manageVehicle.jsp?message=Vehicle Deleted Successfully");
            }
        } catch (NumberFormatException e) {
           String errorMessage = "Error: Invalid vehicle ID.";
        }
    } else {
        String errorMessage = "Error: vehicle ID NULL.";;
    }
%>
