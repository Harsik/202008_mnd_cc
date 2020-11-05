<%@ page import="java.util.*"%>
<%@ page import="com.ksign.access.sso.SSOConf"%>
<%@ page import="com.ksign.access.sso.sso10.SSO10Conf"%>
<%@ page import="com.ksign.access.api.*"%>
<%@ page import="java.io.*" %>

<%!
	public void sendAlert(HttpServletResponse resp, String alertMsg, String nextURI) throws IOException {
		alertMsg = alertMsg.replaceAll("\"", "\\\"");
		alertMsg = alertMsg.replaceAll("\r", "\\r");
		alertMsg = alertMsg.replaceAll("\n", "\\n");

		String msg = "<script language=\"javascript\">\r\n" + "  alert(\"" + alertMsg + "\");\r\n" + "  top.location.href = \"" + nextURI + "\";\r\n" +
    					"</script>\r\n";

		resp.setCharacterEncoding("MS949");
		// resp.setContentLength();

		PrintWriter out = resp.getWriter();
		out.println(msg);
		out.flush();
	}
%>
<%
	SSOService ssoService = SSOService.getInstance();
	SSORspData rspData = ssoService.ssoGetLoginData(request);
	
	String SSO_SERVER = ssoService.getServerScheme();
	String AGENT_ADDR = request.getScheme() + "://" + request.getServerName()+ ":" + request.getServerPort() + request.getContextPath();

	String AGENT_DEMO1 = "http://lemon.lipton.ice:8081/index.jsp";
	String AGENT_DEMO2 = "http://peach.lipton.ice:8082/index.jsp";
	
	String GID = ssoService.getGid();
	
	String mTokenUrl = SSO_SERVER + "/mobile-token-ctl.jsp?cmd=getTokenId&toGid=INSIDE_DW";

	String AGENT_VERSION = ssoService.getVersion();
    // -------------------------------------------------------------------------
    //  TODO : 로그인 URL 설정 - 응용 커스터 마이징 필요
    // -------------------------------------------------------------------------
    
	String reqCtx = request.getContextPath();
	String _loginURI = reqCtx + "/index.jsp";

	
	//-------------------------------------------------
	//  TODO: WAS 인증세션 검사 - 응용 커스터마이징 필요 <STEP.1>
	// -------------------------------------------------
	Object _uidObj = session.getAttribute("uid");
	if(_uidObj == null) {
		// =========================================================================
	    //  <STEP.2> SSO 인증토큰 획득
	    // =========================================================================
		rspData = ssoService.ssoGetLoginData(request);
		if(rspData != null && rspData.getResultCode() != -1) {
			_uidObj = rspData.getAttribute(SSO10Conf.UIDKey);
	
		// =========================================================================
		// WAS 인증세션 설정 : 토큰에 저장된 사용자 정보를 획득하여 설정
		//   - 응용 커스터마이징 필요
		// =========================================================================
			session.setAttribute("uid", _uidObj);		
		}
	}
    // ============================= SSO 설정 끝 =============================
    
    // -------------------------------------------------------------------------
    //  WAS 인증세션이 존재하지 않을경우 - index 페이지로 이동
    // -------------------------------------------------------------------------
    if(_uidObj == null) {
%>
<script language="javascript">
  	top.location.href = "<%=_loginURI%>";
</script>

<%
	return;
    }
%>
