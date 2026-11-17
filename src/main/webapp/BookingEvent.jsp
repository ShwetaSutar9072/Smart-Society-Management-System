<%-- 
    Document   : BookingEvent
    Created on : 10 Feb, 2025, 7:56:55 PM
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

            <a class="navbar-brand text-success logo h1 align-self-center" >
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
            <h1 class="h1">Booking Event</h1>
          
        </div>
    </div>

   

    <!-- Start Contact -->
    <div class="container py-5">
              <%
                     int i=0;
                     Statement st=con.createStatement();
                     String str="select count(*)from bookingevent;";
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
                        <label for="inputname">Booking id</label>
                        <input type="text" class="form-control mt-1"  name="txtbid" value="<%=i%>" readonly="true" placeholder="">
                    </div>
                    <div class="form-group col-md-6 mb-3">
                        <label for="inputemail">Booking Date</label>
                        <input type="date" class="form-control mt-1"   name="txtbdate" value="" >
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
                    <label for="inputsubject">Name</label>
                    <input type="text" class="form-control mt-1"  name="txtnm" value="<%=rnm%>" readonly="true" placeholder="Name">
                </div>
               <div class="form-group col-md-6 mb-3">
                        <label for="inputname">Mobile No.</label>
                        <input type="text" class="form-control mt-1"  name="txtmno" value="<%=mob%>" readonly="true"  placeholder="">
                    </div>
                    <%
                    String eventnm=null;
                    int eventcharges=0;
                    Statement st3=con.createStatement();
                    String str3="select * from addevent where eventid="+id+"";
                    ResultSet rs3=st3.executeQuery(str3);
                    while(rs3.next())
                    {
                      eventnm=rs3.getString(2);
                      eventcharges=rs3.getInt(3);
                    }
                    %>
                    <div class="form-group col-md-6 mb-3">
                        <label for="inputemail">Event Name</label>
                        <input type="text" class="form-control mt-1" name="txtenm" value="<%=eventnm%>" readonly="true">
                    </div>
               
                <div class="form-group col-md-6 mb-3">
                    <label for="inputsubject">Event Charges</label>
                    <input type="text" class="form-control mt-1"  name="txtecharges" value="<%=eventcharges%>" readonly="true">
                </div>
               <div class="form-group col-md-6 mb-3">
                        <label for="inputname">Event Date</label>
                        <input type="date" class="form-control mt-1"  name="txtedate" value="" >
                    </div>
                    <div class="form-group col-md-6 mb-3">
                        <label for="inputemail">Event Time</label>
                        <input type="text" class="form-control mt-1"  name="txtetime" value="" >
                    </div>
                
               <div class="form-group col-md-6 mb-3">
                    <label for="inputsubject">QR Code</label>
                    <img class="img-fluid" src="img/qr.jpg" alt="" width="100px" height="100px">
                </div>
             
                <div class="row">
                    <div class="col text-end mt-2">
                        <button type="submit" class="btn btn-success btn-lg px-3">Book</button>
                    </div>
                      </div>
                 </div>
                </div>
                                    <%
                    String bdate1=request.getParameter("txtbdate");
                    String rnm1=request.getParameter("txtnm");   
                    String mob1=request.getParameter("txtmno");
                    String eventnm1=request.getParameter("txtenm");
                    String eventcharges1=request.getParameter("txtecharges");
                    String edate1=request.getParameter("txtedate");
                    String etime1=request.getParameter("txtetime");

                    Statement st1=con.createStatement();

                    if(bdate1!=null && bdate1!="" && 
                       rnm1!=null && rnm1!="" && 
                       mob1!=null && mob1!="" && 
                       eventnm1!=null && eventnm1!="" && 
                       eventcharges1!=null && eventcharges1!="" && 
                       edate1!=null && edate1!="" && 
                       etime1!=null && etime1!="")
                    {

                    String check="select * from bookingevent where edate='"+edate1+"'";

                    ResultSet rscheck=st1.executeQuery(check);

                    if(rscheck.next())
                    {
                        out.println("<script>alert('Event already booked on this date')</script>");
                    }
                    else
                    {

                    String str1="insert into bookingevent(bid,bdate,rname,mob,ename,echarges,edate,etime)values("+i+",'"+bdate1+"','"+rnm1+"','"+mob1+"','"+eventnm1+"',"+eventcharges1+",'"+edate1+"','"+etime1+"')";

                    int a=st1.executeUpdate(str1);

                    out.println("<script>alert('Event Booking is successfully done..')</script>");

                    }

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