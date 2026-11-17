<%-- 
    Document   : OtherServices
    Created on : 11 Feb, 2025, 10:13:46 AM
    Author     : HP
--%>


<%@include file="dbconnection.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <title> Service</title>
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
            <h1 class="h1">Other Services</h1>
          
        </div>
    </div>

   

    <!-- Start Contact -->
    <div class="container py-5">
                       <%
                        int i=0;
                        Statement st=con.createStatement();
                        String str="select count(*)from otherservices";
                        ResultSet rs=st.executeQuery(str);
                        if(rs.next())
                        {
                            i=rs.getInt(1);
                            i++;  
                        }
                        %>
        <div class="row py-5">
            <form class="col-md-9 m-auto" method="post" role="form">
                <div class="row">
                    <div class="form-group col-md-6 mb-3">
                        <label for="inputname">Sr.No.</label>
                        <input type="text" class="form-control mt-1" name="txrsrno" value="<%=i%>" readonly="true">
                    </div>
                    <div class="form-group col-md-6 mb-3">
                        <label for="inputemail">Service Name</label>
                        <select name="drpservice">
                        <option>Smart Security</option>
                        <option>Smart Core Cleaning Services</option>
                        <option>Smart Plumbing and Water services</option>
                        <option>Smart Core Electrical Services</option>
                    </select>
                    </div>
                      
                
                 <div class="form-group col-md-6 mb-3">
                    <label for="inputsubject">Provider Name</label>
                    <input type="text" class="form-control mt-1" name="txtpnm" value=""  >
                </div>
               <div class="form-group col-md-6 mb-3">
                        <label for="inputname">Address</label>
                        <input type="text" class="form-control mt-1"  name="txtadd" value="" >
                    </div>
                   
                    <div class="form-group col-md-6 mb-3">
                        <label for="inputemail">Mobile no.</label>
                        <input type="text" class="form-control mt-1"  name="txtmobno" value="" >
                    </div>
               
                
                <div class="row">
                    <div class="col text-end mt-2">
                        <button type="submit" class="btn btn-success btn-lg px-3">Add</button>
                    </div>
                      </div>
                 </div>
                </div>
                <%
                             String snm=request.getParameter("drpservice");
                             String pnm=request.getParameter("txtpnm");
                             String add=request.getParameter("txtadd");
                             String mob=request.getParameter("txtmobno");
                        
                             Statement st1=con.createStatement();
                             if(snm!=null && snm!="" && pnm!=null && pnm!="" && add!=null && add!="" && mob!=null && mob!="")
                             {
                              String str1="insert into otherservices(sno,servicename,pro_name,address,mob_no)values("+i+",'"+snm+"','"+pnm+"','"+add+"','"+mob+"')";   
                               int a=st1.executeUpdate(str1);
                               out.println("<script>alert('your Service is added..')</script>");
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