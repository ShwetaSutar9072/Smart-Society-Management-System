<%@ include file="/WEB-INF/jspf/init.jspf" %>
<% String role = "resident"; String pageTitle = "Pay charges"; %>
<%@ include file="/WEB-INF/jspf/guard.jspf" %>
<%
    int chargeId = Web.toInt(request.getParameter("srno"), -1);
    String month = null, year = null;
    int ele = 0, maint = 0;
    Db.Resident me = null;
    try (Connection con = Db.get()) {
        me = Db.findResident(con, residentUser);
        boolean found = false;
        try (PreparedStatement ps = con.prepareStatement("SELECT month, year, elecharges, maincharges FROM commoncharges WHERE srno = ?")) {
            ps.setInt(1, chargeId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) { found = true; month = rs.getString(1); year = rs.getString(2); ele = rs.getInt(3); maint = rs.getInt(4); }
            }
        }
        if (me == null || !found) {
            Web.flash(session, "warning", "That charges entry was not found.");
            response.sendRedirect("SearchTotalCharges.jsp");
            return;
        }
        // already paid?
        try (PreparedStatement ps = con.prepareStatement("SELECT MAX(payid) FROM paycharges WHERE srno = ? AND name = ? AND mobno = ?")) {
            ps.setInt(1, chargeId);
            ps.setString(2, me.name());
            ps.setString(3, me.mobile());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next() && rs.getInt(1) > 0) {
                    Web.flash(session, "info", "You have already paid the charges for " + month + " " + year + ".");
                    response.sendRedirect("Receipt.jsp?kind=charge&id=" + rs.getInt(1));
                    return;
                }
            }
        }
        if (Web.isPost(request)) {
            // amounts always come from the database, never from the browser
            int payId = 0;
            for (int attempt = 0; ; attempt++) {
                try (PreparedStatement ps = con.prepareStatement(
                        "INSERT INTO paycharges (payid, `date`, name, mobno, srno, month, year, elecharges, maincharges, total) VALUES (?,?,?,?,?,?,?,?,?,?)")) {
                    payId = Db.nextId(con, "paycharges", "payid");
                    ps.setInt(1, payId);
                    ps.setString(2, java.time.LocalDate.now().toString());
                    ps.setString(3, me.name());
                    ps.setString(4, me.mobile());
                    ps.setInt(5, chargeId);
                    ps.setString(6, month);
                    ps.setString(7, year);
                    ps.setInt(8, ele);
                    ps.setInt(9, maint);
                    ps.setInt(10, ele + maint);
                    ps.executeUpdate();
                    break;
                } catch (SQLException e) {
                    if (!Db.isDuplicate(e) || attempt >= 2) throw e;
                }
            }
            Web.flash(session, "success", "Payment successful. Thank you!");
            response.sendRedirect("Receipt.jsp?kind=charge&id=" + payId);
            return;
        }
    }
%>
<%@ include file="/WEB-INF/jspf/header.jspf" %>
<div class="page-head"><div class="container"><h1>Pay charges</h1><p><%= h(month) %> <%= h(year) %></p></div></div>
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-7">
            <div class="ss-card">
                <div class="receipt">
                    <dl class="row mb-3">
                        <dt class="col-5">Resident</dt><dd class="col-7"><%= h(me.name()) %></dd>
                        <dt class="col-5">Mobile</dt><dd class="col-7"><%= h(me.mobile()) %></dd>
                        <dt class="col-5">Period</dt><dd class="col-7"><%= h(month) %> <%= h(year) %></dd>
                        <dt class="col-5">Electricity charges</dt><dd class="col-7">&#8377;<%= ele %></dd>
                        <dt class="col-5">Maintenance charges</dt><dd class="col-7">&#8377;<%= maint %></dd>
                        <dt class="col-5">Total</dt><dd class="col-7 total">&#8377;<%= ele + maint %></dd>
                    </dl>
                    <div class="text-center mb-4">
                        <p class="text-muted mb-2">Scan the QR code to pay, then confirm below.</p>
                        <img src="img/qr.jpg" alt="Payment QR code" width="180" height="180" style="object-fit:contain">
                    </div>
                    <form method="post" action="PayCharges.jsp?srno=<%= chargeId %>">
                        <div class="d-flex gap-2">
                            <a class="btn btn-outline-secondary" href="SearchTotalCharges.jsp">Back</a>
                            <button type="submit" class="btn btn-success flex-grow-1"><i class="bi bi-check-circle"></i> I have paid &#8377;<%= ele + maint %></button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/jspf/footer.jspf" %>
