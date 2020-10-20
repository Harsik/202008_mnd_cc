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

<script type="text/javascript" src="../jqgrid/src/i18n/grid.locale-kr.js"></script>

<!-- <script src="../js/17/jQuery.fixTableHeader.min.js"></script> -->

<script type="text/javascript">
    var gMildsc = "";
    var gSeq = "";
	
    //jqGrid Group Mapping
    var subGridTeamCd = [];
    var subGridcolNames = [];
    var subGridcolModel = [];
    var subGridMydata = [];
    var subLength = 0;  //코드길이
    var onceExcute = false;
    var previousRowId=0;
    
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
			
			//jqGrid init
			initGrid();
			//jqGrid SubGrid init
			getSubGridHeader();
			
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
		}

		function searchHistory() {
			location.href= "/intra/searchHistory.do"
		}
		
/* 		
		function deleteBookMark(seq) {
			var frm = document.form1;
			
			if(confirm("삭제하시겠습니까? ")) {
				
				frm.seq.value = seq;
				frm.action = "/intra/deleteBookMark.do";
				frm.submit();
			}
		}
 */		
		
		$(document).on("click", "#del2", function() {
			if(confirm("삭제하시겠습니까?")) {
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
			
			
			if(confirm("삭제하시겠습니까? ")) {
				$.ajax({
					url : "/intra/deleteBookMarkAjax.do",
					type : "post",
					dataType : 'json',
					data : {
						"seq" : seq,
					},
					success : function(data) {
						/* 
						if(data.result == 1) {
							//myPageAjax("0")
							window.location.reload();
							//location.href= "/intra/myPage.do";
						}
						 */
					}

				});
				
				location.href= "/intra/myPage.do";
			}
		}
		
		$(document).on("click", "#bkmkPopup", function() {	      
			  location.href= "/intra/intraBookmarkGroupList.do"
		});
		
		function openSelectGroup(pSeq, pMildsc) {
				
	     //즐겨찾기 그룹 선택 팝업창 호출
	     var x = (window.screen.width / 2) - (650 / 2);
	     var y = (window.screen.height / 2) - (200 / 2);
	     
	     var popType = "U";
	     gMildsc = pMildsc;
	     gSeq = pSeq;
	     
	     window.open("./bkmkSelectGroupPopup.do?popType="+popType+"", "즐겨찾기"
	           , "location=no,scrollbars=no,resizable=no,top="+y+",left="+x+
	           ",width=650,height=200, screenX="+x+", screenY="+y+""); 
	     
		}
		
	  //즐겨찾기 그룹값 리턴 및 저장
	  function gChildEvent(gGroupCd) {
	    //alert('pGroupCd : '+gGroupCd);
	       
	      $.ajax({
	        url : "/intra/updateBkmkUserGroup.do",
	        type : "post",
	        dataType : 'json',
	        data : {
	          "group_id" : gGroupCd,
	          "seq" : gSeq,
	          "mildsc" : gMildsc
	        },
	        success : function(data) {
	        	window.location.reload();
	          /* 
	        	if(data.result === 1) {
	            myPageAjax();
	          }else if(data.result === "200") {
	            alert("등록되어있습니다.");
	          }
	           */
	        }
	      });
 
	  }
		
	  function fnDelBkmk()
	  {
	    var name_by_id = $('#'+this.id).attr('name').replace('btn_', '');
	    //alert(name_by_id);
	    deleteBookMark(name_by_id);
	  }	  
	  
	  function initGrid() {
	  $("#tblBkmkGroupList").jqGrid({
		    url : "/intra/intraBkmkGroupList.do",
		    datatype : "json",
		    mtype : "POST",
		    //postData : {
		    //  pJson : getJsonStrSelectBkmkGroupList("", "", g_tbbsStrtDt, g_tbbsEndDt)
		    //},
		    jsonReader : {
		      repeatitems: false
		    },		     
		    colNames : ["seq", "즐겨찾기그룹"],
		    colModel : [{ name : "seq", index : "seq", width : 10, align: "left", hidden : true},
		                { name : "groupNm", index : "groupNm", width : 100, align: "left"},
		               ],
		     
        sortname : "groupNm",
        sortorder : "asc",
        gridview : true,
        hidegrid : false,
        shrinkToFit : true,
        loadonce : false,
        scrollOffset : 0,
        height : "600",  
        width : "100%",
        regional : "kr",
        rowNum : 20,
        rowList : [20, 40, 60, 80, 100],
        autowidth : true,
        pager : "#pgBkmkGroupList",
        rownumbers : true,
        rownumWidth : 30,
        emptyrecords : "",
        caption : "",
        loadui : "enable",
        viewrecords: true,
	        
		    subGrid: true,
 		    subGridRowExpanded: function(subgrid_id, row_id) {
		           
					//이전 그리드 닫기
					if (row_id != 0) {
					 $("#tblBkmkGroupList").collapseSubGridRow(previousRowId);
					}  
					
					previousRowId = row_id;
					
					
					//init variable 
					var row = $("#tblBkmkGroupList").getRowData(row_id);
					var teamCds=[];
					var subgrid_table_id = subgrid_id+"_t";
					var gGroupCd = row.seq;
		            
		      $("#"+subgrid_id).html("<table id='"+subgrid_table_id+"' class='scroll'></table>");     
           
           //1단 그리드 그리기
           $("#"+subgrid_table_id).jqGrid({
        	     url : "/intra/intraBkmkSubGroupList.do",
        	     datatype : "json",
        	     mtype : "POST",
        	     postData : {
		        	            "group_id" : gGroupCd
		        	            },
               //datatype : "local",
               //data : subGridMydata,
               colNames: subGridcolNames,
               colModel : subGridcolModel,
               height: '100%',
               width: '100%',
               cellEdit:true,
               rownumbers : true,
               rownumWidth : 30,
               //rowNum:50,
               viewrecords: true,
               //sortname: '',
               //sortorder: ""
				        gridComplete : function()
				        {
				          var ids = $(this).getDataIDs();
				          
				          // 녹취 버튼 표시
				          for(var i = 0; i < ids.length; i++)
				          {
				            var rowId = ids[i];
				            var row = $(this).getRowData(rowId);
				            
				            if(row.seq != null && row.seq != "")
				            {				           			            	
				              var recBtn = "<button class='button' style='width: 50px;' id='btn_" + row.seq + "' " + "name='btn_" + row.seq + "'>삭제</button>";
				              $(this).jqGrid("setRowData", rowId, { DEL_BUTTON : recBtn });
				              $("#btn_" + row.seq).bind("click", fnDelBkmk);
				                
				            }
				          }
				              
				        }               
           });

		    },

        error : function(data, status, err)
        {
          networkErrorHandler(data, status, err);
        }
		  }).jqGrid("navGrid", "#pgBkmkGroupList", {edit : false, add : false, del : false, search : false});
	  }
	  
	  function getSubGridHeader() {
		  subGridcolNames = ["번호", "소속", "직책", "계급", "성명", "부대전화번호", "전화번호", "설정"];
		  subGridcolModel =
			    [
			      { name : "seq", index : "seq", align : "center", width : 50, hidden : true },
			      { name : "bookmarkFullDeptNm", index : "bookmarkFullDeptNm", align : "left", width : 320 },
			      { name : "bookmarkUserRspofcNm", index : "USR_NM", align : "center", width : 120, 
			    	  formatter: function (cellvalue, options, rowobj) {
			              var str = "";
                                      if(rowobj.mildsc =="A")
			                  str = (rowobj.bookmarkUserRspofcNm == undefined ? "" : rowobj.bookmarkUserRspofcNm);
			              else 
                                          str = (rowobj.bookmarkUserRspsbltBiznes == undefined ? "" : rowobj.bookmarkUserRspsbltBiznes);
			              return str;
			        }  
			      },
			      { name : "bookmarkUserRank", index : "bookmarkUserRank", align : "center", width : 120 },        
			      { name : "bookmarkUserNm", index : "bookmarkUserNm", align : "center", width : 120 },   
			      { name : "bookmarkUserTelno", index : "bookmarkUserTelno", align : "center", width : 180 }, 
			      { name : "bookmarkUserMpno", index : "bookmarkUserMpno", align : "center", width : 120 },
			      { name : "DEL_BUTTON", align : "center", width: 80 }
			    ];
	  }	  
	  
	</script>

	<style type="text/css">
 
		 .ui-jqgrid .ui-jqgrid-htable .ui-th-div {
		    font-weight: 600;
		    font-size: 14px;
        font-family: "malgun", sans-serif;
        line-height: 40px;
		    height:40px;
		}

    .ui-jqgrid tr.jqgrow td {
      font-size: 13px;
      font-family: "malgun", sans-serif;
      height: 38px;
    }
    
    .ui-common-table .ui-subgrid .tablediv {
      font-size: 13px;
      font-family: "malgun", sans-serif;
      height: 38px;
    }
     
	</style>

<%-- <div id="wrapper">
	<ul class="con">
    	<li class="area">
            <div class="title"><span class="icon_title"></span>마이페이지</div>
            <div class="tap_wrapper">		
                <ul class="tab2" >
                    <li class="on">
                        <a href="#">즐겨찾기</a>
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
											<th>번호</th>
											<th>소 속</th>
											<!-- <th>직책</th> -->
											<th>계급</th>
											<th>성명</th>
											<th>부대전화번호</th>
											<th>전화번호</th>
											<th>설정</th>
										</tr>
										<tbody>
										<c:forEach items="${list}" var="data" varStatus="status">
										<c:set var="fullDeptNm" value="${fn:split(data.bookmarkFullDeptNm,' ')}"/>
											<tr id="tr1"> 
												<td><c:out value="${(paginationInfo.currentPageNo-1) * paginationInfo.recordCountPerPage + status.count}"/></td>
												<td style="text-align:left; white-space: 'pre-line'; "><c:out value="${data.bookmarkFullDeptNm}"/></td> 
												<td style="text-align:left;"><c:out value="${fn:split(data.bookmarkFullDeptNm,' ')[0]} "/>${fullDeptNm[fn:length(fullDeptNm)-1]}</td>
												<td><c:out value="${data.bookmarkUserRspofcNm}"/></td>
												<td><c:out value="${data.bookmarkUserRank}"/></td>
												<td><c:out value="${data.bookmarkUserNm}"/></td>
												<td><c:out value="${data.bookmarkUserTelno}"/></td>
												<td><c:out value="${data.bookmarkUserMpno}"/></td>
												<td><button type="button" class="apply-btn"  onclick="deleteBookMark('<c:out value="${data.seq}"/>');">삭제</button></td>
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
                        <a href="#">검색어목록</a>
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
												<th>번호</th>
												<th>검색어</th>
												<th>등록일자</th>
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
	<!--왼쪽 영역-->
	<div class="cont_center">
		<div class="tit">
			<img src="../images/intra_new/tit_mypage.png" alt="마이페이지"><span>마이페이지</span>
		</div>
		<div class="tab">
			<ul>
				<li class="tablinks active" onclick="openTab(event, 'result_tab1')">즐겨찾기</li>
				<li class="tablinks" onclick="openTab(event, 'result_tab2')">검색이력</li>
			</ul>
			<p class="btn_area_write" style="float: right;margin:-33px 0px;">
				<a href="#" class="btn_write" id="bkmkPopup" >그룹관리</a> 
			</p>
		</div>

      <!-- 그리드테이블 -->
      <div id="result_tab1" class="tabcontent section" style="display: block; height: 82%;">  
        <table id="tblBkmkGroupList"></table>
        <div id="pgBkmkGroupList"></div>
      </div>
      
<%-- 
		<div id="result_tab1" class="tabcontent section" style="display: block; height: 85%">
			<form id="custom_basic" class="custom_basic container-tb" id="form1" name="form1" method="POST" action="#">
				<input type="hidden" id="seq" name="seq" value="">
				<input type="hidden" id="currentPage" name="currentPage" value='<c:out value="${paginationInfo.currentPageNo}"/>' />
				<input type="hidden" id="recordCountPerPage" name="recordCountPerPage" value='<c:out value="${paginationInfo.recordCountPerPage}"/>' />
				<input type="hidden" onclick="onListPage('1')">
				<table class="customers">
					<colgroup>
						<col style="width: 5%;">
						<col style="width: 15%;">
						<col style="width: 27%;">
						<col style="width: 13%;">
						<col style="width: 7%;">
						<col style="width: 7%;">
						<col style="width: 10%;">
						<col style="width: 10%;">
						<col style="width: 7%;">
					</colgroup>
					<thead>
						<tr>
							<th>번호</th>
							<th>즐겨찾기그룹</th>
							<th>소속</th>
							<th>직책</th>
							<th>계급</th>
							<th>성명</th>
							<th>부대전화번호</th>
							<th>전화번호</th>
							<th>설정</th>
						</tr>
					</thead>

					<tbody>
						<c:forEach items="${list}" var="data" varStatus="status">
							<tr id="tr1">
								<td><c:out value="${(paginationInfo.currentPageNo-1) * paginationInfo.recordCountPerPage + status.count}" /></td>
								
								<td class="ellipsis" style="text-align:center;">
								  <a id="seq" href="javascript:{openSelectGroup('<c:out value="${data.seq}"/>','<c:out value="${data.mildsc}"/>')}">
									<c:out value="${data.groupNm}" />
								  </a>
								</td>
				
								<td style="white-space:pre-line;"><c:out value="${data.bookmarkFullDeptNm}" /></td> 
								<td style="text-align:left;"><c:out value="${fn:split(data.bookmarkFullDeptNm,' ')[0]} "/>${fullDeptNm[fn:length(fullDeptNm)-1]}</td>
								<c:if test="${data.mildsc == 'A'}">
									<td><c:out value="${data.bookmarkUserRspofcNm}" /></td>
								</c:if>
								<c:if test="${data.mildsc != 'A'}">
									<td><c:out value="${data.bookmarkUserRspsbltBiznes}" /></td>
								</c:if>
								<td><c:out value="${data.bookmarkUserRank}" /></td>
								<td><c:out value="${data.bookmarkUserNm}" /></td>								
								<td style="text-align:left;" >${fn:replace(data.bookmarkUserTelno,',',', <br>')}</td>
								<td><c:out value="${data.bookmarkUserMpno}" /></td>
								<td><a href="javascript:void(0)" class="btn" onclick="deleteBookMark('<c:out value="${data.seq}"/>');">
								<img src="../images/intra_new/i_btn_del.png" alt="삭제"></a></td>
								<td><button type="button" class="apply-btn" onclick="deleteBookMark('<c:out value="${data.seq}"/>');">삭제</button></td>
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
 --%>		
		
		<div id="result_tab2" class="tabcontent" style="height: 89%;">
			<div class="custom_basic">
				<table class="customers">
					<colgroup>
						<col style="width: 7%;">
						<col style="width: 73%;">
						<col style="width: 20%;">
					</colgroup>
					<thead>
						<tr>
							<th>번호</th>
							<th>검색어</th>
							<th>등록일자</th>
						</tr>
					</thead>
					<tbody id="searchList">
						<!-- <tr>
							<td>1</td>
							<td>홍길동</td>
							<td>2018-01-02</td>
						</tr>
						<tr>
							<td>2</td>
							<td>홍길동</td>
							<td>2018-01-02</td>
						</tr>
						<tr>
							<td>3</td>
							<td>홍길동</td>
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
	<!--// 왼쪽 영역-->


</div>
<!--// ***** wrap *****-->














<!--contents_area-->
<%--   <div id="content_is">
		<!--content_main-->
		<div class="content_main_i">
			<!--lnb-->
			<div class="lnb">
				<h3>마이페이지</h3>
				<ul>
					<li class="on"><a href="javascript:myPage();">즐겨찾기</a></li>
					<li><a href="javascript:searchHistory();">검색어목록</a></li>
				</ul>
			</div>
			<!--//lnb-->
			<!--contents-->
			<div class="contents">
				<!--title-->
				<h3>즐겨찾기</h3>
				<!--//title-->
				<!--즐겨찾기 게시판-->
				<div class="board_type_n">	
				<form id="form1" name="form1" method="POST" action="#" class="search-box_ad">
					<input type="hidden" id="seq" name="seq" value="">
					<table class="tbn_type_board" border="1" cellspacing="0" summary="즐겨찾기 게시판입니다.">
						<caption>즐겨찾기 게시판</caption>
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
								<th scope="col">번호</th>
								<th scope="col">부서</th>
								<th scope="col">부서전화번호</th>
								<th scope="col">계급</th>
								<th scope="col">성명</th>
								<th scope="col">직책</th>
								<th scope="col">전화번호</th>
								<th scope="col">설정</th>
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
								<td><button type="button" class="apply-btn"  onclick="deleteBookMark('<c:out value="${data.seq}"/>');">삭제</button></td>
							</tr>
						</c:forEach>	
						</tbody>
					</table>
				</form>
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
 </div> --%>

