<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="com.ksign.access.wrapper.api.*" %>
<%@ page import="com.ksign.access.wrapper.sso.SSOConf" %>
<%@ page import="com.ksign.access.wrapper.sso.sso10.SSO10Conf" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%!
    // -------------------------------------------------------------------------
    //  [��ƿ] �α��� ���� �߻� ��, alert() ��� �� ���� �������� �̵��ϴ� �޼ҵ�
    // -------------------------------------------------------------------------
    public void sendAlert(HttpServletResponse resp, String alertMsg, String nextURI) throws IOException {

        alertMsg = alertMsg.replaceAll("\"", "\\\"");
        alertMsg = alertMsg.replaceAll("\r", "\\r");
        alertMsg = alertMsg.replaceAll("\n", "\\n");

        String msg = 
            "<script language=\"javascript\">\r\n" +
            "  alert(\"" + alertMsg + "\");\r\n" +
            "  top.location.href = \"" + nextURI + "\";\r\n" +
            "</script>\r\n";

        resp.setCharacterEncoding("MS949");
        // resp.setContentLength();

        PrintWriter out = resp.getWriter();
        out.println(msg);
        out.flush();
    }
%>
<%
	// =========================================================================
	//  <AP.1> SSO ���� ��ü ȹ��
 	// =========================================================================
	SSORspData rspData = null;
	SSOService ssoService = SSOService.getInstance();
	
	// =========================================================================
    //  <AP.2> SSO ������ū ȹ��
    // =========================================================================
        
    	rspData = ssoService.ssoGetLoginData(request);
	if(rspData == null || rspData.getResultCode() == -1) {
		// TODO : ������������ or index.jsp �������� �̵�
		String alertMsg = "����� ������ū ȹ�濡 �����Ͽ����ϴ�. �ʱ� ������������ �̵��մϴ�.";
		String nextURI = "../index.jsp";
		sendAlert(response, alertMsg, nextURI);
		return;
	}
	// end: added
		
	// =========================================================================
    //  [AP.3] WAS �������� ���� - ���� Ŀ���͸���¡ �ʿ�
    // =========================================================================
	//String uid = rspData.getAttribute("KSIGN_FED_USER_ID");
	String uid = rspData.getAttribute(SSO10Conf.UIDKey);
	if(uid == null) {
		uid = rspData.getAttribute("UID");
	}

	String simpyoungwon = SeedCrypto.encrypt(rspData.getAttribute("UID"), null);
	SeedCrypto.decrypt(simpyoungwon, null);
	if(uid != null) {
		session.setAttribute("uid", uid);
	}

	String expireMsg = request.getParameter("expire");
	if(expireMsg != null) {
		session.setAttribute("expire.date", expireMsg);
	}
	//...
	
	// =========================================================================
    //  [AP.4] ���� ������ ���� URL�� �̵�
    // =========================================================================
	String retURL = (String)request.getParameter("returnurl");	
    	if(retURL == null){
		// TODO : ������������ or index.jsp �������� �̵�
		
		String encReturnURL = (String) request.getParameter("encreturnurl");
		encReturnURL = ssoService.decryptURL(encReturnURL);
		
		
		if(encReturnURL == null) {
			String alertMsg = "���� URL ȹ�濡 �����Ͽ����ϴ�. �ʱ� ������������ �̵��մϴ�.";
			String nextURI = "../index.jsp";
			sendAlert(response, alertMsg, nextURI);
			return;	
		} else {
			retURL = encReturnURL;
		}
		
			
	}
    
	String requestMethod;
	String paramKey, paramValue;
	HashMap params = (HashMap) session.getAttribute("KSIGN_REQ_PARAM");
	
	StringBuffer paramSB = new StringBuffer();
	if(params != null && !params.isEmpty()) {
		requestMethod = (String) params.get("KSIGN_REQ_METHOD");
		if(requestMethod != null && requestMethod.equalsIgnoreCase("post")) {
			params.remove("KSIGN_REQ_METHOD");
			Set keys = params.keySet();
			java.util.Iterator iKeys = keys.iterator();
			
			for(int i = 0 ; i < params.size() ; i ++){
			 	paramKey = (String) iKeys.next();
				paramValue = (String) params.get(paramKey);
				paramSB.append(java.net.URLEncoder.encode(paramKey)).append("=").append(java.net.URLEncoder.encode(paramValue)).append("&");
			}
		
			if(retURL.indexOf("?") != -1) {
				retURL = retURL + "&" + paramSB.toString();
			} else {
				retURL = retURL + "?" + paramSB.toString();
			}
		}
	} 
/*    
	StringBuffer sb = new StringBuffer();

	for( java.util.Enumeration en = request.getParameterNames(); en.hasMoreElements(); ) {
		String key = (String) en.nextElement();
		if(key.startsWith("returnurl")) continue;
		sb.append(key).append("=").append(java.net.URLEncoder.encode(request.getParameter(key))).append("&");
	}

    response.sendRedirect(retURL + "&" + sb.toString());
	*/
	
	
response.sendRedirect(retURL);
    if(true) return;	
%>
