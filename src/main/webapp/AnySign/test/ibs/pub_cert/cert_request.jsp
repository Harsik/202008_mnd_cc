<%@ page contentType="text/html; charset=utf-8" %>
<%@ page buffer="16kb" %>
<%@ page import="xecure.servlet.*" %>
<%@ page import="xecure.crypto.*" %>
<%@ page import="java.io.*" %>

<form name='xecure'><input type=hidden name='p'></form>

<script type="text/javascript" src="../../../xecureweb_up.js"></script>

<script language='javascript'>
PrintObjectTag();
</script>

<%
	String account = request.getParameter("account");
	String ac_pwd = request.getParameter("ac_pwd");
	String pcard = request.getParameter("pcard");
	String operaterId = "internet";
	String user_policy_type = request.getParameter("user_policy_type") ; 
	String company_name = request.getParameter("company_name");
	String user_name = request.getParameter("user_name");
	user_name = new String(user_name.getBytes("ISO-8859-1"), "UTF-8");
	out.println( "user_name:" + user_name + "<BR/>");

	String euser_name = request.getParameter("euser_name");
	String user_id = request.getParameter("user_id");
	String ssn = request.getParameter("ssn");





	String policy_type ;
	String user_type;
/*
	if ( user_type.equals("1") ) {
		policy_type = "01";
		user_id = policy_type + ssn.charAt(5) + user_id;
	}
	else if(user_type.equals("2")) {
		policy_type = "02";
		user_id = policy_type + ssn.charAt(8) + user_id;
	}
	else	policy_type = "06";
*/

	user_type = user_policy_type.substring(0, 1);

	if( user_type.equals("1") ) {

		policy_type = user_policy_type.substring(1,3);
		user_id = policy_type + ssn.charAt(5) + user_id;


	}
	else if ( user_type.equals("2") ) {

		policy_type = user_policy_type.substring(1,3);
		user_id = policy_type + ssn.charAt(8) + user_id;

	}
	else
		policy_type = user_policy_type.substring(1,2);

	String email = request.getParameter("email");
	String cell_phone = request.getParameter("cell_phone");
	String fax = request.getParameter("fax");
	String zipcode = request.getParameter("zipcode");
	String address = request.getParameter("address");
	String phone = request.getParameter("phone");
	String czipcode = request.getParameter("czipcode");
	String caddress = request.getParameter("caddress");
	String cphone = request.getParameter("cphone");
	int	ra_result;
	
	XecureConfig xconf = new XecureConfig ();
	PublicRA sfra = new PublicRA (xconf);

	ra_result = sfra.registerNewUser ( operaterId, user_type, company_name, user_name, euser_name, user_id, 
				ssn, policy_type, email,cell_phone, fax, zipcode, address, phone,
                                czipcode, caddress, cphone );

%>

