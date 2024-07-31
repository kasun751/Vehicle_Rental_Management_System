<%-- 
    Document   : headerComponent
    Created on : Jul 8, 2024, 5:09:01 PM
    Author     : rkcp8
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%! 
    boolean status = false;
    
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../css/headerComponent.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
        <title>JSP Page</title>
    </head>
    <body>
        <div class="header-container">
            <div class="header-container-upper">
                <%
                    request.getSession(false);
                    String email = (session != null) ? (String) session.getAttribute("userName") : "";
                    if (email == null || email.isEmpty()) {
                        status = false;
                    } else {
                        status = true;
                    }
                %>
            </div>
            <div class="header-container-lower">
                <nav class="navbar navbar-expand-lg bg-body-tertiary">
                    <div class="container-fluid">
                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse" id="navbarSupportedContent">
                            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                                <li class="nav-item">
                                    <a href='../ui/indexPage.jsp' class="nav-link active" aria-current="page" href="#scrollspyHeading1">Home</a>
                                </li>
                               <%
                                    String currentPage = (String) request.getAttribute("currentPage");
                                    if ("index".equals(currentPage)) {
                                        out.print("<li class='nav-item'>");
                                        out.print("<a class='nav-link' href='#scrollspyHeading2'>About Us</a>");
                                        out.print("</li>");
                                        out.print("<li class='nav-item'>");
                                        out.print("<a class='nav-link' href='#scrollspyHeading3'>Our Services</a>");
                                        out.print("</li>");
                                        out.print("<li class='nav-item'>");
                                        out.print("<a class='nav-link' href='#scrollspyHeading4'>Contact Us</a>");
                                        out.print("</li>");
                                    }else if("home".equals(currentPage)){
                                        out.print("<li class='nav-item'>");
                                        out.print("<a class='nav-link' href='../ui/myRentedVehicles.jsp'>RentedVehicles</a>");
                                        out.print("</li>");
                                    }else if("myRentedVehicles".equals(currentPage)){
                                        out.print("<li class='nav-item'>");
                                        out.print("<a class='nav-link' href='../ui/homePage.jsp'>FindVehicle</a>");
                                        out.print("</li>");
                                    }
                                %>

                            </ul>
                            <script>
                                function refresh() {
                                    document.getElementById('searchData').value = ""
                                    document.getElementById('searchForm').submit();
                                    document.getElementById('sortClear').submit();
                                }
                            </script>
                            <form action="homePage.jsp" id="sortClear" hidden>
                                <input type="text" value="" name="sort"/>
                            </form>
                            <form action="homePage.jsp" id="searchForm" class="d-flex" role="search" >

                                <%
                                    if ("home".equals(currentPage) || "myRentedVehicles".equals(currentPage)) {
                                        out.print("<img src='../Images/refresh.svg' onclick='refresh()' alt='refresh-btn' style='margin-right: 10px;width:40px; cursor:pointer' />");
                                        out.print("<input class='form-control me-2' id='searchData' type='search' name='searchData' placeholder='Search' aria-label='Search' >");
                                        out.print("<button class='btn btn-outline-success' type='submit' >Search</button>");
                                        
                                    }
                                    if (!status) {
                                        out.print("<a href='login.jsp' class='btn btn-primary'>Login</a>");
                                        out.print("<a href='userRegister.jsp' class='btn btn-primary'>Register</a>");
                                    } else {
                                        if("index".equals(currentPage)){
                                            out.print("<a href='homePage.jsp' class='btn btn-primary'>Find Vehicle</a>");
                                            String userType =session.getAttribute("userType")!=null? (String)session.getAttribute("userType"):"";
                                            if(userType.equals("vehicleOwner")){
                                                out.print("<a href='dashboard.jsp' class='btn btn-primary'>Dashboard</a>");
                                            }                                            
                                        }
                                        out.print("<a href='logout.jsp' class='btn btn-secondary'>Log Out</a>");
                                    }
                                %>
                            </form>
                        </div>
                    </div>
                </nav>
            </div>
        </div>
    </body>
</html>
