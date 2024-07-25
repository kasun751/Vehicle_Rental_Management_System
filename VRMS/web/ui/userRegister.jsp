<%-- 
    Document   : userRegister
    Created on : Jul 19, 2024, 9:21:13 PM
    Author     : rkcp8
--%>

<%@page import="vrms.classes.DbConnector"%>
<%@page import="vrms.classes.Users"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <title>User Registration</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            .was-validated .form-control:invalid {
                border-color: #dc3545;
            }
            .was-validated .form-control:valid {
                border-color: #28a745;
            }
        </style>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>
        <script>
            function handleChange() {
                var password1 = document.getElementById("password1").value;
                var password2 = document.getElementById("password2").value;

                if (password1 !== password2) {
                    document.getElementById("submit-btn").disabled = true;
                } else {
                    document.getElementById("submit-btn").disabled = false;
                }
            }
        </script>
    </head>
    <body>
        <%
            String nic = request.getParameter("nic");
            nic = nic != null ? nic : "";
            if (!nic.equals("")) {
                String fname = request.getParameter("firstname");
                String lname = request.getParameter("lastname");
                String phone = request.getParameter("phone");
                String email = request.getParameter("email");
                String address = request.getParameter("address");
                String city = request.getParameter("city");
                String password = request.getParameter("password");
                String confirmPassword = request.getParameter("confirmPassword");
                String account_type = request.getParameter("account_type");
                Users user1 = new Users();
                    out.print(""+email+"");
                if (user1.checkEmailAvailability(DbConnector.getConnection(), email)) {
                    if (password.equals(confirmPassword)) {
                        Users user = new Users(fname, lname, phone, email, address, city, nic, password, account_type);
                        if (user.addUsers(DbConnector.getConnection())) {
                            response.sendRedirect("login.jsp?s=1");
                        } else {
                            response.sendRedirect("userRegister.jsp?s=0");
                        }
                    } else {
                        response.sendRedirect("userRegister.jsp?s=3");
                    }
                } else {
                    response.sendRedirect("userRegister.jsp?s=4");
                }

            }
        %>
        <div class="user-registration-container col-5">
            <div class="container mt-5">
                <form action="userRegister.jsp" method="POST" class="needs-validation" novalidate>
                    <%
                        String s = request.getParameter("s");
                        s = s != null ? s : "";
                        if (s.equals("0")) {
                            out.print("<div class='alert alert-danger' role='alert'>");
                            out.print("Registration Failed!");
                            out.print("</div>");
                        } else if (s.equals("3")) {
                            out.print("<div class='alert alert-danger' role='alert'>");
                            out.print("Password and Confirm Password are not match");
                            out.print("</div>");
                            out.print("<div class='alert alert-danger' role='alert'>");
                            out.print("Registration Failed!");
                            out.print("</div>");                        
                        } else if (s.equals("4")) {
                            out.print("<div class='alert alert-danger' role='alert'>");
                            out.print("Email already exists. !!!");
                            out.print("</div>");
                        }
                    %>
                    <div class="row mb-3">
                        <div class="col">
                            <input type="text" name="firstname" class="form-control" placeholder="First name" required>
                            <div class="invalid-feedback">Please provide a first name.</div>
                        </div>
                        <div class="col">
                            <input type="text" name="lastname" class="form-control" placeholder="Last name" required>
                            <div class="invalid-feedback">Please provide a last name.</div>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col">
                            <input type="text" name="phone" class="form-control" placeholder="Phone number" required>
                            <div class="invalid-feedback">Please provide a phone number.</div>
                        </div>
                        <div class="col">
                            <input type="email" name="email" class="form-control" placeholder="Email" required>
                            <div class="invalid-feedback">Please provide a valid email address.</div>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col">
                            <input type="text" name="address" class="form-control" placeholder="Address" required>
                            <div class="invalid-feedback">Please provide an address.</div>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-6">
                            <input type="text" name="city" class="form-control" placeholder="City" required>
                            <div class="invalid-feedback">Please provide a city.</div>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-6">
                            <input type="text" name="nic" class="form-control" placeholder="NIC" required>
                            <div class="invalid-feedback">Please provide an NIC.</div>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col">
                            <input type="password" name="password" id="password1" class="form-control" placeholder="Password" required>
                            <div class="invalid-feedback">Please provide a password.</div>
                        </div>
                        <div class="col">
                            <input type="password" id="password2" name="confirmPassword" class="form-control" placeholder="Confirm password" required>
                            <div class="invalid-feedback">Please confirm your password.</div>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-6">
                            <label class="text-danger">Are you a Vehicle Owner?</label>
                            <div>
                                <input type="radio" name="account_type" value="vehicleOwner" required> Yes
                                <input type="radio" name="account_type" value="customer" checked> No
                                <div class="invalid-feedback">Please select an option.</div>
                            </div>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary">Submit</button>
                </form>
            </div>
        </div>
        <script>
            // Bootstrap custom validation
            (function () {
                'use strict';
                window.addEventListener('load', function () {
                    var forms = document.getElementsByClassName('needs-validation');
                    Array.prototype.filter.call(forms, function (form) {
                        form.addEventListener('submit', function (event) {
                            if (form.checkValidity() === false) {
                                event.preventDefault();
                                event.stopPropagation();
                            }
                            form.classList.add('was-validated');
                        }, false);
                    });
                }, false);
            })();
        </script>
    </body>
</html>

