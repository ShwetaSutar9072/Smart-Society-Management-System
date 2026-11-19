<%@ include file="/WEB-INF/jspf/init.jspf" %>
<% String role = "public"; String pageTitle = "Registration"; %>
<%@ include file="/WEB-INF/jspf/guard.jspf" %>
<%
    String error = null;
    String rnm = "", add = "", mob = "", email = "", unm = "";
    if (Web.isPost(request)) {
        rnm = Web.param(request, "txtrnm");
        add = Web.param(request, "txtadd");
        mob = Web.param(request, "txtmno");
        email = Web.param(request, "txteid");
        unm = Web.param(request, "txtunm");
        String pwd = request.getParameter("txtpass");
        String pwd2 = request.getParameter("txtpass2");
        if (rnm.isEmpty() || add.isEmpty() || mob.isEmpty() || email.isEmpty() || unm.isEmpty() || pwd == null || pwd.isEmpty()) {
            error = "Please fill in every field.";
        } else if (!Web.validMobile(mob)) {
            error = "Mobile number must be exactly 10 digits.";
        } else if (!Web.validEmail(email)) {
            error = "Please enter a valid email address.";
        } else if (!unm.matches("[A-Za-z0-9_.-]{3,30}")) {
            error = "Username must be 3-30 characters: letters, numbers, dot, dash or underscore.";
        } else if (pwd.length() < 6) {
            error = "Password must be at least 6 characters.";
        } else if (!pwd.equals(pwd2)) {
            error = "The two passwords do not match.";
        } else {
            try (Connection con = Db.get();
                 PreparedStatement ps = con.prepareStatement(
                         "INSERT INTO registration (resi_name, address, mob_no, email_id, username, password, status) "
                         + "VALUES (?, ?, ?, ?, ?, ?, 'Pending')")) {
                ps.setString(1, rnm);
                ps.setString(2, add);
                ps.setString(3, mob);
                ps.setString(4, email);
                ps.setString(5, unm);
                ps.setString(6, Passwords.hash(pwd));
                ps.executeUpdate();
                Web.flash(session, "success", "Registration submitted. You can log in once the admin approves your account.");
                response.sendRedirect("ResidentLogin.jsp");
                return;
            } catch (SQLException e) {
                if (Db.isDuplicate(e)) {
                    error = "That username is already taken. Please choose another.";
                } else {
                    throw e;
                }
            }
        }
    }
%>
<%@ include file="/WEB-INF/jspf/header.jspf" %>
<div class="page-head"><div class="container"><h1>Resident registration</h1><p>Create your account. The society admin will approve it before you can log in.</p></div></div>
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="ss-card">
<% if (error != null) { %><div class="alert alert-danger" role="alert"><%= h(error) %></div><% } %>
                <form method="post" action="Registration.jsp">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label" for="txtrnm">Resident name</label>
                            <input type="text" class="form-control" id="txtrnm" name="txtrnm" value="<%= h(rnm) %>" maxlength="100" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label" for="txtadd">Address / flat no.</label>
                            <input type="text" class="form-control" id="txtadd" name="txtadd" value="<%= h(add) %>" maxlength="255" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label" for="txtmno">Mobile no.</label>
                            <input type="tel" class="form-control" id="txtmno" name="txtmno" value="<%= h(mob) %>" pattern="[0-9]{10}" maxlength="10" inputmode="numeric" placeholder="10-digit number" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label" for="txteid">Email ID</label>
                            <input type="email" class="form-control" id="txteid" name="txteid" value="<%= h(email) %>" maxlength="100" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label" for="txtunm">Username</label>
                            <input type="text" class="form-control" id="txtunm" name="txtunm" value="<%= h(unm) %>" pattern="[A-Za-z0-9_.\-]{3,30}" maxlength="30" autocomplete="username" required>
                        </div>
                        <div class="col-md-6"></div>
                        <div class="col-md-6">
                            <label class="form-label" for="txtpass">Password</label>
                            <input type="password" class="form-control" id="txtpass" name="txtpass" minlength="6" autocomplete="new-password" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label" for="txtpass2">Confirm password</label>
                            <input type="password" class="form-control" id="txtpass2" name="txtpass2" minlength="6" autocomplete="new-password" required>
                        </div>
                    </div>
                    <div class="text-end mt-4">
                        <button type="submit" class="btn btn-success btn-lg px-4"><i class="bi bi-person-plus"></i> Register</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/jspf/footer.jspf" %>
