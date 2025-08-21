<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="vrms.classes.DbConnector"%>
<%@page import="vrms.classes.Vehicle"%>

<%!
    String email = "";
%>
<%
    String currentPage = "manageVehicle";
    request.setAttribute("currentPage", currentPage);
    email = (session != null) ? (String) session.getAttribute("userName") : "";
    if (email == null || email.isEmpty()) {
        response.sendRedirect("login.jsp");
    }

    if (session != null && email != null) {
        List<Vehicle> vehicles = new ArrayList<Vehicle>();
        String userId = null;

        try {
            Connection con = DbConnector.getConnection();
            String query = "SELECT userID FROM users WHERE email = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                userId = rs.getString("userID");
            }
            rs.close();
            pstmt.close();

            query = "SELECT * FROM vehicleinfo WHERE ownerId = ?";
            pstmt = con.prepareStatement(query);
            pstmt.setString(1, email);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                Vehicle vehicle = new Vehicle(
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
                vehicles.add(vehicle);
            }
            rs.close();
            pstmt.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error.");
            return;
        }
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Vehicles</title>
        <!-- Bootstrap CSS CDN -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .table-responsive {
                overflow-x: auto;
            }
            td, th {
                vertical-align: middle;
                text-align: center;
            }
            .vehicle-img {
                width: 100px;
                height: 100px;
            }
            tr.clickable-row {
                cursor: pointer;
            }
            .collapse-row {
                display: none;
            }
            #manageVehicle-body{
                background: rgba(88,128,128,.2);
                height:100vh;
            }
        </style>
    </head>
    <body>
        <jsp:include page="../components/headerComponent.jsp" />
        <div id="manageVehicle-body">
            <!-- Header -->
            <!--        <header class="bg-light py-3 mb-4">
                        <div class="container">
                            <h1 class="text-center">Car Rental Management System</h1>
                        </div>
                    </header>-->

            <!-- Navigation Bar -->
            <!--        <nav class="navbar navbar-expand-lg mb-4">
                        <div class="container">
                            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                                <span class="navbar-toggler-icon"></span>
                            </button>
                            <div class="collapse navbar-collapse" id="navbarNav">
                                <ul class="navbar-nav">
                                    <li class="nav-item">
                                        <a class="nav-link" href="dashboard.jsp">Dashboard</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link active" href="manageVehicles.jsp">Manage Vehicles</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="profile.jsp">Profile</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="logout.jsp">Logout</a>
                                    </li>
                                </ul>
                            </div>
                    </nav>-->

            <!-- Container -->
            <div class="container">
                <h3 class="mb-3">Your Vehicles</h3>
                <div class="table-responsive">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Vehicle ID</th>
                                <th>Image</th>
                                <th>Brand</th>
                                <th>Model</th>
                                <th>Year</th>
                                <th>Type</th>
                                <th>Seating Capacity</th>
                                <th>Fuel Type</th>
                                <th>Transmission</th>
                                <th>Mileage</th>
                                <th>Rental Price</th>
                                <th>Availability</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Vehicle vehicle : vehicles) {%>
                            <tr class="clickable-row" data-bs-toggle="collapse" data-bs-target="#details<%= vehicle.getVehicleID()%>">
                                <td><%= vehicle.getVehicleID()%></td>
                                <td><img src="<%= "../uploads/" + vehicle.getImageURL()%>" alt="Vehicle Image" class="vehicle-img"></td>
                                <td><%= vehicle.getVehicleBrand()%></td>
                                <td><%= vehicle.getModel()%></td>
                                <td><%= vehicle.getYear()%></td>
                                <td><%= vehicle.getVehicleType()%></td>
                                <td><%= vehicle.getSeatingCapacity()%></td>
                                <td><%= vehicle.getFuelType()%></td>
                                <td><%= vehicle.getTransmissionType()%></td>
                                <td><%= vehicle.getMileage()%></td>
                                <td>$<%= vehicle.getRentalPrice()%></td>
                                <td><%= vehicle.isAvailability() ? "Available" : "Not Available"%></td>
                                <td>
                                    <a href="editVehicle.jsp?id=<%= vehicle.getVehicleID()%>" ><button class="btn btn-warning btn-sm edit-btn">Edit</button></a>
                                    <button class="btn btn-danger btn-sm" onclick="confirmDelete(<%= vehicle.getVehicleID()%>)">Remove</button>
                                </td>
                            </tr>
                            <tr class="collapse collapse-row" id="details<%= vehicle.getVehicleID()%>">
                                <td colspan="13">
                                    <div class="card card-body">
                                        <h5>Vehicle Details</h5>
                                        <p><strong>Features:</strong> <%= vehicle.getFeatures()%></p>
                                        <p><strong>Color:</strong> <%= vehicle.getColor()%></p>
                                        <p><strong>Insurance Info:</strong> <%= vehicle.getInsuranceInfo()%></p>
                                        <p><strong>Air Condition:</strong> <%= vehicle.isAirCondition() ? "Yes" : "No"%></p>
                                        <p><strong>Airbags:</strong> <%= vehicle.isAirBags() ? "Yes" : "No"%></p>
                                        <p><strong>Electric Window:</strong> <%= vehicle.isElectricWindow() ? "Yes" : "No"%></p>
                                    </div>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
                <h2 class="mb-4">Manage Vehicles</h2>
                <div class="mb-4 text-center">
                    <button id="openModalBtn" class="btn btn-primary btn-custom" data-bs-toggle="modal" data-bs-target="#addVehicleModal">Add Vehicle</button>
                </div>

                <!-- Confirmation Modal -->
                <div id="confirmModal" class="modal fade" tabindex="-1" aria-labelledby="confirmModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="confirmModalLabel">Delete Vehicle</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <p>Are you sure you want to delete this vehicle?</p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                <button type="button" class="btn btn-danger" id="deleteVehicleBtn">Delete</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Add Vehicle Modal -->
                <div id="addVehicleModal" class="modal fade" tabindex="-1" aria-labelledby="addVehicleModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="addVehicleModalLabel">Add Vehicle</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form id="addVehicleForm" action="addVehicle.jsp" method="post">
                                    <!-- Include form fields here -->
                                    <div class="mb-3">
                                        <label for="vehicleBrand" class="form-label">Vehicle Brand</label>
                                        <input type="text" class="form-control" id="vehicleBrand" name="vehicleBrand" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="model" class="form-label">Model</label>
                                        <input type="text" class="form-control" id="model" name="model" required>
                                    </div>
                                    <!-- Add more form fields as needed -->
                                    <button type="submit" class="btn btn-primary">Submit</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Bootstrap JS and dependencies -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                                        document.addEventListener("DOMContentLoaded", function () {
                                            document.querySelectorAll('.clickable-row').forEach(function (row) {
                                                row.addEventListener('click', function () {
                                                    this.nextElementSibling.classList.toggle('collapse-row');
                                                });
                                            });
                                        });

                                        function confirmDelete(vehicleID) {
                                            const modal = new bootstrap.Modal(document.getElementById('confirmModal'));
                                            modal.show();
                                            document.getElementById('deleteVehicleBtn').addEventListener('click', function () {
                                                window.location.href = 'deleteVehicle.jsp?id=' + vehicleID;
                                            });
                                        }
            </script>
        </div>
        <jsp:include page="../components/footerComponent.jsp" />
    </body>
</html>

<%
    } else {
        response.sendRedirect("login.jsp");
    }
%>
