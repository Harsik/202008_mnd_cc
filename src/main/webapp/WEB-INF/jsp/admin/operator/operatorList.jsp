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
	
		//팝업 테스트. 공지사항 제목에 걸려있음.
		function popup_test(){ //경로, 가로, 세로, 아이디
			gfn_popup("/operator/testpopup.do", "400", "400", "bpopupTest");
		};

		
		function layer_popup_test(){ //아이디, 경로, 파라미터, 가로
			openBpopup("bpopupTest", "/operator/testpopup.do", "", "400");
		};
		
		$(document).on("click", ".mr5", function() {
			location.href= "/admin/userWrite.do";
		});		
		
	</script>
   <!--contents_area-->
    <div id="content_a">
		<!--content_main-->
		<div class="content_main">
			<!--contents-->
			<div class="contents_a">
				<!--title-->
				<h3>교환원 관리 목록</h3>
				<!--//title-->
				<!--검색-->
				<form method="get" action="#" class="search-box_ad">
						<fieldset>
							<legend>검색</legend>
								<select name="" title="조건을 선택하세요" class="select-type">
									<option>선택하세요</option>
									<option>아이디</option>
									<option>사용자이름</option>
									<option>부대</option>
								</select>
								<span class="word-input">
									<input type="text" name="" value="" title="검색어를 입력하세요" />
									<button type="submit" class="search_ad-btn ml5">
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
								<th scope="col">사용자이름</th>
								<th scope="col">부대</th>
								<th scope="col">IP</th>
								<th scope="col">등록일</th>
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
								<td class="center"></td>
								<td><a href="#"><c:out value="${data.employeeId}"/></a></td>
								<td class="center"><c:out value="${data.employeeName}"/></td>
								<td class="center">60대대</td>
								<td class="center"></td>
								<td class="center"><c:out value="${data.regDt}"/></td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
				<!--//일반관리 목록 게시판-->
				<!--페이징-->
				<!-- <div class="tbl_bottom">
					<div class="pagination">
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
					</div>
				</div> -->
				<!--//페이징-->
			</div>
			<!--//contents-->
			
			
		</div>
		<!--//content_main-->
    </div>
    <!--//contents_area-->
</div>
