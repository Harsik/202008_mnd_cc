<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script >
$(document).ready(function() {
	
	$("#detailView").hide();
});

function viewClick() {
	alert("show hide click event");
	$("#detailView").show();
	$("#view").hide();
};

function confirm() {
	$("#detailView").hide();
	$("#view").show();
}



</script>


<div id="popWrap">
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
				<table class="tbl_type_board" border="1" cellspacing="0" summary="공지사항 게시판입니다.">
					<caption>공지사항 게시판</caption>
					<colgroup>
					<col width="9%">
					<col>
					<col width="14%">
					<col width="18%">
					<col width="14%">
					<col width="12%">
					</colgroup>
					<thead>
						<tr>
							<th scope="col">긴급</th>
							<th scope="col">제목</th>
							<th scope="col">작성자</th>
							<th scope="col">작성일시</th>
							<th scope="col">첨부파일</th>
							<th scope="col">조회수</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>일반</td>
							<td class="c_left" id="viewTd"><a href="#" onclick="viewClick();">공지사항입니다.공지사항입니다.공지사항입니다.</a></td>
							<td>고길동님</td>
							<td>2018-01-25</td>
							<td>1</td>
							<td>12</td>
						</tr>
						<tr>
							<td>일반</td>
							<td class="c_left"><a href="#">공지사항입니다.공지사항입니다.공지사항입니다.</a></td>
							<td>고길동님</td>
							<td>2018-01-25</td>
							<td>1</td>
							<td>12</td>
						</tr>
						<tr>
							<td>일반</td>
							<td class="c_left"><a href="#">공지사항입니다.공지사항입니다.공지사항입니다.</a></td>
							<td>고길동님</td>
							<td>2018-01-25</td>
							<td>1</td>
							<td>12</td>
						</tr>
						<tr>
							<td>일반</td>
							<td class="c_left"><a href="#">공지사항입니다.공지사항입니다.공지사항입니다.</a></td>
							<td>고길동님</td>
							<td>2018-01-25</td>
							<td>1</td>
							<td>12</td>
						</tr>
						<tr>
							<td>일반</td>
							<td class="c_left"><a href="#">공지사항입니다.공지사항입니다.공지사항입니다.</a></td>
							<td>고길동님</td>
							<td>2018-01-25</td>
							<td>1</td>
							<td>12</td>
						</tr>
					</tbody>
				</table>
			</div>
			<!--//공지사항:list -->
			
			<!--페이징-->
			<div class="tbl_bottom">
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
			</div>
			<!--//페이징-->
			
			<!--btnArea-->
			<div class="btnArea t_center">
				<button type="button" class="btnComm gray mr5" title="확인">확인</button>
				<button type="button" class="btnComm gr_line" title="취소">취소</button>
			</div>
			<!--//btnArea-->
	</div>
	<!--//contents_area-->
	
	<div class="popCnt" id="detailView">
		<div class="board_type">
			<!--공지사항 게시판 상세보기-->
			<table class="tbl_type_board" border="1" cellspacing="0" summary="공지사항 게시판 상세보기입니다.">
				<caption>공시사항 게시판 상세보기</caption>
				<colgroup>
				<col width="20%">
				<col>
				</colgroup>
				<tbody>
					<tr>
						<th scope="col" class="p_th">번호</th>
						<td class="p_left">8888</td>
					</tr>
					<tr>
						<th scope="col" class="p_th">이름</th>
						<td class="p_left">고길동</td>
					</tr>
					<tr>
						<th scope="col" class="p_th">내용</th>
						<td class="p_contents">내용들어갑니다.<br>내용들어갑니다.<br>내용들어갑니다.<br>내용들어갑니다.<br>내용들어갑니다</td>
					</tr>
				</tbody>
			</table>
			<!--//공지사항 게시판 상세보기-->
		</div>
		<!--btnArea-->
		<div class="btnArea t_center">
			<button type="button" class="btnComm gray mr5" onclick="confirm();" title="확인">확인</button>
			<button type="button" class="btnComm gr_line" title="취소">취소</button>
		</div>
		<!--//btnArea-->
	</div>
	<!--//contents_area-->
	
</div>