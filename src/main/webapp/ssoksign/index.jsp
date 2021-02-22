<%@ page contentType="text/html; charset=euc-kr"%>

<%@ page import="org.springframework.beans.factory.annotation.Autowired"%>
<%@page  import="com.ksign.access.wrapper.sso.sso10.SSO10Conf"%>
<%@ page import="com.ksign.access.wrapper.api.*"%>

<%	
// 	SSORspData rspData = null;
// 	SSOService ssoService = SSOService.getInstance();
// 	rspData = ssoService.ssoGetLoginData(request);
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
</body>
</html>
