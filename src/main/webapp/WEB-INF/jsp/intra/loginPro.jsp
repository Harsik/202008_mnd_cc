<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />	
	<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />	
	<meta name="keywords" content="전화번호 통합검색체계" />
	<meta name="description" content="국방부,육군,공군,해군 전화번호 통합검색체계" />
    <title>전화번호 통합검색체계</title>
    <link rel="stylesheet" href="../AnySign/AnySign4PC/css/common.css" />
	
	<script type="text/javascript" src="../js/jquery-1.7.1.min.js"></script>
    <script type="text/javascript" src="../AnySign/anySign4PCInterface.js"></script>
    <script type="text/javascript" src="../AnySign/AnySign4PCtest.js"></script>
    <script type="text/javascript" src="../AnySign/AnySign4PC/ext/AnySign.js"></script>
	<script>
	</script>
 
<style>
.login {position:absolute; width: 800px; height:412px; left:50%; top:40%; margin:-230px 0 0 -400px;z-index:10; }
.button {height:22px; padding-top:1px;}
.login_content{
	border: 2px solid rgba(0, 93, 152, 1); height:400px; width: 846px; font-family: "Noto Sans KR", sans-serif;
}
.login_notice_line {
	padding: 10px; text-align: center; color: rgb(102, 102, 102); font-size: 15px; box-sizing:border-box;
/* 	background-color: rgb(235, 235, 235); */
	background-color: rgb(255, 255, 255);
}
.login_form .login_radio_wrap {
	margin-left: 27%; float: left; padding: 2px; border: 1px solid rgb(204, 204, 204); border-image: none; width: 250px; height:130px; text-align: center; display: block;
}
.login_form .login_radio_wrap li {
	display: inline-block; padding-top: 20px;
}
.login_form input[type='radio'] {
	display: none;
}
.login_form input[type='radio'] + label {
	margin: 0px; padding: 10px 30px; color: rgb(51, 51, 51); line-height: 100%; font-size: 13px; cursor: pointer;
	width: 40px; display: block;
}
.login_form input[type='radio'] + label span {
	width: 100%; font-size: 13px; margin-top: -5px; vertical-align: middle; cursor: pointer;
}
.login_form .radio_1 input[type='radio'] + label {
	background-color: rgb(255, 255, 255);
}
.login_form .radio_2 input[type='radio'] + label {
	background-color: rgb(255, 255, 255);
}
.login_form .radio_3 input[type='radio'] + label {
	background-color: rgb(255, 255, 255);
}
.login_form .radio_4 input[type='radio'] + label {
	background-color: rgb(255, 255, 255);
}
.login_form .radio_1 input[type='radio']:checked + label {
	color: rgb(255, 255, 255); background-color: rgb(149, 149, 149);
}
.login_form .radio_2 input[type='radio']:checked + label {
	color: rgb(255, 255, 255); background-color: rgb(84, 130, 53);
}
.login_form .radio_3 input[type='radio']:checked + label {
	color: rgb(255, 255, 255); background-color: rgb(47, 85, 151);
}
.login_form .radio_4 input[type='radio']:checked + label {
	color: rgb(255, 255, 255); background-color: rgb(91, 155, 213);
}
.login_form table {
	margin: auto; margin-top: 10px;
}
.login_form table input {
	margin: 5px 0px; padding: 6px 8px; border-radius: 2px; border: 1px solid rgb(228, 229, 230); border-image: none; width: 100%; color: rgb(154, 154, 154); display: inline-block;
}
.login_form table td button {
	margin: 0px 5px; border-radius: 2px; border: currentColor; border-image: none; width: 98px; height: 77px; color: rgb(255, 255, 255); line-height: 130%; letter-spacing: -0.03em; font-size: 15px; float: left; display: inline-block;
}
.login_form table td button:first-child {
	margin-left: 19px;
}
.login_form table td button:last-child {
	margin-right: 0px;
}
.login_btn {
	background-color: rgb(33, 108, 188);
}
.login_btn2 {
	background-color: rgb(21, 152, 154);
}
.login_btn3 {
	margin: 45px 0px 0px 40px; border-radius: 2px; border: currentColor; border-image: none; width: 98px; 
	height: 77px; color: rgb(255, 255, 255); line-height: 130%; letter-spacing: -0.03em; 
	font-size: 15px; display: inline-block;
	background-color: rgb(21, 152, 154);
}
.login_footer p{
	text-align: center;
	font-size: 13px;
}
.col_b {
	color: rgba(0, 93, 152, 1);
}
a {
	color: rgb(0, 123, 255); text-decoration: none; background-color: transparent;
}
</style>
	
	<script type="text/javascript">
		function fnLogin(){
			$("#mdcd").val($(".login_radio_wrap input[type='radio']:checked").val());
			AnySign.SignDataCMS ("","","",0,"","3","0");
		}
	</script>	
