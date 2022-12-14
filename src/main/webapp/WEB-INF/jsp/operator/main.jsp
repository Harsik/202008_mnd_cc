<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/layout/include/incHeader.jspf" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
	<link rel="stylesheet" type="text/css" href="../css/common.css" />  
	<link rel="stylesheet" type="text/css" href="../css/tabs.css"/>
	<link rel="stylesheet" type="text/css" href="../jsTree/jstree.3.3.5/dist/themes/default/style.min.css"/>
    <link rel="stylesheet" type="text/css"	href="../jqueryui/jquery-ui.css" />
	
	<script type="text/javascript"	src="../jsTree/jstree.3.3.5/jquery-1.12.1.js"></script>
	
	<script type="text/javascript"	src="../jqueryui/jquery-ui.js"></script>  
	<script type="text/javascript" src="../js/tabs.js"></script>
	<script type="text/javascript" src="../js/common.js"></script> 
    <script type="text/javascript" src="../jsTree/jstree.3.3.5/dist/jstree.min.js"></script>
	
	  
	<script type="text/javascript">
	
	var mildsc = "";
	var id = "";
	var dept_cd = "";
	var nodeId = "";
	var ckMildsc = "";
	var JsonArrayA = new Array();
	var JsonArrayB = new Array();
	var JsonArrayC = new Array();
	var JsonArrayD = new Array();
	
		$(document).ready(function(){
			// 통화상태 감지 이벤트
			$('#MainStatusNm').on('DOMSubtreeModified', function() {
				var stat = $('#MainStatusNm').text();
				console.log("change >>> "+ stat);
				if(stat=="[통화중]"){
					$(".bottonButton").hide();
					$(".outCall_box01 .tit_i").html("아웃콜 정보");
				}else{
					$(".bottonButton").show();
					$(".outCall_box01 .tit_i").html("사용자 정보");
				}
			});
			// 정렬 start
			$("th[name=sortbtn]").click(function(){
// 				alert('test : '+$(this).attr("data"));
				var compare = $("#sortField").val();
				var order = $("#sortOrder").val();
				
				if(compare === $(this).attr("data")){
					if(order==="desc"){
						$("#sortOrder").val("asc");
					}else{
						$("#sortOrder").val("desc");
					}
				}
				$("#sortField").val($(this).attr("data"));
				search();
			});
			
			// 정렬 end
			
			$("#searchThead").hide();
			$(".treePopWrap").hide();

			
 			/* function checkKeyPressed(e) {
			    if (e.keyCode == "44") {
			    	
			        alert("The print screen button was pressed.");
			        
			        e.keyCode = 0;
			        e.canceBubble = true;
			        e.returnValue = false;
			    }
			} */

			//window.addEventListener("keyup", checkKeyPressed, false);
			 
			 
			/* 국방부 */
			$.ajax({   
				url:"/operator/getTree.do",
				dataType:'json',
				async:true,
				data:{"mildsc":"A","hgrnkDeptCd":"#"},
				success:function(data) {
			        $.each(data, function(idx, item){
			        	JsonArrayA[idx] = {id:item.id, parent:item.parent, text:item.text};
			        });
					
				},
				complete:function(){
					createTree("A");
				}
				
			});
			
			/* 육군 */
			$.ajax({   
				url:"/operator/getTree.do",
				dataType:'json',
				async:true,
				data:{"mildsc":"B","hgrnkDeptCd":"#"},
				success:function(data) {
					
			        $.each(data, function(idx, item){
			        	JsonArrayB[idx] = {id:item.id, parent:item.parent, text:item.text};
			        });
					
				},
				complete:function(){
					createTree("B");
				}
				
			});
			
			
			/* 해군 */
			$.ajax({   
				url:"/operator/getTree.do",
				dataType:'json',
				async:true,
				data:{"mildsc":"C","hgrnkDeptCd":"#"},
				success:function(data) {
					
			        $.each(data, function(idx, item){
			        	JsonArrayC[idx] = {id:item.id, parent:item.parent, text:item.text};
			        });
					
				},
				complete:function(){
					createTree("C");
				}
				
			});
			
			/* 공군 */
			$.ajax({   
				url:"/operator/getTree.do",
				dataType:'json',
				async:true,
				data:{"mildsc":"D","hgrnkDeptCd":"#"},
				success:function(data) {
			        $.each(data, function(idx, item){
			        	JsonArrayD[idx] = {id:item.id, parent:item.parent, text:item.text};
			        });
				},
				complete:function(){
					createTree("D");
				}
				
			});
			
			// 악성민원 버튼 클릭 이벤트
	        $("#btnIn_Aksung1,#btnIn_Aksung2,#btnIn_Aksung3,#btnOut_Aksung1,#btnOut_Aksung2,#btnOut_Aksung3").bind("click", blockPopup);
			
	        datePicker("#start_dt");
			datePicker("#end_dt");
			$("#start_dt").val(retDate());
			$("#end_dt").val(getDate());
			
			datePicker("#blockd_start_dt");
			datePicker("#blockd_end_dt");
			
			// 악성민원 탭 클릭 이벤트
			$(".tab-link").eq(2).click(function(){
				SelectBlock("0");
			});
			
			// 악성민원 조회 이벤트
			$("#btnSelectBlock").click(function(){
				SelectBlock("0");
		  	});
			
			// 악성민원 조회 엔터 이벤트
			$("#cust_info_search").keyup(function (key) {
				if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
					SelectBlock("0");
				}
			});
			
			// 악성민원 IVR
			datePicker("#ivr_start_dt");
			datePicker("#ivr_end_dt");
			$("#ivr_start_dt").val(retDate());
			$("#ivr_end_dt").val(getDate());
			
			// IVR 탭 클릭 이벤트
			$(".tab-link").eq(3).click(function(){
				SelectBlockIvr("0");
			});
			
			// IVR 조회 이벤트
			$("#btnSelectBlockIvr").click(function(){
				SelectBlockIvr("0");
		  	});
			
			// IVR 조회 엔터 이벤트
			$("#block_ivr_search_content").keyup(function (key) {
				if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
					SelectBlockIvr("0");
				}
			});
			
			if(window.sessionStorage.getItem("ADMIN_YN")=="N"){
				$("#btnExcelBlockIvr").css( "visibility", "hidden" );
			}
			
			$("#btnExcelBlockIvr").bind("click", btnExcelBlockIvrClickEvent);
			
		});// ready END
		
		function blockPopup(){
			var custTel = "";	// 번호
			var custNm	= "";	// 이름
			var custStat= "";	// 버튼 유형 : 1:언어폭력/2:성희롱/3:업무방해	
			var callType= "";	// 콜 타입 : id값을 넘겨서 in/out 판단
			var trnsCall= "";	// 전달큐
			
			callType= this.id;
			custStat= this.value;
			
			if(callType=="btnIn_Aksung1" || callType=="btnIn_Aksung2" || callType=="btnIn_Aksung3"){ //IN
				if(!bCalling){
					alert("통화중 일때만 가능합니다.");
					return false;
				}
				custTel = $("#tfTelno").val();
				custNm	= $("#nm").val();
			}else{
				custTel = $("#outTelno").val();
				custNm	= $("#outNm").val();
			}
			
			if(custStat=="1"){
				trnsCall = "3010";
			}else if(custStat=="2"){
				trnsCall = "3011";
			}else{
				trnsCall = "3012";
			}
			
			if(callType=="btnIn_Aksung1" || callType=="btnIn_Aksung2" || callType=="btnIn_Aksung3"){ //IN
				if(confirm(this.title + "에 대한 자동 음원 송출을 하시겠습니까?")){
					// 전화가 끊기면 text가 초기화 되기때문에 hidden 값에 넣어놓기
					$("#h_nm").val($("#nm").val()); 				//성명
					$("#h_tfTelno").val($("#tfTelno").val()); 		//연락처
					$("#h_fullDeptNm").val($("#fullDeptNm").val());	//조직 
					$("#h_deptNm").val($("#deptNm").val()); 		//부서
					$("#h_mildsc").val($("#mildsc").val()); 		//군
					
					blockIvrInsert(custStat,custNm,custTel);
					block_popupEvent(custTel,custNm,custStat,callType);
					
 					fnSingleStepTransfer(trnsCall,"",custTel);		// 특정큐로 호전환
	 				window.sessionStorage.setItem("callType",""); 	// 초기화
				}
			}else{	//OUT
				if($("#outNm").val()=="" || $("#outTelno").val()==""){
					alert("민원인 정보를 기입해주세요.");
					return false;
				}
			
				$("#h_nm").val($("#outNm").val()); 					//성명
				$("#h_tfTelno").val($("#outTelno").val()); 			//연락처
				$("#h_fullDeptNm").val($("#outFullDeptNm").val());	//조직 
				$("#h_deptNm").val($("#outDeptNm").val()); 			//부서
				$("#h_mildsc").val($("#outMildsc").val()); 			//군
				
				block_popupEvent(custTel,custNm,custStat,callType);
			}
		}
		
		function block_popupEvent(tel,nm,stat,type){
			var width = 1100;
			var height = 400;
			var left = Math.ceil((window.screen.width - width)/2);
			var top = Math.ceil((window.screen.height - height)/2);
			
			var paramURL = getContextPath() + "/operator/blockPopup.do?tel="+encodeURI(tel)+"&nm="+encodeURI(nm)+"&stat="+stat+"&type="+type;
			var option = "width=" + width + ", height=" + height
				+ ", toolbar=no, directories=no, scrollbars=auto, location=no, resizable=no, status=no,menubar=no, top="
				+ top + ",left=" + left +"";

			var newWindow = window.open(paramURL, "악성민원", option);
			newWindow.focus();
			
			// 팝업창 열려 있는지 확인
// 		    if(windowObjHistorySearch == null) {
// 		    	console.log("1");
// 		        windowObjHistorySearch = window.open(paramURL, "악성민원", option);
// 		    } else {
// 		        if(windowObjHistorySearch.closed) {
// 		        	console.log("2");
// 		            windowObjHistorySearch = window.open(paramURL, "악성민원", option);
// 		        }
// 		    }
// 		    windowObjHistorySearch.focus();
			
		}
		
		function SelectBlock(pageNum){
			$.ajax({   
				url:"/operator/selectBlockList.do",
				dataType:'json',
				type:"post",
				async:true,
				data:{
					"setPageNum" : pageNum,
					"dateType"	 : $("#date_type").val(),
					"startDt"	 : $("#start_dt").val().replace(/-/gi, ""),
					"endDt"	 	 : $("#end_dt").val().replace(/-/gi, ""),
					"blockType"	 : $("#block_type").val(),
					"blockStat"	 : $("#block_stat").val(),
					"blockSearch"	 : $("#block_search").val(),
					"blockSearchContent"	 : $("#cust_info_search").val().replace(/-/gi, ""),
					"adminYn"	 : window.sessionStorage.getItem("ADMIN_YN"),
					"usrId"		 : window.sessionStorage.getItem("USERID"),
				},
				success:function(data) {
					console.log("data >> "+data);
					setBlockPaging(data);
					createBlock(data);
				},
			});
		}
		
		function setBlockPaging(data){
			var htmlStr = "";
			htmlStr += "<div class='pagination'>";
			htmlStr += "<a href='javascript:void(0)' onclick='SelectBlock("+data.paging.prevPageNo+");' class='list_btn'><img src='../images/operator/paging_btn_prev.png' alt='이전'/></a>";
			var pageSizeVal = data.paging.endPageNo - data.paging.startPageNo;

			for (var i = data.paging.startPageNo; i <= data.paging.endPageNo; i++) {
				if (i == data.paging.pageNo) {
					htmlStr += "<a href='javascript:void(0)' onclick='SelectBlock("+i+");' class='list_btn'><b>"+i+"</b></a>";
				} else {
					htmlStr += "<a href='javascript:void(0)' onclick='SelectBlock("+i+");' class='list_btn'>"+i+"</a>";
				}
			}
			htmlStr += "<a href='javascript:void(0)' onclick='SelectBlock("+data.paging.nextPageNo+");' class='list_btn'><img src='../images/operator/paging_btn_next.png' alt='다음'/></a>";
			htmlStr += "</div>";
			$("#block_paging").html(htmlStr);
		}
		
		function createBlock(data){
			$("#content_block tbody").empty();
			
			var datas = data.list;
			
			if(datas.length != 0){ // data != null
				var str = "";
				$.each(datas , function(i){
					var tel = datas[i].telno.replace(/ /gi, "");
					str += "<TR id='blockTr'>";
					str += '<input type="hidden" id="seq" value='+datas[i].seq+'>'; //PK
					str += '<td>'+datas[i].rownum+'</td>'; 		//번호
					str += '<td>'+datas[i].rgstDttm+'</td>'; 	//등록일시
					str += '<td>'+datas[i].rgstId+'</td>';		//교환원
					if(datas[i].rgstRsn.length > 19){
						str += '<td>'+datas[i].rgstRsn.substr(0,19)+'...</td>';	//차단사유
					}else{
						str += '<td>'+datas[i].rgstRsn+'</td>';
					}
					if(datas[i].type == "1"){ 					//유형 - 1:언어폭력, 2:성희롱, 3:업무방해
						str += '<td>언어폭력</td>';
					}else if(datas[i].type == "2"){
						str += '<td>성희롱</td>';
					}else if(datas[i].type == "3"){
						str += '<td>업무방해</td>';
					}
					
					if(datas[i].actType == "1"){
						str += '<td>요청</td>';
					}else if(datas[i].actType == "2"){
						str += '<td>승인</td>';
					}else if(datas[i].actType == "3"){
						str += '<td>반려</td>';
					}else if(datas[i].actType == "4"){
						str += '<td>해제</td>';
					}else if(datas[i].actType == "5"){
						str += '<td>삭제</td>';
					}
					str += '<td>'+datas[i].strtDate+" ~ "+datas[i].endDate+'</td>';		//차단일
					str += '<td>'+telnoFormat(datas[i].mpno)+'</td>';		//휴대전화 번호
					str += '<td>'+datas[i].fulnm+'</td>';		//민원인
					str += '</TR>';
				});
				
				$("#content_block tbody").append(str); 
				$("#block_paging").show(); 
			} else{
				$("#block_paging").hide();
			}
		}
		
		// 악성민원 리스트 클릭시 상세 팝업 호출 이벤트
		$(document).on( "dblclick","#blockTr", function() {
			$("#content_block tbody tr").css("background-color", "white" );
			$( this ).css( "background-color", "#f4f4f4" );
			var tr = $(this);
			var td = tr.children();
			
			var seq = td.eq(0).val();			//PK
			
			blockDetail_popupEvent(seq);
		});
		
		// 악성민원 상세 팝업
		function blockDetail_popupEvent(seq){
			var width = 1200;
			var height = 400;
			var left = Math.ceil((window.screen.width - width)/2);
			var top = Math.ceil((window.screen.height - height)/2);
			
			var paramURL = getContextPath() + "/operator/blockDetailPopup.do?seq="+seq;
			var option = "width=" + width + ", height=" + height
				+ ", toolbar=no, directories=no, scrollbars=auto, location=no, resizable=no, status=no,menubar=no, top="
				+ top + ",left=" + left +"";

			var newWindow = window.open(paramURL, "악성민원상세", option);
			newWindow.focus();
		}
		
		//Block End
		
		
		//Block Ivr Start
		function blockIvrInsert(callState,custNm,custTel){
			var callConnTime = gCallConnectTime.replace(/\B(?=(\d{2})+(?!\d))/g, ':');
			var sldrYn	= "Y";
			var telYn	= "N";
			
			if(custNm == "미등록인"){
				sldrYn = "N";
			}
			
			if(custTel.substr(0,2)=="01" && custTel.length >= 10){
				telYn = "Y";
			}
			
			$.ajax({
				url : "/operator/insertBlockIvr.do",
				type : "post",
				dataType : 'json',
				data : {
					"callState"	: callState,		// 1: 언어폭력, 2: 성희롱, 3:업무방해
					"custNm"	: custNm,			// 민원인명
					"custTel"	: custTel.replace(/-/gi, "").trim(),	// 민원인번호
					"custTelYn"	: telYn,			// 번호구분	Y: 휴대전화번호, N: 일반전화번호
					"sldrYn"	: sldrYn,			// 군인구분	Y: 군인, N: 미등록인
					"callDttm"	: callConnTime,		// 호인입시간
					"rgstId"	: window.sessionStorage.getItem("USERID"),	// 상담원
				},
				success : function(data) {
					if(data.result > 0){
						SelectBlockIvr("0");
					}else{
						// 군인임에도 해당 데이터가 조회가 안 될 경우, 이름/인입번호라도 저장
						$.ajax({
							url : "/operator/insertBlockIvr.do",
							type : "post",
							dataType : 'json',
							data : {
								"callState"	: callState,		// 1: 언어폭력, 2: 성희롱, 3:업무방해
								"custNm"	: custNm,			// 민원인명
								"custTel"	: custTel.replace(/-/gi, "").trim(),	// 민원인번호
								"custTelYn"	: telYn,			// 번호구분	Y: 휴대전화번호, N: 일반전화번호
								"sldrYn"	: "N",				// 군인구분	Y: 군인, N: 미등록인
								"callDttm"	: callConnTime,		// 호인입시간
								"rgstId"	: window.sessionStorage.getItem("USERID"),	// 상담원
							},
							success : function(data) {
								if(data.result > 0){
									SelectBlockIvr("0");
								}
							},
							error : function(data, status, err){ 
								console.log("insert BLOCK IVR ERROR :: " + data);
							}

						});
					}
					
				},
				error : function(data, status, err){ 
					console.log("insert BLOCK IVR ERROR :: " + data);
				}

			});
		}
		
		function SelectBlockIvr(pageNum){
			$.ajax({   
				url:"/operator/selectBlockIvrList.do",
				dataType:'json',
				type:"post",
				async:true,
				data:{
					"setPageNum" : pageNum,
					"startDt"	 : $("#ivr_start_dt").val().replace(/-/gi, ""),
					"endDt"	 	 : $("#ivr_end_dt").val().replace(/-/gi, ""),
					"ivrType"	 : $("#block_ivr_type").val(),
					"searchType" : $("#block_ivr_search").val(),
					"searchContent" : $("#block_ivr_search_content").val().replace(/-/gi, ""),
					"adminYn" 		: window.sessionStorage.getItem("ADMIN_YN"),
					"userId" 		: window.sessionStorage.getItem("USERID")
				},
				success:function(data) {
					console.log("data >> "+data);
					setBlockIvrPaging(data);
					createBlockIvr(data);
				},
			});
		}
		
		function setBlockIvrPaging(data){
			var htmlStr = "";
			htmlStr += "<div class='pagination'>";
			htmlStr += "<a href='javascript:void(0)' onclick='SelectBlockIvr("+data.paging.prevPageNo+");' class='list_btn'><img src='../images/operator/paging_btn_prev.png' alt='이전'/></a>";
			var pageSizeVal = data.paging.endPageNo - data.paging.startPageNo;

			for (var i = data.paging.startPageNo; i <= data.paging.endPageNo; i++) {
				if (i == data.paging.pageNo) {
					htmlStr += "<a href='javascript:void(0)' onclick='SelectBlockIvr("+i+");' class='list_btn'><b>"+i+"</b></a>";
				} else {
					htmlStr += "<a href='javascript:void(0)' onclick='SelectBlockIvr("+i+");' class='list_btn'>"+i+"</a>";
				}
			}
			htmlStr += "<a href='javascript:void(0)' onclick='SelectBlockIvr("+data.paging.nextPageNo+");' class='list_btn'><img src='../images/operator/paging_btn_next.png' alt='다음'/></a>";
			htmlStr += "</div>";
			$("#block_ivr_paging").html(htmlStr);
		}
		
		function createBlockIvr(data){
			$("#content_block_ivr tbody").empty();
			
			var datas = data.list;
			
			if(datas.length != 0){ // data != null
				var str = "";
				$.each(datas , function(i){
					var tel = datas[i].ani.replace(/ /gi, "");
					str += "<TR id='blockIvrTr'>";
					str += '<input type="hidden" id="seq" value='+datas[i].seq+'>'; //PK
					str += '<td>'+datas[i].rownum+'</td>'; 		//번호
					str += '<td>'+datas[i].rgstDttm+'</td>'; 	//등록일시
					str += '<td>'+datas[i].rgstId+'</td>';		//교환원
					if(datas[i].type == "1"){ 					//유형 - 1:언어폭력, 2:성희롱, 3:업무방해
						str += '<td>언어폭력</td>';
					}else if(datas[i].type == "2"){
						str += '<td>성희롱</td>';
					}else if(datas[i].type == "3"){
						str += '<td>업무방해</td>';
					}
					str += '<td>'+telnoFormat(datas[i].ani)+'</td>';	//휴대전화 번호
					str += '<td>'+datas[i].fulnm+'</td>';				//민원인
					str += '</TR>';
				});
				
				$("#content_block_ivr tbody").append(str); 
				$("#block_ivr_paging").show(); 
			} else{
				$("#block_ivr_paging").hide();
			}
		}
		
		function btnExcelBlockIvrClickEvent(){
			$(window).off("beforeunload");
	    	  
	    	var param = {
	    		    "startDt"	 : $("#ivr_start_dt").val().replace(/-/gi, ""),
					"endDt"	 	 : $("#ivr_end_dt").val().replace(/-/gi, ""),
					"ivrType"	 : $("#block_ivr_type").val(),
					"searchType" : $("#block_ivr_search").val(),
					"searchContent" : $("#block_ivr_search_content").val().replace(/-/gi, ""),
					"adminYn" 		: window.sessionStorage.getItem("ADMIN_YN"),
					"userId" 		: window.sessionStorage.getItem("USERID"),
	    		 	"colHeader"	: ["rownum","type","fulnm","servno","fullDeptNm","rankNm","ani","telno","callDttm","rgstDttm","rgstId"],
	    		 	"colName"	: ["번호","유형","이름","군번","부대","계급","인입번호","군전화번호","인입시간","송출시간","교환원"],
	    		 	"title"	:   "악성민원"
	    	};
	    	  
	        var form = document.createElement("form");
	        form.setAttribute("method", "post");
	        form.action = "/csv/blockIvrCsvDownload.do";
	         
	        var hiddenField = document.createElement("input");
		    hiddenField.setAttribute("type", "hidden");
		    hiddenField.setAttribute("name", "excelDown");
		    hiddenField.setAttribute("value", JSON.stringify(param));
		    form.appendChild(hiddenField);
		    document.body.appendChild(form);
	          
		    form.submit();
	     }
		
		
		//Block Ivr End
		
		function createTree(mildsc){
			
			 $(".treePopWrap").dialog({
				autoOpen: false,
			    resizable: false, 
			    width: 1000,
			    height : 700,
			   // modal: true,
			    draggable: true,
			    closeOnEscape: false,
			    open: function(event, ui)
			    {
			    	$(".ui-dialog-titlebar", ui.dialog | ui).hide();
			    	$(".ui-dialog-titlebar-close", ui.dialog | ui).hide();
			    	
	    	}
	     });   

			
			if(mildsc=='A'){
				$('#treeA').jstree({
					 'core' : {
					 	"check_callback" : false,
					      /* 'data' : [
						       { "id" : "ajson1", "parent" : "#", "text" : "Simple root node" },
						       { "id" : "ajson2", "parent" : "#", "text" : "Root node 2" },
						       { "id" : "ajson3", "parent" : "ajson2", "text" : "Child 1" },
						       { "id" : "ajson4", "parent" : "ajson2", "text" : "Child 2" },
						    ]  */
						'data' : JsonArrayA
						
						} 
				})
				.bind("select_node.jstree", function(evt, data) {       // 노드가 선택된 뒤 처리할 이벤트
					
					nodeId = data.node.id;
					
	 
	 					treeInit("0",mildsc,nodeId);
				
	     	  });
			}else if(mildsc=='B'){
				$('#treeB').jstree({
					 'core' : {
					 	"check_callback" : false,
					     /* 'data' : [
						       { "id" : "ajson1", "parent" : "#", "text" : "Simple root node" },
						       { "id" : "ajson2", "parent" : "#", "text" : "Root node 2" },
						       { "id" : "ajson3", "parent" : "ajson2", "text" : "Child 1" },
						       { "id" : "ajson4", "parent" : "ajson2", "text" : "Child 2" },
						    ] */
						'data' : JsonArrayB
						
						} 
				})
				.bind("select_node.jstree", function(evt, data) {       // 노드가 선택된 뒤 처리할 이벤트
									
					nodeId = data.node.id;
	 					treeInit("0",mildsc,nodeId);
	     	  });
			}else if(mildsc=='C'){
				$('#treeC').jstree({
					 'core' : {
					 	"check_callback" : false,
					     /* 'data' : [
						       { "id" : "ajson1", "parent" : "#", "text" : "Simple root node" },
						       { "id" : "ajson2", "parent" : "#", "text" : "Root node 2" },
						       { "id" : "ajson3", "parent" : "ajson2", "text" : "Child 1" },
						       { "id" : "ajson4", "parent" : "ajson2", "text" : "Child 2" },
						    ] */
						'data' : JsonArrayC
						
						}
				})
				.bind("select_node.jstree", function(evt, data) {       // 노드가 선택된 뒤 처리할 이벤트
					
					nodeId = data.node.id;
					$("#popWrap").dialog({
						autoOpen: false,
					    resizable: false, 
					    width: 1000,
					    height : 700,
					   // modal: true,
					    draggable: true,
					    closeOnEscape: false,
					    open: function(event, ui)
					    {
					    	$(".ui-dialog-titlebar", ui.dialog | ui).hide();
					    	$(".ui-dialog-titlebar-close", ui.dialog | ui).hide();
					    	
				    	}
				     }); 
	 
	 					treeInit("0",mildsc,nodeId);
	     	  });
			}else if(mildsc=='D'){
				$('#treeD').jstree({
					 'core' : {
					 	"check_callback" : false,
					     /* 'data' : [
						       { "id" : "ajson1", "parent" : "#", "text" : "Simple root node" },
						       { "id" : "ajson2", "parent" : "#", "text" : "Root node 2" },
						       { "id" : "ajson3", "parent" : "ajson2", "text" : "Child 1" },
						       { "id" : "ajson4", "parent" : "ajson2", "text" : "Child 2" },
						    ] */
						'data' : JsonArrayD
						
						
						}
				})
				.bind("select_node.jstree", function(evt, data) {       // 노드가 선택된 뒤 처리할 이벤트
					
					nodeId = data.node.id;
					/* $("#popWrap").dialog({
						autoOpen: false,
					    resizable: false, 
					    width: 1000,
					    height : 700,
					   // modal: true,
					    draggable: true,
					    closeOnEscape: false,
					    open: function(event, ui)
					    {
					    	$(".ui-dialog-titlebar", ui.dialog | ui).hide();
					    	$(".ui-dialog-titlebar-close", ui.dialog | ui).hide();
					    	
				    	}
				     });  */
	 
	 					treeInit("0",mildsc,nodeId);
	     	  });
			}
			
		}
		

		function treeInit(num,mildsc,nodeId) {
				
			$.ajax({
				url : "/operator/selectDeptList.do",
				type : "post",
				dataType : 'json',
				data : {
					"mildsc" : mildsc,
					"deptCd" : nodeId,
					"setPageNum":num
				},
				success : function(data) {
					treePopup(data,mildsc,nodeId);
				}

			});
			
		}
		
		$(document).on("click","#closeBt", function() {
			$('.treePopWrap').dialog('close');
		}) 
		

		function treePopup(result,mildsc,nodeId) {
			
			setTreePaging(result,mildsc,nodeId);	
			var html = "";
			if(result.list.length != 0) {
				
				$("#thPop").show();
				$.each(result.list, function(i, value) {
					html += "	<tr id='treeTr'>";
				/*	html += "		<td>"+ value.mildscNm +"</td>"; */
					html += "		<td>"+ value.fullDeptNm +"</td>";
					html += "		<td>"+ value.telno +"</td>";
					html += "		<td>"+ value.rank +"</td>";
					html += "		<td>"+ value.nm +"</td>";
					html += "		<td>"+ value.rspsbltBiznes +"</td>";
					html += "		<td>"+ value.mpno +"</td>";
					html += "	</tr>";
					
				});
				$("#tPop").show();
				$("#datatext").hide();
				$("#tPop").html(html);
				$("#paging").show();
			} else {
					
				$("#thPop").hide();
				$("#tPop").hide();
				$("#paging").hide();
				html = "<p>조직정보가 없습니다.</p>";
				$("#datatext").html(html);
			}	
			$(".treePopWrap").dialog("open");
		}

		function paginTree(num,mildsc,nodeId) {
			treeInit(num,mildsc,nodeId);
		}
		
		$(document).on("click",".pagination a", function() {
			var arrId = $(this).attr("id");
			
			var val = arrId.split(",");
			paginTree(val[0],val[1],val[2]);
			
			
		});
		
		function setTreePaging(result,mildsc,nodeId){
			var htmlStr = "";
			htmlStr += "<div class='pagination'>";
			htmlStr += "<a href='javascript:void(0)' id='"+ result.paging.prevPageNo+ ","+mildsc +","+nodeId+"' class='list_btn'><img src='../images/operator/paging_btn_prev.png' alt='이전'/></a>";
			var pageSizeVal = result.paging.endPageNo - result.paging.startPageNo;

			for (var i = result.paging.startPageNo; i <= result.paging.endPageNo; i++) {
				if (i == result.paging.pageNo) {
					htmlStr += "<a href='javascript:void(0)' id='" + i + ","+mildsc +","+nodeId+"' class='list_btn'><b>" + i + "</b></a>";
				} else {
					htmlStr += "<a href='javascript:void(0)' id='" + i + ","+mildsc +","+nodeId+"' class='list_btn'>" + i + "</a>";
				}
			}
			htmlStr += "<a href='javascript:void(0)' id='"+ result.paging.nextPageNo+ ","+mildsc +","+nodeId+"' class='list_btn'><img src='../images/operator/paging_btn_next.png' alt='다음'/></a>";
			htmlStr += "</div>";
			$("#paging").html(htmlStr);
		}
		
		
		
		$(document).on("mouseenter","#treeTr", function() {
			$( this ).css( "background-color", "#f4f4f4" );
			 $( this).children("td").css( "cursor", "pointer" );

		});
		
		$(document).on( "mouseleave","#treeTr", function() {
			 $( this ).css( "background-color", "white" );
    	 }); 
		
		
		$(document).on( "click","#treeTr", function() {
			
			
			var tr = $(this);
			var td = tr.children();
			
            		var mildsc = td.eq(0).text();
			var temptelno = td.eq(1).text();
			var telno = "";
			var deptNm = td.eq(4).text();
			var rank = td.eq(3).text();
			var fullNm = td.eq(0).text();
			var nm = td.eq(3).text();
			
			var pattern =/[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]|[가-힣]/gi; // 정규식
			try{ 
				var arrTelno = temptelno.split(',');
				var filtNum=arrTelno[0].replace(pattern, "");
				//telno=getPhoneNumFormat(filtNum);
				telno=filtNum;
			}catch(e){
				//telno=getPhoneNumFormat(temptelno);
				var filtNum=temptelno.replace(pattern, "");
				telno=filtNum;
			}
			
	        $("input[id=outNm]").val(nm);					
			$("input[id=outTelno]").val(telno);					
			$("input[id=outDeptNm]").val(deptNm);					
			
			$("input[id=outMildsc]").val(mildsc); 					
        	$("input[id=outFullDeptNm]").val(fullNm); 
			
        	$(tr).dblclick( function() {
        		$('.treePopWrap').dialog('close');
        	})
        
   	 	}); 
		
		/*조족도  끝  */
		
		$(document).ready(function(){
			$("#query").keyup(function (key) {
				if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
					search();
				}
			});
		});
		
		// 전화번호 검색 자동완성 기능 추가 20.10.20
		// 미사용일때는 ajax안돌도록 변경 21.01.04
		$(function(){
		    $("#query").autocomplete({
		        source : function( request, response) {
		        	if($("#searchCnt").val() != 0){
			            $.ajax({
			                type:"post",
			                async:true,
			                url:"/operator/search2.do",
			                dataType: "json",
			                data : {
			                	"searchContent" : $("#query").val().trim(),
			                	"searchCnt" : $("#searchCnt").val()
			                	},
			                success: function(data){
			                	data = data.list;
			                	console.log(data);
			                    //서버에서 json 데이터 response 후 목록에 뿌려주기 위함
			                    response(
	
			                        $.map(data, function(item){
			                        	var pattern =/[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]|[가-힣]/gi; // 정규식
			                        	var arrTelno = item.telno.split(',');
			            				var filtNum=arrTelno[0].replace(pattern, "");
			            				var bInter =filtNum.substr(3);
			                            return{
			                                label:(bInter+"|"+item.fullDeptNm+" "+item.nm),
			                                value:(bInter+"|"+item.fullDeptNm+" "+item.nm),
			                                hidVal: (item.nm+"|"+filtNum+"|"+item.rsponm+"|"+item.deptNm+"|"+item.fullDeptNm)
			                            };
			                        })
	
			                    );
			                }
			            });
		       		}
		        },
		        // 조회를 위한 최소글자수
		        minLength:1,
		        select: function(event, ui){
		        	$("#outNm,#outTelno,#outFullDeptNm,#outDeptNm,#outMildsc").val("");
		            ui.item.value="";
		            var arItem=new Array(2);
		            //만약 검색리스트에서 선택하였을때 선택한 데이터에 의한 이벤트 발생
		            arItem=(ui.item.hidVal.toString()).split('|');
		            $("input[id=outNm]").val(arItem[0].trim());					
					$("input[id=outTelno]").val(arItem[1].trim());					
					$("input[id=outFullDeptNm]").val(arItem[2].trim());					
					$("input[id=outDeptNm]").val(arItem[3].trim()); 					
		        	$("input[id=outMildsc]").val(arItem[4].trim());
		        }
		    });
		})
		
		function search(pageNm) {
		var special_pattern = /['~!@#$%^&*|\\\'\";:\/"]/gi;

		if(pageNm==undefined){
			pageNm='1';
		}		
		    if ($("#query").val().trim() == "" || $("#query").val().trim() == null) {
		        alert("검색어를 입력해주세요.");
		        return;
		    }
		    if ($("#query").val() == "씨발" ) {
		        alert("비속어를 입력 하지마세요.");
		        
		        return $("#query").val("");
		    }
		    
		    if ($("#query").val() == "미친" ) {
		        alert("비속어를 입력 하지마세요.");
		        
		        return $("#query").val("");
		    }
/*
		    if(special_pattern.test($("#query").val()) == true){
				alert("특수문자는 사용할수 없습니다.");
		        
		        return $("#query").val("");
		    }
*/

			var tmp = "";
		    $("input[name=range]").each(function(idx,val){
	                 if($(this).is(":checked")){
	                 	tmp += $(this).val();
	                 	tmp += "$";
	                 }	
	            });
			
			$.ajax({   
				url:"/search.do",
				type:"post",
				dataType:'json',
				data:{"value" : $("#query").val().trim()
					, "setPageNum" : pageNm
					, "range" : tmp
					, "tar_range" : $("#tar_range").val()
					, "sortField" : $("#sortField").val()
					, "sortOrder" : $("#sortOrder").val()},
				success:function(data) {
					
					setSearch(data);
				}
			})
		}
		
		
		function setSearch(result) {
			
			if(result.data.length != 0 ) {
					
				$("#searchThead").show();
				$("#searchData").hide();
				$("#searchTbody").html(makeSearchString(result.data));
				$("#searchTbody").show();
				$(".tbl_bottom").show();
				setPaging(result.paging);
				resultCnt(result);
			} else {
				
				$("#searchThead").hide();
				$("#searchTbody").hide();
				$("#searchData").show();
				$("#searchData").html("검색어 결과가 없습니다.");
			}
		}
		
		function resultCnt(result) {
			var rscnt = "";
			var rscntext = "";
			if(result.data[0].temp != "") {
				rscnt = result.data[0].temp;
				rscntext = rscnt+"건이 검색되었습니다.";
			} else {
				rscntext = "";
			}
			
			$("#rscnt").html(rscntext);
		};
		
		function makeSearchString(result) {
			var searchHtml = "";

			$.each(result, function(i, value) {
				
					var sp = value.telno.split(",");
					var str =  sp[0].substr(sp[0].length -4, 3);
					var str2 =  sp[0].substr(sp[0].length -3, 2);
					var length = sp[0].substr(sp[0].length -5).length;
					
					
					if(value.facility_nm != "") {
						if(length  == 5) {
							if(str === "000") {
								searchHtml += "<tr id='searchTr' style='background-color: #fffe9d;' class='yellow'>";
							} else	if(str2 === "00") {
								searchHtml += "<tr id='searchTr' style='background-color: #deff9d;' class='green'>";
							} else {
								
								searchHtml += "<tr id='searchTr' >";
							}
						} else {
							searchHtml += "<tr id='searchTr' >";
						}
						
						if(value.telno.length == 8) {
						searchHtml += "	 <td>군)"+ value.telno +"</td>";
						}else {
						searchHtml += "  <td>"+ value.telno.replace("일반)","일)") +"</td>";
						}
						searchHtml += "  <td>"+ value.full_dept_nm+"<input type='hidden' value='"+ value.dept_nm +"'/> <br/>/"+value.facility_nm+"</td>";
						searchHtml += "	 <td>"+ value.rank +"</td>";
						
						if(value.mildsc_nm == "국방부") {
							searchHtml += "  <td>"+ value.rspofc_nm +"</td>";
						} else {
							searchHtml += "  <td>"+ value.rspsblt_biznes +"</td>";
						}
						
						searchHtml += "	 <td>"+ value.nm +"</td>";
						/* searchHtml += "	 <td>"+ value.facility_nm +"</td>"; */
						searchHtml += "</tr>";
					} else {
						
						
						if(length  == 5) {
							if(str === "000") {
								searchHtml += "<tr id='searchTr' style='background-color: #fffe9d;' class='yellow'>";
							} else	if(str2 === "00") {
								searchHtml += "<tr id='searchTr' style='background-color: #deff9d;' class='green'>";
							} else {
								
								searchHtml += "<tr id='searchTr' >";
							}
						} else {
							searchHtml += "<tr id='searchTr' >";
						}
						
						if(value.telno.length == 8) {
						searchHtml += "	 <td >군)"+ value.telno +"</td>";
						}else {
						searchHtml += "  <td>"+ value.telno.replace("일반)","일)") +"</td>";
						}
						searchHtml += "  <td>"+ value.full_dept_nm+"<input type='hidden' value='"+ value.dept_nm +"'/></td>";
						searchHtml += "	 <td>"+ value.rank +"</td>";
						if(value.mildsc_nm == "국방부") {
							searchHtml += "  <td>"+ value.rspofc_nm +"</td>";
						} else {
							searchHtml += "  <td>"+ value.rspsblt_biznes +"</td>";
						}
						
						searchHtml += "	 <td>"+ value.nm +"</td>";
						/* searchHtml += "	 <td>"+ value.facility_nm +"</td>"; */
						searchHtml += "</tr>";
					}
				
			});
				return searchHtml;
			
		}
		
		function paging(result){
			search(result);
		}
		
		function setPaging(result) {
				
				var htmlStr = "";
				htmlStr += "<div class='pagination'>";
				htmlStr += "<a href='javascript:void(0)' onclick='paging("+result.prevPageNo+");' class='list_btn'><img src='../images/operator/paging_btn_prev.png' alt='이전'/></a>";
				var pageSizeVal = result.endPageNo - result.startPageNo;
				
				for(var i=result.startPageNo; i<=result.endPageNo; i++) {
					if (i == result.pageNo) {
						htmlStr += "<a href='javascript:void(0)' onclick='paging("+i+");' class='list_btn'><b>"+i+"</b></a>";
					} else {
						htmlStr += "<a href='javascript:void(0)' onclick='paging("+i+");' class='list_btn'>"+i+"</a>";
					}
				}
				htmlStr += "<a href='javascript:void(0)' onclick='paging("+result.nextPageNo+");' class='list_btn'><img src='../images/operator/paging_btn_next.png' alt='다음'/></a>";
				htmlStr += "</div>";
				$(".tbl_bottom").html(htmlStr);
		}
		
		// 21.01.25 클릭한 값에 대해서 엔터누르면 연결되는 기능 구현
		$(document).on("keyup","#searchTr", function() {
			if (event.keyCode === 13) {
				$("#btnTransfer").trigger("click");
		    }
		});
		
		$(document).on( "click","#searchTr", function() {
		
			var tr = $(this);
			var td = tr.children();
		
			var mildsc = td.eq(1).text();
			var deptNm = td.eq(1).children()[0].value;
			var rank = td.eq(2).text();
			var fullNm = td.eq(3).text();
			var temptelno = td.eq(0).text();
			var telno = "";

			if(td.eq(4).text() == "") {
				var nm = td.eq(4).text();
			} else {
				var nm = td.eq(4).text();
			}
				
			var pattern =/[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]|[가-힣]/gi; // 정규식
			try{ 
				var arrTelno = temptelno.split(',');
				var filtNum=arrTelno[0].replace(pattern, "");
				//telno=getPhoneNumFormat(filtNum);
				telno=filtNum;
			}catch(e){
				//telno=getPhoneNumFormat(temptelno);
				var filtNum=temptelno.replace(pattern, "");
				telno=filtNum;
			}			 
			
			$("input[id=outNm]").val(nm);					
			$("input[id=outTelno]").val(telno);					
			$("input[id=outDeptNm]").val(deptNm);					
			
			$("input[id=outMildsc]").val(mildsc); 					
        	$("input[id=outFullDeptNm]").val(fullNm); 

   	 	}); 
		
		$(document).on( "dblclick","#searchTr", function() {
		
			var tr = $(this);
			var td = tr.children();
		
			var mildsc = td.eq(1).text();
			var deptNm = td.eq(1).children()[0].value;
			var rank = td.eq(2).text();
			var fullNm = td.eq(3).text();
			var temptelno = td.eq(0).text();
			var telno = "";

			if(td.eq(4).text() == "") {
				var nm = td.eq(4).text();
			} else {
				var nm = td.eq(4).text();
			}
				
			var pattern =/[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]|[가-힣]/gi; // 정규식
			try{ 
				var arrTelno = temptelno.split(',');
				var filtNum=arrTelno[0].replace(pattern, "");
				telno=filtNum;
			}catch(e){
				var filtNum=temptelno.replace(pattern, "");
				telno=filtNum;
			}			 
			
			$("input[id=outNm]").val(nm);					
			$("input[id=outTelno]").val(telno);					
			$("input[id=outDeptNm]").val(deptNm);					
			
			$("input[id=outMildsc]").val(mildsc); 					
        	$("input[id=outFullDeptNm]").val(fullNm); 
			
			var outTelno=$("#outTelno").val(); //화면 
			var pureNum=phoneNumber(outTelno); //입력 값  
		
			if(pureNum=="" && pureNum.length<4){
				alert("전화번호를 정확하게 입력해 주세요.");
				$("#outTelno").focus();
				return;
			}

			//현재 연결된 전화번호 체크
			if(!curCallCheck(pureNum)){
				return;
			}
					
			makeCall(pureNum);

   	 	}); 
		
	 $(document).on("mouseenter","#searchTr", function() {
			 var cl = $(this).attr('class');
			 if(cl != "red"  && cl != "yellow" && cl != "green") {
				$( this ).css( "background-color", "#f4f4f4" );
			 	$( this).children("td").css( "cursor", "pointer" );
			 }

		});
		
		 $(document).on( "mouseleave","#searchTr", function() {
			var cl = $(this).attr('class');
			if(cl != "red" && cl != "yellow" && cl != "green") {
				 $( this ).css( "background-color", "white" );
			} 

    	 });  

	$(document).on("click","#searchTr", function() {
			var cl = $(this).attr('class');
			 if(cl != "yellow" && cl != "green" ) {
					$( "tr" ).each(function( index ) {
						var cl2 = $(this).attr('class');
						if(cl2 === "red") {
			              		$(this).css('background-color', 'white');
			              		$(this).removeClass("red");
						} else if(cl2 === "yellow") {
							$(this).css('background-color', '#fffe9d');
						} else if(cl2 === "green") {
							$(this).css('background-color', '#deff9d');
						}
				    });
				
			//	$( this).css( "background-color", "#A9E2F3" );
			 $(this).addClass("red");
			 $(this).css('background-color', '#64cad9');
                         $(this).css('color', '#000');
	
			 } else {
				 
				 
				 if(cl === "yellow"){
					 
					$( "tr" ).each(function( index ) {
						var cl2 = $(this).attr('class');
						
						if(cl2 === "red") {
						 
			              		$(this).css('background-color', 'white');
			              		$(this).removeClass("red");
						} 
				    });
								 
              				 $(this).css('background-color', '#64cad9');
                                         $(this).css('color', '#000');
	
					 
				 } else if(cl === "green") {
					 $( "tr" ).each(function( index ) {
						 
							var cl2 = $(this).attr('class');
							if(cl2 === "red") {
							 
				              		$(this).css('background-color', 'white');
				              		$(this).removeClass("red");
							} 
					    });
						 
						 $(this).css('background-color', '#64cad9');
						$(this).css('color', '#000');
	              		
				 }
			 }
		}); 		

// range check box
function checkRange(num){
	if($("input[name=range]").is(":checked")){
		var length = $("input[name=range]").length;
		for(var i=0; i < length; i++){
			var anchor = $("input[name=range]").eq(i);
			var relAttribute = anchor.attr("rel");
			if(relAttribute != num){
				anchor.prop("checked", false);
			}
		}
	}else{
		$("input[name=range]").eq(0).prop("checked", true);
	}
}



function reClear(){
	$("#searchThead").hide();
	$("#searchTbody").hide();
	$(".tbl_bottom").hide();

	$("#outNm").val("");
	$("#outTelno").val("");
	$("#outFullDeptNm").val("");
	$("#outDeptNm").val("");
	$("#outMildsc").val("");
	$("#query").focus();	
	
	return $("#query").val("");
}

	</script>
 <!--contents_area-->
    <div id="content_m">
    <form name="form1" id="form1" method="post">
    	<input type="hidden" id="telno" name="telno" value="">
    </form>
		<!--content_main-->
		<div class="content_main01">
			<!--왼쪽 박스-->
			<div class="Call_box">
				<ul>
					<li class="Call_box_left">
					<!--인입콜 정보-->
						<div class="inCall_box01">
							<div class="topButton" style="margin-top: -7px; margin-right: 85px; float: right;">
							  <button type="button" name="btnIn_Aksung1" id="btnIn_Aksung1" value="1" class="btnComm_s blue_h" title="언어폭력">언어폭력</button>
							  <button type="button" name="btnIn_Aksung2" id="btnIn_Aksung2" value="2" class="btnComm_s blue_h" title="성희롱" style="margin-left: 10px;">성희롱</button>
							  <button type="button" name="btnIn_Aksung3" id="btnIn_Aksung3" value="3" class="btnComm_s blue_h" title="업무방해" style="margin-left: 10px;">업무방해</button>
							</div>
							<div class="inner01">
							<h2><span class="tit_i">인입콜정보</span></h2>
									<!--인입콜 내용-->
									<div class="inCall_cont01">
										<input type="hidden" id="h_nm" value=""/>
										<input type="hidden" id="h_tfTelno" value=""/>
										<input type="hidden" id="h_fullDeptNm" value=""/>
										<input type="hidden" id="h_deptNm" value=""/>
										<input type="hidden" id="h_mildsc" value=""/>
										<ul>
											<li class="inCall_cont_le">성명</li>
											<li class="inCall_cont_ri"><input type="text" class="w100p" id ="nm" name="nm"></li>
										</ul>
										<ul>
											<li class="inCall_cont_le">연락처</li>
											<li class="inCall_cont_ri"><input type="text" class="w100p" id="tfTelno" name="telno"></li>
										</ul>
										<ul>
											<li class="inCall_cont_le">직책</li>
											<li class="inCall_cont_ri"><input type="text" class="w100p" id="fullDeptNm"></li>
										</ul>
										<ul>
											<li class="inCall_cont_le">부서</li>
											<li class="inCall_cont_ri"><input type="text" class="w100p" id="deptNm"></li>
										</ul>
										<ul>
											<li class="inCall_cont_le">부대</li>
											<li class="inCall_cont_ri"><input type="text" class="w100p" id="mildsc"></li>
											
										</ul>
									</div>
									<!--//인입콜 내용-->
								</div>
							</div>
						<!--//인입콜 정보-->
						<!--아웃콜 정보-->
						<div class="outCall_box01">
							<div class="bottonButton" style="margin-top: -7px; margin-right: 85px; float: right;">
							  <button type="button" name="btnOut_Aksung1" id="btnOut_Aksung1" value="1" class="btnComm_s blue_h" title="언어폭력">언어폭력</button>
							  <button type="button" name="btnOut_Aksung2" id="btnOut_Aksung2" value="2" class="btnComm_s blue_h" title="성희롱" style="margin-left: 10px;">성희롱</button>
							  <button type="button" name="btnOut_Aksung3" id="btnOut_Aksung3" value="3" class="btnComm_s blue_h" title="업무방해" style="margin-left: 10px;">업무방해</button>
							</div>
							<div class="inner01">
								<h2><span class="tit_i">아웃콜 정보</span></h2>
									<!--검색이력정보 내용-->
									<div class="outCall_cont01">
										<ul>
											<li class="outCall_cont_le">성명</li>
											<li class="outCall_cont_ri"><input type="text" class="w100p" id ="outNm" ></li>
										</ul>
										<ul>
											<li class="outCall_cont_le">연락처</li>
											<li class="outCall_cont_ri"><input type="text" class="w100p" id="outTelno"></li>
										</ul>
										<ul>
											<li class="outCall_cont_le">직책</li>
											<li class="outCall_cont_ri"><input type="text" class="w100p" id="outFullDeptNm"></li>
										</ul>
										<ul>
											<li class="outCall_cont_le">부서</li>
											<li class="outCall_cont_ri"><input type="text" class="w100p" id="outDeptNm"></li>
										</ul>
										<ul>
											<li class="outCall_cont_le">부대</li>
											<li class="outCall_cont_ri"><input type="text" class="w100p" id="outMildsc"></li>
										</ul>
										<!-- <ul>
											<li class="but01 f_right mt7">
												<button type="button" class="btnComm blue" title="연결" />호전환</button>
											</li>
										</ul> -->
										<ul>
											<li class="f_right mt15">
												<button type="button" class="btnComm_s blue" title="연결" id="btnTransfer" />&nbsp;연&nbsp;&nbsp;결&nbsp;</button>
												<button type="button" class="btnComm_s red" title="호전환"  id="btnConsult" />호전환</button>
											</li>
										</ul>	
									</div>
									<!--//검색이력정보 내용-->
								</div>
							</div>
						<!--//아웃콜 정보-->
					</li>
					<li class="Call_box_right">
					<!--오른쪽 박스-->
			<div class="content_right01">
				<!--전화번호검색 / 조직도-->
				<div class="tab_box02">
					<ul class="tabs01">
						<li class="tab-link current" data-tab="tab-4">전화번호 검색</li>
						<li class="tab-link" data-tab="tab-5">조직도</li>
						<li class="tab-link" data-tab="tab-block">악성민원 차단요청</li>
						<li class="tab-link" data-tab="tab-block-ivr">악성민원 송출조회</li>
					</ul>
					<div id="tab-4" class="tab-content01 current">
						<!--검색-->
						<input type="checkbox" name="range" rel="1" value="all" onclick="checkRange(1);" checked="checked">전체
						<input type="checkbox" name="range" rel="2" id="A" value="A" onclick="checkRange(2);" style="margin-left: 5px;">국방부/합참
						<input type="checkbox" name="range" rel="2" id="B" value="B" onclick="checkRange(2);" style="margin-left: 5px;">육군
						<input type="checkbox" name="range" rel="2" id="C" value="C" onclick="checkRange(2);" style="margin-left: 5px;">해군/해병대
						<input type="checkbox" name="range" rel="2" id="D" value="D" onclick="checkRange(2);" style="margin-left: 5px;">공군
						<select id="searchCnt" name="" title="조건을 선택하세요" class="select-type" style="height: 25px; float: right;">
					        <option value="0" selected="selected">미사용</option>
     						<option value="5">5개</option>
					        <option value="10">10개</option>
                            <option value="15">15개</option>
                            <option value="20">20개</option>
                            <option value="10000">10000개</option>
						</select>
						<span style="float: right; margin-right: 15px;">검색 나열 개수</span>
						<div class="search-box">
						
									<legend>통합검색</legend>
										<select id="tar_range" name="" title="조건을 선택하세요" class="select-type">
     										<option value="tot">통합검색</option>
					           				<option value="full_dept_nm,full_dept_nm2">소속</option>
                                            <option value="nm2">이름</option>
                                            <option value="rsp2">직책</option>
                                            <option value="facility_nm2">시설물명</option>
						    				<option value="telno2">사무실번호</option>
						    				<option value="mpno2">휴대번호</option>
										</select>
										<span class="word-input">
											<input type="text" id="query" name="query" style="ime-mode:active;" value="" title="검색어를 입력하세요" />
											<button type="button" class="search-btn ml5"  onclick="javascript:search('1')">
												검색
											</button>
											<button type="button" class="search-btn ml5"  onclick="javascript:reClear()">
												초기화
											</button>
										</span>
						</div>
<!--//검색-->
						<!--전화번호 검색-->
					<!--	<P id="rscnt" style="text-align: right;" ></P> -->
						<div class="board_type board_typeBox">
							<input id="sortField" type="hidden" value="score"/>
							<input id="sortOrder" type="hidden" value="desc"/>
							<table class="tbl_type_board" border="1" cellspacing="0" summary="전화번호 검색 게시판입니다." >

								<caption>전화번호 검색 게시판</caption>
								<colgroup>
								<col width="22%">
								<col width="40%">
								<col width="7%">
								<!-- <col width="10%"> -->
								<col>
								<col width="10%">
								<!-- <col width="10%"> -->
								</colgroup>
								<thead id="searchThead">
								
									<tr>
										<th scope="col" name="sortbtn" data="telno">사무실 번호</th>
										<th scope="col" name="sortbtn" data="full_Dept_Nm">부대</th>
										<!-- <th scope="col">부서</th> -->
										<th scope="col">계급</th>
										<!--<th scope="col" name="sortbtn" data="rank">계급</th>-->
										<th scope="col">직책</th>
										<th scope="col" name="sortbtn" data="nm">성명</th>
										<!-- <th scope="col">시설물명</th> -->
									</tr>
								</thead>
								<tbody id="searchTbody"></table>
								<div id="searchData"></div>
							</div>
								<div class="tbl_bottom mt30"></div> 
							</div>
						<!--//전화번호 검색-->
					<div id="tab-5" class="tab-content01">
						<!--조직도-->
						<div class="tab_box03 mt10 ml10 mr20 mb30">
							<ul class="tabs02">
								<li class="tab-link current" data-tab="tab-6">국방/합참</li>
								<li class="tab-link" data-tab="tab-7">육군</li>
								<li class="tab-link" data-tab="tab-8">해군/해병대</li>
								<li class="tab-link" data-tab="tab-9">공군</li>
								<li class="tab-link" data-tab="tab-10">기타</li>
							</ul>
							<div id="tab-6" class="tab-content02 current">
							<!--국방부/ 합참-->
								<div id="treeA"></div>
							<!--//국방부 조직도-->
							</div>
							<div id="tab-7" class="tab-content02 ">
							<!--육군-->
								<div id="treeB"></div>
							<!--//육군 조직도-->
							</div>
							<div id="tab-8" class="tab-content02">
							<!--해군-->
								<div id="treeC"></div>
							<!--//해군 조직도 -->
							</div>
							<div id="tab-9" class="tab-content02">
							<!--공군-->
								<div id="treeD"></div>
							<!--//공군 조직도 -->
							</div>
							<div id="tab-10" class="tab-content02">
							<!--기타-->
								<div id="treeE"></div>
							<!--//기타조직도 -->
							</div>
						</div>
						<!--//조직도-->
					</div>
					
					<!-- 악성민원 -->
					<style>
					.selectBox {height: 20px; font-size: 13px}
/*  					#tab-block-ivr .selectBox {height: 20px; font-size: 13px}  */
 					#search-block-ivr th {text-align: left; padding-right: 5px;} 
 					#content_block_ivr th {text-align: center;} 
/*  					#tab-block .selectBox {height: 20px; font-size: 13px}  */
 					#search-block  th {text-align: left; padding-right: 5px;} 
 					#content_block  th {text-align: center;} 
					</style>
					
					<div id="tab-block" class="tab-content01">
					<div id="search-block" style="height: 45px;">
							<table summary="상담이력조회" class="search2_tbl">
							<tr>
								<td>
									<select id="date_type" style="margin: 0px 5px -2px 1px; height: 20px;">
										<option value="crt_dt">등록일</option>
										<option value="block_dt">차단일</option>
									</select>
								</td>
								<td class="selectBox" style="width: 230px;" colspan="2">
								<input type="text" class="text_ol_half"  id="start_dt" maxlength="16" alt="시작날짜" title="시작날짜" style="border: 1px solid rgb(205, 205, 205); border-image: none; width: 80px; height: 20px; line-height: 0px; font-size: 13px;"> ~ <input style="border: 1px solid rgb(205, 205, 205); border-image: none; width: 80px; height: 20px; line-height: 0px; font-size: 13px;" type="text" class="text_ol_half" id="end_dt" maxlength="16"  alt="종료날짜" title="종료날짜" >
								</td>
								<th scope="row" style="font-size: 14px; text-align: left;">유형</th>
								<td>
									<select class="selectBox" style="width:100px; font-size: 13px" id="block_type" title="유형">
										<option value="all">전체</option>
										<option value="1">언어폭력</option>
										<option value="2">성희롱</option>
										<option value="3">업무방해</option>
									</select>
								</td>
								<th scope="row" style="font-size: 14px; width: 5px; padding-left: 10px;">처리결과</th>
								<td>
									<select class="selectBox" id="block_stat" title="처리결과" style="margin-right: 10px;">
										<option value="all">전체</option>
										<option value="1">요청</option>
										<option value="2">승인</option>
										<option value="3">반려</option>
										<option value="4">해제</option>
										<option value="5">삭제</option>
									</select>
								</td>
								<td>
									<select class="selectBox" id="block_search" title="검색" style="padding-left: 15px;">
										<option value="all">전체</option>
										<option value="cust_nm">민원인명</option>
										<option value="cust_tel">전화번호</option>
									</select>
								</td>
								<td>
									<input type="text" class="text_ol" id="cust_info_search" style="height: 20px !important; font-size: 13px; margin-left: 5px; line-height: 0px; font-family: 'Nanum Gothic';" alt="검색어" title="검색어">
								</td>
								<td>
									<button type="button" id="btnSelectBlock"  class="btnComm_aksung" style="margin-left: 175px;">조회</button>
								</td>
							</tr>
						</table>
					</div>
               
	               	<div id="content_block" class="tbl_type_board" style="width: 100%; height: 505px; margin-bottom: 0px;">
						<table>
							<colgroup>
								<col width="5%">
								<col width="15%">
								<col width="5%">
								<col width="22%">
								<col width="7%">
								<col width="5%">
								<col width="20%">
								<col width="13%">
								<col width="13%">
							</colgroup>
							<thead>
								<tr>
									<th>번호</th>
									<th>등록일</th>
									<th>교환원</th>
									<th>사유</th>
									<th>유형</th>
									<th>처리결과</th>
									<th>차단일</th>
									<th>연락처</th>
									<th>민원인</th>
								</tr>
							</thead>
							<tbody>
							</tbody>
						 </table>
<!-- 						 <div id="block_paging" style="margin-top: 5px;"></div> -->
	               	</div>
	               	<div id="block_paging" style="margin-top: 5px;"></div>
            	</div>
            	<!-- 악성민원 탭 end -->
            	
            	<!-- tab-block-ivr start -->
            	<div id="tab-block-ivr" class="tab-content01">
            		<div id="search-block-ivr" style="height: 45px;">
						<table summary="IVR송출조회" class="search2_tbl">
						<tr>
							<th scope="row" style="font-size: 14px; text-align: left;">등록일</th>
							<td class="selectBox" style="width: 300px;" colspan="2">
								<input type="text" class="text_ol_half" id="ivr_start_dt" maxlength="16" alt="시작날짜" title="시작날짜" style="border: 1px solid rgb(205, 205, 205); border-image: none; width: 80px; height: 20px; line-height: 0px; font-size: 13px;">
								 ~ 
								<input type="text" class="text_ol_half" id="ivr_end_dt" maxlength="16"  alt="종료날짜" title="종료날짜" style="border: 1px solid rgb(205, 205, 205); border-image: none; width: 80px; height: 20px; line-height: 0px; font-size: 13px;">
							</td>
							
							<th scope="row" style="font-size: 14px; text-align: left;">유형</th>
							<td>
								<select class="selectBox" style="width:100px; font-size: 13px" id="block_ivr_type" title="유형">
									<option value="all">전체</option>
									<option value="1">언어폭력</option>
									<option value="2">성희롱</option>
									<option value="3">업무방해</option>
								</select>
							</td>
							
							<th scope="row" style="text-align: left; padding-left: 60px; font-size: 14px;">검색</th>
							<td>
								<select class="selectBox" style="width:100px; font-size: 13px" id="block_ivr_search" title="유형">
									<option value="all">전체</option>
									<option value="cust_nm">민원인</option>
									<option value="agent_id">교환원</option>
									<option value="cust_infm">연락처</option>
								</select>
							</td>
							
							<td>
								<input type="text" class="text_ol" id="block_ivr_search_content" style="height: 20px !important; font-size: 13px; margin-left: 5px; line-height: 0px; font-family: 'Nanum Gothic';" alt="검색어" title="검색어">
							</td>
						
							<td>
								<button class="btnComm_aksung" id="btnExcelBlockIvr" style="width: 85px; margin-left: 55px;" type="button">엑셀다운로드</button>
								<button class="btnComm_aksung" id="btnSelectBlockIvr" style="margin-left: 10px;" type="button">조회</button>
<!-- 								<button type="button" id="btnSelectBlockIvr"  class="btnComm_aksung" style="margin-left: 150px;">조회</button> -->
							</td>
						</tr>
							
						</table>
					</div>
               
	               	<div id="content_block_ivr" class="tbl_type_board" style="width: 100%; height: 505px; margin-bottom: 0px;">
						<table style="width: 100%;">
							<colgroup>
								<col width="5%">
								<col width="20%">
								<col width="15%">
								<col width="20%">
								<col width="20%">
								<col width="20%">
							</colgroup>
							<thead>
								<tr>
									<th>번호</th>
									<th>등록일</th>
									<th>교환원</th>
									<th>유형</th>
									<th>연락처</th>
									<th>민원인</th>
								</tr>
							</thead>
							<tbody>
							</tbody>
						 </table>
<!-- 						 <div id="block_ivr_paging" style="margin-top: 5px;"></div> -->
	               	</div>
	               	<div id="block_ivr_paging" style="margin-top: 5px;"></div>
            	</div>
            	<!-- tab-block-ivr end -->
            	
            	
				</div>
				<!--//전화번호검색 / 조직도-->
			
			</div>
			<!--//오른쪽 박스-->
					</li>
				</ul>	

			</div>
			<!--//왼쪽 박스-->
			
			<!--하단 통계-->
			<!-- <div class="content_b01">
			<div class="content_bottom01">
				<ul>
					<li>음성인식상담 : </li>
					<li class="f_blue01 pr30"><span class="fEBold pl3">30</span>건</li>
					<li>대기자수 : </li>
					<li class="f_red pr30"><span class="fEBold pl3">30</span>건</li>
				</ul>
			</div>
			</div> -->
			<!--//하단 통계-->
		</div>
		<!--//content_main-->
		
	<!--팝업시작  -->
	<div id="popWrap" class="treePopWrap">
		<!--header-->
		<div class="popHead">
			<h1>조직도 상세 팝업</h1>
			<a href="#" class="btn_close" id="closeBt"><img src="../images/operator/btn_p_close.gif" alt="닫기" /></a>
		</div>
	    <!--//header-->
	    <!--contents_area-->
	    <div class="popCnt">
			<div class="board_type">
				<!--조직도 상세보기-->
							<!--공지사항:list-->
							<div class="board_type">	
								<table class="tbl_type_board" border="1" cellspacing="0" summary="조직도 상세">
									<caption>조직도 팝업</caption>
									<colgroup>
									<col width="35%">
									<col width="14%">
									<col width="10%">
									<col width="10%">
									<col width="15%">
									<col width="15%">
									<!-- <col width="15%"> -->
									<!-- <col width="11%"> -->
									
									</colgroup>
									<thead id="thPop">
										<tr>
										<!--	<th scope="col">군</th> -->
											<th scope="col">부대</th>
											<th scope="col">전화번호</th>
											<th scope="col">계급</th>
											<th scope="col">성명</th>
											<th scope="col">직책</th>
											<th scope="col">휴대번호</th>
											<!-- <th scope="col">즐겨찾기</th> -->
										</tr>
									</thead>
									<tbody id="tPop">
									</tbody>
								</table>
							</div>
							<!--//공지사항:list -->
							
						</div>
						<div id="datatext"></div>
			<!--btnArea-->
			<!-- 페이징  -->
			<div class="tbl_bottom" id="paging"></div>
			<!-- // 페이징  -->
			<div class="btnArea t_center">
				<button type="button" class="btnComm gray mr5" title="확인" id="closeBt">닫기</button>
				<!-- <button type="button" class="btnComm gr_line" title="취소" id="closeBt">취소</button> -->
			</div>
			<!--//btnArea-->
		</div>
		<!--//contents_area-->
	</div>	
</div>
<!--//contents_area-->
