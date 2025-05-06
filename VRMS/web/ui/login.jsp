<%-- 
    Document   : login.jsp
    Created on : Jul 8, 2024, 2:30:32 PM
    Author     : rkcp8
--%>

<%@page import="vrms.classes.DbConnector"%>
<%@page import="vrms.classes.Users"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style>
            .was-validated .form-control:invalid {
                border-color: #dc3545;
            }
            .was-validated .form-control:valid {
                border-color: #28a745;
            }
        </style>
        <link href="login.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="../css/login.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>

        <title>VRMS Login</title>
    </head>
    <body>
        <jsp:include page="../components/headerComponent.jsp" /> 
        <div class="login-outer-container d-flex justify-content-center">
            <div class="container login-inner-container col-lg-5 d-flex justify-items-center justify-content-center">
                <img src="../Images/logo.png" class="col-4" style="width:200px;height: 200px;" />
                <form action="login.jsp" method="POST" class="needs-validation col-8" novalidate>
                    <%
                        String s = request.getParameter("s");
                        s = s != null ? s : "";
                        if (s.equals("1")) {
                            out.print("<div class='alert alert-success' role='alert'>");
                            out.print("Registration Success!");
                            out.print("</div>");
                        } else if (s.equals("2")) {
                            out.print("<div class='alert alert-danger' role='alert'>");
                            out.print("Invalid email or Password!");
                            out.print("</div>");
                        }

                        String email = request.getParameter("email");
                        email = email != null ? email : "";
                        if (!email.equals("")) {
                            String password = request.getParameter("password");
                            Users user = new Users(email, password);
                            if (user.validateUser(DbConnector.getConnection())) {
                                session = request.getSession();
                                session.setAttribute("userName", email);
                                session.setAttribute("userType", user.getUserTypebyUsername(DbConnector.getConnection(),email));
                                response.sendRedirect("homePage.jsp");
                            }else{
                                response.sendRedirect("login.jsp?s=2");
                            }
                        }
                    %>
                    <div class="form-group">
                        <label for="email">Email:</label>
                        <input id="userName" class="form-control" type="text" name="email" required>
                        <div class="invalid-feedback">
                            Please provide a email.
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="password">Password:</label>
                        <input id="password" class="form-control" type="password" name="password" required>
                        <div class="invalid-feedback">
                            Please provide a password.
                        </div>
                    </div>
                    <button class="btn btn-primary w-50 mt-2" type="submit">Login</button>
                    <a href="userRegister.jsp" class="btn btn-outline-secondary w-40 mt-2" >Register</a>
                    <a href="indexPage.jsp" class="btn btn-outline-danger w-40 mt-2" >Cancel</a>
                </form>
            </div>
        </div>
        <script>
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
        <jsp:include page="../components/footerComponent.jsp" />
    </body>
</html>
