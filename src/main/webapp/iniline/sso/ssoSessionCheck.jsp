<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<%@page import="kr.co.iniline.swift.sp.api.SPApiManager"%>
<%@page import="kr.co.iniline.swift.common.configuration.ConfigurationManager"%>

<%
	response.setHeader("Pragma", "No-Cache");
	response.setHeader("Cache-Control", "No-Cache");
	response.setHeader("Expires", "-1");

	SPApiManager spApiManager = new SPApiManager(request, response);
	ConfigurationManager configurationManager = (ConfigurationManager)application.getAttribute("SwiftConfigurationManager");

	//SP세션이 없을경우, IDP로 인증메시지 요청
	if(!spApiManager.existSPUserSession()) {
//		session.removeAttribute("USER_ID");
		//session.invalidate();

		// SSO 요청
		String RelayState = request.getParameter("RelayState");
		String entity_id = request.getParameter("entity_id");

		System.out.println("if " + entity_id);
//		if(RelayState == null || RelayState.equals("") || entity_id == null || entity_id.equals("")) {
//			new Exception("RelayState or entity_id is null or \"\"");
//		}
		if(RelayState != null && !RelayState.equals("") && entity_id != null && !entity_id.equals("")) {
			response.sendRedirect(configurationManager.getElementValue(ConfigurationManager.URL) + "/singleSignOn?RelayState=" + RelayState + "&entity_id=" + entity_id);
			return;
		}

	} else {
		//SP세션이 있으면 WAS의 USER_ID 가 없어도 만들어 준다.
		//(이것은 정책에 따라 변경가능)
	//	if(session.getAttribute("USER_ID") == null) {
	//		session.setAttribute("USER_ID", spApiManager.getUserSession().getUserID());

	//	}
	 response.sendRedirect(configurationManager.getElementValue(ConfigurationManager.URL) + "/../intra/main.do");

		System.out.println("else ");
	}

	
//	response.sendRedirect(configurationManager.getElementValue(ConfigurationManager.URL) + "/../intra/login.do");

//	response.sendRedirect(configurationManager.getElementValue(ConfigurationManager.URL) + "/../" + RelayState);
%>
