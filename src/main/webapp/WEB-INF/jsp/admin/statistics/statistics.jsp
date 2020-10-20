<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
				<h3>통계관리 관리</h3>
				<!--//title-->
				<!--통계 관리-->
				<!--검색-->
				<form method="get" action="#" class="search-box_st mt10 t_center">
					<fieldset>
						<legend>검색</legend>
							<span class="stit">날짜</span>
							<input type="text" name="" value="" class="w100 mr5"><img src="../images/admin/ico_calendar.png" alt="달력" />
							<span class="hyphen">~</span>
							<input type="text" name="" value="" class="w100 mr5"><img src="../images/admin/ico_calendar.png" alt="달력" />
							<span class="stit ml40">기간구분</span>
							<select name="" title="조건을 선택하세요" class="select-type w100">
								<option>선택</option>
								<option>가입신청</option>
								<option>삭제</option>
								<option>승인</option>
							</select>
							<span class="stit ml40">통계구분</span>
							<select name="" title="조건을 선택하세요" class="select-type w150">
								<option>전체</option>
								<option>가입신청</option>
								<option>삭제</option>
								<option>승인</option>
							</select>
							<button type="submit" class="search_ad-btn ml5">검색</button>
							<button type="submit" class="search_ad-btn ml5">초기화</button>
							
					</fieldset>
				</form>
				<!--//검색-->
				
				<!--통계-->
				<h4 class="sta_tit mt30 mb10">통계</h4>
				<div class="statistics">	
				</div>
				<!--//통계-->
				
			<!--//통계 관리-->
			</div>
			<!--//contents-->
			
			
		</div>
		<!--//content_main-->
    </div>
    <!--//contents_area-->
</div>

