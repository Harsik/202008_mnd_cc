<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page buffer="16kb" %>
<%@ page import="xecure.servlet.*" %>
<%@ page import="xecure.file.*" %>
<%@ page import="xecure.crypto.*" %>
<%@ page import="java.io.*" %>


<%

session.setAttribute("session1", "s1_value");
session.setAttribute("session2", "s2_value");


String aUploadDirectory = "/FileStore/";

try {
	
	XecureFileInputStream file;
	XecureServlet xservlet = new XecureServlet(request, response);

	file = new XecureFileInputStream(xservlet.getXecureSession(), xservlet.request);
	file.saveFileAt(aUploadDirectory);
	
	out.print ("OK");
}
catch(XecureServletConfigException e) {
	out.print ("SFE20");
}
catch(XecureServletException e) {
	out.print ("SFE21");
}
catch(IOException e) {
	out.print ("SFE22");
}
catch(Exception e) {
	out.print ("SFE23");
}
%>