<html>
<head>
<title>사용자 등록 확인</title>
<%=policy_type%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><style type="text/css">
<!--
.font1 { font-size: 9pt;color:#666666;}
td {  font-size: 9pt;color:#333333}
A:link    {font-size:9pt;color:#010824;text-decoration:none; }
A:active  {font-size:9pt;color:#010824;text-decoration:none; }
A:visited {font-size:9pt;color:#010824;text-decoration:none; }
A:hover   {font-size:9pt;color:#0066cc;text-decoration:none; }
-->
</style>

<script type="text/javascript" src="../../../transkey/BigInt.js"></script>
<script type="text/javascript" src="../../../transkey/Barrett.js"></script>
<script type="text/javascript" src="../../../transkey/RSA.js"></script>
<script type="text/javascript" src="../../../transkey/wz_jsgraphics.js"></script>
<script type="text/javascript" src="../../../transkey/transkey_XC.js"></script>
<script type="text/javascript" src="../../../transkey/seed.js"></script>
<script type="text/javascript" src="../../../transkey/genkey.js"></script>

</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">


<script language='javascript'>
function cert_request ()
{
	var aForm = document.getElementById ("auth");
	
	RequestCertificate ("10",
						aForm.ref_code.value,
						aForm.auth_code.value,
						cert_request_callback);
}

function cert_request_callback (aResult)
{
	if (aResult == 0)
	{
		alert ("금융 결제원 공인인증기관으로 부터 인증서를 발급 받았습니다.");
	}
}
</script>


<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
  <tr> 
    <td colspan="2" valign="top"> 
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <table width="92%" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr> 
          <td rowspan="2" valign="top"> 
            <table width="106" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="91"><img src="../../../img/img_main_web05.gif" width="91" height="110"></td>
                <td width="14">&nbsp;</td>
                <td width="1"><img src="../../../jsp/img/dot_gray01.gif" width="1" height="100%"></td>
              </tr>
              <tr> 
                <td width="91">&nbsp;</td>
                <td width="11">&nbsp;</td>
                <td width="1"><img src="../../../jsp/img/line_gray.gif" width="1" height="129"></td>
              </tr>
            </table>
          </td>
          <td valign="top" width="845"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="2%" height="30"></td>
                <td height="34"><img src="../../../img/img_main_web04.gif" width="240" height="15"></td>
              </tr>
              <tr> 
                <td colspan="2"><img src="../../../jsp/img/dot_gray01.gif" width="100%" height="1"></td>
              </tr>
              <tr> 
                <td>&nbsp;</td>
                <td align="right">
                  <table width="25%" height=20 border="0" cellpadding="0" cellspacing="0">
                    <tr>
                      <td width="50%">
                        <div align="center"><a href="../../index.html">TOP 메뉴</a></div>
                      </td>
                      <td width="50%">
                        <div align="center"><a href="cert_main.jsp" onClick="return XecureLink(this);">이전메뉴</a></div>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td valign="top"> 
            <table width="85%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td height="100" width="8%">&nbsp;</td>
                <td height="120" valign="middle"> 
                  <p align="center"><font size="6" face="Times New Roman, Times, serif">사용자 
                    등록 확인</font></p>
                </td>
              </tr>
              <tr> 
                <td>&nbsp;</td>
                <td valign="top"> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td width="2%" height="24" bgcolor="#DEDBCB">&nbsp;</td>
                      <td width="2%" height="24" bgcolor="#DEDBCB">&nbsp;</td>
                      <td height="24" bgcolor="#DEDBCB">&nbsp;</td>
                    </tr>
                    <tr> 
                      <td colspan="3" height="24"> 
                        <div align="center">
                          <p>&nbsp;</p>
						  
<%
	if ( ra_result == 0 ) {
%> 

<table>
<tr><td>사용자</td><td><%=user_name%></td></tr>
<tr><td>계좌번호</td><td><%=account%></td></tr>
<tr><td>등록일</td><td><%=sfra.getResponseFromRegUser("REGDATE")%></td></tr>
<tr><td>등록번호</td><td><%=sfra.getResponseFromRegUser("REGSERIAL")%></td></tr>
<tr><td>사용자 ID</td><td><%=sfra.getResponseFromRegUser("USERID")%></td></tr>
<tr><td>주민등록번호</td><td><%=sfra.getResponseFromRegUser("SSN")%></td></tr>
<tr><td>참조코드</td><td><%=sfra.getResponseFromRegUser("REFCODE")%></td></tr>
<tr><td>인가코드</td><td><%=sfra.getResponseFromRegUser("AUTHCODE")%></td></tr>
<tr><td>인증정책식별코드</td><td><%=sfra.getResponseFromRegUser("POLICYTYPE")%></td></tr>
<tr><td>최상위인증기관 해쉬값</td><td><%=sfra.getResponseFromRegUser("ROOTHASH")%></td></tr>
</table>
<br>
<%=request.getParameter("user_name")%>'님의 사용자 정보가 금융결제원 인증기관에 등록 되었습니다. <br>
<br>
  이제 '확인' 버튼을 누르시면 금융결제원 공인인증기관으로 부터 인증서를 발급받을 수 있습니다.
<p><font color="#000000" size="5"> </font> </p>
<form name='auth' id="auth" onSubmit='return false;'>
<input type=hidden name='ref_code' value='<%=sfra.getResponseFromRegUser("REFCODE")%>'>
<input type=hidden name='auth_code' value='<%=sfra.getResponseFromRegUser("AUTHCODE")%>'>
<input type=image src="../../../image/button_ok.jpg" width="90" height="24" border="0" onClick="cert_request ()";>
</form>
<%	}
	else {
%>
<p>		사용자 등록에 실패했습니다.</p>
에러 코드 : <%=sfra.getLastError()%><br>
에러 메시지 : <%=sfra.getLastErrorMsg()%><br>
<%=xconf.getRaHost() + xconf.getRaPort()%>
<%	}
%> 

                        </div>
                      </td>
                    </tr>
                    <tr> 
                      <td width="2%">&nbsp;</td>
                      <td width="2%" valign="top">&nbsp;</td>
                      <td> 
                        <p>&nbsp;</p>
                      </td>
                    </tr>
                    <tr> 
                      <td width="2%" height="24" bgcolor="#DEDBCB">&nbsp;</td>
                      <td width="2%" height="24" bgcolor="#DEDBCB">&nbsp;</td>
                      <td height="24" bgcolor="#DEDBCB">&nbsp;</td>
                    </tr>
                    <tr> 
                      <td width="2%">&nbsp;</td>
                      <td valign="top" width="2%">&nbsp;</td>
                      <td> 
                        <p>&nbsp; </p>
                      </td>
                    </tr>
                    <tr> 
                      <td width="2%">&nbsp;</td>
                      <td width="2%">&nbsp;</td>
                      <td>&nbsp;</td>
                    </tr>
                    <tr> 
                      <td width="2%">&nbsp;</td>
                      <td width="2%">&nbsp;</td>
                      <td>&nbsp;</td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr> 
                <td height="40">&nbsp;</td>
                <td height="40">&nbsp;</td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td height="24" bgcolor="#345B87"> 
      <div align="right"><font color="#FFFFFF"><b><font color="#CED2DB"><a href="http://www.softforum.com"><font color="#FFFFFF">www.softforum.com</font></a></font></b></font></div>
    </td>
    <td height="24" bgcolor="#345B87" width="3%">&nbsp;</td>
  </tr>
</table>
</body>
</html>
