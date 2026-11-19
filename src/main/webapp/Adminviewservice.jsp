<%@ include file="/WEB-INF/jspf/init.jspf" %>
<% String role = "admin"; String pageTitle = "Subscriptions"; %>
<%@ include file="/WEB-INF/jspf/guard.jspf" %>
<%
    int type = Web.toInt(request.getParameter("type"), 1);
    Catalog.Svc svc = Catalog.service(type);
    if (svc == null) { svc = Catalog.service(1); type = 1; }
%>
<%@ include file="/WEB-INF/jspf/header.jspf" %>
<div class="page-head"><div class="container"><h1>Service subscriptions</h1><p>See which residents subscribed to each service.</p></div></div>
<div class="container py-5">
    <ul class="nav nav-pills mb-4 gap-2">
<% for (Catalog.Svc s : Catalog.SERVICES) { %>
        <li class="nav-item"><a class="nav-link border<%= s.type == svc.type ? " active bg-success border-success" : " text-success" %>" href="Adminviewservice.jsp?type=<%= s.type %>"><%= h(s.title) %></a></li>
<% } %>
    </ul>
    <div class="ss-table table-responsive">
        <table class="table table-hover align-middle">
            <thead><tr><th>Pay no.</th><th>Date</th><th>Resident</th><th>Service</th><th class="text-end">Amount</th></tr></thead>
            <tbody>
<%
    int rows = 0;
    long sum = 0;
    // svc.table comes from the fixed Catalog list, never from the request, so it is safe to concatenate.
    try (Connection con = Db.get(); Statement st = con.createStatement();
         ResultSet rs = st.executeQuery("SELECT " + svc.idCol + " AS payno, `date`, " + svc.nameCol + " AS rnm, service, amount FROM " + svc.table + " ORDER BY 1 DESC")) {
        while (rs.next()) {
            rows++;
            sum += rs.getInt("amount");
%>
                <tr>
                    <td><%= rs.getInt("payno") %></td>
                    <td><%= h(rs.getString("date")) %></td>
                    <td><%= h(rs.getString("rnm")) %></td>
                    <td><%= h(rs.getString("service")) %></td>
                    <td class="text-end">&#8377;<%= rs.getInt("amount") %></td>
                </tr>
<%
        }
    }
    if (rows == 0) {
%>
                <tr><td colspan="5"><div class="empty-state"><i class="bi bi-journal-text"></i>No subscriptions for this service yet.</div></td></tr>
<% } else { %>
                <tr class="table-light"><td colspan="4" class="text-end fw-semibold">Total collected</td><td class="text-end fw-bold">&#8377;<%= sum %></td></tr>
<% } %>
            </tbody>
        </table>
    </div>
</div>
<%@ include file="/WEB-INF/jspf/footer.jspf" %>
