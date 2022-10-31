package com.together.moviesquare.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

@SuppressWarnings("deprecation")
public class LoggerInterceptor extends HandlerInterceptorAdapter {
	//log4j.xml 에서 debug 레벨로 로그를 남기도록 설정하고,
	//LoggerFactory.getLogger 메소드의 매개변수로 현재 클래스를 전달함

	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Override
	public boolean preHandle(HttpServletRequest request, 
			HttpServletResponse response, 
			Object handler) throws Exception {
		//DispatcherServlet 에서 Controller 로 가기 전에 구동됨
		
		if(logger.isDebugEnabled()) {
			logger.debug("============== START ============");
			logger.debug(request.getRequestURI());
			logger.debug("=================================");
		}
		
		return super.preHandle(request, response, handler);  //true 리턴
	}
	
	@Override
	public void postHandle(HttpServletRequest request, 
			HttpServletResponse response, 
			Object handler, 
			ModelAndView modelAndView) throws Exception {
		//Controller 에서 리턴되어 뷰리졸버로 가기 전에 구동됨
		super.postHandle(request, response, handler, modelAndView);
		
		if(logger.isDebugEnabled()) {
			logger.debug("------------- view ----------------");
		}
	}
	
	@Override
	public void afterCompletion(HttpServletRequest request, 
			HttpServletResponse response, 
			Object handler, Exception ex	) throws Exception {
		//뷰리졸버가 뷰를 찾아서 내보내고 나면 구동됨
		if(logger.isDebugEnabled()) {
			logger.debug("=========== END ===========");
		}
		
		super.afterCompletion(request, response, handler, ex);
	}
}
