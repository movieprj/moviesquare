<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1>무비광장</h1>
	<br><br><br><br><br>
	
	
	<div>
		<button onclick="javascript:location.href='enrollPage.do';">회원가입</button>
		<button onclick="javascript:location.href='loginPage.do';">로그인</button>
		<c:if test="${ !empty sessionScope.loginMember }">
			<button onclick="javascript:location.href='logout.do';">로그아웃</button>
		</c:if>
	</div>
</body>
</html>