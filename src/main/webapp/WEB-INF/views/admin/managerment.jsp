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
	<form action="msearchId.do" method="get" >
       <input type="search" name="keyword" ">
       <input type="submit" value="검색" class="btn">
    </form>
    <a href="mlist.do"><input type = "button" value="전체검색"></a>
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
           <c:forEach items="${ requestScope.list }" var="m">
            <tr>
            	<td>
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
	            </td>
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
<br>
<c:if test="${ empty action }">
<!-- 전체 목록 페이징 처리 -->
<div style="text-align:center;"> <!-- 페이지 표시 영역 -->
	<!-- 1페이지로 이동 처리 -->
	<c:if test="${ currentPage eq 1 }">
		[맨처음] &nbsp;
	</c:if>
	<c:if test="${ currentPage > 1 }">
		<c:url var="bl" value="/mlist.do">
			<c:param name="page" value="1" />
		</c:url>
		<a href="${ bl }">[맨처음]</a> &nbsp;
	</c:if>
	<!-- 이전 페이지그룹으로 이동 처리 -->
	<c:if test="${ (currentPage - 10) < startPage and (currentPage - 10) > 0 }">
		<c:url var="bl2" value="/mlist.do">
			<c:if test="${currentPage%10==0 }">
						<c:param name="page" value="${ startPage-1 }" />
					</c:if>
					<c:if test="${currentPage%10!=0 }">
						<c:param name="page" value="${ currentPage - (currentPage%10) }" />
					</c:if>
		</c:url>
		<a href="${ bl2 }">[이전그룹]</a> &nbsp;
	</c:if>
	<!-- 현재 페이지가 속한 페이지 그룹 페이지 숫자 출력 -->
	<c:forEach var="p" begin="${ startPage }" end="${ endPage }" step="1">
		<c:if test="${ p eq currentPage }">
			<font size="4" color="red"><b>[${ p }]</b></font>
		</c:if>
		<c:if test="${ p ne currentPage }">
			<c:url var="bl3" value="/mlist.do">
				<c:param name="page" value="${ p }" />
		</c:url>
		<a href="${ bl3 }">${ p }</a> 
		</c:if>
	</c:forEach>
	<!-- 다음 페이지그룹으로 이동 처리 -->
	<c:if test="${ (currentPage + 10) > endPage and ((endPage%10)==0) and listCount > ( endPage*limit ) }">
		<c:url var="bl4" value="/mlist.do">
			<c:param name="page" value="${ endPage + 1 }" />
		</c:url>
		<a href="${ bl4 }">[다음그룹]</a> &nbsp;
	</c:if>
	<!-- 끝페이지로 이동 처리 -->
	<c:if test="${ currentPage eq maxPage }">
		[맨끝] &nbsp; 
	</c:if>
	<c:if test="${ currentPage < maxPage }">
		<c:url var="bl5" value="/mlist.do">
			<c:param name="page" value="${ maxPage }" />
		</c:url>
		<a href="${ bl5 }">[맨끝]</a> &nbsp;
	</c:if>
</div>
</c:if>

<c:if test="${ !empty action }">

