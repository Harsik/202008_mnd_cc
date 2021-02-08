<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page buffer="16kb" %>
<%@ page import="xecure.servlet.*" %>
<%@ page import="xecure.file.*" %>
<%@ page import="xecure.crypto.*" %>
<%@ page import="java.io.*" %>

<%
try{

//////////////////////////////////////////////////////////////////////////
//tomcat

//	out.clear();
//	out = pageContext.pushBody();
	
	
	XecureServlet xservlet = new XecureServlet(request, response);
	// tomcat, 기타 WAS
	XecureFileOutputStream file;
	file = new XecureFileOutputStream(xservlet.getXecureSession(),
	                                  xservlet.request,
	                                  xservlet.response,
	                                  response.getOutputStream());
	// jeus
	/*
	 XecureFilePrintWriter file;
	 file = new XecureFilePrintWriter(xservlet.getXecureSession(),
									  xservlet.request,
									  xservlet.response,
									  response.getWriter());
									  */
									  
	String filePATH = "/FileStore/" + xservlet.request.getParameter("filename");
	
	file.flush();
	//file.fileDownload();
	file.fileDownload(filePATH);
}
catch(FileNotFoundException e) {
	out.print ("SFE123");
	System.out.println("FileNotFoundException");
}
catch(IOException e) {
	out.print ("SFE123");
	System.out.println("IOException");
}
catch(XecureServletConfigException e) {
	out.print ("SFE123");
	System.out.println("XecureServletConfigException");
}
catch(XecureServletException e) {
	out.print ("SFE123");
	System.out.println("XecureServletException");
}

%>
