<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>admin선택</title>
    <link rel="stylesheet" href="resources/css/selectadmin.css">
    <link rel="stylesheet" href="resources/css/reset.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400&family=Roboto:wght@100&display=swap" rel="stylesheet">

</head>
<body>
	<div id="wrap">
        <h1 class="title">어드민선택</h1>
        <a href="mlist.do"><div id="memberadmin">회원어드민</div></a>
        <a href="movieCost.do"><div id="movieadmin">영화어드민</div></a>
        <a href="adminlogout.do"><div id ="logoutadmin">로그아웃</div></a>
    </div>
</body>
</html>