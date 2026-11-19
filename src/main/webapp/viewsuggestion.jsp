<%@ include file="/WEB-INF/jspf/init.jspf" %>
<% String role = "admin"; String pageTitle = "Feedback"; %>
<%@ include file="/WEB-INF/jspf/guard.jspf" %>
<%@ include file="/WEB-INF/jspf/header.jspf" %>
<div class="page-head"><div class="container"><h1>Resident feedback</h1><p>Feedback, suggestions and complaints sent by residents.</p></div></div>
<div class="container py-5">
    <div class="ss-table table-responsive">
        <table class="table table-hover align-middle">
            <thead><tr><th>Type</th><th>Name</th><th>Mobile</th><th>Message</th></tr></thead>
            <tbody>
<%
    int rows = 0;
    try (Connection con = Db.get(); Statement st = con.createStatement();
         ResultSet rs = st.executeQuery("SELECT type, name, mobno, message FROM guidance")) {
        while (rs.next()) {
            rows++;
            String type = rs.getString("type");
            String badge = "Complaints".equals(type) ? "danger" : ("Suggestion".equals(type) ? "info" : "success");
%>
                <tr>
                    <td><span class="badge text-bg-<%= badge %>"><%= h(type) %></span></td>
                    <td><%= h(rs.getString("name")) %></td>
                    <td><%= h(rs.getString("mobno")) %></td>
                    <td style="white-space:pre-wrap"><%= h(rs.getString("message")) %></td>
                </tr>
<%
        }
    }
    if (rows == 0) {
%>
                <tr><td colspan="4"><div class="empty-state"><i class="bi bi-chat-left-text"></i>No feedback yet.</div></td></tr>
<% } %>
            </tbody>
        </table>
    </div>
</div>
<%@ include file="/WEB-INF/jspf/footer.jspf" %>
