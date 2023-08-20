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
		<form action="findId.do">
	        <div class="wrap">
	            <div class="login">
	
	                <h3 style="	font-family: 'Noto Sans KR', sans-serif; font-size : 40px">아이디 찾기</h3>
	                <div class="login_pw">
	                    <input type="name" name="m_name" placeholder="회원님의 이름을 입력해주세요" required>
	                    <br>
	                    <input type="date" class="bttn2" value="male" name="m_birthday" id="m_birthday" required> <span id="birthdaystauts"></span>
						<br>
	                    <div class="wid2">
	                        <input class="wid" type="submit" value="아이디찾기">
	                        <input class="wid" onclick="location='main.do'" value="홈으로">
	                    </div>
	                </div>
	            </div>
	        </div>
    	</form>
	</body>
</html>