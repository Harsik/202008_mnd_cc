<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<%@page import="kr.co.iniline.swift.common.configuration.ConfigurationManager"%>
<%@page import="kr.co.iniline.swift.sp.api.SPApiManager"%>

<%
	String RelayState = request.getParameter("RelayState");
	if(RelayState == null || RelayState.equals("")) {
		RelayState = "";
	}
	String entity_id = request.getParameter("entity_id");
	if(entity_id == null || entity_id.equals("")) {
		entity_id = "INISwift_IDP_MND";
	}

	SPApiManager spMgr = new SPApiManager(request, response);
	if(spMgr.existSPUserSession()) {
		spMgr.removeSPUserSession();
	}

	session.invalidate();

	ConfigurationManager configurationManager = (ConfigurationManager)application.getAttribute("SwiftConfigurationManager");
	String sloURL = configurationManager.getAgentElementValue(entity_id, ConfigurationManager.URL) +
					"/../iniline/sso/ssoLogOut.jsp?RelayState=" + RelayState;

	response.sendRedirect(sloURL);
%>