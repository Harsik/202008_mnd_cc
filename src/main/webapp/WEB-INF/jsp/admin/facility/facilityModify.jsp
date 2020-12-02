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
	
		function fnFacModi() {

			if($.trim($("#facilityNm").val()) == ""){
				alert("시설물 명을 입력해주세요.");
				$("#facilityNm").focus();
				return;
			}
			// 20.12.01 시설물 특수문자 제한
			var special_pattern = /["':;&%#-]/gi;
			 
			if( $("#facilityNm").val().length > 50 || special_pattern.test($("#facilityNm").val()) ){
				alert("문자 50자 이상 및 특수문자는 등록이 제한됩니다.\n다시 입력해 주시기 바랍니다.");
				$("#facilityNm").focus();
				return;
			}
			if($.trim($("#tel").val()) == ""){
				alert("전화번호를 입력해주세요");
				$("#tel").focus();
				return;
			}
			var regNumber = /^[0-9,]*$/;
			if(!regNumber.test($("#tel").val())) {
			    alert('전화번호는 숫자만 입력해주세요.');
				$("#tel").focus();
			    return;
			}
			
			if(confirm("시설물을 수정 하시겠습니까?")){
				
				$.ajax({   
					url:"/admin/doFacModify.do",
					type:"post",
					dataType:'json',
					data:$("#frm").serialize(),
					success:function(data) {
						
						alert("시설물이 수정되었습니다.");
						
						var frm = document.frm;
						frm.action = "/admin/main.do";
						frm.submit();				
					}
					
				});
			}
			
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
			fnFacModi();
		});		

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
			var mildsc = $('#mildsc option:selected').val(); // 최상위 코드
			
			var text = '<option value="">- 선택 -</option>';

			for(var i=cnt-1;i>idx;i--){
			//for(var i=idx+1;i<cnt;i++){
				$('select', div).eq(i).remove();
			}
			
			if(code == ''){ // 전체를 선택했을 경우
				
			}else{
				
				$.ajax({   
					url:"/admin/getFacility.do",
					type:"post",
					dataType:'json',
					data:{"hgrnkDeptCd":code,"mildsc":mildsc},
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

	</script>
 <!--contents_area-->
    <div id="content_a">
		<!--content_main-->
		<div class="content_main">
			<!--contents-->
			<div class="contents_a">
				<!--title-->
				<h3>시설물명 현황 수정</h3>
				<!--//title-->
				
				<!--시설물 등록 게시판-->				
				<form name="frm" id="frm" method="post">
					<input type="hidden" id="seq" name="seq" value='<c:out value="${paramMap.seq}"/>' />
					<input type="hidden" id="currentPage" name="currentPage" value='<c:out value="${paramMap.currentPage}"/>' />
					<input type="hidden" id="recordCountPerPage" name="recordCountPerPage" value='<c:out value="${paramMap.recordCountPerPage}"/>' />
					<input type="hidden" id="searchKey" name="searchKey" value='<c:out value="${paramMap.searchKey}"/>' />
					<input type="hidden" id="searchTxt" name="searchTxt" value='<c:out value="${paramMap.searchTxt}"/>' />
				
				<div class="board_type_n mt40">	
					<table class="tba_type_board" border="1" cellspacing="0" summary="시설물 수정 게시판입니다.">
						<caption>시설물 수정 게시판</caption>
						<colgroup>
						<col width="15%">
						<col>
						</colgroup>
						<tbody>
							
							<tr>
								<th scope="col">군</th>
								<td>
									<select name="mildsc" id="mildsc" onchange="setTopComboBox(this);" title="조건을 선택하세요" class="select-type w250">
										<option value="A" ${mildsc.equals('A')?'selected':'' }>국방부</option>
										<option value="B" ${mildsc.equals('B')?'selected':'' }>육군</option>
										<option value="C" ${mildsc.equals('C')?'selected':'' }>해군</option>
										<option value="D" ${mildsc.equals('D')?'selected':'' }>공군</option>
										<option value="1290451" ${mdcdFlg.equals('Y')?'selected':'' }>합동참모본부</option>
									</select>
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
							</tr>
							<tr>
								<th scope="col">시설물명</th>
								<td>
									<input id="facilityNm" name="facilityNm" type="text" class="w300" value="${data.facilityNm}" title="시설물명" />
								</td>
							</tr>
							<tr>
								<th scope="col">전화번호</th>
								<td><input id="tel" name="tel"  type="text" class="w300" value="${data.tel}" title="전화번호" />
									*일반 전화번호는 콤마(,)로 구분해 주십시오.</td>
							</tr>
						</tbody>
					</table>
				</div>
				
				</form>
				<!--//시설물 등록 게시판-->
				
				<!--btn_area-->
				<div class="tbl_bottom">
					<div class="t_right">
					  <button type="button" name="btnModi" id="btnModi" class="btnComm grblue mr5 modiBt" title="수정">수정</button>
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