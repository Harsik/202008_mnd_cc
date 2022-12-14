<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/layout/include/incHeader.jspf"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!-- <link rel="stylesheet" type="text/css" href="../css/common.css" />   -->
<link rel="stylesheet" type="text/css" href="../css/tabs.css" />
<link rel="stylesheet" type="text/css" media="screen" href="../dtree/dtree.css" />
<link rel="stylesheet" type="text/css" media="screen" href="../jqgrid/css/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" media="screen" href="../jqueryui/jquery-ui.css" />

<link rel="stylesheet" href="../css/17/sub.css" />

<!--[if lt ie 9]> 
	<link rel="stylesheet" href="../css/17/sub_ie8.css" />
<![endif]-->

<script type="text/javascript" src="../js/tabs.js"></script>
<script type="text/javascript" src="../dtree/dtree.js"></script>
<script type="text/javascript" src="../jqgrid/js/jquery.jqGrid.min.js"></script>

<!-- <script src="../js/17/jQuery.fixTableHeader.min.js"></script> -->

<script type="text/javascript">
	
		$(document).ready(function() {
			
            $('.tab-toggle').click(function() {
                $('.section').each(function() {
                    $(this).addClass(" hidden");
                })

                $('#left-' + $(this).attr('data-target') + '').removeClass("hidden");
                $('#right-' + $(this).attr('data-target') + '').removeClass("hidden");
            });
			$( ".tab2>li>a" ).click(function() {
				$(this).parent().addClass("on").siblings().removeClass("on");
				return false;
			});
			init();
			//$('#mypage').addClass('active');
			active(3);
		})
		
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
		
		function init() {
			$.ajax({   
				url:"/intra/selectSearchHistList.do",
				type:"post",
				dataType:'json',
				success:function(data) {
					//console.log(data);
					setSelectInfo(data);	
				}
				
			});
		}
	
		
		function setSelectInfo(result) {
		//	console.log(result.list);
			
			if(result.list !=0) {
				$("#searchListTh").show();
				$("#searchList").html(makeSearchList(result.list));
			} else {
				$("#searchList").html("???????????????????????????");
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
		}

		function searchHistory() {
			location.href= "/intra/searchHistory.do"
		}
		
		
		function deleteBookMark(seq) {
			var frm = document.form1;
			
			if(confirm("????????????????????????? ")) {
				
				frm.seq.value = seq;
				frm.action = "/intra/deleteBookMark.do";
				frm.submit();
			}
		}
		
		$(document).on("click", "#del2", function() {
			if(confirm("?????????????????????????")) {
				$("#tr2").hide();
			}
		});
		
		function onListPage(page) {
			var frm = document.form1;
			frm.currentPage.value = page;
			frm.action = "/intra/myPage.do";
			frm.submit();
		};		
		
		/* function openTab(evt, resultName) {
		    var i, tabcontent, tablinks;
		    tabcontent = document.getElementsByClassName("tabcontent");
		    for (i = 0; i < tabcontent.length; i++) {
		        tabcontent[i].style.display = "none";
		    }
		    tablinks = document.getElementsByClassName("tablinks");
		    for (i = 0; i < tablinks.length; i++) {
		        tablinks[i].className = tablinks[i].className.replace(" active", "");
		    }
		    document.getElementById(resultName).style.display = "block";
		    evt.currentTarget.className += " active";
		} */
		
		function openTab(evt, resultName) {
		    var i, tabcontent, tablinks;
		    tabcontent = $(".tabcontent");
		    for (i = 0; i < tabcontent.length; i++) {
		        tabcontent[i].style.display = "none";
		    }
		    //console.log(evt);
		    tablinks = $(".tablinks");
		    for (i = 0; i < tablinks.length; i++) {
		        tablinks[i].className = tablinks[i].className.replace(" active", "");
		    }
		    document.getElementById(resultName).style.display = "block";
		    
			evt.srcElement.className += " active";
		}
		
		function deleteBookMark(seq) {
			
			
			if(confirm("????????????????????????? ")) {
				$.ajax({
					url : "/intra/deleteBookMarkAjax.do",
					type : "post",
					dataType : 'json',
					data : {
						"seq" : seq,
					},
					success : function(data) {
						if(data.result == 1) {
							//myPageAjax("0")
							window.location.reload();
							//location.href= "/intra/myPage.do";
						}
					}

				});
			}
		}
		
		
	</script>

<%-- <div id="wrapper">
	<ul class="con">
    	<li class="area">
            <div class="title"><span class="icon_title"></span>???????????????</div>
            <div class="tap_wrapper">		
                <ul class="tab2" >
                    <li class="on">
                        <a href="#">????????????</a>
                        	<!-- Contents View -->
							<div>
							  <ul class="tempty">
								
								<li class="board">
								<form id="form1" name="form1" method="POST" action="#" class="search-box_ad">
									<input type="hidden" id="seq" name="seq" value="">
									<input type="hidden" id="currentPage" name="currentPage" value='<c:out value="${paginationInfo.currentPageNo}"/>' />
									<input type="hidden" id="recordCountPerPage" name="recordCountPerPage" value='<c:out value="${paginationInfo.recordCountPerPage}"/>' />
									<input type="hidden" onclick="onListPage('1')">
									<table class="board_st2" cellpadding="0" cellspacing="0">
										 <colgroup>
											<col width="5%">
											<col width="30%">
											<!-- <col width="10%"> -->
											<col width="7%">
											<col width="8%">
											<col width="15%">
											<col width="10%">
											<col width="10%" style="min-width:60px;">
										</colgroup>
										<tr><th class="line" colspan="7"></th></tr>
										<tr>
											<th>??????</th>
											<th>??? ???</th>
											<!-- <th>??????</th> -->
											<th>??????</th>
											<th>??????</th>
											<th>??????????????????</th>
											<th>????????????</th>
											<th>??????</th>
										</tr>
										<tbody>
										<c:forEach items="${list}" var="data" varStatus="status">
										<c:set var="fullDeptNm" value="${fn:split(data.bookmarkFullDeptNm,' ')}"/>
											<tr id="tr1"> 
												<td><c:out value="${(paginationInfo.currentPageNo-1) * paginationInfo.recordCountPerPage + status.count}"/></td>
												<td style="text-align:left;"><c:out value="${data.bookmarkFullDeptNm}"/></td> 
												<td style="text-align:left;"><c:out value="${fn:split(data.bookmarkFullDeptNm,' ')[0]} "/>${fullDeptNm[fn:length(fullDeptNm)-1]}</td>
												<td><c:out value="${data.bookmarkUserRspofcNm}"/></td>
												<td><c:out value="${data.bookmarkUserRank}"/></td>
												<td><c:out value="${data.bookmarkUserNm}"/></td>
												<td><c:out value="${data.bookmarkUserTelno}"/></td>
												<td><c:out value="${data.bookmarkUserMpno}"/></td>
												<td><button type="button" class="apply-btn"  onclick="deleteBookMark('<c:out value="${data.seq}"/>');">??????</button></td>
											</tr>
										</c:forEach>	
										</tbody>
									</table>
									</form>
								</li>
								 <li class="paging">
									<page:paging paginationInfo="${paginationInfo}" jsFunction="onListPage" rowControl="false"  />
								</li> 
							</ul>
                          </div>
					</li>
					<li>
                        <a href="#">???????????????</a>
                        <div>
							  <ul class="tempty">
								
								<li class="board">
									<table class="board_st2" cellpadding="0" cellspacing="0">
										 <colgroup>
											<col width="10%">
											<col width="70%">
											<col width="20%">
										 </colgroup>
										 <thead id="searchListTh">
											<tr><th class="line" colspan="6"></th></tr>
											<tr>
												<th>??????</th>
												<th>?????????</th>
												<th>????????????</th>
											</tr>
										</thead>
										<tbody id="searchList">
										</tbody>
										
									</table>
								</li>
								<!-- <li class="paging">
									<a href="#" class="btn_prev"><<</a>
									<a href="#" class="btn_prev"><</a>
									
									<a href="#" class="num on">1</a>
									<a href="#" class="num">2</a>
									<a href="#" class="num">3</a>
									<a href="#" class="num">4</a>
									<a href="#" class="num">5</a>
									<a href="#" class="num">6</a>
									<a href="#" class="num">7</a>
									
									<a href="#" class="btn_next">></a>
									<a href="#" class="btn_next">>></a>
								</li> -->
							</ul>
                          </div>
                            <!--// Contents View -->
                        </div>
                    </li>
				</ul>
			</div>
        </li>
    </ul>
</div> --%>

<div class="wrap">
	<!--?????? ??????-->
	<div class="cont_center">
		<div class="tit">
			<img src="../images/intra_new/tit_mypage.png" alt="???????????????"><span>???????????????</span>
		</div>
		<div class="tab">
			<ul>
				<li class="tablinks active" onclick="openTab(event, 'result_tab1')">????????????</li>
				<li class="tablinks" onclick="openTab(event, 'result_tab2')">????????????</li>
			</ul>
		</div>

		<div id="result_tab1" class="tabcontent section" style="display: block; height: 89%;">
			<form id="custom_basic" class="custom_basic container-tb" id="form1" name="form1" method="POST" action="#">
				<input type="hidden" id="seq" name="seq" value="">
				<input type="hidden" id="currentPage" name="currentPage" value='<c:out value="${paginationInfo.currentPageNo}"/>' />
				<input type="hidden" id="recordCountPerPage" name="recordCountPerPage" value='<c:out value="${paginationInfo.recordCountPerPage}"/>' />
				<input type="hidden" onclick="onListPage('1')">
				<table class="customers">
					<colgroup>
						<col style="width: 5%;">
						<col style="width: 27%;">
						<col style="width: 17%;">
						<col style="width: 13%;">
						<col style="width: 10%;">
						<col style="width: 11%;">
						<col style="width: 11%;">
						<col style="width: 7%;">
					</colgroup>
					<thead>
						<tr>
							<th>??????</th>
							<th>??????</th>
							<th>??????</th>
							<th>??????</th>
							<th>??????</th>
							<th>??????????????????</th>
							<th>????????????</th>
							<th>??????</th>
						</tr>
					</thead>

					<tbody>
						<c:forEach items="${list}" var="data" varStatus="status">
							<tr id="tr1">
								<td><c:out value="${(paginationInfo.currentPageNo-1) * paginationInfo.recordCountPerPage + status.count}" /></td>
								<td><c:out value="${data.bookmarkDeptNm}" /></td>
								<td><c:out value="${data.bookmarkUserRspofcNm}" /></td>
								<td><c:out value="${data.bookmarkUserRank}" /></td>
								<td><c:out value="${data.bookmarkUserNm}" /></td>								
								<td>${fn:replace(data.bookmarkUserTelno,',',', <br>')}</td>
								<td><c:out value="${data.bookmarkUserMpno}" /></td>
								<td><a href="javascript:void(0)" class="btn" onclick="deleteBookMark('<c:out value="${data.seq}"/>');">
								<img src="../images/intra_new/i_btn_del.png" alt="??????"></a></td>
								<%-- <td><button type="button" class="apply-btn" onclick="deleteBookMark('<c:out value="${data.seq}"/>');">??????</button></td> --%>
							</tr>
						</c:forEach>
					</tbody>

				</table>
			</form>
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
		<div id="result_tab2" class="tabcontent">
			<div class="custom_basic" style="height: 85%;">
				<table class="customers">
					<colgroup>
						<col style="width: 7%;">
						<col style="width: 73%;">
						<col style="width: 20%;">
					</colgroup>
					<thead>
						<tr>
							<th>??????</th>
							<th>?????????</th>
							<th>????????????</th>
						</tr>
					</thead>
					<tbody id="searchList">
						<!-- <tr>
							<td>1</td>
							<td>?????????</td>
							<td>2018-01-02</td>
						</tr>
						<tr>
							<td>2</td>
							<td>?????????</td>
							<td>2018-01-02</td>
						</tr>
						<tr>
							<td>3</td>
							<td>?????????</td>
							<td>2018-01-02</td>
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
					<%-- <page:paging paginationInfo="${paginationInfo}" jsFunction="onListPage" rowControl="false"  /> --%>
			</div>
		</div>
	</div>
	<!--// ?????? ??????-->


</div>
<!--// ***** wrap *****-->














<!--contents_area-->
<%--   <div id="content_is">
		<!--content_main-->
		<div class="content_main_i">
			<!--lnb-->
			<div class="lnb">
				<h3>???????????????</h3>
				<ul>
					<li class="on"><a href="javascript:myPage();">????????????</a></li>
					<li><a href="javascript:searchHistory();">???????????????</a></li>
				</ul>
			</div>
			<!--//lnb-->
			<!--contents-->
			<div class="contents">
				<!--title-->
				<h3>????????????</h3>
				<!--//title-->
				<!--???????????? ?????????-->
				<div class="board_type_n">	
				<form id="form1" name="form1" method="POST" action="#" class="search-box_ad">
					<input type="hidden" id="seq" name="seq" value="">
					<table class="tbn_type_board" border="1" cellspacing="0" summary="???????????? ??????????????????.">
						<caption>???????????? ?????????</caption>
						<colgroup>
						<col width="5%">
						<col>
						<col width="10%">
						<col width="10%">
						<col width="10%">
						<col width="25%">
						<col width="10%">
						
						</colgroup>
						<thead>
							<tr>
								<th scope="col">??????</th>
								<th scope="col">??????</th>
								<th scope="col">??????????????????</th>
								<th scope="col">??????</th>
								<th scope="col">??????</th>
								<th scope="col">??????</th>
								<th scope="col">????????????</th>
								<th scope="col">??????</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach items="${list}" var="data" varStatus="status">
							<tr id="tr1"> 
								
								<td><c:out value="${(paginationInfo.currentPageNo-1) * paginationInfo.recordCountPerPage + status.count}"/></td>
								<td><c:out value="${data.bookmarkDeptNm}"/></td>
								<td><c:out value="${data.bookmarkUserTelno}"/></td>
								<td><c:out value="${data.bookmarkUserRank}"/></td>
								<td><c:out value="${data.bookmarkUserNm}"/></td>
								<td><c:out value="${data.bookmarkUserRspofcNm}"/></td>
								<td><c:out value="${data.bookmarkUserMpno}"/></td>
								<td><button type="button" class="apply-btn"  onclick="deleteBookMark('<c:out value="${data.seq}"/>');">??????</button></td>
							</tr>
						</c:forEach>	
						</tbody>
					</table>
				</form>
				</div>
				<!--//???????????? ?????????-->
				<!--?????????-->
				<!-- <div class="tbl_bottom">
					<div class="pagination">
						<a title="???????????????" class="btn_first"><span>??????????????? ??????</span></a>
						<a title="???????????????" class="btn_prev"><span>?????? ???????????? ??????</span></a>
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
						<a title="???????????????" class="btn_next"><span>?????? ???????????? ??????</span></a>
						<a title="??????????????????" class="btn_last"><span>????????????????????? ??????</span></a>
					</div>
				</div> -->
				<!--//?????????-->
			</div>
			<!--//contents-->
		</div>
		<!--//content_main-->
    </div>
    <!--//contents_area-->
 </div> --%>

