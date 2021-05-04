<%@ page contentType="text/html; charset=euc-kr"%>

<%@ page import="org.springframework.beans.factory.annotation.Autowired"%>
<%@page  import="com.ksign.access.wrapper.sso.sso10.SSO10Conf"%>
<%@ page import="com.ksign.access.wrapper.api.*"%>

<%	
	SSORspData rspData = null;
	SSOService ssoService = SSOService.getInstance();
	rspData = ssoService.ssoGetLoginData(request);
	System.out.print("SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>index</title>
	<link rel="stylesheet" href="./css/purple_index_style.css" type="text/css" media="all" />
	<link rel="stylesheet" href="./css/join.css" type="text/css" media="all" />
	<script type="text/javascript"	src="./js/jquery-3.3.1.js"></script>
	<script>
	var id = "<%=session.getAttribute("uid")%>";
	alert("pmi-sso.jsp	::: uid >>> "+id);
		$(document).ready(function(){
			if(id != "" && id != "null" && id != null){
				$.ajax({   
					url:"/intra/loginUAjax.do",
					type:"post",
					dataType:'json',
					data:{
						"id" : id
					},
					success:function(data) {
						//alert(data);
						//console.log(data);
						if(data.code == '0'){
							location.href = "/intra/main.do";
						}else {
							alert(data.msg);
							location.href = "/intra/login.do";
						}
					}
				}); 
			}else{
				//PKI
				location.href = "/intra/login.do";
			}
			 
		});
	</script>
</head>
<body bgcolor="#ffffff">
<div id="container">
        <div class="loginWrap">
            <div id="header">
                <div id="top">
                    <h1 class="logo" title="">
                        <a href="#" title="KSIGN">KSIGN</a>
                    </h1>
                </div>
            </div>
            
            <div class="loginAreaWrap">
                    <div class="loginArea">
	                    <h2>SSO Login</h2>
		                <ul>
		                  <li>해당 화면은 통합인증(SSO) 연계를 위해 가상으로 개발된 로그인 페이지로 회원정보를 출력합니다.</li>
		                </ul>
<fieldset>
<font color="gray"><p align="right"><a href="http://agent1.jun.com:8081/ssoAgent1/sso/index.jsp"><b>Home </a> | <a href="http://agent2.jun.com:7081/ssoAgent2/sso/index.jsp">Site 1</a> | <a href="http://agent2.jun.com:7081/ssoAgent2/sso/index.jsp">Site 2</a> | <a href="http://agent2.jun.com:7081/ssoAgent2/sso/index.jsp">Site 3</b></a></p></font></br>

 <label>UID : <%=rspData.getAttribute(SSO10Conf.UIDKey)%></label> <br /> 
 <label>AM : <%=rspData.getAttribute(SSO10Conf.AMKey)%></label><br />
 <label>TS : <%=rspData.getAttribute(SSO10Conf.TSKey)%></label><br /> 
 <label>CP : <%=rspData.getAttribute(SSO10Conf.CPKey)%></label>
  <label>NAME : <%=rspData.getAttribute("name")%></label>


<form action="./logout.jsp" method="post" name="login_form">
<p align="right"><input name="login" value="logout" type="submit"></p>
</form>
</fieldset>
</div>
 <div class="adArea">
                    <a href="#" target="_blank"><img src="./images/ksign_banner.png" alt="banner" align="center"/></a>
                </div>
                <!-- //bannerArea -->
            </div>
            <!-- //loginAreaWrap -->
            <div class="footer">
                <span class="copy">COPYRIGHT(C) 2009<strong> KSIGN</strong>. ALL RIGHT RESERVED.</span>
            </div>
        </div>
        <!-- //loginWrap -->
    </div>
    <!-- //container -->
</body>
</html>
