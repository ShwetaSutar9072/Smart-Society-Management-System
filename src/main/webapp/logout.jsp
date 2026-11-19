<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Works for both resident and admin sessions.
    session.invalidate();
    response.sendRedirect("Mainhome.jsp?loggedout=1");
%>
