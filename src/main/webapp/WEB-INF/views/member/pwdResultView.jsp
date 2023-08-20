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
	    <link rel="stylesheet" href="resources/css/login/enroll.css" type="text/css">
	    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
	    <script type="text/javascript">
		    var enrollcheck = {
		    		"pwVal" : "invalidation"
		    };
		    var pwdLength;
		    var passRule;
		    
			//비밀번호 확인
		    function dupCheckPw(){
		    	pwdLength = $("#m_pw").val().length;
		    	passRule = /^(?=.*[a-zA-Z])((?=.*\d)).{8,15}$/;
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
		    	if(p1==p2 && passRule.test($("#m_pw").val()) === true)
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
		    function validate(){
		    	if(enrollcheck["pwVal"]=="invalidation"){
		    		alert("비밀번호 확인해 주세요");
		    		return false;
		    	}
		    	//비밀번호 변경
		    	$.ajax({
					url : "changePwd.do",
					type : "post",
					data : {
						m_email : "${ find_info.m_email }",
						m_name  : "${ find_info.m_name }",
						m_birthday : "${ find_info.m_birthday }",
						m_pw   : $("#m_pw").val()
					},
					success : function(data) {
						console.log("결과 : " + data);
						if(data ==="0"){
							alert("비밀번호 변경 완료했습니다");
							location.href = "main.do";
						}else{
							alert("비밀번호 변경에 실패했습니다");
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
		<!-- 아이디가 존재하면 -->
		<c:if test="${ FindResult eq '1' }">
			<div class="wrap">
				<div class="login">
					<h1> 아이디는 : ${ find_info.m_email } 입니다.</h1>
					<!--비밀번호-->
					<div class="textForm">
						<input class="pw" type="password" name="m_pw" id="m_pw" oninput="dupCheckPw();" placeholder="*비밀번호를 입력해주세요." required><br>
						 <span id="pwdMsg"></span>
					</div>
					<!--비밀번호 재확인-->
					<div class="textForm">
						<input class="pw" type="password" name="v_pw" id="v_pw" oninput="verifyPWD();" placeholder="*비밀번호 확인" required><br>
					    <span id="vPwdMsg"></span>
					</div>
					<div>
						<input class="submit2" value="변경하기" onclick="validate();">&nbsp;<a id="mainmove" href="main.do">홈으로</a>
					</div>
				</div>
			</div>
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