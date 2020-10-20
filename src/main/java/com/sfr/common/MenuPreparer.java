package com.sfr.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.tiles.Attribute;
import org.apache.tiles.AttributeContext;
import org.apache.tiles.preparer.ViewPreparer;
import org.apache.tiles.request.Request;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;


public class MenuPreparer implements ViewPreparer {
	
	@Override
	public void execute(Request request, AttributeContext attributeContext) {
		
	    HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
	    HttpSession session = httpServletRequest.getSession();

	    String user_name = (String)session.getAttribute("user_name");		

	    attributeContext.putAttribute("user_name", new Attribute(user_name), true);
	}
}