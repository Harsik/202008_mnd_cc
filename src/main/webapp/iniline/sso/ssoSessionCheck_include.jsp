<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<!--%@include file="/iniline/sso/ssoSessionCheck_include.jsp"%-->

<%@page import="kr.co.iniline.swift.sp.api.SPApiManager"%>

<%
	boolean EXIST_SSO_SESSION = false;
	String SSO_USER_ID = null;

	SPApiManager spApiManager = new SPApiManager(request, response);
	EXIST_SSO_SESSION = spApiManager.existSPUserSession();

	if(EXIST_SSO_SESSION) {
		// SSO 세션 존재함  => SSO 사용자ID 얻음
		try{
		SSO_USER_ID = spApiManager.getUserSession().getUserID();
		}catch(Exception e) {
			e.printStackTrace();
		}

	}
%>

<!--%
	System.out.println("EXIST_SSO_SESSION : " + EXIST_SSO_SESSION);
	System.out.println("SSO_USER_ID : " + SSO_USER_ID);

	String id = null;
	if(EXIST_SSO_SESSION) {
		// SSO 세션 존재함  => SSO 사용자ID 얻음
		// WAS 세션 생성처리
		id = SSO_USER_ID;
	} else {
		// SSO 세션 존재하지 않음  => 어플리케이션별 처리(ex. 개별로그인 페이지 호출)
		// WAS 세션 종료처리
		response.sendRedirect("/index.jsp");
		return;
	}

	/*
		id 로 원래 구현된 비지니스 로직을 수행
	*/
%-->
