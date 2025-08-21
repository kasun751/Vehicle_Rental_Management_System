<%-- 
    Document   : orderResultPage
    Created on : Jul 24, 2024, 11:20:05 PM
    Author     : rkcp8
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="../css/orderResultPage.css" />
    <meta charset="UTF-8">
    <title>Order Placed Successfully</title>
</head>
<body>
    <div class="container">
        <h1>Order Placed Successfully!</h1>
        <p>Thank you for your order. Your order ID is: <strong>${orderID}</strong></p>
        <p>You will receive a confirmation email shortly.</p>
        <a href="homePage.jsp" class="button">Return to Home</a>
        <a href="myRentedVehicles.jsp" class="button">Go to Rented Vehicle</a>
    </div>
</body>
</html>

