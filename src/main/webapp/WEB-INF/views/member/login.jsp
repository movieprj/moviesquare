<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<form action="login.do" method="post">
		<div class="">
			<h3 align="center" style="font-family: 'Noto Sans KR', sans-serif; font-size : 40px">로그인 페이지</h3><br>
			<div class="">
				<input class="id" type="text" name="m_id" id="m_id" placeholder="*아이디를 입력해주세요." required><br>
			</div>
			<div class="">
				<input class="pwd" type="password" name="m_pw" id="m_pw" required><br>
			</div>
			<div>
				<input class="submit" type="submit" value="가입하기">&nbsp;<a id="mainmove" href="main.do">시작페이지</a>
			</div>
		</div>
</form>
</body>
</html>