<%-- 
    Document   : rateProcess
    Created on : Jul 26, 2024, 1:14:50 PM
    Author     : rkcp8
--%>

<%@page import="vrms.classes.VehicleOrder"%>
<%@page import="vrms.classes.DbConnector"%>
<%@page import="vrms.classes.Vehicle"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if(session.getAttribute("userName")==null){
        response.sendRedirect("login.jsp");
    }
    String username = (String)session.getAttribute("userName");
    String s = request.getParameter("s") != null ? request.getParameter("s") : "";
    String orderID = request.getParameter("o") != null ? request.getParameter("o") : "";
    String strRateIndex = request.getParameter("rateIndex") != null ? request.getParameter("rateIndex") : "0";

        if (!strRateIndex.equals("0")) {
        
        String strVehicleId = request.getParameter("vehicleId") != null ? request.getParameter("vehicleId") : "0";
        Vehicle vehicle = new Vehicle();
        int vehicleId = Integer.parseInt(strVehicleId);
        int rateIndex = Integer.parseInt(strRateIndex);
        
        if(vehicle.setVehicleRating(DbConnector.getConnection(), vehicleId, rateIndex, username)){
            if(new VehicleOrder().updateOrderStatus(DbConnector.getConnection(), orderID)){
                response.sendRedirect("myRentedVehicles.jsp?r=1");
            } else {
                response.sendRedirect("myRentedVehicles.jsp?r=0");
            }            
        } else {
            response.sendRedirect("myRentedVehicles.jsp?r=0&k=5");
        }
    }

    else if(strRateIndex.equals("0")){
        if(new VehicleOrder().updateOrderStatus(DbConnector.getConnection(),orderID)){
                response.sendRedirect("myRentedVehicles.jsp?r=2");
            }else{
                response.sendRedirect("myRentedVehicles.jsp?r=0");
            }
    }
%>
