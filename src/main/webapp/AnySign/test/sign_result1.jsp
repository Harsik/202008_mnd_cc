<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ page buffer="16kb" %>
<%@ page import="xecure.servlet.*" %>
<%@ page import="xecure.crypto.*" %>
<%@ page import="java.io.*" %>
<%
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
			aCertificate = verifier.getSignerCertificate().getCertPem().replaceAll ("\n", "");
			aSubjectRDN = verifier.getSignerCertificate().getSubject();
			
			byte[] buf = verifier.getVerifiedMsg();
			
			if(buf != null){
				String tmp = "";
				
				for (int i = 0; i < buf.length; i++)
				{
					tmp = Integer.toHexString(0xFF & buf[i]);
					if (tmp.length() == 1) tmp = "0" + tmp;
					aPlainHex += tmp;
				}
			}
			
		}

	}
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="cache-control" content="no-cache">
</head>
<script type="text/javascript"	src="../../js/jquery-1.7.1.min.js"></script>  
<script>
	var orignlMdcd = "<%=request.getParameter("mdcd")%>";
	var resultCode = "<%=aErrCode%>";
		$(document).ready(function(){
			if(resultCode == "0") {
				console.log("PKI 인증 성공");
				var rdn = "<%=aSubjectRDN%>";
				$.ajax({   
					url:"/intra/loginPAjax.do",
					type:"post",
					dataType:'json',
					data:{
						"initId"  : rdn,
						"mdcd" : orignlMdcd,
						"logYn"	: "Y"
					},
					success:function(data) {
						
						if(data.code == '0'){
							location.href = "/intra/main.do";
						}else {
							//alert(data.msg);
							alert("인증서 정보가 올바르지 않습니다.\n포탈에서 로그인 해주세요.");
							location.href = "/intra/login.do";
						}
						
					},error : function(data, status, err) 
					{
						alert("PKI LOGIN ERROR!!!");
						location.href = "/intra/login.do";
					}
				}); 
			}else{
				alert("인증서 정보가 올바르지 않습니다.\n포탈에서 로그인 해주세요.");
				location.href = "/intra/login.do";
			}
			 
		});
	</script>
</body>
</html>
