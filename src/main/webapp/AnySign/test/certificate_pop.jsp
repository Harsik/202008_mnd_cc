<%@ page contentType="text/html; charset=utf-8" %>
<%@ page buffer="16kb" %>
<%
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<%@ page import="xecure.servlet.*" %>
<%@ page import="xecure.crypto.*" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
	<title>Test Page</title>
	
	<link rel="stylesheet" type="text/css" href="../XecureWeb/css/common.css" />
			
	<script type="text/javascript" src="../xecureweb_up.js"></script>
	<script type="text/javascript" src="../transkey/BigInt.js"></script>
	<script type="text/javascript" src="../transkey/Barrett.js"></script>
	<script type="text/javascript" src="../transkey/RSA.js"></script>
	<script type="text/javascript" src="../transkey/wz_jsgraphics.js"></script>
	<script type="text/javascript" src="../transkey/transkey_XC.js"></script>
	<script type="text/javascript" src="../transkey/seed.js"></script>
	<script type="text/javascript" src="../transkey/genkey.js"></script>
	<script language="javascript" type="text/javascript">
	//<![CDATA[
		PrintObjectTag(); 
	//]]>
	</script>
	<script language="javascript" type="text/javascript">
	//<![CDATA[
	
	var useTranskey = false;
	function makeSign( )
	{
		XecureWeb.SetUITarget(document.getElementById('signbtn'));	
		XecureWeb.SignDataCMS (XecureWeb.mXgateAddress, XecureWeb.mCAList, "hello", 768, "", 3, signResult_callback);
		return false;
	}

	function signResult_callback (aResult)
	{
		alert(aResult);
	}
	//]]>
	</script>
</head> 
<body>


<div class="btn-area mb50">
	<a href="#" type="button" id='signbtn' onClick='return makeSign();return false;'  >확인확인확인</a>
</div>
<div class="btn-area mb50">
	<a href="#" type="button" id='signbtn' onClick='ShowCertManager();return false;' > 인증서관리자</a>
</div>
</body>
</html>
