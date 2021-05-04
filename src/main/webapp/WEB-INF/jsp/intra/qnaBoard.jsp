<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/layout/include/incHeader.jspf" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<link rel="stylesheet" type="text/css" href="../css/tabs.css" />
<link rel="stylesheet" type="text/css" media="screen" href="../dtree/dtree.css" />
<link rel="stylesheet" type="text/css" media="screen" href="../jqgrid/css/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" media="screen" href="../jqueryui/jquery-ui.css" />
<link rel="stylesheet" type="text/css"	href="../jqueryui/jquery-ui.css" />
 
<link rel="stylesheet" type="text/css" href="../css/17/sub.css" />

<script type="text/javascript" src="../js/tabs.js"></script>
<script type="text/javascript" src="../dtree/dtree.js"></script>
<script type="text/javascript"	src="../jqueryui/jquery-ui.js"></script> 
<script type="text/javascript" src="../jqgrid/js/jquery.jqGrid.min.js"></script>

<script src="../js/17/jQuery.fixTableHeader.min.js"></script>
	  
	<script type="text/javascript">
	
$(document).ready(function() {
		active(2);
		
		
			// 일반전화용 인입 팝업 다이얼로그 설정
		$("#popupwrp").dialog({
			autoOpen: false,
		    resizable: false, 
		    width: 650,
		    modal: true,
		    draggable: true,
		    closeOnEscape: false,
		    open: function(event, ui)
		    {
		    	 
	    	},
		  	buttons: [
					{
						text: "등록",
						click: function()
						{
							  savaContent();
						}
					},
					{
						text: "닫기",
						click: function()
						{
							$(this).dialog("close");
						}
					} 
				]
		});
			
	});
	
	function active(num) {
		var l = $('div.navbar>a').length;
		for(var ii = 0; ii < l; ii++ ) {
			//console.log($('div.navbar>a').eq(ii).hasClass('active'));
			if($('div.navbar>a').eq(ii).hasClass('active')) {
				$('div.navbar>a').eq(ii).removeClass('active');
			}
		}
		$('div.navbar>a').eq(num).addClass('active');
	}
	
	function user_qnaw_y() {
		$("#popupwrp").dialog("open");
		//window.open("/intra/qna_write.jsp", "_blank", "location=no,scrollbars=no,resizable=no,top=100,left=100,width=850,height=700");//주소표시줄, 스크롤바, 팝업사이즈 임의 지정
	}
	
	function user_qnam_y() {
		window.open("/intra/qna_update.do", "_blank", "location=no,scrollbars=no,resizable=no,top=100,left=100,width=850,height=700");//주소표시줄, 스크롤바, 팝업사이즈 임의 지정
	}
	
	function close(no) {
		$('.layer'+no).fadeOut();
	}
	 
		
		function qnaBoard() {
			location.href= "/intra/qnaBoard.do";
		}

 
 		/* $(document).on("click", "#writePopup", function() {
 			
 			$("#labTitle").html("Q&A 글쓰기");
 			$("#replyCont").hide();
 			
 			$("#regId").val("");
 			$("#subject").val("");
			$("#contents").val("");
			$("#replycontents").val("");  			
 			
 			var mynm=$("#mynm").val();
 			$("#regId").val(mynm);  
 			
 			$("#detailseq").val("0");
 			$("#detailparentcd").val("0");
 			
 			//disable 해제
 			$("#subject").removeAttr("disabled");
      $("#contents").removeAttr("disabled");
      $("#replycontents").removeAttr("disabled");
     
      $(":button:contains('등록')").show();
      $("#replyBtn").show();
      
      
 			$("#popupwrp").dialog("open");
 			$("#subject").focus();
				formControl();
		}); */
		
