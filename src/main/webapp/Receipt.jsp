<%@ include file="/WEB-INF/jspf/init.jspf" %>
<% String role = "resident"; String pageTitle = "Receipt"; %>
<%@ include file="/WEB-INF/jspf/guard.jspf" %>
<%
    // A resident can only open their own receipts.
    String kind = Web.param(request, "kind");
    int id = Web.toInt(request.getParameter("id"), -1);
    String title = null, dateStr = null, who = null, mobile = null;
    List<String[]> lines = new ArrayList<>();
    int total = 0;
    try (Connection con = Db.get()) {
        Db.Resident me = Db.findResident(con, residentUser);
        if (me != null) {
            if ("charge".equals(kind)) {
                try (PreparedStatement ps = con.prepareStatement(
                        "SELECT `date`, name, mobno, month, year, elecharges, maincharges, total FROM paycharges WHERE payid = ? AND name = ? AND mobno = ?")) {
                    ps.setInt(1, id); ps.setString(2, me.name()); ps.setString(3, me.mobile());
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            title = "Monthly charges";
                            dateStr = rs.getString(1); who = rs.getString(2); mobile = rs.getString(3);
                            lines.add(new String[]{"Period", rs.getString(4) + " " + rs.getString(5)});
                            lines.add(new String[]{"Electricity charges", "\u20B9" + rs.getInt(6)});
                            lines.add(new String[]{"Maintenance charges", "\u20B9" + rs.getInt(7)});
                            total = rs.getInt(8);
                        }
                    }
                }
            } else if ("sub".equals(kind)) {
                Catalog.Svc svc = Catalog.service(Web.toInt(request.getParameter("type"), -1));
                if (svc != null) {
                    // svc.table comes from the fixed Catalog list, never from the request
                    try (PreparedStatement ps = con.prepareStatement(
                            "SELECT `date`, " + svc.nameCol + ", service, amount FROM " + svc.table + " WHERE " + svc.idCol + " = ? AND " + svc.nameCol + " = ?")) {
                        ps.setInt(1, id); ps.setString(2, me.name());
                        try (ResultSet rs = ps.executeQuery()) {
                            if (rs.next()) {
                                title = "Service subscription";
                                dateStr = rs.getString(1); who = rs.getString(2); mobile = me.mobile();
                                lines.add(new String[]{"Service", rs.getString(3)});
                                total = rs.getInt(4);
                            }
                        }
                    }
                }
            } else if ("event".equals(kind)) {
                try (PreparedStatement ps = con.prepareStatement(
                        "SELECT bdate, rname, mob, ename, echarges, edate, etime FROM bookingevent WHERE bid = ? AND rname = ? AND mob = ?")) {
                    ps.setInt(1, id); ps.setString(2, me.name()); ps.setString(3, me.mobile());
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            title = "Event booking";
                            dateStr = rs.getString(1); who = rs.getString(2); mobile = rs.getString(3);
                            lines.add(new String[]{"Event", rs.getString(4)});
                            lines.add(new String[]{"Event date", rs.getString(6)});
                            lines.add(new String[]{"Time", rs.getString(7)});
                            total = rs.getInt(5);
                        }
                    }
                }
            }
        }
    }
    if (title == null) {
        Web.flash(session, "warning", "That receipt was not found.");
        response.sendRedirect("MyPayments.jsp");
        return;
    }
%>
<%@ include file="/WEB-INF/jspf/header.jspf" %>
<div class="container py-5">
    <div class="ss-card receipt">
        <div class="text-center mb-4">
            <div class="display-5 text-success"><i class="bi bi-patch-check"></i></div>
            <h1 class="h3 fw-bold mb-0">Payment receipt</h1>
            <div class="text-muted"><%= h(title) %> &middot; #<%= id %></div>
        </div>
        <dl class="row mb-0">
            <dt class="col-5">Date</dt><dd class="col-7"><%= h(dateStr) %></dd>
            <dt class="col-5">Resident</dt><dd class="col-7"><%= h(who) %></dd>
            <dt class="col-5">Mobile</dt><dd class="col-7"><%= h(mobile) %></dd>
<% for (String[] l : lines) { %>            <dt class="col-5"><%= h(l[0]) %></dt><dd class="col-7"><%= h(l[1]) %></dd>
<% } %>
            <dt class="col-5">Amount paid</dt><dd class="col-7 total">&#8377;<%= total %></dd>
        </dl>
        <div class="d-flex gap-2 justify-content-center mt-4 no-print">
            <button type="button" class="btn btn-success" onclick="window.print()"><i class="bi bi-printer"></i> Print</button>
            <a class="btn btn-outline-secondary" href="MyPayments.jsp">All payments</a>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/jspf/footer.jspf" %>
