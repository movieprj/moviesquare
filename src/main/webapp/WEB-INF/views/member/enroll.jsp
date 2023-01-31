<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
//입력된 아이디가 중복되지 않았는지 확인
function dupCheckId() {
	const idchkMsg = $('#idDupCheckMsg');
	idMinLength = document.getElementById("m_id").value.length;
	if (idMinLength < 4) {
		idchkMsg.html("아이디는 최소 5자 이상이어야 합니다.");
		idchkMsg.css('color', 'red');
	}else{
		$.ajax({
			url : "idcheck.do",
			type : "post",
			data : {
				m_id : $("#m_id").val()
			},
			success : function(data) {
				console.log("sucess : " + data);
				if (data == "ok") {
					idchkMsg.html("사용 가능한 아이디입니다.");
					idchkMsg.css('color', 'green');
				} else {
					idchkMsg.html("이미 가입된 회원의 아이디입니다.");
					idchkMsg.css('color', 'red');
					$("#m_id").select();
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				console.log("error : " + jqXHR + ", " + textStatus + ", "
						+ errorThrown);
			}
		});
	}
}
//비밀번호 확인
function dupCheckPw(){
	var pwdLength = $("#m_pw").val().length;
	if(pwdLength<8 || pwdLength>15)
	{
		$("#pwdMsg").text("비밀번호 글자수 제한 8~15자");
		$("#pwdMsg").css('color', 'red');
	}else{
		$("#pwdMsg").text("비밀번호 사용 가능");
		$("#pwdMsg").css('color', 'green');
	}
}
//비밀번호 일치 확인
function verifyPWD(){
	var p1 = $("#m_pw").val();
	var p2 = $("#v_pw").val();
	if(p1==p2)
	{
		$("#vPwdMsg").text("일치합니다.");
		$("#vPwdMsg").css('color', 'green');
	}else{
		$("#vPwdMsg").text("다시 확인해 주세요");
		$("#vPwdMsg").css('color', 'red');
	}
}
//닉네임 확인
function dupCheckNick() {
	$.ajax({
		url : "nickcheck.do",
		type : "post",
		data : {
			m_nickname : $("#m_nickname").val()
		},
		success : function(data) {
			console.log("sucess : " + data);
			if (data == "ok") {
				$("#nickMsg").text("사용 가능한 닉네임입니다.");
				$("#nickMsg").css('color', 'green');
			} else {
				$("#nickMsg").text("사용중인 닉네임입니다.");
				$("#nickMsg").css('color', 'red');
				$("#m_nickname").select();
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log("error : " + jqXHR + ", " + textStatus + ", "
					+ errorThrown);
		}
	});
}
</script>
</head>
<body>
<form action="" method="post" onsubmit="return validate();">
		<div class="">
			<div class="">
				<h3 align="center" style="font-family: 'Noto Sans KR', sans-serif; font-size : 40px">회원 가입 페이지</h3><br>
				<div class="">
					<input class="id" type="text" name="m_id" id="m_id" oninput="dupCheckId();" placeholder="*아이디를 입력해주세요." required><br>
					 <span id="idDupCheckMsg"></span>
				</div>
				<div class="">
					<input class="pwd" type="password" name="m_pw" id="m_pw" oninput="dupCheckPw();" placeholder="*비밀번호를 입력해주세요." required><br>
					 <span id="pwdMsg"></span>
				</div>
				<div class="">
					<input class="vpwd" type="password" name="v_pw" id="v_pw" oninput="verifyPWD();" placeholder="*비밀번호를 한번 더 입력해주세요." required><br>
					 <span id="vPwdMsg"></span>
				</div>
				<div class="">
					<input class="name" type="text" name="m_name" id="m_name" placeholder="*이름을 입력해 주세요" required><br>
				</div>
				<div class="">
					<input class="id" type="text" name="m_nickname" id="m_nickname" oninput="dupCheckNick();" placeholder="*닉네임를 입력해주세요." required><br>
					 <span id="nickMsg"></span>
				</div>
				
				<div>
					<input class="submit2" type="submit" value="가입하기">&nbsp;<a id="mainmove" href="main.do">시작페이지</a>
				</div>
	</form>
</body>
</html>