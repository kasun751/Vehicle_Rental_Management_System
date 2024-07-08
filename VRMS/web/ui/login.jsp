<%-- 
    Document   : login.jsp
    Created on : Jul 8, 2024, 2:30:32 PM
    Author     : rkcp8
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="../css/login.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>
        
        <title>VRMS Login</title>
    </head>
    <body>
        <div class="login-outer-container">
            <div class="container login-inner-container mt-5 col-7">
                <form action="../loginvalidate" method="POST">
                    User Name: 
                    <input class="form-control" type="text" name="userName" /><br>
                    Password:
                    <input class="form-control" type="password" name="password" /><br>
                    <input class="btn btn-primary" type="submit" value="Login" />
                </form>
            </div>
        </div>
    </body>
</html>
