<%@ include file="/WEB-INF/jspf/init.jspf" %>
<% String role = (session.getAttribute("admin") != null) ? "admin" : (session.getAttribute("unm1") != null ? "resident" : "public"); String pageTitle = "About us"; %>
<%@ include file="/WEB-INF/jspf/guard.jspf" %>
<%@ include file="/WEB-INF/jspf/header.jspf" %>
<section class="py-5" style="background:var(--ss-primary);color:#fff">
    <div class="container">
        <div class="row align-items-center g-4">
            <div class="col-md-8">
                <h1 class="fw-bold">About us</h1>
                <p class="mb-0 fs-5">As soon as you refuse to accept the change, you fail!
                You must choose smart society management software to keep your society running smoothly with the lowest effort.
                If you are looking for the best solution, our website might be the right choice.
                Our website incorporates each necessary feature and keeps upgrading itself as per the requirement.
                Now you can manage the entire society with just a few clicks using this website.</p>
            </div>
            <div class="col-md-4"><img class="about-img" src="img/about2.jpg" alt="About Smart Society"></div>
        </div>
    </div>
</section>
<section class="section">
    <div class="container">
        <div class="text-center mb-5">
            <h2 class="section-title">Our services</h2>
            <p class="section-sub">Managing residential societies using these online society management solutions keeps
            all concerned people aware of the events. With sophisticated email and SMS alerts, instant notification,
            and contact and document management modules, members find it convenient and fast.</p>
        </div>
        <div class="row g-4">
            <div class="col-md-6 col-lg-3"><div class="stat-tile text-center py-4"><div class="display-5 text-success"><i class="bi bi-cpu"></i></div><h3 class="h5 mt-3 mb-0">Smart devices</h3></div></div>
            <div class="col-md-6 col-lg-3"><div class="stat-tile text-center py-4"><div class="display-5 text-success"><i class="bi bi-shield-check"></i></div><h3 class="h5 mt-3 mb-0">Security</h3></div></div>
            <div class="col-md-6 col-lg-3"><div class="stat-tile text-center py-4"><div class="display-5 text-success"><i class="bi bi-receipt"></i></div><h3 class="h5 mt-3 mb-0">Bill generation</h3></div></div>
            <div class="col-md-6 col-lg-3"><div class="stat-tile text-center py-4"><div class="display-5 text-success"><i class="bi bi-clock-history"></i></div><h3 class="h5 mt-3 mb-0">24 hours service</h3></div></div>
        </div>
    </div>
</section>
<%@ include file="/WEB-INF/jspf/footer.jspf" %>
