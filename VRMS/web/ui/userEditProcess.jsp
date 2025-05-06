<%-- 
    Document   : userEditProcess
    Created on : Aug 9, 2024, 10:45:34 PM
    Author     : rkcp8
--%>

<%@page import="vrms.classes.DbConnector"%>
<%@page import="vrms.classes.Users"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String email = (session != null) ? (String) session.getAttribute("userName") : "";
    String userType = (session != null) ? (String) session.getAttribute("userType") : "";
    if (email == null || email.isEmpty()) {
        response.sendRedirect("login.jsp");
    }
    if (request.getParameter("editSubmit") != null) {
        String strUserID = request.getParameter("userID");
        int userID = Integer.parseInt(strUserID);
        String lname = request.getParameter("lname");
        String fname = request.getParameter("fname");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String nic = request.getParameter("nic");

        Users user = new Users(userID, fname, lname, phone, address, city, nic);
        if (user.updateUsers(DbConnector.getConnection())) {
            if (userType.equals("vehicleOwner")) {
                response.sendRedirect("dashboard.jsp?u=1");
            } else {
                response.sendRedirect("homePage.jsp?u=1");
            }
        } else {
            if (userType.equals("vehicleOwner")) {
                response.sendRedirect("dashboard.jsp?u=0");
            } else {
                response.sendRedirect("homePage.jsp?u=0");
            }
        }
    } else {
        if (userType.equals("vehicleOwner")) {
            response.sendRedirect("dashboard.jsp");
        } else {
            response.sendRedirect("homePage.jsp");
        }
    }
%>
