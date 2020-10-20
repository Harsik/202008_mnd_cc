<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
	<link rel="stylesheet" type="text/css" href="../css/common.css" />  
	<link rel="stylesheet" type="text/css" href="../css/tabs.css"/>
	<link rel="stylesheet" type="text/css" media="screen" href="../dtree/dtree.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="../jqgrid/css/ui.jqgrid.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="../jqueryui/jquery-ui.css" />
    
	
	<script type="text/javascript" src="../js/tabs.js"></script>
	<script type="text/javascript" src="../dtree/dtree.js"></script>
    <script type="text/javascript" src="../jqgrid/js/jquery.jqGrid.min.js" ></script> 
	  
	<script type="text/javascript">
	
		
		function fnFacAdd() {
			
			if($.trim($("#mngrId").val()) == ""){
				alert("아이디를 입력해수세요");
				$("#mngrId").focus();
				return;
			}
			
			var idFilter = ['admin'];
			var chkId = $.trim($("#mngrId").val()).toLowerCase();
			var matchKey = "";
			
			for(var i in idFilter){
				if(chkId.indexOf( idFilter[i] )> -1){
					matchKey = idFilter[i];
					break;
				}
			}
			if(matchKey!=""){
				alert("아이디에는 "+matchKey+"를 넣을 수 없습니다.");
				$("#mngrId").focus();
				return;
			}
			
			if($.trim($("#mngrPw").val()) == ""){
				alert("비밀번호를 입력해주세요");
				$("#mngrPw").focus();
				return;
			}

			if(!chkPwd( $.trim($('#mngrPw').val()))){
				$('#mngrPw').val('');
				$('#mngrPw').focus();
				return;
			}
						
			if(confirm("시스템 관리자를 등록 하시겠습니까?")){
				
				$('select').removeAttr("disabled");
				
				$.ajax({   
					url:"/admin/adminInsert.do",
					type:"post",
					dataType:'json',
					data:$("#frm").serialize(),
					success:function(data) {
						if(data.resultCd == "200") {
							alert("이미 등록된 아이디 입니다.");
						} else {	
							alert("등록되었습니다.");
							
							var frm = document.frm;
							frm.action = "/admin/adminList.do";
							frm.submit();
						}				
					}
					
				});
			}
		};
		
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
		
	</script>
   <!--contents_area-->
    <div id="content_a">
		<!--content_main-->
		<div class="content_main">
			<!--contents-->
			<div class="contents_a">
				<!--title-->
				<h3>시스템 관리자</h3>
				<!--//title-->
				<!--시스템 관리자 등록 게시판-->
				<form name="frm" id="frm" method="post">
				<div class="board_type_n mt40">	
					<table class="tba_type_board" border="1" cellspacing="0" summary="시스템 관리자 등록 게시판입니다.">
						<caption>시스템 관리자 등록 게시판</caption>
						<colgroup>
						<col width="15%">
						<col>
						<col width="15%">
						<col>
						</colgroup>
						<thead>
							<tr>
								<th scope="col">군</th>
								<td colspan="3">
									<select name="mildsc" id="mildsc" title="조건을 선택하세요" class="select-type w250" >
										<option value="A" >국방부</option>
										<option value="B" >육군</option>
										<option value="C" >해군</option>
										<option value="D" >공군</option>
									</select>	
								</td>								
						</thead>
						<tbody>
							<tr>
								<th scope="col">아이디</th>
								<td><input type="text" class="w300" title="아이디" name="mngrId" id="mngrId" placeholder="mnd2" /></td>
								<th scope="col">비밀번호</th>
								<td><input type="password" class="w300" title="비밀번호" name="mngrPw" id="mngrPw" /></td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--//시스템 관리자 등록 게시판-->
				<!--btn_area-->
				<div class="tbl_bottom">
					<div class="t_right">
					  <button type="button" name="btnModi" id="btnModi" class="btnComm grblue mr5" title="등록" onclick=" fnFacAdd();">등록</button>
						<button type="button" name="btnModi" id="btnModi" class="btnComm gr_line" title="취소" onClick="history.back();">취소</button>
					</div>
				</div>
				</form>
				<!--//btn_area-->
			</div>
			<!--//contents-->
			
			
		</div>
		<!--//content_main-->
    </div>
    <!--//contents_area-->
</div>
