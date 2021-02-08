<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="xecure.servlet.*" %>
<%@ page import="xecure.crypto.*" %>
<%@ page import="java.security.*" %>
<%@ page import="java.util.Random" %>
<%@ page import="java.io.File" %>
<%
	File file = null;
	int i = 0;
	File[] files = null;

//	String servletPath = request.getServletPath();
//	String realPath = request.getRealPath(servletPath);

//	file = new File (realPath);
//	realPath = file.getParent() + "/download";
	
	String realPath = "/FileStore/";
	file = new File(realPath);
	if (file.exists() && file.isDirectory())
	{
		files = file.listFiles();
	}
%>
<html>
<head>
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
.inputselect	{width: 100%;}
ainput{border:0px; margin:2px; padding:1px;}
.inputbutton	{width: 100%;height: 100%; border:1px solid #d3d3d3; margin:2px; padding:1px;}
.inputcheck		{width: 14px;height: 14px;}
-->
</style>

<script type="text/javascript">
document.write("<script type=\"text/javascript\" src=\"" + "../anySign4PCInterface.js" + "?version=" + new Date().getTime() + "\"></scr"+"ipt>");
</script>

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
%>
PrintObjectTag ();
</script>
<script>
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

function sumSelect (aSelect)
{
	var aIter;
	var aTotal = "";

	for (aIter = 0;aIter < aSelect.length;aIter++)
	{
		if (aSelect[aIter].selected)
		{
			aTotal += aSelect[aIter].value;
			aTotal += "|";
		}
	}

	aTotal = aTotal.substring (0, aTotal.length - 1);

	return aTotal;
}

function disableInput (check, element)
{
	if (check) {
		element.disabled = true;
		element.value = "";
	} else {
		element.disabled = false;
	}
}

function init()
{
	initForm();
	numbering();
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
	// form_SignFileEx
	document.getElementById ("form_SignFileEx").aXgateAddress.value = AnySign.mXgateAddress;
	document.getElementById ("form_SignFileEx").aCAList.value = AnySign.mCAList;
	document.getElementById ("form_SignFileEx").aLimitPassword.value = AnySign.mLimitedTrial;
	document.getElementById ("form_SignFileEx").aDescription.value = "파일 전자서명을 진행합니다.";
	
	// form_SignFileExWithSerial
	document.getElementById ("form_SignFileExWithSerial").aXgateAddress.value = AnySign.mXgateAddress;
	document.getElementById ("form_SignFileExWithSerial").aCAList.value = AnySign.mCAList;
	document.getElementById ("form_SignFileExWithSerial").aLimitPassword.value = AnySign.mLimitedTrial;
	document.getElementById ("form_SignFileExWithSerial").aDescription.value = "파일 전자서명을 진행합니다.";
	
	// form_SignFileExWithVID
	document.getElementById ("form_SignFileExWithVID").aXgateAddress.value = AnySign.mXgateAddress;
	document.getElementById ("form_SignFileExWithVID").aCAList.value = AnySign.mCAList;
	document.getElementById ("form_SignFileExWithVID").aLimitPassword.value = AnySign.mLimitedTrial;
	document.getElementById ("form_SignFileExWithVID").aDescription.value = "파일 전자서명을 진행합니다.";
	
	// form_SignFileExWithVID_Serial
	document.getElementById ("form_SignFileExWithVID_Serial").aXgateAddress.value = AnySign.mXgateAddress;
	document.getElementById ("form_SignFileExWithVID_Serial").aCAList.value = AnySign.mCAList;
	document.getElementById ("form_SignFileExWithVID_Serial").aLimitPassword.value = AnySign.mLimitedTrial;
	document.getElementById ("form_SignFileExWithVID_Serial").aDescription.value = "파일 전자서명을 진행합니다.";
	
	// form_VerifyFile
	document.getElementById ("form_VerifyFile").aDescription.value = "전자서명된 파일을 검증합니다.";
	
	// form_GetVerifiedFileCertInfo
	document.getElementById ("form_GetVerifiedFileCertInfo").aIndex.value = 0;
	
	// form_VerifyAndSignFile
	document.getElementById ("form_VerifyAndSignFile").aVerifyDescription.value = "전자서명된 파일을 검증합니다.";
	document.getElementById ("form_VerifyAndSignFile").aXgateAddress.value = AnySign.mXgateAddress;
	document.getElementById ("form_VerifyAndSignFile").aCAList.value = AnySign.mCAList;
	document.getElementById ("form_VerifyAndSignFile").aLimitPassword.value = AnySign.mLimitedTrial;
	document.getElementById ("form_VerifyAndSignFile").aSignDescription.value = "파일 전자서명을 진행합니다.";
	
	// form_ExtractFile
	document.getElementById ("form_ExtractFile").aDescription.value = "전자서명된 파일에서 원문 파일을 추출합니다.";
	
	// form_EnvelopeFileWithPEM
	document.getElementById ("form_EnvelopeFileWithPEM").aCertPEM.value = s;
	document.getElementById ("form_EnvelopeFileWithPEM").aDescription.value = "파일 전자봉투 암호화를 진행합니다.";
	
	// form_EnvelopeFileWithCert
	document.getElementById ("form_EnvelopeFileWithCert").aXgateAddress.value = AnySign.mXgateAddress;
	document.getElementById ("form_EnvelopeFileWithCert").aCAList.value = AnySign.mCAList;
	document.getElementById ("form_EnvelopeFileWithCert").aDescription.value = "파일 전자봉투 암호화를 진행합니다.";
	
	// form_EnvelopeFileWithCert_Serial
	document.getElementById ("form_EnvelopeFileWithCert_Serial").aXgateAddress.value = AnySign.mXgateAddress;
	document.getElementById ("form_EnvelopeFileWithCert_Serial").aCAList.value = AnySign.mCAList;
	document.getElementById ("form_EnvelopeFileWithCert_Serial").aDescription.value = "파일 전자봉투 암호화를 진행합니다.";
		
	// form_DeEnvelopeFileWithCert
	document.getElementById ("form_DeEnvelopeFileWithCert").aXgateAddress.value = AnySign.mXgateAddress;
	document.getElementById ("form_DeEnvelopeFileWithCert").aCAList.value = AnySign.mCAList;
	document.getElementById ("form_DeEnvelopeFileWithCert").aLimitPassword.value = AnySign.mLimitedTrial;
	document.getElementById ("form_DeEnvelopeFileWithCert").aDescription.value = "파일 전자봉투 복호화를 진행합니다.";
	
	// form_DeEnvelopeFileWithCert_Serial
	document.getElementById ("form_DeEnvelopeFileWithCert_Serial").aXgateAddress.value = AnySign.mXgateAddress;
	document.getElementById ("form_DeEnvelopeFileWithCert_Serial").aCAList.value = AnySign.mCAList;
	document.getElementById ("form_DeEnvelopeFileWithCert_Serial").aLimitPassword.value = AnySign.mLimitedTrial;
	document.getElementById ("form_DeEnvelopeFileWithCert_Serial").aDescription.value = "파일 전자봉투 복호화를 진행합니다.";
	
	// form_EnvelopeFileWithPasswd
	document.getElementById ("form_EnvelopeFileWithPasswd").aDescription.value = "파일 전자봉투 암호화를 진행합니다.";
	
	// form_DeEnvelopeFileWithPasswd
	document.getElementById ("form_DeEnvelopeFileWithPasswd").aDescription.value = "파일 전자봉투 복호화를 진행합니다.";
	
	var aPort = "";
	if (window.location.port == "") {
		if (window.location.protocol == "https:") aPort = "443";
		else aPort = "80";
	} else {
		aPort = window.location.port;
	}
	
	var aPathname = location.pathname;
	var aLastIndex = aPathname.lastIndexOf("/");
	
	// form_UploadFile
	document.getElementById ("form_UploadFile").aXgateAddress.value = AnySign.mXgateAddress;
	document.getElementById ("form_UploadFile").aHostName.value = window.location.hostname;
	document.getElementById ("form_UploadFile").aPort.value = 80;
	document.getElementById ("form_UploadFile").aPath.value = aPathname.substring(0, aLastIndex) + "/file_upload.jsp";
	document.getElementById ("form_UploadFile").aQuery.value = "param1=test.txt&param2=한글테스트";
	document.getElementById ("form_UploadFile").aDescription.value = "파일을 업로드합니다.";
	
	// form_DownloadFile
	document.getElementById ("form_DownloadFile").aXgateAddress.value = AnySign.mXgateAddress;
	document.getElementById ("form_DownloadFile").aHostName.value = window.location.hostname;
	document.getElementById ("form_DownloadFile").aPort.value = 80;
	document.getElementById ("form_DownloadFile").aPath.value = aPathname.substring(0, aLastIndex) + "/file_download.jsp";
	document.getElementById ("form_DownloadFile").aQuery.value = "param1=test.txt&param2=한글테스트 똠벩";
	document.getElementById ("form_DownloadFile").aDescription.value = "파일을 다운로드합니다.";
	
	// ZipFile
	document.getElementById ("form_ZipFile").aXgateAddress.value = AnySign.mXgateAddress;
	document.getElementById ("form_ZipFile").aDescription.value = "파일을 압축합니다.";
	
	// UnZipFile
	document.getElementById ("form_UnZipFile").aXgateAddress.value = AnySign.mXgateAddress;
	document.getElementById ("form_UnZipFile").aDescription.value = "압축된 파일을 해제합니다.";
	
	// form_SelectFile
	document.getElementById ("form_SelectFile").aFilterString.value = "모든 파일 (*.*)$*.*$서명 파일 (*.xws)$*.xws$전자봉투 파일 (*.xwe)$*.xwe$";
	
	// ClearTempFile
	document.getElementById ("form_ClearTempFile").aXgateAddress.value = AnySign.mXgateAddress;
}

var aSignFileExt = ".xws";
var aEnvelopeFileExt = ".xwe";
var aZipFileExt = ".zip";
var aTmpFileExt = ".tmp";

var g_input;
var g_output;
var g_ext;
var g_option;

// output_element = input_element + ext
function onSelectOpenFile(option, input_element, output_element, ext) {
	g_input = input_element;
	g_output = output_element;
	g_ext = ext;
	g_option = option;
	
	AnySign.SelectFile("", "", option, onSelectOpenFileCallback);
}

function onSelectOpenFileCallback(result) {
	if (result != "") {
		g_input.value = result;
		
		if (g_option == 0 && g_output != undefined && g_ext != undefined) {
			g_output.value = result + g_ext;
		}
	}
}

//output_element = input_element - ext
function onSelectOpenFile2(option, input_element, output_element, ext) {	
	g_input = input_element;
	g_output = output_element;
	g_ext = ext;
	g_option = option;
	
	AnySign.SelectFile("", "", option, onSelectOpenFile2Callback);
}

function onSelectOpenFile2Callback(result) {
	if (result != "") {
		g_input.value = result;
		
		if (g_option == 0 && g_output != undefined && g_ext != undefined) {
			
			if (result.substr(result.length - g_ext.length, g_ext.length) == g_ext) {
				g_output.value = result.substr(0, result.length - g_ext.length);
			} else {
				g_output.value = result + aTmpFileExt;
			}
		}
	}
}

//output_element = dir path
function onSelectOpenFile3(option, input_element, output_element) {
	g_input = input_element;
	g_output = output_element;
	g_option = option;
	
	AnySign.SelectFile("", "", option, onSelectOpenFile3Callback);
}

function onSelectOpenFile3Callback(result) {
	var aIndex = -1;
	if (result != "") {
		g_input.value = result;
		
		if (g_option == 0 && g_output != undefined) {
			
			aIndex = result.lastIndexOf ("\\");
			if (aIndex >= 0) {
				g_output.value = result.substring(0, aIndex + 1);
			}
		}
	}
}

function onSelectSaveFile(element, option) {
	g_input = element;
	g_option = option;
	
	AnySign.SelectFile("", "", option, onSelectSaveFileCallback);
}

function onSelectSaveFileCallback(result) {
	if (result != "") {
		g_input.value = result;
		
		if (g_option == 0 && g_output != undefined && g_ext != undefined) {
			g_output.value = result + g_ext;
		}
	}
}

function SignFileEx_Callback (aResult) {
	document.getElementById ("form_SignFileEx").aResult.value = aResult.replace(/\|/g, '\r\n');
}

function SignFileEx_ErrCallback (aResult) {
	var aResultString = "ErrCode [" + aResult.code + "] ErrMsg [" +aResult.msg+"]";
	alert(aResultString);
	document.getElementById ("form_SignFileEx").aResult.value = aResultString;
}

function SignFileExWithCacheCert_Callback (aResult) {
	alert("ok");
	document.getElementById ("form_SignFileEx").aResult.value = aResult.replace(/\|/g, '\r\n');
}

function SignFileExWithCacheCert_ErrCallback (aResult) {
	var aResultString = "ErrCode [" + aResult.code + "] ErrMsg [" +aResult.msg+"]";
	alert(aResultString);
	document.getElementById ("form_SignFileEx").aResult.value = aResultString;
}

function ClearCachedData_callback (aResult)
{
	alert(aResult);
}

function SignFileExWithSerial_Callback (aResult) {
	document.getElementById ("form_SignFileExWithSerial").aResult.value = aResult.replace(/\|/g, '\r\n');
}

function SignFileExWithSerial_ErrCallback (aResult) {
	var aResultString = "ErrCode [" + aResult.code + "] ErrMsg [" +aResult.msg+"]";
	alert(aResultString);
	document.getElementById ("form_SignFileExWithSerial").aResult.value = aResultString;
}

function SignFileExWithVID_Callback (aResult) {
	document.getElementById ("form_SignFileExWithVID").aResult.value = aResult.replace(/\|/g, '\r\n');
	AnySign.GetVidInfo(SignFileExWithVID_UserCallback);
}

function SignFileExWithVID_UserCallback (aResult) {
	document.getElementById ("form_SignFileExWithVID").aVidMsg.value = aResult;
}

function SignFileExWithVID_ErrCallback (aResult) {
	var aResultString = "ErrCode [" + aResult.code + "] ErrMsg [" +aResult.msg+"]";
	alert(aResultString);
	document.getElementById ("form_SignFileExWithVID").aResult.value = aResultString;
}

function SignFileExWithVID_CacheCert_Callback (aResult)
{
	alert("ok");
	document.getElementById ("form_SignFileExWithVID").aResult.value = aResult.replace(/\|/g, '\r\n');
	AnySign.GetVidInfo(SignFileExWithVID_CacheCert_UserCallback);
}

function SignFileExWithVID_CacheCert_UserCallback (aResult)
{
	document.getElementById ("form_SignFileExWithVID").aVidMsg.value = aResult;
}

function SignFileExWithVID_CacheCert_ErrCallback (aResult) {
	var aResultString = "ErrCode [" + aResult.code + "] ErrMsg [" +aResult.msg+"]";
	alert(aResultString);
	document.getElementById ("form_SignFileExWithVID").aResult.value = aResultString;
}

function SignFileExWithVID_Serial_Callback (aResult) {
	document.getElementById ("form_SignFileExWithVID_Serial").aResult.value = aResult.replace(/\|/g, '\r\n');
	AnySign.GetVidInfo(SignFileExWithVID_Serial_UserCallback);
}

function SignFileExWithVID_Serial_UserCallback (aResult) {
	document.getElementById ("form_SignFileExWithVID_Serial").aVidMsg.value = aResult;
}

function SignFileExWithVID_Serial_ErrCallback (aResult) {
	var aResultString = "ErrCode [" + aResult.code + "] ErrMsg [" +aResult.msg+"]";
	alert(aResultString);
	document.getElementById ("form_SignFileExWithVID_Serial").aResult.value = aResultString;
}

function VerifyFile_Callback (aResult) {
	var aFileInfo;
	var aResultString;
	
	aFileInfo = aResult.split("|");	
	
	if (aFileInfo.length == 5) {
		aResultString = "파일 검증 결과: " + aFileInfo[0] + (aFileInfo[0] == 1 ? " (성공)" : " (실패)") + "\r\n" +
		"인증서 검증 결과: " + aFileInfo[1] + (aFileInfo[1] == 1 ? " (성공)" : " (실패)") + "\r\n" +
		"파일명: " + aFileInfo[2] + "\r\n" +
		"파일 크기: " + aFileInfo[3] + " byte" + "\r\n" +
		"파일 수정 시간: " + aFileInfo[4];
	} else {
		aResultString = aResult; 
	}
	
	document.getElementById ("form_VerifyFile").aResult.value = aResultString;
}

function VerifyFile_ErrCallback (aResult) {
	var aResultString = "ErrCode [" + aResult.code + "] ErrMsg [" +aResult.msg+"]";
	alert (aResultString);
	document.getElementById ("form_VerifyFile").aResult.value = aResultString;
}

function VerifyAndSignFile_Callback (aResult) {
	document.getElementById ("form_VerifyAndSignFile").aResult.value = aResult;
}

function VerifyAndSignFile_ErrCallback (aResult) {	
	var aResultString = "ErrCode [" + aResult.code + "] ErrMsg [" +aResult.msg+"]";
	alert (aResultString);
	document.getElementById ("form_VerifyAndSignFile").aResult.value = aResultString;
}

function GetVerifiedFileCertInfo_Callback (aResult) {
	document.getElementById ("form_GetVerifiedFileCertInfo").aResult.value = aResult;
}

function GetVerifiedFileCertInfo_ErrCallback (aResult) {	
	var aResultString = "ErrCode [" + aResult.code + "] ErrMsg [" +aResult.msg+"]";
	alert (aResultString);
	document.getElementById ("form_GetVerifiedFileCertInfo").aResult.value = aResultString;
}

function ExtractFile_Callback (aResult) {
	document.getElementById ("form_ExtractFile").aResult.value = aResult;
}

function ExtractFile_ErrCallback (aResult) {
	var aResultString = "ErrCode [" + aResult.code + "] ErrMsg [" +aResult.msg+"]";
	alert (aResultString);
	document.getElementById ("form_ExtractFile").aResult.value = aResultString;
}

function EnvelopeFileWithPEM_Callback (aResult) {
	document.getElementById ("form_EnvelopeFileWithPEM").aResult.value = aResult.replace(/\|/g, '\r\n');
}

function EnvelopeFileWithPEM_ErrCallback (aResult) {
	var aResultString = "ErrCode [" + aResult.code + "] ErrMsg [" +aResult.msg+"]";
	alert (aResultString);
	document.getElementById ("form_EnvelopeFileWithPEM").aResult.value = aResultString;
}

function EnvelopeFileWithCert_Callback (aResult) {
	document.getElementById ("form_EnvelopeFileWithCert").aResult.value = aResult.replace(/\|/g, '\r\n');
}

function EnvelopeFileWithCert_ErrCallback (aResult) {
	var aResultString = "ErrCode [" + aResult.code + "] ErrMsg [" +aResult.msg+"]";
	alert (aResultString);
	document.getElementById ("form_EnvelopeFileWithCert").aResult.value = aResultString;
}

function EnvelopeFileWithCert_Serial_Callback (aResult) {
	document.getElementById ("form_EnvelopeFileWithCert_Serial").aResult.value = aResult.replace(/\|/g, '\r\n');
}

function EnvelopeFileWithCert_Serial_ErrCallback (aResult) {
	var aResultString = "ErrCode [" + aResult.code + "] ErrMsg [" +aResult.msg+"]";
	alert (aResultString);
	document.getElementById ("form_EnvelopeFileWithCert_Serial").aResult.value = aResultString;
}

function DeEnvelopeFileWithCert_Callback (aResult) {
	document.getElementById ("form_DeEnvelopeFileWithCert").aResult.value = aResult.replace(/\|/g, '\r\n');
}

function DeEnvelopeFileWithCert_ErrCallback (aResult) {
	var aResultString = "ErrCode [" + aResult.code + "] ErrMsg [" +aResult.msg+"]";
	alert (aResultString);
	document.getElementById ("form_DeEnvelopeFileWithCert").aResult.value = aResultString;
}

function DeEnvelopeFileWithCert_Serial_Callback (aResult) {
	document.getElementById ("form_DeEnvelopeFileWithCert_Serial").aResult.value = aResult.replace(/\|/g, '\r\n');
}

function DeEnvelopeFileWithCert_Serial_ErrCallback (aResult) {
	var aResultString = "ErrCode [" + aResult.code + "] ErrMsg [" +aResult.msg+"]";
	alert (aResultString);
	document.getElementById ("form_DeEnvelopeFileWithCert_Serial").aResult.value = aResultString;
}

function EnvelopeFileWithPasswd_Callback (aResult) {
	document.getElementById ("form_EnvelopeFileWithPasswd").aResult.value = aResult.replace(/\|/g, '\r\n');
}

function EnvelopeFileWithPasswd_ErrCallback (aResult) {
	var aResultString = "ErrCode [" + aResult.code + "] ErrMsg [" +aResult.msg+"]";
	alert (aResultString);
	document.getElementById ("form_EnvelopeFileWithPasswd").aResult.value = aResultString;
}

function DeEnvelopeFileWithPasswd_Callback (aResult) {
	document.getElementById ("form_DeEnvelopeFileWithPasswd").aResult.value = aResult.replace(/\|/g, '\r\n');
}

function DeEnvelopeFileWithPasswd_ErrCallback (aResult) {
	var aResultString = "ErrCode [" + aResult.code + "] ErrMsg [" +aResult.msg+"]";
	alert (aResultString);
	document.getElementById ("form_DeEnvelopeFileWithPasswd").aResult.value = aResultString;
}

function GetEnvelopedFileInfo_Callback (aResult) {
	document.getElementById ("form_GetEnvelopedFileInfo").aResult.value = aResult;
}

function GetEnvelopedFileInfo_ErrCallback (aResult) {	
	var aResultString = "ErrCode [" + aResult.code + "] ErrMsg [" +aResult.msg+"]";
	document.getElementById ("form_GetEnvelopedFileInfo").aResult.value = aResultString;
	alert ("전자봉투 암호화 정보 추출에 실패하였습니다.");
}

function UploadFile_Callback (aResult) {
	document.getElementById ("form_UploadFile").aResult.value = aResult.replace(/\|/g, '\r\n');
}

function UploadFile_ErrCallback (aResult) {
	var aResultString = "ErrCode [" + aResult.code + "] ErrMsg [" +aResult.msg+"]";
	alert (aResultString);
	document.getElementById ("form_UploadFile").aResult.value = aResultString;
}

function DownloadFile_Callback (aResult) {
	document.getElementById ("form_DownloadFile").aResult.value = aResult.replace(/\|/g, '\r\n');
}

function DownloadFile_ErrCallback (aResult) {	
	var aResultString = "ErrCode [" + aResult.code + "] ErrMsg [" +aResult.msg+"]";
	alert (aResultString);
	document.getElementById ("form_DownloadFile").aResult.value = aResultString;
}

function ZipFile_Callback (aResult) {
	document.getElementById ("form_ZipFile").aResult.value = aResult.replace(/\|/g, '\r\n');
}

function ZipFile_ErrCallback (aResult) {	
	var aResultString = "ErrCode [" + aResult.code + "] ErrMsg [" +aResult.msg+"]";
	alert (aResultString);
	document.getElementById ("form_ZipFile").aResult.value = aResultString;
}

function UnZipFile_Callback (aResult) {
	document.getElementById ("form_UnZipFile").aResult.value = aResult.replace(/\|/g, '\r\n');
}

function UnZipFile_ErrCallback (aResult) {	
	var aResultString = "ErrCode [" + aResult.code + "] ErrMsg [" +aResult.msg+"]";
	alert (aResultString);
	document.getElementById ("form_UnZipFile").aResult.value = aResultString;
}

function SelectFile_Callback (aResult) {
	document.getElementById ("form_SelectFile").aResult.value = aResult;
}

function SelectFile_ErrCallback (aResult) {	
	var aResultString = "ErrCode [" + aResult.code + "] ErrMsg [" +aResult.msg+"]";
	alert (aResultString);
	document.getElementById ("form_SelectFile").aResult.value = aResultString;
}

function GetFileInfo_Callback (aResult) {
	document.getElementById ("form_GetFileInfo").aResult.value = aResult;
}

function GetFileInfo_ErrCallback (aResult) {	
	var aResultString = "ErrCode [" + aResult.code + "] ErrMsg [" +aResult.msg+"]";
	alert (aResultString);
	document.getElementById ("form_GetFileInfo").aResult.value = aResultString;
}

function ClearTempFile_Callback (aResult) {
	document.getElementById ("form_ClearTempFile").aResult.value = aResult;
}

function ClearTempFile_ErrCallback (aResult) {	
	var aResultString = "ErrCode [" + aResult.code + "] ErrMsg [" +aResult.msg+"]";
	alert (aResultString);
	document.getElementById ("form_ClearTempFile").aResult.value = aResultString;
}

function GetHomeDir_Callback (aResult) {
	document.getElementById ("form_GetHomeDir").aResult.value = aResult;
}

function GetHomeDir_ErrCallback (aResult) {	
	var aResultString = "ErrCode [" + aResult.code + "] ErrMsg [" +aResult.msg+"]";
	alert (aResultString);
	document.getElementById ("form_GetHomeDir").aResult.value = aResultString;
}
</script>
</head>
<body onload="init();" leftmargin="0" topmargin="0" style="padding-top:0px; padding-left:0px;">
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
										<br>
										
										<h3 id="1">SignFileEx</h3>
										<form id="form_SignFileEx" name="form_SignFileEx" method="post" action="#">
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
												<td>aLimitPassword</td>
												<td><input type="text" class="inputtext" name="aLimitPassword"/></td>
											</tr>
											<tr>
												<td>aInputFilePath</td>
												<td style="text-align:left;">
													<input type="checkbox" class="inputcheck" name="aFileSelectOption" value="0" checked disabled="true"/>
													0 : 단일 파일 선택<br/>
													<input type="checkbox" class="inputcheck" name="aFileSelectOption" value="2" onClick="disableInput (this.checked, this.form.aOutputFilePath)"/>
													2 : 복수 파일 선택 (Ctrl + Click)<br/>
													<input type="button" class="inputbutton" style="height:auto;" value="SelectFile"
													onClick="onSelectOpenFile (sumCheckbox (this.form.aFileSelectOption), this.form.aInputFilePath, this.form.aOutputFilePath, aSignFileExt);"/>
													<input type="text" class="inputtext" name="aInputFilePath"/>
												</td>
											</tr>
											<tr>
												<td>aOutputFilePath</td>
												<td style="text-align:left;"><input type="text" class="inputtext" name="aOutputFilePath"/></td>
											</tr>
											<tr>
												<td>aSignOption</td>
												<td style="text-align:left;">
													<strong>(서명 옵션)</strong></br>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="0" checked disabled="true"/>
													0x00000000 : 기본 서명<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="1"/>
													0x00000001 : 서명에 Cert Chain을 포함한다.<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="2"/>
													0x00000002 : 서명에 CRL을 포함한다.<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="32"/>
													0x00000020 : 다른 인증서로 추가 서명을 진행한다.<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="64"/>
													0x00000040 : 분리서명 (서명 파일을 생성하지 않고, 서명값을 리턴합니다)<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="128"/>
													0x00000080 : 분리서명 결과값 Base64 (기본값 Hex)<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="4096"/>
													0x00001000 : 인증서 캐쉬<br/>
													<strong>(공통 옵션)</strong></br>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="65536" checked />
													0x00010000 : 저장할 파일 선택창을 출력하지 않는다.<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="131072"/>
													0x00020000 : 저장할 파일을 임시 폴더에 저장한다.<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="262144"/>
													0x00040000 : 동일한 이름의 저장 파일이 있는 경우 오류 처리한다.(기본값은 덮어쓴다)<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="524288"/>
													0x00080000 : 진행창을 보이지 않는다.<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="1048576"/>
													0x00100000 : 성공 시 진행창을 닫는다.(오류 시는 닫지 않는다)<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="2097152"/>
													0x00200000 : 완료 시 진행창을 닫는다.(오류가 발생해도 닫는다)<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="4194304"/>
													0x00400000 : 오류 시 다음 파일 계속 진행한다.(기본값은 종료한다)<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="8388608"/>
													0x00800000 : 오류 시 다음 파일 계속 진행할지 확인창을 띄운다.<br/>
													<!--<input type="checkbox" class="inputcheck" name="aSignOption" value="16777216"/>
													0x01000000 : 오류 시 이전에 성공한 모든 파일을 삭제한다.<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="33554432"/>
													0x02000000 : 취소 시 이전에 성공한 모든 파일을 삭제한다.<br/>-->
												</td>
											</tr>
											<tr>
												<td>aDescription</td>
												<td style="text-align:left;"><input type="text" class="inputtext" name="aDescription"/></td>
											</tr>
											<tr>
												<td>Run</td>
												<td colspan="2">
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.SignFileEx"
													onClick="AnySign.SignFileEx (this.form.aXgateAddress.value,
																				 this.form.aCAList.value,
																				 this.form.aLimitPassword.value,
																				 this.form.aInputFilePath.value,
																				 this.form.aOutputFilePath.value,
																				 sumCheckbox (this.form.aSignOption),
																				 this.form.aDescription.value,
																				 SignFileEx_Callback,
																				 SignFileEx_ErrCallback);"/>
													<!--
													<br/>
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.SignFileExWithCacheCert"
													onClick="AnySign.SignFileExWithCacheCert (this.form.aXgateAddress.value,
																							  this.form.aInputFilePath.value,
																							  this.form.aOutputFilePath.value,
																							  sumCheckbox (this.form.aSignOption),
																							  this.form.aDescription.value,
																							  SignFileExWithCacheCert_Callback,
																							  SignFileExWithCacheCert_ErrCallback);"/>
													<br/>
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.ClearCachedData"
													onClick="AnySign.ClearCachedData (this.form.aXgateAddress.value,
																					  0,
																					  ClearCachedData_callback);
																					  this.form.aResult.value='';"/>
													-->
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.SignFileExWithCacheCert2"
													onClick="AnySign.SignFileExWithCacheCert2 (this.form.aXgateAddress.value,
																							   this.form.aInputFilePath.value,
																							   this.form.aOutputFilePath.value,
																							   sumCheckbox (this.form.aSignOption),
																							   this.form.aDescription.value,
																							   SignFileExWithCacheCert_Callback,
																							   SignFileExWithCacheCert_ErrCallback);"/>
													<br/>
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.ClearCacheCert2"
													onClick="AnySign.ClearCacheCert2 (function(aResult){alert(aResult);});"/>
												</td>
											</tr>
											<tr>
												<td>Output</td>
												<td colspan="2"  style="text-align:left;">
													<textarea class="inputtextarea" name="aResult" rows="7"></textarea>
												</td>
											</tr>
										</table>
										</form>
										<br/>
										
										<h3 id="2">SignFileExWithSerial</h3>
										<form id="form_SignFileExWithSerial" name="form_SignFileExWithSerial" method="post" action="#">
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
												<td>aCertSerial</td>
												<td><input type="text" class="inputtext" name="aCertSerial"/></td>
											</tr>
											<tr>
												<td>aCertLocation</td>
												<td><input type="text" class="inputtext" name="aCertLocation"/></td>
											</tr>
											<tr>
												<td>aLimitPassword</td>
												<td><input type="text" class="inputtext" name="aLimitPassword"/></td>
											</tr>
											<tr>
												<td>aInputFilePath</td>
												<td style="text-align:left;">
													<input type="checkbox" class="inputcheck" name="aFileSelectOption" value="0" checked disabled="true"/>
													0 : 단일 파일 선택<br/>
													<input type="checkbox" class="inputcheck" name="aFileSelectOption" value="2" onClick="disableInput (this.checked, this.form.aOutputFilePath)"/>
													2 : 복수 파일 선택 (Ctrl + Click)<br/>
													<input type="button" class="inputbutton" style="height:auto;" value="SelectFile"
													onClick="onSelectOpenFile (sumCheckbox (this.form.aFileSelectOption), this.form.aInputFilePath, this.form.aOutputFilePath, aSignFileExt);"/>
													<input type="text" class="inputtext" name="aInputFilePath"/>
												</td>
											</tr>
											<tr>
												<td>aOutputFilePath</td>
												<td style="text-align:left;"><input type="text" class="inputtext" name="aOutputFilePath"/></td>
											</tr>
											<tr>
												<td>aSignOption</td>
												<td style="text-align:left;">
													<strong>(서명 옵션)</strong></br>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="0" checked disabled="true"/>
													0x00000000 : 기본 서명<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="1"/>
													0x00000001 : 서명에 Cert Chain을 포함한다.<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="2"/>
													0x00000002 : 서명에 CRL을 포함한다.<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="32"/>
													0x00000020 : 다른 인증서로 추가 서명을 진행한다.<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="64"/>
													0x00000040 : 분리서명 (서명 파일을 생성하지 않고, 서명값을 리턴합니다)<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="128"/>
													0x00000080 : 분리서명 결과값 Base64 (기본값 Hex)<br/>
													<strong>(공통 옵션)</strong></br>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="65536" checked />
													0x00010000 : 저장할 파일 선택창을 출력하지 않는다.<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="131072"/>
													0x00020000 : 저장할 파일을 임시 폴더에 저장한다.<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="262144"/>
													0x00040000 : 동일한 이름의 저장 파일이 있는 경우 오류 처리한다.(기본값은 덮어쓴다)<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="524288"/>
													0x00080000 : 진행창을 보이지 않는다.<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="1048576"/>
													0x00100000 : 성공 시 진행창을 닫는다.(오류 시는 닫지 않는다)<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="2097152"/>
													0x00200000 : 완료 시 진행창을 닫는다.(오류가 발생해도 닫는다)<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="4194304"/>
													0x00400000 : 오류 시 다음 파일 계속 진행한다.(기본값은 종료한다)<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="8388608"/>
													0x00800000 : 오류 시 다음 파일 계속 진행할지 확인창을 띄운다.<br/>
													<!--<input type="checkbox" class="inputcheck" name="aSignOption" value="16777216"/>
													0x01000000 : 오류 시 이전에 성공한 모든 파일을 삭제한다.<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="33554432"/>
													0x02000000 : 취소 시 이전에 성공한 모든 파일을 삭제한다.<br/>-->
												</td>
											</tr>
											<tr>
												<td>aDescription</td>
												<td style="text-align:left;"><input type="text" class="inputtext" name="aDescription"/></td>
											</tr>
											<tr>
												<td>Run</td>
												<td colspan="2">
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.SignFileExWithSerial"
													onClick="AnySign.SignFileExWithSerial (this.form.aXgateAddress.value,
																						   this.form.aCAList.value,
																						   this.form.aCertSerial.value,
																						   this.form.aCertLocation.value,
																						   this.form.aLimitPassword.value,
																						   this.form.aInputFilePath.value,
																						   this.form.aOutputFilePath.value,
																						   sumCheckbox (this.form.aSignOption),
																						   this.form.aDescription.value,
																						   SignFileExWithSerial_Callback,
																						   SignFileExWithSerial_ErrCallback);"/>
												</td>
											</tr>
											<tr>
												<td>Output</td>
												<td colspan="2"  style="text-align:left;">
													<textarea class="inputtextarea" name="aResult" rows="7"></textarea>
												</td>
											</tr>
										</table>
										</form>
										<br/>
										
										<h3 id="3">SignFileExWithVID</h3>
										<form id="form_SignFileExWithVID" name="form_SignFileExWithVID" method="post" action="#">
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
												<td>aLimitPassword</td>
												<td><input type="text" class="inputtext" name="aLimitPassword"/></td>
											</tr>
											<tr>
												<td>aInputFilePath</td>
												<td style="text-align:left;">
													<input type="checkbox" class="inputcheck" name="aFileSelectOption" value="0" checked disabled="true"/>
													0 : 단일 파일 선택<br/>
													<input type="checkbox" class="inputcheck" name="aFileSelectOption" value="2" onClick="disableInput (this.checked, this.form.aOutputFilePath)"/>
													2 : 복수 파일 선택 (Ctrl + Click)<br/>
													<input type="button" class="inputbutton" style="height:auto;" value="SelectFile"
													onClick="onSelectOpenFile (sumCheckbox (this.form.aFileSelectOption), this.form.aInputFilePath, this.form.aOutputFilePath, aSignFileExt);"/>
													<input type="text" class="inputtext" name="aInputFilePath"/>
												</td>
											</tr>
											<tr>
												<td>aOutputFilePath</td>
												<td style="text-align:left;"><input type="text" class="inputtext" name="aOutputFilePath"/></td>
											</tr>
											<tr>
												<td>aSignOption</td>
												<td style="text-align:left;">
													<strong>(서명 옵션)</strong></br>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="0" checked disabled="true"/>
													0x00000000 : 기본 서명<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="1"/>
													0x00000001 : 서명에 Cert Chain을 포함한다.<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="2"/>
													0x00000002 : 서명에 CRL을 포함한다.<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="32"/>
													0x00000020 : 다른 인증서로 추가 서명을 진행한다.<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="64"/>
													0x00000040 : 분리서명 (서명 파일을 생성하지 않고, 서명값을 리턴합니다)<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="128"/>
													0x00000080 : 분리서명 결과값 Base64 (기본값 Hex)<br/>
													<strong>(VID 옵션)</strong></br>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="8"/>
													0x00000008 : WEB 으로 부터 직접 입력받는다.<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="16"/>
													0x00000010 : IDN값을 입력받지 않는다. (""로 대체)<br/>
													<strong>(공통 옵션)</strong></br>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="65536" checked />
													0x00010000 : 저장할 파일 선택창을 출력하지 않는다.<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="131072"/>
													0x00020000 : 저장할 파일을 임시 폴더에 저장한다.<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="262144"/>
													0x00040000 : 동일한 이름의 저장 파일이 있는 경우 오류 처리한다.(기본값은 덮어쓴다)<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="524288"/>
													0x00080000 : 진행창을 보이지 않는다.<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="1048576"/>
													0x00100000 : 성공 시 진행창을 닫는다.(오류 시는 닫지 않는다)<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="2097152"/>
													0x00200000 : 완료 시 진행창을 닫는다.(오류가 발생해도 닫는다)<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="4194304"/>
													0x00400000 : 오류 시 다음 파일 계속 진행한다.(기본값은 종료한다)<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="8388608"/>
													0x00800000 : 오류 시 다음 파일 계속 진행할지 확인창을 띄운다.<br/>
													<!--<input type="checkbox" class="inputcheck" name="aSignOption" value="16777216"/>
													0x01000000 : 오류 시 이전에 성공한 모든 파일을 삭제한다.<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="33554432"/>
													0x02000000 : 취소 시 이전에 성공한 모든 파일을 삭제한다.<br/>-->
												</td>
											</tr>
											<tr>
												<td>aIdn</td>
												<td style="text-align:left;"><input type="text" class="inputtext" name="aIdn"/></td>
											</tr>
											<tr>
												<td>aDescription</td>
												<td style="text-align:left;"><input type="text" class="inputtext" name="aDescription"/></td>
											</tr>
											<tr>
												<td>Run</td>
												<td colspan="2">
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.SignFileExWithVID"
													onClick="AnySign.SignFileExWithVID (this.form.aXgateAddress.value,
																						this.form.aCAList.value,
																						this.form.aLimitPassword.value,
																						this.form.aInputFilePath.value,
																						this.form.aOutputFilePath.value,
																						this.form.aIdn.value,
																						s,
																						sumCheckbox (this.form.aSignOption),
																						this.form.aDescription.value,
																						SignFileExWithVID_Callback,
																						SignFileExWithVID_ErrCallback);"/>
													<!--
													<br/>
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.SignFileExWithVID_CacheCert"
													onClick="AnySign.SignFileExWithVID_CacheCert (this.form.aXgateAddress.value,
																								  this.form.aInputFilePath.value,
																								  this.form.aOutputFilePath.value,
																								  this.form.aIdn.value, 
																								  s,
																								  sumCheckbox (this.form.aSignOption),
																								  this.form.aDescription.value,
																								  SignFileExWithVID_CacheCert_Callback,
																								  SignFileExWithVID_CacheCert_ErrCallback);"/>
													<br/>
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.ClearCachedData"
													onClick="AnySign.ClearCachedData (this.form.aXgateAddress.value,
																					  0,
																					  ClearCachedData_callback);
																					  this.form.aResult.value='';this.form.aVidMsg.value='';"/>
													-->
												</td>
											</tr>
											<tr>
												<td>Output</td>
												<td colspan="2"  style="text-align:left;">
													<textarea class="inputtextarea" name="aResult" rows="7"></textarea>
												</td>
											</tr>
											<tr>
												<td>VID Output</td>
												<td colspan="2">
													<textarea class="inputtextarea" name="aVidMsg" rows="7"></textarea>
												</td>
											</tr>
										</table>
										</form>
										<br/>
										
										<h3 id="4">SignFileExWithVID_Serial</h3>
										<form id="form_SignFileExWithVID_Serial" name="form_SignFileExWithVID_Serial" method="post" action="#">
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
												<td>aCertSerial</td>
												<td><input type="text" class="inputtext" name="aCertSerial"/></td>
											</tr>
											<tr>
												<td>aCertLocation</td>
												<td><input type="text" class="inputtext" name="aCertLocation"/></td>
											</tr>
											<tr>
												<td>aLimitPassword</td>
												<td><input type="text" class="inputtext" name="aLimitPassword"/></td>
											</tr>
											<tr>
												<td>aInputFilePath</td>
												<td style="text-align:left;">
													<input type="checkbox" class="inputcheck" name="aFileSelectOption" value="0" checked disabled="true"/>
													0 : 단일 파일 선택<br/>
													<input type="checkbox" class="inputcheck" name="aFileSelectOption" value="2" onClick="disableInput (this.checked, this.form.aOutputFilePath)"/>
													2 : 복수 파일 선택 (Ctrl + Click)<br/>
													<input type="button" class="inputbutton" style="height:auto;" value="SelectFile"
													onClick="onSelectOpenFile (sumCheckbox (this.form.aFileSelectOption), this.form.aInputFilePath, this.form.aOutputFilePath, aSignFileExt);"/>
													<input type="text" class="inputtext" name="aInputFilePath"/>
												</td>
											</tr>
											<tr>
												<td>aOutputFilePath</td>
												<td style="text-align:left;"><input type="text" class="inputtext" name="aOutputFilePath"/></td>
											</tr>
											<tr>
												<td>aSignOption</td>
												<td style="text-align:left;">
													<strong>(서명 옵션)</strong></br>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="0" checked disabled="true"/>
													0x00000000 : 기본 서명<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="1"/>
													0x00000001 : 서명에 Cert Chain을 포함한다.<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="2"/>
													0x00000002 : 서명에 CRL을 포함한다.<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="32"/>
													0x00000020 : 다른 인증서로 추가 서명을 진행한다.<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="64"/>
													0x00000040 : 분리서명 (서명 파일을 생성하지 않고, 서명값을 리턴합니다)<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="128"/>
													0x00000080 : 분리서명 결과값 Base64 (기본값 Hex)<br/>
													<strong>(VID 옵션)</strong></br>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="8"/>
													0x00000008 : WEB 으로 부터 직접 입력받는다.<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="16"/>
													0x00000010 : IDN값을 입력받지 않는다. (""로 대체)<br/>
													<strong>(공통 옵션)</strong></br>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="65536" checked />
													0x00010000 : 저장할 파일 선택창을 출력하지 않는다.<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="131072"/>
													0x00020000 : 저장할 파일을 임시 폴더에 저장한다.<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="262144"/>
													0x00040000 : 동일한 이름의 저장 파일이 있는 경우 오류 처리한다.(기본값은 덮어쓴다)<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="524288"/>
													0x00080000 : 진행창을 보이지 않는다.<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="1048576"/>
													0x00100000 : 성공 시 진행창을 닫는다.(오류 시는 닫지 않는다)<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="2097152"/>
													0x00200000 : 완료 시 진행창을 닫는다.(오류가 발생해도 닫는다)<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="4194304"/>
													0x00400000 : 오류 시 다음 파일 계속 진행한다.(기본값은 종료한다)<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="8388608"/>
													0x00800000 : 오류 시 다음 파일 계속 진행할지 확인창을 띄운다.<br/>
													<!--<input type="checkbox" class="inputcheck" name="aSignOption" value="16777216"/>
													0x01000000 : 오류 시 이전에 성공한 모든 파일을 삭제한다.<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="33554432"/>
													0x02000000 : 취소 시 이전에 성공한 모든 파일을 삭제한다.<br/>-->
												</td>
											</tr>
											<tr>
												<td>aIdn</td>
												<td style="text-align:left;"><input type="text" class="inputtext" name="aIdn"/></td>
											</tr>
											<tr>
												<td>aDescription</td>
												<td style="text-align:left;"><input type="text" class="inputtext" name="aDescription"/></td>
											</tr>
											<tr>
												<td>Run</td>
												<td colspan="2">
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.SignFileExWithVID_Serial"
													onClick="AnySign.SignFileExWithVID_Serial (this.form.aXgateAddress.value,
																							   this.form.aCAList.value,
																							   this.form.aCertSerial.value,
																							   this.form.aCertLocation.value,
																							   this.form.aLimitPassword.value,
																							   this.form.aInputFilePath.value,
																							   this.form.aOutputFilePath.value,
																							   this.form.aIdn.value,
																							   s,
																							   sumCheckbox (this.form.aSignOption),
																							   this.form.aDescription.value,
																							   SignFileExWithVID_Serial_Callback,
																							   SignFileExWithVID_Serial_ErrCallback);"/>
												</td>
											</tr>
											<tr>
												<td>Output</td>
												<td colspan="2"  style="text-align:left;">
													<textarea class="inputtextarea" name="aResult" rows="7"></textarea>
												</td>
											</tr>
											<tr>
												<td>VID Output</td>
												<td colspan="2">
													<textarea class="inputtextarea" name="aVidMsg" rows="7"></textarea>
												</td>
											</tr>
										</table>
										</form>
										<br/>
										
										<h3 id="5">VerifyFile</h3>
										<form id="form_VerifyFile" name="form_VerifyFile" method="post" action="#">
										<table class="test">
											<tr>
												<td width="50" rowspan="4">Input</td>
												<td width="120">aInputFilePath</td>
												<td width="524">
													<input type="button" class="inputbutton" style="height:auto;" value="SelectFile"
													onClick="onSelectOpenFile (0, this.form.aInputFilePath);"/>
													<input type="text" class="inputtext" name="aInputFilePath"/>
												</td>
											</tr>
											<tr>
												<td>aSignedData</td>
												<td><textarea class="inputtextarea" name="aSignedData" rows="7"></textarea></td>
											</tr>
											<tr>
												<td>aVerifyOption</td>
												<td style="text-align:left;">
													<strong>(검증 옵션)</strong></br>
													<input type="checkbox" class="inputcheck" name="aVerifyOption" value="0" checked disabled="true"/>
													0x00000000 : 기본 검증<br/>
													<input type="checkbox" class="inputcheck" name="aVerifyOption" value="4" checked />
													0x00000004 : 인증서 CRL 검증을 수행한다.<br/>
													<input type="checkbox" class="inputcheck" name="aVerifyOption" value="16"/>
													0x00000010 : 분리서명 검증 (원문 파일과 서명값을 입력한다)<br/>
													<strong>(공통 옵션)</strong></br>
													<input type="checkbox" class="inputcheck" name="aVerifyOption" value="524288"/>
													0x00080000 : 진행창을 보이지 않는다.<br/>
													<input type="checkbox" class="inputcheck" name="aVerifyOption" value="1048576"/>
													0x00100000 : 성공 시 진행창을 닫는다.(오류 시는 닫지 않는다)<br/>
													<input type="checkbox" class="inputcheck" name="aVerifyOption" value="2097152"/>
													0x00200000 : 완료 시 진행창을 닫는다.(오류가 발생해도 닫는다)<br/>
													<input type="checkbox" class="inputcheck" name="aVerifyOption" value="268435456" checked />
													0x10000000 : 진행창 완료 후 검증 확인창을 띄운다.<br/>
													<input type="checkbox" class="inputcheck" name="aVerifyOption" value="536870912"/>
													0x20000000 : 검증 확인창에 추가 서명 버튼을 표시한다.<br/>
												</td>
											</tr>
											<tr>
												<td>aDescription</td>
												<td style="text-align:left;"><input type="text" class="inputtext" name="aDescription"/></td>
											</tr>
											<tr>
												<td>Run</td>
												<td colspan="2">
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.VerifyFile"
													onClick="AnySign.VerifyFile (this.form.aInputFilePath.value,
																				 this.form.aSignedData.value,
																				 sumCheckbox (this.form.aVerifyOption),
																				 this.form.aDescription.value,
																				 VerifyFile_Callback,
																				 VerifyFile_ErrCallback);"/>
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
										
										<h3 id="6">VerifyAndSignFile</h3>
										<form id="form_VerifyAndSignFile" name="form_VerifyAndSignFile" method="post" action="#">
										<table class="test">
											<tr>
												<td width="50" rowspan="12">Input</td>
												<td width="120">aXgateAddress</td>
												<td width="524"><input type="text" class="inputtext" name="aXgateAddress"/></td>
											</tr>
											<tr>
												<td>aCAList</td>
												<td><input type="text" class="inputtext" name="aCAList"/></td>
											</tr>
											<tr>
												<td>aCertSerial</td>
												<td><input type="text" class="inputtext" name="aCertSerial"/></td>
											</tr>
											<tr>
												<td>aCertLocation</td>
												<td><input type="text" class="inputtext" name="aCertLocation"/></td>
											</tr>
											<tr>
												<td>aLimitPassword</td>
												<td><input type="text" class="inputtext" name="aLimitPassword"/></td>
											</tr>
											<tr>
												<td>aInputFilePath</td>
												<td>
													<input type="button" class="inputbutton" style="height:auto;" value="SelectFile"
													onClick="onSelectOpenFile (0, this.form.aInputFilePath, this.form.aOutputFilePath, aSignFileExt);"/>
													<input type="text" class="inputtext" name="aInputFilePath"/>
												</td>
											</tr>
											<tr>
												<td>aOutputFilePath</td>
												<td style="text-align:left;"><input type="text" class="inputtext" name="aOutputFilePath"/></td>
											</tr>
											<tr>
												<td>aSignedData</td>
												<td><textarea class="inputtextarea" name="aSignedData" rows="7"></textarea></td>
											</tr>
											<tr>
												<td>aVerifyOption</td>
												<td style="text-align:left;">
													<strong>(검증 옵션)</strong></br>
													<input type="checkbox" class="inputcheck" name="aVerifyOption" value="0" checked disabled="true"/>
													0x00000000 : 기본 검증<br/>
													<input type="checkbox" class="inputcheck" name="aVerifyOption" value="4" checked />
													0x00000004 : 인증서 CRL 검증을 수행한다.<br/>
													<input type="checkbox" class="inputcheck" name="aVerifyOption" value="16"/>
													0x00000010 : 분리서명 검증 (원문 파일과 서명값을 입력한다)<br/>
													<strong>(공통 옵션)</strong></br>
													<input type="checkbox" class="inputcheck" name="aVerifyOption" value="524288"/>
													0x00080000 : 진행창을 보이지 않는다.<br/>
													<input type="checkbox" class="inputcheck" name="aVerifyOption" value="1048576"/>
													0x00100000 : 성공 시 진행창을 닫는다.(오류 시는 닫지 않는다)<br/>
													<input type="checkbox" class="inputcheck" name="aVerifyOption" value="2097152"/>
													0x00200000 : 완료 시 진행창을 닫는다.(오류가 발생해도 닫는다)<br/>
													<input type="checkbox" class="inputcheck" name="aVerifyOption" value="268435456" checked />
													0x10000000 : 진행창 완료 후 검증 확인창을 띄운다.<br/>
													<!--
													<input type="checkbox" class="inputcheck" name="aVerifyOption" value="536870912" checked disabled="true"/>
													0x20000000 : 검증 확인창에 추가 서명 버튼을 표시한다.<br/>
													-->
												</td>
											</tr>
											<tr>
												<td>aSignOption</td>
												<td style="text-align:left;">
													<strong>(서명 옵션)</strong></br>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="0" checked disabled="true"/>
													0x00000000 : 기본 서명<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="1"/>
													0x00000001 : 서명에 Cert Chain을 포함한다.<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="2"/>
													0x00000002 : 서명에 CRL을 포함한다.<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="4"/>
													0x00000004 : 다른 인증서로 추가 서명을 진행한다.<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="16"/>
													0x00000010 : 분리서명 (서명 파일을 생성하지 않고, 서명값을 리턴합니다)<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="32"/>
													0x00000020 : 분리서명 결과값 Base64 (기본값 Hex)<br/>
													<strong>(공통 옵션)</strong></br>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="65536" checked />
													0x00010000 : 저장할 파일 선택창을 출력하지 않는다.<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="131072"/>
													0x00020000 : 저장할 파일을 임시 폴더에 저장한다.<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="262144"/>
													0x00040000 : 동일한 이름의 저장 파일이 있는 경우 오류 처리한다.(기본값은 덮어쓴다)<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="524288"/>
													0x00080000 : 진행창을 보이지 않는다.<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="1048576"/>
													0x00100000 : 성공 시 진행창을 닫는다.(오류 시는 닫지 않는다)<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="2097152"/>
													0x00200000 : 완료 시 진행창을 닫는다.(오류가 발생해도 닫는다)<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="4194304"/>
													0x00400000 : 오류 시 다음 파일 계속 진행한다.(기본값은 종료한다)<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="8388608"/>
													0x00800000 : 오류 시 다음 파일 계속 진행할지 확인창을 띄운다.<br/>
													<!--<input type="checkbox" class="inputcheck" name="aSignOption" value="16777216"/>
													0x01000000 : 오류 시 이전에 성공한 모든 파일을 삭제한다.<br/>
													<input type="checkbox" class="inputcheck" name="aSignOption" value="33554432"/>
													0x02000000 : 취소 시 이전에 성공한 모든 파일을 삭제한다.<br/>-->
												</td>
											</tr>
											<tr>
												<td>aDescription</td>
												<td style="text-align:left;"><input type="text" class="inputtext" name="aVerifyDescription"/></td>
											</tr>
											<tr>
												<td>aDescription</td>
												<td style="text-align:left;"><input type="text" class="inputtext" name="aSignDescription"/></td>
											</tr>
											<tr>
												<td>Run</td>
												<td colspan="2">
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.VerifyAndSignFile"
													onClick="AnySign.VerifyAndSignFile (this.form.aXgateAddress.value,
																						this.form.aCAList.value,
																						this.form.aCertSerial.value,
																						this.form.aCertLocation.value,
																						this.form.aLimitPassword.value,
																						this.form.aInputFilePath.value,
																						this.form.aOutputFilePath.value,
																						this.form.aSignedData.value,
																						sumCheckbox (this.form.aVerifyOption),
																						sumCheckbox (this.form.aSignOption),
																						this.form.aVerifyDescription.value,
																						this.form.aSignDescription.value,
																						VerifyAndSignFile_Callback,
																						VerifyAndSignFile_ErrCallback);"/>
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
										
										<h3 id="7">GetVerifiedFileCertInfo</h3>
										<form id="form_GetVerifiedFileCertInfo" name="form_GetVerifiedFileCertInfo" method="post" action="#">
										<table class="test">
											<tr>
												<td width="50" rowspan="2">Input</td>
												<td width="120">aOption</td>
												<td width="524" style="text-align:left;">
													<input type="checkbox" class="inputcheck" name="aOption" value="0" checked />
													0 : Full (인증서의 자세한 정보)<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="1"/>
													1 : Simple (서명시간 및 인증서의 간단한 정보)<br/>
												</td>
											</tr>
											<tr>
												<td>aIndex</td>
												<td style="text-align:left;">
													<input type="text" class="inputtext" name="aIndex"/>
													<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr valign="top">
														<td style="text-align:left;">
														* Full<br>
														0 인증서 검증 결과<br>&nbsp&nbsp&nbsp(0 - 정상, 오류코드|오류메세지)<br>
														1 버전<br>
														2 일련번호<br>
														3 서명 알고리즘<br>
														4 발급자<br>
														5 다음부터 유효함<br>
														6 다음까지 유효함<br>
														7 발급대상<br>
														8 공개키 알고리즘<br>
														9 공개키<br>
														10 서명<br>
														11 CA 키 고유번호<br>
														12 인증서 정책<br>
														13 키사용<br>
														14 기본 규제<br>
														15 주체 대체 이름<br>
														16 CRL 분배점<br>
														17 사용자 알림<br>
														18 CPS<br>
														19 기관정보 엑세스<br>
														</td>
														<td style="text-align:left;">
														* Simple<br>
														0 서명 시간<br>
														1 인증서 상태<br>&nbsp&nbsp&nbsp(0 - 정상, 1 - 만료 예정, 2 - 만료 된)<br>
														2 인증서 구분<br>
														3 사용자<br>
														4 발급자 구분<br>
														5 유효기간<br>
														6 발급자<br>
														7 일련번호<br>
														</td>
													</tr>
													</table>
												</td>
											</tr>
											<tr>
												<td>Run</td>
												<td colspan="2">
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.GetVerifiedFileCertInfo"
													onClick="AnySign.GetVerifiedFileCertInfo (sumCheckbox (this.form.aOption),
																							  this.form.aIndex.value,
																							  GetVerifiedFileCertInfo_Callback,
																							  GetVerifiedFileCertInfo_ErrCallback)"/>
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
										
										<h3 id="8">ExtractFile</h3>
										<form id="form_ExtractFile" name="form_ExtractFile" method="post" action="#">
										<table class="test">
											<tr>
												<td width="50" rowspan="4">Input</td>
												<td width="120">aInputFilePath</td>
												<td width="524">
													<input type="button" class="inputbutton" style="height:auto;" value="SelectFile"
													onClick="onSelectOpenFile2 (0, this.form.aInputFilePath, this.form.aOutputFilePath, aSignFileExt);"/>
													<input type="text" class="inputtext" name="aInputFilePath"/>
												</td>
											</tr>
											<tr>
												<td>aOutputFilePath</td>
												<td style="text-align:left;"><input type="text" class="inputtext" name="aOutputFilePath"/></td>
											</tr>
											<tr>
												<td>aOption</td>
												<td style="text-align:left;">
													<input type="checkbox" class="inputcheck" name="aOption" value="0" checked disabled="true"/>
													0x00000000 : 기본 옵션<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="262144"/>
													0x00040000 : 동일한 이름의 저장 파일이 있는 경우 오류 처리한다.(기본값은 덮어쓴다)<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="524288"/>
													0x00080000 : 진행창을 보이지 않는다.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="1048576"/>
													0x00100000 : 성공 시 진행창을 닫는다.(오류 시는 닫지 않는다)<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="2097152"/>
													0x00200000 : 완료 시 진행창을 닫는다.(오류가 발생해도 닫는다)<br/>
												</td>
											</tr>
											<tr>
												<td>aDescription</td>
												<td style="text-align:left;"><input type="text" class="inputtext" name="aDescription"/></td>
											</tr>
											<tr>
												<td>Run</td>
												<td colspan="2">
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.ExtractFile"
													onClick="AnySign.ExtractFile (this.form.aInputFilePath.value,
																				  this.form.aOutputFilePath.value,
																				  sumCheckbox (this.form.aOption),
																				  this.form.aDescription.value,
																				  ExtractFile_Callback,
																				  ExtractFile_ErrCallback)"/>
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
										
										<h3 id="9">EnvelopeFileWithPEM</h3>
										<form id="form_EnvelopeFileWithPEM" name="form_EnvelopeFileWithPEM" method="post" action="#">
										<table class="test">
											<tr>
												<td width="50" rowspan="5">Input</td>
												<td width="120">aInputFilePath</td>
												<td width="524" style="text-align:left;">
													<input type="checkbox" class="inputcheck" name="aFileSelectOption" value="0" checked disabled="true"/>
													0 : 단일 파일 선택<br/>
													<input type="checkbox" class="inputcheck" name="aFileSelectOption" value="2" onClick="disableInput (this.checked, this.form.aOutputFilePath)"/>
													2 : 복수 파일 선택 (Ctrl + Click)<br/>
													<input type="button" class="inputbutton" style="height:auto;" value="SelectFile"
													onClick="onSelectOpenFile (sumCheckbox (this.form.aFileSelectOption), this.form.aInputFilePath, this.form.aOutputFilePath, aEnvelopeFileExt);"/>
													<input type="text" class="inputtext" name="aInputFilePath"/>
												</td>
											</tr>
											<tr>
												<td>aOutputFilePath</td>
												<td style="text-align:left;"><input type="text" class="inputtext" name="aOutputFilePath"/></td>
											</tr>
											<tr>
												<td>aCertPEM</td>
												<td><textarea class="inputtextarea" name="aCertPEM" rows="7"></textarea></td>
											</tr>
											<tr>
												<td>aOption</td>
												<td style="text-align:left;">
													<input type="checkbox" class="inputcheck" name="aOption" value="0" checked disabled="true"/>
													0x00000000 : 기본 옵션<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="65536" checked />
													0x00010000 : 저장할 파일 선택창을 출력하지 않는다.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="131072"/>
													0x00020000 : 저장할 파일을 임시 폴더에 저장한다.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="262144"/>
													0x00040000 : 동일한 이름의 저장 파일이 있는 경우 오류 처리한다.(기본값은 덮어쓴다)<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="524288"/>
													0x00080000 : 진행창을 보이지 않는다.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="1048576"/>
													0x00100000 : 성공 시 진행창을 닫는다.(오류 시는 닫지 않는다)<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="2097152"/>
													0x00200000 : 완료 시 진행창을 닫는다.(오류가 발생해도 닫는다)<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="4194304"/>
													0x00400000 : 오류 시 다음 파일 계속 진행한다.(기본값은 종료한다)<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="8388608"/>
													0x00800000 : 오류 시 다음 파일 계속 진행할지 확인창을 띄운다.<br/>
												</td>
											</tr>
											<tr>
												<td>aDescription</td>
												<td style="text-align:left;"><input type="text" class="inputtext" name="aDescription"/></td>
											</tr>
											<tr>
												<td>Run</td>
												<td colspan="2">
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.EnvelopeFileWithPEM"
													onClick="AnySign.EnvelopeFileWithPEM (this.form.aInputFilePath.value,
																						  this.form.aOutputFilePath.value,
																						  this.form.aCertPEM.value,
																						  sumCheckbox (this.form.aOption),
																						  this.form.aDescription.value,
																						  EnvelopeFileWithPEM_Callback,
																						  EnvelopeFileWithPEM_ErrCallback)"/>
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
										
										<h3 id="10">EnvelopeFileWithCert</h3>
										<form id="form_EnvelopeFileWithCert" name="form_EnvelopeFileWithCert" method="post" action="#">
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
												<td>aInputFilePath</td>
												<td style="text-align:left;">
													<input type="checkbox" class="inputcheck" name="aFileSelectOption" value="0" checked disabled="true"/>
													0 : 단일 파일 선택<br/>
													<input type="checkbox" class="inputcheck" name="aFileSelectOption" value="2" onClick="disableInput (this.checked, this.form.aOutputFilePath)"/>
													2 : 복수 파일 선택 (Ctrl + Click)<br/>
													<input type="button" class="inputbutton" style="height:auto;" value="SelectFile"
													onClick="onSelectOpenFile (sumCheckbox (this.form.aFileSelectOption), this.form.aInputFilePath, this.form.aOutputFilePath, aEnvelopeFileExt);"/>
													<input type="text" class="inputtext" name="aInputFilePath"/>
												</td>
											</tr>
											<tr>
												<td>aOutputFilePath</td>
												<td style="text-align:left;"><input type="text" class="inputtext" name="aOutputFilePath"/></td>
											</tr>
											<tr>
												<td>aOption</td>
												<td style="text-align:left;">
													<input type="checkbox" class="inputcheck" name="aOption" value="0" checked disabled="true"/>
													0x00000000 : 기본 옵션<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="4"/>
													0x00000004 : 여러개의 인증서로 암호화한다.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="65536" checked />
													0x00010000 : 저장할 파일 선택창을 출력하지 않는다.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="131072"/>
													0x00020000 : 저장할 파일을 임시 폴더에 저장한다.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="262144"/>
													0x00040000 : 동일한 이름의 저장 파일이 있는 경우 오류 처리한다.(기본값은 덮어쓴다)<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="524288"/>
													0x00080000 : 진행창을 보이지 않는다.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="1048576"/>
													0x00100000 : 성공 시 진행창을 닫는다.(오류 시는 닫지 않는다)<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="2097152"/>
													0x00200000 : 완료 시 진행창을 닫는다.(오류가 발생해도 닫는다)<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="4194304"/>
													0x00400000 : 오류 시 다음 파일 계속 진행한다.(기본값은 종료한다)<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="8388608"/>
													0x00800000 : 오류 시 다음 파일 계속 진행할지 확인창을 띄운다.<br/>
												</td>
											</tr>
											<tr>
												<td>aDescription</td>
												<td style="text-align:left;"><input type="text" class="inputtext" name="aDescription"/></td>
											</tr>
											<tr>
												<td>Run</td>
												<td colspan="2">
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.EnvelopeFileWithCert"
													onClick="AnySign.EnvelopeFileWithCert (this.form.aXgateAddress.value,
																						   this.form.aCAList.value,
																						   this.form.aInputFilePath.value,
																						   this.form.aOutputFilePath.value,
																						   sumCheckbox (this.form.aOption),
																						   this.form.aDescription.value,
																						   EnvelopeFileWithCert_Callback,
																						   EnvelopeFileWithCert_ErrCallback)"/>
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
										
										<h3 id="11">EnvelopeFileWithCert_Serial</h3>
										<form id="form_EnvelopeFileWithCert_Serial" name="form_EnvelopeFileWithCert_Serial" method="post" action="#">
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
												<td>aCertSerial</td>
												<td><input type="text" class="inputtext" name="aCertSerial"/></td>
											</tr>
											<tr>
												<td>aCertLocation</td>
												<td><input type="text" class="inputtext" name="aCertLocation"/></td>
											</tr>
											<tr>
												<td>aInputFilePath</td>
												<td style="text-align:left;">
													<input type="checkbox" class="inputcheck" name="aFileSelectOption" value="0" checked disabled="true"/>
													0 : 단일 파일 선택<br/>
													<input type="checkbox" class="inputcheck" name="aFileSelectOption" value="2" onClick="disableInput (this.checked, this.form.aOutputFilePath)"/>
													2 : 복수 파일 선택 (Ctrl + Click)<br/>
													<input type="button" class="inputbutton" style="height:auto;" value="SelectFile"
													onClick="onSelectOpenFile (sumCheckbox (this.form.aFileSelectOption), this.form.aInputFilePath, this.form.aOutputFilePath, aEnvelopeFileExt);"/>
													<input type="text" class="inputtext" name="aInputFilePath"/>
												</td>
											</tr>
											<tr>
												<td>aOutputFilePath</td>
												<td style="text-align:left;"><input type="text" class="inputtext" name="aOutputFilePath"/></td>
											</tr>
											<tr>
												<td>aOption</td>
												<td style="text-align:left;">
													<input type="checkbox" class="inputcheck" name="aOption" value="0" checked disabled="true"/>
													0x00000000 : 기본 옵션<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="4"/>
													0x00000004 : 여러개의 인증서로 암호화한다.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="65536" checked />
													0x00010000 : 저장할 파일 선택창을 출력하지 않는다.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="131072"/>
													0x00020000 : 저장할 파일을 임시 폴더에 저장한다.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="262144"/>
													0x00040000 : 동일한 이름의 저장 파일이 있는 경우 오류 처리한다.(기본값은 덮어쓴다)<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="524288"/>
													0x00080000 : 진행창을 보이지 않는다.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="1048576"/>
													0x00100000 : 성공 시 진행창을 닫는다.(오류 시는 닫지 않는다)<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="2097152"/>
													0x00200000 : 완료 시 진행창을 닫는다.(오류가 발생해도 닫는다)<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="4194304"/>
													0x00400000 : 오류 시 다음 파일 계속 진행한다.(기본값은 종료한다)<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="8388608"/>
													0x00800000 : 오류 시 다음 파일 계속 진행할지 확인창을 띄운다.<br/>
												</td>
											</tr>
											<tr>
												<td>aDescription</td>
												<td style="text-align:left;"><input type="text" class="inputtext" name="aDescription"/></td>
											</tr>
											<tr>
												<td>Run</td>
												<td colspan="2">
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.EnvelopeFileWithCert_Serial"
													onClick="AnySign.EnvelopeFileWithCert_Serial (this.form.aXgateAddress.value,
																								  this.form.aCAList.value,
																								  this.form.aCertSerial.value,
																								  this.form.aCertLocation.value,
																								  this.form.aInputFilePath.value,
																								  this.form.aOutputFilePath.value,
																								  sumCheckbox (this.form.aOption),
																								  this.form.aDescription.value,
																								  EnvelopeFileWithCert_Serial_Callback,
																								  EnvelopeFileWithCert_Serial_ErrCallback)"/>
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
										
										<h3 id="12">DeEnvelopeFileWithCert</h3>
										<form id="form_DeEnvelopeFileWithCert" name="form_DeEnvelopeFileWithCert" method="post" action="#">
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
												<td>aLimitPassword</td>
												<td><input type="text" class="inputtext" name="aLimitPassword"/></td>
											</tr>
											<tr>
												<td>aInputFilePath</td>
												<td style="text-align:left;">
													<input type="checkbox" class="inputcheck" name="aFileSelectOption" value="0" checked disabled="true"/>
													0 : 단일 파일 선택<br/>
													<input type="checkbox" class="inputcheck" name="aFileSelectOption" value="2" onClick="disableInput (this.checked, this.form.aOutputFilePath)"/>
													2 : 복수 파일 선택 (Ctrl + Click)<br/>
													<input type="button" class="inputbutton" style="height:auto;" value="SelectFile"
													onClick="onSelectOpenFile2 (sumCheckbox (this.form.aFileSelectOption), this.form.aInputFilePath, this.form.aOutputFilePath, aEnvelopeFileExt);"/>
													<input type="text" class="inputtext" name="aInputFilePath"/>
												</td>
											</tr>
											<tr>
												<td>aOutputFilePath</td>
												<td style="text-align:left;"><input type="text" class="inputtext" name="aOutputFilePath"/></td>
											</tr>
											<tr>
												<td>aOption</td>
												<td style="text-align:left;">
													<input type="checkbox" class="inputcheck" name="aOption" value="0" checked disabled="true"/>
													0x00000000 : 기본 옵션<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="65536" checked />
													0x00010000 : 저장할 파일 선택창을 출력하지 않는다.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="131072"/>
													0x00020000 : 저장할 파일을 임시 폴더에 저장한다.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="262144"/>
													0x00040000 : 동일한 이름의 저장 파일이 있는 경우 오류 처리한다.(기본값은 덮어쓴다)<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="524288"/>
													0x00080000 : 진행창을 보이지 않는다.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="1048576"/>
													0x00100000 : 성공 시 진행창을 닫는다.(오류 시는 닫지 않는다)<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="2097152"/>
													0x00200000 : 완료 시 진행창을 닫는다.(오류가 발생해도 닫는다)<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="4194304"/>
													0x00400000 : 오류 시 다음 파일 계속 진행한다.(기본값은 종료한다)<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="8388608"/>
													0x00800000 : 오류 시 다음 파일 계속 진행할지 확인창을 띄운다.<br/>
												</td>
											</tr>
											<tr>
												<td>aDescription</td>
												<td style="text-align:left;"><input type="text" class="inputtext" name="aDescription"/></td>
											</tr>
											<tr>
												<td>Run</td>
												<td colspan="2">
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.DeEnvelopeFileWithCert"
													onClick="AnySign.DeEnvelopeFileWithCert (this.form.aXgateAddress.value,
																						     this.form.aCAList.value,
																						     this.form.aLimitPassword.value,
																						     this.form.aInputFilePath.value,
																						     this.form.aOutputFilePath.value,
																						     sumCheckbox (this.form.aOption),
																						     this.form.aDescription.value,
																						     DeEnvelopeFileWithCert_Callback,
																						     DeEnvelopeFileWithCert_ErrCallback)"/>
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
										
										<h3 id="13">DeEnvelopeFileWithCert_Serial</h3>
										<form id="form_DeEnvelopeFileWithCert_Serial" name="form_DeEnvelopeFileWithCert_Serial" method="post" action="#">
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
												<td>aCertSerial</td>
												<td><input type="text" class="inputtext" name="aCertSerial"/></td>
											</tr>
											<tr>
												<td>aCertLocation</td>
												<td><input type="text" class="inputtext" name="aCertLocation"/></td>
											</tr>
											<tr>
												<td>aLimitPassword</td>
												<td><input type="text" class="inputtext" name="aLimitPassword"/></td>
											</tr>
											<tr>
												<td>aInputFilePath</td>
												<td style="text-align:left;">
													<input type="checkbox" class="inputcheck" name="aFileSelectOption" value="0" checked disabled="true"/>
													0 : 단일 파일 선택<br/>
													<input type="checkbox" class="inputcheck" name="aFileSelectOption" value="2" onClick="disableInput (this.checked, this.form.aOutputFilePath)"/>
													2 : 복수 파일 선택 (Ctrl + Click)<br/>
													<input type="button" class="inputbutton" style="height:auto;" value="SelectFile"
													onClick="onSelectOpenFile2 (sumCheckbox (this.form.aFileSelectOption), this.form.aInputFilePath, this.form.aOutputFilePath, aEnvelopeFileExt);"/>
													<input type="text" class="inputtext" name="aInputFilePath"/>
												</td>
											</tr>
											<tr>
												<td>aOutputFilePath</td>
												<td style="text-align:left;"><input type="text" class="inputtext" name="aOutputFilePath"/></td>
											</tr>
											<tr>
												<td>aOption</td>
												<td style="text-align:left;">
													<input type="checkbox" class="inputcheck" name="aOption" value="0" checked disabled="true"/>
													0x00000000 : 기본 옵션<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="65536" checked />
													0x00010000 : 저장할 파일 선택창을 출력하지 않는다.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="131072"/>
													0x00020000 : 저장할 파일을 임시 폴더에 저장한다.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="262144"/>
													0x00040000 : 동일한 이름의 저장 파일이 있는 경우 오류 처리한다.(기본값은 덮어쓴다)<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="524288"/>
													0x00080000 : 진행창을 보이지 않는다.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="1048576"/>
													0x00100000 : 성공 시 진행창을 닫는다.(오류 시는 닫지 않는다)<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="2097152"/>
													0x00200000 : 완료 시 진행창을 닫는다.(오류가 발생해도 닫는다)<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="4194304"/>
													0x00400000 : 오류 시 다음 파일 계속 진행한다.(기본값은 종료한다)<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="8388608"/>
													0x00800000 : 오류 시 다음 파일 계속 진행할지 확인창을 띄운다.<br/>
												</td>
											</tr>
											<tr>
												<td>aDescription</td>
												<td style="text-align:left;"><input type="text" class="inputtext" name="aDescription"/></td>
											</tr>
											<tr>
												<td>Run</td>
												<td colspan="2">
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.DeEnvelopeFileWithCert_Serial"
													onClick="AnySign.DeEnvelopeFileWithCert_Serial (this.form.aXgateAddress.value,
																								    this.form.aCAList.value,
																								    this.form.aCertSerial.value,
																								    this.form.aCertLocation.value,
																								    this.form.aLimitPassword.value,
																								    this.form.aInputFilePath.value,
																								    this.form.aOutputFilePath.value,
																								    sumCheckbox (this.form.aOption),
																								    this.form.aDescription.value,
																								    DeEnvelopeFileWithCert_Serial_Callback,
																								    DeEnvelopeFileWithCert_Serial_ErrCallback)"/>
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
										
										<h3 id="14">EnvelopeFileWithPasswd</h3>
										<form id="form_EnvelopeFileWithPasswd" name="form_EnvelopeFileWithPasswd" method="post" action="#">
										<table class="test">
											<tr>
												<td width="50" rowspan="5">Input</td>
												<td width="120">aInputFilePath</td>
												<td width="524" style="text-align:left;">
													<input type="checkbox" class="inputcheck" name="aFileSelectOption" value="0" checked disabled="true"/>
													0 : 단일 파일 선택<br/>
													<input type="checkbox" class="inputcheck" name="aFileSelectOption" value="2" onClick="disableInput (this.checked, this.form.aOutputFilePath)"/>
													2 : 복수 파일 선택 (Ctrl + Click)<br/>
													<input type="button" class="inputbutton" style="height:auto;" value="SelectFile"
													onClick="onSelectOpenFile (sumCheckbox (this.form.aFileSelectOption), this.form.aInputFilePath, this.form.aOutputFilePath, aEnvelopeFileExt);"/>
													<input type="text" class="inputtext" name="aInputFilePath"/>
												</td>
											</tr>
											<tr>
												<td>aOutputFilePath</td>
												<td style="text-align:left;"><input type="text" class="inputtext" name="aOutputFilePath"/></td>
											</tr>
											<tr>
												<td>aPassword</td>
												<td style="text-align:left;">
													<input type="text" class="inputtext" name="aPassword"/>
												</td>
											</tr>
											<tr>
												<td>aOption</td>
												<td style="text-align:left;">
													<strong>(패스워드 입력창 옵션)</strong></br>
													<input type="checkbox" class="inputcheck" name="aOption" value="0" checked disabled="true"/>
													0x00000000 : WEB으로 부터 직접 입력받는다.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="1"/>
													0x00000001 : 패스워드 입력창을 출력한다.<br/>
													<strong>(공통 옵션)</strong></br>
													<input type="checkbox" class="inputcheck" name="aOption" value="65536" checked />
													0x00010000 : 저장할 파일 선택창을 출력하지 않는다.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="131072"/>
													0x00020000 : 저장할 파일을 임시 폴더에 저장한다.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="262144"/>
													0x00040000 : 동일한 이름의 저장 파일이 있는 경우 오류 처리한다.(기본값은 덮어쓴다)<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="524288"/>
													0x00080000 : 진행창을 보이지 않는다.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="1048576"/>
													0x00100000 : 성공 시 진행창을 닫는다.(오류 시는 닫지 않는다)<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="2097152"/>
													0x00200000 : 완료 시 진행창을 닫는다.(오류가 발생해도 닫는다)<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="4194304"/>
													0x00400000 : 오류 시 다음 파일 계속 진행한다.(기본값은 종료한다)<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="8388608"/>
													0x00800000 : 오류 시 다음 파일 계속 진행할지 확인창을 띄운다.<br/>
												</td>
											</tr>
											<tr>
												<td>aDescription</td>
												<td style="text-align:left;"><input type="text" class="inputtext" name="aDescription"/></td>
											</tr>
											<tr>
												<td>Run</td>
												<td colspan="2">
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.EnvelopeFileWithPasswd"
													onClick="AnySign.EnvelopeFileWithPasswd (this.form.aInputFilePath.value,
																						     this.form.aOutputFilePath.value,
																						     this.form.aPassword.value,
																						     sumCheckbox (this.form.aOption),
																						     this.form.aDescription.value,
																						     EnvelopeFileWithPasswd_Callback,
																						     EnvelopeFileWithPasswd_ErrCallback)"/>
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
										
										<h3 id="15">DeEnvelopeFileWithPasswd</h3>
										<form id="form_DeEnvelopeFileWithPasswd" name="form_DeEnvelopeFileWithPasswd" method="post" action="#">
										<table class="test">
											<tr>
												<td width="50" rowspan="5">Input</td>
												<td width="120">aInputFilePath</td>
												<td width="524" style="text-align:left;">
													<input type="checkbox" class="inputcheck" name="aFileSelectOption" value="0" checked disabled="true"/>
													0 : 단일 파일 선택<br/>
													<input type="checkbox" class="inputcheck" name="aFileSelectOption" value="2" onClick="disableInput (this.checked, this.form.aOutputFilePath)"/>
													2 : 복수 파일 선택 (Ctrl + Click)<br/>
													<input type="button" class="inputbutton" style="height:auto;" value="SelectFile"
													onClick="onSelectOpenFile2 (sumCheckbox (this.form.aFileSelectOption), this.form.aInputFilePath, this.form.aOutputFilePath, aEnvelopeFileExt);"/>
													<input type="text" class="inputtext" name="aInputFilePath"/>
												</td>
											</tr>
											<tr>
												<td>aOutputFilePath</td>
												<td style="text-align:left;"><input type="text" class="inputtext" name="aOutputFilePath"/></td>
											</tr>
											<tr>
												<td>aPassword</td>
												<td style="text-align:left;">
													<input type="text" class="inputtext" name="aPassword"/>
												</td>
											</tr>
											<tr>
												<td>aOption</td>
												<td style="text-align:left;">
													<strong>(패스워드 입력창 옵션)</strong></br>
													<input type="checkbox" class="inputcheck" name="aOption" value="0" checked disabled="true"/>
													0x00000000 : WEB으로 부터 직접 입력받는다.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="1"/>
													0x00000001 : 패스워드 입력창을 출력한다.<br/>
													<strong>(공통 옵션)</strong></br>
													<input type="checkbox" class="inputcheck" name="aOption" value="65536" checked />
													0x00010000 : 저장할 파일 선택창을 출력하지 않는다.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="131072"/>
													0x00020000 : 저장할 파일을 임시 폴더에 저장한다.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="262144"/>
													0x00040000 : 동일한 이름의 저장 파일이 있는 경우 오류 처리한다.(기본값은 덮어쓴다)<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="524288"/>
													0x00080000 : 진행창을 보이지 않는다.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="1048576"/>
													0x00100000 : 성공 시 진행창을 닫는다.(오류 시는 닫지 않는다)<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="2097152"/>
													0x00200000 : 완료 시 진행창을 닫는다.(오류가 발생해도 닫는다)<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="4194304"/>
													0x00400000 : 오류 시 다음 파일 계속 진행한다.(기본값은 종료한다)<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="8388608"/>
													0x00800000 : 오류 시 다음 파일 계속 진행할지 확인창을 띄운다.<br/>
												</td>
											</tr>
											<tr>
												<td>aDescription</td>
												<td style="text-align:left;"><input type="text" class="inputtext" name="aDescription"/></td>
											</tr>
											<tr>
												<td>Run</td>
												<td colspan="2">
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.DeEnvelopeFileWithPasswd"
													onClick="AnySign.DeEnvelopeFileWithPasswd (this.form.aInputFilePath.value,
																							   this.form.aOutputFilePath.value,
																							   this.form.aPassword.value,
																							   sumCheckbox (this.form.aOption),
																							   this.form.aDescription.value,
																							   DeEnvelopeFileWithPasswd_Callback,
																							   DeEnvelopeFileWithPasswd_ErrCallback)"/>
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
										
										<h3 id="16">GetEnvelopedFileInfo</h3>
										<form id="form_GetEnvelopedFileInfo" name="form_GetEnvelopedFileInfo" method="post" action="#">
										<table class="test">
											<tr>
												<td width="50" rowspan="2">Input</td>
												<td width="120">aInputFilePath</td>
												<td width="524" style="text-align:left;">
													<input type="button" class="inputbutton" style="height:auto;" value="SelectFile"
													onClick="onSelectOpenFile (0, this.form.aInputFilePath);"/>
													<input type="text" class="inputtext" name="aInputFilePath"/>
												</td>
											</tr>
											<tr>
												<td>aOption</td>
												<td style="text-align:left;">
													<input type="checkbox" class="inputcheck" name="aOption" value="1" checked/>
													0x00000001 : 전자봉투 타입<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="2" checked/>
													0x00000002 : 파일명<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="4" checked/>
													0x00000004 : 인증서 일련번호<br/>
												</td>
											</tr>
											<tr>
												<td>Run</td>
												<td colspan="2">
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.GetEnvelopedFileInfo"
													onClick="AnySign.GetEnvelopedFileInfo (this.form.aInputFilePath.value,
																				 		   sumCheckbox (this.form.aOption),
																				 		   GetEnvelopedFileInfo_Callback,
																				 		   GetEnvelopedFileInfo_ErrCallback)"/>
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
										
										<h3 id="17">UploadFile</h3>
										<form id="form_UploadFile" name="form_UploadFile" method="post" action="#">
										<table class="test">
											<tr>
												<td width="50" rowspan="8">Input</td>
												<td width="120">aXgateAddress</td>
												<td width="524"><input type="text" class="inputtext" name="aXgateAddress"/></td>
											</tr>
											<tr>
												<td>aPath</td>
												<td style="text-align:left;"><input type="text" class="inputtext" name="aPath"/></td>
											</tr>
											<tr>
												<td>aQuery</td>
												<td style="text-align:left;"><input type="text" class="inputtext" name="aQuery"/></td>
											</tr>
											<tr>
												<td>aHostName</td>
												<td style="text-align:left;"><input type="text" class="inputtext" name="aHostName"/></td>
											</tr>
											<tr>
												<td>aPort</td>
												<td style="text-align:left;"><input type="text" class="inputtext" name="aPort"/></td>
											</tr>
											<tr>
												<td>aInputFilePath</td>
												<td style="text-align:left;">
													<input type="checkbox" class="inputcheck" name="aFileSelectOption" value="0" checked disabled="true"/>
													0 : 단일 파일 선택<br/>
													<input type="checkbox" class="inputcheck" name="aFileSelectOption" value="2"/>
													2 : 복수 파일 선택 (Ctrl + Click)<br/>
													<input type="button" class="inputbutton" style="height:auto;" value="SelectFile"
													onClick="onSelectOpenFile (sumCheckbox (this.form.aFileSelectOption), this.form.aInputFilePath);"/>
													<input type="text" class="inputtext" name="aInputFilePath"/>
												</td>
											</tr>
											<tr>
												<td>aOption</td>
												<td style="text-align:left;">
													<input type="checkbox" class="inputcheck" name="aOption" value="0" checked disabled="true"/>
													0x00000000 : 기본 옵션<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="524288"/>
													0x00080000 : 진행창을 보이지 않는다.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="1048576"/>
													0x00100000 : 성공 시 진행창을 닫는다.(오류 시는 닫지 않는다)<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="2097152"/>
													0x00200000 : 완료 시 진행창을 닫는다.(오류가 발생해도 닫는다)<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="4194304"/>
													0x00400000 : 오류 시 다음 파일 계속 진행한다.(기본값은 종료한다)<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="8388608"/>
													0x00800000 : 오류 시 다음 파일 계속 진행할지 확인창을 띄운다.<br/>
												</td>
											</tr>
											<tr>
												<td>aDescription</td>
												<td style="text-align:left;"><input type="text" class="inputtext" name="aDescription"/></td>
											</tr>
											<tr>
												<td>Run</td>
												<td colspan="2">
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.UploadFile"
													onClick="AnySign.UploadFile (this.form.aXgateAddress.value,
																				 this.form.aPath.value,
																				 this.form.aQuery.value,
																				 this.form.aHostName.value,
																				 this.form.aPort.value,
																				 this.form.aInputFilePath.value,
																				 sumCheckbox (this.form.aOption),
																				 this.form.aDescription.value,
																				 UploadFile_Callback,
																				 UploadFile_ErrCallback)"/>
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
										
										<h3 id="18">DownloadFile</h3>
										<form id="form_DownloadFile" name="form_DownloadFile" method="post" action="#">
										<table class="test">
											<tr>
												<td width="50" rowspan="9">Input</td>
												<td width="120">aXgateAddress</td>
												<td width="524"><input type="text" class="inputtext" name="aXgateAddress"/></td>
											</tr>
											<tr>
												<td>aPath</td>
												<td style="text-align:left;"><input type="text" class="inputtext" name="aPath"/></td>
											</tr>
											<tr>
												<td>aQuery</td>
												<td style="text-align:left;"><input type="text" class="inputtext" name="aQuery"/></td>
											</tr>
											<tr>
												<td>aHostName</td>
												<td style="text-align:left;"><input type="text" class="inputtext" name="aHostName"/></td>
											</tr>
											<tr>
												<td>aPort</td>
												<td style="text-align:left;"><input type="text" class="inputtext" name="aPort"/></td>
											</tr>
											<tr>
												<td>aTargetFilePath</td>
												<td style="text-align:left;">
													<select name="aTargetFileSelect" multiple="single" class="inputselect" size="6">
