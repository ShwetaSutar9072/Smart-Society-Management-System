<%-- 
    Document   : SearchPayCharges
    Created on : 11 Feb, 2025, 2:18:19 PM
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
                            <a class="nav-link" href="AdminHomePage.jsp">Home</a>
                        </li>
                         <li class="nav-item">
                             <a class="nav-link" href="SearchSubscription.jsp">security</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="searchsubscription2.jsp">Cleaning Services</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="searchsubscription3.jsp">Plumbing & Water Services</a>
                        </li>
                         <li class="nav-item">
                             <a class="nav-link" href="searchsubscription4.jsp">Electrical Services</a>
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
            <h1 class="h1">View Smart Core Cleaning Services Subscription</h1>
          
        </div>
    </div>

   

    <!-- Start Contact -->
    <div class="container py-5">
               
        <div class="row py-5">
            <form class="col-md-9 m-auto" method="post" role="form">
                <div class="row">
                    
                    
                </div>
                <table>
                <%
                     int i=0;
                     String date=request.getParameter("txtdate");
                     String rnm=request.getParameter("txtrnm");
                     String sernm=request.getParameter("txtsnm");
                    
                     int amount=0;
                     
                    
                   
                   Statement st=con.createStatement();
                   
                   String str="select * from subscription2";
                   ResultSet rs=st.executeQuery(str);
                   while(rs.next())
                   {
                     i=rs.getInt(1);
                     date=rs.getString(2);
                     rnm=rs.getString(3);
                     sernm=rs.getString(4);
                     amount =rs.getInt(5);
                     
                   %>
                <tr><td width="100px" align="center" height="20px" style="border: medium solid #000;" >Pay Id</td>
                        <td width="100px" height=30px" align="center" style=" border: medium solid #000;">Date</td>
                        <td width="100px" height="30px" align="center" style=" border: medium solid #000;">Name</td>
                         <td width="100px" height=30px" align="center" style=" border: medium solid #000;">Service</td>
                        <td width="100px" height="30px" align="center" style=" border: medium solid #000;">Amount</td>
                        
                           
                    </tr>
                   
                   <tr><td width="100px" align="center" style="border: medium solid #000;" ><%=i%></td>
                       <td width="100px" align="center" style="border: medium solid #000;" ><%=date%></td>
                       <td width="100px" align="center" style="border: medium solid #000;" ><%=rnm%></td> 
                       <td width="100px" align="center" style="border: medium solid #000;" ><%=sernm%></td>
                       <td width="100px" align="center" style="border: medium solid #000;" ><%=amount%></td>
                       

            </tr>
                   <%
                   

                   }
                   %>
                </table>
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