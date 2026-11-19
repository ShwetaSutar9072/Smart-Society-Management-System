<%@ include file="/WEB-INF/jspf/init.jspf" %>
<% String role = "admin"; String pageTitle = "Add event"; %>
<%@ include file="/WEB-INF/jspf/guard.jspf" %>
<%
    String error = null;
    String evNm = "", evCh = "";
    if (Web.isPost(request)) {
        String action = Web.param(request, "action");
        int idParam = Web.toInt(request.getParameter("eventid"), -1);
        if ("update".equals(action)) {
            int ch = Web.toInt(request.getParameter("charges"), -1);
            if (ch < 0) {
                Web.flash(session, "danger", "Charges must be a whole number, zero or more.");
            } else {
                try (Connection con = Db.get();
                     PreparedStatement ps = con.prepareStatement("UPDATE addevent SET eventcharges = ? WHERE eventid = ?")) {
                    ps.setInt(1, ch);
                    ps.setInt(2, idParam);
                    ps.executeUpdate();
                }
                Web.flash(session, "success", "Event charges updated.");
            }
            response.sendRedirect("EventInfo.jsp");
            return;
        } else if ("delete".equals(action)) {
            try (Connection con = Db.get();
                 PreparedStatement ps = con.prepareStatement("DELETE FROM addevent WHERE eventid = ?")) {
                ps.setInt(1, idParam);
                ps.executeUpdate();
            }
            Web.flash(session, "success", "Event removed.");
            response.sendRedirect("EventInfo.jsp");
            return;
        }
        evNm = Web.param(request, "drpevent");
        evCh = Web.param(request, "txtecharges");
        int chN = Web.toInt(evCh, -1);
        if (!Arrays.asList(Catalog.EVENTS).contains(evNm)) {
            error = "Please choose an event type.";
        } else if (chN < 0) {
            error = "Charges must be a whole number, zero or more.";
        } else {
            try (Connection con = Db.get()) {
                boolean exists;
                try (PreparedStatement chk = con.prepareStatement("SELECT 1 FROM addevent WHERE eventname = ?")) {
                    chk.setString(1, evNm);
                    try (ResultSet rs = chk.executeQuery()) { exists = rs.next(); }
                }
                if (exists) {
                    error = "\"" + evNm + "\" already exists. Edit its charges in the table instead.";
                } else {
                    for (int attempt = 0; ; attempt++) {
                        try (PreparedStatement ps = con.prepareStatement(
                                "INSERT INTO addevent (eventid, eventname, eventcharges) VALUES (?,?,?)")) {
                            ps.setInt(1, Db.nextId(con, "addevent", "eventid"));
                            ps.setString(2, evNm);
                            ps.setInt(3, chN);
                            ps.executeUpdate();
                            break;
                        } catch (SQLException e) {
                            if (!Db.isDuplicate(e) || attempt >= 2) throw e;
                        }
                    }
                    Web.flash(session, "success", "Event added.");
                    response.sendRedirect("EventInfo.jsp");
                    return;
                }
            }
        }
    }
%>
<%@ include file="/WEB-INF/jspf/header.jspf" %>
<div class="page-head"><div class="container"><h1>Events</h1><p>Event types residents can book, and what each one costs.</p></div></div>
<div class="container py-5">
    <div class="row g-4">
        <div class="col-lg-4">
            <div class="ss-card">
                <h2 class="h5 card-title">Add an event</h2>
<% if (error != null) { %><div class="alert alert-danger" role="alert"><%= h(error) %></div><% } %>
                <form method="post" action="EventInfo.jsp">
                    <div class="mb-3">
                        <label class="form-label" for="drpevent">Event</label>
                        <select class="form-select" id="drpevent" name="drpevent" required>
                            <option value="">Select event</option>
<% for (String ev : Catalog.EVENTS) { %><option<%= ev.equals(evNm) ? " selected" : "" %>><%= h(ev) %></option><% } %>
                        </select>
                    </div>
                    <div class="mb-4">
                        <label class="form-label" for="txtecharges">Charges (&#8377;)</label>
                        <input type="number" class="form-control" id="txtecharges" name="txtecharges" min="0" value="<%= h(evCh) %>" required>
                    </div>
                    <button type="submit" class="btn btn-success w-100"><i class="bi bi-plus-circle"></i> Add event</button>
                </form>
            </div>
        </div>
        <div class="col-lg-8">
            <div class="ss-table table-responsive">
                <table class="table align-middle">
                    <thead><tr><th>#</th><th>Event</th><th style="width:220px">Charges (&#8377;)</th><th></th></tr></thead>
                    <tbody>
<%
    int rows = 0;
    try (Connection con = Db.get(); Statement st = con.createStatement();
         ResultSet rs = st.executeQuery("SELECT eventid, eventname, eventcharges FROM addevent ORDER BY eventid")) {
        while (rs.next()) {
            rows++;
            int id = rs.getInt("eventid");
%>
                        <tr>
                            <td><%= id %></td>
                            <td><%= h(rs.getString("eventname")) %></td>
                            <td>
                                <form method="post" action="EventInfo.jsp" class="d-flex gap-2">
                                    <input type="hidden" name="action" value="update"><input type="hidden" name="eventid" value="<%= id %>">
                                    <input type="number" class="form-control form-control-sm" name="charges" min="0" value="<%= rs.getInt("eventcharges") %>" aria-label="Charges" required>
                                    <button class="btn btn-sm btn-outline-success" title="Save charges"><i class="bi bi-check-lg"></i></button>
                                </form>
                            </td>
                            <td class="text-end">
                                <form method="post" action="EventInfo.jsp" onsubmit="return confirm('Remove this event type?');">
                                    <input type="hidden" name="action" value="delete"><input type="hidden" name="eventid" value="<%= id %>">
                                    <button class="btn btn-sm btn-outline-danger" title="Remove"><i class="bi bi-trash"></i></button>
                                </form>
                            </td>
                        </tr>
<%
        }
    }
    if (rows == 0) {
%>
                        <tr><td colspan="4"><div class="empty-state"><i class="bi bi-calendar-event"></i>No events yet.</div></td></tr>
<% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/jspf/footer.jspf" %>
