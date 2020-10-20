<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ include file="/WEB-INF/jsp/layout/include/incHeader.jspf" %>
	<link rel="stylesheet" type="text/css" href="../css/common.css" />  
	<link rel="stylesheet" type="text/css" href="../css/tabs.css"/>
	<link rel="stylesheet" type="text/css" media="screen" href="../dtree/dtree.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="../jqgrid/css/ui.jqgrid.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="../jqueryui/jquery-ui.css" />
	
	<script type="text/javascript" src="../js/tabs.js"></script>
	<script type="text/javascript" src="../dtree/dtree.js"></script>
    <script type="text/javascript" src="../jqgrid/js/jquery.jqGrid.min.js" ></script> 
    <script type="text/javascript" src="../js/jquery.form.js" ></script>  
	  
	<script type="text/javascript">
	
		function fnPassModi() {

			if($.trim($("#mngrPw").val()) == ""){
				alert("변경할 비밀번호를 입력해주세요.");
				$("#mngrPw").focus();
				return;
			}
			if(!chkPwd( $.trim($('#mngrPw').val()))){
				$('#mngrPw').val('');
				$('#mngrPw').focus();
				return;
			}
			
			if(confirm("비밀번호를 변경 하시겠습니까?")){
				
				$.ajax({   
					url:"/admin/doChgMngrPw.do",
					type:"post",
					dataType:'json',
					data:$("#frm").serialize(),
					success:function(data) {
						
						alert("비밀번호가 변경되었습니다.");
						
						var frm = document.frm;
						frm.action = "/admin/main.do";
						frm.submit();				
					}
					
				});
			}
			
		}

		//비밀번호 유효성 검사
		function chkPwd(str){

			 var pw = str;
			 var num = pw.search(/[0-9]/g);
			 var eng = pw.search(/[a-z]/ig);
			 var spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);			 

			 if(pw.length < 8 || pw.length > 20){
				 alert("비밀번호는 8자리 ~ 20자리 이내로 입력해주세요.");
				 return false;
			 }

			 if(pw.search(/₩s/) != -1){
			 	alert("비밀번호는 공백업이 입력해주세요.");
			 	return false;
			 } 
			 if(num < 0 || eng < 0 || spe < 0 ){
			 	alert("영문, 숫자, 특수문자를 혼합하여 입력해주세요.");
			 	return false;
			 }
			 return true;
		}
		
		function fnCancel() {
			var frm = document.frm;
			frm.action = "/admin/main.do";
			frm.submit();
		}

		$(document).on("click", ".cleBt", function() {
			fnCancel();
		});	
		$(document).on("click", ".modiBt", function() {
			fnPassModi();
		});		
		
	</script>
 <!--contents_area-->
    <div id="content_a">
		<!--content_main-->
		<div class="content_main">
			<!--contents-->
			<div class="contents_a">
				<!--title-->
				<h3>비밀번호 변경</h3>
				<!--//title-->
				
				<!--비밀번호 변경 게시판-->				
				<form name="frm" id="frm" method="post">
				
				<div class="board_type_n mt40">	
					<table class="tba_type_board" border="1" cellspacing="0" summary="비밀번호 변경 게시판입니다.">
						<caption>비밀번호 변경 게시판</caption>
						<colgroup>
						<col width="15%">
						<col>
						</colgroup>
						<tbody>
							<tr>
								<th scope="col">변경할 비밀번호</th>
								<td><input id="mngrPw" name="mngrPw"  type="password" class="w300" title="변경할 비밀번호" /></td>
							</tr>
						</tbody>
					</table>
				</div>
				
				</form>
				<!--//비밀번호 변경 게시판-->
				
				<!--btn_area-->
				<div class="tbl_bottom">
					<div class="t_right">
					  <!-- <button type="button" name="btnModi" id="add" class="btnComm grblue mr5" title="추가">추가</button> -->
					  <button type="button" name="btnModi" id="btnModi" class="btnComm grblue mr5 modiBt" title="수정">수정</button>
					  <!-- <button type="button" name="btnModi" id="btnModi" class="btnComm gr_line mr5" title="삭제">삭제</button> -->
					  <button type="button" name="btnModi" id="btnModi" class="btnComm gray cleBt" title="취소">취소</button>
					</div>
				</div>
				<!--//btn_area-->
				
			</div>
			<!--//contents-->
			
			
		</div>
		<!--//content_main-->
    </div>
    <!--//contents_area-->
</div>