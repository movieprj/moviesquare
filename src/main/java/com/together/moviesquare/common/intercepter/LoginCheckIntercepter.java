package com.together.moviesquare.common.intercepter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.together.moviesquare.member.vo.Member;


@SuppressWarnings("deprecation")
public class LoginCheckIntercepter extends HandlerInterceptorAdapter  {
	//public class LoginCheckInterceptor implements AsyncHandlerInterceptor {
		private Logger logger = LoggerFactory.getLogger(getClass());
		
		@Override
		public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
			HttpSession session = request.getSession();
			Member loginMember = 
					(Member)session.getAttribute("loginMember");
			
			if(loginMember != null) {
				logger.info("로그인 상태 : " + request.getRequestURI() + " 요청");			
			}else {
				logger.info("비로그인 상태 : " + request.getRequestURI() + " 요청");
				
				String referer = request.getHeader("Referer");
				logger.info("Referer : " + referer);
				
				String origin = request.getHeader("Origin");
				
				String url = request.getRequestURL().toString();
				
				String uri = request.getRequestURI();
				
				//크롬 브라우저일 때
				if(origin == null) {
					origin = uri.replace(uri, "");
				}
				
				String location = referer.replace(origin + request.getContextPath(), "");
				
				request.setAttribute("loc", location);
				request.setAttribute("message", "로그인해야 이용할 수 있는 서비스입니다.");
				request.getRequestDispatcher("/WEB-INF/views/common/error.jsp").forward(request, response);
				return false;
			}
			return super.preHandle(request, response, handler);
		}
		
	}