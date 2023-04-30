<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OTT 게시판</title>
<script type="text/javascript"
	src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.1.min.js"></script>

</head>
<body>
	<h1 align="center">OTT 인기 TOP 10순위</h1>
	<table align="center" cellspacing="0" cellpadding="3"
		style="margin: 0 auto; border-collapse: collapse; border-top: 3px solid #f8f9fa;">
		<tr>
			<th>OTT명</th>
			<th>영화순위</th>
			<th>영화이름</th>
			<th>OTT크롤링날짜</th>
		</tr>

		<c:forEach items="${ottList}" var="ott">
            <tr>
                <td>${ott.ott_name}</td>
                <td>${ott.ott_movierank}</td>
                <td>${ott.ott_moviename}</td>
                <td>${ott.ott_date}</td>
            </tr>
        </c:forEach>

	</table>
</body>
</html>