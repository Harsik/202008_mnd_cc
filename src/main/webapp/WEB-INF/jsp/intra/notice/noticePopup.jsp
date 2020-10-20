<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/layout/include/incHeader.jspf"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!-- <link rel="stylesheet" href="../css/intra/intra.css" />  -->
<link href="../../css/17/sub.css" rel="stylesheet" type="text/css" />

<!--[if lt ie 9]> 
	<link rel="stylesheet" href="../../css/17/sub_ie8.css" />
<![endif]-->

<!-- <link href="../../css/17/notice.css" rel="stylesheet" type="text/css" /> -->
<!-- <script type="text/javascript" src="../../js/17/jQuery.fixTableHeader.min.js"></script> -->
<script>
$(document).ready(function() {
	
	$("#detailView").hide();
	//$('#noticePopup').fixTableHeader();
	var pageURL = location.href;
	active(1);
		
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


function noticeDetail(seq) {
	var frm = document.form1;
	frm.seq.value = seq;
	frm.action = "/intra/intraNoticeDetail.do";
	frm.submit();
}
 

function onListPage(page) {
	var frm = document.form1;
	frm.currentPage.value = page;
	frm.action = "/intra/intraNoticeList.do";
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

</script>

<style>
@font-face {
	font-family: 'Nanum Gothic';
	font-style: normal;
	font-weight: 400;
	src: url(../../fonts/NanumGothic-Regular.eot);
	src: url(../../fonts/NanumGothic-Regular.eot?#iefix)
		format('embedded-opentype'),
		url(../../fonts//NanumGothic-Regular.woff2) format('woff2'),
		url(../../fonts/NanumGothic-Regular.woff) format('woff'),
		url(../../fonts/NanumGothic-Regular.ttf) format('truetype');
}

@font-face {
	font-family: 'Nanum Gothic';
	font-style: normal;
	font-weight: 700;
	src: url(../../fonts/NanumGothic-Bold.eot);
	src: url(../../fonts/NanumGothic-Bold.eot?#iefix)
		format('embedded-opentype'), url(../../fonts/NanumGothic-Bold.woff2)
		format('woff2'), url(../../fonts/NanumGothic-Bold.woff) format('woff'),
		url(../../fonts/NanumGothic-Bold.ttf) format('truetype');
}

@font-face {
	font-family: 'Nanum Gothic';
	font-style: normal;
	font-weight: 800;
	src: url(../../fonts/NanumGothic-ExtraBold.eot);
	src: url(../../fonts/NanumGothic-ExtraBold.eot?#iefix)
		format('embedded-opentype'),
		url(../../fonts/NanumGothic-ExtraBold.woff2) format('woff2'),
		url(../../fonts/NanumGothic-ExtraBold.woff) format('woff'),
		url(../../fonts/NanumGothic-ExtraBold.ttf) format('truetype');
}
</style>

<%-- <div class="noticeList">
            	<ul>
                    <li class="board" style="height:350px; overflow:auto;">
                    <form id="form1" name="form1" method="POST" action="#" class="search-box_ad">
						<input type="hidden" id="seq" name="seq" value="" />
						<input type="hidden" id="currentPage" name="currentPage" value='<c:out value="${paginationInfo.currentPageNo}"/>' />
						<input type="hidden" id="recordCountPerPage" name="recordCountPerPage" value='<c:out value="${paginationInfo.recordCountPerPage}"/>' />
						<input type="hidden" onclick="onListPage('1')">
					</form>
                        <table class="board_st1" cellpadding="0" cellspacing="0">
                            <colgroup>
                                <col width="8%">
                                <col width="59%">
                                <col width="15%">
                                <col width="18%" style="min-width:78px;">
                            </colgroup>
                            <tr><th class="line" colspan="4"></th></tr>
                            <tr>
                                <th>번호</th>
                                <th>제목</th>
                                <th>작성자</th>
                                <th>등록일</th>
                            </tr>
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
										<td class="c_left" >관리자</td>
										<td><c:out value="${data.regDt}"/></td>
										<td><c:out value="${data.cnt}"/></td>
									</tr>
									
								
								</c:forEach>	
							</tbody>
                        </table>
                    </li>
                    <li class="paging">
						<page:paging paginationInfo="${paginationInfo}" jsFunction="onListPage" rowControl="false"  />
                    </li>
                </ul>
			</div> --%>

<!--***** wrap *****-->
<div class="wrap">
	<!--왼쪽 영역-->
	<div class="cont_center">
		<div class="tit">
			<img src="../../images/intra_new/tit_notice.png" alt="공지사항"><span>공지사항</span>
		</div>
		<form id="form1" name="form1" method="POST" action="#" class="search-box_ad">
			<input type="hidden" id="seq" name="seq" value="" />
			<input type="hidden" id="currentPage" name="currentPage" value='<c:out value="${paginationInfo.currentPageNo}"/>' />
			<input type="hidden" id="recordCountPerPage" name="recordCountPerPage" value='<c:out value="${paginationInfo.recordCountPerPage}"/>' />
			<input type="hidden" onclick="onListPage('1')">
		</form>
		<div id="result_tab1" class="tabcontent_notice" style="display: block;">
			<div class="custom_basic">
				<table class="customers">
					<colgroup>
						<col style="width: 7%;">
						<col style="width: 65%;">
						<col style="width: 7%;">
						<col style="width: 13%;">
						<col style="width: 15%;">
					</colgroup>
					<thead>
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>첨부파일</th>
							<th>작성자</th>
							<th>등록일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${list}" var="data" varStatus="status">
							<tr>
								<td><c:out
										value="${(paginationInfo.currentPageNo-1) * paginationInfo.recordCountPerPage + status.count}" /></td>
								<td class="ellipsis">
									<a id="seq" href="javascript:{noticeDetail('<c:out value="${data.seq}"/>')}">
										<c:out value="${data.title}" />
									</a>
								</td>
								<td class="center" >${(data.atchCnt != 0 ? "<img src='../images/admin/ico_attach.png' />" : '')} </td>
								<td>관리자</td>
								<td><c:out value="${data.regDt}" /></td>
								<%-- <td><c:out value="${data.cnt}" /></td> --%>
							</tr>
						</c:forEach>
						<!-- <tr>
							<td>1</td>
							<td class="ellipsis"><a href="notice_view.html">국방전화번호
									통합검색체계</a></td>
							<td>김정식</td>
							<td>2018-06-24</td>
						</tr>
						<tr>
							<td>2</td>
							<td class="ellipsis"><a href="notice_view.html">국방전화번호
									통합검색체계</a></td>
							<td>김정식</td>
							<td>2018-06-24</td>
						</tr>
						<tr>
							<td>3</td>
							<td class="ellipsis"><a href="notice_view.html">국방전화번호
									통합검색체계</a></td>
							<td>김정식</td>
							<td>2018-06-24</td>
						</tr> -->
					</tbody>
				</table>
			</div>
			<div class="paging">
				<!-- <a href="#" class="btn_prev"><<</a> <a href="#" class="btn_prev"><</a>
				<a href="#" class="num on">1</a> <a href="#" class="num">2</a> <a
					href="#" class="num">3</a> <a href="#" class="num">4</a> <a
					href="#" class="num">5</a> <a href="#" class="num">6</a> <a
					href="#" class="num">7</a> <a href="#" class="num">8</a> <a
					href="#" class="num">9</a> <a href="#" class="num">10</a> <a
					href="#" class="btn_next">></a> <a href="#" class="btn_next">>></a> -->
					<page:paging paginationInfo="${paginationInfo}" jsFunction="onListPage" rowControl="false"  />
			</div>
		</div>
		<!-- <div id="result_tab2" class="tabcontent">
			<div class="custom_basic">
				<table class="customers">
					<colgroup>
						<col style="width: 7%;">
						<col style="width: 73%;">
						<col style="width: 20%;">
					</colgroup>
					<tr>
						<th>번호</th>
						<th>검색어</th>
						<th>등록일자</th>
					</tr>
					<tr>
						<td>1</td>
						<td>홍길동</td>
						<td>2018-01-02</td>
					</tr>
					<tr>
						<td>2</td>
						<td>홍길동</td>
						<td>2018-01-02</td>
					</tr>
					<tr>
						<td>3</td>
						<td>홍길동</td>
						<td>2018-01-02</td>
					</tr>

				</table>
			</div>
			<div class="paging">
				<a href="#" class="btn_prev"><<</a> <a href="#" class="btn_prev"><</a>
				<a href="#" class="num on">1</a> <a href="#" class="num">2</a> <a
					href="#" class="num">3</a> <a href="#" class="num">4</a> <a
					href="#" class="num">5</a> <a href="#" class="num">6</a> <a
					href="#" class="num">7</a> <a href="#" class="num">8</a> <a
					href="#" class="num">9</a> <a href="#" class="num">10</a> <a
					href="#" class="btn_next">></a> <a href="#" class="btn_next">>></a>
				
			</div>
		</div> -->
	</div>
	<!--// 왼쪽 영역-->


</div>
<!--// ***** wrap *****-->

<!--// 공지사항 리스트 팝업 -->



<%-- <div id="popWrap">
	<!--header-->
	<div class="popHead">
		<h1>공지사항 상세 팝업</h1>
		<a href="#" class="btn_close"><img src="../images/operator/btn_p_close.gif" alt="닫기" /></a>
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
	<input type="checkbox" onClick="closePop();">오늘 하루 동안 열지 않음

	<!--//contents_area-->
</div> --%>
