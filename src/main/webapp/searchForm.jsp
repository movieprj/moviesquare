<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<!-- <link rel="stylesheet" href="../css/day11.css"> -->
<style type="text/css">
* {
	margin: 0;
	padding: 0;
}

body {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
}

.search {
	width: 300px;
	height: 100px;
}

.search input {
	width: 80%;
	height: 30px;
	font-size: 18px;
	border: none;
	border-bottom: 1px black solid;
}

.search button {
	font-size: 18px;
	border: none;
	background-color: green;
	width: 50px;
	height: 30px;
	border-radius: 15px;
	color: #fff;
	cursor: pointer;
}
</style>
</head>
<body>
	<section>
		<form action="https://search.naver.com/search.naver">
			<div class="search">
				<input type="text" name="query" value="">
				<button type="submit">검색</button>
			</div>
		</form>
	</section>
</body>
</html>