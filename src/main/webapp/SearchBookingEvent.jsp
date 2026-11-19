<%@ include file="/WEB-INF/jspf/init.jspf" %>
<% String role = "admin"; String pageTitle = "Event bookings"; %>
<%@ include file="/WEB-INF/jspf/guard.jspf" %>
<%
    if (Web.isPost(request) && "cancel".equals(Web.param(request, "action"))) {
        try (Connection con = Db.get();
             PreparedStatement ps = con.prepareStatement("DELETE FROM bookingevent WHERE bid = ?")) {
            ps.setInt(1, Web.toInt(request.getParameter("bid"), -1));
            ps.executeUpdate();
        }
        Web.flash(session, "success", "Booking cancelled.");
        response.sendRedirect("SearchBookingEvent.jsp");
        return;
    }
    String bdate = Web.param(request, "txtbdate");
    if (!bdate.isEmpty() && !bdate.matches("\\d{4}-\\d{2}-\\d{2}")) bdate = "";
%>
<%@ include file="/WEB-INF/jspf/header.jspf" %>
<div class="page-head"><div class="container"><h1>Event bookings</h1><p>Search by the date the booking was made, or leave blank to see the latest bookings.</p></div></div>
<div class="container py-5">
    <form method="get" action="SearchBookingEvent.jsp" class="ss-card mb-4">
        <div class="row g-3 align-items-end">
            <div class="col-md-6 col-lg-4">
                <label class="form-label" for="txtbdate">Booking date</label>
                <input type="date" class="form-control" id="txtbdate" name="txtbdate" value="<%= h(bdate) %>">
            </div>
            <div class="col-auto"><button class="btn btn-success"><i class="bi bi-search"></i> Search</button></div>
<% if (!bdate.isEmpty()) { %><div class="col-auto"><a class="btn btn-outline-secondary" href="SearchBookingEvent.jsp">Clear</a></div><% } %>
        </div>
    </form>
    <div class="ss-table table-responsive">
        <table class="table table-hover align-middle">
            <thead><tr><th>#</th><th>Booked on</th><th>Resident</th><th>Mobile</th><th>Event</th><th class="text-end">Charges</th><th>Event date</th><th>Time</th><th></th></tr></thead>
            <tbody>
<%
    int rows = 0;
    String sql = "SELECT bid, bdate, rname, mob, ename, echarges, edate, etime FROM bookingevent"
               + (bdate.isEmpty() ? "" : " WHERE bdate = ?") + " ORDER BY edate DESC, bid DESC LIMIT 200";
    try (Connection con = Db.get(); PreparedStatement ps = con.prepareStatement(sql)) {
        if (!bdate.isEmpty()) ps.setString(1, bdate);
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                rows++;
%>
                <tr>
                    <td><%= rs.getInt("bid") %></td>
                    <td><%= h(rs.getString("bdate")) %></td>
                    <td><%= h(rs.getString("rname")) %></td>
                    <td><%= h(rs.getString("mob")) %></td>
                    <td><%= h(rs.getString("ename")) %></td>
                    <td class="text-end">&#8377;<%= rs.getInt("echarges") %></td>
                    <td><%= h(rs.getString("edate")) %></td>
                    <td><%= h(rs.getString("etime")) %></td>
                    <td class="text-end">
                        <form method="post" action="SearchBookingEvent.jsp" onsubmit="return confirm('Cancel this booking?');">
                            <input type="hidden" name="action" value="cancel"><input type="hidden" name="bid" value="<%= rs.getInt("bid") %>">
                            <button class="btn btn-sm btn-outline-danger" title="Cancel booking"><i class="bi bi-x-circle"></i></button>
                        </form>
                    </td>
                </tr>
<%
            }
        }
    }
    if (rows == 0) {
%>
                <tr><td colspan="9"><div class="empty-state"><i class="bi bi-journal-check"></i>No bookings found.</div></td></tr>
<% } %>
            </tbody>
        </table>
    </div>
</div>
<%@ include file="/WEB-INF/jspf/footer.jspf" %>
