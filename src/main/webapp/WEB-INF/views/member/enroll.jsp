<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="resources/css/login/enroll.css" type="text/css">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="viewport" content="initial-scale=1, maximum-scale=1">

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
//회원가입 유효성 검사
var enrollcheck = {
		"pwVal" : "invalidation",
		"nickVal" : "invalidation",
		"emailVal" : "invalidation"
};
var email_code = "";
//입력된 이메일 중복되지 않았는지 확인
function emailChk() {
	var passRule = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
	
	if(passRule.test($("#m_email").val()) === true)
	{
		//이메일 길이 제한 최소 5글자
		if($("#m_email").val().indexOf('@') > 4){
			$.ajax({
				url : "emailcheck.do",
				type : "post",
				data : {
					m_email : $("#m_email").val()
				},
				success : function(data) {
					if (data == "no") {
						$("#emailMsg").text("이미 가입된 회원의 이메일입니다.");
						$("#emailMsg").css('color', 'red');
						$("#m_email").select();
					} else {
						$("#emailMsg").text("사용 가능한 이메일입니다.");
						$("#emailMsg").css('color', 'green');
						email_code = data;
						$("#ceMailcertification").attr('disabled',false);
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					console.log("error : " + jqXHR + ", " + textStatus + ", "
							+ errorThrown);
				}
			});
		}else{
			$("#emailMsg").text("이메일은 5글자 이상이어야 합니다.");
			$("#emailMsg").css('color', 'red');
			enrollcheck["emailVal"] = "invalidation";
		}
	}else{
		$("#emailMsg").text("이메일 형식을 맞춰 작성해 주세요");
		$("#emailMsg").css('color', 'red');
		enrollcheck["emailVal"] = "invalidation";
	}
	
}
function mailCertification(){
	var input_code = $("#ceMailcertification").val();
	console.log(input_code);
	if(email_code == input_code){
		enrollcheck["emailVal"] = "validation";
		$("#emailCertificationMsg").text("이메일 인증이 완료되었습니다.");
		$("#emailCertificationMsg").css('color', 'green');
	}else{
		enrollcheck["emailVal"] = "invalidation";
		$("#emailCertificationMsg").text("잘못된 인증번호 입니다. 다시 확인해 주세요");
		$("#emailCertificationMsg").css('color', 'red');
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
//이메일 확인 사용안함
/*
function emailChk2(){
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
*/
//회원가입 폼 유효성 검사
function validate(){
	if(enrollcheck["pwVal"]=="invalidation"){
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
	<div class="wrap">
		<div class="login">
			<h3 text-align="center" style="font-family: 'Noto Sans KR', sans-serif; font-size : 40px">회원 가입</h3><br>
			
			<div class="textForm2">
				<!--이메일 입력-->
				<input class="m_email" type="text" name="m_email" id="m_email" placeholder="*이메일을 입력해주세요." required><br>
				<div class="emailchk">
					<input class="bttn" type="button" onclick="emailChk();" value="이메일 중복 확인 버튼"> <span id="emailMsg"></span>
				</div>
			</div>
			<!-- 인증번호 확인-->
			<div class="textForm">
				<input class="pw" id = "ceMailcertification" placeholder="인증번호 6자리를 입력해주세요!" disabled="disabled" maxlength="6" oninput="mailCertification();" required><br>
				<span id="emailCertificationMsg"></span>
			</div>
			<!--비밀번호 확인-->
			<div class="textForm">
				<input class="pw" type="password" name="m_pw" id="m_pw" oninput="dupCheckPw();" placeholder="*비밀번호를 입력해주세요." required><br>
				 <span id="pwdMsg"></span>
			</div>
			<!--비밀번호 재확인-->
			<div class="textForm">
				<input class="pw" type="password" name="v_pw" id="v_pw" oninput="verifyPWD();" placeholder="*비밀번호 확인" required><br>
			    <span id="vPwdMsg"></span>
			</div>
			<!--이름 입력-->
			<div class="textForm">
				<input class="id" type="text" name="m_name" id="m_name" placeholder="*이름을 입력해 주세요" required><br>
			</div>
			<!--닉네임 중복확인-->
			<div class="textForm">
				<input class="id" type="text" name="m_nickname" id="m_nickname" oninput="dupCheckNick();" placeholder="*닉네임를 입력해주세요." required><br>
				<span id="nickMsg"></span>
			</div>
			<!--성별 선택 -->
			<div class="textForm3">
				<input type="gender" class="gender" name="gender" id="gender" placeholder="*성별을 선택하세요." disabled>
				<div class="genderchk">
					<input class="bttn2" type="radio" name="m_gender" value="M" checked> <span id="genderstatus">남</span>
					<input class="bttn3" type="radio" name="m_gender" value="F"> <span id="genderstatus">여</span>
				</div>
			</div>
			<!--생년월일 확인-->
			<div class="textForm3">
				<input type="birthday" class="birthday" name="birthday" id="birthday" placeholder="*생년월일을 선택하세요." disabled>
				<div class="genderchk">
					<input type="date" class="bttn2" value="male" name="m_birthday" id="m_birthday" required> <span id="birthdaystauts"></span>
				</div>
			</div>
			<div>
				<input class="submit2" type="submit" value="가입하기">&nbsp;<a id="mainmove" href="main.do">홈으로</a>
			</div>
		</div>
	</div>
</form>
</body>
</html>