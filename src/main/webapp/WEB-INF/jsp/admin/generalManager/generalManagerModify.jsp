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
	
		
		function deleteGeneral() {
			var frm = document.frm;
			
			if(confirm("삭제하시겠습니까? ")) {
				
				//frm.seq.value = $("#seq").val();
				frm.action = "/admin/deleteGeneral.do";
				frm.submit();
			}
		}
		

		function setTopComboBox(o){

			var code = o.value;
			var div = $(o).parent(); // 셀렉트 박스의 상위 객체
			var cnt = $('select', div).size(); // 셀렉트 박스 갯수
			var idx = $('select', div).index(o); // 현재 셀렉트 박스의 순서
			var mildsc = $('#mildsc option:selected').val(); // 최상위 코드
			
			var text = '<option value="">- 선택 -</option>';
			
			for(var i=cnt-1;i>idx;i--){
			//for(var i=idx+1;i<cnt;i++){
				$('select', div).eq(i).remove();
			}
			
			if(code == ''){ // 전체를 선택했을 경우
				
			}else{
				
				$.ajax({   
					url:"/admin/getFacilityTop.do",
					type:"post",
					dataType:'json',
					data:{"mildsc":mildsc},
					success:function(data) {
						
						if(data!=null && data.length>0){
							var cnt = $('select', div).size(); // 셀렉트 박스 갯수
							var idx = $('select', div).index(o); // 현재 셀렉트 박스의 순서
							
							if(cnt-1==idx){
								div.append("<select name=\"deptCd\" id=\"deptCd\" onchange=\"setComboBox(this);\" class=\"select-type w250\" >");
								div.append("</select>");
							}
							
							var combo = $('select', div).eq(idx + 1);
							combo.empty();
							combo.append(text);
							
							for(var i=0 ; i<data.length ; i++){
								combo.append('<option value="' + data[i].deptCd + '">' + data[i].deptNm + '</option>');
							}	
						}
										
					}
					
				});
			}

		}
		
		function setComboBox(o){
			var code = o.value;
			var div = $(o).parent(); // 셀렉트 박스의 상위 객체
			var cnt = $('select', div).size(); // 셀렉트 박스 갯수
			var idx = $('select', div).index(o); // 현재 셀렉트 박스의 순서
			
			var text = '<option value="">- 선택 -</option>';

			for(var i=cnt-1;i>idx;i--){
			//for(var i=idx+1;i<cnt;i++){
				$('select', div).eq(i).remove();
			}
			
			if(code == ''){ // 전체를 선택했을 경우
				
			}else{
				
				$.ajax({   
					url:"/admin/getGeneralManager.do",
					type:"post",
					dataType:'json',
					data:{"hgrnkDeptCd":code},
					success:function(data) {
						 //console.log(data);
						if(data!=null && data.length>0){
							var cnt = $('select', div).size(); // 셀렉트 박스 갯수
							var idx = $('select', div).index(o); // 현재 셀렉트 박스의 순서
							
							if(cnt-1==idx){
								div.append("<select name=\"deptCd\" id=\"deptCd\" onchange=\"setComboBox(this);\" class=\"select-type w250\" >");
								div.append("</select>");
							}
							
							var combo = $('select', div).eq(idx + 1);
							combo.empty();
							combo.append(text);
							
							for(var i=0 ; i<data.length ; i++){
								combo.append('<option value="' + data[i].deptCd + '">' + data[i].deptNm + '</option>');
							}	
						}
										
					}
					
				});
			}

		}

		function fnFacModi() {

			if($("#mngrPw").val() != ""){
				if(!chkPwd( $.trim($('#mngrPw').val()))){
					$('#mngrPw').val('');
					$('#mngrPw').focus();
					return;
				}
			}
			
			if(confirm("일반관리자를 수정 하시겠습니까?")){
				
				$('select').removeAttr("disabled");
				
				$.ajax({   
					url:"/admin/generalManagerUpdate.do",
					type:"post",
					dataType:'json',
					data:$("#frm").serialize(),
					success:function(data) {
						
						if(data.resultCd == '100'){
				    		alert("등록되었습니다.");
						}
						
						var frm = document.frm;
						frm.action = "/admin/generalManagerList.do";
						frm.submit();				
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
		
		/* $(document).on("click", "#btnModi", function() {
			fnFacModi();
		});
		$(document).on("click", "#btnDel", function() {
			deleteGeneral();
		});
		$(document).on("click", "#btnCancle", function() {
			fnFacList();
		}); */
		
	</script>
    <!--contents_area-->
    <div id="content_a">
		<!--content_main-->
		<div class="content_main">
			<!--contents-->
			<div class="contents_a">
				<!--title-->
				<h3>시설물 일반관리자 수정</h3>
				<!--//title-->
				<!--일반관리 등록 게시판-->
				<form name="frm" id="frm" method="post">
					<input type="hidden" name="searchKey" id="searchKey" value='<c:out value="${paramMap.searchKey}"/>' />
					<input type="hidden" name="searchTxt" id="searchTxt" value='<c:out value="${paramMap.searchTxt}"/>' />
					
				<div class="board_type_n mt40">	
					<table class="tba_type_board" border="1" cellspacing="0" summary="일반관리 등록 게시판입니다.">
						<caption>일반관리 등록 게시판</caption>
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
									<c:if test="${mildsc.equals('A')}">
									<select name="mildsc" id="mildsc" onchange="setTopComboBox(this);" title="조건을 선택하세요" class="select-type w250">
										<option value="A" ${mildsc.equals('A')?'selected':'' }>국방부</option>
										<option value="1290451" ${mdcdFlg.equals('Y')?'selected':'' }>합동참모본부</option>
									</select>
									</c:if>
									<c:if test="${!mildsc.equals('A')}">
									<select name="mildsc" id="mildsc" title="조건을 선택하세요" class="select-type w250" disabled>
										<option value="B" ${mildsc.equals('B')?'selected':'' }>육군</option>
										<option value="C" ${mildsc.equals('C')?'selected':'' }>해군</option>
										<option value="D" ${mildsc.equals('D')?'selected':'' }>공군</option>
									</select>
									</c:if>
									
									<%-- <c:forEach items="${deptNmList}" var="data" varStatus="status">
									<select name="deptCd" id="deptCd" title="조건을 선택하세요" class="select-type w250" disabled>
										<option value="${data.deptCd}" selected>${data.deptNm}</option>
									</select>
									</c:forEach>
									
									<select name="deptCd" id="deptCd" onchange="setComboBox(this);" title="조건을 선택하세요" class="select-type w250" >
										<option value="" selected>- 선택 -</option>
									<c:forEach items="${deptList}" var="data" varStatus="status">
										<option value="${data.deptCd}">${data.deptNm}</option>
									</c:forEach>
									</select>
									 --%>
									
									<c:if test="${fn:length(deptList)>0}">	
									<c:forEach items="${deptList}" var="data1" varStatus="status1">
									<c:if test="${fn:length(data1)>0}">
									<select name="deptCd" id="deptCd" onchange="setComboBox(this);" title="조건을 선택하세요" class="select-type w250" >
										<option value="" selected>- 선택 -</option>
									<c:forEach items="${data1}" var="data2" varStatus="status2">
										<option value="${data2.deptCd}" ${deptNmList[status1.index].deptCd.equals(data2.deptCd)?'selected':'' }>${data2.deptNm}</option>
									</c:forEach>
									</select>
									</c:if>
									</c:forEach>
									</c:if>
									
									</td>
								
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
				<!--//일반관리 등록 게시판-->
				
				<!--btn_area-->
				<div class="tbl_bottom">
					<div class="t_right">
					  <button type="button" name="btnModi" id="btnModi" class="btnComm grblue mr5 submit" title="수정" onclick="fnFacModi();">수정</button>
					  <button type="button" name="btnDel" id="btnDel" class="btnComm gr_line mr5" title="삭제" onclick="deleteGeneral();">삭제</button>
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
