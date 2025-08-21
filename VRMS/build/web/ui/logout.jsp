<%-- 
    Document   : logout
    Created on : Jul 20, 2024, 4:26:56 PM
    Author     : rkcp8
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
  session.invalidate();
  response.sendRedirect("indexPage.jsp");
%>
