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
      <script src="https://d3js.org/d3.v3.min.js"></script>
<title>Document</title>
<!-- <link rel="stylesheet" href="../css/day11.css"> -->

</head>
<body>

			<div id="jsmind_container"></div>
			
			<script type="text/javascript">
			$.ajax({
			    url: "/moviesquare/getMovieData.do/46",
			    type: "GET",
			    dataType: "json",
			    success: function(response) {
			        // 서버로부터 응답을 성공적으로 받았을 때 실행할 코드
			        console.log(response);
			        console.log(response.actors);
			        load_jsmind(response);
			    },
			    error: function(xhr, status, error) {
			        // 서버로부터 응답을 받지 못했을 때 실행할 코드
			        console.log("Error: " + error);
			    }
			});
			
			
			
            function load_jsmind(json) {
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
                            "topic": "제목: "+json.title, parentid:'root'
                        },
                        {
                            "id": "director",
                            "topic": "감독: "+json.director, parentid:'root'
                        },
                        {
                            "id": "actors",
                            "topic": "배우: "+json.actors, parentid:'root'
                        },
                        {
                            "id": "production",
                            "topic": "제작사: "+json.company, parentid:'root'
                        },
                        {
                            "id": "genre",
                            "topic": "장르: "+json.genre, parentid:'root'
                        },
                        {
                            "id": "country",
                            "topic": "국가: "+json.nation, parentid:'root'
                        },
                        {
                            "id": "release_date",
                            "topic": "개봉일: "+json.reprlsdate, parentid:'root'
                        },
                        {
                            "id": "keywords",
                            "topic": "키워드: "+json.keywords, parentid:'root'
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
            
    </script>

<div id="mindmap"></div>
<script>
//데이터 정의
var nodeArray = new Array();
        var linkArray = new Array();
        var nodeColorArray = d3.scale.category20();
        data = {
            nodes: [
                 {keyword: '미스트롯', id:'1', tag:'1'}
                ,{keyword: '김호중', id:'2', tag:'2'}
                ,{keyword: '편의점 샛별이', id:'3', tag:'3'}
                ,{keyword: '방탄소년단', id:'4', tag:'4'}
                ,{keyword: '미스터 트롯', id:'5', tag:'5'}
                ,{keyword: '전지적 참견 시점', id:'6', tag:'6'}
                ,{keyword: '(아는 건 별로 없지만) 가족입니다', id:'7', tag:'7'}
                ,{keyword: '아내의맛', id:'8', tag:'8'}
                ,{keyword: '사이코지만 괜찮아', id:'9', tag:'9'}
                ,{keyword: '백종원의 골목식당', id:'10', tag:'10'}
                ,{keyword: '비디오스타', id:'11', tag:'11'}
            ]
            ,links: [
                {source: 0,target: 1, boldVal: 1}
                ,{source: 0,target: 2, boldVal: 2}
                ,{source: 0,target: 3, boldVal: 3}
                ,{source: 0,target: 4, boldVal: 4}
                ,{source: 0,target: 5, boldVal: 5}
                ,{source: 0,target: 6, boldVal: 4}
                ,{source: 0,target: 7, boldVal: 3}
                ,{source: 0,target: 8, boldVal: 2}
                ,{source: 0,target: 9, boldVal: 1}
                ,{source: 0,target: 10, boldVal: 1}
            ]
        }

        var nodeSize = 50;

        var total_interactions = data.links.reduce(function(result, currentObject) {
            return result + currentObject.boldVal;
        }, 0);

        function tick() {
            callLink
                .attr("x1", function(d) { return d.source.x; })
                .attr("y1", function(d) { return d.source.y; })
                .attr("x2", function(d) { return d.target.x; })
                .attr("y2", function(d) { return d.target.y; });
            textLink
                .attr("x1", function(d) { return d.source.x; })
                .attr("y1", function(d) { return d.source.y; })
                .attr("x2", function(d) { return d.target.x; })
                .attr("y2", function(d) { return d.target.y; });

            node
                .attr("transform", function(d) {
                    var xVal = d.x;
                    var yVal = d.y;
                    if(xVal < 0){
                        d.x = -1 * xVal;
                    }else if(xVal > (width-20)){
                        d.x = width-20;
                    }else if(xVal < 20){
                        d.x = 20;
                    }

                    if(yVal < 0){
                        d.y = -1 * yVal;
                    }else if(yVal > (height-25)){
                        d.y = height-25;
                    }else if(yVal < 25){
                        d.y = 25;
                    }
                    if(d.index == 0){
                        d.x = 300;
                        d.y = 150;
                    }
                    return "translate(" + d.x + "," + d.y + ")";
                });
        }

        var width = 600;
        var height = 300;

        var nodes = data.nodes
        var links = data.links
        var colors = nodeColorArray;
        var force = d3.layout.force()
            .nodes(nodes)
            .links(links)
            .charge(-3000)
            .friction(0.5)
            .gravity(0.01)
            .distance(90)
            .size([width,height])
            .start();

        var linkedByIndex = {};
        links.forEach(function(d) {
            linkedByIndex[d.source.index + "," + d.target.index] = true;
        });

        var svg = d3.select("#mindmap").append("svg")
            .attr("width", width)
            .attr("height", height);

        var callLink = svg.selectAll(".call-line")
            .data(links)
            .enter().append("line");
        var textLink = svg.selectAll(".text-line")
            .data(links)
            .enter().append("line");

        var node = svg.selectAll("g.node")
            .data(data.nodes)
            .enter().append("g")
            .attr("class", "node")
            .call(force.drag);

        node.append("rect") // 노드모양 지정. ellipse - 타원형
            .attr("cursor","pointer") // mouseover시 손가락 모양
            .attr('fill', function(d, i) { // 노드 컬러 지정
                return colors(d.id);
            })
            .attr("rx", 20)
            .attr("ry", 20)
            /*.attr("x", -50)*/
            .attr("x", function(d){
                var returnVal = -50;
                if(d.index == 0){
                    var nameStrLen = d.keyword.length;
                    if(nameStrLen > 8 && nameStrLen < 16){
                        returnVal = -80;
                    }else if(nameStrLen > 15){
                        returnVal = -120;
                    }
                }
                return returnVal;
            })
            .attr("y", -23)
            .attr("height", function(d) { // 노드 y축 길이
                return nodeSize*0.8;
            })
            .attr("width", function(d) { // 노드 x축 길이
                var returnVal = "";
                var nameStrLen = d.keyword.length;
                if(typeof d != 'undefined' && d.keyword != null && d.keyword != ""){
                    if(nameStrLen > 8 && nameStrLen < 16){
                        returnVal = nodeSize*3.5;
                    }else if(nameStrLen > 15){
                        returnVal = nodeSize*5;
                    }else {
                        returnVal = nodeSize*2;
                    }
                }
                return returnVal;
            })
            .on("click",function(d){
                
            });

        node.append("text")
            //.attr("dy", "15") // 노드 텍스트 y축 조절
            .attr("text-anchor", "middle") // 노드 텍스트 가운데 정렬
            .attr("dx",function(d) {
                var returnVal = "3%";
                var nameStrLen = d.keyword.length;
                if(typeof d != 'undefined' && d.keyword != null && d.keyword != ""){
                    if(d.index == 0){
                        if(nameStrLen > 8 && nameStrLen < 16){
                            returnVal = "1%";
                        }else if(nameStrLen > 15){
                            returnVal = "2.5%";
                        }else {
                            returnVal = "";
                        }
                    }else{
                        if(nameStrLen > 8 && nameStrLen < 16){
                            returnVal = "6%";
                        }else if(nameStrLen > 15){
                            returnVal = "12%";
                        }else {
                            returnVal = "";
                        }
                    }
                }
                return returnVal;
            })
            .style("white-space", "pre")
            .attr('fill', function(d, i) { // 노드 텍스트 컬러
                return "#fff";
            })
            .style("font-size", function(d) { // 노드 텍스트 사이즈
                return 14;
            })
            .text(function(d) { // 노드 text
                return d.keyword
            })
            .on("click",function(d){ // 노드 click event

            });

        var line_width_factor = 40 // width for a line with all points

        callLink.style("stroke-width", function stroke(d)  { // 데이터의 boldVal값은 라인 두께지정
                return 1.5 * d.boldVal / total_interactions*line_width_factor;
            }).style("stroke", "#dadada") // 라인 컬러

        force.on("tick",tick);
</script>

</body>
</html>