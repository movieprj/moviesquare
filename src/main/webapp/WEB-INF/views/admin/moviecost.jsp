<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
  	<title>관리자페이지</title>
  	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet" />
  	<link rel="stylesheet" href="resources/css/tailwind.output.css" />
  	<link rel="stylesheet" href="resources/css/searchform.css">
  	<script src="https://cdn.jsdelivr.net/gh/alpinejs/alpine@v2.x.x/dist/alpine.min.js" defer></script>
  	<script src="resources/js/init-alpine.js"></script>
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
	<div class="flex h-screen bg-gray-50 dark:bg-gray-900" :class="{ 'overflow-hidden': isSideMenuOpen }">
    <!-- Desktop sidebar -->
    <aside class="z-20 hidden w-64 overflow-y-auto bg-white dark:bg-gray-800 md:block flex-shrink-0">
      <div class="py-4 text-gray-500 dark:text-gray-400">
      
        <a class="ml-6 text-lg font-bold text-gray-800 dark:text-gray-200" href="../index.html">
          영화어드민
        </a>
        <ul class="mt-6">
          <li class="relative px-6 py-3">
            
            <a class="inline-flex items-center w-full text-sm font-semibold text-gray-800 transition-colors duration-150 hover:text-gray-800 dark:hover:text-gray-200 dark:text-gray-100"
              href="mlist.do">
              <svg class="w-5 h-5" aria-hidden="true" fill="none" stroke-linecap="round" stroke-linejoin="round"
                stroke-width="2" viewBox="0 0 24 24" stroke="currentColor">
                <path
                  d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6">
                </path>
              </svg>
              <span class="ml-4">회원 관리</span>
            </a>
          </li>
        </ul>
        <ul>
          <li class="relative px-6 py-3">
			<span class="absolute inset-y-0 left-0 w-1 bg-purple-600 rounded-tr-lg rounded-br-lg"
              aria-hidden="true"></span>
            <a class="inline-flex items-center w-full text-sm font-semibold transition-colors duration-150 hover:text-gray-800 dark:hover:text-gray-200"
              href="movieCost.do">
              <svg class="w-5 h-5" aria-hidden="true" fill="none" stroke-linecap="round" stroke-linejoin="round"
                stroke-width="2" viewBox="0 0 24 24" stroke="currentColor">
                <path
                  d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-3 7h3m-3 4h3m-6-4h.01M9 16h.01">
                </path>
              </svg>
              <span class="ml-4">영화 제작비 입력</span>
            </a>
          </li>
        </ul>
      </div>
    </aside>
    <div class="flex flex-col flex-1 w-full">
      <header class="z-10 py-4 bg-white shadow-md dark:bg-gray-800">
        <div
          class="container flex items-center justify-between h-full px-6 mx-auto text-purple-600 dark:text-purple-300">
          
          <ul class="flex items-center flex-shrink-0 space-x-6">
            <!-- Theme toggler -->
            <li class="flex">
              <button class="rounded-md focus:outline-none focus:shadow-outline-purple" @click="toggleTheme"
                aria-label="Toggle color mode">
                <template x-if="!dark">
                  <svg class="w-5 h-5" aria-hidden="true" fill="currentColor" viewBox="0 0 20 20">
                    <path d="M17.293 13.293A8 8 0 016.707 2.707a8.001 8.001 0 1010.586 10.586z"></path>
                  </svg>
                </template>
                <template x-if="dark">
                  <svg class="w-5 h-5" aria-hidden="true" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd"
                      d="M10 2a1 1 0 011 1v1a1 1 0 11-2 0V3a1 1 0 011-1zm4 8a4 4 0 11-8 0 4 4 0 018 0zm-.464 4.95l.707.707a1 1 0 001.414-1.414l-.707-.707a1 1 0 00-1.414 1.414zm2.12-10.607a1 1 0 010 1.414l-.706.707a1 1 0 11-1.414-1.414l.707-.707a1 1 0 011.414 0zM17 11a1 1 0 100-2h-1a1 1 0 100 2h1zm-7 4a1 1 0 011 1v1a1 1 0 11-2 0v-1a1 1 0 011-1zM5.05 6.464A1 1 0 106.465 5.05l-.708-.707a1 1 0 00-1.414 1.414l.707.707zm1.414 8.486l-.707.707a1 1 0 01-1.414-1.414l.707-.707a1 1 0 011.414 1.414zM4 11a1 1 0 100-2H3a1 1 0 000 2h1z"
                      clip-rule="evenodd"></path>
                  </svg>
                </template>
              </button>
            </li>
          </ul>
        </div>
      </header>
      <main class="h-full overflow-y-auto">
        <div class="container px-6 mx-auto grid">
          
          <!-- CTA -->
          <a class="flex items-center justify-between p-4 mb-8 text-sm font-semibold text-purple-100 bg-purple-600 rounded-lg shadow-md focus:outline-none focus:shadow-outline-purple"
            href="admin">
            <div class="flex items-center">
              <svg class="w-5 h-5 mr-2" fill="currentColor" viewBox="0 0 20 20">
                <path
                  d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z">
                </path>
              </svg>
              <span>메인페이지</span>
            </div>
          </a>
          <!-- Cards -->
          <div class="grid gap-6 mb-8 md:grid-cols-2 xl:grid-cols-4">
            <!-- Card -->
            <div class="flex items-center p-4 bg-white rounded-lg shadow-xs dark:bg-gray-800">
              <div class="p-3 mr-4 text-orange-500 bg-orange-100 rounded-full dark:text-orange-100 dark:bg-orange-500">
                <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                  <path
                    d="M13 6a3 3 0 11-6 0 3 3 0 016 0zM18 8a2 2 0 11-4 0 2 2 0 014 0zM14 15a4 4 0 00-8 0v3h8v-3zM6 8a2 2 0 11-4 0 2 2 0 014 0zM16 18v-3a5.972 5.972 0 00-.75-2.906A3.005 3.005 0 0119 15v3h-3zM4.75 12.094A5.973 5.973 0 004 15v3H1v-3a3 3 0 013.75-2.906z">
                  </path>
                </svg>
              </div>
              <div>
                <p class="mb-2 text-sm font-medium text-gray-600 dark:text-gray-400">
                  영화 갯수
                </p>
                <p class="text-lg font-semibold text-gray-700 dark:text-gray-200">
                  총 영화 갯수(${requestScope.listCount})
                </p>
              </div>
            </div>
            
          </div>
          <!-- 검색 영역-->
          <div class="search-select">
            <select class="selectbox">
            	<option value="1">영화제목</option>
             </select>
               <form action="moviesearchName.do" method="get">
                  <input type="search" class="search" name="keyword">
                  <input style="border: 1px solid #3b4050;" type="submit" class="submit" value="검색">
               </form>
            </div>
            <!-- 여기까지 -->
          <!-- New Table -->
          <!-- 최대 10명으로 나와짐-->
          <div class="w-full overflow-hidden rounded-lg shadow-xs">
            <div class="w-full overflow-x-auto">
              <table class="w-full whitespace-no-wrap">
                <thead>
                  <!-- 표 타이틀 -->
                  <tr
                    class="text-xs font-semibold tracking-wide text-left text-gray-500 uppercase border-b dark:border-gray-700 bg-gray-50 dark:text-gray-400 dark:bg-gray-800 " style="text-align: left;">
                    <th class="px-4 py-3">영화제목</th>
                    <th class="px-4 py-3">포스터</th>
                    <th class="px-4 py-3">제작비</th>
                    <th class="px-4 py-3">제작비 추가/변경</th>
                    <th class="px-4 py-3">개봉일</th>
                  </tr>
                </thead>
                
					
                <tbody class="bg-white divide-y dark:divide-gray-700 dark:bg-gray-800">
                	<c:forEach items="${ requestScope.list }" var="m">
	                  <tr class="text-gray-700 dark:text-gray-400">
						<td class="px-4 py-3">
							<p class="font-semibold">${ m.title }</p>
						</td>
						<td class="px-4 py-3 text-sm">
							<c:if test="${ !empty m.posters }">
								<img alt="" src="${ m.posters }">
							</c:if>
							<c:if test="${ empty m.posters }">
								-
							</c:if>
						</td>
						<td class="px-4 py-3 text-xs">
							${ m.cost }
						</td>
						<td class="px-4 py-3 text-xs">
							<input type = "button" id="fixbtn" class="px-4 py-2 text-sm font-medium leading-5 text-white transition-colors duration-150 bg-purple-600 border border-transparent rounded-lg active:bg-purple-600 hover:bg-purple-700 focus:outline-none focus:shadow-outline-purple " onclick="costInput(0, ${m.id});" value = "추가">
							<input type = "button" id="fixbtn" class="px-4 py-2 text-sm font-medium leading-5 text-white transition-colors duration-150 bg-purple-600 border border-transparent rounded-lg active:bg-purple-600 hover:bg-purple-700 focus:outline-none focus:shadow-outline-purple " onclick="costInput(1, ${m.id});" value = "변경">
						</td>
						<td class="px-4 py-3 text-xs">
							<c:if test="${ !empty m.reprlsdate }">
								${ m.reprlsdate }
							</c:if>
							<c:if test="${ empty m.reprlsdate }">
								-
							</c:if>
							
						</td>
	                  </tr>
					</c:forEach>
                </tbody>
              </table>
            </div>
            
            
			<c:if test="${ empty action }">
			
				<div style="text-align: center;">
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
				<c:if test="${ (currentPage - 10) < startPage and (currentPage - 10) > 0 }">
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
				<c:if test="${ (currentPage + 10) > endPage and ((endPage%10)==0) and listCount > ( endPage*limit ) }">
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

        </div>
          <div class="btn-wrap">
            <button class="list"><a href = "movieCost.do">전체목록</a></button>
          </div>
          
        </div>
      </main>
    </div>
  </div>


	<!-- 검색 목록 페이징 처리 -->
	<br>
</body>
</html>