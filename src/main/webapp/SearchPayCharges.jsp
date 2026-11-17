<%@include file="dbconnection.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>
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
                             <a class="nav-link"  href="viewsuggestion.jsp">ViewSuggestion</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="Adminviewservice.jsp">ServiceBooking</a>
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
            <h1 class="h1">View Paid Charges</h1>
          
        </div>
    </div>

   

    <!-- FORM -->
    <form method="post">

        <div class="form-group col-md-4">
            <label>Select Date</label>
            <input type="date" class="form-control" name="txtdate">
        </div>

        <br>

        <button type="submit" class="btn btn-success">Search</button>
    </form>

    <br><br>

    <!-- TABLE -->
    <table class="table table-bordered">

        <tr>
            <th>Pay ID</th>
            <th>Date</th>
            <th>Name</th>
            <th>Mobile</th>
            <th>Sr No</th>
            <th>Month</th>
            <th>Year</th>
            <th>Electric Charges</th>
            <th>Maintenance Charges</th>
            <th>Total</th>
        </tr>

<%
String inputDate = request.getParameter("txtdate");

int i = 0;
String rnm = "";
String mob = "";
String month = "";
String year = "";
int srno = 0;
int echarges = 0;
int mcharges = 0;
int tot = 0;

if(inputDate != null && !inputDate.equals(""))
{
    Statement st = con.createStatement();

    // IMPORTANT: use backticks for DATE column OR rename column
    String sql = "select * from paycharges where `date`='" + inputDate + "'";

    ResultSet rs = st.executeQuery(sql);

    boolean found = false;

    while(rs.next())
    {
        found = true;

        i = rs.getInt(1);
        String dbDate = rs.getString(2);  // DO NOT overwrite input date
        rnm = rs.getString(3);
        mob = rs.getString(4);
        srno = rs.getInt(5);
        month = rs.getString(6);
        year = rs.getString(7);
        echarges = rs.getInt(8);
        mcharges = rs.getInt(9);
        tot = rs.getInt(10);
%>

<tr>
    <td><%=i%></td>
    <td><%=dbDate%></td>
    <td><%=rnm%></td>
    <td><%=mob%></td>
    <td><%=srno%></td>
    <td><%=month%></td>
    <td><%=year%></td>
    <td><%=echarges%></td>
    <td><%=mcharges%></td>
    <td><%=tot%></td>
</tr>

<%
    }

    if(!found)
    {
%>
<tr>
    <td colspan="10" style="text-align:center; color:red;">
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
    <td colspan="10" style="text-align:center; color:blue;">
        Please select a date
    </td>
</tr>
<%
}
%>
    </table>

</div>

</body>
</html>