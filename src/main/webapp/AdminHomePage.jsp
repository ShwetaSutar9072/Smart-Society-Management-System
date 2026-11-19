<%@ include file="/WEB-INF/jspf/init.jspf" %>
<% String role = "admin"; String pageTitle = "Dashboard"; %>
<%@ include file="/WEB-INF/jspf/guard.jspf" %>
<%
    int residents = 0, pending = 0, bookings = 0, feedback = 0, paid = 0;
    try (Connection con = Db.get(); Statement st = con.createStatement()) {
        try (ResultSet rs = st.executeQuery("SELECT COUNT(*), COALESCE(SUM(status='Pending'),0) FROM registration")) {
            if (rs.next()) { residents = rs.getInt(1); pending = rs.getInt(2); }
        }
        try (ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM bookingevent")) { if (rs.next()) bookings = rs.getInt(1); }
        try (ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM guidance")) { if (rs.next()) feedback = rs.getInt(1); }
        try (ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM paycharges")) { if (rs.next()) paid = rs.getInt(1); }
    }
%>
<%@ include file="/WEB-INF/jspf/header.jspf" %>
<div class="page-head"><div class="container"><h1>Admin dashboard</h1><p>An overview of your society at a glance.</p></div></div>
<div class="container py-5">
    <div class="row g-3 mb-5">
        <div class="col-6 col-lg-3"><div class="stat-tile"><div class="num"><%= residents %></div><div class="lbl">Registered residents</div></div></div>
        <div class="col-6 col-lg-3"><div class="stat-tile"><div class="num"><%= pending %></div><div class="lbl">Waiting for approval</div></div></div>
        <div class="col-6 col-lg-3"><div class="stat-tile"><div class="num"><%= paid %></div><div class="lbl">Charges paid</div></div></div>
        <div class="col-6 col-lg-3"><div class="stat-tile"><div class="num"><%= bookings %></div><div class="lbl">Event bookings</div></div></div>
    </div>
    <h2 class="h4 fw-bold mb-3">Quick actions</h2>
    <div class="row g-3">
        <div class="col-md-6 col-lg-4"><a class="tile-link" href="viewregistration.jsp"><span class="tile-ico"><i class="bi bi-people"></i></span><span><strong>Residents</strong><span class="sub"><%= pending > 0 ? pending + " waiting for approval" : "Approve or reject registrations" %></span></span></a></div>
        <div class="col-md-6 col-lg-4"><a class="tile-link" href="CommonCharges.jsp"><span class="tile-ico"><i class="bi bi-cash-coin"></i></span><span><strong>Add monthly charges</strong><span class="sub">Electricity &amp; maintenance</span></span></a></div>
        <div class="col-md-6 col-lg-4"><a class="tile-link" href="SearchPayCharges.jsp"><span class="tile-ico"><i class="bi bi-receipt"></i></span><span><strong>Paid charges</strong><span class="sub">Search payments by date</span></span></a></div>
        <div class="col-md-6 col-lg-4"><a class="tile-link" href="Addservices.jsp"><span class="tile-ico"><i class="bi bi-tools"></i></span><span><strong>Services &amp; prices</strong><span class="sub">Add or edit subscription services</span></span></a></div>
        <div class="col-md-6 col-lg-4"><a class="tile-link" href="OtherServices.jsp"><span class="tile-ico"><i class="bi bi-person-vcard"></i></span><span><strong>Service providers</strong><span class="sub">Contact details shown to residents</span></span></a></div>
        <div class="col-md-6 col-lg-4"><a class="tile-link" href="Adminviewservice.jsp?type=1"><span class="tile-ico"><i class="bi bi-journal-text"></i></span><span><strong>Subscriptions</strong><span class="sub">Who subscribed to what</span></span></a></div>
        <div class="col-md-6 col-lg-4"><a class="tile-link" href="EventInfo.jsp"><span class="tile-ico"><i class="bi bi-calendar-plus"></i></span><span><strong>Add event</strong><span class="sub">Event types and charges</span></span></a></div>
        <div class="col-md-6 col-lg-4"><a class="tile-link" href="SearchBookingEvent.jsp"><span class="tile-ico"><i class="bi bi-journal-check"></i></span><span><strong>Event bookings</strong><span class="sub">Search by booking date</span></span></a></div>
        <div class="col-md-6 col-lg-4"><a class="tile-link" href="viewsuggestion.jsp"><span class="tile-ico"><i class="bi bi-chat-left-text"></i></span><span><strong>Feedback</strong><span class="sub"><%= feedback %> message<%= feedback == 1 ? "" : "s" %> from residents</span></span></a></div>
    </div>
</div>
<%@ include file="/WEB-INF/jspf/footer.jspf" %>
