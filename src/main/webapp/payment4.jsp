<%-- 
    Document   : payment4
    Created on : 11 Feb, 2025, 12:45:03 PM
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
        String id=request.getParameter("bid");
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
            <h1 class="h1">Subscription</h1>
          
        </div>
    </div>

   

    <!-- Start Contact -->
    <div class="container py-5">
                   
             <%
                        int i=0;
                        Statement st=con.createStatement();
                        String str="select count(*)from subscription";
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
                        <label for="inputname">Pay id</label>
                        <input type="text" class="form-control mt-1"  name="txtpid"  value="<%=i%>" readonly="true">
                    </div>
                    <div class="form-group col-md-6 mb-3">
                        <label for="inputemail"> Date</label>
                        <input type="date" class="form-control mt-1"   name="txtdate" value="" >
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
                      
                    }
                    %>
                 <div class="form-group col-md-6 mb-3">
                    <label for="inputsubject">Name</label>
                    <input type="text" class="form-control mt-1" name="txtrnm" value="<%=rnm%>" readonly="true">
                </div>
                 <%
                  
                    String sernm="Smart Core Electrical Services";
                    int amount=0;
                    
                   Statement st1=con.createStatement();
                   String str1="select * from addservices where service='"+sernm+"'";
                   ResultSet rs1=st1.executeQuery(str1);
                   while(rs1.next())
                   {
                       sernm=rs1.getString(2);
                       amount=rs1.getInt(3);
                   }
                   %>   
             <div class="form-group col-md-6 mb-3">
                        <label for="inputemail">Service</label>
                        <input type="text" class="form-control mt-1" name="txtsnm" value="<%=sernm%>" readonly="true">
                    </div>
                </div>
                 <div class="form-group col-md-6 mb-3">
                    <label for="inputsubject">Amount</label>
                    <input type="text" class="form-control mt-1"  name="txtamt" value="<%=amount%>" readonly="true">
                </div>
                
               <div class="form-group col-md-6 mb-3">
                    <label for="inputsubject">QR Code</label>
                    <img class="img-fluid" src="img/qr.jpg" alt="" width="100px" height="100px">
                </div>
             
                <div class="row">
                    <div class="col text-end mt-2">
                        <button type="submit" class="btn btn-success btn-lg px-3">Pay</button>
                    </div>
                      </div>
                 </div>
                </div>
                 <%
                    
                    String date1=request.getParameter("txtdate");
                    String rnm1=request.getParameter("txtrnm");
                    String sernm1=request.getParameter("txtsnm");
                    String amount1=request.getParameter("txtamt");
                    Statement st3=con.createStatement();
                     if(date1!=null && date1!="" && rnm1!=null && rnm1!="" && sernm1!=null && sernm1!=""  && amount1!=null && amount1!="")
                     {
                  String str3="insert into subscription4(payno,date,rnm,service,amount)values("+i+",'"+date1+"','"+rnm1+"','"+sernm1+"','"+amount1+"')";
                  int a=st3.executeUpdate(str3);
                  out.println("<script>alert('subscription is successfully done..')</script>");
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