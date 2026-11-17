<%-- 
    Document   : viewsuggestion
    Created on : 22 Feb, 2025, 11:30:28 AM
    Author     : HP
--%>



<%@include file="dbconnection.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <title> view suggestion</title>
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
                            <a class="nav-link" href="SearchSubscription.jsp">Subscription</a>
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
            <h1 class="h1">View Suggestion</h1>
          
        </div>
    </div>

   

    <!-- Start Contact -->
    <div class="container py-5">
               
        <div class="row py-5">
            <form class="col-md-9 m-auto" method="post" name="form">
                <div class="row">
                    
                  
                <table>
                    <tr><td width="100px" align="center" height="20px" style="border: medium solid #000;" >Guide</td>
                        <td width="100px" height=30px" align="center" style=" border: medium solid #000;">Name</td>
                         <td width="100px" height=30px" align="center" style=" border: medium solid #000;">Mobile No.</td>
                        <td width="100px" height="30px" align="center" style=" border: medium solid #000;">Message</td>
                          
                    </tr>
                <%
                              
                             String guide=null;
                             String rnm1=null;
                             String mob1=null;
                             String message=null;
                     Statement st=con.createStatement();         
                    String str="select * from guidance";
                    ResultSet rs=st.executeQuery(str);
                   while(rs.next())
                   {
                           
                           guide=rs.getString(1);
                           rnm1=rs.getString(2);
                           mob1=rs.getString(3);
                           message=rs.getString(4);
                    
                   %>
                   
                
                   
                   <tr><td width="100px" align="center" style="border: medium solid #000;" ><%=guide%></td>
                       <td width="100px" align="center" style="border: medium solid #000;" ><%=rnm1%></td>
                       <td width="100px" align="center" style="border: medium solid #000;" ><%=mob1%></td>
                       <td width="100px" align="center" style="border: medium solid #000;" ><%=message%></td>
                       
                      
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