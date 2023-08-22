<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
<%@ page import="java.time.LocalDate" %>
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
	String targetDt = request.getParameter("targetDt")==null?oneWeekAgoDate:request.getParameter("targetDt");				//조회일자
	String itemPerPage = request.getParameter("itemPerPage")==null?"10":request.getParameter("itemPerPage");			//결과row수
	String multiMovieYn = request.getParameter("multiMovieYn")==null?"":request.getParameter("multiMovieYn");			//“Y” : 다양성 영화 “N” : 상업영화 (default : 전체)
	String repNationCd = request.getParameter("repNationCd")==null?"K":request.getParameter("repNationCd");				//“K: : 한국영화 “F” : 외국영화 (default : 전체)
	String wideAreaCd = request.getParameter("wideAreaCd")==null?"":request.getParameter("wideAreaCd");					//“0105000000” 로서 조회된 지역코드
	String weekGb = request.getParameter("weekGb")==null?"":request.getParameter("weekGb");								//“0” : 주간 (월~일), “1” : 주말 (금~일) (default), “2” : 주중 (월~목)

    %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="resources/js/KobisOpenAPIRestService.js"></script>
<script type="text/javascript">
$(function(){
	var kobisService = new KobisOpenAPIRestService("343599b683251114d746f16b8725dbc0");
	var resJson = null;
	try{
		resJson = kobisService.getWeeklyBoxOffice(true,{targetDt:"<%=targetDt%>",itemPerPage:"<%=itemPerPage%>",multiMovieYn:"<%=multiMovieYn%>",repNationCd:"<%=repNationCd%>",wideAreaCd:"<%=wideAreaCd%>",weekGb:"<%=weekGb%>"});
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
</head>
<body>
	<div id="titleInfo">
		<p></p>
		<p></p>
	</div>
	<table border="1" id="boxtab">
		<tbody>
		<tr>
			<td>순위</td><td>영화명</td><td>개봉일</td><td>매출액</td><td>매출액점유율</td><td>매출액증감(전일대비)</td>
			<td>누적매출액</td><td>관객수</td><td>관객수증감(전일대비)</td><td>누적관객수</td><td>스크린수</td><td>상영횟수</td>
		</tr>
		</tbody>
	</table>
	<form action="">
		일자:<input type="text" name="targetDt" value="<%=targetDt %>">
		최대 출력갯수:<input type="text" name="itemPerPage" value="<%=itemPerPage %>">
		영화구분:<select name="multiMovieYn">
			<option value="">-전체-</option>
			<option value="Y"<c:if test="${param.multiMovieYn eq 'Y'}"> selected="seleted"</c:if>>다양성영화</option>
			<option value="N"<c:if test="${param.multiMovieYn eq 'N'}"> selected="seleted"</c:if>>상업영화</option>
		</select>
		국적:<select name="repNationCd">
			<option value="">-전체-</option>
			<option value="K"<c:if test="${param.repNationCd eq 'K'}"> selected="seleted"</c:if>>한국</option>
			<option value="F"<c:if test="${param.repNationCd eq 'F'}"> selected="seleted"</c:if>>외국</option>
			</select>
		지역:<select name="wideAreaCd">
			<option value="">-전체-</option>
			</select>
		주간/주말구분:<select name="weekGb">
			<option value="1"<c:if test="${param.weekGb eq '1'}"> selected="seleted"</c:if>> 주말 </option>
			<option value="0"<c:if test="${param.weekGb eq '0'}"> selected="seleted"</c:if>> 주간 </option>
			<option value="2"<c:if test="${param.weekGb eq '2'}"> selected="seleted"</c:if>> 주중 </option>
			</select>
			<br/>
			<input type="submit" name="" value="조회">
	</form>
</body>
</html>