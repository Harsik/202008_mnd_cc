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
	
<title>Page Title - 우리은행</title>
	
<link rel="stylesheet" type="text/css" href="../XecureWeb/css/common.css" />
			
<script type="text/javascript" src="../xecureweb_up.js"></script>
<script language="javascript" type="text/javascript">
//<![CDATA[
	PrintObjectTag(); 
//]]>
</script>
<script language="javascript" type="text/javascript">
//<![CDATA[

function signResult_callback (aResult)
{
	document.getElementById('signature_data').value = aResult;
}
//]]>
</script>
</head> 
<body>

<div id="certDialog"></div>
<br>
전자서명 결과<br>
<textarea id="signature_data" style="width:945px"></textarea>
<!-- result vid data -->
<br><br>

<script type="text/javascript">
XecureWeb.mDivInsertOption = 2;
XecureWeb.SetUITarget(document.getElementById('certDialog'));	
XecureWeb.SignDataCMS (XecureWeb.mXgateAddress, XecureWeb.mCAList, "hello", 0, "", 3, signResult_callback);
</script>
</body>
</html>
