<%-- 
    Document   : rentVehicle
    Created on : Jul 20, 2024, 8:17:14 PM
    Author     : rkcp8
--%>

<%@page import="vrms.classes.VehicleOrder"%>
<%@page import="vrms.classes.MD5"%>
<%@page import="vrms.classes.Users"%>
<%@page import="vrms.classes.DbConnector"%>
<%@page import="vrms.classes.Vehicle"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.UUID"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.DecimalFormatSymbols"%>
<%!
    Users user = null;
    Vehicle currentVehicle = null;
    String orderID;
    String startday;
    double payhere_amount;
    boolean checkoutField = false;
    int days;
    String vid;
%>
<!DOCTYPE html>
<html>
    <head>
        <link href="../css/homePage.css" rel="stylesheet">
        <link href="../css/rentVehicle.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Home Page</title>
        <script>
            function handlebtn(var1) {
                let days = parseInt(document.getElementById("days").value);
                if (var1 > 0) {
                    if (days < 7) {
                        document.getElementById("days").value = days + 1;
                    }
                } else {
                    if (days > 1) {
                        document.getElementById("days").value = days - 1;
                    }
                }
                handleSetDays()
            }
        </script>
    </head>
    <body>
        <jsp:include page="../components/headerComponent.jsp" />
        <%
            String email = (session != null) ? (String) session.getAttribute("userName") : "";
            startday = request.getParameter("startDay");
            vid = request.getParameter("vid") != null ? request.getParameter("vid") : "";
            String noOfDays = request.getParameter("days") != null ? request.getParameter("days") : "0";
            if (email == null || email.isEmpty()) {
                response.sendRedirect("login.jsp");
                return;
            }
            if (vid == null || vid.isEmpty()) {
                response.sendRedirect("homePage.jsp");
                return;
            } else {
                //check date availability
                int vehicleID = Integer.parseInt(vid);
                VehicleOrder vo = new VehicleOrder(vehicleID, startday, days);
                if (vo.checkDateAvailability(DbConnector.getConnection())) {
                    int vehicleId = Integer.parseInt(vid);
                    Vehicle vehicle = new Vehicle();
                    currentVehicle = vehicle.getVehicleDetailsByID(DbConnector.getConnection(), vehicleId);
                } else {
                    response.sendRedirect("rentVehicle.jsp?vid=" + vid + "&s=0");
                }
                if (noOfDays != null && !noOfDays.equals("0") && vo.checkDateAvailability(DbConnector.getConnection())) {
                days = Integer.parseInt(noOfDays);

                payhere_amount = currentVehicle.getRentalPrice() * days;
                checkoutField = true;
                UUID uniqueId = UUID.randomUUID();
                String uniqueIdString = uniqueId.toString();
                orderID = uniqueIdString;
            }else{
                    checkoutField = false;
                }
            }
        %>
        <div class="container">
            <div class="row">
                <div class="col-5">
                    <div>
                        <img src="<%= "../uploads/"+currentVehicle.getImageURL() %>" class="d-block w-100" alt="...">
                    </div>
                    <% if (checkoutField) {
                            session.setAttribute("payment", payhere_amount);
                            session.setAttribute("days", days);
                            session.setAttribute("vehicleID", vid);
                            session.setAttribute("orderID", orderID);
                            session.setAttribute("startday", startday);
                            out.print("<div class='row'>");
                            out.print("<div>");
                            out.print("<h4>CheckOut</h4>");
                            out.println("Your <b>pre-payment</b> is " + payhere_amount + " LKR<br>");
                            out.println("Your <b>post-payment</b> is " + payhere_amount*9 + " LKR<br>");
                            out.println("Your <b>Total-payment</b> is " + payhere_amount*10 + " LKR<br>");
                            //out.print("<button type='button' class='btn btn-success mt-5 col-12' id='payhere-payment' >Pay now</button>");
                            out.print("<a href='paymentGateway.jsp'><button type='button' class='btn btn-success mt-5 col-12' >Pay now</button> </a>");
                            out.print("</div>");
                            out.print("</div>");
                        }
                    %>
                </div>
                <div class="col-5">
                    <table class="table">
                        <tbody>
                            <tr>
                                <th>Vehicle Brand</th>
                                <td><%= currentVehicle.getBrand()%></td>
                            </tr>
                            <tr>
                                <th>Model</th>
                                <td><%= currentVehicle.getModel()%></td>
                            </tr>
                            <tr>
                                <th>Year</th>
                                <td><%= currentVehicle.getYear()%></td>
                            </tr>
                            <tr>
                                <th>Vehicle Type</th>
                                <td><%= currentVehicle.getVehicleType()%></td>
                            </tr>
                            <tr>
                                <th>Color</th>
                                <td><%= currentVehicle.getColor()%></td>
                            </tr>
                            <tr>
                                <th>Seating Capacity</th>
                                <td><%= currentVehicle.getSeatingCapacity()%></td>
                            </tr>
                            <tr>
                                <th>Fuel Type</th>
                                <td><%= currentVehicle.getFuelType()%></td>
                            </tr>
                            <tr>
                                <th>Transmission Type</th>
                                <td><%= currentVehicle.getTransmissionType()%></td>
                            </tr>
                            <tr>
                                <th>Estimated Mileage</th>
                                <td><%= currentVehicle.getMileage()%></td>
                            </tr>
                            <tr>
                                <th>Features</th>
                                <td><%= currentVehicle.getFeatures()%></td>
                            </tr>
                        </tbody>
                    </table>
                    <div>
                        <div class="row d-flex justify-content-center">
                            <table>
                                <tbody>
                                    <tr>
                                        <td>
                                            <label>Select Rent Start day</label><br>
                                        </td>
                                        <td>
                                            <input class="form-control col-12" name="startday1" type="date" id="startDay1" required=""> 
                                        </td>
                                        <td>                                             
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>                                            
                                            <%
                                                String s = request.getParameter("s") != null ? request.getParameter("s") : "";
                                                if (s.equals("0")) {
                                                    out.print("<label class='text-danger'>Sorry...! We Can't arrange this Vehicle for your durations...</label>");
                                                }
                                            %>
                                            <label class='text-danger' id="startDayWarningMsg" hidden>Please select valid start date...!</label> 
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <label>Select between 1 to 7 days.</label><br>
                                            <input class="col-12" type="range" id="days" min="1" max="7" onchange="handleSetDays()"> 
                                        </td>
                                        <td>
                                            <input type="text" id="days_display" disabled>
                                        </td>
                                        <td>
                                            <div class="col-3">
                                                <button onclick="handlebtn(1)">^</button>
                                                <button onclick="handlebtn(-1)">v</button>                                
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3">
                                            <form action="rentVehicle.jsp?vid=<%= vid%>" id="rent-form" method="POST">
                                                <!--                                                <input type="text" id="unitPrice" name="price" hidden/>-->
                                                <input type="text" id="noOfDays" name="days" hidden/>
                                                <input type="date" id="startDay" name="startDay" hidden/>
                                                <button type="button" onclick="handleRent()" class="btn btn-primary mt-5 mb-4 col-12" >Rent</button>
                                            </form>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%
            user = (new Users()).getUserByID(DbConnector.getConnection(), 1);
        %>
        <script>
            function handleSetDays() {
                let days = document.getElementById("days").value;
                document.getElementById("days_display").value = days;
            }
            handleSetDays();
        </script>
        <script>
            function handleRent() {
                document.getElementById("noOfDays").value = document.getElementById("days_display").value.toString();
                document.getElementById("startDay").value = document.getElementById("startDay1").value;
                let val = document.getElementById("startDay").value;
                const today = new Date();
                today.setHours(0, 0, 0, 0);
                const enteredDate = new Date(val);
                enteredDate.setHours(0, 0, 0, 0);
                if (val !== "" && enteredDate >= today) {
                    document.getElementById("rent-form").submit();                    
                } else {
                    document.getElementById("startDayWarningMsg").hidden = false;
                }
            }
        </script>
        <jsp:include page="../components/footerComponent.jsp" />
    </body>
</html>
