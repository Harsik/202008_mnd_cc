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
<%@ page import="java.security.*" %>
<%@ page import="java.util.Random" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
	
<title>Page Title - 바닥페이지</title>
<script type="text/javascript">
document.write("<script type=\"text/javascript\" src=\"" + "../anySign4PCInterface.js" + "?version=" + new Date().getTime() + "\"></scr"+"ipt>");
</script>

<script type="text/javascript" src="../inca_nos10/pluginfree/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="../inca_nos10/pluginfree/js/jquery-ui-1.10.3.js"></script>
<script type="text/javascript" src="../inca_nos10/pluginfree/jsp/nppfs.script.jsp"></script>
<script type="text/javascript" src="../inca_nos10/pluginfree/js/nppfs-1.0.0.js"></script>

<script language="javascript" type="text/javascript">
<%
    VidVerifier vid = new VidVerifier(new XecureConfig());
    out.println(vid.ServerCertWriteScript());

	// AnySign 세션ID 설정
	String HashedSessionID = "";

	// 1. 고정 세션 ID
	HashedSessionID = "reaverTestSID19810531";
	
	// 2. 웹세션ID 해쉬
	//String id = session.getId();
	//HashedSessionID = cipher.getHash("SHA256",id);

	out.println("AnySign.mAnySignSID = '" + HashedSessionID + "';");
	//


	// 데몬 무결성 검증 기능 선택사항
	String HashedRandomValue = "";
	
	// 1. 무결성 검증 비활성화
	//    AnySign.mAnySignITGT 변수 "" 설정 - 2번 부분 주석처리.
	//

	// 2. 랜덤값 기반 무결성 검증 설정
	//    AnySign.mAnySignITGT = HashedRandomValue
	//
	Cipher cipher = new Cipher( new XecureConfig());
	HashedRandomValue = cipher.getRamdomMsg(30);

	out.println("AnySign.mAnySignITGT = '" + HashedRandomValue + "';");
%>
PrintObjectTag(); 
</script>
<script language="javascript" type="text/javascript">
function onSendToServer(value)
{

	var aRequest = new XMLHttpRequest ();
	var aResponse = "";
	var aURL = "";
	var aMessage = "";

	aURL = "./sign_result.jsp";
	aRequest.open ("POST", aURL, false);
	aRequest.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	aRequest.send ("SIGNED=" + encodeURIComponent(value));

	try
	{
		aResponse = eval (aRequest.responseText);

		if (parseInt (aResponse["code"]) != 0)
		{
			alert ("오류코드:" + aResponse["code"] + "\n" +
				   "오류메시지:" + aResponse["reason"]);
			return;
		}
	}
	catch (evalException)
	{
		alert ("Evaluate exception(" + evalException + "):\n" + aRequest.responseText);
		return;
	}

	aMessage += "사용자 RDN:\n" + aResponse["subjectRDN"] + "\n";
	aMessage += "사용자 인증서:\n" + aResponse["certificatePEM"] + "\n";

	alert (aMessage);

}

function signResult_callback (aResult)
{
	document.getElementById('signature_data').value = aResult;
}

function aUserCallback ()
{
	var aElement = document.getElementById("loadingAnySign");
	aElement.parentNode.removeChild (aElement);
	AnySign.SignDataCMS (AnySign.mXgateAddress, AnySign.mCAList, "hello", 0, "", 3, signResult_callback);
}

function onOKButton(e) {
	document.getElementById('signature_data').value = "";
	document.getElementById("xwup_OkButton").onclick();
}

function initKeyboard () {
	npPfsStartup(document.form1, false, true, false, true, "npkencrypt", "on");
}

function init () {
	initKeyboard();

	AnySign.mIncaNOSv10Enable = true;
	AnySign.mDivInsertOption = 1;
	AnySign.SetUITarget(document.getElementById('certDialog'));	

	setExtension_encCallback (aUserCallback);
}
</script>
</head> 
<body onload="init();">
<form id="form_SignDataCMS" name="form_SignDataCMS" method="post" action="./sign_result2.jsp">
<div id="certDialog"></div>
<img id="loadingAnySign" src="http://reaver.softforum.com/XecureDemo/up/qa_anySign/AnySign4PC/img/loader.gif">
<br>
<!-- result signature data -->
<input type="button" value="OK" onclick="onOKButton(event);">
<p>
<textarea id="signature_data" style="width:940px;height:100px"></textarea>
<br>
<input type="button" value="서버에 확인" onclick="onSendToServer (document.getElementById('signature_data').value); return false;">
</form>
</body>
</html>
