<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/layout/include/incHeader.jspf"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<title>Q&A</title>
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
		//$("#subject").val("");
		//$("#contents").val("");
		//$("#replycontents").val("");
		$("#replyCont").hide();

		//var mynm = $("#mynm").val();
		//$("#regId").val(mynm);
		
		$('a.cbtn').on('click', function() {
			close();
		});
		
		var seq = ${seq};
		var parentcd = ${replyseq};
		//alert(seq + ":" + parentcd);
		if(seq != null) {
			$("#detailseq").val(seq);
			$("#detailparentcd").val(parentcd);
			$("#contents").removeClass('h_340');
			$("#contents").addClass('h_220');
			$("#replyCont").show();
		} else {
			$("#detailseq").val("0");
			$("#detailparentcd").val("0");
		}
		
	});
	
	function savaContent() {
		var selseq = $("#detailseq").val();
		var selpcd = $("#detailparentcd").val();

		var title = $("#subject").val();
		var content = $("#contents").val();
		if (title == "") {
			alert("제목을 입력해 주세요.");
			$("#subject").focus();
			return;
		} else if (content == "") {
			alert("내용을 입력해 주세요.");
			$("#contents").focus();
			return;
		}

		if (confirm("글을 등록하시겠습니까? ")) {
			insertQnaBoard(selseq, selpcd, "P");
		}

	}

	function insertQnaBoard(seq, parentcd, parntgb) {
		var frm = $('#form1');
		var title = $("#subject").val();
		var content = $("#contents").val();
		if (parntgb == "C") {
			content = $("#replycontents").val();
		}
		
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
				if(result == '200') {
					alert('글이 등록 되었습니다.');
					opener.parent.location.reload();
					window.close();
				}
			}
		});

	}
</script>

<body style="background-color:#fff;" onLoad="resizeTo(880,700)">

	<form class="popupwrp search-box_ad" id="form1" name="form1" method="POST" action="#">
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

			<form id="qna_form" class="popcontent" style="display: block;">
				<div class="custom_basic">
					<table class="customers">
						<colgroup>
							<col style="width: 10%;">
							<col style="width: 90%;">
						</colgroup>
						<tr>
							<th>이름</th>
							<td>
								<%-- <input type="text" class="m_ipt" title="이름" name="regId" id="regId" value="${mynm}" disabled > --%>
								<span class="" name="regId" id="regId" >${user_name}</span>
								<input type="hidden" id="detailseq" name="detailseq" value="">
								<input type="hidden" id="detailparentcd" name="detailparentcd" value="">
							</td>
						</tr>
						<tr>
							<th>제목</th>
							<td><input type="text" class="m_ipt" name="subject" id="subject" value='' style="IME-MODE:active;"></td>
						</tr>
						<tr>
							<th>내용</th>
							<td id="content_u"><textarea class="h_340" id="contents" style="IME-MODE:active;"></textarea></td>
						</tr>

						<tr id="replyCont">
							<th>댓글
								<p class="qbtn">
									<a href="#" class="btn_list">등록</a>
								</p>
							</th>
							<td><textarea class="h_80" style="IME-MODE:active;"></textarea></td>
						</tr>

					</table>
					<p class="btn_area">
						<a href="#" class="btn_list" onclick="savaContent();">등록</a> 
						<a href="#" class="btn_list cbtn">닫기</a>
					</p>
				</div>

			</form>
		</div>
		<!--// 왼쪽 영역-->
	</form>

</body>
</html>
