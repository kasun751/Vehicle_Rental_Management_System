<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.File"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.InputStream"%>
<%@page import="javax.servlet.ServletException"%>
<%@page import="javax.servlet.annotation.MultipartConfig"%>
<%@page import="javax.servlet.http.Part"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="vrms.classes.DbConnector"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <%
            String email = (session != null) ? (String) session.getAttribute("userName") : "";
            if (email == null || email.isEmpty()) {
                response.sendRedirect("login.jsp");
            }
        %>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add Vehicle</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <header class="bg-light py-3 mb-4">
            <div class="container">
                <h1 class="text-center">Add Vehicle</h1>
            </div>
        </header>

        <div class="container">
            <!-- Form for adding vehicle -->
            <form action="addvehicleProcess.jsp" method="post" enctype="multipart/form-data">
                <div class="mb-3">
                    <label for="vehicleBrand" class="form-label">Brand</label>
                    <input type="text" class="form-control" id="vehicleBrand" name="vehicleBrand" required>
                </div>
                <div class="mb-3">
                    <label for="model" class="form-label">Model</label>
                    <input type="text" class="form-control" id="model" name="model" required>
                </div>
                <div class="mb-3">
                    <label for="year" class="form-label">Year</label>
                    <input type="number" class="form-control" id="year" name="year" required>
                </div>
                <div class="mb-3">
                    <label for="vehicleType" class="form-label">Vehicle Type</label>
                    <input type="text" class="form-control" id="vehicleType" name="vehicleType" required>
                </div>
                <div class="mb-3">
                    <label for="seatingCapacity" class="form-label">Seating Capacity</label>
                    <input type="number" class="form-control" id="seatingCapacity" name="seatingCapacity" required>
                </div>
                <div class="mb-3">
                    <label for="fuelType" class="form-label">Fuel Type</label>
                    <input type="text" class="form-control" id="fuelType" name="fuelType" required>
                </div>
                <div class="mb-3">
                    <label for="transmissionType" class="form-label">Transmission Type</label>
                    <input type="text" class="form-control" id="transmissionType" name="transmissionType" required>
                </div>
                <div class="mb-3">
                    <label for="mileage" class="form-label">Mileage</label>
                    <input type="number" class="form-control" id="mileage" name="mileage" step="0.1" required>
                </div>
                <div class="mb-3">
                    <label for="rentalPrice" class="form-label">Rental Price</label>
                    <input type="number" class="form-control" id="rentalPrice" name="rentalPrice" step="0.01" required>
                </div>
                <div class="mb-3">
                    <label for="availability" class="form-label">Availability</label>
                    <select class="form-select" id="availability" name="availability" required>
                        <option value="true">Available</option>
                        <option value="false">Not Available</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="features" class="form-label">Features</label>
                    <textarea class="form-control" id="features" name="features" rows="3" required></textarea>
                </div>
                <div class="mb-3">
                    <label for="color" class="form-label">Color</label>
                    <input type="text" class="form-control" id="color" name="color" required>
                </div>
                <div class="mb-3">
                    <label for="insuranceInfo" class="form-label">Insurance Info</label>
                    <input type="text" class="form-control" id="insuranceInfo" name="insuranceInfo" required>
                </div>
                <div class="mb-3">
                    <label for="airCondition" class="form-label">Air Condition</label>
                    <select class="form-select" id="airCondition" name="airCondition" required>
                        <option value="true">Yes</option>
                        <option value="false">No</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="airbags" class="form-label">Airbags</label>
                    <select class="form-select" id="airbags" name="airbags" required>
                        <option value="true">Yes</option>
                        <option value="false">No</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="electricWindow" class="form-label">Electric Window</label>
                    <select class="form-select" id="electricWindow" name="electricWindow" required>
                        <option value="true">Yes</option>
                        <option value="false">No</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="imageFile" class="form-label">Upload Image</label>
                    <input type="file" class="form-control" id="imageFile" name="imageFile" accept="image/*" required>
                </div>
                <div class="text-center">
                    <button type="submit" class="btn btn-primary">Add Vehicle</button>
                </div>
            </form>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>
        <script>
            const input = document.getElementById('imageFile');
            input.addEventListener('change', (event) => {
                const target = event.target;
                if (target.files && target.files[0]) {
                    const maxAllowedSize = 5 * 1024 * 1024; // 5MB
                    if (target.files[0].size > maxAllowedSize) {
                        alert('File size exceeds 5MB limit.');
                        target.value = ''; // Clear the file input
                    }
                }
            });
        </script>
    </body>
</html>
