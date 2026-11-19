<%@ include file="/WEB-INF/jspf/init.jspf" %>
<% String role = "admin"; String pageTitle = "Service providers"; %>
<%@ include file="/WEB-INF/jspf/guard.jspf" %>
<%
    String error = null;
    String snm = "", pnm = "", add = "", mob = "";
    if (Web.isPost(request)) {
        if ("delete".equals(Web.param(request, "action"))) {
            try (Connection con = Db.get();
                 PreparedStatement ps = con.prepareStatement("DELETE FROM otherservices WHERE sno = ?")) {
                ps.setInt(1, Web.toInt(request.getParameter("sno"), -1));
                ps.executeUpdate();
            }
            Web.flash(session, "success", "Provider removed.");
            response.sendRedirect("OtherServices.jsp");
            return;
        }
        snm = Web.param(request, "drpservice");
        pnm = Web.param(request, "txtpnm");
        add = Web.param(request, "txtadd");
        mob = Web.param(request, "txtmobno");
        boolean knownService = false;
        for (Catalog.Svc s : Catalog.SERVICES) if (s.name.equals(snm)) knownService = true;
        if (!knownService) {
            error = "Please choose a service.";
        } else if (pnm.isEmpty() || add.isEmpty()) {
            error = "Please fill in the provider name and address.";
        } else if (!Web.validMobile(mob)) {
            error = "Mobile number must be exactly 10 digits.";
        } else {
            try (Connection con = Db.get();
                 PreparedStatement ps = con.prepareStatement(
                         "INSERT INTO otherservices (servicename, pro_name, address, mob_no) VALUES (?,?,?,?)")) {
                ps.setString(1, snm);
                ps.setString(2, pnm);
                ps.setString(3, add);
                ps.setString(4, mob);
                ps.executeUpdate();
            }
            Web.flash(session, "success", "Service provider added.");
            response.sendRedirect("OtherServices.jsp");
            return;
        }
    }
%>
<%@ include file="/WEB-INF/jspf/header.jspf" %>
<div class="page-head"><div class="container"><h1>Service providers</h1><p>These contact details appear on each service page for residents.</p></div></div>
<div class="container py-5">
    <div class="row g-4">
        <div class="col-lg-4">
            <div class="ss-card">
                <h2 class="h5 card-title">Add a provider</h2>
<% if (error != null) { %><div class="alert alert-danger" role="alert"><%= h(error) %></div><% } %>
                <form method="post" action="OtherServices.jsp">
                    <div class="mb-3">
                        <label class="form-label" for="drpservice">Service</label>
                        <select class="form-select" id="drpservice" name="drpservice" required>
                            <option value="">Select service</option>
<% for (Catalog.Svc s : Catalog.SERVICES) { %><option value="<%= h(s.name) %>"<%= s.name.equals(snm) ? " selected" : "" %>><%= h(s.title) %></option><% } %>
                        </select>
                    </div>
                    <div class="mb-3"><label class="form-label" for="txtpnm">Provider name</label><input type="text" class="form-control" id="txtpnm" name="txtpnm" value="<%= h(pnm) %>" maxlength="100" required></div>
                    <div class="mb-3"><label class="form-label" for="txtadd">Address</label><input type="text" class="form-control" id="txtadd" name="txtadd" value="<%= h(add) %>" maxlength="255" required></div>
                    <div class="mb-4"><label class="form-label" for="txtmobno">Mobile no.</label><input type="tel" class="form-control" id="txtmobno" name="txtmobno" value="<%= h(mob) %>" pattern="[0-9]{10}" maxlength="10" required></div>
                    <button type="submit" class="btn btn-success w-100"><i class="bi bi-plus-circle"></i> Add provider</button>
                </form>
            </div>
        </div>
        <div class="col-lg-8">
            <div class="ss-table table-responsive">
                <table class="table table-hover align-middle">
                    <thead><tr><th>#</th><th>Service</th><th>Provider</th><th>Address</th><th>Mobile</th><th></th></tr></thead>
                    <tbody>
<%
    int rows = 0;
    try (Connection con = Db.get(); Statement st = con.createStatement();
         ResultSet rs = st.executeQuery("SELECT sno, servicename, pro_name, address, mob_no FROM otherservices ORDER BY servicename, sno")) {
        while (rs.next()) {
            rows++;
%>
                        <tr>
                            <td><%= rs.getInt("sno") %></td>
                            <td><%= h(rs.getString("servicename")) %></td>
                            <td><%= h(rs.getString("pro_name")) %></td>
                            <td><%= h(rs.getString("address")) %></td>
                            <td><%= h(rs.getString("mob_no")) %></td>
                            <td class="text-end">
                                <form method="post" action="OtherServices.jsp" onsubmit="return confirm('Remove this provider?');">
                                    <input type="hidden" name="action" value="delete"><input type="hidden" name="sno" value="<%= rs.getInt("sno") %>">
                                    <button class="btn btn-sm btn-outline-danger" title="Remove"><i class="bi bi-trash"></i></button>
                                </form>
                            </td>
                        </tr>
<%
        }
    }
    if (rows == 0) {
%>
                        <tr><td colspan="6"><div class="empty-state"><i class="bi bi-person-vcard"></i>No providers added yet.</div></td></tr>
<% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/jspf/footer.jspf" %>
