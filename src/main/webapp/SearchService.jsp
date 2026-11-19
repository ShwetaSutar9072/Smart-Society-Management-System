<%@ include file="/WEB-INF/jspf/init.jspf" %>
<% String role = "resident"; String pageTitle = "Services"; %>
<%@ include file="/WEB-INF/jspf/guard.jspf" %>
<%
    String[] cardImg = {"security.jpg", "cleaning.jpg", "water.jpg", "electricity.jpg"};
%>
<%@ include file="/WEB-INF/jspf/header.jspf" %>
<div class="page-head"><div class="container"><h1>Our services</h1><p>Pick a service to see what it covers, who provides it, and to subscribe.</p></div></div>
<div class="container py-5">
    <div class="row g-4">
<% for (Catalog.Svc s : Catalog.SERVICES) { %>
        <div class="col-sm-6 col-lg-3">
            <a class="svc-card" href="ServiceDetail.jsp?type=<%= s.type %>">
                <img src="img/<%= cardImg[s.type - 1] %>" alt="<%= h(s.title) %>" loading="lazy">
                <span class="svc-label"><span style="text-transform:none"><%= h(s.title) %></span> <i class="bi bi-arrow-right-circle"></i></span>
            </a>
        </div>
<% } %>
    </div>
</div>
<%@ include file="/WEB-INF/jspf/footer.jspf" %>
