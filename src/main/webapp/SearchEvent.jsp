<%@ include file="/WEB-INF/jspf/init.jspf" %>
<% String role = "resident"; String pageTitle = "Events"; %>
<%@ include file="/WEB-INF/jspf/guard.jspf" %>
<%@ include file="/WEB-INF/jspf/header.jspf" %>
<div class="page-head"><div class="container"><h1>Book an event</h1><p>Choose an event type to book the society hall.</p></div></div>
<div class="container py-5">
    <div class="row g-4">
<%
    int rows = 0;
    try (Connection con = Db.get(); Statement st = con.createStatement();
         ResultSet rs = st.executeQuery("SELECT eventid, eventname, eventcharges FROM addevent ORDER BY eventid")) {
        while (rs.next()) {
            rows++;
%>
        <div class="col-sm-6 col-lg-4">
            <div class="ss-card h-100 text-center">
                <div class="display-5 text-success mb-2"><i class="bi bi-calendar-heart"></i></div>
                <h2 class="h5"><%= h(rs.getString("eventname")) %></h2>
                <p class="fs-4 fw-bold mb-3">&#8377;<%= rs.getInt("eventcharges") %></p>
                <a class="btn btn-success" href="BookingEvent.jsp?eventid=<%= rs.getInt("eventid") %>"><i class="bi bi-journal-plus"></i> Book now</a>
            </div>
        </div>
<%
        }
    }
    if (rows == 0) {
%>
        <div class="col-12"><div class="ss-card empty-state"><i class="bi bi-calendar-event"></i>No events are available for booking yet.</div></div>
<% } %>
    </div>
</div>
<%@ include file="/WEB-INF/jspf/footer.jspf" %>
