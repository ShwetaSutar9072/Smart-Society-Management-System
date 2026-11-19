<%@ include file="/WEB-INF/jspf/init.jspf" %>
<% String role = "public"; String pageTitle = "Resident login"; %>
<%@ include file="/WEB-INF/jspf/guard.jspf" %>
<%
    if (residentUser != null) { response.sendRedirect("ResidentHomepage.jsp"); return; }
    String error = null;
    String unmVal = "";
    if (Web.isPost(request)) {
        unmVal = Web.param(request, "txtunm");
        String pwd = request.getParameter("txtpass");
        if (unmVal.isEmpty() || pwd == null || pwd.isEmpty()) {
            error = "Please enter both username and password.";
        } else {
            try (Connection con = Db.get();
                 PreparedStatement ps = con.prepareStatement(
                         "SELECT srno, username, password, status FROM registration WHERE username = ?")) {
                ps.setString(1, unmVal);
                try (ResultSet rs = ps.executeQuery()) {
                    if (!rs.next() || !Passwords.verify(pwd, rs.getString("password"))) {
                        error = "Invalid username or password.";
                    } else {
                        String status = rs.getString("status");
                        String dbUser = rs.getString("username");
                        int srno = rs.getInt("srno");
                        String stored = rs.getString("password");
                        if ("Pending".equalsIgnoreCase(status)) {
                            error = "Your registration is still waiting for admin approval.";
                        } else if (!"Approved".equalsIgnoreCase(status)) {
                            error = "Your registration was not approved. Please contact the society office.";
                        } else {
                            if (Passwords.needsUpgrade(stored)) {
                                try (PreparedStatement up = con.prepareStatement(
                                        "UPDATE registration SET password = ? WHERE srno = ?")) {
                                    up.setString(1, Passwords.hash(pwd));
                                    up.setInt(2, srno);
                                    up.executeUpdate();
                                }
                            }
                            request.changeSessionId();
                            session.setAttribute("unm1", dbUser);
                            Web.flash(session, "success", "Welcome back, " + dbUser + "!");
                            response.sendRedirect("ResidentHomepage.jsp");
                            return;
                        }
                    }
                }
            }
        }
    }
%>
<%@ include file="/WEB-INF/jspf/header.jspf" %>
<div class="page-head"><div class="container"><h1>Resident login</h1><p>Access charges, services, event bookings and more.</p></div></div>
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-5">
            <div class="ss-card">
<% if (error != null) { %><div class="alert alert-danger" role="alert"><%= h(error) %></div><% } %>
                <form method="post" action="ResidentLogin.jsp">
                    <div class="mb-3">
                        <label class="form-label" for="txtunm">Username</label>
                        <input type="text" class="form-control" id="txtunm" name="txtunm" value="<%= h(unmVal) %>" autocomplete="username" required autofocus>
                    </div>
                    <div class="mb-2">
                        <label class="form-label" for="txtpass">Password</label>
                        <input type="password" class="form-control" id="txtpass" name="txtpass" autocomplete="current-password" required>
                    </div>
                    <div class="mb-4"><a class="small" href="forgetpassword.jsp">Forgot password?</a></div>
                    <button type="submit" class="btn btn-success btn-lg w-100"><i class="bi bi-box-arrow-in-right"></i> Login</button>
                </form>
                <p class="text-center text-muted mt-4 mb-0">New resident? <a href="Registration.jsp">Register here</a></p>
            </div>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/jspf/footer.jspf" %>
