<%-- 
    Document   : Suggestion
    Created on : 11 Feb, 2025, 2:42:42 PM
    Author     : HP
--%>
<%@include file="dbconnection.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <title> Contact</title>
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
      <%
        String unm=(String)session.getAttribute("unm1");
    %>
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
            <h1 class="h1">Suggestion</h1>
            
        </div>
    </div>

   

    <!-- Start Contact -->
    <div class="container py-5">
        <div class="row py-5">
            <form class="col-md-9 m-auto" method="post" role="form">
                <div class="row">
                    <div class="form-group col-md-6 mb-3">
                        <label for="inputname">Guidance</label>
                        <select name="drpguide">
                       <option>Feedback</option>
                       <option>Suggestion</option>
                       <option>Complaints</option>
                   </select>
                    </div>
                     
                      <%
                    String rnm=null;
                    String mob=null;
                    Statement st2=con.createStatement();
                    String str2="select * from registration where username='"+unm+"'";
                    ResultSet rs2=st2.executeQuery(str2);
                    while(rs2.next())
                    {
                      rnm=rs2.getString(2);
                      mob=rs2.getString(4);
                    }
                    %>
                  
                    <div class="form-group col-md-6 mb-3">
                        <label for="inputname">Resident Name</label>
                        <input type="text" class="form-control mt-1"  name="txtrnm" value="<%=rnm%>" readonly="true">
                    </div>
                    <div class="form-group col-md-6 mb-3">
                        <label for="inputemail">Mobile No.</label>
                        <input type="text" class="form-control mt-1"   name="txtmob" value="<%=mob%>" readonly="true">
                    </div>
                </div>
                
                <div class="mb-3">
                    <label for="inputmessage">Message</label>
                    <textarea class="form-control mt-1" id="message" name="txtmsg" placeholder="Message" rows="8"></textarea>
                </div>
                <div class="row">
                    <div class="col text-end mt-2">
                        <button type="submit" class="btn btn-success btn-lg px-3">Submit</button>
                    </div>
                </div>
                     <%  
                     String guide=request.getParameter("drpguide");
                     String rnm1=request.getParameter("txtrnm");   
                     String mob1=request.getParameter("txtmob");
                     String message=request.getParameter("txtmsg");
                      Statement st3=con.createStatement();
                     if(guide!=null && guide!="" && rnm1!=null && rnm1!="" && mob1!=null && mob1!="" && message!=null && message!="" && message!="" )
                     {
                  String str3="insert into guidance(type,name,mobno,message)values('"+guide+"','"+rnm1+"','"+mob1+"','"+message+"')";
                  int a=st3.executeUpdate(str3);
                  out.println("<script>alert('Your Guidance successfully done..')</script>");
                     }
                           
                    %>
            </form>
        </div>
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