$(document).on("click", "#writePopup", function() {
 			
 			/* $("#labTitle").html("Q&A 글쓰기");
 			$("#replyCont").hide();
 			
 			$("#regId").val("");
 			$("#subject").val("");
			$("#contents").val("");
			$("#replycontents").val("");  			
 			
 			var mynm=$("#mynm").val();
 			$("#regId").val(mynm);  
 			
 			$("#detailseq").val("0");
 			$("#detailparentcd").val("0");
 			
 			$("#popupwrp").dialog("open");
 			$("#subject").focus();
			formControl(); */
			
			var mynm=$("#mynm").val();
			
			var x = (window.screen.width / 2) - (880 / 2);
			var y = (window.screen.height / 2) - (700 / 2);
			
			window.open('./qnaWrite.do?mynm='+encodeURI(${mynm})+'&seq=null&replyseq=null', 'qna'
						, "location=no,scrollbars=no,resizable=no,top="+y+",left="+x+
						",width=880,height=700, screenX="+x+", screenY="+y+"");
			
		});
	 
 		
 		$(document).on("click", "#replyBtn", function() {
 			var selseq=$("#detailseq").val();
 			var selpcd=$("#detailparentcd").val();
 			if(selseq==""){
 				alert("원글을 다시 선택해 주세요."); 
 		 		return; 
 			}
 			
 			var replycontents = $("#replycontents").val();
 		 	if(replycontents==""){
 		 		alert("댓글을 입력해 주세요.");
 		 		$("#replycontents").focus();
 		 		return; 
 		 	}
 		 	
 			if(confirm("댓글을 등록하시겠습니까? ")) {
 				if(selseq==selpcd){
 					/*원글클릭팝업*/
 					selseq="0";
 				}
					insertQnaBoard(selseq,selpcd,"C");
			}
 					 
		});
 		
 		function savaContent() {
 			var selseq=$("#detailseq").val();
 			var selpcd=$("#detailparentcd").val();
 			
 			var title = $("#subject").val();
 			var content = $("#contents").val();
 		 	if(title==""){
 		 		alert("제목을 입력해 주세요.");
 		 		$("#subject").focus();
 		 		return;
 		 	}else if(content==""){
 		 		alert("내용을 입력해 주세요.");
 		 		$("#contents").focus();
 		 		return;
 		 	}
 		 	
 			if(confirm("글을 등록하시겠습니까? ")) {
					insertQnaBoard(selseq,selpcd,"P");
			}
 					 
		}
 		
 		/* function viewQnADetail(seq, replyseq, userid){
 			var parentcd="";
 			if(seq==replyseq){
 				parentcd=seq;
 			}
 			
 			$("#labTitle").html("Q&A 댓글쓰기");
 			$("#replyCont").show();

 			$("#detailseq").val("0");
 			$("#detailparentcd").val("0");
 			
 			$("#regId").val("");
 			$("#subject").val("");
			$("#contents").val("");
			$("#replycontents").val(""); 
 			
			$("#detailseq").val(seq);
 			$("#detailparentcd").val(replyseq);
 			
 			var loginId=$("#myid").val(); 
      // disabled 삭제
      $("#subject").removeAttr("disabled");
      $("#contents").removeAttr("disabled");
      $("#replycontents").removeAttr("disabled");
			
		  $(":button:contains('등록')").show();
      $("#replyBtn").show();
      
 			var pdata = {"seq":replyseq,
 									"replyseq":seq} 
 			$.ajax({
					type : "post",
					async : true,
					url : "/intra/detailQnaBoard.do",
					data : pdata,
					success : function(data)
					{
					 	// param값을 JSON으로 파싱
						var jr = JSON.parse(data);
					 	var rval="";
						 
						if(jr != ''){
							
							$.each(jr.list, function(keys, vals)
							{
									 	//console.log(vals);
										if(keys=="0"){
													$("#regId").val(vals.nm);
													$("#subject").val(vals.title);
													$("#contents").val(vals.content);
													if((loginId!=vals.regId) && (loginId!="mnd")){
														$("#subject").attr("disabled",true);
														$("#contents").attr("disabled",true);
														$(":button:contains('등록')").hide();
													}
										}else if(keys=="1"){
												if((loginId!=vals.regId) && (loginId!="mnd")){ 
														$("#replycontents").attr("disabled",true);
														$("#replyBtn").hide();
													}
												$("#replycontents").val(vals.content); 
										}
										
									 rval=keys;
							});
 
								 
							 	$("#popupwrp").dialog("open");
 								//$("#contents").focus();
						}
					},
					error : function(data, status, err) 
					{
						 
					}
			});
 			
 		} */
 		
 		function viewQnADetail(seq, replyseq, userid){
 			var parentcd="";
 			if(seq==replyseq){
 				parentcd=seq;
 			}
 			
			$("#detailseq").val(seq);
 			$("#detailparentcd").val(replyseq);
 			
			var mynm=$("#mynm").val();
				
			var x = (window.screen.width / 2) - (880 / 2);
			var y = (window.screen.height / 2) - (700 / 2);
			
			window.open('./detailQnaBoard.do?mynm='+encodeURI(mynm)+'&replyseq='+seq+'&seq='+replyseq+'', 'qna'
						, "location=no,scrollbars=no,resizable=no,top="+y+",left="+x+
						",width=880,height=700, screenX="+x+", screenY="+y+"");
 			 			
 		}
 		
 		
 		function formControl(){
 			
 		}
 		
 		function contentCheck(){
 			
 		}
 		
 		function insertQnaBoard(seq,parentcd,parntgb){
 				var frm = document.form1;
 				var title = $("#subject").val();
 				var content = $("#contents").val();
 				if(parntgb=="C"){
 					 content = $("#replycontents").val();
 				}
 					frm.seq.value = seq;
					frm.parentcd.value = parentcd;
 					frm.parent.value = parntgb;
					frm.title.value = title;
					frm.content.value = content;
					frm.action = "/intra/insertQnaBoard.do";
					frm.submit();
 		}
 		 		
		function deleteQnaBoard(seq,parntgb) {
			var frm = document.form1;
			var confStr="";
			if(parntgb=="P"){
				confStr="원글인 경우 댓글도 삭제됩니다. ";
			}else if(parntgb=="C"){
				confStr="댓글을 ";
			} 
					
			if(confirm(confStr+"삭제하시겠습니까? ")) {
					frm.seq.value = seq;
					frm.parent.value = parntgb;
					frm.action = "/intra/deleteQnaBoard.do";
					frm.submit();
			}
			
		}
		
		$(document).on("click", "#del2", function() {
			if(confirm("삭제하시겠습니까?")) {
				$("#tr2").hide();
			}
		});
		
		function onListPage(page) {
			var frm = document.form1;
			frm.currentPage.value = page;
			frm.action = "/intra/qnaBoard.do";
			frm.submit();
		};		
		
		
	</script>

