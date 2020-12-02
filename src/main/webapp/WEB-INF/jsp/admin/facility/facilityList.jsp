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
			frm.action = "/admin/main.do";
			frm.submit();
		};
	
		function fnFacDel(seq) {
			/* var frm = document.form1;
			frm.seq.value = seq;
			frm.action = "/admin/main.do";
			frm.submit();
			 */
			 if(confirm("삭제하시겠습니까?")){
				$.ajax({   
					url:"/admin/facilityDelete.do",
					type:"post",
					dataType:'json',
					data:{"seq":seq},
					success:function(data) {
						alert("삭제되었습니다.");
						var frm = document.form1;
						frm.action = "/admin/main.do";
						frm.submit();			
					}
					
				});
			 }
		};
		
		// 체크박스 선택 삭제
		function fnFacSelDels() {

			var num = $("#chkBox:checked").length ;
			if(num < 1){
				alert("삭제할 시설물들을 선택해주세요.");
				return false;
			}
			
			var checkRow = "";
			$('#chkBox:checked').each(function() { 
		    	//alert($(this).val());
		    	checkRow = checkRow + $(this).val()+",";
			});  
			checkRow = checkRow.substring(0,checkRow.lastIndexOf( ",")); //맨끝 콤마 지우기

			//alert(checkRow);
			
			if(confirm("선택한 시설물들을 삭제하시겠습니까?")){
				$.ajax({   
					url:"/admin/facilityChkBoxDelete.do",
					type:"post",
					dataType:'json',
					data:{"checkRow":checkRow},
					success:function(data) {
						alert("삭제되었습니다.");
						var frm = document.form1;
						frm.action = "/admin/main.do";
						frm.submit();			
					}
				});
			}

		}

		function fnFacModi(seq) {
			var frm = document.form1;
			frm.seq.value = seq;
			frm.action = "/admin/facilityModify.do";
			frm.submit();
		};
		
		//팝업 테스트. 공지사항 제목에 걸려있음.
		/* function popup_test(){ //경로, 가로, 세로, 아이디
			gfn_popup("/operator/testpopup.do", "400", "400", "bpopupTest");
		};

		function popup_call(){ //경로, 가로, 세로, 아이디
			gfn_popup("/operator/callOperatorPopup.do", "600", "400", "callPopup");
		};
		
		function layer_popup_test(){ //아이디, 경로, 파라미터, 가로
			openBpopup("bpopupTest", "/operator/testpopup.do", "", "400");
		}; */
		
		$(document).on("click", "#btnAdd", function() {
			location.href= "/admin/facilityWrite.do";
		});	

		$(document).on("click", "#checkall", function() {
	        if($("#checkall").prop("checked")){
	            $("input[name=chkBox]").prop("checked",true);
	        }else{
	            $("input[name=chkBox]").prop("checked",false);
	        }
		});
		
		$(document).on("click", "#btnDels", function() {
			fnFacSelDels();
		});	
		
		$(document).on("click", "#btnCsv", function() {
			var frm = document.form1;
			frm.action = "/csv/csvDownload.do";
			frm.submit();
		});
	</script>
   <!--contents_area-->
    <div id="content_a">
		<!--content_main-->
		<div class="content_main">
			<!--contents-->
			<div class="contents_a">
				<!--title-->
				<h3>시설물 관리</h3>
				<!--//title-->
				<!--검색-->
				<form method="post" action="#" class="search-box_ad" id="form1" name="form1">
				<input type="hidden" id="seq" name="seq" value='' />
				<input type="hidden" id="currentPage" name="currentPage" value='<c:out value="${paginationInfo.currentPageNo}"/>' />
				<input type="hidden" id="recordCountPerPage" name="recordCountPerPage" value='<c:out value="${paginationInfo.recordCountPerPage}"/>' />
						<fieldset>
							<legend>검색</legend>
								<select name="searchKey" id="searchKey" title="조건을 선택하세요" class="select-type">
									<option value="0" ${paramMap.searchKey.equals('0')?'selected':'' }>선택하세요</option>
									<option value="1" ${paramMap.searchKey.equals('1')?'selected':'' }>시설물명</option>
									<option value="2" ${paramMap.searchKey.equals('2')?'selected':'' }>전화번호</option>
									<option value="3" ${paramMap.searchKey.equals('3')?'selected':'' }>등록 부대</option>
									<option value="4" ${paramMap.searchKey.equals('4')?'selected':'' }>아이디</option>
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
				
				<!--시설물관리 목록 게시판-->
				<div class="board_type_n">	
					<table class="tbp_type_board" border="1" cellspacing="0" summary="시설물관리 목록 게시판입니다.">
						<caption>시설물관리 목록 게시판</caption>
						<colgroup>
						<col width="5%">
						<col width="5%">
						<col width="18%">
						<col>
						<col width="9%">
						<col width="8%">
						<col width="8%">
						<col width="4%">
						</colgroup>
						<thead>
							<tr>
								<th scope="col"><input type="checkbox" id="checkall" /></th>
								<th scope="col">번호</th>
								<th scope="col">시설물 이름</th>
								<th scope="col">등록 부대</th>
								<th scope="col">전화번호</th>
								<th scope="col">등록자</th>
								<th scope="col">등록일</th>
								<th scope="col">삭제</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${fn:length(list) == 0}">
							<tr>
			                	<td  class="center" colspan="8">
			                		NO SEARCH DATA
								</td>
							</tr>
							</c:if>
							
							
							<c:forEach items="${list}" var="data" varStatus="status">
							<tr>
								<td class="center"><input type="checkbox" id="chkBox" name="chkBox" value="<c:out value="${data.seq}"/>" /></td>
								<td class="center"><c:out value="${(paginationInfo.currentPageNo-1) * paginationInfo.recordCountPerPage + status.count}"/></td>
								<%-- <td class="center" id="subBt"><a href="#"><c:out value="${data.facilityNm}"/></a></td> --%>
								<td class="center"><a href="#" onclick="fnFacModi('<c:out value="${data.seq}"/>')"><c:out value="${data.facilityNm}"/></a></td> 
								<td class="center"><c:out value="${fn:replace(data.fullDeptNm,'해군 해군본부 해병대사령부','해병대사령부')}"/></td> 
								<%-- <td class="center"><c:out value="${data.fullDeptNm}"/></td> --%>
								<%-- <td class="center"><c:out value="${data.tel}"/></td> --%>
								<td class="center">${fn:replace(data.tel,',',',<br/>')}</td>
								<td class="center"><c:out value="${data.regId}"/></td>
								<td class="center"><c:out value="${data.regDt}"/></td>
								<td class="center"><a href="#" onclick="fnFacDel('<c:out value="${data.seq}"/>')">삭제</a></td>
							</tr>
							</c:forEach>
							
						</tbody>
					</table>
				</div>
				<!--//시설물관리 목록 게시판-->
				<!--페이징-->
				<div class="tbl_bottom">
				<page:paging paginationInfo="${paginationInfo}" jsFunction="onListPage" rowControl="false"  />
				<!-- 
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
				<!--btn_area--> 
				<div class="tbl_bottom">
					<div class="f_left">
						<button type="button" name="btnDels" id="btnDels" class="btnComm gr_line mr5" title="선택 삭제">선택 삭제</button>
					</div>
					<button type="button" name="btnCsv" id="btnCsv" class="btnComm grblue addBt" title="CSV다운" style="float: right;margin-left: 10px;">CSV다운</button>
				<c:if test='${sessionScope.auth=="1"}'>
					<div class="t_right">
					  <button type="button" name="btnAdd" id="btnAdd" class="btnComm grblue addBt" title="등록">등록</button>
					</div>
				</c:if>
				</div>
				
				<!--//btn_area-->
			</div>
			<!--//contents-->
			
			
		</div>
		<!--//content_main-->
    </div>
    <!--//contents_area-->
</div>
