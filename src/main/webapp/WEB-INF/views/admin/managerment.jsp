<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
//로그인 제한/가능 레디오 체크가 변경되었을 때 실행되는 함수
function changeLogin(element){
	//선택한 radio의 name 속성의 이름에서 userid 분리 추출함
	var m_id = element.name.substring(9);
	console.log(m_id);
	var json = new Object();
	json.m_id = m_id;
	if(element.checked == true && element.value == "N"){
		json.login_ok="N";
	} else {
		json.login_ok="Y";
	}
	$.ajax({
		url: "loginok.do",
		type: "post",
		data: JSON.stringify(json),
		contentType: "application/json; charset=utf-8",
		success: function(result){
			console.log(result);
		},
		error: function(request, status, errorData){
			console.log("error code : " + request.status
					+ "\nMessage : " + request.responseText
					+ "\nError : " + errorData);
		}
	});
}
</script>
</head>
<body>
<div class="container">
    <table class="board-table">
        <thead>
        <tr>
          <th scope="cols">이름</th>
          <th scope="cols">닉네임</th>
          <th scope="cols">성별</th>
          <th scope="cols">로그인 활성/비활성</th>
        </tr>
        </thead>
        <tbody>                   
           <c:forEach items="${ requestScope.member }" var="m">
            <tr>
            	<c:if test="${m.login_ok eq 'Y' }">
            		<c:if test="${ !empty m.m_nickname && !empty m.m_name}">
		                <td>${ m.m_name }</td>
		                <td>${m.m_nickname }</td>
		            </c:if>
            		<c:if test="${ empty m.m_nickname && empty m.m_name }">
		                <td>이름 없음</td>
		                <td>닉네임 없음</td>
		            </c:if>
            		<c:if test="${ empty m.m_name }">
		                <td>이름 없음</td>
		                <td>${m.m_nickname }</td>
		            </c:if>
		            <c:if test="${ empty m.m_nickname }">
		                <td>${ m.m_name }</td>
		                <td>닉네임 없음</td>
		            </c:if>
	                <td>
	                	<c:if test="${ m.m_gender eq 'M'}">
	                		<td>남자</td>
	                	</c:if>
	                	<c:if test="${ m.m_gender eq 'F'}">
	                		<td>여자</td>
	                	</c:if>
	                </td>
	            </c:if>
                <td>
                	<c:if test="${m.login_ok eq 'Y' }">
                    	<input type="radio"	name="login_ok_${m.m_nickname}" value="Y"  checked	onchange="changeLogin(this);"> 가능 &nbsp;
                        <input type="radio"	name="login_ok_${m.m_nickname}" value="N"	onchange="changeLogin(this);"> 제한 &nbsp;
                    </c:if>
                    <c:if test="${m.login_ok eq 'N' }">
                        <input type="radio"	name="login_ok_${m.m_nickname}" value="Y"	onchange="changeLogin(this);"> 가능 &nbsp;
                        <input type="radio" name="login_ok_${m.m_nickname}" value="N"	checked	onchange="changeLogin(this);"> 제한 &nbsp;
                    </c:if>
                </td>
            </tr>
        </c:forEach>
    </tbody>
  </table>
</div>
</body>
</html>