</head>
<body>

<div class="login"><a href="javascript:void(0);"><img src="../images/intra_new/login2.jpg"></a>

	<!-- start -->
	<div class="login_content">
		<div class="login_notice_line">
			<a onclick="" href="#" target='_blank'></a><br />
			<a onclick="" href="#" target='_blank'></a><br />
			<a onclick="" href="#" target='_blank'></a><br />
		</div>
		<form name="loginForm" class="login_form" id="loginForm" onsubmit="return false;" method="post">
		<p style="text-align: center; padding-top: 10px; font-size: 13px;">본래 소속 군을 선택해주세요. <span style="color: red;">( 주의! 근무지 소속 아님! )</span> </p> 
		
		<ul class="login_radio_wrap">
		  <li class="radio_1"><input name="mdcd" id="mdcd1" type="radio" checked=""  value="1"><label for="mdcd1"><span></span>국방부</label></li>
		  <li class="radio_2"><input name="mdcd" id="mdcd2" type="radio" value="5"><label for="mdcd2"><span></span>육군</label></li>
		  <li class="radio_3"><input name="mdcd" id="mdcd3" type="radio" value="6"><label for="mdcd3"><span></span>해군</label></li>
		  <li class="radio_4"><input name="mdcd" id="mdcd4" type="radio" value="7"><label for="mdcd4"><span></span>공군</label></li>
		</ul>
		<!-- 
		<table class="m_t_20">
		  <colgroup>
		  	<col width="45%">
		  	<col width="55%">
		  </colgroup>
		  <tbody>
			  <tr>
			    <td>
			    	<input name="srvno" tabindex="1" title="군번/ID" id="srvno" type="text" placeholder="군번/ID" value="">
			    </td>
			    <td rowspan="2">
			    	<button tabindex="3" class="login_btn" onclick="fnLogin()">로그인</button>
			    	<button class="login_btn2" id="crtlogin">인증서<br>로그인</button>
			    </td>
			  </tr>
			  <tr>
			    <td>
			    	<input name="pw" tabindex="2" title="PASSWORD" id="pw" type="password" placeholder="PASSWORD" value="" autocomplete="off">
			    </td>
			  </tr>
		  </tbody>
		</table>
		 -->
		<button class="login_btn3" id="crtlogin" onclick="fnLogin()">인증서<br />로그인</button>
		<div class="login_footer" style="padding-top: 100px;">
			<!-- 
			<p>※ 사용자 구분이 <span class="col_b">군인/군무원 </span>일 경우 <span class="col_b">군번/순번</span>,</p>
			<p><span class="col_b">공무원/공무직근로자/민간인 </span>일 경우에는  <span class="col_b">아이디</span>를  입력하세요.</p>
			 -->
			<p>문의전화 : (군)900-0515, (일)02-748-0515</p>
		</div>
		</form>
	</div>
	<!-- end -->
	
</div>
<form id="pform" name="pform" method="post">
	<input type="hidden" id="aResult" name="aResult">
	<input type="hidden" id="aPlain" name="aPlain">
	<input type="hidden" id="aOption" name="aOption">
	<input type="hidden" id="mdcd" name="mdcd">
</form>	
</body>
</html>