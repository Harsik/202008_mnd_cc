<!DOCTYPE html>
<html>
<head>
<title>nexacro test</title>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="xecure.servlet.*" %>
<%@ page import="xecure.crypto.*" %>
<%@ page import="java.security.*" %>
<%@ page import="java.util.Random" %>
<script type="text/javascript">
document.write("<script type=\"text/javascript\" src=\"" + "../anySign4PCInterface.js" + "?version=" + new Date().getTime() + "\"></scr"+"ipt>");
</script>

<script language='javascript'>
<%
    VidVerifier vid = new VidVerifier(new XecureConfig());
    out.println(vid.ServerCertWriteScript());

	/* Make Hashed JSESSIONID */
	String HashedSessionID = "";
	
	MessageDigest md = MessageDigest.getInstance("SHA");
    String id = session.getId();

	byte[] bsid = id.getBytes("UTF-8");
	byte[] hashedid = md.digest(bsid);

	StringBuffer hexStringBuffer = new StringBuffer(hashedid.length*2);
	String hx;

	for (int i=0;i<hashedid.length;i++)
	{
		hx = Integer.toHexString(0xFF & hashedid[i]); if( hx.length() == 1 ) {hx = "0" + hx;}
		hexStringBuffer.append(hx);
	}

	HashedSessionID = hexStringBuffer.toString();

	hexStringBuffer.setLength(0);
	/* Make Hashed JSESSIONID */

	/* Make Integrity Check Random value */
	String HashedRandomValue = ""; 

	// 무결성 검증 랜덤값 생성을 위한 적용 페이지 고유 정보
	String anysign_random_value        = "reaver"; 
	String anysign_amount			   = "15.55";

	// Generate a random sequence number
	Random generator = new Random();
	int anysign_sequence = generator.nextInt(10000);

	// Generate the timestamp
	// Make sure this will be in UTC
	long anysign_timestamp = System.currentTimeMillis()/1000;

	// process the input string
	String inputstring = anysign_random_value + "^" + anysign_sequence + "^" +
	anysign_timestamp + "^" + anysign_amount + "^";

	String HashedRandomID = "";
	
	byte[] hashedrandom = md.digest(inputstring.getBytes());

	for (int i=0;i<hashedrandom.length;i++)
	{
		hx = Integer.toHexString(0xFF & hashedrandom[i]);
		if( hx.length() == 1 ) {hx = "0" + hx;}
		hexStringBuffer.append(hx);
	}

	HashedRandomValue = hexStringBuffer.toString();
	/* Make Integrity Check Random value */

	out.println("AnySign.mAnySignSID = '" + HashedSessionID + "';");


	// 데몬 무결성 검증 기능 선택사항
	// 1. 무결성 검증 비활성화
	//    AnySign.mAnySignITGT 변수 "" 설정
	//
	// 2. 웹 세션 기반 무결성 검증 설정
	//    AnySign.mAnySignITGT = HashedSessionID
	//
	// 3. 랜덤값 기반 무결성 검증 설정
	//    AnySign.mAnySignITGT = HashedRandomValue

	// use Hashed Sessionid 
	// 웹세션ID값을 기준으로 AnySign4PC 데몬 무결성 검증을 한다.
	//out.println("AnySign.mAnySignITGT = '" + HashedSessionID + "';");

	// use RandomValue
	// 랜덤값을 기준으로 AnySign4PC 데몬 무결성 검증을 한다.
	//out.println("AnySign.mAnySignITGT = '" + HashedRandomValue + "';");

	//out.println ("alert(\"start page = " + HashedRandomValue + "\");");
%>
function SignDataCMS_callback (result) {
	if (result)
		alert("서명완료");
}

function install_callback (result) {
	if (result == "ANYSIGN4PC_NEED_INSTALL")
	{
		window.open (AnySign.mPlatform.aInstallPage, '_self');
	}
	else if (result == "ANYSIGN4PC_NORMAL")
	{
		AnySign.SignDataCMS ("reaver.softforum.com:20443:20999",
							 "Root CA,XecurePKI51 ca,cn=CA131000010,pki50ca,pki70_test_CA,CA131000002Test,CA131000002,CA131000010,Softforum CA 3.0,SoftforumCA,yessignCA-OCSP,signGATE CA,signGATE CA4,SignKorea CA,SignKorea CA2,CrossCertCA,CrossCertCA2,CrossCertCA-Test2,3280TestCAServer,NCASignCA,TradeSignCA,TradeSignCA2,yessignCA-TEST,lotto test CA,NCATESTSign,SignGateFTCA,SignKorea Test CA,SignKorea Test CA2,TestTradeSignCA,Softforum Demo CA,mma ca,병무청 인증기관,MND CA,signGATE FTCA02,.ROOT.CA.KT.BCN.BU,CA974000001,setest CA,3280TestCAServer,yessignCA-Test Class 0,yessignCA-Test Class 1,yessignCA-Test Class 2,TradeSignCA2009Test2,yessignCA,yessignCA Class 1,CrossCertTestCA2,1024TestCA,CA130000031T,CA131000031T,CA131100001,CA134040001,Test1024CA,subca,subca_02",
							 "이 내용이 전자서명됩니다.",
							 512,
							 "",
							 "3",
							 SignDataCMS_callback);
	} else {
		alert("알수없는 에러");
	}
}

function init() {
	PrintObjectTag (true);
	AnySign4PC_installCheck (install_callback);	
}
</script>
</head>
<body>
<input type="button" style="width:100px" value="전자서명" onclick="init();">
</body>
