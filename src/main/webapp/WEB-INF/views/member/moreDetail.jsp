<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	성별, 연령대를 입력해주세요.
</h1>
<form action="/socialMoreInfo.do" method="post">
	<input type="hidden" name="kakaoid" value="${ sub }">
	<input type="hidden" name="m_nickname" value="${ name }">
<select name="m_gender">
	<option value="">성별</option>
    <option value="M">남자</option>
    <option value="F">여자</option>
</select>
<select name="agecode">
	<option value="">연령대</option>
    <option value="A0">1~9</option>
    <option value="A1">10~19</option>
    <option value="A2">20~29</option>
    <option value="A3">30~39</option>
    <option value="A4">40~49</option>
    <option value="A5">50~59</option>
    <option value="A6">60~69</option>
    <option value="A7">70~79</option>
    <option value="A8">80~89</option>
    <option value="A9">90~99</option>
</select>

</form>

</body>
</html>
