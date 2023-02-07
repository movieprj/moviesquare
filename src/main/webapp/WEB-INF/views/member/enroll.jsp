<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
//회원가입 유효성 검사
var enrollcheck = {
		"idVal" : "invalidation",
		"pwVal" : "invalidation",
		"nickVal" : "invalidation",
		"emailVal" : "invalidation"
};

//입력된 아이디가 중복되지 않았는지 확인
function dupCheckId() {
	if ($("#m_id").val().length < 4) {
		$("#idDupCheckMsg").text("아이디는 최소 5자 이상이어야 합니다.");
		$("#idDupCheckMsg").css('color', 'red');
	}else{
		$.ajax({
			url : "idcheck.do",
			type : "post",
			data : {
				m_id : $("#m_id").val()
			},
			success : function(data) {
				if (data == "ok") {
					$("#idDupCheckMsg").text("사용 가능한 아이디입니다.");
					$("#idDupCheckMsg").css('color', 'green');
					enrollcheck["idVal"] = "validation";
				} else {
					$("#idDupCheckMsg").text("이미 가입된 회원의 아이디입니다.");
					$("#idDupCheckMsg").css('color', 'red');
					enrollcheck["idVal"] = "invalidation";
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
	var passRule = /^(?=.*[a-zA-Z])((?=.*\d)).{8,15}$/;
	if(passRule.test($("#m_pw").val()) === false)
	{
		$("#pwdMsg").text("비밀번호는 영어와 숫자를 포함한 8~15자 이내로 작성해 주세요 비밀번호 길이 : " + pwdLength);
		$("#pwdMsg").css('color', 'red');
	}else{
		$("#pwdMsg").text("비밀번호 사용 가능  비밀번호 길이 : " + pwdLength);
		$("#pwdMsg").css('color', 'green');
	}
	verifyPWD();
}
//비밀번호 일치 확인
function verifyPWD(){
	var p1 = $("#m_pw").val();
	var p2 = $("#v_pw").val();
	if(p1==p2)
	{
		$("#vPwdMsg").text("일치합니다.");
		$("#vPwdMsg").css('color', 'green');
		enrollcheck["pwVal"] = "validation";
	}else{
		$("#vPwdMsg").text("다시 확인해 주세요");
		$("#vPwdMsg").css('color', 'red');
		enrollcheck["pwVal"] = "invalidation";
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
				enrollcheck["nickVal"] = "validation";
			} else {
				$("#nickMsg").text("사용중인 닉네임입니다.");
				$("#nickMsg").css('color', 'red');
				enrollcheck["nickVal"] = "invalidation";
				$("#m_nickname").select();
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log("error : " + jqXHR + ", " + textStatus + ", "
					+ errorThrown);
		}
	});
}
//이메일 확인
function emailChk(){
	var passRule = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
	if(passRule.test($("#m_email").val()) === true)
	{
		$("#emailMsg").text("이메일 사용 가능");
		$("#emailMsg").css('color', 'green');
		enrollcheck["emailVal"] = "validation";
	}else{
		$("#emailMsg").text("이메일 형식을 맞춰 작성해 주세요");
		$("#emailMsg").css('color', 'red');
		enrollcheck["emailVal"] = "invalidation";
	}
}
//회원가입 폼 유효성 검사
function validate(){
	if(enrollcheck["idVal"]=="invalidation"){
		alert("id 확인해 주세요");
		return false;
	}else if(enrollcheck["pwVal"]=="invalidation"){
		alert("비밀번호 확인해 주세요");
		return false;
	}else if(enrollcheck["nickVal"]=="invalidation"){
		alert("닉네임 확인해 주세요");
		return false;
	}else if(enrollcheck["emailVal"]=="invalidation"){
		alert("이메일 확인해 주세요");
		return false;
	}else{
		alert("성공");
		return true;
	}
}
</script>
</head>
<body>
<form action="memenroll.do" method="post" onsubmit="return validate();">
	<div class="">
		<h3 align="center" style="font-family: 'Noto Sans KR', sans-serif; font-size : 40px">회원 가입 페이지</h3><br>
		<div class="">
			<input class="id" type="text" name="m_id" id="m_id" placeholder="*아이디를 입력해주세요." required><br>
			 <span id="idDupCheckMsg"></span>
			 <input class="idCheckBtn" type="button" onclick="dupCheckId();" value="아이디 중복 확인 버튼">
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
			<input class="nick" type="text" name="m_nickname" id="m_nickname" oninput="dupCheckNick();" placeholder="*닉네임를 입력해주세요." required><br>
			 <span id="nickMsg"></span>
		</div>
		<div class="">
			<input class="email" type="text" name="m_email" id="m_email" placeholder="*이메일 작성해주세요." required><br>
			 <span id="emailMsg"></span>
			 <input class="idCheckBtn" type="button" onclick="emailChk();" value="이메일 중복 확인 버튼">
		</div>
		<div class="">
			<input class="gender" type="radio" name="m_gender" value="M" checked> 남자 &nbsp;
			<input class="gender" type="radio" name="m_gender" value="F"> 여자
		</div>
		<div class="">
			<input class="birth" type="date" name="m_birthday" id="m_birthday" required><br>
		</div>
		<div>
			<input class="submit" type="submit" value="가입하기">&nbsp;<a id="mainmove" href="main.do">시작페이지</a>
		</div>
	</div>
</form>
</body>
</html>