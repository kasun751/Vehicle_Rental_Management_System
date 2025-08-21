<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="vrms.classes.Vehicle"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="vrms.classes.DbConnector"%>

<%
    String currentPage = "editVehicle";
    request.setAttribute("currentPage", currentPage);

    String email = (session != null) ? (String) session.getAttribute("userName") : "";
    if (email == null || email.isEmpty()) {
        response.sendRedirect("login.jsp");
    }
    String strvehicleId = request.getParameter("id");
    int vehicleId = Integer.parseInt(strvehicleId);
    Vehicle vehicle = null;

    try {
        Connection con = DbConnector.getConnection();
        String query = "SELECT * FROM vehicleinfo WHERE vehicleID = ?";
        PreparedStatement pstmt = con.prepareStatement(query);
        pstmt.setInt(1, vehicleId);
        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
            vehicle = new Vehicle(
                    rs.getInt("vehicleID"),
                    rs.getString("vehicleBrand"),
                    rs.getString("model"),
                    rs.getInt("year"),
                    rs.getString("vehicleType"),
                    rs.getInt("seatingCapacity"),
                    rs.getString("fuelType"),
                    rs.getString("transmissionType"),
                    rs.getDouble("mileage"),
                    rs.getDouble("rentalPrice"),
                    rs.getBoolean("availability"),
                    rs.getString("features"),
                    rs.getString("color"),
                    rs.getString("insuranceInfo"),
                    rs.getBoolean("airCondition"),
                    rs.getBoolean("airbags"),
                    rs.getBoolean("electricWindow"),
                    rs.getString("img_url")
            );
        }
        rs.close();
        pstmt.close();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error.");
    }
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit Vehicle</title>
        <!-- Bootstrap CSS CDN -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <jsp:include page="../components/headerComponent.jsp" />
        <div class="container">
            <h2 class="mt-4">Edit Vehicle</h2>
            <%
                String e = request.getParameter("e");
                e = (e != null) ? e : "";
                if (e.equals("0")) {
                    out.println("<div class='alert alert-danger alert-dismissible fade show mt-3' role='alert'>");
                    out.println("<strong>Vehicle Details can't be Change...Try again...!!!</strong>");
                    out.println("<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>");
                    out.println("</div>");
                } else if (e.equals("1")) {
                    out.println("<div class='alert alert-success alert-dismissible fade show mt-3' role='alert'>");
                    out.println("<strong>Vehicle Details Successfully Changed...!!!</strong>");
                    out.println("<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>");
                    out.println("</div>");
                }
            %>
            <% if (vehicle != null) {%>
            <form action="editvehicleProcess.jsp" method="post" enctype="multipart/form-data">
                <input type="hidden" name="vehicleID" value="<%= vehicle.getVehicleID()%>">
                <div class="row">
                    <div class="col-6 mb-3">
                        <label for="vehicleBrand" class="form-label">Vehicle Brand</label>
                        <input type="text" class="form-control" id="vehicleBrand" name="vehicleBrand" value="<%= vehicle.getVehicleBrand()%>" required>
                    </div>
                    <div class="col-6 mb-3">
                        <label for="model" class="form-label">Model</label>
                        <input type="text" class="form-control" id="model" name="model" value="<%= vehicle.getModel()%>" required>
                    </div>
                </div>
                <div class="row">
                    <div class="col-3 mb-3">
                        <label for="year" class="form-label">Year</label>
                        <input type="number" class="form-control" id="year" name="year" value="<%= vehicle.getYear()%>" required>
                    </div>
                    <div class="col-6 mb-3">
                        <label for="vehicleType" class="form-label">Vehicle Type</label>
                        <input type="text" class="form-control" id="vehicleType" name="vehicleType" value="<%= vehicle.getVehicleType()%>" required>
                    </div>
                    <div class="col-3 mb-3">
                        <label for="seatingCapacity" class="form-label">Seating Capacity</label>
                        <input type="number" class="form-control" id="seatingCapacity" name="seatingCapacity" value="<%= vehicle.getSeatingCapacity()%>" required>
                    </div>
                </div>
                <div class="row">
                    <div class="col-3 mb-3">
                        <label for="fuelType" class="form-label">Fuel Type</label>
                        <input type="text" class="form-control" id="fuelType" name="fuelType" value="<%= vehicle.getFuelType()%>" required>
                    </div>
                    <div class="col-3 mb-3">
                        <label for="transmissionType" class="form-label">Transmission Type</label>
                        <input type="text" class="form-control" id="transmissionType" name="transmissionType" value="<%= vehicle.getTransmissionType()%>" required>
                    </div>
                    <div class="col-3 mb-3">
                        <label for="mileage" class="form-label">Mileage</label>
                        <input type="number" step="0.1" class="form-control" id="mileage" name="mileage" value="<%= vehicle.getMileage()%>" required>
                    </div>
                    <div class="col-3 mb-3">
                        <label for="rentalPrice" class="form-label">Rental Price</label>
                        <input type="number" step="0.01" class="form-control" id="rentalPrice" name="rentalPrice" value="<%= vehicle.getRentalPrice()%>" required>
                    </div>
                </div>
                <div class="row">
                    <div class="col-6 mb-3">
                        <label for="features" class="form-label">Features</label>
                        <textarea class="form-control" id="features" name="features" rows="3" required><%= vehicle.getFeatures()%></textarea>
                    </div>
                    <div class="col-6 mb-3">
                        <label for="insuranceInfo" class="form-label">Insurance Info</label>
                        <textarea class="form-control" id="insuranceInfo" name="insuranceInfo" rows="3" required><%= vehicle.getInsuranceInfo()%></textarea>
                    </div>
                </div>
                <div class="col-6 mb-3">
                    <label for="image" class="form-label">Image</label>
                    <input type="file" class="form-control" id="image" name="image">
                    <img src="<%= "../uploads/"+vehicle.getImageURL()%>" alt="Current Image" class="img-fluid mt-2" style="max-width: 200px;">
                    <input type="hidden" name="currentImageURL" value="<%= vehicle.getImageURL()%>">
                </div>
                <div class="row">
                    <div class="col-3 mb-3">
                        <label for="color" class="form-label">Color</label>
                        <input type="text" class="form-control" id="color" name="color" value="<%= vehicle.getColor()%>" required>
                    </div>
                    <div class="col-3 mb-3">
                        <label for="availability" class="form-label">Availability</label>
                        <select class="form-control" id="availability" name="availability" required>
                            <option value="true" <%= vehicle.isAvailability() ? "selected" : ""%>>Available</option>
                            <option value="false" <%= !vehicle.isAvailability() ? "selected" : ""%>>Not Available</option>
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="col-3 mb-3 form-check">
                        <input type="checkbox" class="form-check-input" id="airCondition" name="airCondition" <%= vehicle.isAirCondition() ? "checked" : ""%>>
                        <label class="form-check-label" for="airCondition">Air Condition</label>
                    </div>
                    <div class="col-3 mb-3 form-check">
                        <input type="checkbox" class="form-check-input" id="airbags" name="airbags" <%= vehicle.isAirBags() ? "checked" : ""%>>
                        <label class="form-check-label" for="airbags">Airbags</label>
                    </div>
                    <div class="col-3 mb-3 form-check">
                        <input type="checkbox" class="form-check-input" id="electricWindow" name="electricWindow" <%= vehicle.isElectricWindow() ? "checked" : ""%>>
                        <label class="form-check-label" for="electricWindow">Electric Window</label>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary m-3">Save Changes</button>
                    <a href="manageVehicle.jsp" class="btn btn-secondary m-3">Cancel</a>
                </div>
            </form>
            <% } else { %>
            <p class="text-danger">Vehicle not found.</p>
            <% }%>
        </div>
        <!-- Bootstrap Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <jsp:include page="../components/footerComponent.jsp" />
    </body>
</html>
