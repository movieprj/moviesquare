<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
	    <meta name="viewport" content="initial-scale=1, maximum-scale=1">
	    <link rel="stylesheet" href="resources/css/login/idfind.css" type="text/css">
	</head>
	<body>
		<!-- 아이디가 존재하면 -->
		<c:if test="${ FindResult eq '1' }">
			<c:forEach items="${ requestScope.find_mail }" var="m">
				<h1> 아이디는 : ${ m.m_email } 입니다.</h1>
				<br>
			</c:forEach>
			
		</c:if>
		<!-- 아이디가 없다면 -->
		<c:if test="${ FindResult eq '0' }">
			<h1> ${ requestScope.msg } </h1>
		</c:if>
		<br>
		<button>
			<a href = "main.do">메인화면으로 이동</a>
		</button>
	</body>
</html>