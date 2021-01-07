<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<title>악성민원인 상세</title>
		
		<style>
		  	table{margin:0;padding:0;vertical-align:top;letter-spacing:0;word-break: keep-all;border-collapse:collapse;border-spacing:0;table-layout:fixed;}
			table tbody th{padding:8px 10px;box-sizing:border-box;border:1px solid #ccc;background:#888;color:#fff;font-weight:500;}
			table tbody td{padding:8px 10px;box-sizing:border-box;border:1px solid #ccc;}
			.button{ height:35px; line-height:29px; background-color:#888; color:#FFF; font-size:15px;min-width:50px; padding:0 20px; box-sizing:border-box;font-weight:700;}
		</style>
		
		<link rel="stylesheet" type="text/css" href="../css/common.css" />  
		<link rel="stylesheet" type="text/css" href="../css/tabs.css"/>
		<link rel="stylesheet" type="text/css" href="../jsTree/jstree.3.3.5/dist/themes/default/style.min.css"/>
	    <link rel="stylesheet" type="text/css"	href="../jqueryui/jquery-ui.css" />
		
		<script type="text/javascript"	src="../jsTree/jstree.3.3.5/jquery-1.12.1.js"></script>
		
		<script type="text/javascript"	src="../jqueryui/jquery-ui.js"></script>  
		<script type="text/javascript" src="../js/tabs.js"></script>
		<script type="text/javascript" src="../js/common.js"></script> 
	    <script type="text/javascript" src="../jsTree/jstree.3.3.5/dist/jstree.min.js"></script>
		<script>
	    var adminYn = window.sessionStorage.getItem("ADMIN_YN");
	    var actType = '${data.actType}';
	    
	    $(document).ready(function(){
	    	
	    	datePicker("#blockd_start_dt");
			datePicker("#blockd_end_dt");
	    	
			$(".btnComm_aksung").bind("click", saveInfo );
			
	    	//중복클릭 방지
	    	/*
			var cols = document.querySelectorAll('.btnComm_aksung');
			[].forEach.call(cols, function(col) {
				col.addEventListener("click", function (e) {
		    	    this.setAttribute("disabled", "disabled");
		    	    saveInfo();
		    	});
			});
			*/
		});
	    
	    window.onload=function() {
	    	if(adminYn=="N"){
				$("#blockd_start_dt,#blockd_end_dt").datepicker('option', 'disabled', true);
				$("#blockd_rtn_rsn").prop("disabled", true);
				$("#btnReject,#btnAgree,#btnCancle").hide();
			}else{
				$("#blockd_rgst_rsn").prop("disabled", true);
				$("#btnDelete,#btnModify").hide();
			}
	    	
	    	// 요철이 아닐때
	    	if(actType!="1"){
	    		$("#blockd_rgst_rsn").prop("disabled", true);
	    		$("#blockd_type").prop("disabled", true);
	    		$("#btnDelete,#btnModify,#btnReject,#btnAgree,#btnCancle").css( "visibility", "hidden" );
	    		
	    		if(actType=="2"){
	    			$("#btnCancle").css( "visibility", "visible" );
	    		}else if(actType=="3"||actType=="4"||actType=="5"){
	    			$("#blockd_start_dt,#blockd_end_dt").datepicker('option', 'disabled', true);
	    			$("#blockd_rtn_rsn").prop("disabled", true);
	    		}
	    		
	    	}else{
	    		$("#btnCancle").hide();
	    	}
	    }
	    
		function saveInfo() {
			var clickId = this.id;
			var clickNm = this.textContent;
			var clickVal = this.value;
			
			var selectPage = opener.$(".pagination").children().children(2).text();
			
			if($("#blockd_type").val()=="all"){
				alert("차단유형을 선택해주세요.");
				$("#blockd_type").focus();
				return false;
			}
			
			if(clickId == "btnModify"){
				if($("#blockd_rgst_rsn").val().trim()==""){
					alert("차단사유를 입력해주세요.");
					$("#blockd_rgst_rsn").focus();
					return false;
				}
			}
			
			if(clickId != "btnModify" && clickId != "btnDelete"){
				if($("#blockd_rtn_rsn").val().trim()==""){
					alert("결재자의견을 입력해주세요.");
					$("#blockd_rtn_rsn").focus();
					return false;
				}
			}
			
			if(clickId == "btnDelete"){ //삭제
				var data = {
					"seq" : $("#blockd_seq").val(),
					"actType" : clickVal,
					"blockdType" : "",
					"rgstRsn" : "",
					"rgstDttm": "",
					"actId" : ""
				}
			}else if(clickId == "btnModify"){ //수정
				var data = {
					"seq" : $("#blockd_seq").val(),
					"blockdType" : $("#blockd_type").val(),
					"rgstRsn" : $("#blockd_rgst_rsn").val().trim(),
					"rgstDttm": "SYSDATETIME",
					"actType" : "1",
					"actId" : ""
				}
			}else if(clickId == "btnAgree" || clickId == "btnReject" || clickId == "btnCancle"){ //승인, 반려, 해제
				var data = {
					"seq" : $("#blockd_seq").val(),
					"rgstDttm" : "",
					"rgstRsn" : "",
					"actType" : clickVal,
					"actId" : window.sessionStorage.getItem("USERID"),
					"blockdType" : $("#blockd_type").val(),
					"blockdStartDt" : $("#blockd_start_dt").val().replace(/-/gi, ""),
					"blockdEndDt" : $("#blockd_end_dt").val().replace(/-/gi, ""),
					"blockdRtnRsn" : $("#blockd_rtn_rsn").val().trim(),
				}
			}
			
			
			if(confirm(clickNm + "하시겠습니까?")) {
				
				$.ajax({   
					url:"/operator/updateBlock.do",
					dataType:"json",
					type:"post",
					async:true,
					data:data,
					success:function(data) {
						if(data=="200"){
							alert(clickNm+"되었습니다.");
							opener.SelectBlock(selectPage);
							window.close();
						}else{
							alert(clickNm+"실패.");
						}
					},error:function(request, status, error){  
				    	console.log("[" + request.status + "] " + "서비스 오류가 발생하였습니다. 잠시후 다시 실행하십시오.");  
				    }
				});
				
			}
		}
		</script>
	</head>
	<body>
		<div id="detailBolck" class="tbl_type_board" style="width: 95%; margin-top: 30px; margin-bottom: 0px;">
	               		<div style="float: right; margin-bottom: 10px;">
	               			<button class="btnComm_aksung" id="btnDelete" value="5" style="margin-left: 10px;">삭제</button>
	               			<button class="btnComm_aksung" id="btnModify" value="" style="margin-left: 10px;">수정</button>
	               			<button class="btnComm_aksung" id="btnReject" value="3" style="margin-left: 10px;">반려</button>
	               			<button class="btnComm_aksung" id="btnAgree" value="2" style="margin-left: 10px;">승인</button>
	               			<button class="btnComm_aksung" id="btnCancle" value="4" style="margin-left: 10px;">해제</button>
	               		</div>
	               		<table style="width: 100%; border:1px solid #ccc;">
	               			<colgroup>
								<col width="15%">
								<col width="10%">
								<col width="10%">
								<col width="10%">
								<col width="15%">
								<col width="35%">
								<col width="10%">
								<col width="35%">
							</colgroup>
							<tr>
								<input type="hidden" id="blockd_seq" value="${data.seq}">
							  	<th>등록일시</th>
							  	<td id="blockd_rgst_dttm" colspan="3">${data.rgstDttm}</td>
							  	<th>민원인</th>
							  	<td id="blockd_cust_nm">${data.fulnm}</td>
							  	<th>계급</th>
							  	<td id="blockd_rank">${data.rankNm}</td>
							</tr>
							<tr>
							  	<th>연락처</th>
							  	<td id="blockd_telno" colspan="3">${data.telno}</td>
							  	<th>부대</th>
							  	<td id="blockd_full_dept_nm" colspan="3">${data.fullDeptNm}</td>
							</tr>
							<tr>
								<th>휴대전화번호</th>
								<td id="blockd_mpno" colspan="3">${data.mpno}</td>
								<th>부서</th>
							  	<td id="blockd_dept_nm">${data.deptNm}</td>
							  	<th>직책</th>
							  	<td id="blockd_rsponm">${data.rsponm}</td>
							</tr>
							<tr>
							  	<th>유형</th>
							  	<td colspan="3">
							  		<select class="selectBox" style="width: 91%; font-size: 14px;" id="blockd_type" title="유형">
										<option value="all" ${data.type.equals('all')?'selected':'' }>전체</option>
										<option value="1" ${data.type.equals('1')?'selected':'' }>언어폭력</option>
										<option value="2" ${data.type.equals('2')?'selected':'' }>성희롱</option>
										<option value="3" ${data.type.equals('3')?'selected':'' }>업무방해</option>
									</select>
							  	</td>
							  	<th rowspan="2">차단사유</th>
							  	<td colspan="3" rowspan="2">
							  		<textarea id="blockd_rgst_rsn" style="height:70px;" title="차단사유">${data.rgstRsn}</textarea>
							  	</td>
							</tr>
							<tr>
							  	<th>차단일</th>
							  	<td class="selectBox" colspan="3">
								<input type="text" class="text_ol_half"  id="blockd_start_dt" value="${data.strtDate}" maxlength="16" alt="시작날짜" title="시작날짜" style="width: 80px; height: 20px; line-height: 0px; font-size: 13px;"> ~ 
								<input type="text" class="text_ol_half" id="blockd_end_dt" value="${data.endDate}" maxlength="16"  alt="종료날짜" title="종료날짜" style="width: 80px; height: 20px; line-height: 0px; font-size: 13px;">
								</td>
							</tr>
							<tr>
								<th>결재일시</th>
								<td id="blockd_act_dt" colspan="3">${data.actDttm}</td>
								<th rowspan="2">결재자의견</th>
							  	<td colspan="3" rowspan="2">
								   <textarea id="blockd_rtn_rsn" style="height:70px;" title="결재자의견">${data.rtnRsn}</textarea>
								</td>
							</tr>
							<tr>
								<th>등록자</th>
							  	<td id="blockd_rgst_id">${data.rgstId}</td>
							 	<th>결재자</th>
							  	<td id="blockd_act_id">${data.actId}</td>
							</tr>
						</table>
	               	</div>
	</body>
</html>