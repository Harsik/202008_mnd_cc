<%@ page contentType="text/html; charset=utf-8" %>
<%@ page buffer="16kb" %>
<%@ page import="xecure.servlet.*" %>
<%@ page import="xecure.crypto.*" %>
<%@ page import="java.io.*" %>

<%
	String envData = request.getParameter("ENVDATA"); 
	
	XecureConfig aXecureConfig = new XecureConfig ();
	
	if (envData == null || envData.length() == 0)
	{
		out.println("invalid param");
		return;
	}
	
	if (envData.substring(0,1).equalsIgnoreCase("3") == false)
	{
		out.println("invalid param");
		return;
	}
	
	EnvelopeData ed = new EnvelopeData(aXecureConfig);
	String result = ed.deEnvelopeData(envData);
	
	if (ed.getLastError() == 0)
	{
		out.println(result);
	}
	else
	{
		out.println("Error:[" + ed.getLastError() + "]" + ed.getLastErrorMsg());
	}
%>
