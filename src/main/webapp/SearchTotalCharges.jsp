<%-- 
    Document   : SearchTotalCharges
    Created on : 11 Feb, 2025, 3:08:15 PM
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

    <script language="javascript">
        function editRecord(id)
        {
            var f= document.form;
            f.method="post";
            f.action='PayCharges.jsp?srno='+id;
            f.submit();
            
        }
        </script>
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
            <h1 class="h1">Search Total Charges</h1>
          
        </div>
    </div>

   

    <!-- Start Contact -->
    <div class="container py-5">
               
        <div class="row py-5">
            <form class="col-md-9 m-auto" method="post" name="form">
                <div class="row">
                    
                    <div class="form-group col-md-6 mb-3">
                        <label for="inputemail">Month</label>
                        <input type="text" class="form-control mt-1"  name="txtmon" value="" >
                    </div>
                     <div class="form-group col-md-6 mb-3">
                        <label for="inputemail">Year</label>
                        <input type="text" class="form-control mt-1"  name="txtyear" value="" >
                    </div>
                </div>
                 
               
                <div class="row">
                    <div class="col text-end mt-2">
                        <button type="submit" class="btn btn-success btn-lg px-3" >Search</button>
                    </div>
                </div>
                <table>
                     <tr><td width="100px" align="center" height="20px" style="border: medium solid #000;" >Srno</td>
                        <td width="100px" align="center"  style="border: medium solid #000;">Month</td>
                        <td width="100px" align="center"  style="border: medium solid #000;">Year</td>
                        <td width="100px" align="center"  style="border: medium solid #000;">Electricity charges</td>
                        <td width="100px" align="center"  style="border: medium solid #000;">Maintenance Charges</td>
                         <td width="100px" align="center"  style="border: medium solid #000;"></td>
                    </tr>
                 
                   <%
                    int srno=0;
                    String month=request.getParameter("txtmon");
                    String year=request.getParameter("txtyear");
                    int elecharges=0;
                    int maincharges=0;
                   Statement st=con.createStatement();
                   String str="select * from commoncharges where month='"+month+"' and year='"+year+"'";
                   ResultSet rs=st.executeQuery(str);
                   while(rs.next())
                   {
                       srno=rs.getInt(1);
                       month=rs.getString(2);
                       year=rs.getString(3);
                       elecharges=rs.getInt(4);
                       maincharges=rs.getInt(5);
                  
                   %>
                  
                   <tr><td width="100px" align="center" style="border: medium solid #000;" ><%=srno%></td>
                       <td width="100px" align="center" style="border: medium solid #000;" ><%=month%></td>
                       <td width="100px" align="center" style="border: medium solid #000;" ><%=year %></td>
                       <td width="100px" align="center" style="border: medium solid #000;" ><%=elecharges%></td>
                       <td width="100px" align="center" style="border: medium solid #000;" ><%=maincharges%></td> 
                       <td align="center" style="border: medium solid #000;"><input type="button" name="Pay" value="Pay"style="background-color: cornflowerblue;font-weight: bold;color: white;font-size: larger;"onclick="editRecord(<%=rs.getInt(1)%>)"/></td>
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