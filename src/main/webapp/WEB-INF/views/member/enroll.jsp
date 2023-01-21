<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
function dupCheckId() {
	// 입력된 아이디가 중복되지 않았는지 확인 : jQuery.ajax() 사용
	const idchkMsg = $('#idDupCheckMsg');
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

	idMinLength = document.getElementById("m_id").value.length;
	if (idMinLength < 4) {
		idchkMsg.html("아이디는 최소 4자 이상이어야 합니다.");
		idchkMsg.css('color', 'red');
	}
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
				<div>
					<input class="submit2" type="submit" value="가입하기">&nbsp;<a id="mainmove" href="main.do">시작페이지</a>

				</div>
	</form>
</body>
</html>