<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="resources/css/login/login.css" type="text/css">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="viewport" content="initial-scale=1, maximum-scale=1">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript">
	function kakaoLogin() {
	    window.location.href = "https://kauth.kakao.com/oauth/authorize?client_id=5cb3fc356b2936bfab1a6ac9666cccfa&redirect_uri=http://127.0.0.1:8080/moviesquare/kakaoLogin.do&response_type=code";
	}
	function naverLogin() {
	    window.location.href = "/moviesquare/naverLogin.do";
	}
	function googleLogin() {
	    window.location.href = "/moviesquare/googleLogin.do";
	}
</script>
<style>
	.sothumb {
	    width: 400px;
	    height: 38px;
	}
</style>
</head>
<body>
	<c:if test="${ !empty admin }">
		<form action="adminLogin.do" method="post">
			<div class="wrap">
				<div class="login">
					<h3 style="font-size:50px; 	font-family: 'Noto Sans KR', sans-serif;">관리자 페이지</h3><br>
					<a href="main.do">
						<h3 style="font-size:50px; 	font-family: 'Noto Sans KR', sans-serif;">MoviePlaza</h3>
					</a>
					<!--이메일 입력-->
					<div class="login_id">
						<h4 style="	font-family: 'Noto Sans KR', sans-serif;">이메일</h4>
						<input type="text" name="m_email" id="m_email" class="pos" placeholder="*관리자 아이디" required>
					</div>
					<!--비밀번호 입력-->
					<div class="login_pw">
						<h4 style="	font-family: 'Noto Sans KR', sans-serif;">비밀번호</h4>
						<input type="password" name="m_pw" class="pos" placeholder="*비밀번호" id="m_pw" required>
					</div>
					<!--로그인 버튼-->
					<div class="submit">
						<input style="	font-family: 'Noto Sans KR', sans-serif;" type="submit" value="로그인">
					</div>
				</div>
			</div>
		</form>
	</c:if>
	<c:if test="${ empty admin }">
		<form action="login.do" method="post">
			<div class="wrap">
				<div class="login">
					<a href="main.do">
						<h3 style="font-size:50px; 	font-family: 'Noto Sans KR', sans-serif;">MoviePlaza</h3>
					</a>
					<!--이메일 입력-->
					<div class="login_id">
						<h4 style="	font-family: 'Noto Sans KR', sans-serif;">이메일</h4>
						<input type="text" name="m_email" id="m_email" class="pos" placeholder="*Email(이메일)" required>
					</div>
					<!--비밀번호 입력-->
					<div class="login_pw">
						<h4 style="	font-family: 'Noto Sans KR', sans-serif;">비밀번호</h4>
						<input type="password" name="m_pw" class="pos" placeholder="*비밀번호" id="m_pw" required>
					</div>
					<!--로그인 버튼-->
					<div class="submit">
						<input style="	font-family: 'Noto Sans KR', sans-serif;" type="submit" value="로그인">
					</div>
					<br>
					
					
					<!--아이디 찾기-->
	                <div class="loginmenu">
	                    <div class="schid">
	                        <c:url var="mvfindId" value="/moveIdRecovery.do" />
	                        <a href="idfind.html">
	                            <p style="font-family: 'Noto Sans KR', sans-serif;">아이디찾기</p>
	                        </a>
	                    </div>
	                    <span style="margin-top: 8px;">|</span>
	                <!--비밀번호 찾기-->
	                <div class="schpw">
	                    <c:url var="mvfindPwd" value="/movePwdRecovery.do" />
	                    <a href="pwfind.html">
	                        <p style="  font-family: 'Noto Sans KR', sans-serif;">비밀번호찾기</p>
	                    </a>
	                </div>
	                <!--비밀번호 찾기-->
	                <span style="margin-top: 8px;">|</span>
	                <div class="schpw">
	                    <c:url var="mvfindPwd" value="/movePwdRecovery.do" />
	                    <a href="pwfind.html">
	                        <p style="  font-family: 'Noto Sans KR', sans-serif;">회원가입</p>
	                    </a>
	                </div>
	                </div>
					
					
					
					<!-- 
						<div class="loginmenu">
							<div class="schid">
								<c:url var="mvfindId" value="/moveIdRecovery.do" />
								<a href="idfind.html">
									<p style="font-family: 'Noto Sans KR', sans-serif;">아이디 찾기</p>
								</a>
							</div>
							<span style="margin-top: 8px;">|</span>
							<div class="schpw">
								<c:url var="mvfindPwd" value="/movePwdRecovery.do" />
								<a href="pwfind.html">
									<p style="	font-family: 'Noto Sans KR', sans-serif;">비밀번호 찾기</p>
								</a>
							</div>
						</div>
					 -->
					<br>
					<!--카카오 로그인 -->
					<div id="kakao_id_login" class="kakao_id_login" style="text-align: center">
						<a href="#" class="cp" onclick="kakaoLogin()">
							<img class="sothumb" src="resources/images/kakao_login_medium_wide.png" alt="카카오로그인">
						</a>
					</div>
					<!-- 네이버 로그인 -->
					<div id="ndfin" style="text-align:center">
						<a href="#" id='.cp_naver' onclick="naverLogin()">
							<img class="sothumb" src="resources/images/naver.png" alt="네이버로그인">
						</a>
					</div>
					<!--  구글 로그인 -->
					<div style="height : 60px">
	                    <a href="#" id='.cp_naver' onclick="googleLogin()">
							<img class="sothumb" src="" alt="구글로그인">
						</a>
	                </div>
			</div>
		</form>
	</c:if>
</body>
</html>