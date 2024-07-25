<%-- 
    Document   : paymentProcess
    Created on : Jul 24, 2024, 8:46:22 PM
    Author     : rkcp8
--%>

<%@page import="vrms.classes.DbConnector"%>
<%@page import="vrms.classes.VehicleOrder"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!
    double payment;
    String username;
    String orderID;
    String startDay;
    int vehicleId;
    int days;
%>
<%
    if (session.getAttribute("payment") != null) {
        double payment = session.getAttribute("payment") != null ? (Double) session.getAttribute("payment") : 0;
        String strVehicleId = session.getAttribute("vehicleID") != null ? (String) session.getAttribute("vehicleID") : "0";
        days = session.getAttribute("days") != null ? (Integer) session.getAttribute("days") : 0;
        username = session.getAttribute("userName") != null ? (String) session.getAttribute("userName") : "";
        orderID = session.getAttribute("orderID") != null ? (String) session.getAttribute("orderID") : "";
        startDay = session.getAttribute("startday") != null ? (String) session.getAttribute("startday") : "";
        //double payment = Double.parseDouble(strPayment);
        vehicleId = Integer.parseInt(strVehicleId);
        //days = Integer.parseInt(strDays);
        VehicleOrder vo = new VehicleOrder(orderID, payment, username, startDay, vehicleId, days);
        if (vo.addOrder(DbConnector.getConnection())) {
            session.setAttribute("payment", "");
            session.setAttribute("days", "");
            session.setAttribute("vehicleID", "");
            session.setAttribute("orderID", "");
            response.sendRedirect("orderResultPage.jsp?s=1");
        } else {
            response.sendRedirect("orderResultPage.jsp?s=0");
        }
    } else {
        response.sendRedirect("homePage.jsp");
    }
%>
