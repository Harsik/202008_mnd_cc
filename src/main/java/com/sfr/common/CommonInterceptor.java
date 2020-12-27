package com.sfr.common;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class CommonInterceptor extends HandlerInterceptorAdapter {

	protected final Logger logger = LoggerFactory.getLogger(this.getClass());
	// 예외 페이지 목록
	static final String[] EXCLUDE_URL_LIST = {
		  "/operator/login"
		, "/operator/test"
		, "/operator/loginProc"
		, "/admin/login"
		, "/admin/loginProc"
		, "/intra/login"
		, "/intra/logina"
		, "/intra/loginb"
		, "/intra/loginc"
		, "/intra/logind"
		, "/intra/loginU"
		, "/operator/ivrCallUser"
		, "/operator/blockCheck"
		, "/operator/reqPrompt"
	};

	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		//logger.debug("preHandle==>") ;
		String reqUri = request.getRequestURI();
		logger.debug("Request URI \t:  " + reqUri);
		
		// 헤더 전체정보 보기
		Enumeration<String> em = request.getHeaderNames();
		 
		while(em.hasMoreElements()){
			String name = em.nextElement() ;
			String val = request.getHeader(name) ;
			logger.debug(name + " : " + val) ;
		}
		 
		// 이전 접속 페이지 가져오기
		String h_referer = request.getHeader("referer") ;
		logger.debug("referer : " + h_referer) ;
		 
		// 사용자의 브라우저 확인
		String h_agent = request.getHeader("User-Agent") ;
		logger.debug("User-Agent : " + h_agent) ;

		// 로그인 세션 없으면 로그인 페이지로 이동 (login.do 페이지 제외)
		for (String target : EXCLUDE_URL_LIST) {
			if(request.getRequestURI().indexOf(target) > -1) {
				System.out.println(">> Interceptor skip");
				return true;
			}
		}
		
		if(request.getSession().getAttribute("user_id") == null || "".equals(request.getSession().getAttribute("user_id"))){
			
			if(reqUri.indexOf("/admin/") >-1){
				response.sendRedirect("/admin/login.do");
			}else if(reqUri.indexOf("/intra/") >-1){
				response.sendRedirect("/intra/login.do");
			}else{
				response.sendRedirect("/operator/login.do");
			}
			
        	
			//request.getRequestDispatcher("/common/noAuth.do").forward(request, response);
        	return false;
        }
		
		
	
		// 관리자가 아닌 경우 /admin/ 못들어감
		if(reqUri.indexOf("/admin/") >-1){
			if(!("0".equals(request.getSession().getAttribute("userCd"))||"3".equals(request.getSession().getAttribute("userCd")))){
				response.sendRedirect("/admin/login.do");
				return false;
			}
		}	
		
		
		// 교환원 아닌 경우 /operator/ 못들어감
		if(reqUri.indexOf("/operator/") >-1){
			if(!"1".equals(request.getSession().getAttribute("userCd"))){
				response.sendRedirect("/operator/login.do");
				return false;
			}
		}
		
		// 일반사용자가 아닌 경우 /intra/ 못들어감
	/*	if(reqUri.indexOf("/intra/") >-1){
			if(!"2".equals(request.getSession().getAttribute("userCd"))){
				response.sendRedirect("/intra/login.do");
				return false;
			}
		}*/
		
		
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		//logger.debug("postHandle==>") ;
		super.postHandle(request, response, handler, modelAndView);
	}
	
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
		//logger.debug("afterCompletion==>") ;
		super.afterCompletion(request, response, handler, ex);
	}
	
	@Override
	public void afterConcurrentHandlingStarted(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		//logger.debug("afterConcurrentHandlingStarted==>") ;
		super.afterConcurrentHandlingStarted(request, response, handler);
	}

}

