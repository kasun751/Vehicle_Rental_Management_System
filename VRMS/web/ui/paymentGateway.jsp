<%-- 
    Document   : paymentGateway
    Created on : Jul 24, 2024, 6:21:27 PM
    Author     : rkcp8
--%>
<%!
      double payment;
    %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    
    <%        
        if(session.getAttribute("payment")!=null){
            payment = session.getAttribute("payment")!=null? (Double)session.getAttribute("payment"):0;
            //payment = Double.parseDouble(strPayment);
        }else{
            response.sendRedirect("homePage.jsp");
        }
    %>
<head>
    <link href="../css/paymentGateway.css" rel="stylesheet">
    <meta charset="UTF-8">
    <title>Dummy Payment Gateway</title>
</head>
<body>
    <div class="container">
        <h2>Payment Gateway</h2>    
        <form action="paymentProcess.jsp" method="post" id="paymentForm">
            <label for="cardNumber">Card Number</label>
            <input type="number" maxlength="16" id="cardNumber" name="cardNumber" required>

            <label for="cardHolderName">Card Holder Name</label>
            <input type="text" id="cardHolderName" name="cardHolderName" required>

            <label for="expiryDate">Expiry Date</label>
            <input type="text" id="expiryDate" name="expiryDate" required placeholder="MM/YY">

            <label for="cvv">CVV</label>
            <input type="number" maxlength="3" id="cvv" name="cvv" required>

            <label for="amount">Amount</label>
            <input type="number" id="amount" name="amount" value="<%= payment %>" disabled required>

            <input type="submit" onclick="handlePayment(event)" value="Pay Now">
        </form>
    </div>
    <script>
        function handlePayment(event){
            const cardNumber = document.getElementById('cardNumber').value;
            const cvv = document.getElementById('cvv').value;

            if(cardNumber.length !== 16){
                alert('Card number must be 16 digits');
                event.preventDefault();
            }

            if(cvv.length !== 3){
                alert('CVV must be 3 digits');
                event.preventDefault();
            }
        }
    </script>
</body>
</html>
