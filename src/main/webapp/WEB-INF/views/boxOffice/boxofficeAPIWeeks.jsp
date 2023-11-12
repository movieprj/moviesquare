<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page
   import="kr.or.kobis.kobisopenapi.consumer.rest.KobisOpenAPIRestService"%>
<%@page import="org.codehaus.jackson.map.ObjectMapper"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Collection"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="net.sf.json.util.JSONBuilder"%>
<%@page import="net.sf.json.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.time.LocalDate"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!--
------------------------------------------------------------
* @설명 : 주간 박스오피스 REST 호출 - 자바스크립트로 호출하는 방식 예제
* NOTE : 본 예제와 같이 자바스크립트로 직접 호출하는 경우 발급키가 공개되므로 서버호출 방식을 권장합니다.
------------------------------------------------------------
-->
    <%
    // 파라메터 설정
    // String todayDate =LocalDate.now().toString().replace("-", "");
    String oneWeekAgoDate = LocalDate.now().minusDays(7).toString().replace("-", ""); //당일 날짜로 셋팅했을 때는 금주 조회 데이터가 안 나오기 때문에 일주일 전으로 날짜를 셋팅했습니다.
   String targetDt = request.getParameter("targetDt")==null?oneWeekAgoDate:request.getParameter("targetDt");            //조회일자
   String itemPerPage = request.getParameter("itemPerPage")==null?"10":request.getParameter("itemPerPage");       //결과row수
   String multiMovieYn = request.getParameter("multiMovieYn")==null?"":request.getParameter("multiMovieYn");         //“Y” : 다양성 영화 “N” : 상업영화 (default : 전체)
   String repNationCd = request.getParameter("repNationCd")==null?"K":request.getParameter("repNationCd");           //“K: : 한국영화 “F” : 외국영화 (default : 전체)
   String wideAreaCd = request.getParameter("wideAreaCd")==null?"":request.getParameter("wideAreaCd");               //“0105000000” 로서 조회된 지역코드
   String weekGb = request.getParameter("weekGb")==null?"":request.getParameter("weekGb");                        //“0” : 주간 (월~일), “1” : 주말 (금~일) (default), “2” : 주중 (월~목)

    %>
<html lang="en">
   <head>
      <!-- basic -->
      <meta charset="utf-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <!-- mobile metas -->
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <meta name="viewport" content="initial-scale=1, maximum-scale=1">
      <!-- site metas -->
      <title>무비플라자 : 영화관순위</title>
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
      <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script><![endif]-->
      <style>
         /* Default styles */
      table {
            width: 100%;
      }

      th {
            padding: 5px;
      }

      td {
            padding: 5px;
            white-space: nowrap; /* Prevent line breaks */
      }

      .centered-form {
            text-align: center;
      }

      .centered-form .form-group {
            margin-bottom: 0; /* form-group's bottom margin */
      }

      /* Media query for screens larger than 768px */
      @media (min-width: 769px) {
         table {
            width: 80%; /* Adjust the width as needed */
         }
      }

      /* Media query for screens larger than 992px */
      @media (min-width: 993px) {
         table {
            width: 60%; /* Adjust the width as needed */
         }
      }

      /* Media query for screens larger than 1200px */
      @media (min-width: 1201px) {
         table {
            width: 40%; /* Adjust the width as needed */
         }
      }
      </style>
   </head>
   <script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="resources/js/KobisOpenAPIRestService.js"></script>
