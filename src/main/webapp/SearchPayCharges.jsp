<%@ include file="/WEB-INF/jspf/init.jspf" %>
<% String role = "admin"; String pageTitle = "Paid charges"; %>
<%@ include file="/WEB-INF/jspf/guard.jspf" %>
<%
    String d = Web.param(request, "txtdate");
    if (!d.isEmpty() && !d.matches("\\d{4}-\\d{2}-\\d{2}")) d = "";
%>
<%@ include file="/WEB-INF/jspf/header.jspf" %>
<div class="page-head"><div class="container"><h1>Paid charges</h1><p>Search payments by date, or leave blank to see the latest.</p></div></div>
<div class="container py-5">
    <form method="get" action="SearchPayCharges.jsp" class="ss-card mb-4">
        <div class="row g-3 align-items-end">
            <div class="col-md-6 col-lg-4">
                <label class="form-label" for="txtdate">Payment date</label>
                <input type="date" class="form-control" id="txtdate" name="txtdate" value="<%= h(d) %>">
            </div>
            <div class="col-auto"><button class="btn btn-success"><i class="bi bi-search"></i> Search</button></div>
<% if (!d.isEmpty()) { %><div class="col-auto"><a class="btn btn-outline-secondary" href="SearchPayCharges.jsp">Clear</a></div><% } %>
        </div>
    </form>
    <div class="ss-table table-responsive">
        <table class="table table-hover align-middle">
            <thead><tr><th>Pay id</th><th>Date</th><th>Resident</th><th>Mobile</th><th>Month</th><th>Year</th><th class="text-end">Electricity</th><th class="text-end">Maintenance</th><th class="text-end">Total</th></tr></thead>
            <tbody>
<%
    int rows = 0;
    long sum = 0;
    String sql = "SELECT payid, `date`, name, mobno, month, year, elecharges, maincharges, total FROM paycharges"
               + (d.isEmpty() ? "" : " WHERE `date` = ?") + " ORDER BY payid DESC LIMIT 200";
    try (Connection con = Db.get(); PreparedStatement ps = con.prepareStatement(sql)) {
        if (!d.isEmpty()) ps.setString(1, d);
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                rows++;
                sum += rs.getInt("total");
%>
                <tr>
                    <td><%= rs.getInt("payid") %></td>
                    <td><%= h(rs.getString("date")) %></td>
                    <td><%= h(rs.getString("name")) %></td>
                    <td><%= h(rs.getString("mobno")) %></td>
                    <td><%= h(rs.getString("month")) %></td>
                    <td><%= h(rs.getString("year")) %></td>
                    <td class="text-end">&#8377;<%= rs.getInt("elecharges") %></td>
                    <td class="text-end">&#8377;<%= rs.getInt("maincharges") %></td>
                    <td class="text-end fw-semibold">&#8377;<%= rs.getInt("total") %></td>
                </tr>
<%
            }
        }
    }
    if (rows == 0) {
%>
                <tr><td colspan="9"><div class="empty-state"><i class="bi bi-receipt"></i>No payments found.</div></td></tr>
<% } else { %>
                <tr class="table-light"><td colspan="8" class="text-end fw-semibold">Total of the <%= rows %> payment<%= rows == 1 ? "" : "s" %> shown</td><td class="text-end fw-bold">&#8377;<%= sum %></td></tr>
<% } %>
            </tbody>
        </table>
    </div>
</div>
<%@ include file="/WEB-INF/jspf/footer.jspf" %>
