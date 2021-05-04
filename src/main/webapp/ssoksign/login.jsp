<%@ page import="com.ksign.access.wrapper.api.SSOService"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="KR">
<head>
<title>KSignAccess Agent Login Sample</title>
<%@ include file="/ssoksign/inc/header.jsp"%>
<link rel="stylesheet" href="http://getbootstrap.com/examples/signin/signin.css">
</head>
<%
	SSOService ssoServ = SSOService.getInstance();
	String SSO_SERVER = ssoServ.getServerScheme();
	
	String gid = ssoServ.getGid();
	String preFixedLoginUri = "/pmi-sso-login-uid-password.jsp";
	String preFixedStdLoginUri = "/ssoksign/login_proc.jsp";
	
	String returl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
	
/* 	response.addHeader("Access-Control-Allow-Headers", "authorization, x-requested-with, Authorization");
	response.addHeader("Access-Control-Allow-Methods", "POST, PUT, GET, OPTIONS");
	response.addHeader("Access-Control-Request-Headers", "authorization, x-requested-with, Authorization");
	//response.addHeader("Access-Control-Allow-Origin", "http://127.0.0.1:8081/");

	response.addHeader("Access-Control-Allow-Origin", "*");

	response.addHeader("Access-Control-Max-Age", "86400");
	response.addHeader("Access-Control-Expose-Headers", "authorization, x-requested-with, Authorization"); */
%>

<body>
	<div class="container">
		<form class="form-signin" id="login_form" method="POST">
			<h2 class="form-signin-heading"><%= gid %> Login</h2>
			<label for="inputEmail" class="sr-only">Email address</label>
			<input type="text" id="uid" class="form-control" name="uid" placeholder="Login Id" value="mpjb012914" required autofocus>
			<label for="inputPassword" class="sr-only">Password</label>
			<input type="password" id="password" name="password" class="form-control" value="1234" placeholder="Password" required>
			<input type="hidden" id="gid" name="gid" class="form-control" value="<%= gid %>" required>
			<input type="hidden" id="returl" name="returl" class="form-control" value="<%=returl %>" required>
			
			<button class="btn btn-lg btn-primary btn-block" type="button" id="int_login" >Intergrate</button>
			<button class="btn btn-lg btn-primary btn-block" type="button" id="std_login" >StandAlone</button>
			
			<button class="btn btn-lg btn-warning btn-block" type="button" id="clientBtn" >read client</button>
		</form>
	</div>

<%@ include file="/ssoksign/inc/base_js.jsp"%>

<script src="<%= request.getContextPath() %>/ssoksign/js/cesco_client.js"></script>
<script src="<%= request.getContextPath() %>/ssoksign/js/bluebird.min.js"></script>

<script>
	$(document).ready(function(){
		$("#int_login").click(function() {
			if(!fieldCheck()) return;
			//var data = $("#login_form").serialize(); 
			
<%-- 			$("#login_form").attr("action", "<%=SSO_SERVER + preFixedLoginUri%>"); //$("#login_form").attr("action", "http://sso.mous.mil:8080/pmi-sso-login-uid-password.jsp"); --%>
			$("#login_form").attr("action", "http://localhost:8080/ssoksign/index.jsp");
			$("#login_form").submit();
		});
		
		$("#std_login").click(function() {
			if(!fieldCheck()) return;
			var data = $("#login_form").serialize(); 
			
			$("#login_form").attr("action", "<%=preFixedStdLoginUri%>?" + data);
			$("#login_form").submit();
		});
		
		$("#clientBtn").click(function(e) {
			//init().then(get);
			get();
			
			
		});
	});
	
	function initMessage() {
		var msg = {
<%-- 				"version" : "1.0.0.1", "serverInfo" : {"HostName" : "<%= SSO_SERVER %>", "PortNum" : 8443, "useSSL" : true,  "SessionInterval" : 2} //SSO_SERVER : http://sso.mous.mil:8080 --%>
				"version" : "1.0.0.1", "serverInfo" : {"HostName" : "http://localhost:8080", "PortNum" : 8443, "useSSL" : true,  "SessionInterval" : 2} 
		}
		return msg;
	}

	
	function fieldCheck() {
		var uid =  $("#uid").val();
		var passwd =  $("#password").val();
	
		if(uid.trim() == '') {
			alert("Id가 입력되지 않았습니다.")
			$("#uid").focus();
			return false;
		}	
		
		if(passwd.trim() == '') {
			alert("비밀번호가 입력되지 않았습니다.")
			$("#password").focus();
			return false;
		}
		
		return true;
	}
</script>
</body>
</html>
