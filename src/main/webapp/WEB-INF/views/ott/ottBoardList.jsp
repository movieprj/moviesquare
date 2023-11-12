<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">

<head>
  <!-- basic -->
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <!-- mobile metas -->
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <meta name="viewport" content="initial-scale=1, maximum-scale=1" />
  <!-- site metas -->
  <title>무비플라자 : OTT순위</title>
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <meta name="author" content="" />
  <!-- bootstrap css -->
  <link rel="stylesheet" href="resources/css/bootstrap.min.css" />
  <!-- style css -->
  <link rel="stylesheet" href="resources/css/style.css" />
  <!-- responsive-->
  <link rel="stylesheet" href="resources/css/responsive.css" />
  <!-- awesome fontfamily -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
  <link rel="stylesheet" href="resources/css/ottrank.css" />
   <script type="text/javascript"
   src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.1.min.js"></script>
  <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script
    ><![endif]-->
</head>
<!-- body -->

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
          <div class="col-md-2 col-sm-3 col logo_section">
            <div class="full">
              <div class="center-desk">
                <div class="logo">
                  <a style="color: white; font-size: 20px;" href="main.do">MoviePlaza</a>
                </div>
              </div>
            </div>
          </div>
          <div class="col-md-9 col-sm-9">
            <nav class="navigation navbar navbar-expand-md navbar-dark">
              <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExample04"
                aria-controls="navbarsExample04" aria-expanded="false" aria-label="Toggle navigation">
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
                              <a class="nav-link" href="movierankDays.do">일별영화관순위</a>
                              <a class="nav-link" href="movierankWeeks.do">주간별영화관순위</a>
                           </li>
                           <li class="nav-item">
                              <a class="nav-link" href="ottBoardList.do">OTT순위 </a>
                           </li>
                  <li class="nav-item">
                    <a class="nav-link" href="contact.html">Contact Us</a>
                  </li>
                </ul>
                <ul class="email text_align_right">
                  <li><a href="login.html"> Login </a></li>
                  <li><a href="snsjoin.html"> SNSJoin </a></li>
                  <li>
                    <a class="search-switch" href="Javascript:void(0)">
                      <i class="fa fa-search" style="cursor: pointer" aria-hidden="true">
                      </i></a>
                  </li>
                </ul>
              </div>
            </nav>
          </div>
        </div>
      </div>
    </div>
  </header>
  <!-- end header -->
  <!-- Search Begin -->
  <div class="search-model">
    <div class="h-100 d-flex align-items-center justify-content-center">
      <div class="search-close-switch">+</div>
      <form class="search-model-form">
        <input type="text" id="search-input" placeholder="Search here....." />
      </form>
    </div>
  </div>
  <!-- Search End -->
  <!-- we_do -->
  <div class="we_do">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <div class="titlepage2 text_align_center">
            <h2>OTT순위</h2>
          </div>
      
      	 <!-- OTT 순위 박스 4개 Start (Netflix, WATCHA, Tving, wavve)-->
          <div class="movie-box">
           
            <!-- Netflix Start -->
            <div class="movie-ott" id="cardNetflix">
              <div class="movie-ott-top">
                <p class="tm">TOP MOVIES</p>
                <p class="ot">Netflix</p>
              </div>
              <div class="movie-img">
                <img src="resources/images/m_poster.jpeg" alt="1등사진">
              </div>
              <div class="movie-list">
                <ul>
                	<c:forEach items="${ottList}" var="ott" >
                		<c:if test="${ott.ott_name eq 'netflix' }"> 
                			<a href="ottranktable.html">
                    			<li>
                        			<span class="margin-2">${ott.ott_movierank}. </span> 
                        			${ott.ott_moviename}
                    			</li>
                			</a>
                			</c:if>
            		</c:forEach>                
                </ul>
              </div>
            </div>
            <!-- Netflix End -->
            
            <!-- WATCHA Start -->
            <div class="movie-ott" id="cardWatcha">
              <div class="movie-ott-top">
                <p class="tm">TOP MOVIES</p>
                <p class="ot">WATCHA</p>
              </div>
              <div class="movie-img">
                <img src="resources/images/m_poster2.jpeg" alt="1등사진">
              </div>
              <div class="movie-list">
                <ul>
                  <c:forEach items="${ottList}" var="ott" >
                		<c:if test="${ott.ott_name eq 'watcha' }"> 
                			<a href="ottranktable.html">
                    			<li>
                        			<span class="margin-2">${ott.ott_movierank}. </span> 
                        			${ott.ott_moviename}
                    			</li>
                			</a>
                		</c:if>
            		</c:forEach>            
                </ul>
              </div>
            </div>
            <!-- WATCHA End -->
            
            <!-- Tving Start -->
            <div class="movie-ott" id="cardTving">
              <div class="movie-ott-top">
                <p class="tm">TOP MOVIES</p>
                <p class="ot">Tving</p>
              </div>
              <div class="movie-img">
                <img src="resources/images/m_poster3.webp" alt="1등사진">
              </div>
              <div class="movie-list">
                <ul>
                  <c:forEach items="${ottList}" var="ott" >
                		<c:if test="${ott.ott_name eq 'tving' }"> 
                			<a href="ottranktable.html">
                    			<li>
                        			<span class="margin-2">${ott.ott_movierank}. </span> 
                        			${ott.ott_moviename}
                    			</li>
                			</a>
                		</c:if>
            		</c:forEach>            
                </ul>
              </div>
            </div>
            <!-- Tving End -->
            
            <!-- wavve Start -->
            <div class="movie-ott" id="cardWavve">
              <div class="movie-ott-top">
                <p class="tm">TOP MOVIES</p>
                <p class="ot">wavve</p>
              </div>
              <div class="movie-img">
                <img src="resources/images/poster.jpeg" alt="1등사진">
              </div>
              <div class="movie-list">
                <ul>
                  <c:forEach items="${ottList}" var="ott" >
                		<c:if test="${ott.ott_name eq 'wavve' }"> 
                			<a href="ottranktable.html">
                    			<li>
                        			<span class="margin-2">${ott.ott_movierank}. </span> 
                        			${ott.ott_moviename}
                    			</li>
                			</a>
                		</c:if>
            		</c:forEach>            
                </ul>
              </div>
            </div>
            <!-- wavve End -->
          </div>
          <!-- OTT 순위 박스 4개 End -->
          
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
              <h3>Useful Link</h3>
              <ul>
                        <li><a href="main.do">Home</a></li>
                        <li><a href="workdb.html">작품DB</a></li>
                        <li><a href="trendany.html">트렌드분석</a></li>
                        <li><a href="movierankDays.do">일별영화관순위</a></li>
                     <li><a href="movierankWeeks.do"">주간별영화관순위</a></li>
                     <li><a href="ottBoardList.do">OTT순위</a></li>
                        <li><a href="contact.html">Contact us</a></li>
                     </ul>
            </div>
          </div>
          <div class="col-md-3 col-sm-6">
            <div class="Informa conta">
              <h3>contact Us</h3>
              <ul>
                <li> <a href="Javascript:void(0)"> <i class="fa fa-map-marker" aria-hidden="true"></i>
                    Location
                  </a>
                </li>
                <li> <a href="Javascript:void(0)"><i class="fa fa-phone" aria-hidden="true"></i> Call +01
                    1234567890
                  </a>
                </li>
                <li> <a href="Javascript:void(0)"> <i class="fa fa-envelope" aria-hidden="true"></i>
                    demo@gmail.com
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
                <li> <a href="Javascript:void(0)"><i class="fa fa-linkedin-square" aria-hidden="true"></i></a>
                </li>
                <li> <a href="Javascript:void(0)"><i class="fa fa-instagram" aria-hidden="true"></i></a></li>
                <li> <a href="Javascript:void(0)"><i class="fa fa-youtube-play" aria-hidden="true"></i></a>
                </li>
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