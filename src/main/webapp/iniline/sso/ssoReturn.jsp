<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page autoFlush="false" %>

<%@page import="kr.co.iniline.swift.sp.api.SPApiManager"%>

<%
	boolean EXIST_SSO_SESSION = false;
	String SSO_USER_ID = null;

	SPApiManager spApiManager = new SPApiManager(request, response);
	EXIST_SSO_SESSION = spApiManager.existSPUserSession();

	if(EXIST_SSO_SESSION) {
//		System.out.println("exist if");
		// SSO Session exist => SSO UserID get
		SSO_USER_ID = spApiManager.getUserSession().getUserID();
	}

	// 군번 있으면 잘라내기
	if(SSO_USER_ID != null && !SSO_USER_ID.equals("")) {
	//	System.out.println("SSO_USER_ID != null"); 
		String[] strArr = SSO_USER_ID.split("\\|");
		SSO_USER_ID = strArr[0];
	}

	String sessionID = spApiManager.getUserSession().getSessionID();
	spApiManager.removeSPUserSession();
	spApiManager.createSPSession(sessionID, SSO_USER_ID);

	// session.setAttribute("sso_Id", SSO_USER_ID);
//	System.out.println("uid : + " + SSO_USER_ID);

	response.sendRedirect("http://11.2.17.190/intra/logina.do?uid="+SSO_USER_ID);
%>
