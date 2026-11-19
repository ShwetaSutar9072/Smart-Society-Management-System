<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<%@ page import="com.mycompany.smartsocietymca.Web" %>
<%
    Integer status = (Integer) request.getAttribute("jakarta.servlet.error.status_code");
    boolean notFound = status != null && status == 404;
    if (exception != null) {
        application.log("Unhandled error on " + request.getAttribute("jakarta.servlet.error.request_uri"), exception);
    }
    response.setStatus(notFound ? 404 : 500);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><%= notFound ? "Page not found" : "Something went wrong" %> | Smart Society</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/bootstrap-icons.min.css">
    <link rel="stylesheet" href="css/site.css">
</head>
<body>
<main class="d-flex align-items-center" style="min-height:100vh">
    <div class="container text-center" style="max-width:560px">
        <div class="ss-card">
            <i class="bi <%= notFound ? "bi-compass" : "bi-exclamation-triangle" %> display-4 text-success"></i>
            <h1 class="h3 mt-3"><%= notFound ? "Page not found" : "Something went wrong" %></h1>
            <p class="text-muted">
                <%= notFound ? "The page you are looking for does not exist or has moved."
                             : "We couldn't complete that request. Please try again in a moment. If the problem continues, contact the society office." %>
            </p>
            <a class="btn btn-success" href="Mainhome.jsp"><i class="bi bi-house-door"></i> Back to home</a>
        </div>
    </div>
</main>
</body>
</html>
