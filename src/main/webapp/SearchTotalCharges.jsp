<%@ include file="/WEB-INF/jspf/init.jspf" %>
<% String role = "resident"; String pageTitle = "Charges"; %>
<%@ include file="/WEB-INF/jspf/guard.jspf" %>
<%
    String fMonth = Web.param(request, "txtmon");
    String fYear = Web.param(request, "txtyear");
    if (!Arrays.asList(Catalog.MONTHS).contains(fMonth)) fMonth = "";
    if (!fYear.matches("20[0-9]{2}")) fYear = "";
%>
<%@ include file="/WEB-INF/jspf/header.jspf" %>
<div class="page-head"><div class="container"><h1>Monthly charges</h1><p>Find a month and pay your electricity and maintenance charges online.</p></div></div>
<div class="container py-5">
    <form method="get" action="SearchTotalCharges.jsp" class="ss-card mb-4">
        <div class="row g-3 align-items-end">
            <div class="col-md-4">
                <label class="form-label" for="txtmon">Month</label>
                <select class="form-select" id="txtmon" name="txtmon">
                    <option value="">All months</option>
<% for (String m : Catalog.MONTHS) { %><option<%= m.equals(fMonth) ? " selected" : "" %>><%= m %></option><% } %>
                </select>
            </div>
            <div class="col-md-3">
                <label class="form-label" for="txtyear">Year</label>
                <input type="number" class="form-control" id="txtyear" name="txtyear" min="2000" max="2099" value="<%= h(fYear) %>" placeholder="All years">
            </div>
            <div class="col-auto"><button class="btn btn-success"><i class="bi bi-search"></i> Search</button></div>
<% if (!fMonth.isEmpty() || !fYear.isEmpty()) { %><div class="col-auto"><a class="btn btn-outline-secondary" href="SearchTotalCharges.jsp">Clear</a></div><% } %>
        </div>
    </form>
    <div class="ss-table table-responsive">
        <table class="table table-hover align-middle">
            <thead><tr><th>#</th><th>Month</th><th>Year</th><th class="text-end">Electricity</th><th class="text-end">Maintenance</th><th class="text-end">Total</th><th class="text-end">Status</th></tr></thead>
            <tbody>
<%
    int rows = 0;
    StringBuilder sql = new StringBuilder("SELECT srno, month, year, elecharges, maincharges FROM commoncharges WHERE 1=1");
    if (!fMonth.isEmpty()) sql.append(" AND month = ?");
    if (!fYear.isEmpty()) sql.append(" AND year = ?");
    sql.append(" ORDER BY srno DESC");
    try (Connection con = Db.get()) {
        Db.Resident me = Db.findResident(con, residentUser);
        // payment ids of charges this resident already paid, keyed by charges srno
        Map<Integer, Integer> paidMap = new HashMap<>();
        if (me != null) {
            try (PreparedStatement pp = con.prepareStatement("SELECT srno, MAX(payid) FROM paycharges WHERE name = ? AND mobno = ? GROUP BY srno")) {
                pp.setString(1, me.name());
                pp.setString(2, me.mobile());
                try (ResultSet pr = pp.executeQuery()) { while (pr.next()) paidMap.put(pr.getInt(1), pr.getInt(2)); }
            }
        }
        try (PreparedStatement ps = con.prepareStatement(sql.toString())) {
            int i = 1;
            if (!fMonth.isEmpty()) ps.setString(i++, fMonth);
            if (!fYear.isEmpty()) ps.setString(i++, fYear);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    rows++;
                    int srno = rs.getInt("srno"), e1 = rs.getInt("elecharges"), m1 = rs.getInt("maincharges");
                    Integer payId = paidMap.get(srno);
%>
                <tr>
                    <td><%= srno %></td>
                    <td><%= h(rs.getString("month")) %></td>
                    <td><%= h(rs.getString("year")) %></td>
                    <td class="text-end">&#8377;<%= e1 %></td>
                    <td class="text-end">&#8377;<%= m1 %></td>
                    <td class="text-end fw-semibold">&#8377;<%= e1 + m1 %></td>
                    <td class="text-end">
<% if (payId != null) { %>
                        <span class="badge text-bg-success badge-status me-1">Paid</span>
                        <a class="btn btn-sm btn-outline-success" href="Receipt.jsp?kind=charge&amp;id=<%= payId %>"><i class="bi bi-receipt"></i> Receipt</a>
<% } else { %>
                        <a class="btn btn-sm btn-success" href="PayCharges.jsp?srno=<%= srno %>"><i class="bi bi-credit-card"></i> Pay</a>
<% } %>
                    </td>
                </tr>
<%
                }
            }
        }
    }
    if (rows == 0) {
%>
                <tr><td colspan="7"><div class="empty-state"><i class="bi bi-cash-coin"></i>No charges found.</div></td></tr>
<% } %>
            </tbody>
        </table>
    </div>
</div>
<%@ include file="/WEB-INF/jspf/footer.jspf" %>
