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
	
		$(document).ready(function() {
			$("#searchListTh").hide();
			init();
		})
	
		function init() {
			$.ajax({   
				url:"/intra/selectSearchHistList.do",
				type:"post",
				dataType:'json',
				success:function(data) {
					
					setSelectInfo(data);	
				}
				
			});
		}
	
		
		function setSelectInfo(result) {
			//console.log(result.list);
			
			if(result.list !=0) {
				$("#searchListTh").show();
				$("#searchList").html(makeSearchList(result.list));
			} else {
				$("#searchList").html("검색이력이없습니다");
			}
		};		
		
		function makeSearchList(result) {
		
			var searchList = "";
			
			$.each(result, function(i, value) {
				var num = i+1;
				
				if(value != "undefine") {
					searchList += "<tr>";
					searchList += "	<td>"+ num +"</td>";
					searchList += " <td>"+ value.sechwd+"</td>";
					searchList += " <td>"+ value.regDt +"</td>";
					searchList += "</tr>";
				}
				
			})
			return searchList;
			
		};
		
		function myPage() {
			location.href= "/intra/myPage.do"
		};

	</script>

   <!--contents_area-->
    <div id="content_is">
		<!--content_main-->
		<div class="content_main_i">
			<!--lnb-->
			<div class="lnb">
				<h3>마이페이지</h3>
				<ul>
					<li ><a href="javascript:myPage();">즐겨찾기</a></li>
					<li class="on"><a href="#">검색이력</a></li>
				</ul>
			</div>
			<!--//lnb-->
			<!--contents-->
			<div class="contents">
				<!--title-->
				<h3>검색이력</h3>
				<!--//title-->
				<!--즐겨찾기 게시판-->
				<div class="board_type_n" >	
					<table class="tbn_type_board" border="1" cellspacing="0" summary="즐겨찾기 게시판입니다.">
						<caption>즐겨찾기 게시판</caption>
						<colgroup>
						<col width="13%">
						<col width="20%">
						<col width="15%">
						</colgroup>
						<thead id="searchListTh">
							<tr>
								<th scope="col">번호</th>
								<th scope="col">검색어</th>
								<th scope="col">등록일자</th>
							</tr>
						</thead>
						<tbody id="searchList">
						</tbody>
					</table>
				</div>
				<!--//즐겨찾기 게시판-->
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