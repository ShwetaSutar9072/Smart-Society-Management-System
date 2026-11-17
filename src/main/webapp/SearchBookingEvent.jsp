<%-- 
    Document   : SearchBookingEvent
    Created on : 11 Feb, 2025, 12:17:49 PM
    Author     : HP
--%>

<%@include file="dbconnection.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <title> </title>
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
                            <a class="nav-link" href="EventInfo.jsp">Event</a>
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
            <h1 class="h1">Search Booking Event</h1>
          
        </div>
    </div>

   

    <!-- Start Contact -->
    <div class="container py-5">
               
        <div class="row py-5">
             <form method="post">
        <div class="form-group col-md-4">
            <label>Select Date</label>
            <input type="date" class="form-control" name="txtbdate">
        </div>

        <br>

        <button type="submit" class="btn btn-success">Search</button>
    </form>

    <br><br>

    <!-- TABLE -->
    <table class="table table-bordered">

        <tr>
            <th>Pay Id</th>
            <th>Date</th>
            <th>Name</th>
            <th>Mobile</th>
            <th>Event</th>
            <th>Charges</th>
            <th>Event Date</th>
            <th>Event Time</th>
        </tr>

<%
String bdate = request.getParameter("txtbdate");

int bid = 0;
String rnm = "";
String mob = "";
String eventnm = "";
int eventcharges = 0;
String edate = "";
String etime = "";

if (bdate != null && !bdate.equals(""))
{
    Statement st = con.createStatement();

    String sql = "select * from bookingevent where bdate='" + bdate + "'";

    ResultSet rs = st.executeQuery(sql);

    boolean found = false;

    while (rs.next())
    {
        found = true;

        bid = rs.getInt(1);
        bdate = rs.getString(2);
        rnm = rs.getString(3);
        mob = rs.getString(4);
        eventnm = rs.getString(5);
        eventcharges = rs.getInt(6);
        edate = rs.getString(7);
        etime = rs.getString(8);
%>

        <tr>
            <td><%=bid%></td>
            <td><%=bdate%></td>
            <td><%=rnm%></td>
            <td><%=mob%></td>
            <td><%=eventnm%></td>
            <td><%=eventcharges%></td>
            <td><%=edate%></td>
            <td><%=etime%></td>
        </tr>

<%
    }

    if (!found)
    {
%>
        <tr>
            <td colspan="8" class="text-center text-danger">
                No records found for selected date
            </td>
        </tr>
<%
    }
}
else
{
%>
    <tr>
        <td colspan="8" class="text-center text-primary">
            Please select a date and click search
        </td>
    </tr>
<%
}
%>

    </table>

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