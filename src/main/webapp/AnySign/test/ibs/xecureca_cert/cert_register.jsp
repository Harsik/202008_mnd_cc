<%@ page contentType="text/html; charset=utf-8" %>
<%@ page buffer="16kb" %>
<%@ page import="xecure.servlet.*" %>
<%@ page import="xecure.crypto.*" %>
<%@ page import="java.io.*" %>

<form name='xecure'><input type=hidden name='p'></form>

<script type="text/javascript" src="../../../xecureweb_up.js"></script>
<script>
PrintObjectTag();
</script>
<html>
<head>
<title>인증서 발급</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">
<!--
.font1 { font-size: 9pt;color:#666666;}
td {  font-size: 9pt;color:#333333}
A:link    {font-size:9pt;color:#010824;text-decoration:none; }
A:active  {font-size:9pt;color:#010824;text-decoration:none; }
A:visited {font-size:9pt;color:#010824;text-decoration:none; }
A:hover   {font-size:9pt;color:#0066cc;text-decoration:none; }
-->
</style>
</head>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

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
                <td height="40" width="8%">&nbsp;</td>
                <td height="40" valign="middle"> 
                  <p align="center"><font size="4" face="Times New Roman, Times, serif">인증서 발급 
                  </font></p>
                </td>
              </tr>
              <tr> 
                <td>&nbsp;</td>
                <td valign="top"> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td width="2%" height="24" bgcolor="#DEDBCB">&nbsp;</td>
                      <td width="2%" height="24" bgcolor="#DEDBCB">&nbsp;</td>
                      <td height="24" bgcolor="#DEDBCB">
                        <p><b>이 페이지는 Xecure 인증기관에 사용자를 등록하고 작업을 수행합니다. 반드시 운영시스템에서는 
                          이 페이지를 웹상에서 제거하고 절대 운영시스템에서는 수행하지 마십시요. </b><b>사용자 확인을 
                          위해서 아래의 정보를 입력해 주십시요.</b></p>
                        </td>
                    </tr>
                    <tr> 
                      <td colspan="3" height="24"> 
<br>

<script language="javascript">
<!--
		function getNow()		{
			var year;
			var month;
			var day;
			var hour;
			var minute;
			var second;
			var ret_Time = "";

			var date = new Date();

			year = date.getFullYear();
			month = date.getMonth();
			day = date.getDate();
			
			hour = date.getHours();
			minute = date.getMinutes();
			second = date.getSeconds();

			if( month == 0 ) month++;
			if( month < 10 ) month = "0" + month;
			if( day < 10 ) day ="0" + day;
			
			if( hour < 10 ) hour = "0" + hour;
			if( minute < 10 ) minute = "0" + minute;

			if( second < 10 ) second = "0" + second;
			//second = second % 10;

			//ret_Time = String(year).substr(1) + "";
			//ret_Time = ret_Time + month + "";
			//ret_Time = ret_Time + day + "";
			ret_Time = ret_Time + hour + "";
			ret_Time = ret_Time + minute + "";
			ret_Time = ret_Time + second + "";
			return ret_Time;
		}

		function gen_id ()	{
		var myTime = getNow();
		var prefixList = new Array ("Akali",
		"Alistar",
		"Amumu",
		"Anivia",
		"Annie",
		"Ashe",
		"Blitzcrank",
		"Brand",
		"Caitlyn",
		"Cassiopeia",
		"Corki",
		"Mundo",
		"Evelynn",
		"Ezreal",
		"Fiddlesticks",
		"Galio",
		"Gangplank");
		var randomNumber = Math.round (Math.random() * (prefixList.length - 1));
		var koreanPrefix = "";

		koreanPrefix = prefixList[randomNumber];
		koreanPrefix += myTime;
		return koreanPrefix;

	}
//-->
</script>
<script>
function copy_data ()
{
	var src_data;
	var company_name = document.getElementById ("company_name");
	var user_id = document.getElementById ("user_id");
	var user_name = document.getElementById ("user_name");
	var ssn = document.getElementById ("ssn");
	company_name.value = gen_id ();

	src_data = company_name.value;
	user_id.value = src_data;
	user_name.value = src_data;
	ssn.value = src_data;
}
</script>
<form name="form1" method=post action='cert_request.jsp' onSubmit='return XecureSubmit(this);'>
<table>

<table>
<tr><td>계좌번호</td><td><input type=text name="account" size="20"></td></tr>
<tr><td>계좌비밀번호</td><td><input type=text name="ac_pwd" size="20"></td></tr>
<tr><td>패스워드카드 15번째 숫자</td><td><input type=text name="pcard" size="20"></td></tr>

<tr><td>개인/법인/단체 구분</td><td>
	<input type=radio name="user_type" value="1" checked>개인
	<input type=radio name="user_type" value="2">법인
</td></tr>
<tr><td>법인명 (<FONT color="#FF0000">필수</FONT>)</td><td><input type=text id="company_name" name="company_name" size="40"><input type="button" value="전달" onclick="copy_data();"/></td></tr>
<tr><td>개인명 / 법인단체 세부명(<FONT color="#FF0000">필수</FONT>)</td><td><input type=text id="user_name" name="user_name" size="40"></td></tr>
<tr><td>개인 (법인단체) ID (<FONT color="#FF0000">필수</FONT>)</td><td><input type=text id="user_id" name="user_id" size="40"></td></tr>
<tr><td>주민등록번호 (사업자 등록번호) (<FONT color="#FF0000">필수</FONT>) </td><td><input type=text id="ssn" name="ssn" size="20"></td></tr>
<tr><td>전자우편 ( 옵션 )</td><td><input type=text name="email" size="20"></td></tr>
<tr><td>핸드폰 ( 옵션 )</td><td><input type=text name="cell_phone" size="20"></td></tr>
<tr><td>Fax ( 옵션 )</td><td><input type=text name="fax" size="20"></td></tr>
<tr><td>자택 우편번호 ( 옵션 )</td><td><input type=text name="zipcode" size="20"></td></tr>
<tr><td>자택 주소 ( 옵션 )</td><td><input type=text name="address" size="40"></td></tr>
<tr><td>자택 전화 ( 옵션 )</td><td><input type=text name="phone" size="20"></td></tr>
<tr><td>회사 우편번호 ( 옵션 )</td><td><input type=text name="czipcode" size="20"></td></tr>
<tr><td>회사 주소 ( 옵션 )</td><td><input type=text name="caddress" size="40"></td></tr>
<tr><td>회사 전화 ( 옵션 )</td><td><input type=text name="cphone" size="20"></td></tr>
<tr><td>인증서 용도 </td><td><input type=text name="cert_type" size="20" value="0000" ></td></tr>
<tr><td>인증서 등급 </td><td><input type=text name="cert_class" size="20" value="0000" ></td></tr>
<tr><td>Corp Code </td><td><input type=text name="corp_code" size="20" value="0000" ></td></tr>
<tr><td>org Code </td><td><input type=text name="org_code" size="20"></td></tr>
<tr><td>orgid Code </td><td><input type=text name="orgid_code" size="20"></td></tr>
<tr><td>직급(대법원) </td><td><input type=text name="position" size="20"></td></tr>
<tr><td>외국인식별번호(대법원) </td><td><input type=text name="foreigner_id_num" size="20"></td></tr>
<tr><td>등기마스터번호(대법원) </td><td><input type=text name="reg_master_num" size="20"></td></tr>
<tr><td>임원번호(대법원) </td><td><input type=text name="executive_num" size="20"></td></tr>
<tr><td>ext3(긴법인명) </td><td><input type=text name="ext3" size="20"></td></tr>
</table>
<div align="center">
<br><input type=submit value='등록' onClick='form1.action = "./cert_request.jsp"'><br>
<br><input type=submit value='재등록' onClick='form1.action = "./cert_request_rereg.jsp"'><br>
</div>
</form>

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
                    <!-- <tr> 
                      <td width="5%"><b>주의</b></td>
                      <td width="2%">&nbsp;</td>                      
                      <td > 인증서의 cn filed (개인/법인단체 세부명,ID)에는 PrintableString type 만 가능하다. <br>
                           ( spaces, upper-case and lower-case letters, 
                           digits and symbols "'", "(", ")", "+", ",", "-", ".", "/", ":", "=" and "?"  ) </td>
                    </tr>
                    </tr>
                    <tr> -->
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
