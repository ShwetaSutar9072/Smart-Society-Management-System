<%@ include file="/WEB-INF/jspf/init.jspf" %>
<% String role = "admin"; String pageTitle = "Services & prices"; %>
<%@ include file="/WEB-INF/jspf/guard.jspf" %>
<%
    String error = null;
    String snm = "", amt = "";
    if (Web.isPost(request)) {
        String action = Web.param(request, "action");
        int srnoParam = Web.toInt(request.getParameter("srno"), -1);
        if ("update".equals(action)) {
            int newAmt = Web.toInt(request.getParameter("amount"), -1);
            if (newAmt < 0) {
                Web.flash(session, "danger", "Amount must be a whole number, zero or more.");
            } else {
                try (Connection con = Db.get();
                     PreparedStatement ps = con.prepareStatement("UPDATE addservices SET amount = ? WHERE srno = ?")) {
                    ps.setInt(1, newAmt);
                    ps.setInt(2, srnoParam);
                    ps.executeUpdate();
                }
                Web.flash(session, "success", "Amount updated.");
            }
            response.sendRedirect("Addservices.jsp");
            return;
        } else if ("delete".equals(action)) {
            try (Connection con = Db.get();
                 PreparedStatement ps = con.prepareStatement("DELETE FROM addservices WHERE srno = ?")) {
                ps.setInt(1, srnoParam);
                ps.executeUpdate();
            }
            Web.flash(session, "success", "Service deleted.");
            response.sendRedirect("Addservices.jsp");
            return;
        }
        snm = Web.param(request, "txtsnm");
        amt = Web.param(request, "txtcharges");
        int amtN = Web.toInt(amt, -1);
        if (snm.isEmpty()) {
            error = "Please enter the service name.";
        } else if (amtN < 0) {
            error = "Amount must be a whole number, zero or more.";
        } else {
            try (Connection con = Db.get()) {
                boolean exists;
                try (PreparedStatement chk = con.prepareStatement("SELECT 1 FROM addservices WHERE service = ?")) {
                    chk.setString(1, snm);
                    try (ResultSet rs = chk.executeQuery()) { exists = rs.next(); }
                }
                if (exists) {
                    error = "That service already exists. Edit its amount in the table instead.";
                } else {
                    for (int attempt = 0; ; attempt++) {
                        try (PreparedStatement ps = con.prepareStatement(
                                "INSERT INTO addservices (srno, service, amount) VALUES (?,?,?)")) {
                            ps.setInt(1, Db.nextId(con, "addservices", "srno"));
                            ps.setString(2, snm);
                            ps.setInt(3, amtN);
                            ps.executeUpdate();
                            break;
                        } catch (SQLException e) {
                            if (!Db.isDuplicate(e) || attempt >= 2) throw e;
                        }
                    }
                    Web.flash(session, "success", "Service added.");
                    response.sendRedirect("Addservices.jsp");
                    return;
                }
            }
        }
    }
    Set<String> core = new HashSet<>();
    for (Catalog.Svc s : Catalog.SERVICES) core.add(s.name.toLowerCase());
%>
<%@ include file="/WEB-INF/jspf/header.jspf" %>
<div class="page-head"><div class="container"><h1>Services &amp; prices</h1><p>The amount here is what residents pay when they subscribe.</p></div></div>
<div class="container py-5">
    <div class="row g-4">
        <div class="col-lg-4">
            <div class="ss-card">
                <h2 class="h5 card-title">Add a service</h2>
<% if (error != null) { %><div class="alert alert-danger" role="alert"><%= h(error) %></div><% } %>
                <form method="post" action="Addservices.jsp">
                    <div class="mb-3">
                        <label class="form-label" for="txtsnm">Service name</label>
                        <input type="text" class="form-control" id="txtsnm" name="txtsnm" value="<%= h(snm) %>" maxlength="100" required>
                    </div>
                    <div class="mb-4">
                        <label class="form-label" for="txtcharges">Amount (&#8377;)</label>
                        <input type="number" class="form-control" id="txtcharges" name="txtcharges" min="0" value="<%= h(amt) %>" required>
                    </div>
                    <button type="submit" class="btn btn-success w-100"><i class="bi bi-plus-circle"></i> Add service</button>
                </form>
            </div>
        </div>
        <div class="col-lg-8">
            <div class="ss-table table-responsive">
                <table class="table align-middle">
                    <thead><tr><th>#</th><th>Service</th><th style="width:220px">Amount (&#8377;)</th><th></th></tr></thead>
                    <tbody>
<%
    int rows = 0;
    try (Connection con = Db.get(); Statement st = con.createStatement();
         ResultSet rs = st.executeQuery("SELECT srno, service, amount FROM addservices ORDER BY srno")) {
        while (rs.next()) {
            rows++;
            int srno = rs.getInt("srno");
            String name = rs.getString("service");
%>
                        <tr>
                            <td><%= srno %></td>
                            <td><%= h(name) %></td>
                            <td>
                                <form method="post" action="Addservices.jsp" class="d-flex gap-2">
                                    <input type="hidden" name="action" value="update"><input type="hidden" name="srno" value="<%= srno %>">
                                    <input type="number" class="form-control form-control-sm" name="amount" min="0" value="<%= rs.getInt("amount") %>" aria-label="Amount for <%= h(name) %>" required>
                                    <button class="btn btn-sm btn-outline-success" title="Save amount"><i class="bi bi-check-lg"></i></button>
                                </form>
                            </td>
                            <td class="text-end">
<% if (!core.contains(name.toLowerCase())) { %>
                                <form method="post" action="Addservices.jsp" onsubmit="return confirm('Delete this service?');">
                                    <input type="hidden" name="action" value="delete"><input type="hidden" name="srno" value="<%= srno %>">
                                    <button class="btn btn-sm btn-outline-danger" title="Delete"><i class="bi bi-trash"></i></button>
                                </form>
<% } else { %><span class="badge text-bg-light">core service</span><% } %>
                            </td>
                        </tr>
<%
        }
    }
    if (rows == 0) {
%>
                        <tr><td colspan="4"><div class="empty-state"><i class="bi bi-tools"></i>No services yet.</div></td></tr>
<% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/jspf/footer.jspf" %>
