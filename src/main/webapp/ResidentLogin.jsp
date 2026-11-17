<%-- 
    Document   : ResidentLogin
    Created on : 11 Feb, 2025, 11:56:19 AM
    Author     : HP
--%>

<%@include file="dbconnection.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <title> Login</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/templatemo.css">
    <link rel="stylesheet" href="css/custom.css">

    <!-- Load fonts style after rendering the layout styles -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;200;300;400;500;700;900&display=swap">
    <link rel="stylesheet" href="css/fontawesome.min.css">

   
</head>

<body>
    <!-- Start Top Nav -->
    <nav class="navbar navbar-expand-lg bg-dark navbar-light d-none d-lg-block" id="templatemo_nav_top">
        <div class="container text-light">
            
        </div>
    </nav>
    <!-- Close Top Nav -->


    <!-- Header -->
    <nav class="navbar navbar-expand-lg navbar-light shadow">
        <div class="container d-flex justify-content-between align-items-center">

            <a class="navbar-brand text-success logo h1 align-self-center" href="index.html">
              Smart Society
            </a>

            <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#templatemo_main_nav" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="align-self-center collapse navbar-collapse flex-fill  d-lg-flex justify-content-lg-between" id="templatemo_main_nav">
                <div class="flex-fill">
                    <ul class="nav navbar-nav d-flex justify-content-between mx-lg-auto">
                         <li class="nav-item">
                            <a class="nav-link" href="ResidentHomepage.jsp">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="SearchTotalCharges.jsp">Charges</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="SearchEvent.jsp">Event</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="logout.jsp">Logout</a>
                        </li>
                    </ul>
                </div>
                

        </div>
    </nav>
    <!-- Close Header -->
    

    <!-- Start Content Page -->
    <div class="container-fluid bg-light py-5">
        <div class="col-md-6 m-auto text-center">
            <h1 class="h1" align="center">Login</h1>
          
        </div>
    </div>

   

    <!-- Start Contact -->
    <div class="container py-5">
               
        <div class="row py-5">
            <form class="col-md-9 m-auto" method="post" role="form">
                <div class="row">
                    
                    <div class="form-group col-md-6 mb-3">
                        <label for="inputemail">Username</label>
                        <input type="text" class="form-control mt-1"  name="txtunm" value="" >
                    </div>
                </div>
                 <div class="form-group col-md-6 mb-3">
                    <label for="inputsubject">Password</label>
                    <input type="text" class="form-control mt-1"  name="txtpass" value=""  >
                </div>
                <div class="form-group col-md-6 mb-3">
                   
                    <li class="nav-item">
                            <a class="nav-link" href="forgetpassword.jsp">Forget Password</a>
                        </li>
                    
                </div>
                <div class="row">
                    <div class="col text-end mt-2">
                        <button type="submit" class="btn btn-success btn-lg px-3">Login</button>
                    </div>
                </div>
            </form>
        </div>
         <%
                                        String unm=request.getParameter("txtunm");
                                         String pass=request.getParameter("txtpass");
                                        Statement st=con.createStatement();
                                        if(unm!=null && unm!=" " && pass!=null && pass!=" ")
                                          
                                              {
                                    String str="select * from registration where username='"+unm+"' and password='"+pass+"' and status='Approved'";                                                  ResultSet rs=st.executeQuery(str);
                                                  if(rs.next())
                                                  {
                                                      out.println("<script>alert('Login Success....')</script>");
                                                      session.setAttribute("unm1",unm);
                                                      response.sendRedirect("ResidentHomepage.jsp");
                                                  }
                                                  else
                                                  {
                        out.println("<script>alert('Login Failed,contact to Admin')</script>");
                                                  }
                                              }
                                        %>
    </div>
    <!-- End Contact -->


    

    <!-- Start Script -->
    <script src="assets/js/jquery-1.11.0.min.js"></script>
    <script src="assets/js/jquery-migrate-1.2.1.min.js"></script>
    <script src="assets/js/bootstrap.bundle.min.js"></script>
    <script src="assets/js/templatemo.js"></script>
    <script src="assets/js/custom.js"></script>
    <!-- End Script -->
</body>

</html>