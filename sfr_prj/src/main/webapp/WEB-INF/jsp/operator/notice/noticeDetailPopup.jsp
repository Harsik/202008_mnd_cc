<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/layout/include/incHeader.jspf" %>
<script >
$(document).ready(function() {
	$("#detailView").hide();
	
	//init();
});


function noticeDetail(seq) {
	var frm = document.form1;
	frm.seq.value = seq;
	frm.action = "/operator/operatorNoticeDetail.do";
	frm.submit();
};
/*
function viewClick() {
	$("#detailView").show();
	$("#view").hide();
};

function confirm() {
	$("#detailView").hide();
	$("#view").show();
}
 */
 
 function back() {
	 
	    var val = $("#seq").val();	 	
	    var frm = document.form1;
		frm.currentPage.value = val;
		frm.action = "/operator/operatorNoticeList.do";
		frm.submit();
 };
 
 


</script>


<div id="popWrap">
	<!--header-->
	<div class="popHead">
		<h1>공지사항 상세 팝업</h1>
		<a href="#" class="btn_close"><img src="../images/operator/btn_p_close.gif" alt="닫기" /></a>
	</div>
    <!--//header-->
    <!--contents_area-->
    <div class="popCnt">
		<div class="board_type">
			<!--공지사항 게시판 상세보기-->
			<table class="tbl_type_board" border="1" cellspacing="0" summary="공지사항 게시판 상세보기입니다.">
				<caption>공시사항 게시판 상세보기</caption>
				<colgroup>
				<col width="20%">
				<col>
				</colgroup>
				<tbody>
				<c:forEach items="${list}" var="data" varStatus="status">
				<form id="form1" name="form1" method="POST" action="#" class="search-box_ad">
					<input type="hidden" id="seq" name="seq" value='<c:out value="${ data.seq}" />'>
					<input type="hidden" id="currentPage" name="currentPage" value='<c:out value="${ data.seq}" />'>
				</form>
					<tr>
						<th scope="col" class="p_th">번호</th>
						<td class="p_left"><c:out value="${ data.seq}" /></td>
					</tr>
					<tr>
						<th scope="col" class="p_th">이름</th>
						<td class="p_left"><c:out value="${ data.regId}" /></td>
					</tr>
					<tr>
						<th scope="col" class="p_th">내용</th>
						<td class="p_contents"><c:out value="${data.content}" /></td>
					</tr>
				</c:forEach>	
				</tbody>
			</table>
			<!--//공지사항 게시판 상세보기-->
		</div>
		<!--btnArea-->
		<div class="btnArea t_center">
			<button type="button" class="btnComm gray mr5" title="확인" onClick="back();">확인</button>
			<button type="button" class="btnComm gr_line" title="취소" onClick="back();">취소</button>
		</div>
		<!--//btnArea-->
	</div>
	<!--//contents_area-->
	
</div>
