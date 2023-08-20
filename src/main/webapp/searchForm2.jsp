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
     <link
            type="text/css"
            rel="stylesheet"
            href="//cdn.jsdelivr.net/npm/jsmind/style/jsmind.css"
        />
        <style type="text/css">
            #jsmind_container {
                width: 800px;
                height: 500px;
                border: solid 1px #ccc;
                /*background:#f4f4f4;*/
                background: #f4f4f4;
            }
        </style>
        <script type="text/javascript" src="//cdn.jsdelivr.net/npm/jsmind/es6/jsmind.js"></script>
        <script
            type="text/javascript"
            src="//cdn.jsdelivr.net/npm/jsmind/es6/jsmind.draggable-node.js"
        ></script>
<title>Document</title>
<!-- <link rel="stylesheet" href="../css/day11.css"> -->

</head>
<body>

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
                            "topic": "영화 제목: 벙어리 삼룡", parentid:'root'
                        },
                        {
                            "id": "director",
                            "topic": "감독: 나운규", parentid:'root'
                        },
                        {
                            "id": "actors",
                            "topic": "배우: 나운규, 유신방, 주삼손, 윤봉춘", parentid:'root'
                        },
                        {
                            "id": "production",
                            "topic": "제작사: 나운규프로덕션", parentid:'root'
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

</body>
</html>