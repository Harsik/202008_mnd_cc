<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<!--%@include file="/iniline/sso/ssoSessionCheck_include.jsp"%-->

<%@page import="kr.co.iniline.swift.sp.api.SPApiManager"%>

<%
	boolean EXIST_SSO_SESSION = false;
	String SSO_USER_ID = null;

	SPApiManager spApiManager = new SPApiManager(request, response);
	EXIST_SSO_SESSION = spApiManager.existSPUserSession();

	if(EXIST_SSO_SESSION) {
		// SSO ���� ������  => SSO �����ID ����
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
		// SSO ���� ������  => SSO �����ID ����
		// WAS ���� ����ó��
		id = SSO_USER_ID;
	} else {
		// SSO ���� �������� ����  => ���ø����̼Ǻ� ó��(ex. �����α��� ������ ȣ��)
		// WAS ���� ����ó��
		response.sendRedirect("/index.jsp");
		return;
	}

	/*
		id �� ���� ������ �����Ͻ� ������ ����
	*/
%-->
