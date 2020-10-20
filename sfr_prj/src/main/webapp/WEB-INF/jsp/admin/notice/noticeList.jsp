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
	  
	<script type="text/javascript">
	
	
	
	function noticeDetail(seq) {
		var frm = document.form1;
		frm.seq.value = seq;
		frm.action = "/admin/noticeModify.do";
		frm.submit();
	}
	
	
	function onListPage(page) {
		var frm = document.form1;
		frm.currentPage.value = page;
		frm.action = "/admin/noticeList.do";
		frm.submit();
	};
	
	
	function noticeWrite() {
		
		location.href = "/admin/noticeWrite.do";
	}
	/* 	//팝업 테스트. 공지사항 제목에 걸려있음.
		function popup_test(){ //경로, 가로, 세로, 아이디
			gfn_popup("/operator/testpopup.do", "400", "400", "bpopupTest");
		};

		
		function layer_popup_test(){ //아이디, 경로, 파라미터, 가로
			openBpopup("bpopupTest", "/operator/testpopup.do", "", "400");
		};
		
		$(document).on("click", ".addBt", function() {
			location.href= "/admin/noticeWrite.do";
		});		

		$(document).on("click", "#subBt", function() {
			location.href= "/admin/noticeModify.do";
		});		
		 */
	</script>
   <!--contents_area-->
    <div id="content_a">
		<!--content_main-->
		<div class="content_main">
			<!--contents-->
			<div class="contents_a">
				<!--title-->
				<h3>공지사항</h3>
				<!--//title-->
				<!--검색-->
				<form id="form1" name="form1" method="POST" action="#" class="search-box_ad">
				<input type="hidden" id="seq" name="seq" value="" />
				<input type="hidden" id="currentPage" name="currentPage" value='<c:out value="${paginationInfo.currentPageNo}"/>' />
				<input type="hidden" id="recordCountPerPage" name="recordCountPerPage" value='<c:out value="${paginationInfo.recordCountPerPage}"/>' />
						<fieldset>
							<legend>검색</legend>
								<span class="stit">제목</span>
								<span class="word-input">
									<input type="text" id="searchTxt" name="searchTxt" value="<c:out value="${paramMap.searchTxt}"/>" title="검색어를 입력하세요" />
									<button type="submit" onclick="onListPage('1');" class="search_ad-btn ml5">
										조회
									</button>
								</span>
						</fieldset>
				</form>
				<!--//검색-->
				
				<!--공지사항 목록 게시판-->
				<div class="board_type_n">	
					<table class="tbp_type_board" border="1" cellspacing="0" summary="공지사항 목록 게시판입니다.">
						<caption>공지사항 목록 게시판</caption>
						<colgroup>
						<col width="7%">
						<col>
						<col width="7%">
						<col width="10%">
						<col width="15%">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">번호</th>
								<th scope="col">제목</th>
								<th scope="col">첨부파일</th>
								<th scope="col">작성자</th>
								<th scope="col">등록일</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${fn:length(list) == 0}">
								<tr>
				                	<td colspan="14">
				                		NO SEARCH DATA
									</td>
								</tr>
						</c:if>
						<c:forEach items="${list}" var="data" varStatus="status">
						
							<tr>
							  <td class="center"><c:out value="${(paginationInfo.currentPageNo-1) * paginationInfo.recordCountPerPage + status.count}"/></td>
								<td><a id="seq"  href="javascript:{noticeDetail('<c:out value="${data.seq}"/>')}" ><c:out value="${data.title}"/></a></td>							
								<td class="center" ><img src="${(data.atchCnt != 0 ? '../images/admin/ico_attach.png' : '')}" /></td>
								<%-- 
								<td class="center" >								  
									<c:choose>
									    <c:when test="${data.atchCnt == 0}">
									        <img src="" />
									    </c:when>
									    <c:when test="${data.atchCnt != 0}">
									        <img src="../images/admin/ico_attach.png" />
									    </c:when>
									</c:choose>
								</td>
								 --%>
								<td class="c_left" ><c:out value="${data.regId}"/></td>
								<td><c:out value="${data.regDt}"/></td>
								<%-- <td><c:out value="${data.cnt}"/></td> --%>
							</tr>
							
						
						</c:forEach>	
						</tbody>
					</table>
				</div>
				<!--//공지사항 목록 게시판-->
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
				<!--btn_area-->
				<div class="tbl_bottom">
					<div class="t_right">
					  <button type="button" name="btnModi" id="btnModi" class="btnComm grblue addBt" title="등록" onclick="noticeWrite();">등록</button>
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

