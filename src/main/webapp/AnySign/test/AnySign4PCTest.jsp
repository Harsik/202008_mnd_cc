<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="xecure.servlet.*" %>
<%@ page import="xecure.crypto.*" %>
<%@ page import="java.security.*" %>
<%@ page import="java.util.Random" %>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>
<%
	String charset = "utf-8";
	String sign_result_page = "./sign_result.jsp";
	String sign_result1_page = "./sign_result1.jsp";
	String sign_result2_page = "./sign_result2.jsp";
	String sign_result3_page = "./sign_result3.jsp";
	
	String link_charset = "euc-kr";
	String link_page = "./AnySign4PCTest_euckr.jsp";
%>
<html>
<head>
<title>AnySign4PC/AnySignLite TEST</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="cache-control" content="no-cache">
<style type="text/css">
<!--
form			{margin:0px 0px 0px 0px;}
input.largebtn	{ width: 500px; }
input.mediumbtn	{ width: 300px; }
input.smallbtn	{ width: 150px; }
h1, h2, h3, h4  { margin:0;}
h3              { font-size:13pt; background-color:#EEE;}
.test			{border:1px dashed gray;}
.test td		{font-size: 9pt;color: #333333;background: #EEEEEE;text-align: center;}
select.combo	{width:150px; font-size: 9pt;color: #333333;;}
.inputtext		{width: 100%;}
.inputtextarea	{width: 100%;word-break:break-all;}
ainput{border:0px; margin:2px; padding:1px;}
.inputbutton	{width: 100%;height: 100%; border:1px solid #d3d3d3; margin:2px; padding:1px;}
.inputcheck		{width: 14px;height: 14px;}
-->
</style>

<!-- nProtect KeyCrypt HTML5
<script type="text/javascript" src="../inca/resource/js/jquery-1.6.2.min.js"></script>
<script type="text/javascript" src="../inca/nppfs-1.3.0.js"></script-->

<!-- nProtect Online Security V1.0 -->
<script type="text/javascript" src="../inca_nos10/pluginfree/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="../inca_nos10/pluginfree/js/jquery-ui-1.10.3.js"></script>
<script type="text/javascript" src="../inca_nos10/pluginfree/jsp/nppfs.script.jsp"></script>
<script type="text/javascript" src="../inca_nos10/pluginfree/js/nppfs-1.0.0.js"></script>

<!-- ezKeyTec-->
<script type="text/javascript" src="../ezKeyTec/eztyiptcrypt.min.js"></script>

<script type="text/javascript">
document.write("<script type=\"text/javascript\" src=\"" + "../anySign4PCInterface.js" + "?version=" + new Date().getTime() + "\"></scr"+"ipt>");
</script>

<!-- TouchEn nxKey -->
<script type="text/javascript" src="../touchennxkey/nxKey/js/TouchEnNxKey.js"></script>

<!-- Openkeyboard
<SCRIPT type="text/javascript" src="../besoft/openkeyboard/openkeyboard_ac.js"></SCRIPT>
 -->

<!-- AhnLab Safe Transaction -->
<script type="text/javascript" src="../AOS2/astx2.min.js"></script>
<script type="text/javascript" src="../AOS2/astx2_ml.min.js"></script>
<script type="text/javascript" src="../AOS2/astx2_jq.min.js"></script>
<script type="text/javascript" src="../AOS2/astx2_custom.js"></script>

<!-- Kings Online Security -->
<script type="text/javascript" src="../KOS/kdfense_object.js"></script>

<!-- XecureKeyPad Plugin
<script type="text/javascript" src="../XecureKeyPad/js/xkeypad_config.js"></script>
<script type="text/javascript" src="../XecureKeyPad/js/xkeypad_plugin.js"></script>
-->

<!-- XecureKeyPad HTML5
<script type="text/javascript" src="../XecureKeypad_html5/js/xkeypad_config.js"></script>
<script type="text/javascript" src="../XecureKeypad_html5/js/xkeypad_html5.js"></script>
 -->
 
 <!-- XecureKeyPad Plugin, Lite(HTML5), E2E(XFS) -->
<script type="text/javascript" src="../XecureKeypad2/js/xkeypad_config.js"></script>
<script type="text/javascript" src="../XecureKeypad2/js/xkeypad_html5.js"></script>
<script type="text/javascript" src="../XecureKeypad2/js/xkeypad_plugin.js"></script>
<script type="text/javascript" src="../XecureKeypad2/js/xkeypad_desktop.js"></script>

<script language='javascript'>
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

	// 데몬 무결성 검증 기능 선택사항
	String HashedRandomValue = "";
	
	// 1. 무결성 검증 비활성화
	//    AnySign.mAnySignITGT 변수 "" 설정 - 2번 부분 주석처리.
	//

	// 2. 랜덤값 기반 무결성 검증 설정
	//    AnySign.mAnySignITGT = HashedRandomValue
	//
	//Cipher cipher = new Cipher( new XecureConfig());
	//HashedRandomValue = cipher.getRamdomMsg(30);

	out.println("AnySign.mAnySignITGT = '" + HashedRandomValue + "';");
%>
// AnySign4PC 설치 확인 및 초기화
//PrintObjectTag ();
AnySign.mCharset = "<%=charset%>";
</script>
<script>
var useTranskey = false;
var aSessionKey = "";

function init()
{
	initForm();
	numbering();
	checkCommonSetting();
	checkAnySign4PC();
	checkAnySignLite();
	checkXecureFreeSign();
	checkKeyboard();
	
	// 키보드 보안 모듈 초기화
	//initKeyboard();
	
	/*
	document.getElementById("cert_login").onclick = function () {
		AnySign.SignDataCMS ("reaver.softforum.com:20443:20999",
							 "Root CA,XecurePKI51 ca,cn=CA131000010,pki50ca,pki70_test_CA,CA131000002Test,CA131000002,CA131000010,Softforum CA 3.0,SoftforumCA,yessignCA-OCSP,signGATE CA,signGATE CA4,SignKorea CA,SignKorea CA2,CrossCertCA,CrossCertCA2,CrossCertCA-Test2,3280TestCAServer,NCASignCA,TradeSignCA,TradeSignCA2,yessignCA-TEST,lotto test CA,NCATESTSign,SignGateFTCA,SignKorea Test CA,SignKorea Test CA2,TestTradeSignCA,Softforum Demo CA,mma ca,병무청 인증기관,MND CA,signGATE FTCA02,.ROOT.CA.KT.BCN.BU,CA974000001,setest CA,3280TestCAServer,yessignCA-Test Class 0,yessignCA-Test Class 1,yessignCA-Test Class 2,TradeSignCA2009Test2,yessignCA,yessignCA Class 1,CrossCertTestCA2,1024TestCA,CA130000031T,CA131000031T,CA131100001,CA134040001,Test1024CA,subca,subca_02",
							 "이 내용이 전자서명됩니다.",
							 512,
							 "",
							 "3",
							 SignDataCMS_callback);
	}
	*/
}

function sumCheckbox (aCheckbox)
{
	var aIter;
	var aTotal = 0;

	for (aIter = 0;aIter < aCheckbox.length;aIter++)
	{
		if (aCheckbox[aIter].checked)
			aTotal += parseInt (aCheckbox[aIter].value);
	}
	return aTotal;
}

function numbering ()
{
	var aElements = document.getElementsByTagName('h3');

	for (i = 0 ; i < aElements.length ; i++)
	{
		aElements[i].innerHTML = (i + 1) + ". " + aElements[i].innerHTML;
		aElements.id = "elem" + (i + 1);
	}
}

function initForm ()
{
	// form_SignDataCMS
	document.getElementById ("form_SignDataCMS").aXgateAddress.value = AnySign.mXgateAddress;
	document.getElementById ("form_SignDataCMS").aCAList.value = AnySign.mCAList;
	document.getElementById ("form_SignDataCMS").aPlain.value = "이 내용이 전자서명됩니다.";
	document.getElementById ("form_SignDataCMS").aLimitedTrial.value = AnySign.mLimitedTrial;

	// form_SignDataCMSWithSerial
	document.getElementById ("form_SignDataCMSWithSerial").aXgateAddress.value = AnySign.mXgateAddress;
	document.getElementById ("form_SignDataCMSWithSerial").aCAList.value = AnySign.mCAList;
	document.getElementById ("form_SignDataCMSWithSerial").aPlain.value = "이 내용이 전자서명됩니다.";
	document.getElementById ("form_SignDataCMSWithSerial").aLimitedTrial.value = AnySign.mLimitedTrial;

	// form_SignDataCMSWithHTMLEx
	document.getElementById ("form_SignDataCMSWithHTMLEx").aXgateAddress.value = AnySign.mXgateAddress;
	document.getElementById ("form_SignDataCMSWithHTMLEx").aCAList.value = AnySign.mCAList;
	document.getElementById ("form_SignDataCMSWithHTMLEx").aForm.value = "<table border=1><tr><td>%s</td></tr><tr><td>%s</td></tr></table>";
	document.getElementById ("form_SignDataCMSWithHTMLEx").aPlain.value = "이 내용이 전자서명됩니다." + AnySign.mSignHTMLOption.aDelimiter  + "이 내용도 전자서명됩니다.";
	document.getElementById ("form_SignDataCMSWithHTMLEx").aCert.value = s;
	document.getElementById ("form_SignDataCMSWithHTMLEx").aLimitedTrial.value = AnySign.mLimitedTrial;

	// form_SignDataCMSWithHTMLExAndSerial
	document.getElementById ("form_SignDataCMSWithHTMLExAndSerial").aXgateAddress.value = AnySign.mXgateAddress;
	document.getElementById ("form_SignDataCMSWithHTMLExAndSerial").aCAList.value = AnySign.mCAList;
	document.getElementById ("form_SignDataCMSWithHTMLExAndSerial").aForm.value = "<table border=1><tr><td>%s</td></tr><tr><td>%s</td></tr></table>";
	document.getElementById ("form_SignDataCMSWithHTMLExAndSerial").aPlain.value = "이 내용이 전자서명됩니다." + AnySign.mSignHTMLOption.aDelimiter  + "이 내용도 전자서명됩니다.";
	document.getElementById ("form_SignDataCMSWithHTMLExAndSerial").aCert.value = s;
	document.getElementById ("form_SignDataCMSWithHTMLExAndSerial").aLimitedTrial.value = AnySign.mLimitedTrial;

	// form_SignDataWithVID
	document.getElementById ("form_SignDataWithVID").aXgateAddress.value = AnySign.mXgateAddress;
	document.getElementById ("form_SignDataWithVID").aCAList.value = AnySign.mCAList;
	document.getElementById ("form_SignDataWithVID").aPlain.value = "이 내용이 전자서명됩니다.";
	document.getElementById ("form_SignDataWithVID").aCert.value = s;
	document.getElementById ("form_SignDataWithVID").aLimitedTrial.value = AnySign.mLimitedTrial;

	// form_SignDataWithVID_Serial
	document.getElementById ("form_SignDataWithVID_Serial").aXgateAddress.value = AnySign.mXgateAddress;
	document.getElementById ("form_SignDataWithVID_Serial").aCAList.value = AnySign.mCAList;
	document.getElementById ("form_SignDataWithVID_Serial").aPlain.value = "이 내용이 전자서명됩니다.";
	document.getElementById ("form_SignDataWithVID_Serial").aCert.value = s;
	document.getElementById ("form_SignDataWithVID_Serial").aLimitedTrial.value = AnySign.mLimitedTrial;

	// form_EnvelopData
	document.getElementById ("form_EnvelopData").aXgateAddress.value = AnySign.mXgateAddress;
	document.getElementById ("form_EnvelopData").aCAList.value = AnySign.mCAList;
	document.getElementById ("form_EnvelopData").aPlain.value = "이 내용이 전자봉투됩니다.";
	document.getElementById ("form_EnvelopData").aCert.value = s;

	// form_DeEnvelopData
	document.getElementById ("form_DeEnvelopData").aXgateAddress.value = AnySign.mXgateAddress;
	document.getElementById ("form_DeEnvelopData").aCAList.value = AnySign.mCAList;

	// form_MultiSignEx
	document.getElementById ("form_MultiSignEx").aXgateAddress.value = AnySign.mXgateAddress;
	document.getElementById ("form_MultiSignEx").aCAList.value = AnySign.mCAList;
	document.getElementById ("form_MultiSignEx").aPlain.value = "이 내용이 전자서명됩니다.|이 내용도 전자서명됩니다.|이 내용 또한 전자서명이 될겁니다.|";
	document.getElementById ("form_MultiSignEx").aDelimiter.value = "|";
	document.getElementById ("form_MultiSignEx").aTotal.value = 3;
	document.getElementById ("form_MultiSignEx").aCert.value = s;

	// form_SignFile
	document.getElementById ("form_SignFile").aXgateAddress.value = AnySign.mXgateAddress;
	document.getElementById ("form_SignFile").aCAList.value = AnySign.mCAList;
	document.getElementById ("form_SignFile").aSignFilePath.value = "";
	document.getElementById ("form_SignFile").aSignedFilePath.value = "";
	document.getElementById ("form_SignFile").aLimitedTrial.value = AnySign.mLimitedTrial;

	// form_MultiFileSign
	document.getElementById ("form_MultiFileSign").aXgateAddress.value = AnySign.mXgateAddress;
	document.getElementById ("form_MultiFileSign").aCAList.value = AnySign.mCAList;
	document.getElementById ("form_MultiFileSign").aSignFilePath.value = "";
	document.getElementById ("form_MultiFileSign").aDelimiter.value = "|";
	document.getElementById ("form_MultiFileSign").aTotal.value = 3;

	// form_RevokeCertificate
	document.getElementById ("form_RevokeCertificate").aType.value = "11";
	document.getElementById ("form_RevokeCertificate").aLimitedTrial.value = AnySign.mLimitedTrial;

	// form_wif
	document.getElementById ("form_wif").aCert.value = s;

	// form_getKTBScanInfo
	document.getElementById ("form_getKTBScanInfo").aServerIP.value = "112.175.100.141";
	document.getElementById ("form_getKTBScanInfo").aServerPort.value = 7070;
}

function GetCertPath_callback (aResult, aSigned)
{
	document.getElementById ("form_GetCertPath").aResult.value = aResult;
	document.getElementById ("form_GetCertPath").aResult_aSigned.value = aSigned;
}

function SignDataCMS_callback (aResult)
{
	document.getElementById ("form_SignDataCMS").aResult.value = aResult;
}

function SignDataAdd_callback (aResult)
{
	document.getElementById ("form_SignDataCMS").aResult2.value = aResult;
}

function SignDataCMSWithCacheCert_callback (aResult)
{
	alert("ok");
	document.getElementById ("form_SignDataCMS").aResult.value = aResult;
}

function SignDataAddWithCacheCert_callback (aResult)
{
	alert("ok");
	document.getElementById ("form_SignDataCMS").aResult2.value = aResult;
}

function ClearCachedData_callback (aResult)
{
	alert(aResult);
}

function EnvelopData_callback (aResult)
{
	document.getElementById ("form_EnvelopData").aResult.value = aResult;
	document.getElementById ("form_DeEnvelopData").aEnvelopedData.value = aResult;
	document.getElementById ("form_DeEnvelopData").aOption[0].checked = document.getElementById ("form_EnvelopData").aOption[0].checked;
	document.getElementById ("form_DeEnvelopData").aOption[1].checked = document.getElementById ("form_EnvelopData").aOption[1].checked;
}

function DeEnvelopData_callback (aResult)
{
	document.getElementById ("form_DeEnvelopData").aResult.value = aResult;
}

function SignFileSelect_callback (aResult)
{
	if (aResult == "")
	{
		alert("file select canceled");
		return;
	}

	document.getElementById ("form_SignFile").aSignFilePath.value = aResult;
	document.getElementById ("form_SignFile").aSignedFilePath.value = aResult + ".sig";
}

function SignFile_callback (aResult)
{
	alert("FileSign is successed");
}

function SignFile_errorcallback (aResult)
{
	var aError = aResult.msg + "[Error Code=" + aResult.code + "]";
	alert(aError);
}

function MultiFileSign_callback (aResult)
{
	if (aResult == "")
	{
		alert("MultiFileSign Result FileSign Fail.");
		return;
	}

	alert("MultiFilesSign Result FileSign Success List : " + aResult);
}

function SignDataCMSWithSerial_callback (aResult)
{
	document.getElementById ("form_SignDataCMSWithSerial").aResult.value = aResult;
}

function SignDataCMSWithHTMLEx_callback (aResult)
{
	document.getElementById ("form_SignDataCMSWithHTMLEx").aResult.value = aResult;
}

function GetVidInfo_callback (aResult)
{
    alert(aResult);
}

function SignDataCMSWithHTMLExAndSerial_callback (aResult)
{
	document.getElementById ("form_SignDataCMSWithHTMLExAndSerial").aResult.value = aResult;
}

function SignDataWithVID_callback (aResult)
{
	document.getElementById ("form_SignDataWithVID").aSignedMsg.value = aResult;

	send_vid_info(SignDataWithVID_UserCallback);
}

function SignDataAddWithVID_callback (aResult)
{
	document.getElementById ("form_SignDataWithVID").aSignedMsg.value = aResult;

	send_vid_info(SignDataAddWithVID_UserCallback);
}

function SignDataWithVID_UserCallback (aResultVid)
{
	document.getElementById ("form_SignDataWithVID").aVidMsg.value = aResultVid;
}

function SignDataAddWithVID_UserCallback (aResultVid)
{
	document.getElementById ("form_SignDataWithVID").aVidMsg.value = aResultVid;
}

function SignDataWithVID_CacheCert_callback (aResult)
{
	alert("ok");
	document.getElementById ("form_SignDataWithVID").aSignedMsg.value = aResult;
	AnySign.GetVidInfo(SignDataWithVID_CacheCert_UserCallback);
}

function SignDataWithVID_CacheCert_UserCallback (aResultVid)
{
	document.getElementById ("form_SignDataWithVID").aVidMsg.value = aResultVid;
}

function SignDataWithVID_Serial_callback (aResult)
{
	document.getElementById ("form_SignDataWithVID_Serial").aSignedMsg.value = aResult;
	AnySign.GetVidInfo(SignDataWithVID_Serial_UserCallback);
}

function SignDataWithVID_Serial_UserCallback (aResultVid)
{
	document.getElementById ("form_SignDataWithVID_Serial").aVidMsg.value = aResultVid;
}

function RenewCertificate_callback (aResult)
{
	if (aResult == 0)
	{
		var aPublicOrPrivate = document.getElementById ("public_or_private").value;
		document.getElementById ("requestResult").value = "인증기관(" + aPublicOrPrivate + ")으로 부터 인증서를 갱신 발급 받았습니다.";
		return;
	}
	else
		document.getElementById ("requestResult").value = "갱신 발급 결과\ncode:" + aResult;
}

function RenewCertificateWithSerial_callback (aResult)
{
	document.getElementById ("form_RenewCertificateWithSerial").aResult.value = aResult;
}

function MultiSignEx_callback (aResult)
{
	document.getElementById ("form_MultiSignEx").aResult.value = aResult;
}

function MultiSignExWithVID_callback (aResult)
{
	document.getElementById ("form_MultiSignEx").aResult.value = aResult;
}

function FileHash_callback (aResult)
{
	document.getElementById ("form_fileHash").aFileHashResult.value = aResult;
}

function RevokeCertificate_callback (aResult)
{
	document.getElementById ("form_RevokeCertificate").aResult.value = aResult;
}

function onRegistCertificate (commandType)
{
	var aRequest= new XMLHttpRequest ();
	var aRegist;
	var aURL;

	var aPolicyType = document.getElementById ("public_type").value;
	var aPublicOrPrivate = document.getElementById ("public_or_private").value;

	document.getElementById ("requestResult").value = "";


	if (aPublicOrPrivate == "yessign")
		aURL = "./ibs/pub_cert/user_regist.jsp";
	else if (aPublicOrPrivate == "xecureca")
		aURL = "./ibs/xecureca_cert/user_regist.jsp";
	else if (aPublicOrPrivate == "yessignmpki") 
		aURL = "./ibs/xecureca_cert/user_regist.jsp";
	else
	{
		alert ("Unknown CA TYPE");
		return;
	}

	aURL += "?commandType=" + commandType;
	aURL += "&user_policy_type=" + aPolicyType;
	aURL += "&user_name=" + encodeURI(document.getElementById ("public_name").value);
	aURL += "&ssn=" + document.getElementById ("public_ssn").value;
	aURL += "&targetRA=" + document.getElementById ("1024_or_2048").value;
	aURL += "&user_public_or_private=" + aPublicOrPrivate;
	

	aRequest.open ("GET", aURL, false);
	aRequest.send (null);

	try
	{
		aRegist = eval (aRequest.responseText);
	}
	catch (evalException)
	{
		var gogogo;
		gogogo = confirm("오류를 자세히 볼 수 있도록 Ajax 대신에 Browser로 직접 호출할까요? (페이지가 이동 됩니다.)");
		if (gogogo == true)
			document.location.href = aURL;

		document.getElementById ("requestResult").value = "서버 페이지(" + aURL + ")의 응답에 문제가 있어서 작업이 중단됩니다.";
		return;
	}

	if (parseInt (aRegist["code"]) == 0)
	{
		if (commandType != "update")
		{
			document.getElementById ("public_refcode").value = aRegist["refcode"];
			document.getElementById ("public_authcode").value = aRegist["authcode"];
		}

		document.getElementById ("public_name").value = aRegist["name"];
		document.getElementById ("public_ssn").value = aRegist["ssn"];
		document.getElementById ("requestResult").value = "등록(" + commandType + ")결과\ncode:" + aRegist["code"];
		return;
	}

	document.getElementById ("requestResult").value = "등록(" + commandType + ")결과\n" + "code:" + aRegist["code"] + "\n" + "reason:" + aRegist["reason"] + "\n" + "moreInformation:" + aRegist["moreinformation"];

}

function decideCAType ()
{
	var aCAType = 0;
	var aPublicOrPrivate = document.getElementById ("public_or_private").value;
	var a1024Or2048 = document.getElementById ("1024_or_2048").value;
	var aKeyAlgorithm = document.getElementById ("key_algorithm").value;

	if (aPublicOrPrivate == "yessign")
	{
		aCAType = 10;
		if (a1024Or2048 == "2048")
			aCAType = 13;
	}
	else if (aPublicOrPrivate == "xecureca")
	{
		if (aKeyAlgorithm == "rsa")
		{
			aCAType = 11;
			if (a1024Or2048 == "2048")
			{
				aCAType = 14;
			}
		}
		else
		{
			aCAType = 12;
			if (a1024Or2048 == "2048")
			{
				aCAType = 15;
			}
		}
	}
	else if (aPublicOrPrivate == "yessignmpki")
	{
		if (aKeyAlgorithm == "rsa")
		{
			if (a1024Or2048 == "2048")
			{
				aCAType = 18;
			}
		}
	}
	

	return aCAType;
}

function onRequestCertificate (userType)
{
	var refcode;
	var authcode;
	var aCAType;

	refcode = document.getElementById ("public_refcode").value;
	authcode = document.getElementById ("public_authcode").value;

	aCAType = decideCAType ();

	RequestCertificate (aCAType,
						refcode,
						authcode,
						cert_request_callback,
						ubikey_request_callback);
}

function onUpdateCertificate (userType)
{
	var aCAType;

	aCAType = decideCAType ();

	RenewCertificate (aCAType, RenewCertificate_callback);
}

function cert_request_callback (aResult)
{
	if (aResult == 0)
	{
		var aPublicOrPrivate = document.getElementById ("public_or_private").value;
		document.getElementById ("requestResult").value = "인증기관(" + aPublicOrPrivate + ")으로 부터 인증서를 발급 받았습니다.";
		return;
	}
	document.getElementById ("requestResult").value = "발급결과\ncode:" + aResult;
}

function ubikey_request_callback (aResult)
{
    if (aResult == 1)
    {
        var aPublicOrPrivate = document.getElementById ("public_or_private").value;
        document.getElementById ("requestResult").value = "인증기관(" + aPublicOrPrivate + ")으로 부터 인증서를 발급 받았습니다.";
        return;
    }
    document.getElementById ("requestResult").value = "발급결과\ncode:" + aResult;
}

function wif_callback (aResult)
{
	document.getElementById("form_wif").aWifResult.value = aResult;
}

function clearField (type)
{
	if (type == "cmp_public")
	{
		document.getElementById ("public_refcode").value = "";
		document.getElementById ("public_authcode").value = "";
		document.getElementById ("public_name").value = "";
		document.getElementById ("public_ssn").value = "";
	}
}

function onSendToServer(value)
{

	var aRequest = new XMLHttpRequest ();
	var aResponse = "";
	var aURL = "";
	var aMessage = "";

	aURL = "<%=sign_result_page%>";
	aRequest.open ("POST", aURL, false);
	aRequest.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	aRequest.send ("SIGNED=" + encodeURIComponent(value));

	if (aRequest.status == 200)
	{
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

		aMessage += "서명 원문:\n" + aResponse["plain"] + "\n";
		aMessage += "사용자 RDN:\n" + aResponse["subjectRDN"] + "\n";
		aMessage += "사용자 인증서:\n" + aResponse["certificatePEM"] + "\n";
		
		alert (aMessage);
	}
	else
	{
		aMessage += "Server error\n";
		aMessage += "HTTP Status: " + aRequest.status + " ";
		aMessage += "(" + aRequest.statusText + ")";
		
		alert (aMessage);
	}
}

function verifyMessage (value, total, delimeter)
{
	var aSignedMsg = "";
	var aVerifiedMsg = "";
	var aResult = "";
	var aLength = "";
	var aIndex = "";

	aSignedMsg = value;

	for (i = 0; i < total; i++)
	{
		aLength = aSignedMsg.aLength;
		aIndex = aSignedMsg.indexOf (delimeter);
		onSendToServer (aSignedMsg.substring(0, aIndex), true);
		aSignedMsg = aSignedMsg.substring (aIndex+1, aLength);
	}

}

function onWifResult(data) {
	var aRequest = new XMLHttpRequest();
	var aResponse = "";

	aURL = "./dev_server.jsp";
	aRequest.open ("POST", aURL, false);
	aRequest.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	aRequest.send ("ENVDATA=" + data);

	alert (aRequest.responseText);
}

function CB_getKTBScanInfo(aResult)
{
	if (aResult != "")
		document.getElementById ("form_getKTBScanInfo").aScanInfo.value = aResult;
	else
		document.getElementById ("form_getKTBScanInfo").aScanInfo.value = "사용자 PC 정보 확인 중에 오류가 발생하였습니다.";
}

function navigate(url, target, feature)
{
	function _blockEnc() {
		checkAnySign4PC();
		url += "?abc=def|qwer&pop=한글";
		XecureNavigate (url, target, feature);
	}
	
	if(!AnySign.mAnySignLoad) {
		AnySign4PC_LoadCallback(_blockEnc);
		PrintObjectTag ();
	} else {
		_blockEnc();
	}
}

function EncDecFunc (aType, aParam)
{
	var aResult = false;
	
	function _blockEnc() {
		checkAnySign4PC();
		if (aType == 'XecureLink')
			aResult = AnySign.XecureLink(aParam);
		else if (aType == 'XecureSubmit')
			aResult = AnySign.XecureSubmit(aParam, aSessionKey);
	}
	
	if(!AnySign.mAnySignLoad) {
		AnySign4PC_LoadCallback(_blockEnc);
		PrintObjectTag ();
	} else {
		_blockEnc();
	}

	return aResult;
}

function BlockEncFunc ()
{
	function _blockEncEx() {
		checkAnySign4PC();
		BlockEncEx('test', 'GET', '<%=charset%>', BlockEncEx_callback);
	}
	
	if(!AnySign.mAnySignLoad) {
		AnySign4PC_LoadCallback(_blockEncEx);
		PrintObjectTag ();
	} else {
		_blockEncEx();
	}
}

function BlockEncEx_callback (aResult)
{
	alert(aResult);
}

// 공통 설정
function checkCommonSetting()
{
	var aLanguage = document.getElementById("form_CommonSetting").Language;
	for (var i = 0; i < aLanguage.length; i++)
	{
		if (AnySign.mLanguage == aLanguage[i].value)
		{
			aLanguage[i].checked = true;
			break;
		}
		
	}
	
	// 인증서 갱신 옵션
	if (AnySign.mShowRenewCertSaveLoc == true)
		document.getElementById("ShowRenewCertSaveLoc").checked = true;
}

function enableLanguage(element)
{
	AnySign.mLanguage = element.value;
}

function enableShowRenewCertSaveLoc(element)
{
	if (element.checked) {
		AnySign.mShowRenewCertSaveLoc = true;
	} else {
		AnySign.mShowRenewCertSaveLoc = false;
	}
}

// 키보드 보안, 가상 키패드 설정
function enableSecureKey(element)
{
	// 가상 키패드
	if (element.id == "Enable_Transkey") {
		AnySign.mTransKeyEnable =! AnySign.mTransKeyEnable;
		if (AnySign.mTransKeyEnable) {
			AnySign.mXecureKeyPadEnable = false;
			AnySign.mOpenkeyboardEnable = false;
			AnySign.mIncaNOSv10Enable = false;
			AnySign.mIncaNOSv10KeypadEnable = false;
		}
	}
	if (element.id == "Enable_XecureKeyPad") {
		AnySign.mXecureKeyPadEnable =! AnySign.mXecureKeyPadEnable;
		if (AnySign.mXecureKeyPadEnable) {
			AnySign.mTransKeyEnable = false;
			AnySign.mOpenkeyboardEnable = false;
			AnySign.mIncaNOSv10Enable = false;
			AnySign.mIncaNOSv10KeypadEnable = false;
		}
	}
	if (element.id == "Enable_Openkeyboard") {
		AnySign.mOpenkeyboardEnable =! AnySign.mOpenkeyboardEnable;
		if (AnySign.mOpenkeyboardEnable) {
			AnySign.mTransKeyEnable = false;
			AnySign.mXecureKeyPadEnable = false;
			AnySign.mIncaNOSv10Enable = false;
			AnySign.mIncaNOSv10KeypadEnable = false;
		}
	}
	if (element.id == "Enable_IncaKeyPad") {
		AnySign.mIncaNOSv10KeypadEnable =! AnySign.mIncaNOSv10KeypadEnable;
		if (AnySign.mIncaKeyPadEnable) {
			AnySign.mTransKeyEnable = false;
			AnySign.mXecureKeyPadEnable = false;
			AnySign.mOpenkeyboardEnable = false;
			AnySign.mIncaNOSv10Enable = false;
		}
	}
	
	// 키보드 보안
	if (element.id == "Enable_TouchEnKey")
	{
		AnySign.mTouchEnKeyEnable =! AnySign.mTouchEnKeyEnable;
		if (AnySign.mTouchEnKeyEnable) {
			AnySign.mKeyCryptHTML5Enable = false;
			AnySign.mASTxEnable = false;
			AnySign.mTouchEnnxKeyEnable = false;
			AnySign.mIncaNOSv10Enable = false;
			AnySign.mKOSKeyEnable = false;
			AnySign.mEzKeyTecEnable = false;
		}
	}
	if (element.id == "Enable_KeyCryptHTLM5")
	{
		AnySign.mKeyCryptHTML5Enable =! AnySign.mKeyCryptHTML5Enable;
		if (AnySign.mKeyCryptHTML5Enable) {
			AnySign.mTouchEnKeyEnable = false;
			AnySign.mASTxEnable = false;
			AnySign.mTouchEnnxKeyEnable = false;
			AnySign.mIncaNOSv10Enable = false;
			AnySign.mKOSKeyEnable = false;
			AnySign.mEzKeyTecEnable = false;
		}
	}
	if (element.id == "Enable_ASTx")
	{
		AnySign.mASTxEnable = !AnySign.mASTxEnable;
		if (AnySign.mASTxEnable) {
			AnySign.mTouchEnKeyEnable = false;
			AnySign.mKeyCryptHTML5Enable = false;
			AnySign.mTouchEnnxKeyEnable = false;
			AnySign.mIncaNOSv10Enable = false;
			AnySign.mKOSKeyEnable = false;
			AnySign.mEzKeyTecEnable = false;
		}
	}
	if (element.id == "Enable_TouchEnnxKey")
	{
		AnySign.mTouchEnnxKeyEnable =! AnySign.mTouchEnnxKeyEnable;
		if (AnySign.mTouchEnnxKeyEnable) {
			AnySign.mTouchEnKeyEnable = false;
			AnySign.mKeyCryptHTML5Enable = false;
			AnySign.mASTxEnable = false;
			AnySign.mIncaNOSv10Enable = false;
			AnySign.mKOSKeyEnable = false;
			AnySign.mEzKeyTecEnable = false;
		}
	}
	if (element.id == "Enable_KOSKey")
	{
		AnySign.mKOSKeyEnable =! AnySign.mKOSKeyEnable;
		if (AnySign.mKOSKeyEnable) {
			AnySign.mTouchEnKeyEnable = false;
			AnySign.mKeyCryptHTML5Enable = false;
			AnySign.mASTxEnable = false;
			AnySign.mTouchEnnxKeyEnable = false;
			AnySign.mIncaNOSv10Enable = false;
			AnySign.mEzKeyTecEnable = false;
		}
	}
	
	if (element.id == "Enable_EzKeyTec")
	{
		AnySign.mEzKeyTecEnable =! AnySign.mEzKeyTecEnable;
		if (AnySign.mKOSKeyEnable) {
			AnySign.mTouchEnKeyEnable = false;
			AnySign.mKeyCryptHTML5Enable = false;
			AnySign.mASTxEnable = false;
			AnySign.mTouchEnnxKeyEnable = false;
			AnySign.mIncaNOSv10Enable = false;
			AnySign.mKOSKeyEnable = false;
		}
	}
	
	// 키보드 보안 + 가상 키패드
	if (element.id == "Enable_IncaNOSv10")
	{
		AnySign.mIncaNOSv10Enable =! AnySign.mIncaNOSv10Enable;
		if (AnySign.mIncaNOSv10Enable) {
			AnySign.mTransKeyEnable = false;
			AnySign.mXecureKeyPadEnable = false;
			AnySign.mOpenkeyboardEnable = false;
			AnySign.mTouchEnKeyEnable = false;
			AnySign.mKeyCryptHTML5Enable = false;
			AnySign.mASTxEnable = false;
			AnySign.mTouchEnnxKeyEnable = false;
			AnySign.mKOSKeyEnable = false;
			AnySign.mIncaNOSv10KeypadEnable = false;
			AnySign.mEzKeyTecEnable = false;
		}
	}	
	
	checkKeyboard();
}

function enableSecureKey_Lite(element)
{
	AnySign.mXecureKeyPadHTML5Enable =! AnySign.mXecureKeyPadHTML5Enable;
	document.getElementById("Enable_XecureKeyPadHTML5").value = AnySign.mXecureKeyPadHTML5Enable;
}

function enableSecureKey_E2E(element)
{
	AnySign.mXecureKeyPadE2EEnable =! AnySign.mXecureKeyPadE2EEnable;
	document.getElementById("Enable_XecureKeyPadE2E").value = AnySign.mXecureKeyPadE2EEnable;
}

function checkKeyboard()
{
	// AnySign4PC
	document.getElementById("Enable_Transkey").value = AnySign.mTransKeyEnable;
	document.getElementById("Enable_XecureKeyPad").value = AnySign.mXecureKeyPadEnable;
	document.getElementById("Enable_Openkeyboard").value = AnySign.mOpenkeyboardEnable;
	document.getElementById("Enable_IncaKeyPad").value = AnySign.mIncaNOSv10KeypadEnable;	
	document.getElementById("Enable_TouchEnKey").value = AnySign.mTouchEnKeyEnable;
	document.getElementById("Enable_KeyCryptHTLM5").value = AnySign.mKeyCryptHTML5Enable;
	document.getElementById("Enable_ASTx").value = AnySign.mASTxEnable;
	document.getElementById("Enable_TouchEnnxKey").value = AnySign.mTouchEnnxKeyEnable;
	document.getElementById("Enable_IncaNOSv10").value = AnySign.mIncaNOSv10Enable;
	document.getElementById("Enable_KOSKey").value = AnySign.mKOSKeyEnable;
	document.getElementById("Enable_EzKeyTec").value = AnySign.mEzKeyTecEnable;
	
	// AnySignLite
	document.getElementById("Enable_XecureKeyPadHTML5").value = AnySign.mXecureKeyPadHTML5Enable;
	
	// XecureFreeSign
	document.getElementById("Enable_XecureKeyPadE2E").value = AnySign.mXecureKeyPadE2EEnable;
	
	// check Module Load
	if (navigator.userAgent.indexOf("MSIE") >= 0)
		document.getElementById("Load_TouchEnKey").innerHTML = document.TouchEnKey != null && typeof(document.TouchEnKey) != "undefined" && document.TouchEnKey.object != null;
	else
		document.getElementById("Load_TouchEnKey").innerHTML = document.getElementById("TouchEnKey") != null && typeof(document.getElementById("TouchEnKey")) != "undefined";
	
	// init keyboard
	if (AnySign.mKeyCryptHTML5Enable || AnySign.mASTxEnable || AnySign.mTouchEnnxKeyEnable || AnySign.mIncaNOSv10Enable || AnySign.mKOSKeyEnable ||AnySign.mIncaNOSv10KeypadEnable || AnySign.mEzKeyTecEnable) {
		if (AnySign.mAnySignLoad) {
			setExternalCallback(false);
			initKeyboard();
		} else {
			setExternalCallback(true);
		}
	} else {
		setExternalCallback(false);
	}
}

function initKeyboard()
{
	// init
	if (document.getElementById("Enable_IncaKeyPad").value == "true")
		initIncaKeyPad();
		
	if (document.getElementById("Enable_TouchEnnxKey").value == "true")
		initTouchEnnxKey();
	
	if (document.getElementById("Enable_KeyCryptHTLM5").value == "true")
		initKeyCryptHTML5();
	
	if (document.getElementById("Enable_IncaNOSv10").value == "true")
		initIncaNOSv10();
	
	if (document.getElementById("Enable_ASTx").value == "true")
		initASTx();
	
	if (document.getElementById("Enable_KOSKey").value == "true")
		initKOS();
		
	if (document.getElementById("Enable_EzKeyTec").value == "true")
		initEzKeyTec();
}

function initTouchEnnxKey()
{
	/*
	설치 체크
	TouchEnNxKey.js
	TK_LoadingCallback() -> 로딩 완료 : tk_initDone(0)
	TK_installPage() -> 미설치 : 설치페이지 이동 (location.href)
	*/
	tk_initDone = doneTouchEnnxKey;
	TK_Loading();
}
function doneTouchEnnxKey(aResult)
{
	document.getElementById("Enable_TouchEnnxKey").style.fontWeight = "bold";
	doneKeyboard(aResult);
}

function initKeyCryptHTML5()
{
	var aVersion = getIEVersion ();
	var aPlatform = AnySign.mPlatform.aName;
	var aKeyCryptHTML5 = false;
	
	if (aVersion)
	{
		if (aVersion > 6)
			aKeyCryptHTML5 = true;
	}
	else if (aPlatform != "linux" && aPlatform != "mac universal")
	{
		aKeyCryptHTML5 = true;
	}
	
	/*
	설치 체크
	nppfs-1.0.0.js
	npPfsStartup.options
		Loading.After -> 로딩 완료 : inca_initDone(0)
		MoveToInstall -> 미설치 : 설치페이지 이동 확인 (confirm)
	*/
	if (aKeyCryptHTML5) {
		inca_initDone = doneKeyCryptHTML5;
		npPfsStartup("document.form1", false, true, false, false, "npkencrypt", "On");
	}
}

function doneKeyCryptHTML5(aResult)
{
	document.getElementById("Enable_KeyCryptHTLM5").style.fontWeight = "bold";
	doneKeyboard(aResult);
}

function initIncaNOSv10()
{
	/*
	설치 체크
	nppfs-1.0.0.js
	npPfsStartup.options
		Loading.After -> 로딩 완료 : nos_initDone(0)
		MoveToInstall -> 미설치 : 설치페이지 이동 확인 (confirm)
	*/
	nos_initDone = doneIncaNOSv10;
	npPfsStartup(document.form1, false, true, false, true, "npkencrypt", "on");
}

function initIncaKeyPad()
{
	/*
	설치 체크
	nppfs-1.0.0.js
	npPfsStartup.options
		Loading.After -> 로딩 완료 : nos_initDone(0)
		MoveToInstall -> 미설치 : 설치페이지 이동 확인 (confirm)
	*/
	nos_initDone = doneIncaKeyPad;
	npPfsStartup(document.form1, false, false, false, true, "npkencrypt", "on");
}

function doneIncaNOSv10(aResult)
{
	document.getElementById("Enable_IncaNOSv10").style.fontWeight = "bold";
	doneKeyboard(aResult);
}

function doneIncaKeyPad(aResult)
{
	document.getElementById("Enable_IncaKeyPad").style.fontWeight = "bold";
	doneKeyboard(aResult);
}

function initASTx() {
	$ASTX2.init(
		function onSuccess(){ // 초기화 완료
			//alert("ASTX init Success");
			doneASTx();
		},
		function onFailure(){ // 미설치
			alert("ASTX init Fail");
		}
	);
}

function doneASTx() {
	document.getElementById("Enable_ASTx").style.fontWeight = "bold";
	doneKeyboard();
}

function initKOS() {
	/*
	설치 체크
	kdfense_object.js
	KOS_GetGlobalEventHandlers()
		KOS_OnReady() -> 초기화 완료 : kos_initDone(0)
		KOS_OnNotInstalled() -> 미설치 : kos_initFail()
	*/
	kos_initDone = doneKOS;
	kos_initFail = failKOS;
	KOS.init();
}

function doneKOS(aResult)
{
	document.getElementById("Enable_KOSKey").style.fontWeight = "bold";
	doneKeyboard(aResult);
}
function failKOS()
{
	alert("KOS init Fail");
}

function initEzKeyTec()
{
	EzKeyTec_initDone = doneEzKeyTec;
	EZKInput.Init();
}

function doneEzKeyTec(aResult)
{
	document.getElementById("Enable_EzKeyTec").style.fontWeight = "bold";
	doneKeyboard(aResult);
}

var gInstallPage = function() {
	if(confirm("프로그램 설치가 필요합니다. 설치 페이지로 이동하시겠습니까?"))
		document.location.href = AnySign.mPlatform.aInstallPage;
}

/*----------------------------------------------------------------------------------*
 * AnySign4PC 실행 시 외부 설치 체크 함수 등록 방법 (예: 키보드 보안 모듈 설치 체크)
 *  인증서 선택창의 저장매체 클릭 시 AnySign4PC 설치 체크와 함께
 *  외부 모듈(키보드 보안 등) 설치 체크와 초기화가 필요한 경우 아래와 같이 셋팅한다.
 *
 * 1. 실행될 함수 작성
 *    첫번째 입력값은 리턴할 콜백 함수로 사용해야 한다!
 *    성공 시 콜백함수에 0(Number) 입력 또는 입력값 없이 호출한다.(이외의 값 입력은 오류 처리)
 *    function initKeyboard(resultFunc) // -> function resultFunc(Number)
 *    {
 *       init();
 *       if (success)
 *           resultFunc(0); // 또는 resultFunc();
 *       else
 *           resultFunc(-1);
 *    }
 * 2. 콜백 함수 등록
 *    setExternal_callback(initKeyboard);
 *----------------------------------------------------------------------------------*/
var gResultFunc = function(a) {};
var doneKeyboard = function(aResult) {
	gResultFunc(aResult);
};

function CB_initKeyboard(aResultFunc) {
	gResultFunc = aResultFunc;
	initKeyboard();
}

function setExternalCallback(aOption) {
	if (aOption)
		setExternal_callback(CB_initKeyboard);
	else
		setExternal_callback(null);
}
/*----------------------------------------------------------------------------------*/

// AnySign4PC 설치 확인 및 초기화
function checkAnySign4PC()
{
	document.getElementById("AnySign4PC_Version").innerHTML = AnySign.mVersion;
	document.getElementById("Enable_AnySignLoad").value = AnySign.mAnySignLoad;
	
	if (AnySign.mAnySignLoad == true)
		document.getElementById("Enable_AnySignLoad").style.fontWeight = "bold";
}

function initAnySign4PC()
{
	checkAnySign4PC();
	if (!AnySign.mAnySignLoad) {
		AnySign4PC_LoadCallback (checkAnySign4PC);
		PrintObjectTag ();
	}
}

// AnySignLite 설정
function checkAnySignLite()
{
	document.getElementById("Enable_AnySignLite").value = AnySign.mAnySignLiteEnable;
}

function enableAnySignLite()
{
	AnySign.mAnySignLiteEnable =! AnySign.mAnySignLiteEnable;
	document.getElementById("Enable_AnySignLite").value = AnySign.mAnySignLiteEnable;
}

// XecureFreeSign 설정
function checkXecureFreeSign()
{
	document.getElementById("Enable_XecureFreeSign").value = AnySign.mXecureFreeSignEnable;
	
	var aSignTypeRadio = document.getElementById("form_XecureFreeSign").signType;
	for (var i = 0; i < aSignTypeRadio.length; i++)
	{
		if (AnySign.mXecureFreeSignData.signType == aSignTypeRadio[i].value)
		{
			aSignTypeRadio[i].checked = true;
			break;
		}
		
	}
}

function enableXecureFreeSign()
{
	AnySign.mXecureFreeSignEnable =! AnySign.mXecureFreeSignEnable;
	document.getElementById("Enable_XecureFreeSign").value = AnySign.mXecureFreeSignEnable;
}

function enableSignType(element)
{
	AnySign.mXecureFreeSignData.signType = element.value;
	
	XCrypto.xfs_init(AnySign.mXecureFreeSignData.serviceURL,
					 AnySign.mXecureFreeSignData.serviceKey,
					 AnySign.mXecureFreeSignData.asyncOption,
					 AnySign.mXecureFreeSignData.signType,
					 AnySign.mWebPageStorageData.type,
					 AnySign.mWebPageStorageData.certList,
					 AnySign.mWebPageStorageData.storageElementID)
}

function XFSLogout()
{
	var aUserCallback = function(aResult) {
		alert(aResult);
	}
	
	AnySign.XFSLogout(aUserCallback);
}

//SetConvertTable();
</script>
</head>
<body onload="init();" leftmargin="0" topmargin="0" style="padding-top:0px; padding-left:0px;">
<!--br><a title="새창" id="cert_login" href="#">공인인증서 로그인</a><p-->
<form name='xecure'><input type=hidden name='p'>
</form>
	<table width="694" align='center' border="0" cellspacing="0" cellpadding="0" height="100%">
		<!-- Header -->
		<tr>
			<td>
				<div id="xecure_header" />
			</td>
		</tr>

		<!-- Body -->
		<tr>
			<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<!-- contents start -->
						<td>
							<!-- CENTER START -->
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td>
										<form id="form_CommonSetting" name="form_CommonSetting">
										<table class="test">
											<tr>
												<td width="694" colspan="2"><h4>공통 설정</h4></td>
											</tr>
											<tr>
												<td width="208">Charset</td>
												<td width="486">
													현재 페이지 : <%=charset%><br>
													<a href="<%=link_page%>">[AnySign4PC/Lite <%=link_charset%>]</a>
												</td>
											</tr>
											<tr>
												<td width="208">Language</td>
												<td width="486">
													<input type="radio" class="inputcheck" name="Language" value="ko-KR" onClick="enableLanguage(this)"> ko-KR
													<input type="radio" class="inputcheck" name="Language" value="en-US" onClick="enableLanguage(this)"> en-US
												</td>
											</tr>
										</table>
										</form>
										<br/>
									
										 <table class="test">
											<tr>
												<td width="694" colspan="3"><h4>AnySign4PC 설정</h4></td>
											</tr>
											<tr>
												<td width="208" colspan="2">AnySign4PC 설치 확인 및 초기화</td>
												<td width="486" >
													Version : <span id="AnySign4PC_Version"></span>
													<input id="Enable_AnySignLoad" type="button" style="width:100%" onclick="initAnySign4PC(this);">
												</td>
											</tr>
											<tr>
												<td width="84" rowspan="3">가상 키패드</td>
												<td width="124">Transkey<br>v4.5.1 (2013.01.11)</td>
												<td width="486">
													<input id="Enable_Transkey" type="button" style="width:100%" onclick="enableSecureKey(this);">
												</td>
											</tr>
											<tr>
												<td width="124">XecureKeyPad<br>v1.0.0.2 (2016.10.19)</td>
												<td width="486">
													<input id="Enable_XecureKeyPad" type="button" style="width:100%" onclick="enableSecureKey(this);">
												</td>
											</tr>
											<tr>
												<td width="124">IncaKeyPad<br>2016.10.19</td>
												<td width="486">
													<input id="Enable_IncaKeyPad" type="button" style="width:100%" onclick="enableSecureKey(this);">
												</td>
											</tr>
											<tr style="display:none"> <!-- 테스트 제외 -->
												<td width="124">Openkeyboard<br>v1.0 (2013.07.21)</td>
												<td width="486">
													<input id="Enable_Openkeyboard" type="button" style="width:100%" onclick="enableSecureKey(this);">
												</td>
											</tr>
											<tr style="display:none"> <!-- 테스트 제외 -->
												<td rowspan="4">키보드 보안</td>
												<td>TouchenKey<br>v3.1.0.11 (2013.02.26)</td>
												<td>
													Module Load (ActiveX/Plugin): <span id="Load_TouchEnKey"></span> <a href="../touchen/installpage/install.html">[설치페이지]</a>
													<input id="Enable_TouchEnKey" type="button" style="width:100%" onclick="enableSecureKey(this);">
												</td>
											</tr>
											<tr style="display:none"> <!-- 테스트 제외 -->
												<td>nProtect KeyCrypt HTML5</td>
												<td>
													<a href="../inca/nos_setup.exe">[설치파일]</a>
													<input id="Enable_KeyCryptHTLM5" type="button" style="width:100%" onclick="enableSecureKey(this);">
												</td>
											</tr>
											<tr>
												<td rowspan="4">키보드 보안</td>
												<td>AhnLab Safe Transaction<br>v1.3.4.393(2015.12.30)</td>
												<td>
													<!--<a href="http://ahnlabnotice.nefficient.co.kr/astx_demo/master/astx_setup.exe">[설치파일]</a>-->
													<a href="../AOS2/files/astx_setup_offline.exe">[설치파일]</a>
													<input id="Enable_ASTx" type="button" style="width:100%" onclick="enableSecureKey(this);">
												</td>
											</tr>
											<tr>
												<td>TouchEn nxKey<br>v1.0.0.8 (2015.07.24)</td>
												<td>
													<a href="../touchennxkey/install/install.html">[설치페이지]</a>
													<input id="Enable_TouchEnnxKey" type="button" style="width:100%" onclick="enableSecureKey(this);">
												</td>
											</tr>
											<tr>
												<td>Kings Online Security<br>v1.0.0.7 (2016.04.07)</td>
												<td>
													<a href="../KOS/KOS_Setup.exe">[설치파일]</a>
													<input id="Enable_KOSKey" type="button" style="width:100%" onclick="enableSecureKey(this);">
												</td>
											</tr>
											<tr>						
												<td>EzKeyTec 키보드보안<br>v2.2(2016.4.29.2)</td>
												<td>
													<a href="../ezKeyTec/easykeyteccab.exe">[설치파일]</a>
													<input id="Enable_EzKeyTec" type="button" style="width:100%" onclick="enableSecureKey(this);">
												</td>
											</tr>
											<tr>
												<td>키보드 보안 + 가상 키패드</td>
												<td>nProtect Online Security V1.0<br>v1.0 (2015.12.23)</td>
												<td>
													<a href="../inca_nos10/nos_setup.exe">[설치파일]</a>
													<input id="Enable_IncaNOSv10" type="button" style="width:100%" onclick="enableSecureKey(this);">
												</td>
											</tr>																						
											<tr>
												<td>보안 토큰</td>
												<td>XecureHSM v2.0.0.3 (driver: v1.1.0.1)</td>
												<td>
													xhsm_install.exe
													<a href="../XecureHSM/xhsm_install.exe">[다운로드]</a>
												</td>
											</tr>
										</table>
										<br>
										
										 <table class="test">
											<tr>
												<td width="694" colspan="3"><h4>AnySignLite 설정</h4></td>
											</tr>
											<tr>
												<td width="208" colspan="2">AnySignLite 사용 유무</td>
												<td width="486" >
													<input id="Enable_AnySignLite" type="button" style="width:100%" onclick="enableAnySignLite(this);">
												</td>
											</tr>
											<tr>
												<td width="84">가상 키패드</td>
												<td width="124">XecureKeyPad Lite<br>v1.0.0.2 (2016.09.28)</td>
												<td width="486">
													<input id="Enable_XecureKeyPadHTML5" type="button" style="width:100%" onclick="enableSecureKey_Lite(this);">
												</td>
											</tr>
										</table>
										<br>
										
										<form id="form_XecureFreeSign" name="form_XecureFreeSign">
										<table class="test">
											<tr>
												<td width="694" colspan="3"><h4>XecureFreeSign 설정</h4></td>
											</tr>
											<tr>
												<td width="208" colspan="2">XecureFreeSign 사용 유무</td>
												<td width="486" >
													<input id="Enable_XecureFreeSign" type="button" style="width:100%" onclick="enableXecureFreeSign(this);">
												</td>
											</tr>
											<tr>
												<td width="208" colspan="2">서명 방식</td>
												<td width="486" >
													<input type="radio" class="inputcheck" name="signType" value="server" onClick="enableSignType(this)"> server
													<input type="radio" class="inputcheck" name="signType" value="server-digest" onClick="enableSignType(this)"> server-digest
													<input type="radio" class="inputcheck" name="signType" value="client" onClick="enableSignType(this)"> client
												</td>
											</tr>
											<tr>
												<td width="84">가상 키패드</td>
												<td width="124">XecureKeyPad E2E<br>v1.0.1.0 (2017.01.17)</td>
												<td width="486">
													<input id="Enable_XecureKeyPadE2E" type="button" style="width:100%" onclick="enableSecureKey_E2E(this);">
												</td>
											</tr>
											<tr>
												<td width="208" colspan="2">OpenAPI</td>
												<td width="486" >
													<input type="button" value="Logout" onclick="XFSLogout();">
												</td>
											</tr>
										</table>
										</form>
										<br>
										
										<h3 id="1">XecureLink</h3>
										<table class="test">
											<tr>
												<td width="170">XecureLink</td>
												<td width="524" style="text-align:left;">
													<a href="enc_server_response.jsp?abc=def|qwer&pop=hi" onClick="return EncDecFunc('XecureLink', this);">전송</a>
												</td>
											</tr>
											<tr>
												<td width="170">AnySign.XecureLink KB</td>
												<td width="524" style="text-align:left;">
													<a href="./KB_qa.jsp" onClick="return EncDecFunc('XecureLink', this);">전송</a>
												</td>
											</tr>
											<tr>
												<td width="170">AnySign.XecureLink LGUPlus</td>
												<td width="524" style="text-align:left;">
													<a href="./LGUPlus_qa.jsp" onClick="return EncDecFunc('XecureLink', this);">전송</a>
												</td>
											</tr>
										</table>
										<br/>

										<h3 id="2">XecureSubmit</h3>
										<table class="test">
											<tr>
												<td width="170">AnySign.XecureSubmit</td>
												<td width="524" style="text-align:left;">
													<form id="form_XecureSubmit2" method="post" action="./enc_server_response_20.jsp?abc=def&pop=hi" method="post" onSubmit="return EncDecFunc('XecureSubmit', this);">
														<input type=text name="text_field1" value ='this is English. hello?'/><br/>
														<input type=text name="text_field2" value ='한글입니다. 안녕할까요?'/><br/>
														<input type=submit value="전송"/>
													</form>
												</td>
											</tr>
										</table>
										<br/>

										<h3 id="3">XecureNavigate</h3>
										<table class="test">
											<tr>
												<td width="170">XecureNavigate</td>
												<td width="524" style="text-align:left;">
													<a title="새창열림" href="javascript:navigate('enc_server_response.jsp', 'test', 'scrollbars=yes,resizeable=yes');">전송</a>
												</td>
											</tr>
											<tr>
												<td width="170">XecureNavigate KB</td>
												<td width="524" style="text-align:left;">
													<a title="새창열림" href="javascript:navigate('KB_qa.jsp', 'test', 'scrollbars=yes,resizeable=yes');">전송</a>
												</td>
											</tr>
											<tr>
												<td width="170">XecureNavigate LGUPlus</td>
												<td width="524" style="text-align:left;">
													<a title="새창열림" href="javascript:navigate('LGUPlus_qa.jsp', 'test', 'scrollbars=yes,resizeable=yes');">전송</a>
												</td>
											</tr>
										</table>
										<br/>

										<h3 id="4">BlockEnc</h3>
										<table class="test">
											<tr>
												<td width="170">BlockEncEx</td>
												<td width="524" style="text-align:left;">
													<a href="#" onClick="BlockEncFunc();">전송</a>
												</td>
											</tr>
										</table>
										<br/>


										<h3 id="5">SignDataCMS</h3>
										<form id="form_SignDataCMS" name="form_SignDataCMS" method="post" action="#">
										<table class="test">
											<tr>
												<td width="50" rowspan="6">Input</td>
												<td width="120">aXgateAddress</td>
												<td width="524"><input type="text" class="inputtext" name="aXgateAddress"/></td>
											</tr>
											<tr>
												<td>aCAList</td>
												<td><input type="text" class="inputtext" name="aCAList"/></td>
											</tr>
											<tr>
												<td>aPlain</td>
												<td><textarea class="inputtextarea" name="aPlain" rows="7"></textarea></td>
											</tr>
											<tr>
												<td>aOption</td>
												<td style="text-align:left;">
													<input type="checkbox" class="inputcheck" name="aOption" value="0" checked disabled="true"/>
													0x00000000 : 기본 서명<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="1" checked/>
													0x00000001 : 서명확인창을 보여준다.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="2" disabled="true"/>
													<s>0x00000002 : 로그인한 인증서만 보여준다.</s><br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="256"/>
													0x00000100 : 출력 값을 Base64로 <br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="512" checked/>
													0x00000200 : 서명 시간 추가 (SignedAttributes)<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="4096"/>
													0x00001000 : 분리 서명 (No Content)<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="8388608"/>
													0x00800000 : SignKorea 축약서명 (PKCS1)<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="16777216"/>
													0x01800000 : SignKorea 축약서명 (PKCS1) + 출력값 추가(subjectRDN|certSerial|인증서값) <br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="33619968"/>
													0x02010000 : SignKorea 풀서명 (NO CMS + SignKorea)<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="2097152"/>
													0x00200000 : 스마트 인증 캐쉬<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="1048576"/>
													0x00100000 : 인증서 위치 캐쉬<br/>
												</td>
											</tr>
											<tr>
												<td>aDescription</td>
												<td><input type="text" class="inputtext" name="aDescription"/></td>
											</tr>
											<tr>
												<td>aLimitedTrial</td>
												<td><input type="text" class="inputtext" name="aLimitedTrial"/></td>
											</tr>
											<tr>
												<td>Run</td>
												<td colspan="6">
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.SignDataCMS"
													onClick="AnySign.SignDataCMS (this.form.aXgateAddress.value,
																					this.form.aCAList.value,
																					this.form.aPlain.value,
																					sumCheckbox (this.form.aOption),
																					this.form.aDescription.value,
																					this.form.aLimitedTrial.value,
																					SignDataCMS_callback);"/>
													<br/>
													<input type="button" class="inputbutton" style="height:auto;" value="Anysign.SignDataAdd"
													onClick="AnySign.SignDataAdd (this.form.aXgateAddress.value,
																					this.form.aCAList.value,
																					this.form.aResult.value,
																					sumCheckbox (this.form.aOption),
																					this.form.aDescription.value,
																					this.form.aLimitedTrial.value,
																					SignDataAdd_callback);"/>
													<br/>
													<input type="button" class="inputbutton" style="height:auto;" value="Sign_with_option"
													onClick="Sign_with_option (sumCheckbox (this.form.aOption),
																			   this.form.aPlain.value,
																			   SignDataCMS_callback);"/>
													<br/>
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.SignDataCMSWithCacheCert"
													onClick="AnySign.SignDataCMSWithCacheCert (this.form.aXgateAddress.value,
																							   this.form.aPlain.value,
																							   sumCheckbox (this.form.aOption),
																							   SignDataCMSWithCacheCert_callback);"/>
													<br/>
													<input type="button" class="inputbutton" style="height:auto;" value="Anysign.SignDataAddWithCacheCert"
													onClick="AnySign.SignDataAddWithCacheCert (sumCheckbox (this.form.aOption),
																							   this.form.aResult.value,
																			    			   SignDataAddWithCacheCert_callback);"/>
													<br/>
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.ClearCachedData"
													onClick="AnySign.ClearCachedData (this.form.aXgateAddress.value,
																					  0,
																					  ClearCachedData_callback);
																					  this.form.aResult.value='';"/>
													<br/>
													<br/>
  													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.GetLastLocation"
  													onClick="AnySign.GetLastLocation (function(aResult){alert(aResult);})"/>
													<br/>
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.GetCacheCertLocation"
  													onClick="AnySign.GetCacheCertLocation (this.form.aXgateAddress.value,
																						   function(aResult){alert(aResult);})"/>
													<br/>
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.GetCacheCertLocationEx"
  													onClick="AnySign.GetCacheCertLocationEx (this.form.aXgateAddress.value,
																							 1,
																							 function(aResult){alert(aResult);})"/>
												</td>
											</tr>
											<tr>
												<td>Output</td>
												<td colspan="2">
													<textarea class="inputtextarea" id="output_id1" name="aResult" rows="7"></textarea>
													SignDataCMS: 
													<button onClick="onSendToServer (document.getElementById('output_id1').value); return false;">서버에 확인</button>
													<button onClick="this.form.aResult2.value='';this.form.action='<%=sign_result1_page%>';this.form.submit();">서버로 전송</button>
													<textarea class="inputtextarea" id="output_id2" name="aResult2" rows="7"></textarea>
													SignDataAdd: 
													<button onClick="this.form.aResult.value='';this.form.action='<%=sign_result2_page%>';this.form.submit();">서버로 전송</button>
												</td>
											</tr>
											<tr>
												<td>Reset</td>
												<td colspan="2">
													<button onClick="this.form.aResult.value='';this.form.aResult2.value='';return false;">결과값 삭제</button>
												</td>
											</tr>
										</table>
										</form>
										<br/>

										<h3 id="6">SignDataCMSWithSerial</h3>
										<form id="form_SignDataCMSWithSerial" name="form_SignDataCMSWithSerial" method="post">
										<table class="test">
											<tr>
												<td width="50" rowspan="8">Input</td>
												<td width="120">aXgateAddress</td>
												<td width="524"><input type="text" class="inputtext" name="aXgateAddress"/></td>
											</tr>
											<tr>
												<td>aCAList</td>
												<td><input type="text" class="inputtext" name="aCAList"/></td>
											</tr>
											<tr>
												<td>aSerial</td>
												<td><input type="text" class="inputtext" name="aSerial"/></td>
											</tr>
											<tr>
												<td>aLocation</td>
												<td><input type="text" class="inputtext" name="aLocation"/></td>
											</tr>
											<tr>
												<td>aPlain</td>
												<td><textarea class="inputtextarea" name="aPlain" rows="7"></textarea></td>
											</tr>
											<tr>
												<td>aOption</td>
												<td style="text-align:left;">
													<input type="checkbox" class="inputcheck" name="aOption" value="0" checked disabled="true"/>
													0 : 기본 서명<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="1"/>
													1 : 서명확인창을 보여준다.<br/>
												</td>
											</tr>
											<tr>
												<td>aDescription</td>
												<td><input type="text" class="inputtext" name="aDescription"/></td>
											</tr>
											<tr>
												<td>aLimitedTrial</td>
												<td><input type="text" class="inputtext" name="aLimitedTrial"/></td>
											</tr>
											<tr>
												<td>Run</td>
												<td colspan="2">
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.SignDataCMSWithSerial"
													onClick="AnySign.SignDataCMSWithSerial (this.form.aXgateAddress.value,
																							  this.form.aCAList.value,
																							  this.form.aSerial.value,
																							  this.form.aLocation.value,
																							  this.form.aPlain.value,
																							  sumCheckbox (this.form.aOption),
																							  this.form.aDescription.value,
																							  this.form.aLimitedTrial.value,
																							  SignDataCMSWithSerial_callback);"/>
													<br/>
													<input type="button" class="inputbutton" style="height:auto;" value="Sign_with_serial"
													onClick="Sign_with_serial (this.form.aSerial.value,
																			   this.form.aLocation.value,
																			   this.form.aPlain.value,
																			   sumCheckbox (this.form.aOption),
																			   SignDataCMSWithSerial_callback);"/>
													<br/>
													<br/>
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.GetLastLocation"
													onClick="AnySign.GetLastLocation (function(aResult){alert(aResult);})"/>
													<br/>
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.SignDataCMSWithSerial_Location"
													onClick="AnySign.SignDataCMSWithSerial_Location (this.form.aXgateAddress.value,
																									 this.form.aCAList.value,
																									 this.form.aSerial.value,
																									 this.form.aLocation.value,
																									 this.form.aPlain.value,
																									 sumCheckbox (this.form.aOption),
																									 this.form.aDescription.value,
																									 this.form.aLimitedTrial.value,
																									 SignDataCMSWithSerial_callback);"/>
												</td>
											</tr>
											<tr>
												<td>Output</td>
												<td colspan="2">
													<textarea class="inputtextarea" id="output_id3" name="aResult" rows="7"></textarea>
												</td>
											</tr>
											<tr>
												<td>Send</td>												
												<td colspan="2">
													<button onClick="onSendToServer (document.getElementById('output_id3').value); return false;">서버에 확인</button>
													<button onClick="this.form.action='<%=sign_result3_page%>';this.form.submit();">서버로 전송</button>
												</td>
											</tr>
										</table>
										</form>
										<br/>

										<h3 id="7">SignDataCMSWithHTMLEx</h3>
										<form id="form_SignDataCMSWithHTMLEx" name="form_SignDataCMSWithHTMLEx" method="post">
										<table class="test">
											<tr>
												<td width="50" rowspan="8">Input</td>
												<td width="120">aXgateAddress</td>
												<td width="524"><input type="text" class="inputtext" name="aXgateAddress"/></td>
											</tr>
											<tr>
												<td>aCAList</td>
												<td><input type="text" class="inputtext" name="aCAList"/></td>
											</tr>
											<tr>
												<td>aForm</td>
												<td><textarea class="inputtextarea" name="aForm" rows="7"></textarea></td>
											</tr>
											<tr>
												<td>aPlain</td>
												<td><textarea class="inputtextarea" name="aPlain" rows="7"></textarea></td>
											</tr>
											<tr>
												<td>aCert</td>
												<td><textarea class="inputtextarea" name="aCert" rows="7"></textarea></td>
											</tr>
											<tr>
												<td>aOption</td>
												<td style="text-align:left;">
													<input type="checkbox" class="inputcheck" name="aOption" value="0" checked disabled="true"/>
													0 : 기본 서명<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="1"/>
													1 : 서명확인창을 보여준다.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="4"/>
													4 : VID 생성<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="16"/>
													16 : IDN값을 입력받지 않는다 ""로 IDN대체 <strong>(VID입력창을 띄우지 않음)</strong><br/>
												</td>
											</tr>
											<tr>
												<td>aDescription</td>
												<td><input type="text" class="inputtext" name="aDescription"/></td>
											</tr>
											<tr>
												<td>aLimitedTrial</td>
												<td><input type="text" class="inputtext" name="aLimitedTrial"/></td>
											</tr>
											<tr>
												<td>Run</td>
												<td colspan="2">
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.SignDataCMSWithHTMLEx"
													onClick="AnySign.SignDataCMSWithHTMLEx (this.form.aXgateAddress.value,
																							  this.form.aCAList.value,
																							  this.form.aForm.value,
																							  this.form.aPlain.value,
																							  this.form.aCert.value,
																							  sumCheckbox (this.form.aOption),
																							  this.form.aDescription.value,
																							  this.form.aLimitedTrial.value,
																							  SignDataCMSWithHTMLEx_callback);"/>
													<br/>
													<input type="button" class="inputbutton" style="height:auto;" value="Sign_with_option_htmlex"
													onClick="Sign_with_option_htmlex (sumCheckbox (this.form.aOption),
																					  this.form.aForm.value,
																					  this.form.aPlain.value,
																					  this.form.aCert.value,
																					  SignDataCMSWithHTMLEx_callback);"/>
												</td>
											</tr>
											<tr>
												<td rowspan="2">Output</td>
												<td colspan="2">
													<textarea class="inputtextarea" id="output_id4" name="aResult" rows="7"></textarea>
												</td>
											</tr>
											<tr>
												<td colspan="2">
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.GetVidInfo()" 
														onclick="AnySign.GetVidInfo(GetVidInfo_callback)"/>
												</td>
											</tr>
											<tr>
												<td>Send</td>												
												<td colspan="2">
													<button onClick="onSendToServer (document.getElementById('output_id4').value); return false;">서버에 확인</button>
													<button onClick="this.form.aForm.value='';this.form.aPlain.value='';this.form.aCert.value='';
																	 this.form.action='<%=sign_result3_page%>';this.form.submit();">서버로 전송</button>
												</td>
											</tr>
										</table>
										</form>
										<br/>

										<h3 id="8">SignDataCMSWithHTMLExAndSerial</h3>
										<form id="form_SignDataCMSWithHTMLExAndSerial" name="form_SignDataCMSWithHTMLExAndSerial" method="post">
										<table class="test">
											<tr>
												<td width="50" rowspan="10">Input</td>
												<td width="120">aXgateAddress</td>
												<td width="524"><input type="text" class="inputtext" name="aXgateAddress"/></td>
											</tr>
											<tr>
												<td>aCAList</td>
												<td><input type="text" class="inputtext" name="aCAList"/></td>
											</tr>
											<tr>
												<td>aSerial</td>
												<td><input type="text" class="inputtext" name="aSerial"/></td>
											</tr>
											<tr>
												<td>aLocation</td>
												<td><input type="text" class="inputtext" name="aLocation"/></td>
											</tr>
											<tr>
												<td>aForm</td>
												<td><textarea class="inputtextarea" name="aForm" rows="7"></textarea></td>
											</tr>
											<tr>
												<td>aPlain</td>
												<td><textarea class="inputtextarea" name="aPlain" rows="7"></textarea></td>
											</tr>
											<tr>
												<td>aCert</td>
												<td><textarea class="inputtextarea" name="aCert" rows="7"></textarea></td>
											</tr>
											<tr>
												<td>aOption</td>
												<td style="text-align:left;">
													<input type="checkbox" class="inputcheck" name="aOption" value="0" checked disabled="true"/>
													0 : 기본 서명<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="1"/>
													1 : 서명확인창을 보여준다.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="4"/>
													4 : VID 생성<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="16"/>
													16 : IDN값을 입력받지 않는다 ""로 IDN대체 <strong>(VID입력창을 띄우지 않음)</strong><br/>
												</td>
											</tr>
											<tr>
												<td>aDescription</td>
												<td><input type="text" class="inputtext" name="aDescription"/></td>
											</tr>
											<tr>
												<td>aLimitedTrial</td>
												<td><input type="text" class="inputtext" name="aLimitedTrial"/></td>
											</tr>
											<tr>
												<td>Run</td>
												<td colspan="2">
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.SignDataCMSWithHTMLExAndSerial"
													onClick="AnySign.SignDataCMSWithHTMLExAndSerial (this.form.aXgateAddress.value,
																									 this.form.aCAList.value,
																									 this.form.aSerial.value,
																									 this.form.aLocation.value,
																									 this.form.aForm.value,
																									 this.form.aPlain.value,
																									 this.form.aCert.value,
																									 sumCheckbox (this.form.aOption),
																									 this.form.aDescription.value,
																									 this.form.aLimitedTrial.value,
																									 SignDataCMSWithHTMLExAndSerial_callback);"/>
													<br/>
													<input type="button" class="inputbutton" style="height:auto;" value="Sign_with_option_htmlex_Serial"
													onClick="Sign_with_option_htmlex_Serial (sumCheckbox (this.form.aOption),
																							 this.form.aForm.value,
																							 this.form.aPlain.value,
																							 this.form.aCert.value,
																							 this.form.aSerial.value,
																							 this.form.aLocation.value,
																							 SignDataCMSWithHTMLExAndSerial_callback);"/>
													<br/>
													<br/>
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.GetLastLocation"
													onClick="AnySign.GetLastLocation (function(aResult){alert(aResult);})"/>
													<br/>
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.SignDataCMSWithHTMLExAndSerial_Location"
													onClick="AnySign.SignDataCMSWithHTMLExAndSerial_Location (this.form.aXgateAddress.value,
																											  this.form.aCAList.value,
																											  this.form.aSerial.value,
																											  this.form.aLocation.value,
																											  this.form.aForm.value,
																											  this.form.aPlain.value,
																											  this.form.aCert.value,
																											  sumCheckbox (this.form.aOption),
																											  this.form.aDescription.value,
																											  this.form.aLimitedTrial.value,
																											  SignDataCMSWithHTMLExAndSerial_callback);"/>
												</td>
											</tr>
											<tr>
												<td rowspan="2">Output</td>
												<td colspan="2">
													<textarea class="inputtextarea" id="output_id5" name="aResult" rows="7"></textarea>
												</td>
											</tr>
											<tr>
												<td colspan="2">
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.GetVidInfo()" 
														onclick="AnySign.GetVidInfo(GetVidInfo_callback)"/>
												</td>
											</tr>
											<tr>
												<td>Send</td>												
												<td colspan="2">
													<button onClick="onSendToServer (document.getElementById('output_id5').value); return false;">서버에 확인</button>
													<button onClick="this.form.aForm.value='';this.form.aPlain.value='';this.form.aCert.value='';
																	 this.form.action='<%=sign_result3_page%>';this.form.submit();">서버로 전송</button>
												</td>
											</tr>
										</table>
										</form>
										<br/>


										<h3 id="9">SignDataWithVID</h3>
										<table class="test">
										<form id="form_SignDataWithVID"  method=post action='<%=sign_result3_page%>'>
											<tr>
												<td width="50" rowspan="8">Input</td>
												<td width="120">aXgateAddress</td>
												<td width="524"><input type="text" class="inputtext" name="aXgateAddress"/></td>
											</tr>
											<tr>
												<td>aCAList</td>
												<td><input type="text" class="inputtext" name="aCAList"/></td>
											</tr>
											</tr>
											<tr>
												<td>aPlain</td>
												<td><textarea class="inputtext" name="aPlain" rows="7"></textarea></td>
											</tr>
											<tr>
												<td>aCert</td>
												<td><textarea class="inputtext" name="aCert" rows="7"></textarea></td>
											</tr>
											<tr>
												<td>aOption</td>
												<td style="text-align:left;">
													<strong>(공통 옵션)</strong></br>
													<input type="checkbox" class="inputcheck" name="aOption" value="0" checked disabled="true"/>
													0 : 기본 서명<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="1"/>
													1 : 서명확인창을 보여준다.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="8"/>
													8 : <strong>WEB(aIdn)</strong>으로 부터 직접 VID를 입력받는다  <strong>(VID입력창 뜨지 않음)</strong><br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="16"/>
													16 : IDN값을 입력받지 않는다 ""로 IDN대체 <strong>(VID입력창을 띄우지 않음)</strong><br/>
												</td>
											</tr>
											<tr>
												<td>aIdn</td>
												<td><input type="text" class="inputtext" name="aIdn"/></td>
											</tr>
											<tr>
												<td>aDescription</td>
												<td><input type="text" class="inputtext" name="aDescription"/></td>
											</tr>
											<tr>
												<td>aLimitedTrial</td>
												<td><input type="text" class="inputtext" name="aLimitedTrial"/></td>
											</tr>
											<tr>
												<td>Run</td>
												<td colspan="2">
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.SignDataWithVID"
													onClick="AnySign.SignDataWithVID (this.form.aXgateAddress.value,
																					this.form.aCAList.value,
																					this.form.aPlain.value,
																					sumCheckbox (this.form.aOption),
																					this.form.aDescription.value,
																					this.form.aLimitedTrial.value,
																					this.form.aIdn.value,
																					this.form.aCert.value,
																					SignDataWithVID_callback);"/>
													<br/>
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.SignDataAddWithVID"
													onClick="AnySign.SignDataAddWithVID (this.form.aXgateAddress.value,
																					this.form.aCAList.value,
																					this.form.aSignedMsg.value,
																					sumCheckbox (this.form.aOption),
																					this.form.aDescription.value,
																					this.form.aLimitedTrial.value,
																					this.form.aIdn.value,
																					this.form.aCert.value,
																					SignDataAddWithVID_callback);"/>
													<br/>
													<input type="button" class="inputbutton" style="height:auto;" value="Sign_with_vid_user" 
													onClick="Sign_with_vid_user (sumCheckbox (this.form.aOption), 
																				 this.form.aPlain.value, 
																				 this.form.aCert.value,
																				 SignDataWithVID_callback);"/>
													<br/>
													<input type="button" class="inputbutton" style="height:auto;" value="Sign_with_vid_web" 
													onClick="Sign_with_vid_web (sumCheckbox (this.form.aOption), 
																				this.form.aPlain.value, 
																				this.form.aIdn.value, 
																				this.form.aCert.value,
																				SignDataWithVID_callback);"/>
													<br/>
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.SignDataWithVID_CacheCert"
													onClick="AnySign.SignDataWithVID_CacheCert (this.form.aXgateAddress.value,
																								this.form.aPlain.value,
																								sumCheckbox (this.form.aOption),
																								this.form.aIdn.value, 
																								this.form.aCert.value,
																								SignDataWithVID_CacheCert_callback);"/>
													<br/>
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.ClearCachedData"
													onClick="AnySign.ClearCachedData (this.form.aXgateAddress.value,
																					  0,
																					  ClearCachedData_callback);
																					  this.form.aSignedMsg.value='';this.form.aVidMsg.value='';"/>
												</td>
											</tr>
											<tr>
												<td>Output</td>
												<td colspan="2">
													<textarea class="inputtext" name="aSignedMsg" rows="7"></textarea>
												</td>
											</tr>
											<tr>
												<td>VID Output</td>
												<td colspan="2">
													<textarea class="inputtext" name="aVidMsg" rows="7"></textarea>
												</td>
											</tr>
											<tr>
												<td>Send</td>												
												<td colspan="4" height="25">
													<button onClick="this.form.aSignedMsg.value='';this.form.aVidMsg.value='';return false;">결과값 삭제</button>
													<input type=submit value="서버로전송">
												</td>
											</tr>
										</form>
										</table>
										<br/>


										<h3 id="10">SignDataWithVID_Serial</h3>
										<table class="test">
										<form id="form_SignDataWithVID_Serial" method=post action='<%=sign_result3_page%>' >
											<tr>
												<td width="50" rowspan="10">Input</td>
												<td width="120">aXgateAddress</td>
												<td width="524"><input type="text" class="inputtext" name="aXgateAddress"/></td>
											</tr>
											<tr>
												<td>aCAList</td>
												<td><input type="text" class="inputtext" name="aCAList"/></td>
											</tr>
											<tr>
												<td>aSerial</td>
												<td><input type="text" class="inputtext" name="aSerial"/></td>
											</tr>
											<tr>
												<td>aLocation</td>
												<td><input type="text" class="inputtext" name="aLocation"/></td>
											</tr>
											<tr>
												<td>aPlain</td>
												<td><textarea class="inputtext" name="aPlain" rows="7"></textarea></td>
											</tr>
											<tr>
												<td>aCert</td>
												<td><textarea class="inputtext" name="aCert" rows="7"></textarea></td>
											</tr>
											<tr>
												<td>aOption</td>
												<td style="text-align:left;">
													<strong>(공통 옵션)</strong></br>
													<input type="checkbox" class="inputcheck" name="aOption" value="0" checked disabled="true"/>
													0 : 기본 서명<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="1"/>
													1 : 서명확인창을 보여준다.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="8"/>
													8 : <strong>WEB(aIdn)</strong>으로 부터 직접 VID를 입력받는다  <strong>(VID입력창 뜨지 않음)</strong><br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="16"/>
													16 : IDN값을 입력받지 않는다 ""로 대체 <strong>(VID입력창 뜨지 않음)</strong><br/>
												</td>
											</tr>
											<tr>
												<td>aIdn</td>
												<td><input type="text" class="inputtext" name="aIdn"/></td>
											</tr>
											<tr>
												<td>aDescription</td>
												<td><input type="text" class="inputtext" name="aDescription"/></td>
											</tr>
											<tr>
												<td>aLimitedTrial</td>
												<td><input type="text" class="inputtext" name="aLimitedTrial"/></td>
											</tr>
											<tr>
												<td>Run</td>
												<td colspan="2">
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.SignDataWithVID_Serial"
													onClick="AnySign.SignDataWithVID_Serial (this.form.aXgateAddress.value,
																							 this.form.aCAList.value,
																							 this.form.aSerial.value,
																							 this.form.aLocation.value,
																							 this.form.aPlain.value,
																							 sumCheckbox (this.form.aOption),
																							 this.form.aDescription.value,
																							 this.form.aLimitedTrial.value,
																							 this.form.aIdn.value, 
																							 this.form.aCert.value,
																							 SignDataWithVID_Serial_callback);"/>
													<!--br/>
													<input type="button" class="inputbutton" style="height:auto;" value="Sign_with_vid_user_serial"
													onClick="Sign_with_vid_user_serial (this.form.aSerial.value,
																						this.form.aLocation.value,
																						sumCheckbox (this.form.aOption),
																						this.form.aPlain.value,
																						this.form.aCert.value,
																						SignDataWithVID_Serial_callback);"/>
													<input type="button" class="inputbutton" style="height:auto;" value="Sign_with_vid_web_serial"
													onClick="Sign_with_vid_web_serial (this.form.aSerial.value,
																					   this.form.aLocation.value, 
																					   sumCheckbox (this.form.aOption), 
																					   this.form.aPlain.value,  
																					   this.form.aCert.value,
																					   this.form.aIdn.value, 
																					   SignDataWithVID_Serial_callback);"/--->
													<br/>
   													<br/>
   													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.GetLastLocation"
   													onClick="AnySign.GetLastLocation (function(aResult){alert(aResult);})"/>
   													<br/>
   													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.SignDataWithVID_Serial_Location"
   													onClick="AnySign.SignDataWithVID_Serial_Location (this.form.aXgateAddress.value,
   																									  this.form.aCAList.value,
   																									  this.form.aSerial.value,
   																									  this.form.aLocation.value,
   																									  this.form.aPlain.value,
   																									  sumCheckbox (this.form.aOption),
   																									  this.form.aDescription.value,
																									  this.form.aLimitedTrial.value,
				 																					  this.form.aIdn.value, 
   																									  this.form.aCert.value,
   																									  SignDataWithVID_Serial_callback);"/>
												</td>
											</tr>
											<tr>
												<td>Output</td>
												<td colspan="2">
													<textarea class="inputtext" name="aSignedMsg" rows="7"></textarea>
												</td>
											</tr>
											<tr>
												<td>Vid Output</td>
												<td colspan="2">
													<textarea class="inputtext" name="aVidMsg" rows="7"></textarea>
												</td>
											</tr>
											<tr>
												<td>Send</td>
												<td colspan="3" height="25"><input type=submit value="서버로전송">
												</td>
											</tr>
										</form>
										</table>
										<br/>


										<h3 id="11">MultiSignEx</h3>
										<form id="form_MultiSignEx" name="form_MultiSignEx">
										<table class="test">
											<tr>
												<td width="50" rowspan="8">Input</td>
												<td width="120">aXgateAddress</td>
												<td width="524"><input type="text" class="inputtext" name="aXgateAddress"/></td>
											</tr>
											<tr>
												<td>aCAList</td>
												<td><input type="text" class="inputtext" name="aCAList"/></td>
											</tr>
											<tr>
												<td>aPlain</td>
												<td><textarea class="inputtextarea" name="aPlain" rows="7" 
													  onChange="this.form.aTotal.value=this.form.aPlain.value.split(this.form.aDelimiter.value).length-1"></textarea></td>
											</tr>
												<td>aTotal</td>
												<td><input type="text" class="inputtext" name="aTotal"/></td>
											</tr>
											<tr>
												<td>aDelimiter</td>
												<td><input type="text" class="inputtext" name="aDelimiter"/></td>
											</tr>
											<tr>
												<td>aCertSerial</td>
												<td><input type="text" class="inputtext" name="aCertSerial"/></td>
											</tr>
											<tr>
												<td>aCertLocation</td>
												<td><input type="text" class="inputtext" name="aLocation"/></td>
											</tr>
											<tr>
												<td>aCert</td>
												<td><textarea class="inputtextarea" name="aCert" rows="7"></textarea></td>
											</tr>
											<tr>
												<td>Run</td>
												<td colspan="2">
													<input type="button" class="inputbutton" style="height:auto;" value="MuiltiSign"
													onClick="MultiSign(this.form.aTotal.value,
																	   this.form.aPlain.value,
																	   this.form.aDelimiter.value,
																	   MultiSignEx_callback);"/>
													<br/>
													<input type="button" class="inputbutton" style="height:auto;" value="MultiSignWithSerial"
													onClick="MultiSignWithSerial(this.form.aTotal.value,
																				 this.form.aPlain.value,
																				 this.form.aDelimiter.value,
																				 this.form.aCertSerial.value,
																				 this.form.aLocation.value,
																				 MultiSignEx_callback);"/>
													<br/>
													<input type="button" class="inputbutton" style="height:auto;" value="MultiSignWithVID_Serial"
													onClick="MultiSignWithVID_Serial(this.form.aTotal.value,
																					 this.form.aPlain.value,
																					 this.form.aDelimiter.value,
																					 this.form.aCertSerial.value,
																					 this.form.aLocation.value,
																					 this.form.aCert.value,
																					 MultiSignExWithVID_callback);"/>
												</td>
											</tr>
											<tr>
												<td rowspan="2">Output</td>
												<td colspan="2">
													<textarea class="inputtextarea" name="aResult" id="output_id6" rows="7"></textarea>
												</td>
											</tr>
											<tr>
												<td colspan="2">
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.GetVidInfo()" 
														onclick="AnySign.GetVidInfo(GetVidInfo_callback)"/>
												</td>
											</tr>
											<tr>
												<td>Send</td>												
												<td colspan="2">
													<button onClick="verifyMessage(document.getElementById('output_id6').value, this.form.aTotal.value, this.form.aDelimiter.value); return false;">서버에 확인</button>
												</td>
											</tr>
										</table>
										</form>
										<br/>

										
										<h3 id="12">SignFile</h3>
										<form id="form_SignFile" name="form_SignFile">
										<table class="test">
											<tr>
												<td width="50" rowspan="7">Input</td>
												<td width="120">aXgateAddress</td>
												<td width="524"><input type="text" class="inputtext" name="aXgateAddress"/></td>
											</tr>
											<tr>
												<td>aCAList</td>
												<td><input type="text" class="inputtext" name="aCAList"/></td>
											</tr>
											<tr>
												<td>SignFilePath</td>
												<td><input type="text" class="inputtext" name="aSignFilePath"/></td>
											</tr>
											<tr>
												<td>OutFilePath</td>
												<td><input type="text" class="inputtext" name="aSignedFilePath"/></td>
											</tr>
											<tr>
												<td>aOption</td>
												<td style="text-align:left;">
													<input type="checkbox" class="inputcheck" name="aOption" value="0" checked disabled="true"/>
													0x00000000 : 기본 서명<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="1"/>
													0x00000001 : 서명확인창을 보여준다.<br/>
												</td>
											</tr>
											<tr>
												<td>aDescription</td>
												<td><input type="text" class="inputtext" name="aDescription"/></td>
											</tr>
											<tr>
												<td>aLimitedTrial</td>
												<td><input type="text" class="inputtext" name="aLimitedTrial"/></td>
											</tr>
											<tr>
												<td>Run</td>
												<td colspan="2">
													<input type="button" class="inputbutton" style="height:auto;" value="OpenFileDialog" 
													onClick="AnySign.ShowSignFileSelectDialog(SignFileSelect_callback);"/>
													</br>
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.SignFile" 
													onClick="AnySign.SignFile(this.form.aXgateAddress.value,
																					this.form.aCAList.value,
																					this.form.aSignFilePath.value,
																					this.form.aSignedFilePath.value,
																					sumCheckbox (this.form.aOption),
																					this.form.aDescription.value,
																					this.form.aLimitedTrial.value,
																					SignFile_callback,
																					SignFile_errorcallback);"/>
													</br>
												</td>
											</tr>
										</table>
										</form>
										<br/>


										<h3 id="13">MultiFileSign</h3>
										<form id="form_MultiFileSign" name="form_MultiFileSign">
										<table class="test">
											<tr>
												<td width="50" rowspan="7">Input</td>
												<td width="120">aXgateAddress</td>
												<td width="524"><input type="text" class="inputtext" name="aXgateAddress"/></td>
											</tr>
											<tr>
												<td>aCAList</td>
												<td><input type="text" class="inputtext" name="aCAList"/></td>
											</tr>
											<tr>
												<td>aSignFiles</td>
												<td><textarea class="inputtextarea" name="aSignFilePath" rows="4" 
													  onChange="this.form.aTotal.value=this.form.aSignFilePath.value.split(this.form.aDelimiter.value).length-1"></textarea></td>
											</tr>
												<td>aTotal</td>
												<td><input type="text" class="inputtext" name="aTotal"/></td>
											</tr>
											<tr>
												<td>aDelimiter</td>
												<td><input type="text" class="inputtext" name="aDelimiter"/></td>
											</tr>
											<tr>
												<td>aCertSerial</td>
												<td><input type="text" class="inputtext" name="aCertSerial"/></td>
											</tr>
											<tr>
												<td>aCertLocation</td>
												<td><input type="text" class="inputtext" name="aLocation"/></td>
											</tr>
											<tr>
												<td>Run</td>
												<td colspan="2">
													<input type="button" class="inputbutton" style="height:auto;" value="MuiltiSign"
													onClick="MultiFileSign(this.form.aTotal.value,
																		   this.form.aSignFilePath.value,
																		   this.form.aDelimiter.value,
																		   MultiFileSign_callback);"/>
													<br/>
												</td>
											</tr>
										</table>
										</form>
										<br/>


										<h3 id="14">EnvelopeData</h3>
										<form id="form_EnvelopData" name="form_EnvelopData">
										<table class="test">
											<tr>
												<td width="50" rowspan="10">Input</td>
												<td width="120">aXgateAddress</td>
												<td width="524"><input type="text" class="inputtext" name="aXgateAddress"/></td>
											</tr>
											<tr>
												<td>aCAList</td>
												<td><input type="text" class="inputtext" name="aCAList"/></td>
											</tr>
											<tr>
												<td>aPlain</td>
												<td><textarea class="inputtextarea" name="aPlain" rows="7"></textarea></td>
											</tr>
											<tr>
												<td>aOption</td>
												<td style="text-align:left;">
													<input type="checkbox" class="inputcheck" name="aOption" value="1" checked/>
													1 : 인증서 사용.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="2"/>
													2 : 비밀번호 사용.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="4"/>
													4 : 여러개의 인증서 사용 (1과 함께 사용).<br/>
												</td>
											</tr>
											<tr>
												<td>aPassword</td>
												<td><input type="password" class="inputtext" name="aPassword" /></td>
											</tr>
											<tr>
												<td>aPEM</td>
												<td style="text-align:left;">
													<input type="checkbox" class="inputcheck" name="aPEM" /> 서버 인증서 (PEM) 사용 <br>
													<textarea class="inputtextarea" name="aCert" rows="7"></textarea>
												</td>
											</tr>
											<tr>
												<td>aCertSerial</td>
												<td><input type="text" class="inputtext" name="aSerial"/></td>
											</tr>
											<tr>
												<td>aCertLocation</td>
												<td><input type="text" class="inputtext" name="aLocation"/></td>
											</tr>
											<tr>
												<td>aDescription</td>
												<td><input type="text" class="inputtext" name="aDescription"/></td>
											</tr>
											<tr>
												<td>Run</td>
												<td colspan="2">
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.EnvelopData"
													onClick="AnySign.EnvelopData (this.form.aXgateAddress.value,
																				  this.form.aCAList.value,
																				  this.form.aPlain.value,
																				  sumCheckbox (this.form.aOption),
																				  this.form.aPassword.value,
																				  this.form.aPEM.checked ? this.form.aCert.value : null,
																				  this.form.aSerial.value,
																				  this.form.aLocation.value,
																				  this.form.aDescription.value,
																				  EnvelopData_callback);"/>
													<br/>
   													<br/>
   													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.GetLastLocation"
   													onClick="AnySign.GetLastLocation (function(aResult){alert(aResult);})"/>
   													<br/>
   													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.EnvelopData_Location"
   													onClick="AnySign.EnvelopData_Location (this.form.aXgateAddress.value,
																						   this.form.aCAList.value,
																						   this.form.aPlain.value,
																						   sumCheckbox (this.form.aOption),
																						   this.form.aPassword.value,
																						   this.form.aPEM.checked ? this.form.aCert.value : null,
																						   this.form.aSerial.value,
																						   this.form.aLocation.value,
																						   this.form.aDescription.value,
																						   EnvelopData_callback);"/>
												</td>
											</tr>
											<tr>
												<td>Output</td>
												<td colspan="2">
													<textarea class="inputtextarea" name="aResult" rows="7"></textarea>
												</td>
											</tr>
										</table>
										</form>
										<br/>


										<h3 id="15">DeEnvelopeData</h3>
										<form id="form_DeEnvelopData" name="form_DeEnvelopData">
										<table class="test">
											<tr>
												<td width="50" rowspan="9">Input</td>
												<td width="120">aXgateAddress</td>
												<td width="524"><input type="text" class="inputtext" name="aXgateAddress"/></td>
											</tr>
											<tr>
												<td>aCAList</td>
												<td><input type="text" class="inputtext" name="aCAList"/></td>
											</tr>
											<tr>
												<td>aEnvelopedData</td>
												<td><textarea class="inputtextarea" name="aEnvelopedData" rows="7"></textarea></td>
											</tr>
											<tr>
												<td>aOption</td>
												<td style="text-align:left;">
													<input type="radio" class="inputcheck" name="aOption" value="1" checked/>
													1 : 인증서 사용.<br/>
													<input type="radio" class="inputcheck" name="aOption" value="2"/>
													2 : 비밀번호 사용.<br/>
												</td>
											</tr>
											<tr>
												<td>aPassword</td>
												<td><input type="password" class="inputtext" name="aPassword" /></td>
											</tr>
											<tr>
												<td>aDescription</td>
												<td><input type="text" class="inputtext" name="aDescription"/></td>
											</tr>
											<tr>
												<td>Run</td>
												<td colspan="2">
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.DeEnvelopData"
													onClick="AnySign.DeEnvelopData (this.form.aXgateAddress.value,
																					  this.form.aCAList.value,
																					  this.form.aEnvelopedData.value,
																					  this.form.aOption[0].checked ? 1 : 2,
																					  this.form.aPassword.value,
																					  this.form.aDescription.value,
																					  null,
																					  DeEnvelopData_callback);"/>
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.DeEnvelopDataWithCacheCert"
													onClick="AnySign.DeEnvelopDataWithCacheCert (this.form.aXgateAddress.value,
																					  this.form.aEnvelopedData.value,
																					  DeEnvelopData_callback);"/>								  
												</td>
											</tr>
											<tr>
												<td>Output</td>
												<td colspan="2">
													<textarea class="inputtextarea" name="aResult" rows="7"></textarea>
												</td>
											</tr>
										</table>
										</form>
										<br/>


										<h3 id="16">ShowCertManager</h3>
										<table class="test">
											<tr>
												<td width="50">Run</td>
												<td width="644" colspan="2">
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.ShowCertManager"
													onClick="AnySign.ShowCertManager ();"/>
													<br/>
													<input type="button" class="inputbutton" style="height:auto;" value="ShowCertManager"
													onClick="ShowCertManager ();"/>
												</td>
											</tr>
										</table>
										<br/>


										<h3 id="17">CMP</h3>
										<table class="test" width="100%">
											<tr>
												<td>Option</td>
												<td>인증서 갱신</td>
												<td style="text-align:left;">
													<input type="checkbox" class="inputcheck" id="ShowRenewCertSaveLoc" name="ShowRenewCertSaveLoc" onclick="enableShowRenewCertSaveLoc(this)"/> ShowRenewCertSaveLoc
												</td>
											</tr>
											<tr>
												<td>Run</td>
												<td width="240px" style="text-align:right; padding-right:15px;">
													참조번호:<input type="text" class="smallbtn" id="public_refcode" style="border:1px solid #CC7733;" value=""/><br/>
													인가코드:<input type="text" class="smallbtn" id="public_authcode" style="border:1px solid #CC7733;" value=""/><br/>
													이름:<input type="text" class="smallbtn" id="public_name" style="border:1px solid #579A33;" value=""/><br/>
													주민등록번호:<input type="text" class="smallbtn" id="public_ssn" style="border:1px solid #579A33;" value=""/><br/>
													<button onclick="clearField('cmp_public');">입력값 지움</button>
												</td>
												<td>
													<table width="300px" cellpadding="0" cellspacing="0" align="center">
														<tr>
															<td colspan="2" style="text-align:right;">
																<br/>
																인증 기관 종류:
																<select id="public_type" class="combo">
																<option value="104">개인 - 보험용</option>
																<option value="202">법인 - 금융</option>
																</select><br/>
																공개키 알고리즘:
																<select id="public_or_private" class="combo">
																<option value="yessign">공인 - 금결원</option>
																<option value="xecureca">사설 - XecureCA</option>
																<option value="yessignmpki">MKPI - 금결원</option>
																</select><br/>
																키길이:
																<select id="key_algorithm" class="combo">
																<option value="rsa">RSA</option>
																<option value="kcdsa">KCDSA - 사설전용</option>
																</select><br/>
																인증서 용도:
																<select id="1024_or_2048" class="combo">
																<option value="2048">2048 - 고도화</option>
																<option value="1024">1024 - 기존</option>
																</select><br/><br/>
															</td>
														</tr>
														<tr>
															<td>
																<button style="width:150px;" onclick="onRegistCertificate ('new');">등록 요청</button>
															</td>
															<td>
																<button style="width:150px;" onclick="onRequestCertificate (0);">인증서 발급</button>
															</td>
														</tr>
														<tr>
															<td>
																<button style="width:150px;" onclick="onRegistCertificate ('rereg');">재등록 요청</button>
															</td>
															<td>
																<button style="width:150px;" onclick="onRequestCertificate (0);">인증서 재발급</button>
															</td>
														</tr>
														<tr>
															<td>
																<button style="width:150px;" onclick="onRegistCertificate ('update');">갱신 요청(공인)</button>
															</td>
															<td>
																<button style="width:150px;" onclick="onUpdateCertificate (10);">인증서 갱신</button>
															</td>
														</tr>
													</table>
												</td>
											</tr>
											<tr>
												<td>Output</td>
												<td colspan="2">
													<textarea class="inputtextarea" id="requestResult" rows="4"></textarea>
												</td>
											</tr>
										</table>
										<br/>


										<h3 id="18">RevokeCertificate</h3>
										<form id="form_RevokeCertificate" name="form_RevokeCertificate">
										<table class="test">
											<tr>
												<td width="50" rowspan="4">Input</td>
												<td width="120">aType</td>
												<td width="524"><input type="text" class="inputtext" name="aType"/></td>
											</tr>
											<tr>
												<td>aJobCode</td>
												<td><input type="text" class="inputtext" name="aJobCode"/></td>
											</tr>
											<tr>
												<td>aReason</td>
												<td><input type="text" class="inputtext" name="aReason"/></td>
											</tr>
											<tr>
												<td>aLimitedTrial</td>
												<td><input type="text" class="inputtext" name="aLimitedTrial"/></td>
											</tr>
											<tr>
												<td width="50">Run</td>
												<td width="644" colspan="2">
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.RevokeCertificate"
													onClick="AnySign.RevokeCertificate (this.form.aType.value,
																						  this.form.aJobCode.value,
																						  this.form.aReason.value,
																						  this.form.aLimitedTrial.value,
																						  RevokeCertificate_callback);"/>
													<br/>
													<input type="button" class="inputbutton" style="height:auto;" value="RevokeCertificate"
													onClick="RevokeCertificate (this.form.aType.value,
																				this.form.aJobCode.value,
																				this.form.aReason.value,
																				RevokeCertificate_callback);"/>
												</td>
											</tr>
											<tr>
												<td>Output</td>
												<td colspan="2">
													<textarea class="inputtextarea" name="aResult" rows="7"></textarea>
												</td>
											</tr>
										</table>
										</form>
										<br/>
										
										<h3 id="19">FileHash</h3>
										<form id="form_fileHash" name="form_fileHash">
										<table class="test">
											<tr>
												<td width="50" rowspan="2">Input</td>
												<td width="120">aFilePath</td>
												<td width="524"><input type="text" class="inputtext" name="aFilePath"/></td>
											</tr>
											<tr>
												<td>Algorithm</td>
												<td style="text-align:left;">
													<input type="radio" class="inputcheck" name="alg" value="0" checked/>
													XW_HASH_MD2<br/>
													<input type="radio" class="inputcheck" name="alg" value="1"/>
													XW_HASH_MD5<br/>
													<input type="radio" class="inputcheck" name="alg" value="2"/>
													XW_HASH_SHA1<br/>
													<input type="radio" class="inputcheck" name="alg" value="3"/>
													XW_HASH_RIPEMD160<br/>
													<input type="radio" class="inputcheck" name="alg" value="4"/>
													XW_HASH_HAS160<br/>
													<input type="radio" class="inputcheck" name="alg" value="5"/>
													XW_HASH_SHA256<br/>
												</td>
											</tr>
											<tr>
												<td>Run</td>
												<td colspan="2">
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.FileHash"
													onClick="FileHash (this.form.aFilePath.value,
																	   sumCheckbox(this.form.alg),
																	   FileHash_callback);"/>
													<br/>
												</td>
											</tr>
											<tr>
												<td>Output</td>
												<td colspan="2">
													<textarea class="inputtextarea" name="aFileHashResult" rows="3"></textarea>
												</td>
											</tr>
										</table>
										</form>
										<br/>


										<h3 id="20">Wif</h3>
										<form id="form_wif" name="form_wif">
										<table class="test" width="700px">
											<tr>
												<td width="50" rowspan="2">Input</td>
												<td width="120">aCert</td>
												<td width="524"><textarea class="inputtextarea" name="aCert" rows="7"></textarea></td>
											</tr>
											<tr>
												<td>aOption</td>
												<td style="text-align:left;">
													<input type="checkbox" class="inputcheck" name="aOption" value="1" checked/>
													0x0001 : HDD Serial(only windows)<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="2"/>
													0x0002 : Mac Address<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="4"/>
													0x0004 : IP Address<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="256"/>
													0x0100 : All User Info<br/>
												</td>
											</tr>
											<tr>
												<td>Run</td>
												<td colspan="2">
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.Wif"
													onClick="AnySign.Wif (sumCheckbox(this.form.aOption), this.form.aCert.value, wif_callback);"/>
													<br/>
												</td>
											</tr>
											<tr>
												<td>Output</td>
												<td colspan="2">
													<textarea class="inputtextarea" id="aWifResult" rows="7"></textarea>
													<button onClick="onWifResult (document.getElementById('aWifResult').value); return false;">서버에 확인</button>
												</td>
											</tr>
										</table>
										</form>
										<br/>

										<h3 id="21">getKTBScanInfo</h3>
										<form id="form_getKTBScanInfo" name="form_getKTBScanInfo">
										<table class="test">
											<tr>
												<td width="50" rowspan="2">Input</td>
												<td width="120">aServerIP</td>
												<td width="524"><input type="text" class="inputtext" name="aServerIP"/></td>
											</tr>
											<tr>
												<td>aServerPort</td>
												<td><input type="text" class="inputtext" name="aServerPort"/></td>
											</tr>
											<tr>
												<td>Run</td>
												<td colspan="2">
													<input type="button" class="inputbutton" style="height:auto;" value="getKTBScanInfo"
													onClick="AnySign.getKTBScanInfo (this.form.aServerIP.value, this.form.aServerPort.value, CB_getKTBScanInfo);"/>
													<br/>
												</td>
											</tr>
											<tr>
												<td>Output</td>
												<td colspan="2">
													<textarea class="inputtextarea" name="aScanInfo" rows="7"></textarea>
												</td>
											</tr>
										</table>
										</form>
										<br/>

										<h3 id="22">getCertPath</h3>
										<form id="form_GetCertPath" name="form_GetCertPath">
										<table class="test">
											<tr>
												<td>Run</td>
												<td width=694>
													<input type="button" class="inputbutton" style="height:auto;" value="getCertPath"
													onClick="AnySign.GetCertPath (GetCertPath_callback);"/>
												</td>
											</tr>
											<tr>
												<td>Output</td>
												<td colspan="2">
													<textarea class="inputtextarea" name="aResult" rows="3"></textarea>
												</td>
											</tr>
											<tr>
												<td>Signed</td>
												<td colspan="2">
													<textarea class="inputtextarea" name="aResult_aSigned" rows="6"></textarea>
												</td>
											</tr>
										</table>
										</form>
										<br/>

										<h3 id="23">certselectwide</h3>
										<table class="test">
											<tr>
												<td width="694">
													<a href="./certselectwide.jsp">[certselectwide]</a>
												</td>
											</tr>
										</table>
										<br/>
										
										<h3 id="24">SignFileInfo</h3>
										<table class="test">
											<tr>
												<td width="694">
													<a href="./signfileinfo_client.jsp">[SignFileInfo]</a>
												</td>
											</tr>
										</table>
										<br/>
										
										<h3 id="25">FCMS</h3>
										<table class="test">
											<tr>
												<td width="694">
													<a href="./fcms.jsp">[FCMS]</a>
												</td>
											</tr>
										</table>
										<br/>

									</td>
								</tr>
							</table>
							<!-- CENTER END -->
						</td>
						<!-- contents end -->
					</tr>
				</table>
			</td>
		</tr>

		<!-- Footer -->
		<tr>
			<td>
				<div id="xecure_footer" />
			</td>
		</tr>
	</table>
</body>
</html>
