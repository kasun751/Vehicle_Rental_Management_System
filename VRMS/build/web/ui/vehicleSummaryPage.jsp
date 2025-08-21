<%-- 
    Document   : VehicleSummaryPage
    Created on : Jul 30, 2024, 5:02:45 PM
    Author     : rkcp8
--%>

<%@page import="vrms.classes.VehicleOrder"%>
<%@page import="java.util.List"%>
<%@page import="vrms.classes.DbConnector"%>
<%@page import="vrms.classes.Vehicle"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%!
    String startDate = "";
    String endDate = "";
%>
<%
    String currentPage = "vehicleSummary";
    request.setAttribute("currentPage", currentPage);
    String email = (session != null) ? (String) session.getAttribute("userName") : "";
    if (email == null || email.isEmpty()) {
        response.sendRedirect("login.jsp");
    }
%>
<html>
    <head>
        <link href="../css/vehicleSummaryPage.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style>
            .table-responsive {
                overflow-x: auto;
            }
            .table {
                background-color: #c8e6c9;
                color: #000;
            }
            .table thead th {
                background-color: #a5d6a7;
                color: #fff;
            }
            .table tbody tr {
                background-color: #e8f5e9;
            }
            .table tbody tr:nth-child(even) {
                background-color: #c8e6c9;
            }
            td, th {
                vertical-align: middle;
                text-align: center;
            }
            .collapse-row {
                display: none;
            }
            #vs-body {
                background: rgba(88,128,128,.2);
                height: 100vh;
                margin: 0;
                padding: 20px;
            }
            .left-container{
                border: 2px solid white;
                border-radius: 20px;
                padding: 20px 50px;
            }            
        </style>

    </head>
    <body>
        <jsp:include page="../components/headerComponent.jsp" />
        <h1 class="d-flex justify-content-center">Order Summery</h1>
        <div class="container">
            <div id="vs-body">
                <div class="row mt-4">
                    <div class="col-4 left-container">
                        <div class="mb-4">
                            <form action="vehicleSummaryPage.jsp" method="post">
                                <b>Start date:</b>
                                <input class="form-control" type="date" name="startDate" /><br>
                                <b>End date:</b>
                                <input class="form-control" type="date" name="endDate" /><br>
                                <input class="form-control btn btn-outline-primary" type="submit" name="submit" value="Filter" />
                            </form>
                        </div>
                        <div>
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th scope="col">Total Income</th>
                                        <th scope="col">Pending Income</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        Vehicle vehicle1 = new Vehicle();
                                        double pendingPayment = 0.0;
                                        double payment = 0.0;
                                        vehicle1.setOwnerID(email);
                                        List<Vehicle> vehicleIdList1 = vehicle1.getVehicleIdListByuserName(DbConnector.getConnection(), startDate, endDate);
                                        for (Vehicle v : vehicleIdList1) {
                                            VehicleOrder vo = new VehicleOrder().getOrderDetailsByVid(DbConnector.getConnection(), v.getVehicleID());
                                            if (vo.getStatus().equals("complete")) {
                                                payment += vo.getPayment();
                                            } else if (vo.getStatus().equals("pending")) {
                                                pendingPayment += vo.getPayment();
                                            }
                                        }
                                        payment *= 90;
                                        pendingPayment *= 90;
                                        out.print("<td>" + payment + "</td>");
                                        out.print("<td>" + pendingPayment + "</td>");
                                        ;%>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="col-8">
                        <%
                            startDate = request.getParameter("startDate") != null ? request.getParameter("startDate") : "";
                            endDate = request.getParameter("endDate") != null ? request.getParameter("endDate") : "";
                            if (!startDate.isEmpty() || !endDate.isEmpty()) {
                                out.println("<div class='alert alert-success alert-dismissible fade show' role='alert'>");
                                out.println("<strong>Your Filter Result :-</strong> " + startDate + "<strong> TO </strong>" + endDate);
                                out.println("<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>");
                                out.println("</div>");
                            }
                        %>
                        <table class="table">
                            <thead>
                                <tr>
                                    <th scope="col">Order ID</th>
                                    <th scope="col">Vehicle ID</th>
                                    <th scope="col">Vehicle Name</th>
                                    <th scope="col">Rent day</th>
                                    <th scope="col">No.Of Days</th>
                                    <th scope="col">Income</th>
                                    <th scope="col">Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    Vehicle vehicle = new Vehicle();
                                    vehicle.setOwnerID(email);
                                    List<Vehicle> vehicleIdList = vehicle.getVehicleIdListByuserName(DbConnector.getConnection(), startDate, endDate);
                                    for (Vehicle v : vehicleIdList) {
                                        Vehicle vehiObj = v.getVehicleDetailsByID(DbConnector.getConnection(), v.getVehicleID());
                                        VehicleOrder vo = new VehicleOrder().getOrderDetailsByVid(DbConnector.getConnection(), v.getVehicleID());
                                        out.print("<tr>");
                                        out.print("<td>" + vo.getOrderID() + "</td>");
                                        out.print("<td>" + vehiObj.getVehicleID() + "</td>");
                                        out.print("<td>" + vehiObj.getBrand() + "</td>");
                                        out.print("<td>" + vo.getStartDay() + "</td>");
                                        out.print("<td>" + vo.getDays() + "</td>");
                                        out.print("<td>" + vo.getPayment() * 90 + "</td>");
                                        out.print("<td>" + vo.getStatus() + "</td>");
                                        out.print("</tr>");
                                    }
                                    ;%>
                            </tbody>
                        </table>
                    </div>
                </div>            
            </div>
        </div>
        <jsp:include page="../components/footerComponent.jsp" />
    </body>
</html>