<script type="text/javascript">
$(function(){
   var kobisService = new KobisOpenAPIRestService("343599b683251114d746f16b8725dbc0");
   var resJson = null;
   try{
      resJson = kobisService.getWeeklyBoxOffice(true,{targetDt:"<%=targetDt%>", weekGb:"<%=weekGb%>"});
   }catch(e){
      resJson = $.parseJSON(e.message);
   }
   if(resJson.failInfo){
      alert(resJson.failInfo.message);
   }else{
      var boxofficeList = resJson.boxOfficeResult.weeklyBoxOfficeList;
      var boxofficeType = resJson.boxOfficeResult.boxofficeType;
      var showRange = resJson.boxOfficeResult.showRange;
      var yearWeekTime = resJson.boxOfficeResult.yearWeekTime;
      for(var i=0;i<boxofficeList.length;i++){
         var boxoffice = boxofficeList[i];
         console.log(boxoffice);
         $("#titleInfo p:eq(0)").html(boxofficeType);
         $("#titleInfo p:eq(1)").html(showRange+" / "+yearWeekTime.substring(0,4)+"년"+yearWeekTime.substring(4,6)+"주차");
         $("#boxtab tbody").append("<tr><td>"+boxoffice.rank+"</td><td>"+boxoffice.movieNm+"</td><td>"+boxoffice.openDt+"</td><td>"+boxoffice.salesAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')+"</td><td>"+boxoffice.salesShare+"</td><td>"+boxoffice.salesInten.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')+"/"+boxoffice.salesChange+"</td><td>"+boxoffice.salesAcc.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')+"</td><td>"+boxoffice.audiCnt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')+"</td><td>"+boxoffice.audiInten.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')+"/"+boxoffice.audiChange+"</td><td>"+boxoffice.audiAcc.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')+"</td><td>"+boxoffice.scrnCnt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')+"</td><td>"+boxoffice.showCnt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')+"</td></tr>");
      }
   }

   var resJson = null;
   try{
      resJson = kobisService.getComCodeList(true,{comCode:"0105000000"});
   }catch(e){
      resJson = $.parseJSON(e.message);
   }

   if(!resJson.failInfo){
      var codes = resJson.codes;
      for(var i=0;i<codes.length;i++){
         var code = codes[i];
         console.log(code);
         var selected = "";
         if('<%=wideAreaCd%>'==code.fullCd){
            selected = " selected='selected'";
         }
         $("select[name=wideAreaCd]").append("<option value='"+code.fullCd+"'"+selected+">"+code.korNm+"</option>");
      }
   }
});
</script>

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
                  <div class=" col-md-2 col-sm-3 col logo_section">
                     <div class="full">
                        <div class="center-desk">
                           <div class="logo">
                        <a style="color: white; font-size: 20px;" href="main.do">MoviePlaza</a>
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
                              <li> <a href="login.html"> Login </a></li>
                              <li> <a href="snsjoin.html"> SNSJoin </a></li>
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
      <!-- portfolio -->
      <div class="portfolio">
         <div class="container">
            <div class="row">
               <div class="col-md-12">
                  <div class="titlepage text_align_left">
                     <h2>영화관순위</h2>
                  </div>
               </div>
            </div>
            <div class="row">
               <div class="col-md-6">
                 <div id="titleInfo">
      <p></p>
      <p></p>
   </div>
   <div class="table-container">
      <table border="2" id="boxtab" >
         <tbody>
         <tr>
            <td>순위</td><td>영화명</td><td>개봉일</td><td>매출액</td><td>매출액점유율</td><td>매출액증감(전일대비)</td>
            <td>누적매출액</td><td>관객수</td><td>관객수증감(전일대비)</td><td>누적관객수</td><td>스크린수</td><td>상영횟수</td>
         </tr>
         </tbody>
      </table>
   </div>
   
	</div>
	<div class="container mt-4">
   <div class="row">
      <div class="col-md-6 offset-md-3">
         <form action="" class="centered-form text-center"
								onsubmit="return fetchData();">
            <div class="form-row">
               <div class="form-group col-md-6">
                  <label for="targetDt">일자 :</label>
                  <input type="text" name="targetDt" id="targetDt" value="<%=targetDt%>" class="form-control">
               </div>

               <div class="form-group col-md-6">
                  <label for="weekGb">주간/주말구분 :</label>
                  <select name="weekGb" id="weekGb" class="form-control">
                     <option value="1"<c:if test="${param.weekGb eq '1'}"> selected="selected"</c:if>> 주말 </option>
                     <option value="0"<c:if test="${param.weekGb eq '0'}"> selected="selected"</c:if>> 주간 </option>
                     <option value="2"<c:if test="${param.weekGb eq '2'}"> selected="selected"</c:if>> 주중 </option>
                  </select>
               </div>
            </div>

            <div class="form-group">
               <input type="submit" name="" class="read_more btn btn-primary" value="조회">
            </div>
         </form>
      </div>
   </div>
</div>

         </div>
               
         </div>
      </div>
      <!-- end portfolio -->
            <!-- footer -->
            <footer>
               <div class="footer">
                  <div class="container">
                     <div class="row">
                        <div class="col-md-3 col-sm-6">
                           <div class="Informa helpful">
                              <h3>Useful  Link</h3>
                              <ul>
                                 <li><a href=main.do>Home</a></li>
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
                        </div>
                     </div>
                  </div>
               </div>
            </footer>
            <!-- end footer -->
      <!-- Javascript files-->
      <script>
		function fetchData() {
			// 폼에서 입력한 날짜 가져오기
			var targetDt = document.getElementById("targetDt").value;

			// 현재 날짜 가져오기
			var currentDate = new Date();
			currentDate.setDate(currentDate.getDate() - 7); // 하루 전 날짜

			// 입력한 날짜를 날짜 객체로 변환
			var inputYear = parseInt(targetDt.substring(0, 4), 10);
			var inputMonth = parseInt(targetDt.substring(4, 6), 10) - 1; // JavaScript의 월은 0부터 시작하므로 1을 빼줌
			var inputDay = parseInt(targetDt.substring(6, 8), 10);
			var inputDate = new Date(inputYear, inputMonth, inputDay);

			if (inputDate < currentDate) {
				// 오늘 날짜 일주일 이전인 경우
				return true; // 조회 실행
			} else {
				// 오늘 날짜 포함해서 이후인 경우
				alert("오늘 날짜 기준으로 일주일 전 데이터가 최신 데이터입니다. 다시 입력해주세요. ex) 20230101");
				return false; // 조회 취소
			}
		}
	</script>
	
	
	
      <script src="resources/js/jquery.min.js"></script>
      <script src="resources/js/bootstrap.bundle.min.js"></script>
      <script src="resources/js/jquery-3.0.0.min.js"></script>
      <script src="resources/js/custom.js"></script>
   </body>
</html>