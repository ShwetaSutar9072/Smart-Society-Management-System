<%@ include file="/WEB-INF/jspf/init.jspf" %>
<% String role = "resident"; String pageTitle = "My payments"; %>
<%@ include file="/WEB-INF/jspf/guard.jspf" %>
<%@ include file="/WEB-INF/jspf/header.jspf" %>
<div class="page-head"><div class="container"><h1>My payments &amp; bookings</h1><p>Everything you have paid for, with printable receipts.</p></div></div>
<div class="container py-5">
<%
    try (Connection con = Db.get()) {
        Db.Resident me = Db.findResident(con, residentUser);
        if (me == null) { response.sendRedirect("logout.jsp"); return; }
%>
    <h2 class="h4 fw-bold mb-3">Monthly charges</h2>
    <div class="ss-table table-responsive mb-5">
        <table class="table table-hover align-middle">
            <thead><tr><th>Receipt</th><th>Date</th><th>Month</th><th class="text-end">Total</th><th></th></tr></thead>
            <tbody>
<%
        int rows = 0;
        try (PreparedStatement ps = con.prepareStatement("SELECT payid, `date`, month, year, total FROM paycharges WHERE name = ? AND mobno = ? ORDER BY payid DESC")) {
            ps.setString(1, me.name());
            ps.setString(2, me.mobile());
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    rows++;
%>
                <tr>
                    <td>#<%= rs.getInt("payid") %></td>
                    <td><%= h(rs.getString("date")) %></td>
                    <td><%= h(rs.getString("month")) %> <%= h(rs.getString("year")) %></td>
                    <td class="text-end">&#8377;<%= rs.getInt("total") %></td>
                    <td class="text-end"><a class="btn btn-sm btn-outline-success" href="Receipt.jsp?kind=charge&amp;id=<%= rs.getInt("payid") %>"><i class="bi bi-receipt"></i> Receipt</a></td>
                </tr>
<%
                }
            }
        }
        if (rows == 0) {
%>
                <tr><td colspan="5"><div class="empty-state"><i class="bi bi-cash-coin"></i>No charges paid yet. <a href="SearchTotalCharges.jsp">Pay now</a></div></td></tr>
<% } %>
            </tbody>
        </table>
    </div>

    <h2 class="h4 fw-bold mb-3">Service subscriptions</h2>
    <div class="ss-table table-responsive mb-5">
        <table class="table table-hover align-middle">
            <thead><tr><th>Receipt</th><th>Date</th><th>Service</th><th class="text-end">Amount</th><th></th></tr></thead>
            <tbody>
<%
        rows = 0;
        StringBuilder u = new StringBuilder();
        for (Catalog.Svc s : Catalog.SERVICES) {
            if (u.length() > 0) u.append(" UNION ALL ");
            u.append("SELECT ").append(s.type).append(" AS t, ").append(s.idCol).append(" AS payno, CAST(`date` AS CHAR) AS d, service, amount FROM ")
             .append(s.table).append(" WHERE ").append(s.nameCol).append(" = ?");
        }
        try (PreparedStatement ps = con.prepareStatement("SELECT * FROM (" + u + ") x ORDER BY d DESC, payno DESC")) {
            for (int i = 1; i <= Catalog.SERVICES.length; i++) ps.setString(i, me.name());
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    rows++;
%>
                <tr>
                    <td>#<%= rs.getInt("payno") %></td>
                    <td><%= h(rs.getString("d")) %></td>
                    <td><%= h(rs.getString("service")) %></td>
                    <td class="text-end">&#8377;<%= rs.getInt("amount") %></td>
                    <td class="text-end"><a class="btn btn-sm btn-outline-success" href="Receipt.jsp?kind=sub&amp;type=<%= rs.getInt("t") %>&amp;id=<%= rs.getInt("payno") %>"><i class="bi bi-receipt"></i> Receipt</a></td>
                </tr>
<%
                }
            }
        }
        if (rows == 0) {
%>
                <tr><td colspan="5"><div class="empty-state"><i class="bi bi-tools"></i>No subscriptions yet. <a href="SearchService.jsp">Browse services</a></div></td></tr>
<% } %>
            </tbody>
        </table>
    </div>

    <h2 class="h4 fw-bold mb-3" id="bookings">Event bookings</h2>
    <div class="ss-table table-responsive">
        <table class="table table-hover align-middle">
            <thead><tr><th>Receipt</th><th>Booked on</th><th>Event</th><th>Event date</th><th>Time</th><th class="text-end">Charges</th><th></th></tr></thead>
            <tbody>
<%
        rows = 0;
        try (PreparedStatement ps = con.prepareStatement("SELECT bid, bdate, ename, edate, etime, echarges FROM bookingevent WHERE rname = ? AND mob = ? ORDER BY bid DESC")) {
            ps.setString(1, me.name());
            ps.setString(2, me.mobile());
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    rows++;
%>
                <tr>
                    <td>#<%= rs.getInt("bid") %></td>
                    <td><%= h(rs.getString("bdate")) %></td>
                    <td><%= h(rs.getString("ename")) %></td>
                    <td><%= h(rs.getString("edate")) %></td>
                    <td><%= h(rs.getString("etime")) %></td>
                    <td class="text-end">&#8377;<%= rs.getInt("echarges") %></td>
                    <td class="text-end"><a class="btn btn-sm btn-outline-success" href="Receipt.jsp?kind=event&amp;id=<%= rs.getInt("bid") %>"><i class="bi bi-receipt"></i> Receipt</a></td>
                </tr>
<%
                }
            }
        }
        if (rows == 0) {
%>
                <tr><td colspan="7"><div class="empty-state"><i class="bi bi-calendar-event"></i>No bookings yet. <a href="SearchEvent.jsp">Book an event</a></div></td></tr>
<% } %>
            </tbody>
        </table>
    </div>
<%
    }
%>
</div>
<%@ include file="/WEB-INF/jspf/footer.jspf" %>