<style type="text/css">
 
.custom_basic2{
	margin:10px;width: 100%;
}

/**마이페이지 테이블**/

.customers2 {
    border-collapse: collapse;
    width: 97.8%;
    table-layout: fixed;
    background: #fff;
	border: 1px solid #e2e1e9;
}

.customers2 th {
    background-color: #f1f2f7;
    border-bottom: 1px solid #e2e1e9 !important;
    border-right: 1px solid #e2e1e9 !important;
    color: #414850;
    font-weight: 600;
    height: 40px;
}

.customers2 th:first-child{border-left:none !important;}

.customers2 td{
    height:38px; 
    line-height:22px;
    color:#424d53;
    border-bottom: 1px solid #e2e1e9;
    text-align: left;
    padding: 3px 10px;
}

.m_ipt{background-color:#fff; border:1px solid #e2e4e6; line-height:19px; height:25px; padding:0; text-indent:5px; font-size:13px;width: 100%;}

textarea{
	width: 720px;
	border: none;
	color:#ddd;
	font-family:"malgun", sans-serif; font-size:13px; 
	line-height:1.4; color:#555; 
	margin:10px 0;
}

.h_340{
	height:340px;
}

.h_220{
	height:220px;
}

.h_80{
	height:80px;
}

.btn_area{
	float: right;
	margin:30px 20px 15px 15px;
}

.btn_area a{color: #fff;}

.btn_list{
	background: #117fca;
	padding: 10px 20px;
	border-radius: 4px;
	color: #fff;
	font-weight: 600;
}

.qbtn{
	margin:10px;
	display: inline-block;
}

.qbtn a{color: #fff;}

.qbtn .btn_list{
	background: #117fca;
	padding: 5px 5px;
	border-radius: 4px;
	color: #fff;
	font-weight: 600;
}

.ui-dialog-buttonset .ui-button{
	background: #117fca;
	color: #fff;
}
</style>

<!--***** wrap *****--> 
<div class="wrap">
   <!--왼쪽 영역-->  
   <div class="cont_center">
	   <div class="tit_qna"><img src="../images/intra_new/tit_qna.png" alt="Q&A"><span>Q&A</span>
	   <p class="btn_area_write">
          <a href="#" class="btn_write" id="writePopup" >글쓰기</a> 
       </p>
	   </div>
       
        <div id="result_tab1" class="tabcontent_notice" style="display: block;">
            <div class="custom_basic">  
				<table class="customers" >
                  <colgroup>
				  	  <col style="width:7%;">
					  <col style="width:55%;">
					  <col style="width:13%;">
					  <col style="width:15%;">
					  <col style="width:10%;">
				  </colgroup>
				  <tr>
                      <th>번호</th>
                      <th>제목</th>
                      <th>작성자</th>
                      <th>등록일</th>
					  <th>설정</th>
                  </tr>
                  <!-- <tr onClick="user_qnam_y();"> -->
                <c:forEach items="${list}" var="data" varStatus="status"> 
                  <tr>
                    <td><c:out value="${data.rownum}"/></td>
                    <td class="ellipsis txt_left" ><a href='#' onclick="viewQnADetail('<c:out value="${data.seq}"/>','<c:out value="${data.parentCd}"/>','<c:out value="${data.regId}"/>');" ><c:out value="${data.title}"/></a></td>
		    <td><c:out value="${data.nm}"/></td>
		    <td><c:out value="${data.regDt}"/></td>
		    <td><c:if test="${user_id==data.regId || user_id=='mnd'}"><a href="#" class="btn" onclick="deleteQnaBoard('<c:out value="${data.seq}"/>','<c:out value="${data.parentGb}"/>');"><img src="../images/intra_new/i_btn_del.png" alt="삭제"></a></c:if> </td>
                  </tr>
		</c:forEach>	
               </table>
            </div>
			<div class="paging">
               <page:paging paginationInfo="${paginationInfo}" jsFunction="onListPage" rowControl="false"  />
		   </div>  
       </div>
       
   </div>
   <!--// 왼쪽 영역-->
  
</div>
<!--// ***** wrap *****--> 



 
								<form id="form1" name="form1" method="POST" action="#" class="search-box_ad">
									<input type="hidden" id="seq" name="seq" value="">
									<input type="hidden" id="parent" name="parent" value="">
									<input type="hidden" id="parentcd" name="parentcd" value="">
									<input type="hidden" id="title" name="title" value="">
									<input type="hidden" id="content" name="content" value="">
									<input type="hidden" id="myid" name="myid" value="${user_id}">
									<input type="hidden" id="mynm" name="mynm" value="${user_name}">
									<input type="hidden" id="currentPage" name="currentPage" value='<c:out value="${paginationInfo.currentPageNo}"/>' />
									<input type="hidden" id="recordCountPerPage" name="recordCountPerPage" value='<c:out value="${paginationInfo.recordCountPerPage}"/>' />
									<input type="hidden" onclick="onListPage('1')">
									</form>



<div class="popupwrp" id="popupwrp" >
		<!--왼쪽 영역-->
		<div class="cont_center">
			<div class="tit">
				<img src="../images/intra_new/tit_qna.png" alt="Q&A"><span>Q&A</span>
			</div>
 
				<div class="custom_basic2">
					<table class="customers2" >
						<colgroup>
							<col style="width: 15%;">
							<col style="width: 85%;">
						</colgroup>
						<tr>
							<th>이름</th>
							<td> <input type="text" class="m_ipt" title="이름" name="regId" id="regId" value="" disabled/>
								<input type="hidden" id="detailseq" name="detailseq" value="">
								<input type="hidden" id="detailparentcd" name="detailparentcd" value="">
							</td>
						</tr>
						<tr>
							<th>제목</th>
							<td><input type="text" class="m_ipt" title="제목" name="subject" id="subject"/></td>
						</tr>
						<tr>
							<th>내용</th>
							<td><textarea class="h_340" style="height: 230px;width: 480px;" id="contents"></textarea> 
							</td>
						</tr>
						<tbody id="replyCont">
							<tr>
								<th scope="col">댓글 <br>
								<p class="qbtn"><a href="#" class="btn_list" id="replyBtn" title="댓글등록">등록</a></p>
								</th>
								<td><textarea class="h_80" style="width: 480px;" title="댓글" name="replycontents" id="replycontents" /></textarea></td>
							</tr>
						</tbody>
						 
					</table>
				 
				</div>
 
		</div>
		<!--// 왼쪽 영역-->
	</div>
	
	 



 
