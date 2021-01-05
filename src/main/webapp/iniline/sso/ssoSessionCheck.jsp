<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<%@page import="kr.co.iniline.swift.sp.api.SPApiManager"%>
<%@page import="kr.co.iniline.swift.common.configuration.ConfigurationManager"%>

<%
	response.setHeader("Pragma", "No-Cache");
	response.setHeader("Cache-Control", "No-Cache");
	response.setHeader("Expires", "-1");

	SPApiManager spApiManager = new SPApiManager(request, response);
	ConfigurationManager configurationManager = (ConfigurationManager)application.getAttribute("SwiftConfigurationManager");

	//SP������ �������, IDP�� �����޽��� ��û
	if(!spApiManager.existSPUserSession()) {
//		session.removeAttribute("USER_ID");
		//session.invalidate();

		// SSO ��û
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
		//SP������ ������ WAS�� USER_ID �� ��� ����� �ش�.
		//(�̰��� ��å�� ���� ���氡��)
	//	if(session.getAttribute("USER_ID") == null) {
	//		session.setAttribute("USER_ID", spApiManager.getUserSession().getUserID());

	//	}
	 response.sendRedirect(configurationManager.getElementValue(ConfigurationManager.URL) + "/../intra/main.do");

		System.out.println("else ");
	}

	
//	response.sendRedirect(configurationManager.getElementValue(ConfigurationManager.URL) + "/../intra/login.do");

//	response.sendRedirect(configurationManager.getElementValue(ConfigurationManager.URL) + "/../" + RelayState);
%>
