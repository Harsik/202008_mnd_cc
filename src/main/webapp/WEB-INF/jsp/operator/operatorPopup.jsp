<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/layout/include/incHeader.jspf" %>
<script type="text/javascript">

$(document).on("click","#btn_close", function() {
	window.close();
}) 


</script>
<div id="popWrap">
	<!--header-->
	<div class="popHead">
		<h1>상담이력 상세 팝업</h1>
		<a href="#" class="btn_close" id="btn_close"><img src="../images/operator/btn_p_close.gif" alt="닫기" /></a>
	</div>
    <!--//header-->
    <!--contents_area-->
    <div class="popCnt">
		<!--상담이력:list-->
		<div class="board_type">
		<!-- <div>상담이력이 없습니다.</div> -->	
			<table class="tbl_type_board" border="1" cellspacing="0" summary="상담이력 게시판입니다.">
				<caption>상담이력 게시판</caption>
				<colgroup>
				<col width="20%">
				<col width="15%">
				<col>
				<col width="15%">
				<col>
				<col width="10%">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">인아웃바운드구분</th>
						<th scope="col">시간</th>
						<th scope="col">전화번호</th>
						<th scope="col">통화시간</th>
						<th scope="col">전환대상</th>
						<!-- <th scope="col">처리유형</th> -->
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
					<c:if test="${ data.callType == 11}">
						<td>인바운드</td>
					</c:if>
					<c:if test="${ data.callType == 14}">
						<td>인바운드후 협의</td>
					</c:if>
					<c:if test="${ data.callType == 22}">
						<td>아웃바운드</td>
					</c:if>
					<c:if test="${ data.callType == 33}">
						<td>내선통화</td>
					</c:if>
						<td><c:out value="${ data.eventStarttime}" /></td>
						<td><c:out value="${ data.ani}" /></td>
						<td><c:out value="${ data.callTime}" />초</td>
						<td><c:out value="${ data.targetDn}" /></td>
						<!-- <td class="f_blue fBold">완료</td> -->
					</tr>
				</c:forEach> 
				</tbody>
			</table> 
		</div>
		<!--//상담이력:list -->
			
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
			
			<!--btnArea-->
			<!-- <div class="btnArea t_center">
				<button type="button" class="btnComm gray mr5" title="확인">확인</button>
				<button type="button" class="btnComm gr_line" title="취소">취소</button>
			</div> -->
			<!--//btnArea-->
	</div>
	<!--//contents_area-->
	
</div>