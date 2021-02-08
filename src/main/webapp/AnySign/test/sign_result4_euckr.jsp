<%@ page contentType="text/html; charset=euc-kr" %>
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
	MultiSignVerifier	verifier = null;

	StringBuffer	aResponse = new StringBuffer ();
%>

<%
	String sm = request.getParameter("SIGNED"); 
	String vm = request.getParameter("VID");

	verifier = new MultiSignVerifier (aXecureConfig , sm, aCharset);

	aResponse.append ("({");
	aResponse.append ("code:\"" + verifier.getLastError () + "\",");
	aResponse.append ("reason:\"" + verifier.getLastErrorMsg () + "\",");

	if (verifier.getLastError() == 0)
	{
		aResponse.append ("plain:\"" + verifier.getVerifiedMsg_Text () + "\",");
		aResponse.append ("certificatePEM:\"" + verifier.getSignerCertificate(0).getCertPem ().replaceAll ("\n", "") + "\",");
		aResponse.append ("subjectRDN:\"" + verifier.getSignerCertificate(0).getSubject () + "\",");
	}
	else
	{
	}

	if (vm != null)
	{

		VidVerifier vid = new VidVerifier (aXecureConfig);
	
		vid.virtualIDVerifyS(vm, verifier.getSignerCertificate(0).getCertPem());
	
		aResponse.append ("vidCode:\"" + vid.getLastError () + "\",");
		aResponse.append ("vidReason:\"" + vid.getLastErrorMsg () + "\",");

		if( vid.getLastError () == 0) {
			aResponse.append ("vidIDNumber:\"" + vid.getIdn () + "\",");
			aResponse.append ("vidRealName:\"" + vid.getRealName () + "\",");
		}
	}

	aResponse.append ("base:\"\"");
	aResponse.append ("})");
	out.println (aResponse.toString ());
%>
