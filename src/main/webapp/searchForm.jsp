<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link type="text/css" rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/jsmind@0.6.4/style/jsmind.css" />
<script type="text/javascript"
	src="//cdn.jsdelivr.net/npm/jsmind@0.6.4/es6/jsmind.js"></script>
<script type="text/javascript"
	src="//cdn.jsdelivr.net/npm/jsmind/es6/jsmind.draggable-node.js"></script>
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
<script type="text/javascript">
function insertKewordAndViews() {
	const keyword = $("input[name='keyword']").val();
	if(keyword == "" || keyword == null) {
		alert("검색어를 입력해주세요.");
		return;
	}

	$.ajax({
		url: "${pageContext.request.contextPath}/insertViews.do",
		type: "post",
		data: {
			keyword: keyword
		},
		success: function(data) {
			alert("검색어와 조회수가 저장되었습니다.");
			console.log(data);
		},
		error: function() {
			console.log("error");
		}
	});
}
$(document).ready(function() {
    $('#search-btn').click(function() {
      // 검색 버튼이 클릭되었을 때 실행할 코드

	  // 조회수와 키워드 입력
	  insertKewordAndViews();

	  // 실제로 검색할 코드 입력.
    });
  });

</script>

</head>
<body>
	<section>
		<form>
			<div class="search">
				<input type="text" name="keyword" value="">
				<button type="button" id="search-btn">검색</button>
			</div>
			<div id="jsmind_container"></div>
			<script type="text/javascript">
            function load_jsmind() {
        var data = {
            meta: {
                "name": "Movie Mindmap",
                "author": "Your Name",
                "version": "1.0"
            },
            format: "node_array",
            data: [
                {
                    "id": "root",
                    "isroot": true,
                    "topic": "영화 정보"
                },
                {
                    'id': 'sub1',
                    'parentid': 'root',
                    'topic': 'sub1',
                    'background-color': '#0000ff',
                },
                        {
                            "id": "title",
                            "topic": "영화 제목: 벙어리 삼룡", parentid:'sub1'
                        },
                        {
                            "id": "director",
                            "topic": "감독: 나운규", parentid:'sub1'
                        },
                        {
                            "id": "actors",
                            "topic": "배우: 나운규, 유신방, 주삼손, 윤봉춘", parentid:'sub1'
                        },
                        {
                            "id": "production",
                            "topic": "제작사: 나운규프로덕션", parentid:'sub1'
                        },
                        {
                            "id": "genre",
                            "topic": "장르: 드라마, 문예", parentid:'sub1'
                        },
                        {
                            "id": "country",
                            "topic": "국가: 대한민국", parentid:'sub1'
                        },
                        {
                            "id": "release_date",
                            "topic": "개봉일: 1929년 1월 19일", parentid:'sub1'
                        },
                        {
                            "id": "plot",
                            "topic": "줄거리: 봉건지주, 머슴살이, 휴머니즘, 라스트 신, 무성영화", parentid:'sub1'
                        },
                    ],
        };

        var options = {
            container: 'jsmind_container',
            editable: true,
            theme: 'orange'
        };

        var jm = new jsMind(options);
        jm.show(data);
            }
            load_jsmind();
    </script>
		</form>
	</section>
</body>
</html>