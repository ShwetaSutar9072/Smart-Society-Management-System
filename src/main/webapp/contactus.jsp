<%@ include file="/WEB-INF/jspf/init.jspf" %>
<% String role = (session.getAttribute("admin") != null) ? "admin" : (session.getAttribute("unm1") != null ? "resident" : "public"); String pageTitle = "Contact us"; %>
<%@ include file="/WEB-INF/jspf/guard.jspf" %>
<%@ include file="/WEB-INF/jspf/header.jspf" %>
<div class="page-head">
    <div class="container">
        <h1>Contact us</h1>
        <p>We help you to make your society smarter and well managed. Happy communities are made of delightful resident experiences!</p>
    </div>
</div>
<div class="container py-5">
    <div class="row g-4 justify-content-center">
        <div class="col-md-4"><div class="stat-tile text-center py-4"><div class="display-6 text-success"><i class="bi bi-geo-alt"></i></div><h2 class="h5 mt-3">Address</h2><p class="mb-0 text-muted">Nivasa Anaya, Pune</p></div></div>
        <div class="col-md-4"><div class="stat-tile text-center py-4"><div class="display-6 text-success"><i class="bi bi-telephone"></i></div><h2 class="h5 mt-3">Phone</h2><p class="mb-0"><a href="tel:7939897564">7939897564</a></p></div></div>
        <div class="col-md-4"><div class="stat-tile text-center py-4"><div class="display-6 text-success"><i class="bi bi-envelope"></i></div><h2 class="h5 mt-3">Email</h2><p class="mb-0"><a href="mailto:info@company.com">info@company.com</a></p></div></div>
    </div>
</div>
<%@ include file="/WEB-INF/jspf/footer.jspf" %>
