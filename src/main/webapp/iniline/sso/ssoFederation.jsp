<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page autoFlush="false" %>

<%@ page import="java.util.Enumeration"%>
<%@ page import="java.util.Hashtable"%>
<%@page import="kr.co.iniline.swift.sp.api.SPApiManager"%>
<%@page import="kr.co.iniline.swift.common.configuration.ConfigurationManager"%>

<%
	response.setHeader("Pragma", "No-Cache");
	response.setHeader("Cache-Control", "No-Cache");
	response.setHeader("Expires", "-1");

	SPApiManager spApiManager = new SPApiManager(request, response);
	ConfigurationManager configurationManager = (ConfigurationManager)application.getAttribute("SwiftConfigurationManager");

	if(!spApiManager.existSPUserSession()) {
		String RelayState = request.getParameter("RelayState");
		String entity_id = request.getParameter("entity_id");
		if(RelayState == null || RelayState.equals("")) {
			RelayState = "iniline/sso/ssoReturn.jsp";
		}
		if(entity_id == null || entity_id.equals("")) {
			entity_id = "INISwift_IDP_MND";
		}

		response.sendRedirect(configurationManager.getElementValue(ConfigurationManager.URL) + "/singleSignOn?RelayState=" + RelayState + "&entity_id=" + entity_id);
		return;
	} else {
		response.sendRedirect("/iniline/sso/ssoReturn.jsp");
	}
%>

