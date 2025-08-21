<%@page import="vrms.classes.DbConnector"%>
<%@page import="vrms.classes.Users"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!
    boolean status = false;
    String email = "";
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../css/headerComponent.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
        <!--        <script>
                    function handleEdit(lname, sname, val) {
                        document.getElementById("edit-label").innerHTML = lname;
                        document.getElementById("exampleModalLabel").innerHTML = 'Edit' + lname;
                        document.getElementById("edit-field").value = val;
                        document.getElementById("edit-field").name = sname;
                    }
                </script>-->
        <title>JSP Page</title>
    </head>
    <body>
        <%
            request.getSession(false);
            email = (session != null) ? (String) session.getAttribute("userName") : "";
            if (email == null || email.isEmpty()) {
                status = false;
            } else {
                status = true;
            }
        %>
        <div class="header-container">
            <div class="header-container-upper">
                <div class="container">
                    <div class="row">
                        <div class="col-4 logo-container">
                            <img src="../Images/logo.png" />
                        </div>
                        <div class="col-8">
                            <h1 id="vrms-header" class="mt-4">Vehicle Rental Management System</h1>
                        </div>
                    </div>
                </div>
            </div>
            <div class="header-container-lower">
                <nav id="navbar-example2" class="navbar navbar-expand-lg">
                    <style>
                        .navbar-toggler {
                            border-color: white;
                        }
                        .navbar-toggler-icon {
                            background-image: url("data:image/svg+xml;charset=UTF8,%3Csvg viewBox='0 0 30 30' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath stroke='rgba(255, 255, 255, 1)' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3E%3C/svg%3E"); /* Change bar color to white */
                        }
                    </style>
                    <div class="container-fluid">
                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse" id="navbarSupportedContent">
                            <ul class="nav nav-pills me-auto mb-2 mb-lg-0">
                                <li class="nav-item">
                                    <a href='../ui/indexPage.jsp' class="nav-link btn btn-outline-primary" aria-current="page" >Home</a>
                                </li>
                                <%
                                    String currentPage = (String) request.getAttribute("currentPage");
                                    if ("index".equals(currentPage)) {
                                        out.print("<li class='nav-item'>");
                                        out.print("<a class='nav-link btn btn-outline-primary' href='#scrollspyHeading3'>About Us</a>");
                                        out.print("</li>");
                                        out.print("<li class='nav-item'>");
                                        out.print("<a class='nav-link btn btn-outline-primary' href='#scrollspyHeading4'>Our Services</a>");
                                        out.print("</li>");
                                        out.print("<li class='nav-item'>");
                                        out.print("<a class='nav-link btn btn-outline-primary' href='#scrollspyHeading5'>Contact Us</a>");
                                        out.print("</li>");
                                    } else if ("home".equals(currentPage) || "vehicleSummary".equals(currentPage)) {
                                        out.print("<li class='nav-item'>");
                                        out.print("<a class='nav-link btn btn-outline-primary' href='../ui/myRentedVehicles.jsp'>RentedVehicles</a>");
                                        out.print("</li>");
                                        String userType = session.getAttribute("userType") != null ? (String) session.getAttribute("userType") : "";
                                        if (userType.equals("vehicleOwner") || userType.equals("admin")) {
                                            out.print("<li class='nav-item'>");
                                            out.print("<a class='nav-link btn btn-outline-primary' href='../ui/dashboard.jsp'>DashBoard</a>");
                                            out.print("</li>");
                                        } else {
                                            out.print("<li class='nav-item'>");
                                            out.print("<a class='nav-link btn btn-outline-primary' href='' data-bs-toggle='modal' data-bs-target='#staticBackdrop'>My Profile</a>");
                                            out.print("</li>");
                                        }
                                    } else if ("myRentedVehicles".equals(currentPage)) {
                                        out.print("<li class='nav-item'>");
                                        out.print("<a class='nav-link btn btn-outline-primary' href='../ui/homePage.jsp'>FindVehicle</a>");
                                        out.print("</li>");
                                    } else if ("manageVehicle".equals(currentPage)) {
                                        out.print("<li class='nav-item'>");
                                        out.print("<a class='nav-link btn btn-outline-primary' href='../ui/dashboard.jsp'>DashBoard</a>");
                                        out.print("</li>");
                                    } else if ("editVehicle".equals(currentPage)) {
                                        out.print("<li class='nav-item'>");
                                        out.print("<a class='nav-link btn btn-outline-primary' href='../ui/manageVehicle.jsp'>My Vehicles</a>");
                                        out.print("</li>");
                                    } else if ("dashboard".equals(currentPage)) {
                                        out.print("<li class='nav-item'>");
                                        out.print("<a class='nav-link btn btn-outline-primary' href='../ui/homePage.jsp'>FindVehicle</a>");
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
                            <form action="homePage.jsp" id="searchForm" role="search" >
                                <%
                                    if ("home".equals(currentPage) || "myRentedVehicles".equals(currentPage)) {
                                        out.print("<img src='../Images/refresh-btn.svg' class='d-inline' onclick='refresh()' alt='refresh-btn' style='margin-right: 10px;width:40px; cursor:pointer' />");
                                        out.print("<input class='form-control me-2 d-inline' id='searchData' type='search' name='searchData' placeholder='Search' aria-label='Search' style='width:40%;'>");
                                        out.print("<button class='btn btn-outline-success d-inline' type='submit' >Search</button>");
                                    }
                                    if (!status) {
                                        out.print("<a href='login.jsp' class='btn btn-primary'>Login</a>");
                                        out.print("<a href='userRegister.jsp' class='btn btn-outline-secondary'>Register</a>");
                                    } else {
                                        if ("index".equals(currentPage)) {
                                            out.print("<a href='homePage.jsp' class='btn btn-primary'>Find Vehicle</a>");
                                            String userType = session.getAttribute("userType") != null ? (String) session.getAttribute("userType") : "";
                                            if (userType.equals("vehicleOwner")) {
                                                out.print("<a href='dashboard.jsp' class='btn btn-outline-primary'>Dashboard</a>");
                                            } else {
                                                out.print("<a class='btn btn-outline-primary' data-bs-toggle='modal' data-bs-target='#staticBackdrop'>My Profile</a>");
                                            }
                                        }
                                        out.print("<a href='logout.jsp' class='btn btn-outline-danger d-inline'>Log Out</a>");
                                    }
                                %>
                            </form>
                        </div>
                    </div>
                </nav>
            </div>
        </div>

        <!-- Modal -->
        <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="staticBackdropLabel">Profile Details</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <%
                            if (status) {
                                Users user = new Users().getUserByUserName(DbConnector.getConnection(), email);
                                if (user != null) {
                                    out.print("<table class='table'>");
                                    out.print("<tbody>");
                                    out.print("<tr>");
                                    out.print("<th>User ID</th>");
                                    out.print("<td>" + user.getUserID() + "</td>");
                                    //out.print("<td>" + "" + "</td>");
                                    out.print("</tr>");
                                    out.print("<tr>");
                                    out.print("<th>First Name</th>");
                                    out.print("<td>" + user.getFirstname() + "</td>");
                                    //out.print("<td><button type='button' class='btn btn-primary' data-bs-dismiss='modal' data-bs-toggle='modal' data-bs-target='#exampleModal56'>Edit </button></td>");
                                    out.print("</tr>");
                                    out.print("<tr>");
                                    out.print("<th>Last Name</th>");
                                    out.print("<td>" + user.getLastname() + "</td>");
                                    //out.print("<td></td>");
                                    out.print("</tr>");
                                    out.print("<tr>");
                                    out.print("<th>Phone Number</th>");
                                    out.print("<td>" + user.getPhone() + "</td>");
                                    //out.print("<td></td>");
                                    out.print("</tr>");
                                    out.print("<tr>");
                                    out.print("<th>Email(username)</th>");
                                    out.print("<td>" + user.getEmail() + "</td>");
                                    //out.print("<td>" + "" + "</td>");
                                    out.print("</tr>");
                                    out.print("<tr>");
                                    out.print("<th>Address</th>");
                                    out.print("<td>" + user.getAddress() + "</td>");
                                    //out.print("<td></td>");
                                    out.print("</tr>");
                                    out.print("<tr>");
                                    out.print("<th>City</th>");
                                    out.print("<td>" + user.getCity() + "</td>");
                                    //out.print("<td></td>");
                                    out.print("</tr>");
                                    out.print("<tr>");
                                    out.print("<th>NIC</th>");
                                    out.print("<td>" + user.getNic() + "</td>");
                                    //out.print("<td></td>");
                                    out.print("</tr>");
                                    out.print("<tr>");
                                    out.print("<th>Account Type</th>");
                                    out.print("<td>" + user.getAccount_type() + "</td>");
                                    //out.print("<td>" + "" + "</td>");
                                    out.print("</tr>");
                                    out.print("</tbody>");
                                    out.print("</table>");
                                }

                            }
                        %>
                    </div>
                    <div class="modal-footer">
                        <button type='button' class='btn btn-primary' data-bs-dismiss='modal' data-bs-toggle='modal' data-bs-target='#exampleModal56'>Edit </button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <div class='modal fade' id='exampleModal56' tabindex='-1' aria-labelledby='exampleModalLabel' aria-hidden='true'>
            <div class='modal-dialog'>
                <div class='modal-content'>
                    <form action="userEditProcess.jsp" method="POST">
                        <div class='modal-header'>
                            <h1 class='modal-title fs-5' id='exampleModalLabel'>Edit</h1>
                            <button type='submit' class='btn-close' data-bs-dismiss='modal' aria-label='Close'></button>
                        </div>

                        <div class='modal-body'>
                            <%
                                if (status) {
                                    Users user = new Users().getUserByUserName(DbConnector.getConnection(), email);
                                    if (user != null) {
                                        out.print("<table class='table'>");
                                        out.print("<tbody>");
                                        out.print("<tr>");
                                        out.print("<th>User ID</th>");
                                        out.print("<td><input type='text' name='userID' value='" + user.getUserID() + "' hidden>" + user.getUserID() + "</td>");
                                        out.print("</tr>");
                                        out.print("<tr>");
                                        out.print("<th>First Name</th>");
                                        out.print("<td><input type='text' class='form-control' name='fname' value='" + user.getFirstname() + "' ></td>");
                                        out.print("</tr>");
                                        out.print("<tr>");
                                        out.print("<th>Last Name</th>");
                                        out.print("<td><input type='text' class='form-control' name='lname' value='" + user.getLastname() + "' ></td>");
                                        out.print("</tr>");
                                        out.print("<tr>");
                                        out.print("<th>Phone Number</th>");
                                        out.print("<td><input type='number' class='form-control' name='phone' value='" + user.getPhone() + "' ></td>");
                                        out.print("</tr>");
                                        out.print("<tr>");
                                        out.print("<th>Email(username)</th>");
                                        out.print("<td>" + user.getEmail() + "</td>");
                                        out.print("</tr>");
                                        out.print("<tr>");
                                        out.print("<th>Address</th>");
                                        out.print("<td><input type='text' class='form-control' name='address' value='" + user.getAddress() + "' ></td>");
                                        out.print("</tr>");
                                        out.print("<tr>");
                                        out.print("<th>City</th>");
                                        out.print("<td><input type='text' class='form-control' name='city' value='" + user.getCity() + "' ></td>");
                                        out.print("</tr>");
                                        out.print("<tr>");
                                        out.print("<th>NIC</th>");
                                        out.print("<td><input type='text' class='form-control' name='nic' value='" + user.getNic() + "' ></td>");
                                        out.print("</tr>");
                                        out.print("<tr>");
                                        out.print("<th>Account Type</th>");
                                        out.print("<td>" + user.getAccount_type() + "</td>");
                                        out.print("</tr>");
                                        out.print("</tbody>");
                                        out.print("</table>");
                                    }

                                }
                            %>
                        </div>
                        <div class='modal-footer'>
                            <button type='submit' class='btn btn-secondary' data-bs-dismiss='modal'>Close</button>
                            <button type='submit' name="editSubmit" class='btn btn-primary'>Save changes</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
