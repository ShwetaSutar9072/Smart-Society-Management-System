<%@ include file="/WEB-INF/jspf/init.jspf" %>
<% String role = "resident"; String pageTitle = "Subscribe"; %>
<%@ include file="/WEB-INF/jspf/guard.jspf" %>
<%
    Catalog.Svc svc = Catalog.service(Web.toInt(request.getParameter("type"), -1));
    if (svc == null) { response.sendRedirect("SearchService.jsp"); return; }
    Db.Resident me = null;
    int amount = -1;
    try (Connection con = Db.get()) {
        me = Db.findResident(con, residentUser);
        try (PreparedStatement ps = con.prepareStatement("SELECT amount FROM addservices WHERE service = ?")) {
            ps.setString(1, svc.name);
            try (ResultSet rs = ps.executeQuery()) { if (rs.next()) amount = rs.getInt(1); }
        }
        if (me == null || amount < 0) {
            Web.flash(session, "warning", "This service is not available for subscription right now.");
            response.sendRedirect("ServiceDetail.jsp?type=" + svc.type);
            return;
        }
        if (Web.isPost(request)) {
            int payNo = 0;
            for (int attempt = 0; ; attempt++) {
                // svc.table comes from the fixed Catalog list, never from the request
                try (PreparedStatement ps = con.prepareStatement(
                        "INSERT INTO " + svc.table + " (" + svc.idCol + ", `date`, " + svc.nameCol + ", service, amount) VALUES (?,?,?,?,?)")) {
                    payNo = Db.nextId(con, svc.table, svc.idCol);
                    ps.setInt(1, payNo);
                    ps.setString(2, java.time.LocalDate.now().toString());
                    ps.setString(3, me.name());
                    ps.setString(4, svc.name);
                    ps.setInt(5, amount);
                    ps.executeUpdate();
                    break;
                } catch (SQLException e) {
                    if (!Db.isDuplicate(e) || attempt >= 2) throw e;
                }
            }
            Web.flash(session, "success", "You are now subscribed to " + svc.title + ".");
            response.sendRedirect("Receipt.jsp?kind=sub&type=" + svc.type + "&id=" + payNo);
            return;
        }
    }
%>
<%@ include file="/WEB-INF/jspf/header.jspf" %>
<div class="page-head"><div class="container"><h1>Subscribe to <%= h(svc.title) %></h1></div></div>
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-7">
            <div class="ss-card">
                <div class="receipt">
                    <dl class="row mb-3">
                        <dt class="col-5">Resident</dt><dd class="col-7"><%= h(me.name()) %></dd>
                        <dt class="col-5">Service</dt><dd class="col-7"><%= h(svc.name) %></dd>
                        <dt class="col-5">Date</dt><dd class="col-7"><%= java.time.LocalDate.now() %></dd>
                        <dt class="col-5">Amount</dt><dd class="col-7 total">&#8377;<%= amount %></dd>
                    </dl>
                    <div class="text-center mb-4">
                        <p class="text-muted mb-2">Scan the QR code to pay, then confirm below.</p>
                        <img src="img/qr.jpg" alt="Payment QR code" width="180" height="180" style="object-fit:contain">
                    </div>
                    <form method="post" action="Subscribe.jsp?type=<%= svc.type %>">
                        <div class="d-flex gap-2">
                            <a class="btn btn-outline-secondary" href="ServiceDetail.jsp?type=<%= svc.type %>">Back</a>
                            <button type="submit" class="btn btn-success flex-grow-1"><i class="bi bi-check-circle"></i> I have paid &#8377;<%= amount %></button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/jspf/footer.jspf" %>