<!-- 검색 목록 페이징 처리 -->
<div style="text-align:center;"> <!-- 페이지 표시 영역 -->
	<!-- 1페이지로 이동 처리 -->
	<c:if test="${ currentPage eq 1 }">
		 [맨처음] &nbsp;
	</c:if>
	<c:if test="${ currentPage > 1 }">
			<c:if test="${ action eq 'userid' }">
				<c:url var="nsl" value="msearchId.do">
					<c:param name="keyword" value="${ keyword }" />
					<c:param name="page" value="1" />
				</c:url>
			</c:if>
		
			<c:if test="${ action eq 'login' }">
				<c:url var="nsl" value="msearchLogin.do">
					<c:param name="keyword" value="${ keyword }" />
					<c:param name="page" value="1" />
				</c:url>
			</c:if>
		<a href="${ nsl }">[맨처음]</a> &nbsp;
	</c:if>
	<!-- 이전 페이지그룹으로 이동 처리 -->
	<c:if test="${ (currentPage - 10) < startPage and (currentPage - 10) > 0 }">
		<c:if test="${ action eq 'userid' }">
				<c:url var="nsl" value="msearchId.do">
					<c:param name="keyword" value="${ keyword }" />
					<c:if test="${currentPage%10==0 }">
							<c:param name="page" value="${ startPage-1 }" />
						</c:if>
						<c:if test="${currentPage%10!=0 }">
							<c:param name="page" value="${ currentPage - (currentPage%10) }" />
						</c:if>
				</c:url>
			</c:if>
		
			<c:if test="${ action eq 'login' }">
				<c:url var="nsl" value="msearchLogin.do">
					<c:param name="keyword" value="${ keyword }" />
					<c:if test="${currentPage%10==0 }">
							<c:param name="page" value="${ startPage-1 }" />
						</c:if>
						<c:if test="${currentPage%10!=0 }">
							<c:param name="page" value="${ currentPage - (currentPage%10) }" />
						</c:if>
				</c:url>
			</c:if>
		
		<a href="${ nsl }">[이전그룹]</a> &nbsp;
	</c:if>
	<!-- 현재 페이지가 속한 페이지 그룹 페이지 숫자 출력 -->
	<c:forEach var="p" begin="${ startPage }" end="${ endPage }" step="1">
		<c:if test="${ p eq currentPage }">
			<font size="4" color="red"><b>[${ p }]</b></font>
		</c:if>
		<c:if test="${ p ne currentPage }">
			<c:if test="${ action eq 'userid' }">
				<c:url var="nsl" value="msearchId.do">
					<c:param name="keyword" value="${ keyword }" />
					<c:param name="page" value="${ p }" />
				</c:url>
			</c:if>
		
			<c:if test="${ action eq 'login' }">
				<c:url var="nsl" value="msearchLogin.do">
					<c:param name="keyword" value="${ keyword }" />
					<c:param name="page" value="${ p }" />
				</c:url>
			</c:if>
		
			<c:if test="${ action eq 'edate' }">
				<c:url var="nsl" value="msearchDate.do">
					<c:param name="begin" value="${ begin }" />
					<c:param name="end" value="${ end }" />
					<c:param name="page" value="${ p }" />
				</c:url>
			</c:if>
			<a href="${ nsl }">${ p }</a> 
		</c:if>
	</c:forEach>
	<!-- 다음 페이지그룹으로 이동 처리 -->
	<c:if test="${ (currentPage + 10) > endPage and ((endPage%10)==0) and listCount > ( endPage*limit ) }">
		<c:if test="${ action eq 'userid' }">
				<c:url var="nsl" value="msearchId.do">
					<c:param name="keyword" value="${ keyword }" />
					<c:param name="page" value="${ endPage + 1 }" />
				</c:url>
			</c:if>
		
			<c:if test="${ action eq 'login' }">
				<c:url var="nsl" value="msearchLogin.do">
					<c:param name="keyword" value="${ keyword }" />
					<c:param name="page" value="${ endPage + 1 }" />
				</c:url>
			</c:if>
		
			<c:if test="${ action eq 'edate' }">
				<c:url var="nsl" value="msearchDate.do">
					<c:param name="begin" value="${ begin }" />
					<c:param name="end" value="${ end }" />
					<c:param name="page" value="${ endPage + 1 }" />
				</c:url>
			</c:if>
		<a href="${ nsl }">[다음그룹]</a> &nbsp;
	</c:if>
	<!-- 끝페이지로 이동 처리 -->
	<c:if test="${ currentPage eq maxPage }">
		[맨끝] &nbsp; 
	</c:if>
	<c:if test="${ currentPage < maxPage }">
		<c:if test="${ action eq 'userid' }">
				<c:url var="nsl" value="msearchId.do">
					<c:param name="keyword" value="${ keyword }" />
					<c:param name="page" value="${ maxPage }" />
				</c:url>
			</c:if>
		
			<c:if test="${ action eq 'login' }">
				<c:url var="nsl" value="msearchLogin.do">
					<c:param name="keyword" value="${ keyword }" />
					<c:param name="page" value="${ maxPage }" />
				</c:url>
			</c:if>
		
		<a href="${ nsl }">[맨끝]</a> &nbsp;
	</c:if>
</div>

</c:if> <!-- 검색 목록 페이징 처리 -->
<br>
</body>
</html>