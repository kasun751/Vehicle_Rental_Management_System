<%@page import="vrms.classes.VehicleOrder"%>
<%@page import="vrms.classes.DbConnector"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vrms.classes.Vehicle"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%!
    List<Vehicle> vehicleList = new ArrayList<Vehicle>();

    double min = 0;
    double max = 0;
    String transmissionType = "";
    boolean airBags = false;
    boolean airCondition = false;
    boolean electricWindow = false;
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <link href="../css/homePage.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Home Page</title>
    </head>
    <body>
        <%
            String currentPage = "myRentedVehicles";
            request.setAttribute("currentPage", currentPage);
        %>
        <jsp:include page="../components/headerComponent.jsp" />
        <%
            String email = (session != null) ? (String) session.getAttribute("userName") : "";
            if (email == null || email.isEmpty()) {
                response.sendRedirect("login.jsp");
            }
        %>
        <div class="container mt-5">
            <div class="row">
                <div class="col-md-4">

                </div>
                <div class="col-md-8">
                    <%
                        String search = request.getParameter("searchData");
                        search = (search != null) ? search.toLowerCase() : "";
                        try {
                            if (search != null && !search.isEmpty()) {
                                out.println("<div class='alert alert-success' role='alert'>Your Search Result :- " + search + "</div>");
                            }
                            VehicleOrder vo = new VehicleOrder();
                            vo.setUsername("kasun@gmail.com");
                            List<Integer> vehicleIDList = vo.getRentedVehicleIDList(DbConnector.getConnection(), search);
                            for (int vid : vehicleIDList) {
                                Vehicle v = new Vehicle().getVehicleDetailsByID(DbConnector.getConnection(), vid);
            
                                out.println("<div class='card mb-3 row d-flex justify-content-center col-md-12'>");
                                out.println("<div class='row g-0'>");
                                out.println("<div class='col-md-4 d-flex align-items-center'>");
                                //out.println("<img src='../Images/" + v.getImagePath() + "' class='img-fluid rounded-start' alt='Image description'>");
                                out.println("</div>");
                                out.println("<div class='col-md-8'>");
                                out.println("<div class='card-body'>");
                                out.println("<h5 class='card-title'>" + v.getTitle() + "</h5>");
                                out.println("<p class='card-text'>" + v.getDescription() + "</p>");
                                out.println("<table>");
                                out.println("<tbody>");
                                out.println("<tr>");
                                out.println("<th>Air Condition: ");
                                out.println("</th>");
                                out.println("<td class='d-felx justify-content-center p-2'>");
                                out.println("<img src='../Images/" + (v.isAirCondition() ? "right.svg" : "cross.png") + "' style='width:20px;' /></td>");
                                out.println("<th>Air Bags: ");
                                out.println("</th>");
                                out.println("<td class='d-felx justify-content-center p-2'>");
                                out.println("<img src='../Images/" + (v.isAirBags() ? "right.svg" : "cross.png") + "' style='width:20px;' /></td>");
                                out.println("<th>Electic Window:");
                                out.println("</th>");
                                out.println("<td class='d-felx justify-content-center p-2'>");
                                out.println("<img src='../Images/" + (v.isElectricWindow() ? "right.svg" : "cross.png") + "' style='width:20px;' /></td>");
                                out.println("</tr>");
                                out.println("</tbody>");
                                out.println("</table>");
                                out.println("<a href='rentVehicle.jsp?vid=" + v.getVehicleID() + "' class='btn btn-primary'>Order Recieved</a>");
                                out.println("<button type='button' class='btn btn-primary' onclick='createCookie(3)' data-bs-toggle='modal' data-bs-target='#exampleModal" + v.getVehicleID() + "'>View </button>");
                                out.println("</div>");
                                out.println("</div>");
                                out.println("</div>");
                                out.println("</div>");

                                out.println("<div class='modal fade' id='exampleModal" + v.getVehicleID() + "' tabindex='-1' aria-labelledby='exampleModalLabel' aria-hidden='true'>");

                                out.println("<div class='modal-dialog'>");
                                out.println("<div class='modal-content'>");
                                out.println("<div class='modal-header'>");
                                out.println("<h5 class='modal-title'>" + v.getTitle() + "</h5>");
                                out.println("<button type='button' class='btn-close' data-bs-dismiss='modal' aria-label='Close'></button>");
                                out.println("</div>");
                                out.println("<div class='modal-body'>");
                                out.println("<table>");
                                out.println("<tbody>");
                                out.println("<tr>");
                                out.println("<th>");
                                out.println("<label>Vehicle Brand</label>");
                                out.println("</th>");
                                out.println("<td>" + v.getBrand() + "</td>");
                                out.println("</tr>");
                                out.println("<tr>");
                                out.println("<th>");
                                out.println("<label>Model</label>");
                                out.println("</th>");
                                out.println("<td>" + v.getModel() + "</td>");
                                out.println("</tr>");
                                out.println("<tr>");
                                out.println("<th>");
                                out.println("<label>Year</label>");
                                out.println("</th>");
                                out.println("<td>" + v.getYear() + "</td>");
                                out.println("</tr>");
                                out.println("<tr>");
                                out.println("<th>");
                                out.println("<label>Vehicle Type</label>");
                                out.println("</th>");
                                out.println("<td>" + v.getVehicleType() + "</td>");
                                out.println("</tr>");
                                out.println("<tr>");
                                out.println("<th>");
                                out.println("<label>Color</label>");
                                out.println("</th>");
                                out.println("<td>" + v.getColor() + "</td>");
                                out.println("</tr>");
                                out.println("<tr>");
                                out.println("<th>");
                                out.println("<label>Seating Capacity</label>");
                                out.println("</th>");
                                out.println("<td>" + v.getSeatingCapacity() + "</td>");
                                out.println("</tr>");
                                out.println("<tr>");
                                out.println("<th>");
                                out.println("<label>Fuel Type</label>");
                                out.println("</th>");
                                out.println("<td>" + v.getFuelType() + "</td>");
                                out.println("</tr>");
                                out.println("<tr>");
                                out.println("<th>");
                                out.println("<label>Transmission Type</label>");
                                out.println("</th>");
                                out.println("<td>" + v.getTransmissionType() + "</td>");
                                out.println("</tr>");
                                out.println("<tr>");
                                out.println("<th>");
                                out.println("<label>Estimated Mileage</label>");
                                out.println("</th>");
                                out.println("<td>" + v.getMileage() + "</td>");
                                out.println("</tr>");
                                out.println("<tr>");
                                out.println("<th>");
                                out.println("<label>Features</label>");
                                out.println("</th>");
                                out.println("<td>" + v.getFeatures() + "</td>");
                                out.println("</tr>");
                                out.println("</tbody>");
                                out.println("</table>");

                                out.println("</div>");
                                out.println("<div class='modal-footer'>");
                                out.println("<button type='button' class='btn btn-secondary' data-bs-dismiss='modal'>Close</button>");
                                out.println("</div>");
                                out.println("</div>");
                                out.println("</div>");
                                out.println("</div>");

                            }
                        } catch (Exception e) {
                            out.println("<div class='alert alert-danger' role='alert'>Error retrieving vehicle list: " + search + min + max + airBags + airCondition + electricWindow + transmissionType + "</div>");
                        }
                    %>
                </div>            
            </div>
        </div>
    </body>
</html>
