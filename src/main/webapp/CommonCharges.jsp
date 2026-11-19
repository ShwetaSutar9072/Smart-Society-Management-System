<%@ include file="/WEB-INF/jspf/init.jspf" %>
<% String role = "admin"; String pageTitle = "Add charges"; %>
<%@ include file="/WEB-INF/jspf/guard.jspf" %>
<%
    String error = null;
    String month = "", year = String.valueOf(java.time.Year.now().getValue()), ele = "", maint = "";
    if (Web.isPost(request)) {
        String action = Web.param(request, "action");
        if ("delete".equals(action)) {
            try (Connection con = Db.get();
                 PreparedStatement ps = con.prepareStatement("DELETE FROM commoncharges WHERE srno = ?")) {
                ps.setInt(1, Web.toInt(request.getParameter("srno"), -1));
                ps.executeUpdate();
            }
            Web.flash(session, "success", "Charges entry deleted.");
            response.sendRedirect("CommonCharges.jsp");
            return;
        }
        month = Web.param(request, "txtmon");
        year = Web.param(request, "txtyear");
        ele = Web.param(request, "txtelecharges");
        maint = Web.param(request, "txtmaincharges");
        int eleN = Web.toInt(ele, -1), maintN = Web.toInt(maint, -1);
        if (!Arrays.asList(Catalog.MONTHS).contains(month)) {
            error = "Please choose a month.";
        } else if (!year.matches("20[0-9]{2}")) {
            error = "Please enter a valid year (for example 2026).";
        } else if (eleN < 0 || maintN < 0) {
            error = "Charges must be whole numbers, zero or more.";
        } else {
            try (Connection con = Db.get()) {
                boolean exists;
                try (PreparedStatement chk = con.prepareStatement("SELECT 1 FROM commoncharges WHERE month = ? AND year = ?")) {
                    chk.setString(1, month);
                    chk.setString(2, year);
                    try (ResultSet rs = chk.executeQuery()) { exists = rs.next(); }
                }
                if (exists) {
                    error = "Charges for " + month + " " + year + " are already added. Delete that entry first to change it.";
                } else {
                    for (int attempt = 0; ; attempt++) {
                        try (PreparedStatement ps = con.prepareStatement(
                                "INSERT INTO commoncharges (srno, month, year, elecharges, maincharges) VALUES (?,?,?,?,?)")) {
                            ps.setInt(1, Db.nextId(con, "commoncharges", "srno"));
                            ps.setString(2, month);
                            ps.setString(3, year);
                            ps.setInt(4, eleN);
                            ps.setInt(5, maintN);
                            ps.executeUpdate();
                            break;
                        } catch (SQLException e) {
                            if (!Db.isDuplicate(e) || attempt >= 2) throw e;
                        }
                    }
                    Web.flash(session, "success", "Charges for " + month + " " + year + " added.");
                    response.sendRedirect("CommonCharges.jsp");
                    return;
                }
            }
        }
    }
%>
<%@ include file="/WEB-INF/jspf/header.jspf" %>
<div class="page-head"><div class="container"><h1>Monthly charges</h1><p>Set the electricity and maintenance charges residents pay each month.</p></div></div>
<div class="container py-5">
    <div class="row g-4">
        <div class="col-lg-4">
            <div class="ss-card">
                <h2 class="h5 card-title">Add charges</h2>
<% if (error != null) { %><div class="alert alert-danger" role="alert"><%= h(error) %></div><% } %>
                <form method="post" action="CommonCharges.jsp">
                    <div class="mb-3">
                        <label class="form-label" for="txtmon">Month</label>
                        <select class="form-select" id="txtmon" name="txtmon" required>
                            <option value="">Select month</option>
<% for (String m : Catalog.MONTHS) { %><option<%= m.equals(month) ? " selected" : "" %>><%= m %></option><% } %>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="txtyear">Year</label>
                        <input type="number" class="form-control" id="txtyear" name="txtyear" min="2000" max="2099" value="<%= h(year) %>" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="txtelecharges">Electricity charges (&#8377;)</label>
                        <input type="number" class="form-control" id="txtelecharges" name="txtelecharges" min="0" value="<%= h(ele) %>" required>
                    </div>
                    <div class="mb-4">
                        <label class="form-label" for="txtmaincharges">Maintenance charges (&#8377;)</label>
                        <input type="number" class="form-control" id="txtmaincharges" name="txtmaincharges" min="0" value="<%= h(maint) %>" required>
                    </div>
                    <button type="submit" class="btn btn-success w-100"><i class="bi bi-plus-circle"></i> Add charges</button>
                </form>
            </div>
        </div>
        <div class="col-lg-8">
            <div class="ss-table table-responsive">
                <table class="table table-hover align-middle">
                    <thead><tr><th>#</th><th>Month</th><th>Year</th><th class="text-end">Electricity</th><th class="text-end">Maintenance</th><th class="text-end">Total</th><th></th></tr></thead>
                    <tbody>
<%
    int rows = 0;
    try (Connection con = Db.get(); Statement st = con.createStatement();
         ResultSet rs = st.executeQuery("SELECT srno, month, year, elecharges, maincharges FROM commoncharges ORDER BY srno DESC")) {
        while (rs.next()) {
            rows++;
            int e1 = rs.getInt("elecharges"), m1 = rs.getInt("maincharges");
%>
                        <tr>
                            <td><%= rs.getInt("srno") %></td>
                            <td><%= h(rs.getString("month")) %></td>
                            <td><%= h(rs.getString("year")) %></td>
                            <td class="text-end">&#8377;<%= e1 %></td>
                            <td class="text-end">&#8377;<%= m1 %></td>
                            <td class="text-end fw-semibold">&#8377;<%= e1 + m1 %></td>
                            <td class="text-end">
                                <form method="post" action="CommonCharges.jsp" onsubmit="return confirm('Delete this charges entry?');">
                                    <input type="hidden" name="action" value="delete"><input type="hidden" name="srno" value="<%= rs.getInt("srno") %>">
                                    <button class="btn btn-sm btn-outline-danger" title="Delete"><i class="bi bi-trash"></i></button>
                                </form>
                            </td>
                        </tr>
<%
        }
    }
    if (rows == 0) {
%>
                        <tr><td colspan="7"><div class="empty-state"><i class="bi bi-cash-coin"></i>No charges added yet.</div></td></tr>
<% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/jspf/footer.jspf" %>
