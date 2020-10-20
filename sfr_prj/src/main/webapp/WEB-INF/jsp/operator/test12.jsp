<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<tiles:importAttribute name="user_name" />
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />	
	<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />	
	<meta name="keywords" content="전화번호 통합검색체계" />
	<meta name="description" content="국방부,육군,공군,해군 전화번호 통합검색체계" />
    <title>전화번호 통합검색체계</title>
	<link rel="stylesheet" href="../css/layout.css" />
    <link rel="stylesheet" href="../css/common.css" />
	<link rel="stylesheet" href="../css/fonts.css" />
	
	<link rel="stylesheet" href="../css/login.css" />
	
	<script type="text/javascript" src="../js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="../js/jquery.bpopup.min.js"></script>
    <script type="text/javascript" src="../js/common.js"></script>	
	
	<script type="text/javascript">
		$(function(){
			
		});

		
		function login() {
			if($.trim($("#id").val()) == ""){
				alert("아이디를 입력해주세요!");
				$("#id").focus();
				return;
			}
			if($.trim($("#pw").val()) == ""){
				alert("비밀번호를 입력해주세요!");
				$("#pw").focus();
				return;
			}		
			
			$.ajax({   
				url:"/intra/loginProc.do",
				type:"post",
				dataType:'json',
				data:$("#frm").serialize(),
				success:function(data) {
					
					console.log(data);
					
					if(data.code == '0'){
						location.href = "/intra/main.do";
					}else if(data.code == '-2'){
						if(confirm(data.msg)){
							$("#loginFlag").val("true");
							login();
						}
					}else {
						alert(data.msg);
					}
				}
				
			});

			
			
		}
	</script>	
</head>
<body>

<!--contents_area-->
    <div id="container_o">
	<div class="centered-login">
	<!--Login-->
		<form name="frm" id="frm" method="post">
		<input type="hidden" name="loginFlag" id="loginFlag" />
			<fieldset>
			<legend>로그인</legend>
			<!--loginWrap-->
				<div class="loginWrap">
					<div class="loginBox">
						<div class="loginBox_img"><span class="txt1"></span></div>
						<!--loginBox_01-->
						<div class="loginBox_01">
							<div class="login_header"><img src="../images/operator/logo_O.png" alt="국방부" /><span class="txt2">전화번호 통합검색</span></div>
							<div class="inputBox">
								<div class="input01">
									<div class="cont mgb10"><p style="color: red;">정보를 가져오지 못했습니다.</p></div>
									</div>
							</div>     
						</div>
						<!--//loginBox_01-->
					</div>
				</div>
				<!--//loginWrap-->
			</fieldset>
		</form>
	<!--//Login--> 
	</div>
    </div>
<!--//contents_area-->
	
</body>
</html>