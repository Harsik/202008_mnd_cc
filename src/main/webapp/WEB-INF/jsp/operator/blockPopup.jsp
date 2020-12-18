<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<title>악성민원인 등록</title>
		
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
	    var nm = '${param.nm}';
	    var tel = '${param.tel}';
	    var stat = '${param.stat}';
	    var type = '${param.type}';
	    var usrId = window.sessionStorage.getItem("USERID");
	    var adminYn = window.sessionStorage.getItem("ADMIN_YN");
	    var mildsc = opener.$("#h_mildsc").val(); 			//부대
	    var deptNm = opener.$("#h_deptNm").val();			//부서
	    var fullDeptNm = opener.$("#h_fullDeptNm").val();	//직책
	    
	    function init(){
	    	$("#crt_dt").html(getDate()+" "+getTime());	// 등록일시
	    	
	    	$("#block_dt").html(getDate()+" ~ "+getDateAdd()); // 차단일 : 오늘 ~ 7일후
	    	
	    	$("#cust_nm").html(nm);
	    	$("#cust_tel").html(tel);
	    	$("#cust_type").val(stat);
	    	$("#crt_id").html(usrId);
	    	$("#cust_group").html(mildsc);
    		$("#cust_dept").html(deptNm);
    		$("#cust_position").html(fullDeptNm);
	    }
	    
	    function getDateAdd(){
	    	var nowDate = new Date();
	    	var FormatDate = nowDate.toLocaleDateString( nowDate.setDate(nowDate.getDate() + 7) );
	    	var arrDate = FormatDate.split(" ");
	    	
	    	var y = arrDate[0].replace(/년/g, "");
	    	var m = arrDate[1].replace(/월/g, "");
	    	var d = arrDate[2].replace(/일/g, "");
	    	
	    	if(m.length == 3) m = "0" + m;
	    	if(d.length == 3) d = "0" + d;
	    	
	    	return y + "-" + m + "-" + d;
	    }
	    
	    function saveInfo(){
	    	
	    	// 민원인 정보 찾기
	    	$.ajax({   
				url:"/operator/selectUser.do",
				type:"post",
				dataType:'json',
				data:{
					//dept_nm 으로도 조회하면 좋을것 같음
					"telno":tel.replace(/-/gi, "").trim(),	//전화번호
					"fulnm":nm.trim(),	//이름
				},
				success:function(data) {
					console.log(data);
					var result = data.map;
					
					var blockDtArr = $("#block_dt").html().split(" ~ ");
					var blockStartDt = blockDtArr[0].replace(/-/gi, "");
					var blockEdnDt = blockDtArr[1].replace(/-/gi, "");
					// 악성민원인 등록
					$.ajax({   
						url:"/operator/insertBlock.do",
						type:"post",
						dataType:"json",
						async:true,
						data:{
							"fulnm"			:nm,							//이름
							"type"			:$("#cust_type").val(),			//유형	1:언어폭력/2:성희롱/3:기타업무방해
							"mdcd"			:result.mildsc,					//군별코드
							"servno" 		:result.milNo,					//군번
							"dept_cd" 		:result.deptCd,					//부서코드
							"dept_nm"		:$("#cust_dept").html().trim(),	//부서명
							"full_dept_nm"	:$("#cust_group").html().trim(),//전체부서명
							"rank_nm"       :result.rank,					//계급
							"rsponm"       	:$("#cust_position").html().trim(),				//직책
							"telno"         :result.telno,					//일반전화번호
							"mpno"          :result.mpno,					//핸드폰
							"strt_date"     :blockStartDt,					//차단시작일
							"end_date"		:blockEdnDt,					//차단종료일
							"rgst_rsn"      :$("#block_content").html().trim(),	//등록사유
							"rgst_id"       :usrId,							//등록자
							"act_type"      :adminYn == "Y" ? "2" : "1",	//처리유형	1:등록요청/2:승인/3:반려 (관리자면 바로 승인)
							"act_id"        :usrId,							//처리자
							
						},
						success:function(data) {
					        alert("요청되었습니다.");
					        opener.$("#h_nm").val(""); 			//성명
					        opener.$("#h_tfTelno").val(""); 	//연락처
					        opener.$("#h_fullDeptNm").val("");	//조직 
					        opener.$("#h_deptNm").val(""); 		//부서
					        opener.$("#h_mildsc").val(""); 		//군
					        window.close();
						},error:function(request, status, error){  
					    	console.log("[" + request.status + "] " + "서비스 오류가 발생하였습니다. 잠시후 다시 실행하십시오.");  
					    } 
					});
					
				}
			});
	    	
	    	
	    }
	    
	    $(document).ready(function(){
	    	init();
	    	
	    	//저장버튼 클릭 이벤트(중복클릭 방지)
	    	var saveBtn = document.querySelector("#saveBtn");
	    	saveBtn.addEventListener("click", function (e) {
	    	    this.setAttribute("disabled", "disabled");
	    	    saveInfo();
	    	});
	    
	    });
	    
		</script>
	</head>
	<body>
		<div>
			<button type="button" name="saveBtn" id="saveBtn" class="button" title="저장" style="margin: 0px 0px 9px 986px;">저장</button>
		</div>
		<div>
			<table style="width: 90%; margin-left: 60px;">
				<colgroup>
					<col width="*">
				</colgroup>
				<tbody>
					<tr>
					   <th>등록일시</th>
					   <td id ="crt_dt" style="width: 23%;"></td>
					   <th>민원인</th>
					   <td id ="cust_nm" style="width: 150px;"></td>
					   <th>직책</th>
					   <td id ="cust_position" style="width: 300px;"></td>
					</tr>
					<tr>
					   <th>연락처</th>
					   <td id ="cust_tel"></td>
					   <th>부대</th>
					   <td colspan="3" id="cust_group"></td>
					</tr>
					<tr>
					   <th>유형</th>
					   <td>
							<select id ="cust_type" title="유형">
								<option value="1">언어폭력</option>
								<option value="2">성희롱</option>
								<option value="3">기타업무방해</option>
							</select>
						</td>
					   <th>부서</th>
					   <td colspan="3"><div id="cust_dept" style="-ms-overflow-y: scroll;"></div></td>
					</tr>
					<tr>
					   <th>차단일</th>
					   <td id ="block_dt"></td>
					   <th rowspan="2">차단사유</th>
					   <td rowspan="2" colspan="3">
					   <textarea style="height:173px;" id="block_content" title="차단사유"></textarea>
					   </td>
					</tr>
					<tr>
					   <th>등록자</th>
					   <td id="crt_id"></td>
					</tr>
				</tbody>
			 </table>
		</div>
	</body>
</html>