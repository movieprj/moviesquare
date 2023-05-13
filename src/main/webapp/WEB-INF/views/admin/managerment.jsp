<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<div class="container">
    <table class="board-table">
        <thead>
        <tr>
          <th scope="cols">이름</th>
          <th scope="cols">닉네임</th>
          <th scope="cols">성별</th>
          <th scope="cols">연령대</th>
          <th scope="cols">로그인 활성/비활성</th>
        </tr>
        </thead>
        <tbody>                   
           <c:forEach items="${ requestScope.list }" var="m">
            <tr>
                <td>${m.m_id}</td>
                <td>${m.m_email }</td>
                <td>
                    <c:if test="${m.login_ok eq 'Y' }">
                        <input type="radio"	name="login_ok_${m.m_id }" value="Y"  checked	onchange="changeLogin(this);"> 가능 &nbsp;
                        <input type="radio"	name="login_ok_${m.m_id }" value="N"	onchange="changeLogin(this);"> 제한 &nbsp;
                    </c:if>
                    <c:if test="${m.login_ok eq 'N' }">
                        <input type="radio"	name="login_ok_${m.m_id }" value="Y"	onchange="changeLogin(this);"> 가능 &nbsp;
                        <input type="radio" name="login_ok_${m.m_id }" value="N"	checked	onchange="changeLogin(this);"> 제한 &nbsp;
                    </c:if>
                </td>
            </tr>
        </c:forEach>
    </tbody>
  </table>
</div>
</body>
</html>