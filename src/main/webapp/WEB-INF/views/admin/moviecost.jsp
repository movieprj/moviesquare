<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
			function costInput(state, id){
				var costInput;
				if(state===0){
					costInput = prompt("제작비를 입력하세요.");
				}else{
					const modi = confirm("제작비를 수정하시겠습니까?");
					if(modi){
						costInput = prompt("제작비를 입력하세요.");
					}
				}
				console.log(id + ", " + typeof(id));
				if(costInput){
					var cost = new Object();
					cost.id = id;
					cost.costInput = costInput;
					cost.state = state;
					$.ajax({
						url: "changeCost.do",
						type: "post",
						data: JSON.stringify(cost),
						contentType: "application/json; charset=utf-8",
						success: function(result){
							location.reload();
						},
						error: function(request, status, errorData){
							console.log("error code : " + request.status
									+ "\nMessage : " + request,responseText
									+ "\nError : " + errorData);
						}
					});
				}
			}
		</script>
</head>
<body>
	<form action="moviesearchName.do" method="get">
		<input type="search" name="keyword""> <input type="submit"
			value="검색" class="btn">
	</form>
	<a href="movieCost.do"><input type="button" value="전체검색"></a>
	<div class="container">
		<table class="board-table">
			<thead>
				<tr>
					<th scope="cols">영화이름</th>
					<th scope="cols">포스터</th>
					<th scope="cols">제작비</th>
					<th scope="cols">제작비 추가/변경</th>
					<th scope="cols">개봉일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${ requestScope.list }" var="m">
					<tr>
						<td><span>${ m.title }</span></td>
						<td><c:if test="${ !empty m.posters }">
								<img alt="" src="">
							</c:if> <c:if test="${ !empty m.posters }">
								<img alt="" src="${ m.posters }">
							</c:if></td>
						<td><span>${ m.cost }</span></td>
						<td><c:if test="${ m.cost eq '0' }">
								<input type="button" value="제작비 추가"
									onclick="costInput(0, ${m.id});">
							</c:if> <c:if test="${ m.cost ne '0' }">
								<input type="button" value="제작비 변경"
									onclick="costInput(1, ${m.id});">
							</c:if></td>
						<td><span>${ m.reprlsdate }</span></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<br>
	<c:if test="${ empty action }">
		<!-- 전체 목록 페이징 처리 -->
		<div style="text-align: center;">
			<!-- 페이지 표시 영역 -->
			<!-- 1페이지로 이동 처리 -->
			<c:if test="${ currentPage eq 1 }">
				[맨처음] &nbsp;
			</c:if>
			<c:if test="${ currentPage > 1 }">
				<c:url var="bl" value="/movieCost.do">
					<c:param name="page" value="1" />
				</c:url>
				<a href="${ bl }">[맨처음]</a> &nbsp;
			</c:if>
			<!-- 이전 페이지그룹으로 이동 처리 -->
			<c:if
				test="${ (currentPage - 10) < startPage and (currentPage - 10) > 0 }">
				<c:url var="bl2" value="/movieCost.do">
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
					<c:url var="bl3" value="/movieCost.do">
						<c:param name="page" value="${ p }" />
					</c:url>
					<a href="${ bl3 }">${ p }</a>
				</c:if>
			</c:forEach>
			<!-- 다음 페이지그룹으로 이동 처리 -->
			<c:if
				test="${ (currentPage + 10) > endPage and ((endPage%10)==0) and listCount > ( endPage*limit ) }">
				<c:url var="bl4" value="/movieCost.do">
					<c:param name="page" value="${ endPage + 1 }" />
				</c:url>
				<a href="${ bl4 }">[다음그룹]</a> &nbsp;
			</c:if>
			<!-- 끝페이지로 이동 처리 -->
			<c:if test="${ currentPage eq maxPage }">
				[맨끝] &nbsp; 
			</c:if>
			<c:if test="${ currentPage < maxPage }">
				<c:url var="bl5" value="/movieCost.do">
					<c:param name="page" value="${ maxPage }" />
				</c:url>
				<a href="${ bl5 }">[맨끝]</a> &nbsp;
			</c:if>
		</div>
	</c:if>
	<c:if test="${ !empty action }">

		<!-- 검색 목록 페이징 처리 -->
		<div style="text-align: center;">
			<!-- 페이지 표시 영역 -->
			<!-- 1페이지로 이동 처리 -->
			<c:if test="${ currentPage eq 1 }">
		 [맨처음] &nbsp;
	</c:if>
			<c:if test="${ currentPage > 1 }">
				<c:if test="${ action eq 'userid' }">
					<c:url var="nsl" value="moviesearchName.do">
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
			<c:if
				test="${ (currentPage - 10) < startPage and (currentPage - 10) > 0 }">
				<c:if test="${ action eq 'userid' }">
					<c:url var="nsl" value="moviesearchName.do">
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
						<c:url var="nsl" value="moviesearchName.do">
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
			<c:if
				test="${ (currentPage + 10) > endPage and ((endPage%10)==0) and listCount > ( endPage*limit ) }">
				<c:if test="${ action eq 'userid' }">
					<c:url var="nsl" value="moviesearchName.do">
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
					<c:url var="nsl" value="moviesearchName.do">
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

	</c:if>
	<!-- 검색 목록 페이징 처리 -->
	<br>
</body>
</html>