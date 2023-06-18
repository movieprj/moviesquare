<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<!-- basic -->
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<!-- mobile metas -->
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="viewport" content="initial-scale=1, maximum-scale=1">
	<!-- site metas -->
	<title>hightech</title>
	<meta name="keywords" content="">
	<meta name="description" content="">
	<meta name="author" content="">
	<!-- bootstrap css -->
	<link rel="stylesheet" href="resources/css/bootstrap.min.css">
	<!-- style css -->
	<link rel="stylesheet" href="resources/css/style.css">
	<!-- responsive-->
	<link rel="stylesheet" href="resources/css/responsive.css">
	<!-- awesome fontfamily -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body class="main-layout inner_page">
      <!-- loader  -->
      <div class="loader_bg">
         <div class="loader"><img src="resources/images/loading.gif" alt="" /></div>
      </div>
      <!-- end loader -->
      <!-- header -->
      <header>
         <div class="header">
            <div class="container-fluid">
               <div class="row d_flex">
                  <div class=" col-md-2 col-sm-3 col logo_section">
                     <div class="full">
                        <div class="center-desk">
                           <div class="logo">
                              <a href="main.do"><img src="resources/images/logo.png" alt="#" /></a>
                           </div>
                        </div>
                     </div>
                  </div>
                  <div class="col-md-8 col-sm-9">
                     <nav class="navigation navbar navbar-expand-md navbar-dark ">
                        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExample04" aria-controls="navbarsExample04" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse" id="navbarsExample04">
                           <ul class="navbar-nav mr-auto">
                              <li class="nav-item">
                                 <a class="nav-link" href="main.do">Home</a>
                              </li>
                              <li class="nav-item active">
                                 <a class="nav-link" href="about.do">About</a>
                              </li>

                              <li class="nav-item">
                                 <a class="nav-link" href="contactus.do">Contact Us</a>
                              </li>
                           </ul>
                        </div>
                     </nav>
                  </div>
                  <div class="col-md-2 d_none">
                     <ul class="email text_align_right">
                        <c:if test="${ empty sessionScope.loginMember }">			
							<li> <a href="loginPage.do"> Login </a></li>
					  	</c:if>
					  	<c:if test="${ !empty sessionScope.loginMember }">			
                        	<li> <a href="logout.do"> Logout </a></li>
                        </c:if>
                        <li> <a href="enrollPage.do"> 회원가입 </a></li>
                        <li> <a href="Javascript:void(0)"> <i class="fa fa-search" style="cursor: pointer;" aria-hidden="true"> </i></a> </li>
                     </ul>
                  </div>
               </div>
            </div>
         </div>
      </header>
      <!-- end header -->
      <!-- about -->
      <div class="about">
         <div class="container">
            <div class="row">
               <div class="col-md-12">
                  <div class="titlepage text_align_center">
                     <h2>About Company</h2>
                     <p>There are many variations of passages of Lorem Ipsum available, but the majority have </p>
                  </div>
               </div>
            </div>
         </div>
      </div>
      <!-- end about -->
      <!-- footer -->
      <footer>
         <div class="footer">
            <div class="container">
               <div class="row">
                  <div class="col-md-3">
                     <a class="logo_footer" href="main.do"><img src="resources/images/logo_footer.png" alt="#" /></a>
                  </div>
                  <div class="col-md-9">
                     <form class="newslatter_form">
                        <input class="ente" placeholder="Enter your email" type="text" name="Enter your email">
                        <button class="subs_btn">Sbscribe Now</button>
                     </form>
                  </div>
                  <div class="col-md-3 col-sm-6">
                     <div class="Informa helpful">
                        <h3>Useful  Link</h3>
                        <ul>
                           <li><a href="main.do">Home</a></li>
                           <li><a href="about.do">About</a></li>
                           <li><a href="contact.do">Contact us</a></li>
                        </ul>
                     </div>
                  </div>
                  <div class="col-md-3 col-sm-6">
                     <div class="Informa">
                        <h3>News</h3>
                        <ul>
                           <li>It is a long established                            
                           </li>
                           <li>fact that a reader will                           
                           </li>
                           <li>be distracted by the                           
                           </li>
                           <li>readable content of a                              
                           </li>
                           <li>page when                          
                           </li>
                        </ul>
                     </div>
                  </div>
                  <div class="col-md-3 col-sm-6">
                     <div class="Informa">
                        <h3>company</h3>
                        <ul>
                           <li>It is a long established                             
                           </li>
                           <li>fact that a reader will                            
                           </li>
                           <li>be distracted by the                          
                           </li>
                           <li>readable content of a                              
                           </li>
                           <li>page when                          
                           </li>
                        </ul>
                     </div>
                  </div>
                  <div class="col-md-3 col-sm-6">
                     <div class="Informa conta">
                        <h3>contact Us</h3>
                        <ul>
                           <li> <a href="Javascript:void(0)"> <i class="fa fa-map-marker" aria-hidden="true"></i> Location
                              </a>
                           </li>
                           <li> <a href="Javascript:void(0)"><i class="fa fa-phone" aria-hidden="true"></i> Call +01 1234567890
                              </a>
                           </li>
                           <li> <a href="Javascript:void(0)"> <i class="fa fa-envelope" aria-hidden="true"></i> demo@gmail.com
                              </a>
                           </li>
                        </ul>
                     </div>
                  </div>
               </div>
            </div>
            <div class="copyright text_align_left">
               <div class="container">
                  <div class="row d_flex">
                     <div class="col-md-6">
                        <p>© 2020 All Rights Reserved.  <a href="https://html.design/"> Free Html Template</a></p>
                     </div>
                     <div class="col-md-6">
                        <ul class="social_icon text_align_center">
                           <li> <a href="Javascript:void(0)"><i class="fa fa-facebook-f"></i></a></li>
                           <li> <a href="Javascript:void(0)"><i class="fa fa-twitter"></i></a></li>
                           <li> <a href="Javascript:void(0)"><i class="fa fa-linkedin-square" aria-hidden="true"></i></a></li>
                           <li> <a href="Javascript:void(0)"><i class="fa fa-instagram" aria-hidden="true"></i></a></li>
                           <li> <a href="Javascript:void(0)"><i class="fa fa-youtube-play" aria-hidden="true"></i></a></li>
                        </ul>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </footer>
      <!-- end footer -->
      <!-- Javascript files-->
      <script src="resources/js/jquery.min.js"></script>
      <script src="resources/js/bootstrap.bundle.min.js"></script>
      <script src="resources/js/jquery-3.0.0.min.js"></script>
      <script src="resources/js/custom.js"></script>
   </body>
</html>