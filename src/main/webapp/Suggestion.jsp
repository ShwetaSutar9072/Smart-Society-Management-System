<%@ include file="/WEB-INF/jspf/init.jspf" %>
<% String role = "resident"; String pageTitle = "Feedback"; %>
<%@ include file="/WEB-INF/jspf/guard.jspf" %>
<%
    final String[] TYPES = {"Feedback", "Suggestion", "Complaints"};
    String error = null;
    String guide = "", message = "";
    Db.Resident me = null;
    try (Connection con = Db.get()) {
        me = Db.findResident(con, residentUser);
        if (me == null) { response.sendRedirect("logout.jsp"); return; }
        if (Web.isPost(request)) {
            guide = Web.param(request, "drpguide");
            message = Web.param(request, "txtmsg");
            if (!Arrays.asList(TYPES).contains(guide)) {
                error = "Please choose a type.";
            } else if (message.isEmpty()) {
                error = "Please write your message.";
            } else if (message.length() > 500) {
                error = "Your message is too long (maximum 500 characters).";
            } else {
                try (PreparedStatement ps = con.prepareStatement("INSERT INTO guidance (type, name, mobno, message) VALUES (?,?,?,?)")) {
                    ps.setString(1, guide);
                    ps.setString(2, me.name());
                    ps.setString(3, me.mobile());
                    ps.setString(4, message);
                    ps.executeUpdate();
                }
                Web.flash(session, "success", "Thank you! Your message has been sent to the society admin.");
                response.sendRedirect("Suggestion.jsp");
                return;
            }
        }
    }
%>
<%@ include file="/WEB-INF/jspf/header.jspf" %>
<div class="page-head"><div class="container"><h1>Feedback &amp; complaints</h1><p>Tell the society admin what is working and what is not.</p></div></div>
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-7">
            <div class="ss-card">
<% if (error != null) { %><div class="alert alert-danger" role="alert"><%= h(error) %></div><% } %>
                <form method="post" action="Suggestion.jsp">
                    <div class="row g-3">
                        <div class="col-md-6"><label class="form-label">Name</label><input type="text" class="form-control" value="<%= h(me.name()) %>" readonly></div>
                        <div class="col-md-6"><label class="form-label">Mobile no.</label><input type="text" class="form-control" value="<%= h(me.mobile()) %>" readonly></div>
                        <div class="col-12">
                            <label class="form-label" for="drpguide">Type</label>
                            <select class="form-select" id="drpguide" name="drpguide" required>
                                <option value="">Select type</option>
<% for (String t : TYPES) { %><option<%= t.equals(guide) ? " selected" : "" %>><%= t %></option><% } %>
                            </select>
                        </div>
                        <div class="col-12">
                            <label class="form-label" for="txtmsg">Message</label>
                            <textarea class="form-control" id="txtmsg" name="txtmsg" rows="5" maxlength="500" required><%= h(message) %></textarea>
                            <div class="form-text">Up to 500 characters.</div>
                        </div>
                    </div>
                    <div class="text-end mt-4"><button type="submit" class="btn btn-success btn-lg px-4"><i class="bi bi-send"></i> Send</button></div>
                </form>
            </div>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/jspf/footer.jspf" %>
