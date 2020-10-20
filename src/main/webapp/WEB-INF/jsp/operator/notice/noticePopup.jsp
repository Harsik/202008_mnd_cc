<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/layout/include/incHeader.jspf" %>
<script >
$(document).ready(function() {
	
	$("#detailView").hide();
	
});


function noticeDetail(seq) {
	var frm = document.form1;
	frm.seq.value = seq;
	frm.action = "/operator/operatorNoticeDetail.do";
	frm.submit();
}
 

function onListPage(page) {
	var frm = document.form1;
	frm.currentPage.value = page;
	frm.action = "/operator/operatorNoticeList.do";
	frm.submit();
};


function viewClick() {
	$("#detailView").show();
	$("#view").hide();
};

function confirm() {
	$("#detailView").hide();
	$("#view").show();
}


$(document).on("click","#btn_close", function() {
	window.close();
}) 


</script>


<div id="popWrap">
	<!--header-->
	<div class="popHead">
		<h1>공지사항 상세 팝업</h1>
		<a href="#" class="btn_close" id="btn_close"><img src="../images/operator/btn_p_close.gif" alt="닫기" /></a>
	</div>
    <!--//header-->
    <!--contents_area-->
    <div class="popCnt" id="view">
			<!--공지사항:list-->
			<div class="board_type">
			<form id="form1" name="form1" method="POST" action="#" class="search-box_ad">
						<input type="hidden" id="seq" name="seq" value="" />
						<input type="hidden" id="currentPage" name="currentPage" value='<c:out value="${paginationInfo.currentPageNo}"/>' />
						<input type="hidden" id="recordCountPerPage" name="recordCountPerPage" value='<c:out value="${paginationInfo.recordCountPerPage}"/>' />
						<input type="hidden" onclick="onListPage('1')">
			</form>
				<table class="tbl_type_board" border="1" cellspacing="0" summary="공지사항 게시판입니다.">
					<caption>공지사항 게시판</caption>
					<colgroup>
					<col width="9%">
					<col>
					<col width="14%">
					<col width="18%">
					<!-- <col width="14%"> -->
					<col width="12%">
					</colgroup>
					<thead>
						<tr>
							<th scope="col">번호</th>
							<th scope="col">제목</th>
							<th scope="col">작성자</th>
							<th scope="col">작성일시</th>
							<!-- <th scope="col">첨부파일</th> -->
							<th scope="col">조회수</th>
						</tr>
					</thead>
					
					<tbody>
						<c:if test="${fn:length(list) == 0}">
								<tr>
				                	<td colspan="13">
				                		NO SEARCH DATA
									</td>
								</tr>
						</c:if>
						<c:forEach items="${list}" var="data" varStatus="status">
						
							<tr>
								<td class="center"><c:out value="${(paginationInfo.currentPageNo-1) * paginationInfo.recordCountPerPage + status.count}"/></td>
								<td><a id="seq"  href="javascript:{noticeDetail('<c:out value="${data.seq}"/>')}" ><c:out value="${data.title}"/></a></td>
								<td class="c_left" ><c:out value="${data.regId}"/></td>
								<td><c:out value="${data.regDt}"/></td>
								<td><c:out value="${data.cnt}"/></td>
							</tr>
							
						
						</c:forEach>	
					</tbody>
				</table>
			</div>
			<!--//공지사항:list -->
			
			<!--페이징-->
			<div class="tbl_bottom">
			
			<page:paging paginationInfo="${paginationInfo}" jsFunction="onListPage" rowControl="false"  />
			
				<!-- <div class="pagination">
					<a title="처음페이지" class="btn_first"><span>첫페이지로 이동</span></a>
					<a title="이전페이지" class="btn_prev"><span>이전 페이지로 이동</span></a>
					<a title="1" class="on">1</a>
					<a title="2">2</a>
					<a title="3">3</a>
					<a title="4">4</a>
					<a title="5">5</a>
					<a title="6">6</a>
					<a title="7">7</a>
					<a title="8">8</a>
					<a title="9">9</a>
					<a title="19">10</a>
					<a title="다음페이지" class="btn_next"><span>다음 페이지로 이동</span></a>
					<a title="마지막페이지" class="btn_last"><span>마지막페이지로 이동</span></a>
				</div> -->
			</div>
			<!--//페이징-->
			
			<!--btnArea-->
			<!-- <div class="btnArea t_center">
				<button type="button" class="btnComm gray mr5" title="확인">확인</button>
				<button type="button" class="btnComm gr_line" title="취소">취소</button>
			</div> -->
			<!--//btnArea-->
	</div>
	<!--//contents_area-->
</div>