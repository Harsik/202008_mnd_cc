package com.sfr.common;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.core.MethodParameter;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

public class CustomMapArgumentResolver implements HandlerMethodArgumentResolver {

	@Override
	public boolean supportsParameter(MethodParameter parameter) {
	    return CommandMap.class.isAssignableFrom(parameter.getParameterType());
	}
	
	@Override
	public Object resolveArgument(MethodParameter parameter, ModelAndViewContainer mavContainer, NativeWebRequest webRequest, WebDataBinderFactory binderFactory) throws Exception {

	    CommandMap commandMap = new CommandMap();
	
	    HttpServletRequest request = (HttpServletRequest) webRequest.getNativeRequest();
	    Enumeration<?> enumeration = request.getParameterNames();
	
	    String key = null;
	    String[] values = null;
	
	    while(enumeration.hasMoreElements()){
	
	        key = (String) enumeration.nextElement();
	        values = request.getParameterValues(key);
	        if(values != null){
	            commandMap.put(key, (values.length > 1) ? values:values[0] );
	        }
	    }
	    
	    //commandMap 의 UserInfo 에 세션값 담아준다. 
	    HttpSession session = request.getSession();

		commandMap.setUserId((String) session.getAttribute("user_id"));
		commandMap.setUserName((String)  session.getAttribute("user_name"));

	    return commandMap;
	}

}
