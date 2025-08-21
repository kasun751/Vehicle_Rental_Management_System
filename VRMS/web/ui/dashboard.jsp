<%-- 
    Document   : dashboard
    Created on : Jul 27, 2024, 12:57:26 AM
    Author     : rkcp8
--%>

<%@page import="vrms.classes.DbConnector"%>
<%@page import="vrms.classes.Users"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Vehicle Management System Dashboard</title>
        <!--        <link rel="stylesheet" href="styles.css">-->
        <style>
            .table-responsive {
                overflow-x: auto;
            }
            td, th {
                vertical-align: middle;
                text-align: center;
            }
            .collapse-row {
                display: none;
            }
            #dashboard-body main {
                background: rgba(88,128,128,.2);
                height:100vh;
            }
            .control-panel {
                margin: 20px 0;
                text-align: center;
            }

            .control-button {
                background-color: #008cba;
                color: white;
                border: none;
                padding: 15px 32px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 16px;
                margin: 4px 2px;
                cursor: pointer;
                border-radius: 8px;
            }

            .control-button:hover {
                background-color: #005f73;
            }
        </style>
    </head>
    <body>
        <%
            String currentPage = "dashboard";
            request.setAttribute("currentPage", currentPage);
        %>
        <jsp:include page="../components/headerComponent.jsp" />
        <%
            String u = request.getParameter("u");
            u = (u != null) ? u : "";
            if (u.equals("0")) {
                out.println("<div class='alert alert-danger alert-dismissible fade show mt-3' role='alert'>");
                out.println("<strong>Profile can't be Change...Try again...!!!</strong>");
                out.println("<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>");
                out.println("</div>");
            } else if (u.equals("1")) {
                out.println("<div class='alert alert-success alert-dismissible fade show mt-3' role='alert'>");
                out.println("<strong>Your Profile Successfully Changed...!!!</strong>");
                out.println("<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>");
                out.println("</div>");
            }
        %>
        <div class="container">
            <div id="dashboard-body">
                <main>
                    <h2 class="d-flex justify-content-center mb-5">Welcome to the Dashboard</h2>
                    <div class="container">
                        <div class="row">
                            <div class="col-4">
                                <%
                                    boolean status;
                                    request.getSession(false);
                                    String email = (session != null) ? (String) session.getAttribute("userName") : "";
                                    if (email == null || email.isEmpty()) {
                                        status = false;
                                        response.sendRedirect("login.jsp");
                                    } else {
                                        status = true;
                                    }
                                    if (status) {
                                        Users user = new Users().getUserByUserName(DbConnector.getConnection(), email);
                                        if (user != null) {
                                            out.print("<table class='table'>");
                                            out.print("<tbody>");
                                            out.print("<tr>");
                                            out.print("<th>User ID</th>");
                                            out.print("<td>" + user.getUserID() + "</td>");
                                            out.print("</tr>");
                                            out.print("<tr>");
                                            out.print("<th>First Name</th>");
                                            out.print("<td>" + user.getFirstname() + "</td>");
                                            out.print("</tr>");
                                            out.print("<tr>");
                                            out.print("<th>Last Name</th>");
                                            out.print("<td>" + user.getLastname() + "</td>");
                                            out.print("</tr>");
                                            out.print("<tr>");
                                            out.print("<th>Phone Number</th>");
                                            out.print("<td>" + user.getPhone() + "</td>");
                                            out.print("</tr>");
                                            out.print("<tr>");
                                            out.print("<th>Email(username)</th>");
                                            out.print("<td>" + user.getEmail() + "</td>");
                                            out.print("</tr>");
                                            out.print("<tr>");
                                            out.print("<th>Address</th>");
                                            out.print("<td>" + user.getAddress() + "</td>");
                                            out.print("</tr>");
                                            out.print("<tr>");
                                            out.print("<th>City</th>");
                                            out.print("<td>" + user.getCity() + "</td>");
                                            out.print("</tr>");
                                            out.print("<tr>");
                                            out.print("<th>NIC</th>");
                                            out.print("<td>" + user.getNic() + "</td>");
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
                                <div class='modal fade' id='exampleModal57' tabindex='-1' aria-labelledby='exampleModalLabel' aria-hidden='true'>
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
                                                        String userType = session.getAttribute("userType") != null ? (String) session.getAttribute("userType") : "";
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
                            </div>
                            <div class="col-8">
                                <h3 class="d-flex justify-content-center">Control Panel</h3>
                                <div class="control-panel">
                                    <button class="control-button " type='button' class='btn btn-primary' data-bs-dismiss='modal' data-bs-toggle='modal' data-bs-target='#exampleModal57' <% out.print(userType.equals("admin")? "hidden":""); %>>Edit Profile</button>
                                    <a href="vehicleSummaryPage.jsp"><button class="control-button">Get Summary</button><a/>
                                        <a href="manageVehicle.jsp" class="control-button" <% out.print(userType.equals("admin")? "hidden":""); %>>My Vehicles</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div> 
        <jsp:include page="../components/footerComponent.jsp" />
    </body>
</html>
