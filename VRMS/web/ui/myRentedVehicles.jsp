<%@page import="vrms.classes.OrderObject"%>
<%@page import="vrms.classes.VehicleOrder"%>
<%@page import="vrms.classes.DbConnector"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vrms.classes.Vehicle"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%!
    String s = "";
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
        <link href="myRentedVehicles.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Home Page</title>
    </head>
    <body id="myRented-body">
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
                    <%
                        s = request.getParameter("s") != null ? request.getParameter("s") : "";
                        VehicleOrder vo1 = new VehicleOrder().getOrderDetails(DbConnector.getConnection(), s);
                        out.print("<h1>Order Details</h1>");
                        if (vo1 != null) {
                            
                            out.print("<table class='table' id='orderDetails-container'>");
                            out.print("<tbody>");
                            out.print("<tr>");
                            out.print("<th>Order ID</th>");
                            out.print("<td>" + vo1.getOrderID() + "</td>");
                            out.print("</tr>");
                            out.print("<tr>");
                            out.print("<th>Rented Day</th>");
                            out.print("<td>" + vo1.getStartDay() + "</td>");
                            out.print("</tr>");
                            out.print("<tr>");
                            out.print("<th>No.of Days</th>");
                            out.print("<td>" + vo1.getDays() + "</td>");
                            out.print("</tr>");
                            out.print("<tr>");
                            out.print("<th>Payment</th>");
                            out.print("<td>" + vo1.getPayment() + "</td>");
                            out.print("</tr>");
                            out.print("<tr>");
                            out.print("<th>Status</th>");
                            out.print("<td>" + vo1.getStatus() + "</td>");
                            out.print("</tr>");
                            out.print("</tbody>");
                            out.print("</table>");
                        }
                    %>
                </div>
                <div class="col-md-8">
                    <%
                        String search = request.getParameter("searchData");
                        String r = request.getParameter("r") != null ? request.getParameter("r") : "";
                        search = (search != null) ? search.toLowerCase() : "";
                        try {
                            if (search != null && !search.isEmpty()) {
//                                out.println("<div class='alert alert-success' role='alert'>Your Search Result :- " + search + "</div>");
                                out.println("<div class='alert alert-success alert-dismissible fade show' role='alert'>");
                                out.println("<strong>Your Search Result :-</strong> " + search + "");
                                out.println("<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>");
                                out.println("</div>");
                            }
                            if(r.equals("1")){
//                                out.println("<div class='alert alert-success' role='alert'>Thank you for Rating<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></div>");
//                                out.println("<div class='alert alert-success' role='alert'>Mark Order as Complete...!</div>");
                                out.println("<div class='alert alert-success alert-dismissible fade show' role='alert'>");
                                out.println("<strong>Thank you for Rating</strong>");
                                out.println("<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>");
                                out.println("</div>");
                            }else if(r.equals("2")){
//                                out.println("<div class='alert alert-success' role='alert'>Mark Order as Complete...!</div>");
                                out.println("<div class='alert alert-success alert-dismissible fade show' role='alert'>");
                                out.println("<strong>Mark Order as Complete...!</strong>");
                                out.println("<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>");
                                out.println("</div>");
                            }else if(r.equals("0")){
                                //out.println("<div class='alert alert-danger' role='alert'>Try again...!!!</div>");
                                out.println("<div class='alert alert-danger alert-dismissible fade show' role='alert'>");
                                out.println("<strong>Try again...!!!</strong>");
                                out.println("<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>");
                                out.println("</div>");
                            }
                            VehicleOrder vo = new VehicleOrder();
                            String username = (String) session.getAttribute("userName");
                            vo.setUsername(username);
                            List<OrderObject> vehicleIDList = vo.getRentedVehicleIDList(DbConnector.getConnection(), search);
                            for (OrderObject vid : vehicleIDList) {
                                Vehicle v = new Vehicle().getVehicleDetailsByID(DbConnector.getConnection(), vid.getVehicleId());

                                out.println("<div class='card mb-3 row d-flex justify-content-center col-md-12'>");
                                out.println("<div class='row g-0'>");
                                out.println("<div class='col-md-4 d-flex align-items-center'>");
                                out.println("<img src='../uploads/" + v.getImagePath() + "' style='width:100%' class='img-fluid rounded-start' alt='Image description'>");
                                out.println("</div>");
                                String style = "";
                                if (s.equals(vid.getOrderId())) {
                                    style = "style='background-color:rgba(88,128,128,0.5);color:white'";
                                }
                                
                                out.println("<div class='col-md-8'>");
                                out.println("<div class='card-body' " + style + " >");
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
                                out.println("<button type='button' class='btn btn-success' data-bs-toggle='modal' data-bs-target='#example" + v.getVehicleID() + "' >Order Recived </button>");
                                out.println("<button type='button' class='btn btn-secondary' onclick='createCookie(3)' data-bs-toggle='modal' data-bs-target='#exampleModal" + v.getVehicleID() + "'>View </button>");
                                out.println("<a href='myRentedVehicles.jsp?s=" + vid.getOrderId() + "' ><button type='button' class='btn btn-primary' >Order Details </button></a>");
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

                                out.println("<div class='modal fade' id='example" + v.getVehicleID() + "' tabindex='-1' aria-labelledby='exampleModalLabel' aria-hidden='true'>");

                                out.println("<div class='modal-dialog'>");
                                out.println("<div class='modal-content'>");
                                out.println("<div class='modal-header'>");
                                out.println("<h5 class='modal-title'>Rate Our Service</h5>");
                                out.println("<button type='button' class='btn-close' data-bs-dismiss='modal' aria-label='Close'></button>");
                                out.println("</div>");
                                out.println("<div class='modal-body'>");
                                out.println("<div class='container'>");
                                out.println("<div class='row'>");
                                out.println("<img class='rate-stars' id='star" + v.getVehicleID() + "1' onclick='handleRate(1," + v.getVehicleID() + ")'  src='../Images/unrateStar.svg' alt='star' style='width: 50px;cursor:pointer;' />");
                                out.println("<img class='rate-stars' id='star" + v.getVehicleID() + "2' onclick='handleRate(2," + v.getVehicleID() + ")' src='../Images/unrateStar.svg' alt='star' style='width: 50px;cursor:pointer;' />");
                                out.println("<img class='rate-stars' id='star" + v.getVehicleID() + "3' onclick='handleRate(3," + v.getVehicleID() + ")' src='../Images/unrateStar.svg' alt='star' style='width: 50px;cursor:pointer;' />");
                                out.println("<img class='rate-stars' id='star" + v.getVehicleID() + "4' onclick='handleRate(4," + v.getVehicleID() + ")' src='../Images/unrateStar.svg' alt='star' style='width: 50px;cursor:pointer;' />");
                                out.println("<img class='rate-stars' id='star" + v.getVehicleID() + "5' onclick='handleRate(5," + v.getVehicleID() + ")' src='../Images/unrateStar.svg' alt='star' style='width: 50px;cursor:pointer;' />");
                                
                                
                                out.println("</div>");
                                out.println("</div>");

                                out.println("</div>");
                                out.println("<div class='modal-footer'>");
                                //hidden form
                                out.println("<form id='rateform" + v.getVehicleID() + "' action='rateProcess.jsp' method='POST'>");
                                out.println("<input type='text' name='rateIndex' id='rateIndexId" + v.getVehicleID() + "' hidden />");
                                out.println("<input type='text' name='vehicleId' id='vehicleId" + v.getVehicleID() + "' value='" + vid.getVehicleId() + "' hidden />");
                                out.println("<input type='text' name='o' value='" + vid.getOrderId() + "' hidden />");
                                
                                out.println("<button type='button' onclick='handleSubmitRate()' class='btn btn-primary' data-bs-dismiss='modal'>Submit</button>");
                                out.println("<button type='button' onclick='handleRate(0," + v.getVehicleID() + ")' class='btn btn-danger'>Clear</button>");
                                out.println("<button type='button' onclick='handleSubmitRate()' class='btn btn-secondary' data-bs-dismiss='modal'>Close</button></a>");
                                out.println("</form>");
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
        <script>
    let val = 0; // Stores the rating value
    let id = 1; // Stores the vehicle ID for form submission

    // Function to handle star rating changes
    function handleRate(e, vid) {
        id = vid; // Set the current vehicle ID
        val = e;  // Set the rating value

        // Update star images based on the rating value
        for (let i = 1; i <= 5; i++) {
            document.getElementById("star"+vid + i).src = i <= e ? "../Images/rateStar.svg" : "../Images/unrateStar.svg";
        }
        
        // Update the hidden input field with the rating value
        document.getElementById("rateIndexId" + id).value = val;
    }

    // Function to submit the form with the selected rating
    function handleSubmitRate() {
        document.getElementById("rateIndexId" + id).value = val;
        document.getElementById("rateform" + id).submit();
    }
</script>
<jsp:include page="../components/footerComponent.jsp" />
    </body>
</html>
