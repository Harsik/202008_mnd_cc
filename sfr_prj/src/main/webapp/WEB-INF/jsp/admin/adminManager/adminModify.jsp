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
	  
	<script type="text/javascript">
	
		
		function deleteAdmin() {
			var frm = document.frm;
			
			if(confirm("삭제하시겠습니까? ")) {
				
				//frm.seq.value = $("#seq").val();
				frm.action = "/admin/deleteAdmin.do";
				frm.submit();
			}
		}
		
		function updateBoard() {
			
			var frm = document.frm;

			if($("#mngrId").val() == "") {
				alert("아이디를  입력해주세요.");
				$("mngrId").focus();
				return;
			}
			if($("#mngrPw").val() != ""){
				if(!chkPwd( $.trim($('#mngrPw').val()))){
					$('#mngrPw').val('');
					$('#mngrPw').focus();
					return;
				}
			}
			
			if(confirm("수정 하시겠습니까?")) {
				
				frm.action = "/admin/updateAdmin.do";
				frm.submit();
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
		
	</script>
   <!--contents_area-->
    <div id="content_a">
		<!--content_main-->
		<div class="content_main">
			<!--contents-->
			<div class="contents_a">
				<!--title-->
				<h3>최상위 관리자</h3>
				<!--//title-->
				<!--최상위 관리자 등록 게시판-->
				<form name="frm" id="frm" method="post">
				<div class="board_type_n mt40">	
					<table class="tba_type_board" border="1" cellspacing="0" summary="최상위 관리자 등록 게시판입니다.">
						<caption>최상위 관리자 등록 게시판</caption>
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
										<option value="A" ${mildsc.equals('A')?'selected':'' }>국방부</option>
										<option value="B" ${mildsc.equals('B')?'selected':'' }>육군</option>
										<option value="C" ${mildsc.equals('C')?'selected':'' }>해군</option>
										<option value="D" ${mildsc.equals('D')?'selected':'' }>공군</option>
									</select>
								</td>
							</tr>									
						</thead>
						<tbody>
							<tr>
							<c:forEach items="${list}" var="data" varStatus="status">
								<input type="hidden" id="seq" name="seq" value="<c:out value="${ data.seq}" />" />
								<th scope="col">아이디</th>
								<td><input type="text" class="w300" title="아이디" name="mngrId" id="mngrId" value="<c:out value="${ data.mngrId}"/>" readonly /></td>
								<th scope="col">비밀번호</th>
								<td><input type="password" class="w300" title="비밀번호" name="mngrPw" id="mngrPw" value="" /></td>
							</c:forEach>
							</tr>
						</tbody>
					</table>
				</div>
				<!--//최상위 관리자 등록 게시판-->
				<!--btn_area-->
				<div class="tbl_bottom">
					<div class="t_right">
					  <button type="button" name="btnModi" id="btnModi" class="btnComm grblue mr5" title="수정" onclick="updateBoard();">수정</button>
					  <button type="button" name="btnDel" id="btnDel" class="btnComm gr_line mr5" title="삭제" onclick="deleteAdmin();">삭제</button>
					  <button type="button" name="btnCancle" id="btnCancle" class="btnComm gray" title="취소" onClick="history.back();">취소</button>
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