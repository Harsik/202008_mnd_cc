<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/layout/include/incHeader.jspf"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="../css/17/popup.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../js/jquery-1.7.1.min.js"></script>
</head>

<script type="text/javascript">

	$(document).ready(function() {

		//$("#labTitle").html("Q&A 글쓰기");
		//$("#replyCont").hide();

		//$("#regId").val("");

		//var mynm = $("#mynm").val();
		//$("#regId").val(mynm);
		var seq = ${seq};
		var parentcd = ${replyseq};

		$("#detailseq").val(parentcd);
		$("#detailparentcd").val(seq); 
	
		if(seq!=parentcd){
			$("#btnContent").html("수정");
			$("#btnUpdate").hide();
		}else{
			$("#btnContent").html("등록");
			$("#btnUpdate").show();
		}
		
		$('a.cbtn').on('click', function() {
			//window.parent.close('_q');
			close();
		});

	});

	function insert(len) {
		var selseq = $("#detailseq").val();
		var selpcd = $("#detailparentcd").val();
		if (selseq == "") {
			alert("원글을 다시 선택해 주세요.");
			return;
		}

		var replycontents = $("#contents_s").val();
		if (replycontents == "") {
			alert("댓글을 입력해 주세요.");
			$("#contents_s").focus();
			return;
		}
		var msg="등록";
		if(len!=''){
			msg="수정";
		}
		
		if (confirm("댓글을 "+msg+"하시겠습니까? ")) {
			if (selseq == selpcd) {
				/*원글클릭팝업*/
				selseq = "0";
			}
			insertQnaBoard(selseq, selpcd, "C");
		}
	}
	
	function update() {
		var selseq = $("#detailseq").val();
		var selpcd = $("#detailparentcd").val();
		if (selseq == "") {
			alert("원글을 다시 선택해 주세요.");
			return;
		}

		var subject = $("#subject").val(); 
		if (subject == "") {
			alert("제목을 입력해 주세요.");
			$("#subject").focus();
			return;
		}
		
		var contents = $("#contents").val(); 
		if (contents == "") {
			alert("원글을 입력해 주세요.");
			$("#contents").focus();
			return;
		}
		
		if (confirm("원글을 수정하시겠습니까? ")) {
			 
			insertQnaBoard(selseq, selpcd, "P");
		}
	}

	function insertQnaBoard(seq, parentcd, parntgb) {
		//var frm = document.form1;
		var frm = $('#form1');
		var title = $("#subject").val();
		//alert(title);
		var content = $("#contents").val();
		if (parntgb == "C") {
			content = $("#contents_s").val();
		}
	
		//alert(content);
		
		$('#seq').val(seq);
		$('#parentcd').val(parentcd);
		$('#parent').val(parntgb);
		$('#title').val(title);
		$('#content').val(content);

		$.ajax({
			type : 'POST',
			url : '/intra/insertQnaBoard.do',
			dataType : 'json',
			data : frm.serialize(),
			success : function(result) {
				if (result == '200') {
					alert('글이 등록 되었습니다.');
					opener.parent.location.reload();
					window.close();
				}
			}
		});

	}
</script>

<body style="background-color: #fff;" onLoad="resizeTo(880,700)">
	<!--***** wrap *****-->
	<form class="popupwrp" id="form1" name="form1" method="POST" action="#">
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
		<!--왼쪽 영역-->
		<div class="cont_center">
			<div class="tit">
				<img src="../images/intra_new/tit_qna.png" alt="Q&A"><span>Q&A</span>
			</div>

			<div class="popcontent" style="display: block;">
				<div class="custom_basic">
					<table class="customers">
						<colgroup>
							<col style="width: 10%;">
							<col style="width: 90%;">
						</colgroup>

						<tr>
							<th>이름</th>
							<td><span>${list.nm }</span>
								<input type="hidden" id="detailseq" name="detailseq" value="">
								<input type="hidden" id="detailparentcd" name="detailparentcd" value="">
							</td>
						</tr>
						<tr>
							<th>제목</th>
							<td>
								<c:if test="${user_id==list.regId}">
									<input type="text" class="" name="subject" id="subject" value="${list.title }" style="IME-MODE:active;">
								</c:if>
								<c:if test="${user_id!=list.regId}">
									<span name="subject" id="subject">${list.title }</span>
								</c:if>
							</td>
						</tr>
						<tr>
							<th>내용</th>
							<td>
								<c:if test="${user_id==list.regId}">
									<textarea class="h_220" id="contents" style="IME-MODE:active;">${list.content }</textarea>
								</c:if>
								<c:if test="${user_id!=list.regId}">
									<pre class="h_220" id="contents" style="white-space:pre-wrap; overflow-y:scroll;">${list.content }</pre>
								</c:if>
							</td>
						</tr>


						<tr>
							<th>
								<div>댓글</div>
								<c:if test="${list_s.content == null || user_id==list_s.regId}">
									<p class="qbtn">
										<a href="#" class="btn_list" onclick="insert('<c:out value="${list_s.content.length()}"/>');"><span id="btnContent">등록</span></a>
									</p>
								</c:if>
							</th>
							<td>
								<c:if test="${user_id==list_s.regId}">
									<textarea class="h_80" id="contents_s" style="IME-MODE:active;"><c:if test="${list_s.content != null }">${list_s.content}</c:if></textarea>
								</c:if>
								<c:if test="${user_id!=list_s.regId && content_s != null}">
									<p class="h_80" id="contents_s" style="overflow-y:scroll;"><c:if test="${list_s.content != null }"></c:if>${list_s.content}</p>
								</c:if>
								<c:if test="${user_id!=list_s.regId && list_s.content == null}">
									<textarea class="h_80" id="contents_s" style="IME-MODE:active;"></textarea>
								</c:if>
								<c:if test="${user_id!=list_s.regId && list_s.content != null}">
									<p class="h_80" id="contents_s" style="overflow-y:scroll;"><c:if test="${list_s.content != null }"></c:if>${list_s.content}</p>
								</c:if>
							</td>

						</tr>

					</table>
					<p class="btn_area">
						<c:if test="${user_id==list.regId}">
							<span id="btnUpdate"><a href="#" class="btn_list" onclick="update();">수정</a></span>
						</c:if>
						<a href="#" class="btn_list cbtn">닫기</a>
					</p>
				</div>

			</div>
		</div>
		<!--// 왼쪽 영역-->

	</form>
	<!--// ***** wrap *****-->
</body>
<script type="text/javascript">
	
</script>
</html>
