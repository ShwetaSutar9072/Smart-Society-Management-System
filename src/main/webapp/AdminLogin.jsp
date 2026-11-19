<%@ include file="/WEB-INF/jspf/init.jspf" %>
<% String role = "public"; String pageTitle = "Admin login"; %>
<%@ include file="/WEB-INF/jspf/guard.jspf" %>
<%
    if (isAdmin) { response.sendRedirect("AdminHomePage.jsp"); return; }
    String error = null;
    String unmVal = "";
    if (Web.isPost(request)) {
        unmVal = Web.param(request, "txtunm");
        String pwd = request.getParameter("txtpass");
        if (unmVal.isEmpty() || pwd == null || pwd.isEmpty()) {
            error = "Please enter both username and password.";
        } else {
            try (Connection con = Db.get();
                 PreparedStatement ps = con.prepareStatement("SELECT password FROM admlogin WHERE admname = ?")) {
                ps.setString(1, unmVal);
                String matched = null;
                int colWidth = 0;
                try (ResultSet rs = ps.executeQuery()) {
                    colWidth = rs.getMetaData().getPrecision(1);
                    while (rs.next()) {
                        if (Passwords.verify(pwd, rs.getString(1))) { matched = rs.getString(1); break; }
                    }
                }
                if (matched == null) {
                    error = "Invalid username or password.";
                } else {
                    // Upgrade a plain-text password to a hash, but only if the column is wide enough
                    // (see ss_backup/migration.sql, which widens it to 255).
                    if (Passwords.needsUpgrade(matched) && colWidth >= 100) {
                        try (PreparedStatement up = con.prepareStatement(
                                "UPDATE admlogin SET password = ? WHERE admname = ? AND password = ?")) {
                            up.setString(1, Passwords.hash(pwd));
                            up.setString(2, unmVal);
                            up.setString(3, matched);
                            up.executeUpdate();
                        }
                    }
                    request.changeSessionId();
                    session.setAttribute("admin", unmVal);
                    Web.flash(session, "success", "Welcome, " + unmVal + ".");
                    response.sendRedirect("AdminHomePage.jsp");
                    return;
                }
            }
        }
    }
%>
<%@ include file="/WEB-INF/jspf/header.jspf" %>
<div class="page-head"><div class="container"><h1>Admin login</h1><p>Sign in to manage residents, charges, services and events.</p></div></div>
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-5">
            <div class="ss-card">
<% if (error != null) { %><div class="alert alert-danger" role="alert"><%= h(error) %></div><% } %>
                <form method="post" action="AdminLogin.jsp" autocomplete="on">
                    <div class="mb-3">
                        <label class="form-label" for="txtunm">Username</label>
                        <input type="text" class="form-control" id="txtunm" name="txtunm" value="<%= h(unmVal) %>" autocomplete="username" required autofocus>
                    </div>
                    <div class="mb-4">
                        <label class="form-label" for="txtpass">Password</label>
                        <input type="password" class="form-control" id="txtpass" name="txtpass" autocomplete="current-password" required>
                    </div>
                    <button type="submit" class="btn btn-success btn-lg w-100"><i class="bi bi-box-arrow-in-right"></i> Login</button>
                </form>
            </div>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/jspf/footer.jspf" %>
