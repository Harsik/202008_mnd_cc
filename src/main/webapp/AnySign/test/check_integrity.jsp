<%@ page contentType="text/html; charset=utf-8" %>
<%@ page buffer="16kb" %>
<%@ page import="xecure.servlet.*" %>
<%@ page import="xecure.crypto.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.security.*" %>
<%@ page import="javax.crypto.Mac" %>
<%@ page import="javax.crypto.SecretKey" %>
<%@ page import="javax.crypto.spec.SecretKeySpec" %>

<%
	XecureConfig aXecureConfig = new XecureConfig ();
	SignVerifier	verifier = null;

	StringBuffer	aResponse = new StringBuffer ();

	String sm = request.getParameter("SIGNED"); 
	String integrityValue = request.getParameter("ITGTVALUE");
	String DaemonPortNumber = request.getParameter("PORTVALUE");

	if (sm != null && sm.substring(0, 4).equalsIgnoreCase("3082"))
	{
		if (sm != null && sm.length() < 3100)
		{
			aResponse.append ("({");
			aResponse.append ("code:\"" + "-1000" + "\",");
			aResponse.append ("reason:\"" + "invalid parameter" + "\",");
			aResponse.append ("base:\"\"");
			aResponse.append ("})");
			out.println (aResponse.toString ());
			return;
		}
		/* Hex encoded Data */
		verifier = new SignVerifier (aXecureConfig , sm, 0);
	}
	else
	{
		/* Base64 encoded Data */
		verifier = new SignVerifier (aXecureConfig , sm, 1);
		System.out.println ("base64:" + sm);
	}

	aResponse.append ("({");
	aResponse.append ("code:\"" + verifier.getLastError () + "\",");
	aResponse.append ("reason:\"" + verifier.getLastErrorMsg () + "\",");

	if (verifier.getLastError() == 0)
	{
		aResponse.append ("plain:\"" + verifier.getVerifiedMsg_Text () + "\",");
		aResponse.append ("certificatePEM:\"" + verifier.getSignerCertificate().getCertPem ().replaceAll ("\n", "") + "\",");
		aResponse.append ("subjectRDN:\"" + verifier.getSignerCertificate().getSubject () + "\",");
	}
	else
	{
		aResponse.append ("base:\"\"");
		aResponse.append ("})");
		out.println (aResponse.toString ());
		return;
	}

	////////////////////////////////////////////////////////////////////////////////////
	// check integrity code start.
	
	int VerifyResult = verifier.verifyAnySignIntegrity(integrityValue,DaemonPortNumber);
	
	if (VerifyResult != 0)
	{
		// 무결성 검증 실패
		// 필요한 경우 현재 서버의 사용자 세션을 삭제하거나 서비스를 중단시키는 것을 권고한다.
		//
		// 서버 사용자 세션 중단코드 작성 공간
		// -------------------------------------
		//
		//
		//
		// -------------------------------------

		//out.println ("alert(\"Integrity Check Fail!!\");");
		aResponse.setLength(0);
		aResponse.append ("({");
		aResponse.append ("code:\"" + verifier.getLastError () + "\",");
		aResponse.append ("reason:\"" + verifier.getLastErrorMsg () + "\",");
		aResponse.append ("base:\"\"");
		aResponse.append ("})");
		out.println (aResponse.toString ());
		return;
	}
	else
	{
		//out.println ("alert(\"Integrity Check Success!!\");");
	}

	// check integrity finish.
	////////////////////////////////////////////////////////////////////////////////////

	aResponse.append ("base:\"\"");
	aResponse.append ("})");
	out.println (aResponse.toString ());
%>

