<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="xecure.servlet.*" %>
<%@ page import="xecure.crypto.*" %>
<%@ page import="xecure.crypto.jni.*" %>
<%@ page import="java.io.*" %>
<%
	int err = 0;
	String[] pemCerts = {};
	
	// 서명 대상 파일 경로
	String strOrgFile = "/signfileinfo/test.txt";
	
	// 1차 서명 파일을 저장할 경로
	String strSignFile = "/signfileinfo/test_1.sig";
	
	// 2차 서명 파일을 저장할 경로
	String strSignFile2 = "/signfileinfo/test_2.sig";
	
	// 2차 서명 인증서 정보
	File certpath = new File("/signfileinfo/cert/signCert.der");
	File keypath = new File("/signfileinfo/cert/signPri.key");
	String passwd = "qwer1234";
	
	String signedData = request.getParameter("aSignedMsg");
	String vidMsg = request.getParameter("aVidMsg");
	
	out.println("<h1>XecureWeb for Multi - SignFileInfo Test (Server)</h1>");
	
	//-----------------------------------------------------------------------------
	out.println("<h3>1. 클라이언트 서명값</h3>");
	if(signedData == null || signedData.length() == 0) {
		out.println("invalid request");
		return;
	}
	out.println("Client Signed Data: " + signedData + "<br>");
	//-----------------------------------------------------------------------------
	out.println("<h3>2. 기존 서명 파일 삭제</h3>");
	out.println("Delete File 1: " + strSignFile + "<br>");
	out.println("Delete File 2: " + strSignFile2 + "<br>");
	
	File f1 = new File(strSignFile);
	File f2 = new File(strSignFile2);
	f1.delete();
	f2.delete();
	//-----------------------------------------------------------------------------
	out.println("<h3>3. 서명값 + 원본 파일 병합</h3>");
	out.println("Original File Path: " + strOrgFile + "<br>");
	out.println("Merge File Path: " + strSignFile + "<br>");
	
	XecureConfig xconfig = new XecureConfig();
	
	SplitFileSign sfs = new SplitFileSign(xconfig);
	byte[] bytes = new java.math.BigInteger(signedData, 16).toByteArray();
	err = sfs.merge(strSignFile, strOrgFile, bytes, pemCerts);
	if (err != 0)
	{
		out.println("> SplitFileSign.merge error[" + sfs.getLastError() + "]");
		return;
	}
	out.println("> SplitFileSign.merge success<br>");
	//-----------------------------------------------------------------------------
	out.println("<h3>4. 병합된 서명 파일 검증</h3>");
	out.println("Merge File Path: " + strSignFile + "<br>");
	
	FileSignVerifier fsv = new FileSignVerifier(xconfig, strSignFile);
	if (fsv.getLastError() != 0)
	{
		out.println("> FileSignVerifier error[" + fsv.getLastError() + "][" + fsv.getLastErrorMsg() + "]");
		return;
	}
	out.println("> FileSignVerifier success<br>");
	//-----------------------------------------------------------------------------
	out.println("<h3>5. 식별번호 검증</h3>");	
	if(vidMsg == null || vidMsg.length() == 0) {
		out.println("> no input VID Data");
	}
	else
	{
		out.println("Client VID Data: " + vidMsg + "<br>");
			
		VidVerifier vv = new VidVerifier(xconfig);
		//vv.virtualIDVerifyS(vidMsg, fsv.getSignerCertificate().getCertPem(), "1111112222222"); // 서버측에서 식별번호 입력 시 사용
		vv.virtualIDVerifyS(vidMsg, fsv.getSignerCertificate().getCertPem());
		if (vv.getLastError() != 0)
		{
			out.println("> VidVerifier error[" + vv.getLastError() + "][" + vv.getLastErrorMsg() + "]");
			return;
		}
		out.println("> VidVerifier success<br>");	
	}
	//-----------------------------------------------------------------------------
	out.println("<h3>6. 서버에서 파일 서명 (2차 서명)</h3>");
	out.println("2nd Sign File path:" + strSignFile2 + "<br>");
	out.println("Cert File path:" + certpath + "<br>");
	out.println("Key File path:" + keypath + "<br>");
	out.println("Password:" + passwd + "<br>");
	
	if (!certpath.exists() || !keypath.exists())
	{
		out.println("> not exists Cert");
		return;
	}
	
	RandomAccessFile fcert = new RandomAccessFile(certpath, "r");
	byte[] bpem = new byte[(int)fcert.length()];
	fcert.read(bpem);
	fcert.close();
	
	RandomAccessFile fkey = new RandomAccessFile(keypath, "r");
	byte[] bkey = new byte[(int)fkey.length()];
	fkey.read(bkey);
	fkey.close();
	
	byte[] bpasswd = passwd.getBytes();
	
	FileSigner fs = new FileSigner(xconfig);
	err = fs.signFileAddWithKey(bpem, bkey, bpasswd, strSignFile, strSignFile2);
	if (err != 0)
	{
		out.println("> FileSigner.signFileAddWithKey error[" + fs.getLastError() + "]");
		return;
	}
	out.println("> FileSigner.signFileAddWithKey success");
	//-----------------------------------------------------------------------------
	out.println("<h3>7. 2차 서명 파일 검증</h3>");
	out.println("2nd Sign File path:" + strSignFile2 + "<br>");
	
	FileMultiSignVerifier fmsv = new FileMultiSignVerifier(xconfig, strSignFile2);
	if (fmsv.getLastError() != 0)
	{
		out.println("> FileMultiSignVerifier error[" + fmsv.getLastError() + "]");
		return;
	}
	out.println("> FileMultiSignVerifier success");
%>
