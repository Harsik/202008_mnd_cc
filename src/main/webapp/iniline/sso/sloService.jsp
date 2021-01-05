<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@page import="kr.co.iniline.swift.common.configuration.ConfigurationManager"%>
<%
	String entity_id = request.getParameter("entity_id");
	if(entity_id == null || entity_id.equals("")) {
		entity_id = "INISwift_IDP_MND";
	}

	String fullURL = request.getRequestURL().toString();
	String returnURL = fullURL.substring(0, fullURL.indexOf(request.getServletPath()));
	System.out.println("sloService called");
	ConfigurationManager configurationManager = (ConfigurationManager)application.getAttribute("SwiftConfigurationManager");
	String sloURL = configurationManager.getAgentElementValue(entity_id, ConfigurationManager.URL) +
					"/../iniline/sso/ssoLogOut.jsp?RelayState=" + returnURL;
	response.sendRedirect(sloURL);
%>
