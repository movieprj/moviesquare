<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<!-- basic -->
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<!-- mobile metas -->
	    <meta name="viewport" content="width=device-width, initial-scale=1">
	    <meta name="viewport" content="initial-scale=1, maximum-scale=1">
		<title>MoviePlaza</title>
		<meta name="keywords" content="">
        <meta name="description" content="">
        <meta name="author" content="">
        <!-- bootstrap css -->
        <link rel="stylesheet" href="resources/css/bootstrap.min.css">
        <!-- style css -->
        <link rel="stylesheet" href="resources/css/style.css">
        <!--login.css-->
        <link rel="stylesheet" href="resources/css/login.css">
        <!--snslogin.css-->
        <link rel="stylesheet" href="resources/css/snslogin.css">
        <!--login.css-->
        <link rel="stylesheet" href="resources/css/idfind.css">      
        <!-- responsive-->
        <link rel="stylesheet" href="resources/css/responsive.css">
        <!-- awesome fontfamily -->
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	</head>
	<body class="main-layout">
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
                              <a style="color : white; font-size: 20px;" href="main.do">MoviePlaza</a>
                           </div>
                        </div>
                     </div>
                  </div>
                  <div class="col-md-9 col-sm-9">
                     <nav class="navigation navbar navbar-expand-md navbar-dark ">
                        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExample04" aria-controls="navbarsExample04" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse" id="navbarsExample04">
                           <ul class="navbar-nav mr-auto">
                              <li class="nav-item active">
                                 <a class="nav-link" href="workdb.html">작품DB</a>
                              </li>
                              <li class="nav-item">
                                 <a class="nav-link" href="trendany.html">트렌드분석</a>
                              </li>
                              <li class="nav-item">
                                 <a class="nav-link" href="movierank.html">영화관순위</a>
                              </li>
                              <li class="nav-item">
                                 <a class="nav-link" href="ottrank.html">OTT순위 </a>
                              </li>
                              <li class="nav-item">
                                 <a class="nav-link" href="contactus.do">Contact Us</a>
                              </li>
                           </ul>
                           <ul class="email text_align_right">
							  <c:if test="${ empty sessionScope.loginMember }">			
								<li> <a href="loginPage.do"> Login </a></li>
							  </c:if>
							  <c:if test="${ !empty sessionScope.loginMember }">			
                                <li> <a href="logout.do"> Logout </a></li>
                              </c:if>
                              <li> <a href="enrollPage.do"> 회원가입 </a></li>
                              <li> <a class="search-switch" href="Javascript:void(0)"> <i class="fa fa-search" style="cursor: pointer;" aria-hidden="true"> </i></a> </li>
                           </ul>
                        </div>
                     </nav>
                  </div>
               </div>
            </div>
         </div>
      </header>
      <!-- end header -->
      <!-- start slider section -->
      <div id="top_section" class=" banner_main">
         <div class="container">
            <div class="row">
               <div class="col-md-12">
                  <div id="myCarousel" class="carousel slide" data-ride="carousel">
                     <ol class="carousel-indicators">
                        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                        <li data-target="#myCarousel" data-slide-to="1"></li>
                        <li data-target="#myCarousel" data-slide-to="2"></li>
                        <li data-target="#myCarousel" data-slide-to="3"></li>
                     </ol>
                     <div class="carousel-inner">
                        <div class="carousel-item active">
                           <div class="container-fluid">
                              <div class="carousel-caption relative">
                                 <!--백그라운드이미지 바꿔야함-->
                                 <div class="bluid">
                                    <h1>영화에 대한 모든 것.  <br>All About The “Movie”</h1>            
                                 </div>
                              </div>
                           </div>
                        </div>
                        <div class="carousel-item">
                           <div class="container-fluid">
                              <div class="carousel-caption relative">
                                 <div class="bluid">
                                    <h1>Creative  <br>Work Idea </h1>
                                    <p>There are many variations of passages of Lorem Ipsum <br>available, but the majority have suffered alteration
                                    </p>
                                    <a class="read_more" href="about.do">About Company </a><a class="read_more" href="contactus.do">Contact </a>
                                 </div>
                              </div>
                           </div>
                        </div>
                        <div class="carousel-item">
                           <div class="container-fluid">
                              <div class="carousel-caption relative">
                                 <div class="bluid">
                                    <h1>Creative  <br>Work Idea </h1>
                                    <p>There are many variations of passages of Lorem Ipsum <br>available, but the majority have suffered alteration
                                    </p>
                                    <a class="read_more" href="about.do">About Company </a><a class="read_more" href="contactus.do">Contact </a>
                                 </div>
                              </div>
                           </div>
                        </div>
                        <div class="carousel-item">
                           <div class="container-fluid">
                              <div class="carousel-caption relative">
                                 <div class="bluid">
                                    <h1>Creative  <br>Work Idea </h1>
                                    <p>There are many variations of passages of Lorem Ipsum <br>available, but the majority have suffered alteration
                                    </p>
                                    <a class="read_more" href="about.do">About Company </a><a class="read_more" href="contactus.do">Contact </a>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>
                     <a class="carousel-control-prev" href="#myCarousel" role="button" data-slide="prev">
                     <i class="fa fa-angle-left" aria-hidden="true"></i>
                     <span class="sr-only">Previous</span>
                     </a>
                     <a class="carousel-control-next" href="#myCarousel" role="button" data-slide="next">
                     <i class="fa fa-angle-right" aria-hidden="true"></i>
                     <span class="sr-only">Next</span>
                     </a>
                  </div>
               </div>
            </div>
         </div>
      </div>
      	<!-- Search Begin -->
	<div class="search-model">
		<div class="h-100 d-flex align-items-center justify-content-center">
			<div class="search-close-switch">+</div>
			<form class="search-model-form">
				<input type="text" id="search-input" placeholder="Search here.....">
			</form>
		</div>
	</div>
	<!-- Search End -->
      <!-- end slider section -->
      <!-- we_do -->
      <div class="we_do">
         <div class="container">
            <div class="row">
               <div class="col-md-12">
                  <div class="titlepage text_align_center">
                     <h2>Service</h2>
                  </div>
               </div>
            </div>
            <div class="row">
               <div class="col-md-12">
                  <div id="we1" class="carousel slide" data-ride="carousel">
                     <ol class="carousel-indicators">
                        <li data-target="#we1" data-slide-to="0" class="active"></li>
                        <li data-target="#we1" data-slide-to="1"></li>
                        <li data-target="#we1" data-slide-to="2"></li>
                        <li data-target="#we1" data-slide-to="3"></li>
                     </ol>
                     <div class="carousel-inner">
                        <div class="carousel-item active">
                           <div class="container-fluid">
                              <div class="carousel-caption we1_do">
                                 <div class="row">
                                    <div class="col-md-4">
                                       <div id="bo_ho" class="we_box text_align_left">
                                          <i><img src="resources/images/we1.png" alt="#"/></i>
                                          <h3>작품DB</h3>
                                          <p>many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which
                                          </p>
                                          <a class="read_more" href="we_do">Read More</a>
                                       </div>
                                    </div>
                                    <div class="col-md-4">
                                       <div id="bo_ho" class="we_box text_align_left">
                                          <i><img src="resources/images/we1.png" alt="#"/></i>
                                          <h3>트렌드분석</h3>
                                          <p>many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which
                                          </p>
                                          <a class="read_more" href="we_do">Read More</a>
                                       </div>
                                    </div>
                                    <div class="col-md-4">
                                       <div id="bo_ho" class="we_box text_align_left">
                                          <i><img src="resources/images/we1.png" alt="#"/></i>
                                          <h3>OTT순위 </h3>
                                          <p>many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which
                                          </p>
                                          <a class="read_more" href="we_do">Read More</a>
                                       </div>
                                    </div>
                                 </div>
                              </div>
                           </div>
                        </div>
                        <div class="carousel-item">
                           <div class="container-fluid">
                              <div class="carousel-caption we1_do">
                                 <div class="row">
                                    <div class="col-md-4">
                                       <div id="bo_ho" class="we_box text_align_left">
                                          <i><img src="resources/images/we1.png" alt="#"/></i>
                                          <h3>영화관순위</h3>
                                          <p>many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which
                                          </p>
                                          <a class="read_more" href="we_do">Read More</a>
                                       </div>
                                    </div>
                                    <div class="col-md-4">
                                       <div id="bo_ho" class="we_box text_align_left">
                                          <i><img src="resources/images/we1.png" alt="#"/></i>
                                          <h3>추가할꺼있음ㄱ</h3>
                                          <p>many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which
                                          </p>
                                          <a class="read_more" href="we_do">Read More</a>
                                       </div>
                                    </div>
                                    <div class="col-md-4">
                                       <div id="bo_ho" class="we_box text_align_left">
                                          <i><img src="resources/images/we1.png" alt="#"/></i>
                                          <h3>추가할꺼있음ㄱ</h3>
                                          <p>many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which
                                          </p>
                                          <a class="read_more" href="we_do">Read More</a>
                                       </div>
                                    </div>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>
                     <a class="carousel-control-prev" href="#we1" role="button" data-slide="prev">
                     <i class="fa fa-angle-left" aria-hidden="true"></i>
                     <span class="sr-only">Previous</span>
                     </a>
                     <a class="carousel-control-next" href="#we1" role="button" data-slide="next">
                     <i class="fa fa-angle-right" aria-hidden="true"></i>
                     <span class="sr-only">Next</span>
                     </a>
                  </div>
               </div>
            </div>
         </div>
      </div>
      <!-- end we_do -->
      <!-- footer -->
      <footer>
         <div class="footer">
            <div class="container">
               <div class="row">
                  <div class="col-md-3 col-sm-6">
                     <div class="Informa helpful">
                        <h3>Useful  Link</h3>
                        <ul>
                           <li><a href="main.do">Home</a></li>
                           <li><a href="workdb.html">작품DB</a></li>
                           <li><a href="trendany.html">트렌드분석</a></li>
                           <li><a href="movierank.html">영화관순위</a></li>
                           <li><a href="ottrank.html">OTT순위</a></li>
                           <li><a href="contactus.do">Contact us</a></li>
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
                        <p>© 2023. MoviePlaza All Rights Reserved.</p>
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
      <script defer src="resources/js/jquery.min.js"></script>
      <script defer src="resources/js/bootstrap.bundle.min.js"></script>
      <script defer src="resources/js/jquery-3.0.0.min.js"></script>
      <script defer src="resources/js/custom.js"></script>
   </body>
</html>