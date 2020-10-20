<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="popWrap">
	<!--header-->
	<div class="popHead">
		<h1>조직도 상세 팝업</h1>
		<a href="#" class="btn_close"><img src="../images/operator/btn_p_close.gif" alt="닫기" /></a>
	</div>
    <!--//header-->
    <!--contents_area-->
    <div class="popCnt">
		<div class="board_type">
			<!--공지사항 게시판 상세보기-->
						<!--공지사항:list-->
						<div class="board_type">	
							<table class="tbl_type_board" border="1" cellspacing="0" summary="공지사항 게시판입니다.">
								<caption>전화번호 검색 게시판</caption>
								<colgroup>
								<col width="7%">
								<col width="9%">
								<col width="9%">
								<col width="10%">
								<col>
								<col width="10%">
								<col width="16%">
								<col width="15%">
								<!-- <col width="11%"> -->
								
								</colgroup>
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">조직</th>
										<th scope="col">직위</th>
										<th scope="col">직급</th>
										<th scope="col">담당업무</th>
										<th scope="col">성명</th>
										<th scope="col">사무실 번호</th>
										<th scope="col">휴대번호</th>
										<!-- <th scope="col">즐겨찾기</th> -->
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>1</td>
										<td>육군</td>
										<td>하사</td>
										<td>부서장</td>
										<td>국방부 홍보</td>
										<td id="tdName"><a href="#" onclick="tdName();">고길동</a></td>
										<td>0505-1234-5678</td>
										<td>010-2222-5678</td>
										<!-- <td><a href="#"><img src="/images/operator/ico_favorite_on.png" alt="즐겨찾기"></a></td> -->
									</tr>
									<tr>
										<td>1</td>
										<td>육군</td>
										<td>중사</td>
										<td>부서장</td>
										<td>국방부 홍보</td>
										<td><a href="#">고길동</a></td>
										<td>0505-1234-5678</td>
										<td>010-1111-5678</td>
										<!-- <td><a href="#"><img src="/images/operator/ico_favorite_off.png" alt="즐겨찾기"></a></td> -->
									</tr>
								</tbody>
							</table>
						</div>
						<!--//공지사항:list -->
						
					</div>
		<!--btnArea-->
		<div class="btnArea t_center">
			<button type="button" class="btnComm gray mr5" title="확인">확인</button>
			<button type="button" class="btnComm gr_line" title="취소" onclick="self.close();">취소</button>
		</div>
		<!--//btnArea-->
	</div>
	<!--//contents_area-->
	
</div>