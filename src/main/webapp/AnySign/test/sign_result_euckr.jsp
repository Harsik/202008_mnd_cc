<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page buffer="16kb" %>
<%@ page import="xecure.servlet.*" %>
<%@ page import="xecure.crypto.*" %>
<%@ page import="java.io.*" %>

<%
	XecureConfig aXecureConfig = new XecureConfig ();
	SignVerifier	verifier = null;

	StringBuffer	aResponse = new StringBuffer ();
%>

<%
	String sm = request.getParameter("SIGNED"); 
	String vm = request.getParameter("VID");

	if (sm != null && sm.substring(0, 4).equalsIgnoreCase("3082"))
	{
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
	}

	if (vm != null)
	{

		VidVerifier vid = new VidVerifier (aXecureConfig);
	
		vid.virtualIDVerifyS(vm, verifier.getSignerCertificate().getCertPem());
	
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

