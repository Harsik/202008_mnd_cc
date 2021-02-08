<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page buffer="16kb" %>
<%
	request.setCharacterEncoding("utf-8");
	response.setContentType("text/html; charset=utf-8");
	
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
	
	String sign_result_page = "./sign_result.jsp";
%>
<%@ page import="xecure.servlet.*" %>
<%@ page import="xecure.crypto.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.security.*" %>
<%@ page import="java.util.Random" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<title>Page Title - 바닥페이지</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />

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

<script type="text/javascript">
document.write("<script type=\"text/javascript\" src=\"" + "../anySign4PCInterface.js" + "?version=" + new Date().getTime() + "\"></scr"+"ipt>");
</script>
<!-- TouchenKey / Transkey -->
<%@ include file="../transkey/includeKeyboardSecurity.jsp" %>

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
//PrintObjectTag(); 
</script>
<script language="javascript" type="text/javascript">
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

function onOKButton(e) {
	document.getElementById('signature_data').value = "";
	document.getElementById("xwup_OkButton").onclick();
}

function signResult_callback (aResult)
{
	document.getElementById('signature_data').value = aResult;
}

function loadingDone (aResultFunc)
{
	var aElement = document.getElementById("loadingAnySign");
	aElement.parentNode.removeChild (aElement);
	
	if (typeof aResultFunc == "function")
		aResultFunc (0);
}

function SignDataCMS ()
{
	var btnSignData = document.getElementById("btnSignDataCMS");
	btnSignData.disabled = true;
	
	if (AnySign.setAnySignLite())
		loadingDone ();
	else
		setExternal_callback (loadingDone);
	
	AnySign.mDivInsertOption = 1;
	AnySign.SetUITarget(document.getElementById('certDialog'));
	
	AnySign.SignDataCMS (AnySign.mXgateAddress, AnySign.mCAList, "hello", 0, "", AnySign.mLimitedTrial, signResult_callback);
}

function init () {
	checkCommonSetting();
	checkAnySign4PC();
	checkAnySignLite();
	checkXecureFreeSign();
	checkKeyboard();
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
}

function enableLanguage(element)
{
	AnySign.mLanguage = element.value;
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
		}
	}
	if (element.id == "Enable_XecureKeyPad") {
		AnySign.mXecureKeyPadEnable =! AnySign.mXecureKeyPadEnable;
		if (AnySign.mXecureKeyPadEnable) {
			AnySign.mTransKeyEnable = false;
			AnySign.mOpenkeyboardEnable = false;
			AnySign.mIncaNOSv10Enable = false;
		}
	}
	if (element.id == "Enable_Openkeyboard") {
		AnySign.mOpenkeyboardEnable =! AnySign.mOpenkeyboardEnable;
		if (AnySign.mOpenkeyboardEnable) {
			AnySign.mTransKeyEnable = false;
			AnySign.mXecureKeyPadEnable = false;
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
	document.getElementById("Enable_TouchEnKey").value = AnySign.mTouchEnKeyEnable;
	document.getElementById("Enable_KeyCryptHTLM5").value = AnySign.mKeyCryptHTML5Enable;
	document.getElementById("Enable_ASTx").value = AnySign.mASTxEnable;
	document.getElementById("Enable_TouchEnnxKey").value = AnySign.mTouchEnnxKeyEnable;
	document.getElementById("Enable_IncaNOSv10").value = AnySign.mIncaNOSv10Enable;
	document.getElementById("Enable_KOSKey").value = AnySign.mKOSKeyEnable;
	
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
	if (AnySign.mKeyCryptHTML5Enable || AnySign.mASTxEnable || AnySign.mTouchEnnxKeyEnable || AnySign.mIncaNOSv10Enable || AnySign.mKOSKeyEnable) {
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
function doneIncaNOSv10(aResult)
{
	document.getElementById("Enable_IncaNOSv10").style.fontWeight = "bold";
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
</script>
</head> 
<body onload="init();">
<table width="694" align='center' border="0" cellspacing="0" cellpadding="0">
<tr>
	<td>
		<form id="form_CommonSetting" name="form_CommonSetting">
		<table class="test">
			<tr>
				<td width="694" colspan="2"><h4>공통 설정</h4></td>
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
				<td width="84" rowspan="2">가상 키패드</td>
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
				<td rowspan="3">키보드 보안</td>
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
				<td>키보드 보안 + 가상 키패드</td>
				<td>nProtect Online Security V1.0<br>v1.0 (2015.12.23)</td>
				<td>
					<a href="../inca_nos10/nos_setup.exe">[설치파일]</a>
					<input id="Enable_IncaNOSv10" type="button" style="width:100%" onclick="enableSecureKey(this);">
				</td>
			</tr>
			<tr>
				<td>보안 토큰</td>
				<td>XecureHSM 1.1.0.0</td>
				<td>
					http://download.softforum.co.kr/Published/XecureHSM/xhsm_install.exe
					<a href="http://download.softforum.co.kr/Published/XecureHSM/xhsm_install.exe">[다운로드]</a>
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
		
		<h3 id="1">SignDataCMS</h3>
		<table class="test">
			<tr>
				<td width="694">
					<input id="btnSignDataCMS" type="button" class="inputbutton" style="height:auto;" value="AnySign.SignDataCMS"
					onClick="SignDataCMS()" />
				</td>
			</tr>
		</table>
		<br/>
		
	</td>
</tr>
</table>

<hr>

<table width="948px" align='center' border="0" cellspacing="0" cellpadding="0">
<tr>
	<td>
		<form id="form_SignDataCMS" name="form_SignDataCMS" method="post" action="#">
		<div id="certDialog"></div>
		<img id="loadingAnySign" src="../AnySign4PC/img/loader.gif">
		<br>
		<!-- result signature data -->
		<input type="button" value="OK" onclick="onOKButton(event);">
		<p>
		<textarea id="signature_data" style="width:940px;height:100px"></textarea>
		<br>
		<input type="button" value="서버에 확인" onclick="onSendToServer (document.getElementById('signature_data').value); return false;">
		</p>
		</form>
	</td>
</tr>
</table>
</body>
</html>
