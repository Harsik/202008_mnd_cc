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
.login {position:absolute; width: 800px; height:412px; left:50%; top:50%; margin:-230px 0 0 -400px; background-color:#ff0000; z-index:10; }
.button {height:22px; padding-top:1px;}
</style>
	
	<script type="text/javascript">
		$(document).ready(function(){
// 			if(document.referrer.indexOf("ssoksign") != -1) login();

			$("#mdcdSelectBox,#login_Btn,#portalBtn").hide();
		});
		
		function login(){
			$("#mdcd").val($("#mdcdSelectBox").val());
			AnySign.SignDataCMS ("","","",0,"","3","0");
		}
		
	</script>	
</head>
<body>
	<div class="login"><a href="javascript:void(0);"><img src="../images/intra/login.jpg"></a>
	<select id="mdcdSelectBox" style="margin: 15px 0px 0px 32%; height:22px;">
		<option value="1" selected>국방부</option>
		<option value="5">육군</option>
		<option value="6">해군</option>
		<option value="7">공군</option>
	</select>
	<button id="login_Btn" type="button" class="button" style="margin-left: 10px;" onclick="login();">공인인증서 로그인</button>
	<br><br>
	
	<button id="portalBtn" type="button" class="button" onclick="location.href='http://www.naver.com';">국방부</button>
	<button id="portalBtn" type="button" class="button" onclick="location.href='http://www.naver.com';">육군</button>
	<button id="portalBtn" type="button" class="button" onclick="location.href='http://www.naver.com';">해군</button>
	<button id="portalBtn" type="button" class="button" onclick="location.href='http://www.naver.com';">공군</button>
	
	</div>
	
	
	<form id="pform" name="pform" method="post">
		<input type="hidden" id="aResult" name="aResult">
		<input type="hidden" id="aPlain" name="aPlain">
		<input type="hidden" id="aOption" name="aOption">
		<input type="hidden" id="mdcd" name="mdcd">
	</form>	
</body>
</html>