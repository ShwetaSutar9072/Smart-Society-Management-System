<%-- 
    Document   : Smartcorecleaningservices
    Created on : 12 Jan, 2025, 2:06:53 PM
    Author     : HP
--%>


<%@include file="dbconnection.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Utility services</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/templatemo.css">
    <link rel="stylesheet" href="css/custom.css">

    <!-- Load fonts style after rendering the layout styles -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;200;300;400;500;700;900&display=swap">
    <link rel="stylesheet" href="css/fontawesome.min.css">
   <link rel="stylesheet" href="css/main2.css">
   
   
</head>

<body>
    
    <!-- Header -->
    <nav class="navbar navbar-expand-lg navbar-light shadow">
        <div class="container d-flex justify-content-between align-items-center">

            <a class="navbar-brand text-success logo h1 align-self-center" href="ResidentHomepage.jsp">
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
                <div class="navbar align-self-center d-flex">
                    <div class="d-lg-none flex-sm-fill mt-3 mb-4 col-7 col-sm-auto pr-3">
                       
                    </div>
                   
                    
                </div>
            </div>

        </div>
    </nav>
    <!-- Close Header -->

    


    <!-- Start Banner Hero -->
    <div id="template-mo-zay-hero-carousel" class="carousel slide" data-bs-ride="carousel">
       
       
                <div class="container">
                    <div class="row p-5">
                        <div class="mx-auto col-md-8 col-lg-6 order-lg-last">
                            <img class="img-fluid" src="./img/cleaning1.jpg" alt="">
                        </div>
                        <div class="col-lg-6 mb-0 d-flex align-items-center">
                            <div class="text-align-left align-self-center">
                                <h1 class="h1 text-success"><b>Smart</b> Core Cleaning Services</h1>
                                <h3 class="h2"></h3>
                                <p>
                              Our comprehensive Society Smart Core Cleaning Services solution will cover:

                                <ol>
                                    <li>Residential Cleaning</li>
                                    <li>Commercial Cleaning</li>
                                    <li>Specialized Cleaning</li>
                                   
                                </ol>
                            </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
             <div class="input-group-text btn-success text-light" align="center"><tr><td width="400px" align="center"><a href="payment2.jsp">Subscription</a></div>


    <!-- Start Categories of The Month -->
    <section class="container py-5">
        <div class="row text-center pt-3">
            <div class="col-lg-6 m-auto">
                <h1 class="h1">Contact us</h1>
                
                
            </div>
        </div>
        <table
          <tr>
                        <td width="100px" align="center"  style="border: medium solid #000;">Service</td>
                        <td width="100px" align="center"  style="border: medium solid #000;">Provider name</td>
                        <td width="100px" align="center"  style="border: medium solid #000;">Address</td>
                        <td width="100px" align="center"  style="border: medium solid #000;">Mobile no.</td>
                    </tr>
        
                   <%
                   
                    String snm="Smart Core Cleaning Services";
                    String pnm=null;
                    String add=null;
                    String mob=null;
                   Statement st=con.createStatement();
                   String str="select * from otherservices where servicename='"+snm+"'";
                   ResultSet rs=st.executeQuery(str);
                   while(rs.next())
                   {
                      
                       snm=rs.getString(2);
                       pnm=rs.getString(3);
                       add=rs.getString(4);
                       mob=rs.getString(5);
                       
                  %>
                   <tr>
                       <td width="100px" align="center" style="border: medium solid #000;" ><%=snm%></td>
                       <td width="100px" align="center" style="border: medium solid #000;" ><%=pnm %></td>
                       <td width="100px" align="center" style="border: medium solid #000;" ><%=add%></td>
                       <td width="100px" align="center" style="border: medium solid #000;" ><%=mob%></td> 
                       
            </tr>
            <%
            }
                   %>
        </table>

   

    <!-- Start Footer -->
    <!-- <footer class="bg-dark" id="tempaltemo_footer">
        <div class="container">
           
            <div class="row text-light mb-4">
                <div class="col-12 mb-3">
                    <div class="w-100 my-3 border-top border-light"></div>
                </div>
                
                <div class="col-auto">
                    <label class="sr-only" for="subscribeEmail">Email address</label>
                    <div class="input-group mb-2">
                        <input type="text" class="form-control bg-dark border-light" id="subscribeEmail" placeholder="Email address">
                        <div class="input-group-text btn-success text-light">Subscribe</div>
                    </div>
                </div>
            </div>
        </div>

       
    </footer> -->
    <!-- End Footer -->

    <!-- Start Script -->
    <script src="assets/js/jquery-1.11.0.min.js"></script>
    <script src="assets/js/jquery-migrate-1.2.1.min.js"></script>
    <script src="assets/js/bootstrap.bundle.min.js"></script>
    <script src="assets/js/templatemo.js"></script>
    <script src="assets/js/custom.js"></script>
    <!-- End Script -->
</body>

</html>