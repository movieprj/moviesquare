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
		      	<c:forEach items="${ requestScope.movies }" var="m">
		        	<tr>
		          		<td>
				        	<span>${ m.title }</span>
			        	</td>
			        	<td>
			        		<c:if test="${ !empty m.posters }">
			        			<img alt="" src="">
			        		</c:if>
			        		<c:if test="${ !empty m.posters }">
			        			<img alt="" src="${ m.posters }">
			        		</c:if>
			        	</td>
			        	<td>
			        		<span>${ m.cost }</span>
			        	</td>
			        	<td>
			        		<c:if test="${ m.cost eq '0' }">
			        			<input type="button" value="제작비 추가" onclick="costInput(0, ${m.id});">
			        		</c:if>
			        		<c:if test="${ m.cost ne '0' }">
			        			<input type="button" value="제작비 변경" onclick="costInput(1, ${m.id});">
			        		</c:if>
			        	</td>
			        	<td>
			        		<span>${ m.reprlsdate }</span>
			        	</td>
		        	</tr>
		      </c:forEach>
		    </tbody>
		  </table>
		</div>
	</body>
</html>