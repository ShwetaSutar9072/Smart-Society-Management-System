<%-- 
    Document   : viewregistration
    Created on : 22 Feb, 2025, 11:29:19 AM
    Author     : HP
--%>

<%@include file="dbconnection.jsp" %>

<%
String sr=request.getParameter("srno");

if(sr!=null)
{
    Statement st2=con.createStatement();

    String qry="update registration set status='Approved' where srno="+sr;

    st2.executeUpdate(qry);
}
%>

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

    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;200;300;400;500;700;900&display=swap">
    <link rel="stylesheet" href="css/fontawesome.min.css">
</head>

<body>

    <!-- Header -->
    <nav class="navbar navbar-expand-lg navbar-light shadow">
        <div class="container d-flex justify-content-between align-items-center">

            <a class="navbar-brand text-success logo h1 align-self-center" href="index.html">
              Smart Society
            </a>

            <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#templatemo_main_nav">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="align-self-center collapse navbar-collapse flex-fill d-lg-flex justify-content-lg-between" id="templatemo_main_nav">
                <div class="flex-fill">
                    <ul class="nav navbar-nav d-flex justify-content-between mx-lg-auto">

                        <li class="nav-item">
                             <a class="nav-link" href="AdminHomePage.jsp">Home</a>
                        </li>

                        <li class="nav-item">
                             <a class="nav-link" href="viewsuggestion.jsp">ViewSuggestion</a>
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

        </div>
    </nav>

    <!-- Title -->
    <div class="container-fluid bg-light py-5">
        <div class="col-md-6 m-auto text-center">
            <h1 class="h1">View Registration</h1>
        </div>
    </div>

    <!-- Table -->
    <div class="container py-5">

        <div class="row py-5">

            <form class="col-md-12 m-auto" method="post" name="form">

                <table border="1" width="100%">

                    <tr>

                        <td align="center">Sr No</td>
                        <td align="center">Name</td>
                        <td align="center">Address</td>
                        <td align="center">Mobile No</td>
                        <td align="center">Email</td>
                        <td align="center">Status</td>
                        <td align="center">Action</td>

                    </tr>

                    <%

                    int srno=0;
                    String rnm=null;
                    String add=null;
                    String mob=null;
                    String email=null;

                    Statement st=con.createStatement();

                    String str="select * from registration";

                    ResultSet rs=st.executeQuery(str);

                    while(rs.next())
                    {
                        srno=rs.getInt(1);
                        rnm=rs.getString(2);
                        add=rs.getString(3);
                        mob=rs.getString(4);
                        email=rs.getString(5);

                        String status=rs.getString("status");

                    %>

                    <tr>

                        <td align="center"><%=srno%></td>
                        <td align="center"><%=rnm%></td>
                        <td align="center"><%=add%></td>
                        <td align="center"><%=mob%></td>
                        <td align="center"><%=email%></td>

                        <td align="center">
                            <%=status%>
                        </td>

                        <td align="center">

                        <%
                        if(status.equals("Pending"))
                        {
                        %>

                        <a href="viewregistration.jsp?srno=<%=srno%>">
                            Approve
                        </a>

                        <%
                        }
                        else
                        {
                            out.println("Approved");
                        }
                        %>

                        </td>

                    </tr>

                    <%
                    }
                    %>

                </table>

            </form>

        </div>

    </div>

</body>

</html>