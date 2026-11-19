<%@ include file="/WEB-INF/jspf/init.jspf" %>
<% String role = "admin"; String pageTitle = "Residents"; %>
<%@ include file="/WEB-INF/jspf/guard.jspf" %>
<%
    // State changes are POST-only (they used to be plain links, so a crawler or prefetch could approve people).
    if (Web.isPost(request)) {
        int srno = Web.toInt(request.getParameter("srno"), -1);
        String action = Web.param(request, "action");
        String status = "approve".equals(action) ? "Approved" : ("reject".equals(action) ? "Rejected" : null);
        if (srno > 0 && status != null) {
            try (Connection con = Db.get();
                 PreparedStatement ps = con.prepareStatement("UPDATE registration SET status = ? WHERE srno = ?")) {
                ps.setString(1, status);
                ps.setInt(2, srno);
                ps.executeUpdate();
            }
            Web.flash(session, "success", "Resident #" + srno + " marked " + status + ".");
        }
        response.sendRedirect("viewregistration.jsp");
        return;
    }
%>
<%@ include file="/WEB-INF/jspf/header.jspf" %>
<div class="page-head"><div class="container"><h1>Resident registrations</h1><p>Approve residents so they can log in.</p></div></div>
<div class="container py-5">
    <div class="ss-table table-responsive">
        <table class="table table-hover align-middle">
            <thead><tr><th>#</th><th>Name</th><th>Address</th><th>Mobile</th><th>Email</th><th>Username</th><th>Status</th><th class="text-end">Action</th></tr></thead>
            <tbody>
<%
    int rows = 0;
    try (Connection con = Db.get(); Statement st = con.createStatement();
         ResultSet rs = st.executeQuery("SELECT srno, resi_name, address, mob_no, email_id, username, status FROM registration ORDER BY (status='Pending') DESC, srno DESC")) {
        while (rs.next()) {
            rows++;
            int srno = rs.getInt("srno");
            String status = rs.getString("status");
            String badge = "Approved".equals(status) ? "success" : ("Pending".equals(status) ? "warning text-dark" : "danger");
%>
                <tr>
                    <td><%= srno %></td>
                    <td><%= h(rs.getString("resi_name")) %></td>
                    <td><%= h(rs.getString("address")) %></td>
                    <td><%= h(rs.getString("mob_no")) %></td>
                    <td><%= h(rs.getString("email_id")) %></td>
                    <td><%= h(rs.getString("username")) %></td>
                    <td><span class="badge text-bg-<%= badge %> badge-status"><%= h(status) %></span></td>
                    <td class="text-end text-nowrap">
<% if (!"Approved".equals(status)) { %>
                        <form method="post" action="viewregistration.jsp" class="d-inline"><input type="hidden" name="srno" value="<%= srno %>"><input type="hidden" name="action" value="approve"><button class="btn btn-sm btn-success"><i class="bi bi-check-lg"></i> Approve</button></form>
<% } %>
<% if (!"Rejected".equals(status)) { %>
                        <form method="post" action="viewregistration.jsp" class="d-inline" onsubmit="return confirm('Reject / block this resident?');"><input type="hidden" name="srno" value="<%= srno %>"><input type="hidden" name="action" value="reject"><button class="btn btn-sm btn-outline-danger"><i class="bi bi-x-lg"></i> <%= "Approved".equals(status) ? "Block" : "Reject" %></button></form>
<% } %>
                    </td>
                </tr>
<%
        }
    }
    if (rows == 0) {
%>
                <tr><td colspan="8"><div class="empty-state"><i class="bi bi-people"></i>No registrations yet.</div></td></tr>
<% } %>
            </tbody>
        </table>
    </div>
</div>
<%@ include file="/WEB-INF/jspf/footer.jspf" %>
