<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="com.ksign.access.wrapper.api.*" %>

<%
	String fed = request.getParameter("federation");
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">

<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>login_stand</title>
<link rel="stylesheet" href="./css/purple_index_style.css" type="text/css" media="all" />
<link rel="stylesheet" href="./css/join.css" type="text/css" media="all" />
<script language="javascript" src="axkcase.js"></script>
<script language="javascript">
function CheckAX()
{
	var Installed = false;
	// AxKSignCASE 프로젝트 일때
	var KSIGNActiveXProgID = "Axsungkyul.Axsungkyul.1"
	
	try
	{
		var xObj = new ActiveXObject(KSIGNActiveXProgID);
	
		if(xObj){
			Installed = true;
		}
		else
		{
			Installed = false;
		}
	}
	catch(ex)
	{
		Installed = false;
	}
	
	return Installed;
} 

function LoginData2(form)
{

	var dn;
	var signeddata;
	
	if(!CheckAX()) {
		alert("클라이언트 프로그램이 설치되지 않아 수행할 수 없습니다.");
		return;
	}

	dn = document.AxKCASE.SelectCert();
	if ((dn == null) || (dn == ""))
	{
		if(document.AxKCASE.GetErrorCode() != -1)
			alert(document.AxKCASE.GetErrorContent());
		return;
	}

	signeddata = document.AxKCASE.SignedData(dn, "", dn);
	if( signeddata == null || signeddata == "" )
	{
		errmsg = document.AxKCASE.GetErrorContent();
		errcode = document.AxKCASE.GetErrorCode();
		alert( "인증서 로그인 오류 :"+errmsg );
		return;
	}
	
	form.signed_data.value = signeddata;
	form.submit();
}

function login(){
	var f = document.login_form;
		var uid = f.uid.value;
		var pwd = f.password.value;
		
		if(uid == ""){
			alert("아이디를 입력하세요");
			f.uid.focus();
			return;
		}
		if(pwd == ""){
			alert("비밀번호를 입력하세요");
			return;
		}
		if('<%=fed%>'!='null'){
			f.federation.value='<%=fed%>';
		}
		f.action="login_proc.jsp";
		f.submit();

}
function check(){
	if(event.keyCode==13){
		login();
	}
}

</script>

</head>
<body>
<div class="login"><img src="../images/intra/login.jpg"></div>
<%--
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
		                  <li>해당 화면은 통합인증(SSO) 연계를 위해 가상으로 개발된 샘플 기관 로그인 페이지로 화면 UI는 적용되지 않았으나<br> 기능적으로 정상동작하는 화면입니다</li>
		                </ul>
		                
		                <form action="./login_proc.jsp" method="post" name="login_form">
						<input name="federation" type="hidden" value='<%=fed%>' size="20" maxlength="20">
                        <fieldset>
                            <label for="loginId">아이디</label> 
                            <input type="text" name="uid" value="" Style="ime-mode:inactive"  class="input_txt" id="loginId" onkeypress=""/> <br/>
                            <label for="loginPassword">비밀번호</label>
							<input type="password" name="password" Value="" id="loginPassword" class="input_txt pw" onkeypress="javascript:check();"/> 
                            <a class="buttonLogin" onClick="javascript:login();"></a><br>
                        </fieldset>
					 <br>
         	<form action="./sampleSignedData_All.jsp" method="post" name="SignedData">
    	<div align="right">
		  <input type="hidden" value="" name="signed_data" size="0">
          <!--input type="button" value=" 인증서 로그인(SignData) " onClick="javascript:LoginData2(this.form)"-->
		  <input class="button orange" type="button" value="공인 인증서 로그인 ▶▶" onClick="javascript:LoginData2(this.form)">
        </div>
	</form>
		  </form>
                    </div>
                    <!-- //loginArea -->
                </form>
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
	<object id="AxKCASE"  classid="CLSID:70C53AC1-10FB-40e2-9D46-C611501E4017"
codebase="./Axsungkyul(3.5.3.1).cab#Version=3,5,3,1" width= Document.body.clientWidth height= Document.body.clientHeight>
</object>
--%>
</body>
</html>