<%
													if (files != null)
													{
														for (i = 0 ; i < files.length; ++i)
														{
															if (!files[i].isDirectory())
																out.println ("<option value=\"" +  files[i].getName() + "\">" + files[i].getName() + " (" + files[i].length() + " Byte)</option>");
														}
													}
													else
													{
														out.println ("<option value=\"\">No Files</option>");
													}
%>
													</select>
													* Multi Select: Ctrl + Click<br/>
													<input type="button" class="inputbutton" style="height:auto;" value="SelectFile"
													onClick="this.form.aTargetFilePath.value = sumSelect (this.form.aTargetFileSelect)"/><br/>
													<input type="text" class="inputtext" name="aTargetFilePath"/>
												</td>
											</tr>
											<tr>
												<td>aDownloadPath</td>
												<td style="text-align:left;">
													<input type="button" class="inputbutton" style="height:auto;" value="SelectFile"
													onClick="onSelectSaveFile (this.form.aDownloadPath, 3);"/>
													<input type="text" class="inputtext" name="aDownloadPath"/>
												</td>
											</tr>
											<tr>
												<td>aOption</td>
												<td style="text-align:left;">
													<input type="checkbox" class="inputcheck" name="aOption" value="0" checked disabled="true"/>
													0x00000000 : 기본 옵션<br/>													
													<input type="checkbox" class="inputcheck" name="aOption" value="65536" checked />
													0x00010000 : 저장할 파일 선택창을 출력하지 않는다.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="131072"/>
													0x00020000 : 저장할 파일을 임시 폴더에 저장한다.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="262144"/>
													0x00040000 : 동일한 이름의 저장 파일이 있는 경우 오류 처리한다.(기본값은 덮어쓴다)<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="524288"/>
													0x00080000 : 진행창을 보이지 않는다.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="1048576"/>
													0x00100000 : 성공 시 진행창을 닫는다.(오류 시는 닫지 않는다)<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="2097152"/>
													0x00200000 : 완료 시 진행창을 닫는다.(오류가 발생해도 닫는다)<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="4194304"/>
													0x00400000 : 오류 시 다음 파일 계속 진행한다.(기본값은 종료한다)<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="8388608"/>
													0x00800000 : 오류 시 다음 파일 계속 진행할지 확인창을 띄운다.<br/>
												</td>
											</tr>
											<tr>
												<td>aDescription</td>
												<td style="text-align:left;"><input type="text" class="inputtext" name="aDescription"/></td>
											</tr>
											<tr>
												<td>Run</td>
												<td colspan="2">
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.DownloadFile"
													onClick="AnySign.DownloadFile (this.form.aXgateAddress.value,
																				   this.form.aPath.value,
																				   this.form.aQuery.value,
																				   this.form.aHostName.value,
																				   this.form.aPort.value,
																				   this.form.aTargetFilePath.value,
																				   this.form.aDownloadPath.value,
																				   sumCheckbox (this.form.aOption),
																				   this.form.aDescription.value,
																				   DownloadFile_Callback,
																				   DownloadFile_ErrCallback)"/>
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
										
										<h3 id="19">ZipFile</h3>
										<form id="form_ZipFile" name="form_ZipFile" method="post" action="#">
										<table class="test">
											<tr>
												<td width="50" rowspan="5">Input</td>
												<td width="120">aXgateAddress</td>
												<td width="524"><input type="text" class="inputtext" name="aXgateAddress"/></td>
											</tr>
											<tr>
												<td>aInputFilePath</td>
												<td style="text-align:left;">
													<input type="checkbox" class="inputcheck" name="aFileSelectOption" value="0" checked disabled="true"/>
													0 : 단일 파일 선택<br/>
													<input type="checkbox" class="inputcheck" name="aFileSelectOption" value="2" onClick="disableInput (this.checked, this.form.aOutputFilePath)"/>
													2 : 복수 파일 선택 (Ctrl + Click)<br/>
													<input type="button" class="inputbutton" style="height:auto;" value="SelectFile"
													onClick="onSelectOpenFile (sumCheckbox (this.form.aFileSelectOption), this.form.aInputFilePath, this.form.aOutputFilePath, aZipFileExt);"/>
													<input type="text" class="inputtext" name="aInputFilePath"/>
												</td>
											</tr>
											<tr>
												<td>aOutputFilePath</td>
												<td style="text-align:left;"><input type="text" class="inputtext" name="aOutputFilePath"/></td>
											</tr>
											<tr>
												<td>aOption</td>
												<td style="text-align:left;">
													<input type="checkbox" class="inputcheck" name="aOption" value="65536" checked />
													0x00010000 : 저장할 파일 선택창을 출력하지 않는다.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="131072"/>
													0x00020000 : 저장할 파일을 임시 폴더에 저장한다.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="262144"/>
													0x00040000 : 동일한 이름의 저장 파일이 있는 경우 오류 처리한다.(기본값은 덮어쓴다)<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="524288"/>
													0x00080000 : 진행창을 보이지 않는다.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="1048576"/>
													0x00100000 : 성공 시 진행창을 닫는다.(오류 시는 닫지 않는다)<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="2097152"/>
													0x00200000 : 완료 시 진행창을 닫는다.(오류가 발생해도 닫는다)<br/>
												</td>
											</tr>
											<tr>
												<td>aDescription</td>
												<td style="text-align:left;"><input type="text" class="inputtext" name="aDescription"/></td>
											</tr>
											<tr>
												<td>Run</td>
												<td colspan="2">
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.ZipFile"
													onClick="AnySign.ZipFile (this.form.aXgateAddress.value,
																			  this.form.aInputFilePath.value,
																			  this.form.aOutputFilePath.value,
																			  sumCheckbox (this.form.aOption),
																			  this.form.aDescription.value,
																			  ZipFile_Callback,
																			  ZipFile_ErrCallback)"/>
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
										
										<h3 id="20">UnZipFile</h3>
										<form id="form_UnZipFile" name="form_UnZipFile" method="post" action="#">
										<table class="test">
											<tr>
												<td width="50" rowspan="5">Input</td>
												<td width="120">aXgateAddress</td>
												<td width="524"><input type="text" class="inputtext" name="aXgateAddress"/></td>
											</tr>
											<tr>
												<td>aInputFilePath</td>
												<td style="text-align:left;">
													<input type="button" class="inputbutton" style="height:auto;" value="SelectFile"
													onClick="onSelectOpenFile3 (0, this.form.aInputFilePath, this.form.aOutputFilePath);"/>
													<input type="text" class="inputtext" name="aInputFilePath"/>
												</td>
											</tr>
											<tr>
												<td>aOutputFilePath</td>
												<td style="text-align:left;"><input type="text" class="inputtext" name="aOutputFilePath"/></td>
											</tr>
											<tr>
												<td>aOption</td>
												<td style="text-align:left;">
													<input type="checkbox" class="inputcheck" name="aOption" value="65536" checked />
													0x00010000 : 저장할 파일 선택창을 출력하지 않는다.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="131072"/>
													0x00020000 : 저장할 파일을 임시 폴더에 저장한다.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="524288"/>
													0x00080000 : 진행창을 보이지 않는다.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="1048576"/>
													0x00100000 : 성공 시 진행창을 닫는다.(오류 시는 닫지 않는다)<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="2097152"/>
													0x00200000 : 완료 시 진행창을 닫는다.(오류가 발생해도 닫는다)<br/>
												</td>
											</tr>
											<tr>
												<td>aDescription</td>
												<td style="text-align:left;"><input type="text" class="inputtext" name="aDescription"/></td>
											</tr>
											<tr>
												<td>Run</td>
												<td colspan="2">
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.UnZipFile"
													onClick="AnySign.UnZipFile (this.form.aXgateAddress.value,
																				this.form.aInputFilePath.value,
																				this.form.aOutputFilePath.value,
																				sumCheckbox (this.form.aOption),
																				this.form.aDescription.value,
																				UnZipFile_Callback,
																				UnZipFile_ErrCallback)"/>
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
										
										<h3 id="21">SelectFile</h3>
										<form id="form_SelectFile" name="form_SelectFile" method="post" action="#">
										<table class="test">
											<tr>
												<td width="50" rowspan="3">Input</td>
												<td width="120">aInitPath</td>
												<td width="524"><input type="text" class="inputtext" name="aInitPath"/></td>
											</tr>
											<tr>
												<td>aFilterString</td>
												<td style="text-align:left;">
												<input type="text" class="inputtext" name="aFilterString"/>
												</td>
											</tr>
											<tr>
												<td>aOption</td>
												<td style="text-align:left;">
													<input type="checkbox" class="inputcheck" name="aOption" value="0" checked disabled="true"/>
													0x00000000 : 열기 모드<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="1"/>
													0x00000001 : 저장 모드<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="2"/>
													0x00000002 : 다중 파일 선택 (저장 모드인 경우 폴더 선택창을 띄운다)<br/>
												</td>
											</tr>
											<tr>
												<td>Run</td>
												<td colspan="2">
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.SelectFile"
													onClick="AnySign.SelectFile (this.form.aInitPath.value,
																				 this.form.aFilterString.value,
																				 sumCheckbox (this.form.aOption),
																				 SelectFile_Callback,
																				 SelectFile_ErrCallback)"/>
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
										
										<h3 id="22">GetFileInfo</h3>
										<form id="form_GetFileInfo" name="form_GetFileInfo" method="post" action="#">
										<table class="test">
											<tr>
												<td width="50" rowspan="2">Input</td>
												<td width="120">aFilePath</td>													
												<td width="524">
													<input type="button" class="inputbutton" style="height:auto;" value="SelectFile"
													onClick="onSelectOpenFile (0, this.form.aFilePath);"/>
													<input type="text" class="inputtext" name="aFilePath"/>
												</td>
											</tr>
											<tr>
												<td>aOption</td>
												<td style="text-align:left;">
													<input type="checkbox" class="inputcheck" name="aOption" value="1" checked />
													0x00000001 : 크기<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="2"/>
													0x00000002 : 생성 시간<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="4"/>
													0x00000004 : 마지막 접근 시간<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="8"/>
													0x00000008 : 마지막 수정 시간<br/>
												</td>
											</tr>
											<tr>
												<td>Run</td>
												<td colspan="2">
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.GetFileInfo"
													onClick="AnySign.GetFileInfo (this.form.aFilePath.value,
																				  sumCheckbox (this.form.aOption),
																				  GetFileInfo_Callback,
																				  GetFileInfo_ErrCallback)"/>
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
										
										<h3 id="23">ClearTempFile</h3>
										<form id="form_ClearTempFile" name="form_ClearTempFile" method="post" action="#">
										<table class="test">
											<tr>
												<td width="50">Input</td>
												<td width="120">aXgateAddress</td>
												<td width="524"><input type="text" class="inputtext" name="aXgateAddress"/></td>
											</tr>
											<tr>
												<td>Run</td>
												<td colspan="2">
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.ClearTempFile"
													onClick="AnySign.ClearTempFile (this.form.aXgateAddress.value,
																					ClearTempFile_Callback,
																					ClearTempFile_ErrCallback)"/>
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
										
										<h3 id="24">GetHomeDir</h3>
										<form id="form_GetHomeDir" name="form_GetHomeDir" method="post" action="#">
										<table class="test">
											<tr>
												<td width="50">Run</td>
												<td width="644">
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.GetHomeDir"
													onClick="AnySign.GetHomeDir (GetHomeDir_Callback,
																				 GetHomeDir_ErrCallback)"/>
												</td>
											</tr>
											<tr>
												<td>Output</td>
												<td>
													<textarea class="inputtextarea" name="aResult" rows="7"></textarea>
												</td>
											</tr>
										</table>
										</form>
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
