<%-- 
    Document   : dashboard
    Created on : Jul 27, 2024, 12:57:26 AM
    Author     : rkcp8
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link href="../css/dashboard.css" rel="stylesheet">
    <title>Vehicle Management System Dashboard</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Vehicle Management System</h1>
        </header>
        <main>
            <h2>Welcome to the Dashboard</h2>
            <p>Use the navigation menu to manage vehicles, users, and view reports.</p>
            <section>
                <h3>Control Panel</h3>
                <div class="control-panel">
                    <button class="control-button">Edit Profile</button>
                    <a href="vehicleSummaryPage.jsp"><button class="control-button">Get Summary</button><a/>
                    <button class="control-button">My Vehicles</button>
                    <button class="control-button">Remove Vehicle</button>
                    <button class="control-button">Remove Vehicle</button>
                </div>
            </section>
        </main>
        <footer>
            <p>&copy; 2024 Vehicle Management System</p>
        </footer>
    </div>
</body>
</html>
