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
        <link href="homePage.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Home Page</title>
    </head>
    <body id="homePage-body">
        <%
            String currentPage = "home";
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
                    <form action="homePage.jsp" class="form-control  mb-3" style="width: 18rem;">
                        <input type="text" value="sortData" name="sort" hidden />
                        <label class="row col-md-12 mb-3 m-1">min</label>
                        <input type="number" name="minPrice"  class="form-control col-md-10" value="0"/>

                        <label class="row col-md-12 mb-3 m-1">max</label>
                        <input type="number" name="maxPrice" class="form-control col-md-10" value="0"/>

                        <div class="row col-md-12 mb-3">   
                            <table class="col-md-10 mb-3">
                                <tbody>
                                    <tr>
                                        <th>
                                            <label class="m-2">Air Bags</label>                                            
                                        </th>
                                        <td>
                                            <input type="checkbox" name="airBag" value="1" class="form-check-input"/>
                                        </td>                                        
                                    </tr>
                                    <tr>
                                        <th class="">
                                            <label class="m-2">Air Condition</label>                                          
                                        </th>
                                        <td>
                                            <input type="checkbox" name="airCondition" value="1"  class="form-check-input "/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                            <label class="m-2">Electric Window</label>
                                        </th>  
                                        <td>
                                            <input type="checkbox" name="electricWindow" value="1"  class="form-check-input"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th class="p-3">
                                            <label class="m-2">Transmission Type</label><br>
                                            <input type="radio" name="transmissionType" value="auto" />Automatic
                                            <input type="radio" name="transmissionType" value="manual" />Manual
                                        </th>
                                    </tr>
                                </tbody>
                            </table>
                        </div>                    
                        <input class="row col-md-10 m-1 btn btn-primary" type="submit" value="Sort" />
                    </form>
                </div>
                <div class="col-md-8">
                    <%
                        String u = request.getParameter("u");
                        u = (u != null) ? u : "";
                        if (u.equals("0")) {
                            out.println("<div class='alert alert-danger alert-dismissible fade show mt-3' role='alert'>");
                            out.println("<strong>Profile can't be Change...Try again...!!!</strong>");
                            out.println("<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>");
                            out.println("</div>");
                        } else if (u.equals("1")) {
                            out.println("<div class='alert alert-success alert-dismissible fade show mt-3' role='alert'>");
                            out.println("<strong>Your Profile Successfully Changed...!!!</strong>");
                            out.println("<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>");
                            out.println("</div>");
                        }
                        String search = request.getParameter("searchData");
                        String sort = request.getParameter("sort");
                        search = (search != null) ? search.toLowerCase() : "";
                        sort = (sort != null) ? sort : "";

                        if (sort.equals("sortData")) {
                            min = Double.parseDouble(request.getParameter("minPrice"))/10;
                            max = Double.parseDouble(request.getParameter("maxPrice"))/10;
                            transmissionType = request.getParameter("transmissionType");
                            airBags = request.getParameter("airBag") != null;
                            airCondition = request.getParameter("airCondition") != null;
                            electricWindow = request.getParameter("electricWindow") != null;
                        }

                        try {
                            if (search != null && !search.isEmpty()) {
                                out.println("<div class='alert alert-success alert-dismissible fade show' role='alert'>");
                                out.println("<strong>Your Search Result :-</strong> " + search + "");
                                out.println("<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>");
                                out.println("</div>");
                            }
                            Vehicle vehicle = new Vehicle();
                            if (sort.equals("sortData")) {
                                vehicleList = vehicle.getSortedVehicleList(DbConnector.getConnection(), min, max, airBags, airCondition, electricWindow, transmissionType);
                                out.println("<div class='alert alert-success alert-dismissible fade show' role='alert'><strong>Your Sorted vehicle list:</strong> "
                                        + (min != 0 ? " Min: " + min*10 + " " : "")
                                        + (max != 0 ? " Max: " + max*10 + " " : "")
                                        + (airBags ? " Air Bags: Yes " : " ")
                                        + (airCondition ? " Air Condition: Yes " : " ")
                                        + (electricWindow ? " Electric Window: Yes " : "  ")
                                        + (transmissionType == "auto" | transmissionType == "manual" ? " Transmission Type: " + transmissionType : "  ")
                                        + "");
                                out.println("<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>");
                                out.println("</div>");

                            } else {
                                vehicleList = vehicle.getVehicleList(DbConnector.getConnection(), search);
                            }
                            for (Vehicle v : vehicleList) {
                                out.println("<div class='card mb-3 row d-flex justify-content-center col-md-12'>");
                                out.println("<div class='row g-0'>");
                                out.println("<div class='col-md-4 d-flex align-items-center'>");
                                out.println("<img src='../uploads/" + v.getImagePath() + "' class='img-fluid rounded-start' alt='Image description'>");

                                out.println("</div>");
                                out.println("<div class='col-md-8'>");
                                out.println("<div class='card-body'>");
                                out.println("<h5 class='card-title'>");
                                out.println(v.getTitle() + " &nbsp;&nbsp;");
                                int count = v.getVehicleRate(DbConnector.getConnection(), v.getVehicleID());
                                for (int i = 0; i < count; i++) {
                                    out.println("<img class='rate-stars' src='../Images/rateStar.svg' alt='star' style='width: 20px;' />");
                                }
                                for (int i = 0; i < 5 - count; i++) {
                                    out.println("<img class='rate-stars' src='../Images/unrateStar.svg' alt='star' style='width: 20px;' />");
                                }
                                out.println("</h5>");
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
                                out.println("<a href='rentVehicle.jsp?vid=" + v.getVehicleID() + "' class='btn btn-primary'>Rent</a>");
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
        <jsp:include page="../components/footerComponent.jsp" />
    </body>
</html>
