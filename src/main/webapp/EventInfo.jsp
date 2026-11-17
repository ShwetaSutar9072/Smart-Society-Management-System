<%-- 
    Document   : EventInfo
    Created on : 10 Feb, 2025, 8:42:09 PM
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
                            <a class="nav-link" href="CommonCharges.jsp">Charges</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="SearchBookingEvent.jsp"> Booking Event</a>
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
            <h1 class="h1"> Add Event</h1>
          
        </div>
    </div>

   

    <!-- Start Contact -->
    <div class="container py-5">
         <%
                     int i=0;
                     Statement st=con.createStatement();
                     String str="select count(*)from addevent";
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
                        <label for="inputname">Event id</label>
                        <input type="text" class="form-control mt-1" name="txtsrno" value="<%=i%>" readonly="true">
                    </div>
                    <div class="form-group col-md-6 mb-3">
                        <label for="inputemail">Event Name</label>
                        <br>
                        <select name="drpevent">
                         
                         <option>Birthday/Anniversary</option>
                         <option>Festival Party</option>
                         <option>Naming Ceremony</option>
                         <option>Conference</option>
                         <option>Others</option>
                     </select>
                    </div>
                      
                
                 <div class="form-group col-md-6 mb-3">
                    <label for="inputsubject">Event Charges</label>
                    <input type="text" class="form-control mt-1" name="txtecharges" value="" >
                </div>
              
                
                <div class="row">
                    <div class="col text-end mt-2">
                        <button type="submit" class="btn btn-success btn-lg px-3">Add</button>
                    </div>
                      </div>
                 </div>
                </div>
                <%
                             String eventnm=request.getParameter("drpevent");
                             String eventcharges=request.getParameter("txtecharges");
                             
                        
                             Statement st1=con.createStatement();
                             if(eventnm!=null && eventnm!="" && eventcharges!=null && eventcharges!="" )
                             {
                              String str1="insert into addevent(eventid,eventname,eventcharges)values("+i+",'"+eventnm+"','"+eventcharges+"')";   
                               int a=st1.executeUpdate(str1);
                               out.println("<script>alert('your Event is added..')</script>");
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