<%@ include file="/WEB-INF/jspf/init.jspf" %>
<% String role = "public"; String pageTitle = "Reset password"; %>
<%@ include file="/WEB-INF/jspf/guard.jspf" %>
<%
    String error = null;
    String unm = "", email = "", mob = "";
    if (Web.isPost(request)) {
        unm = Web.param(request, "txtunm");
        email = Web.param(request, "txtemail");
        mob = Web.param(request, "txtmob");
        String pwd = request.getParameter("txtpass");
        String pwd2 = request.getParameter("txtpass2");
        if (unm.isEmpty() || email.isEmpty() || mob.isEmpty() || pwd == null || pwd.isEmpty()) {
            error = "Please fill in every field.";
        } else if (pwd.length() < 6) {
            error = "Password must be at least 6 characters.";
        } else if (!pwd.equals(pwd2)) {
            error = "The two passwords do not match.";
        } else {
            // The username alone is not proof of identity: the email and mobile number
            // given at registration must match too.
            try (Connection con = Db.get();
                 PreparedStatement ps = con.prepareStatement(
                         "UPDATE registration SET password = ? WHERE username = ? AND email_id = ? AND mob_no = ?")) {
                ps.setString(1, Passwords.hash(pwd));
                ps.setString(2, unm);
                ps.setString(3, email);
                ps.setString(4, mob);
                if (ps.executeUpdate() == 1) {
                    Web.flash(session, "success", "Password changed. Please log in with your new password.");
                    response.sendRedirect("ResidentLogin.jsp");
                    return;
                }
                error = "Those details do not match any registered resident.";
            }
        }
    }
%>
<%@ include file="/WEB-INF/jspf/header.jspf" %>
<div class="page-head"><div class="container"><h1>Reset password</h1><p>Confirm your registered details, then choose a new password.</p></div></div>
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
            <div class="ss-card">
<% if (error != null) { %><div class="alert alert-danger" role="alert"><%= h(error) %></div><% } %>
                <form method="post" action="forgetpassword.jsp">
                    <div class="mb-3">
                        <label class="form-label" for="txtunm">Username</label>
                        <input type="text" class="form-control" id="txtunm" name="txtunm" value="<%= h(unm) %>" required>
                    </div>
                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label class="form-label" for="txtemail">Registered email</label>
                            <input type="email" class="form-control" id="txtemail" name="txtemail" value="<%= h(email) %>" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label" for="txtmob">Registered mobile</label>
                            <input type="tel" class="form-control" id="txtmob" name="txtmob" value="<%= h(mob) %>" pattern="[0-9]{10}" maxlength="10" required>
                        </div>
                    </div>
                    <div class="row g-3 mb-4">
                        <div class="col-md-6">
                            <label class="form-label" for="txtpass">New password</label>
                            <input type="password" class="form-control" id="txtpass" name="txtpass" minlength="6" autocomplete="new-password" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label" for="txtpass2">Confirm new password</label>
                            <input type="password" class="form-control" id="txtpass2" name="txtpass2" minlength="6" autocomplete="new-password" required>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-success btn-lg w-100"><i class="bi bi-key"></i> Reset password</button>
                </form>
                <p class="text-center mt-4 mb-0"><a href="ResidentLogin.jsp">Back to login</a></p>
            </div>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/jspf/footer.jspf" %>
