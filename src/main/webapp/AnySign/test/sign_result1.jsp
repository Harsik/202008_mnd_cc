<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ page buffer="16kb" %>
<%@ page import="xecure.servlet.*" %>
<%@ page import="xecure.crypto.*" %>
<%@ page import="java.io.*" %>
<%
	//out.println(java.nio.charset.Charset.defaultCharset().name());
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8");
	String aCharset = "UTF-8";
	
	XecureConfig aXecureConfig = new XecureConfig ();
	SignVerifier	verifier = null;

	String aResult = request.getParameter("aResult");
	int aErrCode = 0;
	String aErrReason = "";
	String aPlain = "";
	String aPlainHex = "";
	String aCertificate = "";
	String aSubjectRDN = "";
		
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
		aSignedData = aSplitSign.merge(aResult, aPlainByte);
		if (aSplitSign.getLastError() != 0)
		{
			aErrCode = aSplitSign.getLastError();
			aErrReason = aSplitSign.getLastErrorMsg();
			out.println ("분리 서명 데이터 오류<br>");
			out.println ("Error Code: " + aErrCode + "<br>");
			out.println ("Error Reason: " + aErrReason + "<br>");
			return;
		}
		
		aResult = aSignedData;
	}
	
	if (aResult == null || aResult.equals(""))
	{
		aErrCode = -1;
		aErrReason = "invalid parameter";
	}
	else if (aResult.length() < 10)
	{
		aErrCode = -1;
		aErrReason = "invalid parameter (short)";
	}
	else
	{
		if (aResult.substring(0, 4).equalsIgnoreCase("3082"))
		{
			/* Hex encoded Data */
			verifier = new SignVerifier (aXecureConfig , aResult, aCharset, 0);
		}
		else
		{
			/* Base64 encoded Data */
			verifier = new SignVerifier (aXecureConfig , aResult, aCharset, 1);
		}

		if (verifier.getLastError() != 0)
		{
			aErrCode = verifier.getLastError();
			aErrReason = verifier.getLastErrorMsg();
		}
		else
		{
			aPlain = verifier.getVerifiedMsg_Text();
			System.out.println(aPlain);
			aCertificate = verifier.getSignerCertificate().getCertPem().replaceAll ("\n", "");
			System.out.println(aCertificate);
			aSubjectRDN = verifier.getSignerCertificate().getSubject();
			System.out.println(aSubjectRDN);
			
			byte[] buf = verifier.getVerifiedMsg();
			String tmp = "";
			
			for (int i = 0; i < buf.length; i++)
			{
				tmp = Integer.toHexString(0xFF & buf[i]);
				if (tmp.length() == 1) tmp = "0" + tmp;
				aPlainHex += tmp;
			}
			
			
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
	<li>오류 코드: <%=aErrCode%>
	<li>오류 메세지: <%=aErrReason%>
	<li>서명 원문: <%=aPlain%>
	<li>서명 원문(Hex): <%=aPlainHex%>
	<li>서명 인증서 주체: <%=aSubjectRDN%>
	<li>서명 인증서: <div><textarea cols="100" rows="10"><%=aCertificate%></textarea></div>
	<script type="text/javascript"	src="../../js/jquery-1.7.1.min.js"></script>  
	<script>
	var resultCode = "<%=aErrCode%>";
		$(document).ready(function(){
			if(resultCode == "0") {
				console.log("PKI 인증 성공");
				var rdn = "<%=aSubjectRDN%>";
// 				rdn = "cn=박준배(012914)"
				var str = rdn.split(",")[0];
				var mySubString = str.substring(
				    str.lastIndexOf("(") + 1, 
				    str.lastIndexOf(")")
				);
				var id = mySubString;
				console.log(mySubString);
				$.ajax({   
					url:"/intra/loginPAjax.do",
					type:"post",
					dataType:'json',
					data:{
						"user_id" : id
					},
					success:function(data) {
						if(data.code == '0'){
							$.ajax({   
								url:"/intra/loginUAjax.do",
								type:"post",
								dataType:'json',
								data:{
									"id" : "m"+data.user_id
								},
								success:function(data) {
									if(data.code == '0'){
										location.href = "/intra/main.do";
									}else {
										alert(data.msg);
									}
								}
							}); 
						}else {
							alert(data.msg);
						}
					}
				}); 
			}else{
				alert("PKI SERVER ERROR");
			}
			 
		});
	</script>
</ul>
</body>
</html>
