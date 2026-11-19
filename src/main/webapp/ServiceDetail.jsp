<%@ include file="/WEB-INF/jspf/init.jspf" %>
<% String role = "resident"; String pageTitle = "Service"; %>
<%@ include file="/WEB-INF/jspf/guard.jspf" %>
<%
    Catalog.Svc svc = Catalog.service(Web.toInt(request.getParameter("type"), -1));
    if (svc == null) { response.sendRedirect("SearchService.jsp"); return; }
    pageTitle = svc.title;
    Integer price = null;
    try (Connection con = Db.get();
         PreparedStatement ps = con.prepareStatement("SELECT amount FROM addservices WHERE service = ?")) {
        ps.setString(1, svc.name);
        try (ResultSet rs = ps.executeQuery()) { if (rs.next()) price = rs.getInt(1); }
    }
%>
<%@ include file="/WEB-INF/jspf/header.jspf" %>
<div class="container py-5">
    <div class="row g-5 align-items-center">
        <div class="col-lg-6 order-lg-last"><img class="about-img" src="img/<%= svc.image %>" alt="<%= h(svc.title) %>"></div>
        <div class="col-lg-6">
            <h1 class="fw-bold text-success"><%= h(svc.title) %></h1>
            <p class="text-muted">Our comprehensive society service covers:</p>
            <ul class="feature-list mb-4">
<% for (String f : svc.features) { %>                <li><%= h(f) %></li>
<% } %>
            </ul>
<% if (price != null) { %>
            <p class="fs-4 fw-bold mb-3">&#8377;<%= price %> <small class="text-muted fs-6 fw-normal">per subscription</small></p>
            <a class="btn btn-success btn-lg" href="Subscribe.jsp?type=<%= svc.type %>"><i class="bi bi-bag-plus"></i> Subscribe</a>
<% } else { %>
            <div class="alert alert-warning mb-0">The price for this service has not been set yet. Please check back soon.</div>
<% } %>
        </div>
    </div>

    <h2 class="h4 fw-bold mt-5 mb-3">Contact the provider</h2>
    <div class="ss-table table-responsive">
        <table class="table align-middle">
            <thead><tr><th>Service</th><th>Provider</th><th>Address</th><th>Mobile</th></tr></thead>
            <tbody>
<%
    int rows = 0;
    try (Connection con = Db.get();
         PreparedStatement ps = con.prepareStatement("SELECT servicename, pro_name, address, mob_no FROM otherservices WHERE servicename = ? ORDER BY sno")) {
        ps.setString(1, svc.name);
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                rows++;
%>
                <tr>
                    <td><%= h(rs.getString("servicename")) %></td>
                    <td><%= h(rs.getString("pro_name")) %></td>
                    <td><%= h(rs.getString("address")) %></td>
                    <td><a href="tel:<%= h(rs.getString("mob_no")) %>"><%= h(rs.getString("mob_no")) %></a></td>
                </tr>
<%
            }
        }
    }
    if (rows == 0) {
%>
                <tr><td colspan="4"><div class="empty-state"><i class="bi bi-person-vcard"></i>No provider has been listed yet.</div></td></tr>
<% } %>
            </tbody>
        </table>
    </div>
    <div class="mt-4"><a class="btn btn-outline-secondary" href="SearchService.jsp"><i class="bi bi-arrow-left"></i> All services</a></div>
</div>
<%@ include file="/WEB-INF/jspf/footer.jspf" %>
