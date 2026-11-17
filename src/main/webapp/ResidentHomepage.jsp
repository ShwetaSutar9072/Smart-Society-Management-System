<%-- 
    Document   : clienthome
    Created on : 7 Jan, 2025, 9:42:27 PM
    Author     : HP
--%>



<%@include file="dbconnection.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" type="text/css" href="demo1.css">
    <link rel="stylesheet" type="text/css" href="css/new3.css">
</head>
<body>
    <%
         String unm=(String)session.getAttribute("unm1");
        
    %>
<header>
        <div class="main">
        <div class="container">
        <nav>
            <ul>
               <li><h1 style="color: #69bb7e">Smart Society</h1></li>
               <li ><a href="Mainhome.jsp">Home<br></a></li>
                <li><a href="SearchTotalCharges.jsp">Search Charges</a></li>
                <li><a href="SearchService.jsp">Services</a></li>                
                <li><a href="SearchEvent.jsp">Event</a></li>
                <li><a href="Suggestion.jsp">Feedback</a></li>
                <li><a href="logout.jsp">Logout</a></li>
          
                <%--
    <div class="dropdown">
    <button class="dropbtn">Account
      <i class="fa fa-caret-down"></i>
    </button>
    <div class="dropdown-content">
      <a href="#"><%=unm%></a>
      <a href="logout.jsp">Logout</a>
  
    </div>
  </div>
  --%>
    </ul>
        </nav>
        </div>
        </div>
            <p><%=unm%></p>
        <div class="title">
             <h3 align="center">We help you to make your Society - Smarter and Well Managed</h3>
            <h1 align="center">SMART SOCIETY UTILITIES</h1>
            
        </div>
      
</header>

    <br><br><br>
   
    <!--about us-->
    <div class="title4"><h1 align="center">MAKE SOCIETY DIGITAL & PAPERLESS</h1></div>
    <div class="about">
        
    <div class="about-section">
        <div class="inner-container">
            <h1>Benefit of our Website</h1>
            <p class="text">“Managing residential societies using these Online society management solutions keep all concerned people aware of the events. With sophisticated Email and SMS alerts, instant notification, and contact and document management modules; members discover it convenient and fast.”</p>
        </div>
    </div>
    </div>
    <div class="news">
       <marquee><h2> Happy Communities are made of Delightful Resident Experiences! Here's the website Devoted to it!</h2></marquee>
    </div>
<!--</about-->

<div class="Gallery">
        <div class="title2">
            <br>
            <h1 align="center">Services</h1><br><br>
        </div>
       
   <div class="box"><img src="img/security.jpg"> <a class="destination-overlay text-white text-decoration-none">
            <h2 class="text-white" align="center">SECURITY</h2>
    </a></div>
    
    <div class="box"><img src="img/cleaning.jpg">  <a class="destination-overlay text-white text-decoration-none" >
                            <h2 class="text-white" align="center">CLEANING</h2>
    </a></div>
    
    <div class="box"><img src="img/water.jpg"> <a class="destination-overlay text-white text-decoration-none">
                            <h2 class="text-white" align="center">WATER AND PLUMBING</h2>
    </a></div>
    <br><br><br>
    <div class="box"><img src="img/electricity.jpg"> <a class="destination-overlay text-white text-decoration-none">
                              <h2 class="text-white" align="center">ELECTRICITY</h2>
    </a></div>
    
    <div class="box"><img src="img/event.jpg"> <a class="destination-overlay text-white text-decoration-none">
                            <h2 class="text-white" align="center">EVENTS</h2>
    </a></div>
    
    <div class="box"><img src="img/others.jpg"> <a class="destination-overlay text-white text-decoration-none">
                            <h2 class="text-white" align="center">OTHER SERVICES</h2>
    </a></div>
 </div>
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>


<div class="Yojana">
<div class="title3">
        <p class="text"><h3 align="centre"><b>As soon as you refuse to accept the change, you fail!
        You must choose smart society management software to keep your society running smoothly with the lowest effort.
        If you are looking for the best solution, our website might be the right choice. 
        Our website incorporates each necessary feature and keeps upgrading itself as per the requirement.
        Now you can manage the entire society with just a few clicks using this website.</b></h3></p>
       

</div>
</div> 
<br><br><br><br><br>
<!--footer start-->
<div class="footer" style="color: black;">
    <marquee> <p class="design">Designed By:</marquee>
</div>
</body>
</html>


