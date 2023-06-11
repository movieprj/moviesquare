<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript">
	$(function() {
	    var adminFail = "${adminFail}";
	    console.log(adminFail);
	    if (adminFail) {
	        alert("Fail message: " + adminFail);
	    }
	});
</script>
</head>
<body>
<!-- 관리자 페이지 로그인 -->
	<c:if test="${ !empty admin }">
		<form action="adminLogin.do" method="post">
			<div class="">
				<h3 align="center"
					style="font-family: 'Noto Sans KR', sans-serif; font-size: 40px">로그인
					페이지</h3>
				<br>
				<div class="">
					<input class="id" type="text" name="m_email" id="m_email"
						placeholder="*관리자 아이디를 입력해주세요." required><br>
				</div>
				<div class="">
					<input class="pwd" type="password" name="m_pw" id="m_pw" required><br>
				</div>
				<div>
					<input class="submit" type="submit" value="로그인">&nbsp;<a
						id="mainmove" href="main.do">시작페이지</a>
				</div>
			</div>
		</form>
	</c:if>
	<c:if test="${ empty admin }">
		<form action="login.do" method="post">
			<div class="">
				<h3 align="center"
					style="font-family: 'Noto Sans KR', sans-serif; font-size: 40px">로그인
					페이지</h3>
				<br>
				<div class="">
					<input class="id" type="text" name="m_email" id="m_email"
						placeholder="*이메일을 입력해주세요." required><br>
				</div>
				<div class="">
					<input class="pwd" type="password" name="m_pw" id="m_pw" required><br>
				</div>
				<div>
					<input class="submit" type="submit" value="로그인">&nbsp;<a
						id="mainmove" href="main.do">시작페이지</a>
				</div>
			</div>
		</form>
		<form action="kakaoLogin.do" method="get">
			<a class="kakao"
				href="https://kauth.kakao.com/oauth/authorize?client_id=5cb3fc356b2936bfab1a6ac9666cccfa&redirect_uri=http://127.0.0.1:8080/moviesquare/kakaoLogin.do&response_type=code">
				<div class="kakao_i"></div>
				<div class="kakao_txt">카카오톡으로 간편로그인</div>
			</a>
		</form>
		<form action="googleLogin.do" method="get">
			<a class="google"
				href="/moviesquare/googleLogin.do">
				<div>구글로그인</div>
			</a>
		</form>
		<form action="naverLogin.do" method="get">
			<a class="naver"
				href="/moviesquare/naverLogin.do">
				<div>네이버로그인</div>
			</a>
		</form>
	</c:if>
</body>
</html>