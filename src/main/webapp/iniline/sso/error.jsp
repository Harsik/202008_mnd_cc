<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="kr.co.iniline.swift.common.service.SwiftErrorHandler"%>
<%@page import="kr.co.iniline.swift.common.service.SwiftError"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<%
	SwiftError swiftError = (SwiftError)session.getAttribute("SwiftError");
%>
<body>
	SP Error 페이지<br>
	---------------------------------------------------------------<br>
<%
	if(swiftError != null) {
%>
	<%=swiftError.getErrorCode()%> : <%=swiftError.getErrorMsg()%>
<%
	}
%>
</body>
</html>