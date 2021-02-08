<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="java.security.Provider" %>
<%@ page import="java.security.NoSuchAlgorithmException" %>
<%@ page import="xecure.servlet.*" %>
<%@ page import="xecure.crypto.*" %>
<%
	int cnt = 0;
	String tmpStr = "";

	// 서명 대상 파일 경로
	String strFilePath = "/signfileinfo/test.txt";
	String strFilePath_1 = "/signfileinfo/test1.txt";
	String strFilePath_2 = "/signfileinfo/test2.txt";
	String strFilePath_3 = "/signfileinfo/test3.txt";

	// 해쉬 알고리즘명
	String strAlgNameSha1 = "SHA1";
	String strAlgNameSha256 = "SHA256";
	
	// 클라이언트 전달 변수
	String strFileInfo = "";
	String strFileHash = "";
	String strMultiFileInfo = "";
	String strMultiFileHash = "";
	
	//-----------------------------------------------------------------------------
	// file 0
	//-----------------------------------------------------------------------------
	
	// 서명 대상 파일명 추출
	cnt = 0;
	tmpStr = strFilePath;
	while(true){
		cnt = tmpStr.indexOf("/");
		if(cnt == -1) break;
		tmpStr = tmpStr.substring(cnt+1);
	}
	while(true){
		cnt = tmpStr.indexOf("\\");
		if(cnt == -1) break;
		tmpStr = tmpStr.substring(cnt+1);
	}
	String strFileName = tmpStr;
	
	String strFileDate = "";
	String strDigestSha1 = "";
	String strDigestSha256 = "";
	
	// 파일 확인
	File f = new File(strFilePath);
	if(!f.isFile()) {
		out.println("File0 Not Found");
		return;
	}
	
	//-----------------------------------------------------------------------------
	// 1. 파일 -> 바이트 변환
	RandomAccessFile afile = new RandomAccessFile(strFilePath, "r");
	byte[] bytes = new byte[(int)afile.length()];
	afile.read(bytes);
	afile.close();
	
	//-----------------------------------------------------------------------------
	// 2. 파일 마지막 수정 날짜 확인
	File file = new File(strFilePath);
	Date date = new Date(file.lastModified());
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyMMddhhmmss");
	strFileDate = sdf.format(date);
	
	//-----------------------------------------------------------------------------	
	// 3. 파일 해쉬값 생성
	// 1) SHA-1
	XWMessageDigest xwmdSha1 = XWMessageDigest.getInstance("SHA-1");
	if(xwmdSha1 == null)
	{
		out.println("> not support algorithm.");
		return;
	}
	byte[] bDigestSha1 = xwmdSha1.digest(bytes);
	strDigestSha1 = Cipher.toHexString(bDigestSha1);
	
	// 2) SHA-256
	XWMessageDigest xwmdSha2 = XWMessageDigest.getInstance("SHA-256");
	if(xwmdSha2 == null)
	{
		out.println("> not support algorithm.");
		return;
	}
	byte[] bDigestSha2 = xwmdSha2.digest(bytes);
	strDigestSha256 = Cipher.toHexString(bDigestSha2);
	
	//-----------------------------------------------------------------------------
	// file 1
	//-----------------------------------------------------------------------------
	
	// 서명 대상 파일명 추출
	cnt = 0;
	tmpStr = strFilePath_1;
	while(true){
		cnt = tmpStr.indexOf("/");
		if(cnt == -1) break;
		tmpStr = tmpStr.substring(cnt+1);
	}
	while(true){
		cnt = tmpStr.indexOf("\\");
		if(cnt == -1) break;
		tmpStr = tmpStr.substring(cnt+1);
	}
	String strFileName_1 = tmpStr;
	
	String strFileDate_1 = "";
	String strDigestSha1_1 = "";
	String strDigestSha256_1 = "";
	
	// 파일 확인
	File f_1 = new File(strFilePath_1);
	if(!f_1.isFile()) {
		out.println("File1 Not Found");
		return;
	}
	
	//-----------------------------------------------------------------------------
	// 1. 파일 -> 바이트 변환
	RandomAccessFile afile_1 = new RandomAccessFile(strFilePath_1, "r");
	byte[] bytes_1 = new byte[(int)afile_1.length()];
	afile_1.read(bytes_1);
	afile_1.close();
	
	//-----------------------------------------------------------------------------
	// 2. 파일 마지막 수정 날짜 확인
	File file_1 = new File(strFilePath_1);
	Date date_1 = new Date(file_1.lastModified());
	
	SimpleDateFormat sdf_1 = new SimpleDateFormat("yyMMddhhmmss");
	strFileDate_1 = sdf_1.format(date_1);
	
	//-----------------------------------------------------------------------------	
	// 3. 파일 해쉬값 생성
	// 1) SHA-1
	XWMessageDigest xwmdSha1_1 = XWMessageDigest.getInstance("SHA-1");
	if(xwmdSha1_1 == null)
	{
		out.println("> not support algorithm.");
		return;
	}
	byte[] bDigestSha1_1 = xwmdSha1_1.digest(bytes_1);
	strDigestSha1_1 = Cipher.toHexString(bDigestSha1_1);
	
	// 2) SHA-256
	XWMessageDigest xwmdSha2_1 = XWMessageDigest.getInstance("SHA-256");
	if(xwmdSha2_1 == null)
	{
		out.println("> not support algorithm.");
		return;
	}
	byte[] bDigestSha2_1 = xwmdSha2_1.digest(bytes_1);
	strDigestSha256_1 = Cipher.toHexString(bDigestSha2_1);
	
	//-----------------------------------------------------------------------------
	// file 2
	//-----------------------------------------------------------------------------	
	
	// 서명 대상 파일명 추출
	cnt = 0;
	tmpStr = strFilePath_2;
	while(true){
		cnt = tmpStr.indexOf("/");
		if(cnt == -1) break;
		tmpStr = tmpStr.substring(cnt+1);
	}
	while(true){
		cnt = tmpStr.indexOf("\\");
		if(cnt == -1) break;
		tmpStr = tmpStr.substring(cnt+1);
	}
	String strFileName_2 = tmpStr;
	
	String strFileDate_2 = "";
	String strDigestSha1_2 = "";
	String strDigestSha256_2 = "";
	
	// 파일 확인
	File f_2 = new File(strFilePath_2);
	if(!f_2.isFile()) {
		out.println("File2 Not Found");
		return;
	}
	
	//-----------------------------------------------------------------------------
	// 1. 파일 -> 바이트 변환
	RandomAccessFile afile_2 = new RandomAccessFile(strFilePath_2, "r");
	byte[] bytes_2 = new byte[(int)afile_2.length()];
	afile_2.read(bytes_2);
	afile_2.close();
	
	//-----------------------------------------------------------------------------
	// 2. 파일 마지막 수정 날짜 확인
	File file_2 = new File(strFilePath_2);
	Date date_2 = new Date(file_2.lastModified());
	
	SimpleDateFormat sdf_2 = new SimpleDateFormat("yyMMddhhmmss");
	strFileDate_2 = sdf_2.format(date_2);
	
	//-----------------------------------------------------------------------------	
	// 3. 파일 해쉬값 생성
	// 1) SHA-1
	XWMessageDigest xwmdSha1_2 = XWMessageDigest.getInstance("SHA-1");
	if(xwmdSha1_2 == null)
	{
		out.println("> not support algorithm.");
		return;
	}
	byte[] bDigestSha1_2 = xwmdSha1_2.digest(bytes_2);
	strDigestSha1_2 = Cipher.toHexString(bDigestSha1_2);
	
	// 2) SHA-256
	XWMessageDigest xwmdSha2_2 = XWMessageDigest.getInstance("SHA-256");
	if(xwmdSha2_2 == null)
	{
		out.println("> not support algorithm.");
		return;
	}
	byte[] bDigestSha2_2 = xwmdSha2_2.digest(bytes_2);
	strDigestSha256_2 = Cipher.toHexString(bDigestSha2_2);

	//-----------------------------------------------------------------------------
	// file 3
	//-----------------------------------------------------------------------------
	
	// 서명 대상 파일명 추출
	cnt = 0;
	tmpStr = strFilePath_3;
	while(true){
		cnt = tmpStr.indexOf("/");
		if(cnt == -1) break;
		tmpStr = tmpStr.substring(cnt+1);
	}
	while(true){
		cnt = tmpStr.indexOf("\\");
		if(cnt == -1) break;
		tmpStr = tmpStr.substring(cnt+1);
	}
	String strFileName_3 = tmpStr;
	
	String strFileDate_3 = "";
	String strDigestSha1_3 = "";
	String strDigestSha256_3 = "";
	
	// 파일 확인
	File f_3 = new File(strFilePath_3);
	if(!f_3.isFile()) {
		out.println("File3 Not Found");
		return;
	}
	
	//-----------------------------------------------------------------------------
	// 1. 파일 -> 바이트 변환
	RandomAccessFile afile_3 = new RandomAccessFile(strFilePath_3, "r");
	byte[] bytes_3 = new byte[(int)afile_3.length()];
	afile_3.read(bytes_3);
	afile_3.close();
	
	//-----------------------------------------------------------------------------
	// 2. 파일 마지막 수정 날짜 확인
	File file_3 = new File(strFilePath_3);
	Date date_3 = new Date(file_3.lastModified());
	
	SimpleDateFormat sdf_3 = new SimpleDateFormat("yyMMddhhmmss");
	strFileDate_3 = sdf_3.format(date_3);
	
	//-----------------------------------------------------------------------------	
	// 3. 파일 해쉬값 생성
	// 1) SHA-1
	XWMessageDigest xwmdSha1_3 = XWMessageDigest.getInstance("SHA-1");
	if(xwmdSha1_3 == null)
	{
		out.println("> not support algorithm.");
		return;
	}
	byte[] bDigestSha1_3 = xwmdSha1_3.digest(bytes_3);
	strDigestSha1_3 = Cipher.toHexString(bDigestSha1_3);
	
	// 2) SHA-256
	XWMessageDigest xwmdSha2_3 = XWMessageDigest.getInstance("SHA-256");
	if(xwmdSha2_3 == null)
	{
		out.println("> not support algorithm.");
		return;
	}
	byte[] bDigestSha2_3 = xwmdSha2_3.digest(bytes_3);
	strDigestSha256_3 = Cipher.toHexString(bDigestSha2_3);
	
	//-----------------------------------------------------------------------------
	// 클라이언트에 파일 정보 전달
	//-----------------------------------------------------------------------------
	strFileInfo = strFileName + "|" + strFileDate;
	strFileHash = strAlgNameSha1 + "|" + strDigestSha1 + "$" + strAlgNameSha256 + "|" + strDigestSha256;
	strMultiFileInfo = strFileName_1 + "|" + strFileDate_1 + "&" +
					   strFileName_2 + "|" + strFileDate_2 + "&" +
					   strFileName_3 + "|" + strFileDate_3 + "&";
	strMultiFileHash = strAlgNameSha1 + "|" + strDigestSha1_1 + "$" + strAlgNameSha256 + "|" + strDigestSha256_1 + "&" +
					   strAlgNameSha1 + "|" + strDigestSha1_2 + "$" + strAlgNameSha256 + "|" + strDigestSha256_2 + "&" +
					   strAlgNameSha1 + "|" + strDigestSha1_3 + "$" + strAlgNameSha256 + "|" + strDigestSha256_3 + "&";
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
ainput{border:0px; margin:2px; padding:1px;}
.inputbutton	{width: 100%;height: 100%; border:1px solid #d3d3d3; margin:2px; padding:1px;}
.inputcheck		{width: 14px;height: 14px;}
-->
</style>

<script type="text/javascript" src="../inca/resource/js/jquery-1.6.2.min.js"></script>
<script type="text/javascript" src="../inca/nppfs-1.3.0.js"></script>
<script type="text/javascript">
document.write("<script type=\"text/javascript\" src=\"" + "../anySign4PCInterface.js" + "?version=" + new Date().getTime() + "\"></scr"+"ipt>");
</script>

<!--%@ include file="../transkey/includeKeyboardSecurity.jsp" %-->
<SCRIPT type="text/javascript" src="../besoft/openkeyboard/openkeyboard_ac.js" charset="UTF-8" ></SCRIPT>

<script type="text/javascript" src="../ahnlab/astxsdk.js"></script>

<script type="text/javascript" src="../XecureKeyPad/js/xkeypad_config.js"></script>
<script type="text/javascript" src="../XecureKeyPad/js/xkeypad_plugin.js"></script>

<script type="text/javascript" src="../touchennxkey/nxKey/js/TouchEnNxKey.js"></script>

<script type="text/javascript">
// 서버 인증서
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

// 서명 대상 파일 정보
var aFileInfo = "<%=strFileInfo%>";
var aFileHash = "<%=strFileHash%>";

var aMultiFileInfo = "<%=strMultiFileInfo%>";
var aMultiFileHash = "<%=strMultiFileHash%>";

PrintObjectTag();

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
	document.getElementById ("form_SignFileInfo").aXgateAddress.value = AnySign.mXgateAddress;
	document.getElementById ("form_SignFileInfo").aCAList.value = AnySign.mCAList;
	document.getElementById ("form_SignFileInfo").aFileInfo.value = aFileInfo;
	document.getElementById ("form_SignFileInfo").aFileHash.value = aFileHash;
	document.getElementById ("form_SignFileInfo").aLimitPassword.value = AnySign.mLimitedTrial;
	
	document.getElementById ("form_SignFileInfoWithSerial").aXgateAddress.value = AnySign.mXgateAddress;
	document.getElementById ("form_SignFileInfoWithSerial").aCAList.value = AnySign.mCAList;
	document.getElementById ("form_SignFileInfoWithSerial").aFileInfo.value = aFileInfo;
	document.getElementById ("form_SignFileInfoWithSerial").aFileHash.value = aFileHash;
	document.getElementById ("form_SignFileInfoWithSerial").aLimitPassword.value = AnySign.mLimitedTrial;
	
	document.getElementById ("form_SignFileInfoWithVID").aXgateAddress.value = AnySign.mXgateAddress;
	document.getElementById ("form_SignFileInfoWithVID").aCAList.value = AnySign.mCAList;
	document.getElementById ("form_SignFileInfoWithVID").aFileInfo.value = aFileInfo;
	document.getElementById ("form_SignFileInfoWithVID").aFileHash.value = aFileHash;
	document.getElementById ("form_SignFileInfoWithVID").aLimitPassword.value = AnySign.mLimitedTrial;
	
	document.getElementById ("form_SignFileInfoWithVID_Serial").aXgateAddress.value = AnySign.mXgateAddress;
	document.getElementById ("form_SignFileInfoWithVID_Serial").aCAList.value = AnySign.mCAList;
	document.getElementById ("form_SignFileInfoWithVID_Serial").aFileInfo.value = aFileInfo;
	document.getElementById ("form_SignFileInfoWithVID_Serial").aFileHash.value = aFileHash;
	document.getElementById ("form_SignFileInfoWithVID_Serial").aLimitPassword.value = AnySign.mLimitedTrial;
	
	document.getElementById ("form_MultiSignFileInfo").aXgateAddress.value = AnySign.mXgateAddress;
	document.getElementById ("form_MultiSignFileInfo").aCAList.value = AnySign.mCAList;
	document.getElementById ("form_MultiSignFileInfo").aDelimiter.value = "&";
	document.getElementById ("form_MultiSignFileInfo").aTotal.value = 3;
	document.getElementById ("form_MultiSignFileInfo").aFileInfo.value = aMultiFileInfo;
	document.getElementById ("form_MultiSignFileInfo").aFileHash.value = aMultiFileHash;
	document.getElementById ("form_MultiSignFileInfo").aLimitPassword.value = AnySign.mLimitedTrial;
	
	document.getElementById ("form_MultiSignFileInfoWithSerial").aXgateAddress.value = AnySign.mXgateAddress;
	document.getElementById ("form_MultiSignFileInfoWithSerial").aCAList.value = AnySign.mCAList;
	document.getElementById ("form_MultiSignFileInfoWithSerial").aDelimiter.value = "&";
	document.getElementById ("form_MultiSignFileInfoWithSerial").aTotal.value = 3;
	document.getElementById ("form_MultiSignFileInfoWithSerial").aFileInfo.value = aMultiFileInfo;
	document.getElementById ("form_MultiSignFileInfoWithSerial").aFileHash.value = aMultiFileHash;
	document.getElementById ("form_MultiSignFileInfoWithSerial").aLimitPassword.value = AnySign.mLimitedTrial;
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

// Call Method
function SignFileInfo (aXgateAddress, aCAList, aFileInfo, aFileHash, aOption, aDescription, aLimitPassword, aCallback)
{
	AnySign.SignFileInfo (aXgateAddress, aCAList, aFileInfo, aFileHash, aOption, aDescription, aLimitPassword, aCallback);
}

function SignFileInfoWithSerial (aXgateAddress, aCAList, aSerial, aLocation, aFileInfo, aFileHash, aOption, aDescription, aLimitPassword, aCallback)
{	
	AnySign.SignFileInfoWithSerial (aXgateAddress, aCAList, aSerial, aLocation, aFileInfo, aFileHash, aOption, aDescription, aLimitPassword, aCallback);
}

function SignFileInfoWithVID (aXgateAddress, aCAList, aFileInfo, aFileHash, aOption, aDescription, aLimitPassword, aIdn, aSvrCert, aCallback)
{	
	AnySign.SignFileInfoWithVID (aXgateAddress, aCAList, aFileInfo, aFileHash, aOption, aDescription, aLimitPassword, aIdn, aSvrCert, aCallback);
}

function SignFileInfoWithVID_Serial (aXgateAddress, aCAList, aSerial, aLocation, aFileInfo, aFileHash, aOption, aDescription, aLimitPassword, aIdn, aSvrCert, aCallback)
{	
	AnySign.SignFileInfoWithVID_Serial (aXgateAddress, aCAList, aSerial, aLocation, aFileInfo, aFileHash, aOption, aDescription, aLimitPassword, aIdn, aSvrCert, aCallback);
}

// Callback Method
function SignFileInfo_callback (aResult)
{
	document.getElementById ("form_SignFileInfo").aSignedMsg.value = aResult;
}

function SignFileInfoWithSerial_callback (aResult)
{
	document.getElementById ("form_SignFileInfoWithSerial").aSignedMsg.value = aResult;
}

function SignFileInfoWithVID_callback (aResult)
{
	document.getElementById ("form_SignFileInfoWithVID").aSignedMsg.value = aResult;
	send_vid_info(SignFileInfoWithVID_vidmsg_callback);
}

function SignFileInfoWithVID_vidmsg_callback (aResult)
{
	document.getElementById ("form_SignFileInfoWithVID").aVidMsg.value = aResult;
}

function SignFileInfoWithVID_Serial_callback (aResult)
{
	document.getElementById ("form_SignFileInfoWithVID_Serial").aSignedMsg.value = aResult;
	AnySign.GetVidInfo(SignFileInfoWithVID_Serial_vidmsg_callback);
}

function SignFileInfoWithVID_Serial_vidmsg_callback (aResult)
{
	document.getElementById ("form_SignFileInfoWithVID_Serial").aVidMsg.value = aResult;
}

function MultiSignFileInfo_callback (aResult)
{
	document.getElementById ("form_MultiSignFileInfo").aSignedMsg.value = aResult;
}

function MultiSignFileInfoWithSerial_callback (aResult)
{
	document.getElementById ("form_MultiSignFileInfoWithSerial").aSignedMsg.value = aResult;
}

</script>
</head>
<body onload="init();">
<%
	out.println("<h1>XecureWeb for Multi - SignFileInfo Test (Client)</h1>");
	out.println("<hr>");
	out.println("<h2>1. Server 파일 해쉬값 생성</h2>");
	
	out.println("Server Input File Name: " + strFileName + "<br>");
	out.println("Last Modified Date:" + strFileDate + "<br>");
	out.println("XWMessageDigest(sha-1):" + strDigestSha1 + "<br>");
	out.println("XWMessageDigest(sha-256):" + strDigestSha256 + "<br>");
	
	out.println("<br>");
	out.println("Server Input File Name: " + strFileName_1 + "<br>");
	out.println("Last Modified Date:" + strFileDate_1 + "<br>");
	out.println("XWMessageDigest(sha-1):" + strDigestSha1_1 + "<br>");
	out.println("XWMessageDigest(sha-256):" + strDigestSha256_1 + "<br>");
	
	out.println("<br>");
	out.println("Server Input File Name: " + strFileName_2 + "<br>");
	out.println("Last Modified Date:" + strFileDate_2 + "<br>");
	out.println("XWMessageDigest(sha-1):" + strDigestSha1_2 + "<br>");
	out.println("XWMessageDigest(sha-256):" + strDigestSha256_2 + "<br>");
	
	out.println("<br>");
	out.println("Server Input File Name: " + strFileName_3 + "<br>");
	out.println("Last Modified Date:" + strFileDate_3 + "<br>");
	out.println("XWMessageDigest(sha-1):" + strDigestSha1_3 + "<br>");
	out.println("XWMessageDigest(sha-256):" + strDigestSha256_3 + "<br>");
	
	out.println("<hr>");
%>
<form name='xecure'><input type=hidden name='p'></form>
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
										
										<h2>2. Client 서명값 생성</h3>
										<br>
									
										<!-- SignFileInfo START -->
										<h3 id="1">SignFileInfo</h3>
										<form id="form_SignFileInfo" name="form_SignFileInfo" method="post" action="./signfileinfo_server.jsp">
										<table class="test">
											<tr>
												<td width="50" rowspan="7">Input</td>
												<td width="120">XgateAddress</td>
												<td width="524"><input type="text" class="inputtext" name="aXgateAddress"/></td>
											</tr>
											<tr>
												<td>aCAList</td>
												<td><input type="text" class="inputtext" name="aCAList"/></td>
											</tr>
											<tr>
												<td>aFileInfo</td>
												<td><textarea class="inputtextarea" name="aFileInfo" rows="3"></textarea></td>
											</tr>
											<tr>
												<td>aFileHash</td>
												<td><textarea class="inputtextarea" name="aFileHash" rows="3"></textarea></td>
											</tr>
											<tr>
												<td>aOption</td>
												<td style="text-align:left;">
													<input type="checkbox" class="inputcheck" name="aOption" value="0" checked disabled="true"/>
													0x00000000 : 기본 서명<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="1" />
													0x00000001 : 서명확인창을 보여준다.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="256" />
													0x00000100 : 출력 값을 Base64로 <br/>
												</td>
											</tr>
											<tr>
												<td>aDescription</td>
												<td><input type="text" class="inputtext" name="aDescription"/></td>
											</tr>
											<tr>
												<td>aLimitPassword</td>
												<td><input type="text" class="inputtext" name="aLimitPassword"/></td>
											</tr>
											<tr>
												<td>Run</td>
												<td colspan="2">
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.SignFileInfo"
													onClick="SignFileInfo (this.form.aXgateAddress.value,
																		   this.form.aCAList.value,
																		   this.form.aFileInfo.value,
																		   this.form.aFileHash.value,
																		   sumCheckbox (this.form.aOption),
																		   this.form.aDescription.value,
																		   this.form.aLimitPassword.value,
																		   SignFileInfo_callback);"/>
												</td>
											</tr>
											<tr>
												<td>Output</td>
												<td colspan="2">
													<textarea class="inputtextarea" name="aSignedMsg" rows="7"></textarea>
												</td>
											</tr>
											<tr>
												<td>Send</td>
												<td colspan="2">
													<input type="submit" class="inputbutton" style="height:auto;" value="서버로 전송"/>
												</td>
											</tr>
										</table>
										</form>
										<br/>
										<!-- SignFileInfo END -->
										
										
										<!-- SignFileInfoWithSerial START -->
										<h3 id="2">SignFileInfoWithSerial</h3>
										<form id="form_SignFileInfoWithSerial" name="form_SignFileInfoWithSerial" method="post" action="./signfileinfo_server.jsp">
										<table class="test">
											<tr>
												<td width="50" rowspan="9">Input</td>
												<td width="120">XgateAddress</td>
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
												<td>aFileInfo</td>
												<td><textarea class="inputtextarea" name="aFileInfo" rows="3"></textarea></td>
											</tr>
											<tr>
												<td>aFileHash</td>
												<td><textarea class="inputtextarea" name="aFileHash" rows="3"></textarea></td>
											</tr>
											<tr>
												<td>aOption</td>
												<td style="text-align:left;">
													<input type="checkbox" class="inputcheck" name="aOption" value="0" checked disabled="true"/>
													0x00000000 : 기본 서명<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="1" />
													0x00000001 : 서명확인창을 보여준다.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="256" />
													0x00000100 : 출력 값을 Base64로 <br/>
												</td>
											</tr>
											<tr>
												<td>aDescription</td>
												<td><input type="text" class="inputtext" name="aDescription"/></td>
											</tr>
											<tr>
												<td>aLimitPassword</td>
												<td><input type="text" class="inputtext" name="aLimitPassword"/></td>
											</tr>
											<tr>
												<td>Run</td>
												<td colspan="2">
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.SignFileInfoWithSerial"
													onClick="SignFileInfoWithSerial (this.form.aXgateAddress.value,
																					 this.form.aCAList.value,
																					 this.form.aSerial.value,
																					 this.form.aLocation.value,
																					 this.form.aFileInfo.value,
																					 this.form.aFileHash.value,
																					 sumCheckbox (this.form.aOption),
																					 this.form.aDescription.value,
																					 this.form.aLimitPassword.value,
																					 SignFileInfoWithSerial_callback);"/>
												</td>
											</tr>
											<tr>
												<td>Output</td>
												<td colspan="2">
													<textarea class="inputtextarea" name="aSignedMsg" rows="7"></textarea>
												</td>
											</tr>
											<tr>
												<td>Send</td>
												<td colspan="2">
													<input type="submit" class="inputbutton" style="height:auto;" value="서버로 전송"/>
												</td>
											</tr>
										</table>
										</form>
										<br/>
										<!-- SignFileInfoWithSerial END -->
										
										
										<!-- SignFileInfoWithVID START -->
										<h3 id="3">SignFileInfoWithVID</h3>
										<form id="form_SignFileInfoWithVID" name="form_SignFileInfoWithVID" method="post" action="./signfileinfo_server.jsp">
										<table class="test">
											<tr>
												<td width="50" rowspan="11">Input</td>
												<td width="120">XgateAddress</td>
												<td width="524"><input type="text" class="inputtext" name="aXgateAddress"/></td>
											</tr>
											<tr>
												<td>aCAList</td>
												<td><input type="text" class="inputtext" name="aCAList"/></td>
											</tr>
											<tr>
												<td>aIdn</td>
												<td><input type="text" class="inputtext" name="aIdn"/></td>
											</tr>
											<tr>
												<td>aFileInfo</td>
												<td><textarea class="inputtextarea" name="aFileInfo" rows="3"></textarea></td>
											</tr>
											<tr>
												<td>aFileHash</td>
												<td><textarea class="inputtextarea" name="aFileHash" rows="3"></textarea></td>
											</tr>
											<tr>
												<td>aOption</td>
												<td style="text-align:left;">
													<input type="checkbox" class="inputcheck" name="aOption" value="0" checked disabled="true"/>
													0x00000000 : 기본 서명<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="1" />
													0x00000001 : 서명확인창을 보여준다.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="8"/>
													0x00000008 : <strong>WEB(aIdn)</strong>으로 부터 직접 VID를 입력받는다  <strong>(VID입력창 뜨지 않음)</strong><br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="16"/>
													0x00000010 : IDN값을 입력받지 않는다 ""로 IDN대체 <strong>(VID입력창 뜨지 않음)</strong><br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="256" />
													0x00000100 : 출력 값을 Base64로 <br/>
												</td>
											</tr>
											<tr>
												<td>aDescription</td>
												<td><input type="text" class="inputtext" name="aDescription"/></td>
											</tr>
											<tr>
												<td>aLimitPassword</td>
												<td><input type="text" class="inputtext" name="aLimitPassword"/></td>
											</tr>
											<tr>
												<td>Run</td>
												<td colspan="2">
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.SignFileInfoWithVID"
													onClick="SignFileInfoWithVID (this.form.aXgateAddress.value,
																				  this.form.aCAList.value,
																				  this.form.aFileInfo.value,
																				  this.form.aFileHash.value,
																				  sumCheckbox (this.form.aOption),
																				  this.form.aDescription.value,
																				  this.form.aLimitPassword.value,
																				  this.form.aIdn.value,
																				  s,
																				  SignFileInfoWithVID_callback);"/>
												</td>
											</tr>
											<tr>
												<td>Output</td>
												<td colspan="2">
													<textarea class="inputtextarea" name="aSignedMsg" rows="7"></textarea>
												</td>
											</tr>
											<tr>
												<td>VID Output</td>
												<td colspan="2">
													<textarea class="inputtextarea" name="aVidMsg" rows="7"></textarea>
												</td>
											</tr>
											<tr>
												<td>Send</td>
												<td colspan="2">
													<input type="submit" class="inputbutton" style="height:auto;" value="서버로 전송"/>
												</td>
											</tr>
										</table>
										</form>
										<br/>
										<!-- SignFileInfoWithVID END -->
										
										
										<!-- SignFileInfoWithVID_Serial START -->
										<h3 id="4">SignFileInfoWithVID_Serial</h3>
										<form id="form_SignFileInfoWithVID_Serial" name="form_SignFileInfoWithVID_Serial" method="post" action="./signfileinfo_server.jsp">
										<table class="test">
											<tr>
												<td width="50" rowspan="11">Input</td>
												<td width="120">XgateAddress</td>
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
												<td>aIdn</td>
												<td><input type="text" class="inputtext" name="aIdn"/></td>
											</tr>
											<tr>
												<td>aFileInfo</td>
												<td><textarea class="inputtextarea" name="aFileInfo" rows="3"></textarea></td>
											</tr>
											<tr>
												<td>aFileHash</td>
												<td><textarea class="inputtextarea" name="aFileHash" rows="3"></textarea></td>
											</tr>
											<tr>
												<td>aOption</td>
												<td style="text-align:left;">
													<input type="checkbox" class="inputcheck" name="aOption" value="0" checked disabled="true"/>
													0x00000000 : 기본 서명<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="1" />
													0x00000001 : 서명확인창을 보여준다.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="8"/>
													0x00000008 : <strong>WEB(aIdn)</strong>으로 부터 직접 VID를 입력받는다  <strong>(VID입력창 뜨지 않음)</strong><br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="16"/>
													0x00000010 : IDN값을 입력받지 않는다 ""로 IDN대체 <strong>(VID입력창 뜨지 않음)</strong><br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="256" />
													0x00000100 : 출력 값을 Base64로 <br/>
												</td>
											</tr>
											<tr>
												<td>aDescription</td>
												<td><input type="text" class="inputtext" name="aDescription"/></td>
											</tr>
											<tr>
												<td>aLimitPassword</td>
												<td><input type="text" class="inputtext" name="aLimitPassword"/></td>
											</tr>
											<tr>
												<td>Run</td>
												<td colspan="2">
													<input type="button" class="inputbutton" style="height:auto;" value="AnySign.SignFileInfoWithVID_Serial"
													onClick="SignFileInfoWithVID_Serial (this.form.aXgateAddress.value,
																						 this.form.aCAList.value,
																						 this.form.aSerial.value,
																						 this.form.aLocation.value,
																						 this.form.aFileInfo.value,
																						 this.form.aFileHash.value,
																						 sumCheckbox (this.form.aOption),
																						 this.form.aDescription.value,
																						 this.form.aLimitPassword.value,
																						 this.form.aIdn.value,
																						 s,
																						 SignFileInfoWithVID_Serial_callback);"/>
												</td>
											</tr>
											<tr>
												<td>Output</td>
												<td colspan="2">
													<textarea class="inputtextarea" name="aSignedMsg" rows="7"></textarea>
												</td>
											</tr>
											<tr>
												<td>VID Output</td>
												<td colspan="2">
													<textarea class="inputtextarea" name="aVidMsg" rows="7"></textarea>
												</td>
											</tr>
											<tr>
												<td>Send</td>
												<td colspan="2">
													<input type="submit" class="inputbutton" style="height:auto;" value="서버로 전송"/>
												</td>
											</tr>
										</table>
										</form>
										<br/>
										<!-- SignFileInfoWithVID_Serial END -->
										
										<!-- MultiSignFileInfo START -->
										<h3 id="5">MultiSignFileInfo</h3>
										<form id="form_MultiSignFileInfo" name="form_MultiSignFileInfo" method="post" action="./signfileinfo_server.jsp">
										<table class="test">
											<tr>
												<td width="50" rowspan="11">Input</td>
												<td width="120">XgateAddress</td>
												<td width="524"><input type="text" class="inputtext" name="aXgateAddress"/></td>
											</tr>
											<tr>
												<td>aCAList</td>
												<td><input type="text" class="inputtext" name="aCAList"/></td>
											</tr>
											<tr>
												<td>aTotal</td>
												<td><input type="text" class="inputtext" name="aTotal"/></td>
											</tr>
											<tr>
												<td>aDelimiter</td>
												<td><input type="text" class="inputtext" name="aDelimiter"/></td>
											</tr>
											<tr>
												<td>aFileInfo</td>
												<td><textarea class="inputtextarea" name="aFileInfo" rows="3"></textarea></td>
											</tr>
											<tr>
												<td>aFileHash</td>
												<td><textarea class="inputtextarea" name="aFileHash" rows="3"></textarea></td>
											</tr>
											<tr>
												<td>aOption</td>
												<td style="text-align:left;">
													<input type="checkbox" class="inputcheck" name="aOption" value="0" checked disabled="true"/>
													0x00000000 : 기본 서명<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="1" />
													0x00000001 : 서명확인창을 보여준다.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="256" />
													0x00000100 : 출력 값을 Base64로 <br/>
												</td>
											</tr>
											<tr>
												<td>aDescription</td>
												<td><input type="text" class="inputtext" name="aDescription"/></td>
											</tr>
											<tr>
												<td>aLimitPassword</td>
												<td><input type="text" class="inputtext" name="aLimitPassword"/></td>
											</tr>
											<tr>
												<td>Run</td>
												<td colspan="2">
													<input type="button" class="inputbutton" style="height:auto;" value="MultiSignFileInfo"
													onClick="MultiSignFileInfo (this.form.aXgateAddress.value,
																				this.form.aCAList.value,
																				this.form.aTotal.value,
																				this.form.aDelimiter.value,
																				this.form.aFileInfo.value,
																				this.form.aFileHash.value,
																				sumCheckbox (this.form.aOption),
																				this.form.aDescription.value,
																				this.form.aLimitPassword.value,
																				MultiSignFileInfo_callback);"/>
												</td>
											</tr>
											<tr>
												<td>Output</td>
												<td colspan="2">
													<textarea class="inputtextarea" name="aSignedMsg" rows="7"></textarea>
												</td>
											</tr>
											<!--
											<tr>
												<td>Send</td>
												<td colspan="2">
													<input type="submit" class="inputbutton" style="height:auto;" value="서버로 전송"/>
												</td>
											</tr>
											-->
										</table>
										</form>
										<br/>
										<!-- MultiSignFileInfo END -->
										
										<!-- MultiSignFileInfoWithSerial START -->
										<h3 id="6">MultiSignFileInfoWithSerial</h3>
										<form id="form_MultiSignFileInfoWithSerial" name="form_MultiSignFileInfoWithSerial" method="post" action="./signfileinfo_server.jsp">
										<table class="test">
											<tr>
												<td width="50" rowspan="11">Input</td>
												<td width="120">XgateAddress</td>
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
												<td>aTotal</td>
												<td><input type="text" class="inputtext" name="aTotal"/></td>
											</tr>
											<tr>
												<td>aDelimiter</td>
												<td><input type="text" class="inputtext" name="aDelimiter"/></td>
											</tr>
											<tr>
												<td>aFileInfo</td>
												<td><textarea class="inputtextarea" name="aFileInfo" rows="3"></textarea></td>
											</tr>
											<tr>
												<td>aFileHash</td>
												<td><textarea class="inputtextarea" name="aFileHash" rows="3"></textarea></td>
											</tr>
											<tr>
												<td>aOption</td>
												<td style="text-align:left;">
													<input type="checkbox" class="inputcheck" name="aOption" value="0" checked disabled="true"/>
													0x00000000 : 기본 서명<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="1" />
													0x00000001 : 서명확인창을 보여준다.<br/>
													<input type="checkbox" class="inputcheck" name="aOption" value="256" />
													0x00000100 : 출력 값을 Base64로 <br/>
												</td>
											</tr>
											<tr>
												<td>aDescription</td>
												<td><input type="text" class="inputtext" name="aDescription"/></td>
											</tr>
											<tr>
												<td>aLimitPassword</td>
												<td><input type="text" class="inputtext" name="aLimitPassword"/></td>
											</tr>
											<tr>
												<td>Run</td>
												<td colspan="2">
													<input type="button" class="inputbutton" style="height:auto;" value="MultiSignFileInfoWithSerial"
													onClick="MultiSignFileInfoWithSerial (this.form.aXgateAddress.value,
																						  this.form.aCAList.value,
																						  this.form.aSerial.value,
																						  this.form.aLocation.value,
																						  this.form.aTotal.value,
																						  this.form.aDelimiter.value,
																						  this.form.aFileInfo.value,
																						  this.form.aFileHash.value,
																						  sumCheckbox (this.form.aOption),
																						  this.form.aDescription.value,
																						  this.form.aLimitPassword.value,
																						  MultiSignFileInfoWithSerial_callback);"/>
												</td>
											</tr>
											<tr>
												<td>Output</td>
												<td colspan="2">
													<textarea class="inputtextarea" name="aSignedMsg" rows="7"></textarea>
												</td>
											</tr>
											<!--
											<tr>
												<td>Send</td>
												<td colspan="2">
													<input type="submit" class="inputbutton" style="height:auto;" value="서버로 전송"/>
												</td>
											</tr>
											-->
										</table>
										</form>
										<br/>
										<!-- MultiSignFileInfoWithSerial END -->

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