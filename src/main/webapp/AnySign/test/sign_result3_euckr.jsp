<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%> 
<%@ page buffer="16kb" %>
<%@ page import="xecure.servlet.*" %>
<%@ page import="xecure.crypto.*" %>
<%@ page import="java.io.*" %>
<%
	//out.println(java.nio.charset.Charset.defaultCharset().name());
	request.setCharacterEncoding("euc-kr");
	response.setContentType("text/html; charset=euc-kr");
	String aCharset = "euc-kr";
	
	XecureConfig aXecureConfig = new XecureConfig ();
	MultiSignVerifier verifier = null;
	
	String aSignedMsg1 = request.getParameter("aResult");
	String aSignedMsg2 = request.getParameter("aResult2");
	String aSignedMsg = request.getParameter("aSignedMsg");
	int aErrCode = 0;
	String aErrReason = "";
	String aPlain = "";
	String aPlainHex = "";
	String aCertificate = "";
	String aSubjectRDN = "";
	int aSignerNum = 0;
	
	if (aSignedMsg1 != null && aSignedMsg1.length() > 0)
	{
		aSignedMsg = aSignedMsg1;
	}
	else if (aSignedMsg2 != null && aSignedMsg2.length() > 0)
	{
		aSignedMsg = aSignedMsg2;
	}
		
	SplitSign aSplitSign = new SplitSign(aXecureConfig);
	String aRequestPlain = request.getParameter("aPlain");	
	byte[] aPlainByte = null;
	String aSignedData = "";
		
	String[] aOptions = request.getParameterValues("aOption");	
	int aOption = 0;
	for (int i = 0; aOptions !=null && i < aOptions.length; i++)
	{
		aOption += Integer.parseInt(aOptions[i]);
	}
	
	/* 분리 서명 검증 시 */
	if ((aOption & 0x100) == 0 && (aOption & 0x200) == 0x200 && (aOption & 0x1000) == 0x1000)
	{
		aPlainByte = aRequestPlain.getBytes(aCharset);
		aSignedData = aSplitSign.merge(aSignedMsg, aPlainByte);
		if (aSplitSign.getLastError() != 0)
		{
			aErrCode = aSplitSign.getLastError();
			aErrReason = aSplitSign.getLastErrorMsg();
			out.println ("분리 서명 데이터 오류<br>");
			out.println ("Error Code: " + aErrCode + "<br>");
			out.println ("Error Reason: " + aErrReason + "<br>");
			return;
		}
		
		aSignedMsg = aSignedData;
	}
	
	if (aSignedMsg == null || aSignedMsg.equals(""))
	{
		aErrCode = -1;
		aErrReason = "invalid parameter";
	}
	else if (aSignedMsg.length() < 10)
	{
		aErrCode = -1;
		aErrReason = "invalid parameter (short)";
	}
	else
	{
		if (aSignedMsg.substring(0, 4).equalsIgnoreCase("3082"))
		{
			/* Hex encoded Data */
			verifier = new MultiSignVerifier (aXecureConfig , aSignedMsg, aCharset);
		}
		else
		{
			/* Base64 encoded Data */
			verifier = new MultiSignVerifier (aXecureConfig , aSignedMsg, aCharset);
		}

		if (verifier.getLastError() != 0)
		{
			aErrCode = verifier.getLastError();
			aErrReason = verifier.getLastErrorMsg();
		}
		else
		{
			// 서명 원문
			aPlain = verifier.getVerifiedMsg_Text();
			
			// 서명 원문(Hex)
			byte[] buf = verifier.getVerifiedMsg();
			String tmp = "";
			for (int i = 0; i < buf.length; i++)
			{
				tmp = Integer.toHexString(0xFF & buf[i]);
				if (tmp.length() == 1) tmp = "0" + tmp;
				aPlainHex += tmp;
			}
			
			// 서명 인증서
			aSignerNum = verifier.getNumberOfSigner();
		}

	}
	
	/* 식별번호 검증 */
	VidVerifier vid = null;
	
	String aVidMsg = request.getParameter("aVidMsg");
	String aServerIdn = request.getParameter("aServerIdn");
	int aIsVid = 0;
	int aVidErrCode = 0;
	String aVidErrReason = "";
	int aVidCertNum = 0;
	String aVidCertSubjectRDN = "";
	String aIdn = "";
	String aRealName = "";
	
	if (aVidMsg != null && aVidMsg.length() > 0 && aSignerNum > 0)
	{
		aIsVid = 1;
		vid = new VidVerifier(aXecureConfig);
		
		for (int i = 0; i < aSignerNum; i++)
		{
			if (aServerIdn != null && aServerIdn.length() > 0)
			{
				// 서버측에서 식별번호 입력 시 사용
				vid.virtualIDVerifyS(aVidMsg, verifier.getSignerCertificate(i).getCertPem(), aServerIdn);
				aIdn = "(서버에서 입력)";
			}
			else
			{
				vid.virtualIDVerifyS(aVidMsg, verifier.getSignerCertificate(i).getCertPem());
			}
			
			if (vid.getLastError() == 0)
			{
				aVidCertNum = i;
				aVidCertSubjectRDN = verifier.getSignerCertificate(i).getSubject();
				aIdn += vid.getIdn();
				aRealName = vid.getRealName();
				break;
			}
		}
		
		if (vid.getLastError() != 0)
		{
			aVidErrCode = vid.getLastError();
			aVidErrReason = vid.getLastErrorMsg();
		}
	}
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="cache-control" content="no-cache">
</head>
<body>
<h3>서명값 검증 결과</h3>
<ul>
	<li>서명값: <div><textarea cols="100" rows="10"><%=aSignedMsg%></textarea></div>
	<li>오류 코드: <%=aErrCode%>
	<li>오류 메세지: <%=aErrReason%>
	<li>서명 원문: <%=aPlain%>
	<li>서명 원문(Hex): <%=aPlainHex%>
	<li>서명자 수: <%=aSignerNum%>
<%
	for (int i = 0; i < aSignerNum; i++)
	{
		aCertificate = verifier.getSignerCertificate(i).getCertPem().replaceAll ("\n", "");
		aSubjectRDN = verifier.getSignerCertificate(i).getSubject();
%>
	<li>서명 인증서 [<%=i+1%>]: <%=aSubjectRDN%>
	<div><textarea cols="100" rows="10"><%=aCertificate%></textarea></div>
<%
	}
%>
</ul>
<%
	if (aIsVid == 1) {
%>
<h3>식별번호 검증 결과</h3>
<ul>
	<li>암호화된 VID: <div><textarea cols="100" rows="10"><%=aVidMsg%></textarea></div>
	<li>오류 코드: <%=aVidErrCode%>
	<li>오류 메세지: <%=aVidErrReason%>
	<li>인증서 [<%=aVidCertNum+1%>]: <%=aVidCertSubjectRDN%>
	<li>주민등록번호(사업자 등록번호):  <%=aIdn%>
	<li>사용자 실명: <%=aRealName%>
</ul>
<%	
	}
%>
</body>
</html>