<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ page import="com.ksign.access.wrapper.sso.sso10.SSO10Conf"%>
<%@ page import="com.ksign.access.wrapper.api.*" %>
<%@ include file="./inc/header.jsp"%>
<%
	String SSO_SERVER = SSOService.getInstance().getServerScheme();
	String AGENT_ADDR = request.getScheme() + "://" + request.getServerName()+ ":" + request.getServerPort() + request.getContextPath();
	
	String errorCode = request.getParameter("errorCode");
	//String errorMsg = request.getParameter("errorMsg");
	String errorMsg = new String(request.getParameter("errorMsg").getBytes("8859_1"), "UTF-8");
	
	String loginedId = "";
	String clientIp = "";
	if("3045".equals(errorCode)) {
		loginedId = errorMsg.substring(errorMsg.indexOf("uid=") + 4, errorMsg.indexOf("&clientip="));
		clientIp = errorMsg.substring(errorMsg.indexOf("&clientip=") + 10, errorMsg.indexOf("]"));
	}
	
	if(errorCode.equals("3045")){
%>
<script language="JavaScript">
		var b = confirm("<%=loginedId %>아이디가 <%=clientIp%>IP에 로그인되어있습니다.  \n이전 로그인을 종료 하시겠습니까?");
		
		if(b) {
			alert("이전 로그아웃을 실행합니다.");
			top.location.href="<%=SSO_SERVER%>/sso/singleLogout.jsp?uid=<%=loginedId%>&returl=<%=AGENT_ADDR%>/sso/logout.jsp"
		} else {
			alert("로그인페이지로 이동합니다.");
			<%SSOService.getInstance().removeSSOToken(request);%>
			top.location.href="<%=AGENT_ADDR%>/sso/index.jsp";
		}
</script>
<%	
	}
%>
<html>
<head>

<title>
errorPage
</title>
</head>
<body bgcolor="#ffffff">
<h1>
<li> error message :: <%=errorMsg%>
<li> error code :: <%=errorCode%>
</h1>
</body>
</html>
