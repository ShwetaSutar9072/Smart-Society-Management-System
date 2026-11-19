<%@ include file="/WEB-INF/jspf/init.jspf" %>
<% String role = "resident"; String pageTitle = "Book event"; %>
<%@ include file="/WEB-INF/jspf/guard.jspf" %>
<%
    final String[] SLOTS = {"Morning (8 AM - 12 PM)", "Afternoon (12 PM - 4 PM)", "Evening (4 PM - 8 PM)", "Night (8 PM - 11 PM)"};
    int eventId = Web.toInt(request.getParameter("eventid"), -1);
    String eventName = null;
    int eventCharges = 0;
    Db.Resident me = null;
    String error = null;
    String edate = "", etime = "";
    String today = java.time.LocalDate.now().toString();
    try (Connection con = Db.get()) {
        me = Db.findResident(con, residentUser);
        boolean found = false;
        try (PreparedStatement ps = con.prepareStatement("SELECT eventname, eventcharges FROM addevent WHERE eventid = ?")) {
            ps.setInt(1, eventId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) { found = true; eventName = rs.getString(1); eventCharges = rs.getInt(2); }
            }
        }
        if (me == null || !found) {
            Web.flash(session, "warning", "Please choose an event first.");
            response.sendRedirect("SearchEvent.jsp");
            return;
        }
        if (Web.isPost(request)) {
            edate = Web.param(request, "txtedate");
            etime = Web.param(request, "txtetime");
            boolean validDate = false;
            try { validDate = !java.time.LocalDate.parse(edate).isBefore(java.time.LocalDate.now()); } catch (Exception ignore) { }
            if (!validDate) {
                error = "Please choose today or a future date for the event.";
            } else if (!Arrays.asList(SLOTS).contains(etime)) {
                error = "Please choose a time slot.";
            } else {
                boolean taken;
                try (PreparedStatement chk = con.prepareStatement("SELECT 1 FROM bookingevent WHERE edate = ?")) {
                    chk.setString(1, edate);
                    try (ResultSet rs = chk.executeQuery()) { taken = rs.next(); }
                }
                if (taken) {
                    error = "The hall is already booked on " + edate + ". Please pick another date.";
                } else {
                    for (int attempt = 0; ; attempt++) {
                        try (PreparedStatement ps = con.prepareStatement(
                                "INSERT INTO bookingevent (bid, bdate, rname, mob, ename, echarges, edate, etime) VALUES (?,?,?,?,?,?,?,?)")) {
                            ps.setInt(1, Db.nextId(con, "bookingevent", "bid"));
                            ps.setString(2, today);
                            ps.setString(3, me.name());
                            ps.setString(4, me.mobile());
                            ps.setString(5, eventName);
                            ps.setInt(6, eventCharges);
                            ps.setString(7, edate);
                            ps.setString(8, etime);
                            ps.executeUpdate();
                            break;
                        } catch (SQLException e) {
                            if (!Db.isDuplicate(e) || attempt >= 2) throw e;
                        }
                    }
                    Web.flash(session, "success", "Your " + eventName + " is booked for " + edate + ".");
                    response.sendRedirect("MyPayments.jsp#bookings");
                    return;
                }
            }
        }
    }
%>
<%@ include file="/WEB-INF/jspf/header.jspf" %>
<div class="page-head"><div class="container"><h1>Book: <%= h(eventName) %></h1><p>Charges: &#8377;<%= eventCharges %></p></div></div>
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-7">
            <div class="ss-card">
<% if (error != null) { %><div class="alert alert-danger" role="alert"><%= h(error) %></div><% } %>
                <form method="post" action="BookingEvent.jsp?eventid=<%= eventId %>">
                    <div class="row g-3">
                        <div class="col-md-6"><label class="form-label">Booking date</label><input type="text" class="form-control" value="<%= today %>" readonly></div>
                        <div class="col-md-6"><label class="form-label">Resident</label><input type="text" class="form-control" value="<%= h(me.name()) %>" readonly></div>
                        <div class="col-md-6"><label class="form-label">Mobile no.</label><input type="text" class="form-control" value="<%= h(me.mobile()) %>" readonly></div>
                        <div class="col-md-6"><label class="form-label">Event</label><input type="text" class="form-control" value="<%= h(eventName) %> &mdash; &#8377;<%= eventCharges %>" readonly></div>
                        <div class="col-md-6">
                            <label class="form-label" for="txtedate">Event date</label>
                            <input type="date" class="form-control" id="txtedate" name="txtedate" min="<%= today %>" value="<%= h(edate) %>" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label" for="txtetime">Time slot</label>
                            <select class="form-select" id="txtetime" name="txtetime" required>
                                <option value="">Select a time slot</option>
<% for (String slot : SLOTS) { %><option<%= slot.equals(etime) ? " selected" : "" %>><%= slot %></option><% } %>
                            </select>
                        </div>
                    </div>
                    <div class="d-flex gap-2 mt-4">
                        <a class="btn btn-outline-secondary" href="SearchEvent.jsp">Back</a>
                        <button type="submit" class="btn btn-success flex-grow-1"><i class="bi bi-journal-check"></i> Confirm booking</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/jspf/footer.jspf" %>
