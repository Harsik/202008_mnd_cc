<%@ page contentType="text/html; charset=utf-8" %>
<%@ page buffer="16kb" %>
<%@ page import="xecure.servlet.*" %>
<%@ page import="xecure.crypto.*" %>
<%@ page import="java.io.*" %>


<form name='xecure'><input type=hidden name='p'></form>

<html>
<head>
<title>12인증서 (재)발급, 갱신등록</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><style type="text/css">
<!--
.font1 { font-size: 9pt;color:#666666;}
td {  font-size: 9pt;color:#333333}
A:link    {font-size:9pt;color:#010824;text-decoration:none; }
A:active  {font-size:9pt;color:#010824;text-decoration:none; }
A:visit	  {font-size:9pt;color:#010824;text-decoration:none; }
A:hover   {font-size:9pt;color:#0066cc;text-decoration:none; }
-->
</style>
</head>

<script language="javascript">
<!--
		function getNow()		{
			var year;
			var month;
			var day;
			var hour;
			var minute;
			var second;

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

			ret_Time = String(year).substr(1) + "";
			ret_Time = ret_Time + month + "";
			ret_Time = ret_Time + day + "";
			ret_Time = ret_Time + hour + "";
			ret_Time = ret_Time + minute + "";
			ret_Time = ret_Time + second + "";
			return ret_Time;
		}

		function auto_input()	{
		var myForm = document.getElementById( "form1" );
		var myTime = getNow();
		var randomNumber = Math.round (Math.random() * 9);
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
		var koreanPrefix = "";

		koreanPrefix = prefixList[randomNumber];
		if( myForm == null ) {
			alert( "myForm is null" );
		}
		if( myTime == null ) {
			alert( "myTime is null" );
		}
		if( myTime.length != 13 ) {
			alert( "시간정보의 길이가 올바르지 않습니다. 반드시 13자 리턴된 길이는 " + myTime.length );
		}


		//법인단체명
		myForm.company_name.value = koreanPrefix + myTime.substr(6);
		myForm.company_name.value = myTime;

		//개인명
		myForm.user_name.value = koreanPrefix;
		//myForm.user_name.value = myTime;

		//개인ID
		myForm.user_id.value = koreanPrefix + myTime.substr(6);
		myForm.user_id.value = myTime;

		//주민번호
		myForm.ssn.value = myTime;

		}
		function clickshow(num) {
			for (i=1;i<=10;i++) {
				if(imgch=eval("document.bar"+i)) {
					menu=eval("document.all.block"+i+".style"); 
					if (num==i) {
						if (menu.display=="block"){	// 메뉴 닫힘
							menu.display="none"; 
							//imgch.src="./MenuImage/b_1.gif";       
						} else {					// 메뉴 열림
							menu.display="block";
							//imgch.src="./MenuImage/b_2.gif";
						}
					} else {
						menu.display="none";
						//imgch.src="./MenuImage/b_1.gif";
					}
				} else {
					break ;
				}
			}
	}
//-->
</script>

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
                <td height="100" width="8%">&nbsp;</td>
                <td height="120" valign="middle"> 
                  <p align="center"><font size="6" face="Times New Roman, Times, serif">인증서 (재)발급, 갱신등록 
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
                        <p><b>이 페이지는 금융결제원 인증기관에 사용자를 등록하고 작업을 수행합니다. 반드시 운영시스템에서는 
                          이 페이지를 웹상에서 제거하고 절대 운영시스템에서는 수행하지 마십시요. </b><b>사용자 확인을 
                          위해서 아래의 정보를 입력해 주십시요.</b></p>
                        </td>
                    </tr>
                    <tr> 
                      <td colspan="3" height="24"> 
<br>
<form id="form1" name="form1" method=post action='cert_request.jsp'>
<table>

<tr><td><A href="javascript:auto_input();"><FONT color="#FF0000">자동입력</FONT></A></td></tr>
<tr><td>개인/법인/단체 구분</td><tr>
<td style='CURSOR: hand' onclick='javascript:clickshow(1)' width='149' bgcolor='F5F5F5' height='25'>
&nbsp;

<img src='./MenuImage/b_2.gif' name='bar1' width='9' height='9' border='0'>

<b><font face='굴림' size='2'>개인</font></b>

<td style='CURSOR: hand' onclick='javascript:clickshow(2)' width='149' bgcolor='F5F5F5' height='25'>
&nbsp;
<img src='./MenuImage/b_3.gif' name='bar2' width='9' height='9' border='0'>

<b><font face='굴림' size='2'>법인</font></b>
</td>
</tr>

<tr>
<td width='249'>
<span id='block1' style='DISPLAY: block; MARGIN-LEFT: 0px; CURSOR: hand'>
	<input type=radio name="user_policy_type" value="101" >전자거래범용
	<input type=radio name="user_policy_type" value="104" checked="true">은행/보험용 <br>
	<input type=radio name="user_policy_type" value="162">신용카드결제용
	<input type=radio name="user_policy_type" value="169">보안메일용

<td width='249'>
<span id='block2' style='DISPLAY: none; MARGIN-LEFT: 0px; CURSOR: hand'>
	<input type=radio name="user_policy_type" value="202" >금용거래용
	<input type=radio name="user_policy_type" value="205">전자거래범용<br>
	<input type=radio name="user_policy_type" value="261">기업뱅킹용
	<input type=radio name="user_policy_type" value="269">보안메일용

</td>
</tr>
<tr></tr><tr></tr><tr></tr>
<!-- 추가 -->

<tr><td>법인/단체명 ( 법인/단체일 경우 필수, 영문 필수 )</td><td><input type=text name="company_name" size="40"></td></tr>
<tr><td>개인명 / 법인단체 세부명 ( 필수 )</td><td><input type=text name="user_name" size="40"></td></tr>
<tr><td>영문 개인명 / 영문 법인단체 세부명 ( 옵션 ) </td><td><input type=text name="euser_name" size="40"></td></tr>
<tr><td>개인 (법인단체) ID ( 필수 )</td><td><input type=text name="user_id" size="20"></td></tr>
<tr><td>주민등록번호 ( 사업자 등록번호 ) ( 필수 ) </td><td><input type=text name="ssn" size="20"></td></tr>
<tr><td>전자우편 ( 옵션 )</td><td><input type=text name="email" size="20"></td></tr>
<tr><td>핸드폰 ( 옵션 )</td><td><input type=text name="cell_phone" size="20"></td></tr>
<tr><td>Fax ( 옵션 )</td><td><input type=text name="fax" size="20"></td></tr>
<tr><td>자택 우편번호 ( 개인 필수 )</td><td><input type=text name="zipcode" value="1306-6" size="20"></td></tr>
<tr><td>자택 주소 ( 개인 필수 )</td><td><input type=text name="address" value="SeochoDong" size="40"></td></tr>
<tr><td>자택 전화 ( 개인 필수 )</td><td><input type=text name="phone" value="3483-1004" size="20"></td></tr>
<tr><td>회사 우편번호 ( 법인 필수 )</td><td><input type=text name="czipcode" value="1306-6" size="20"></td></tr>
<tr><td>회사 주소 ( 법인 필수 )</td><td><input type=text name="caddress" value="SeochoDong" size="40"></td></tr>
<tr><td>회사 전화 ( 법인 필수 )</td><td><input type=text name="cphone" value="3483-1004" size="20"></td></tr>
</table>
<div align="center">
<br><input type=submit value='등록' ><br>
<input type=submit value='재등록' onClick='form1.action = "cert_rereg.jsp"'><br>
<input type=submit value='갱신' onClick='form1.action = "cert_update.jsp"'>
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
