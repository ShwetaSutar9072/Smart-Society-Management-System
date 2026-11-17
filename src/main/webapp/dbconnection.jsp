<%-- 
    Document   : dbconnection
    Created on : 30 Dec, 2024, 11:07:39 AM
    Author     : HP
--%>

<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
      <%
Class.forName("com.mysql.cj.jdbc.Driver");

String url = System.getenv("DB_URL");
String username = System.getenv("DB_USERNAME");
String password = System.getenv("DB_PASSWORD");

java.sql.Connection con =
    DriverManager.getConnection(url, username, password);
%>
    </body>
</html>
