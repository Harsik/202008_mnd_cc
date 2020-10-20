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
	
		function onListPage(page) {
			var frm = document.form1;
			frm.currentPage.value = page;
			frm.action = "/admin/generalManagerList.do";
			frm.submit();
		};
			
		$(document).on("click", "#addBt", function() {
			location.href= "/admin/generalManagerWrite.do";
		});

		/* $(document).on("click", "#subBt", function() {
			location.href= "/admin/generalManagerModify.do";
		});	 */
		
		function generalDetail(seq) {
			var frm = document.form1;
			frm.seq.value = seq;
			frm.action = "/admin/generalManagerModify.do";
			frm.submit();
		};
		
		
	</script>
    <!--contents_area-->
    <div id="content_a">
		<!--content_main-->
		<div class="content_main">
			<!--contents-->
			<div class="contents_a">
				<!--title-->
				<h3>일반관리 관리</h3>
				<!--//title-->
				<!--검색-->
				<form id="form1" name="form1" method="POST" action="#" class="search-box_ad">
				<input type="hidden" id="seq" name="seq" value="" />
				<input type="hidden" id="currentPage" name="currentPage" value='<c:out value="${paginationInfo.currentPageNo}"/>' />
				<input type="hidden" id="recordCountPerPage" name="recordCountPerPage" value='<c:out value="${paginationInfo.recordCountPerPage}"/>' />
						<fieldset>
							<legend>검색</legend>
								<select name="searchKey" id="searchKey" title="조건을 선택하세요" class="select-type">
									<option value="0" ${paramMap.searchKey.equals('0')?'selected':'' }>선택하세요</option>
									<option value="1" ${paramMap.searchKey.equals('1')?'selected':'' }>아이디</option>
									<option value="2" ${paramMap.searchKey.equals('2')?'selected':'' }>부대</option>
								</select>
								<span class="word-input">
									<input type="text" name="searchTxt" id="searchTxt" value='<c:out value="${paramMap.searchTxt}"/>' title="검색어를 입력하세요" />
									<button type="submit" onclick="onListPage('1');" class="search_ad-btn ml5">
										조회
									</button>
								</span>
						</fieldset>
				</form>
				<!--//검색-->
				
				<!--일반관리 목록 게시판-->
				<div class="board_type_n">	
					<table class="tbp_type_board" border="1" cellspacing="0" summary="일반관리 목록 게시판입니다.">
						<caption>일반관리 목록 게시판</caption>
						<colgroup>
						<col width="7%">
						<col>
						<col>
						<col>
						<col>
						<col width="15%">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">번호</th>
								<th scope="col">아이디</th>
								<th scope="col">권한정보</th>
								<th scope="col">군명</th>
								<th scope="col">부대</th>
								<th scope="col">등록일</th>
							</tr>
						</thead>
						<tbody>
						<c:if test="${fn:length(list) == 0}">
							<tr>
			                	<td  class="center" colspan="6">
			                		NO SEARCH DATA
								</td>
							</tr>
							</c:if>
							<c:forEach items="${list}" var="data" varStatus="status">
							<tr>
								<td class="center"><c:out value="${(paginationInfo.currentPageNo-1) * paginationInfo.recordCountPerPage + status.count}"/></td>
								<td id="subBt">
								<c:if test="${sessionScope.auth =='0'}">
									<a href="javascript:{generalDetail('<c:out value="${data.seq}"/>')}"  ><c:out value="${data.mngrId}"/></a>
								</c:if>								
								<c:if test="${sessionScope.auth =='2'}">
									<c:out value="${data.mngrId}"/>
								</c:if>	
								</td>
								<c:if test="${data.auth == 1}">
									<td class="center">일반관리자</td>
								</c:if>
								<td class="center"><c:out value="${data.mildscNm}"/></td>
								<td class="center"><c:out value="${fn:replace(data.fullDeptNm,'해군 해군본부 해병대사령부','해병대사령부')}"/></td>
								<td class="center"><c:out value="${data.regDt}"/></td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<!--//일반관리 목록 게시판-->
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
						<c:if test="${sessionScope.auth =='0'}">
					  <button type="button" name="addBt" id="addBt" class="btnComm grblue addBt" title="등록">등록</button>
						</c:if>
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
