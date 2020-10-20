<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>main</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="../css/17/style_popup.css" />

<link href="../css/17/popup.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="../css/17/main_sub.css" />
<script src="../js/jquery-1.7.1.min.js"></script>
<!-- <script src="../js/17/jQuery.fixTableHeader.min.js"></script> -->
<script type="text/javascript" src="/MaWebDRM/MaWebDRM_Common.js"></script>
<script type="text/javascript" src="/MaWebDRM/MaWebDRM.js"></script>
<style>
   html {overflow : auto;}
</style>
<script type="text/javascript">

	var page = '';
	var mildsc = '';
	var nodeId ='';

	$(document).ready(function(){
		page = '${page}';
		mildsc = '${mildsc}';
		nodeId ='${nodeId}';
		
		$(document).on("click","#paging a", function() {
		var arrId = $(this).attr("id");
		var val = arrId.split(",");
		paginTree(val[0],val[1],val[2]);
		
		
	});
	$(document).on("click","#paging2 a", function() {
		var arrId = $(this).attr("id");
		var val = arrId.split(",");
		paginTree2(val[0],val[1],val[2]);
		
		
	});

		//treeFacilityInit(page, mildsc, nodeId);
		treeInit(page, mildsc, nodeId);
	});

	function treeFacilityInit(num, mildsc, nodeId) {
		if (nodeId == "1290000") {

		} else if (nodeId == "1290451") {

		} else {
			//layer_open('layer3', '3');
		}
		
		$.ajax({
			url : "/intra/selectfacilityList.do",
			type : "post",
			dataType : 'json',
			data : {
				"mildsc" : mildsc,
				"deptCd" : nodeId,
				"setPageNum" : num
			},
			success : function(data) {
				treeFacilityPopup(data, mildsc, nodeId);
			}

		});

	}

	function treeFacilityPopup(result, mildsc, nodeId) {
		setTreeFacilltyPaging(result, mildsc, nodeId);
		var html = "";
		
		if (result.list.length != 0) {
			
			$.each(result.list, function(i, value) {
				var fullDeptNm = value.fullDeptNm.split(" ");
				var last = fullDeptNm.length - 1;
				html += "	<tr id='treeTr'>";
				html += "		<td>" + fullDeptNm[1] + " " + fullDeptNm[last]
						+ "</td>";
				//	html += "		<td>"+ value.deptNm +"</td>";
				
				var t = value.tel;
				t = t.replace(',', ',<br>');
				
				html += "		<td>" + t + "</td>";
				html += "		<td>" + value.facilityNm + "</td>";
				html += "	</tr>";

			});
			//$("#tPop2").show();
			//$("#datatext2").hide();
			$("#tPop2").html(html);
			//$("#thPop2").show();
		} else {
			//console.log(result.list.length);
			//$("#thPop2").hide();
			//$("#tPop2").hide();
			//$("#datatext2").show();
			html = "<tr><td colspan='7'>시설물 정보가 없습니다.</td></tr>";
			$("#tPop2").html(html);
		}
		//$("#popWrap").dialog("open");
	}

	// 페이징1
	$(document).on("click",".pagination a", function() {
		var arrId = $(this).attr("id");
		var val = arrId.split(",");
		paginTree(val[0],val[1],val[2]);
	});
	
	$(document).on("click",".pagination2 a", function() {
		var arrId = $(this).attr("id");
		var val = arrId.split(",");
		paginTree2(val[0],val[1],val[2]);
		
		
	});
	
	// treeInit 호출
	function paginTree(num,mildsc,nodeId) {
		treeInit(num,mildsc,nodeId);
	}
	
	function paginTree2(num,mildsc,nodeId) {
		treeFacilityInit(num,mildsc,nodeId);
	}
	
	//treePopup 호출
	function treeInit(num, mildsc, nodeId) {

		treeFacilityInit(num, mildsc, nodeId);

		if (nodeId == "1290000") {

		} else if (nodeId == "1290451") {

		} else {
			//layer_open('layer3', '3');
		}
		$.ajax({
			url : "/intra/selectDeptList.do",
			type : "post",
			dataType : 'json',
			data : {
				"mildsc" : mildsc,
				"deptCd" : nodeId,
				"setPageNum" : num
			},
			success : function(data) {
				//console.log(data);
				treePopup(data, mildsc, nodeId);
			}

		});

	}
	
	function treeFacilityInit(num,mildsc,nodeId) {
		if(nodeId == "1290000" ) {	
			
		} else if ( nodeId == "1290451") {
			
		} else {
			//layer_open('layer3','3');
		}
		$.ajax({
			url : "/intra/selectfacilityList.do",
			type : "post",
			dataType : 'json',
			data : {
				"mildsc" : mildsc,
				"deptCd" : nodeId,
				"setPageNum":num
			},
			success : function(data) {
				treeFacilityPopup(data,mildsc,nodeId);
			}

		});
		
	}

	//마지막
	function treePopup(result, mildsc, nodeId) {
		
		setTreePaging(result, mildsc, nodeId);
		var html = "";
		var nm = [];
		if (result.list.length != 0) {

			$.each(result.list, function(i, value) {
				var fullDeptNm = value.fullDeptNm.split(" ");
				var last = fullDeptNm.length - 1;
				
				html += "	<tr id='treeTr'>";
				html += "	<td>" + fullDeptNm[1] + " " + fullDeptNm[last]
						+ "</td>";
				//	html += "		<td>"+ value.deptNm +"</td>";
				var t = value.telno;
				t = t.replace(',', ',<br>');
				html += "		<td style='text-align:left;'>" + t + "</td>";
				
				html += "		<td style='white-space: pre-line;'>" + value.rank + "</td>";
				html += "		<td>" + value.nm + "</td>";
				if (value.mildsc == "A") {
					html += "		<td style='white-space: pre-line;'>" + value.rspofcNm + "</td>";
				} else {
					html += "               <td style='white-space: pre-line;'>" + value.rspsbltBiznes + "</td>";
				}
				html += "		<td>" + value.mpno + "</td>";
				html += "	</tr>";

			});
			
			//$("#tPop").show();
			//$("#datatext").hide();
			$("#tPop").html(html);
			//$("#thPop").show();
		} else {
			//console.log(result.list.length);
			//$("#thPop").hide();
			//$("#tPop").hide();
			//$("#datatext").show();
			html = "<tr><td colspan='6'>조직정보가 없습니다.</td></tr>";
			$("#tPop").html(html);
		}
		//$("#popWrap").dialog("open");
	}
	
	function setTreeFacilltyPaging(result,mildsc,nodeId){
		var htmlStr = "";
		//htmlStr += "<div class='pagination2'>";
		//htmlStr += "<a href='javascript:void(0)' id='"+ result.paging.prevPageNo+ ","+mildsc +","+nodeId+"' class='num'><img src='../images/operator/paging_btn_prev.png' alt='이전'/></a>";
		var pageSizeVal = result.paging.endPageNo - result.paging.startPageNo;
		htmlStr += "<a href='javascript:void(0)'  id='"+ result.paging.prevPageNo+ ","+mildsc +","+nodeId+"'  class='btn_prev'><</a>";
		for (var i = result.paging.startPageNo; i <= result.paging.endPageNo; i++) {
			if (i == result.paging.pageNo) {
				if(result.paging.endPageNo == 0) {
					htmlStr += "<a href='#' class='num on'><b>1</b></a>";
				} else {
					htmlStr += "<a href='javascript:void(0)' id='" + i + ","+mildsc +","+nodeId+"' class='num on'><b>" + i + "</b></a>";
				}
			} else {
				if(result.paging.endPageNo == 0) {
					htmlStr += "<a href='#' class='num on'>1</a>";
				} else {
					htmlStr += "<a href='javascript:void(0)' id='" + i + ","+mildsc +","+nodeId+"' class='num'>" + i + "</a>";
				}
			}
		}
		//htmlStr += "<a href='javascript:void(0)' id='"+ result.paging.nextPageNo+ ","+mildsc +","+nodeId+"' class='num'><img src='../images/operator/paging_btn_next.png' alt='다음'/></a>";
		//htmlStr += "</div>";
		htmlStr += "<a href='javascript:void(0)' id='"+ result.paging.nextPageNo+ ","+mildsc +","+nodeId+"' class='btn_next'>></a>";
		$("#paging2").html(htmlStr);
	}
	
	function setTreePaging(result,mildsc,nodeId){
		var htmlStr = "";
		//htmlStr += "<div class='pagination'>";
		//htmlStr += "<a href='javascript:void(0)' id='"+ result.paging.prevPageNo+ ","+mildsc +","+nodeId+"' class='num'><img src='../images/operator/paging_btn_prev.png' alt='이전'/></a>";
		var pageSizeVal = result.paging.endPageNo - result.paging.startPageNo;
		htmlStr += "<a href='javascript:void(0)'  id='"+ result.paging.prevPageNo+ ","+mildsc +","+nodeId+"' class='btn_prev'><</a>";
		for (var i = result.paging.startPageNo; i <= result.paging.endPageNo; i++) {
			if (i == result.paging.pageNo) {
				if(result.paging.endPageNo == 0) {
                                        htmlStr += "<a href='#' class='num on'><b>1</b></a>";
                                } else {
					htmlStr += "<a href='javascript:void(0)' id='" + i + ","+mildsc +","+nodeId+"'  class='num on'><b>" + i + "</b></a>";
				}
			} else {
				if(result.paging.endPageNo == 0) {
                                        htmlStr += "<a href='#' class='num on'><b>1</b></a>";
                                } else {
				htmlStr += "<a href='javascript:void(0)' id='" + i + ","+mildsc +","+nodeId+"' class='num'>" + i + "</a>";
			}}
		}
		//htmlStr += "<a href='javascript:void(0)' id='"+ result.paging.nextPageNo+ ","+mildsc +","+nodeId+"' class='num'><img src='../images/operator/paging_btn_next.png' alt='다음'/></a>";
		//htmlStr += "</div>";
		htmlStr += "<a href='javascript:void(0)' id='"+ result.paging.nextPageNo+ ","+mildsc +","+nodeId+"'  class='btn_next'>></a>";
		//p1 = htmlStr;
		
		$("#paging").html(htmlStr);
	}
</script>

</head>
<body onload="resizeTo(1000,800)">
	<!--***** wrap *****-->
	<div class="wrap">
		<!--왼쪽 영역-->
		<div class="cont_left">
			<div class="tab">
				<ul>
					<li class="tablinks active" onclick="openTab(event, 'result_tab1')">사용자</li>
					<li class="tablinks" onclick="openTab(event, 'result_tab2')">시설물상세</li>
				</ul>
			</div>

			<div id="result_tab1" class="tabcontent" style="display: block;">
				<div class="custom_basic">
					<div id="right-fixedHeader" class="section">
						<div id="tableContainer" class="container-tb" style="border-left: 1px solid #e2e1e9; border-right: 1px solid #e2e1e9;">
							<table>
								<thead>
									<tr>
										<th style="width: 24%;" class="fth-header">소속</th>
										<th style="width: 17%;" class="fth-header">사무실번호</th>
										<th style="width: 17%;" class="fth-header">계급</th>
										<th style="width: 11%;" class="fth-header">성명</th>
										<th style="width: 17%;" class="fth-header">직책</th>
										<th style="width: 14%;" class="fth-header">휴대번호</th>
									</tr>
								</thead>
								<tbody id="tPop">
									
								</tbody>
							</table>
						</div>
						<div class="paging" id="paging" style="width: 100%;">
							<a href="#" class="num on">1</a>
							<!-- <a href="#" class="btn_prev"><</a> <a href="#" class="num on">1</a>
							<a href="#" class="num">2</a> <a href="#" class="num">3</a> <a
								href="#" class="num">4</a> <a href="#" class="num">5</a> <a
								href="#" class="num">6</a> <a href="#" class="num">7</a> <a
								href="#" class="num">8</a> <a href="#" class="num">9</a> <a
								href="#" class="num">10</a> <a href="#" class="btn_next">></a> -->
						</div>
					</div>
				</div>
			</div>
			<!-- 시설물 -->
			<div id="result_tab2" class="tabcontent">

				<div class="custom_basic">
					<div id="right-fixedHeader" class="section">
						<div id="tableContainer2" class="container-tb" style="border-left: 1px solid #e2e1e9; border-right: 1px solid #e2e1e9;">
							<table>
								<thead>
									<tr>
										<th class="fth-header"  style="width: 30%;">소속</th>
										<th class="fth-header" style="width: 45%;">사무실번호</th>
										<th class="fth-header" style="width: 25%;">시설물명</th>
									</tr>
								</thead>
								<tbody id="tPop2">
									<!-- <tr>
										<td>국방부 국직기관 행정보단 분서개작처 특수지도과</td>
										<td class="txt_left">군) 975-4145, 일) 042-878-4145</td>
										<td>지도군무서기</td>
										<td>이홍락</td>
										<td>5구역 지형 DB구축원</td>
										<td>010-5555-6666</td>
									</tr> -->
								</tbody>
							</table>
						</div>
						<div class="paging" id="paging2" style="width: 100%;">
						<a href="#" class="num on">1</a>	
							<!-- <a href="#" class="btn_prev"><</a> <a href="#" class="num on">1</a>
							<a href="#" class="num">2</a> <a href="#" class="num">3</a> <a
								href="#" class="num">4</a> <a href="#" class="num">5</a> <a
								href="#" class="num">6</a> <a href="#" class="num">7</a> <a
								href="#" class="num">8</a> <a href="#" class="num">9</a> <a
								href="#" class="num">10</a> <a href="#" class="btn_next">></a> -->
						</div>
					</div>
				</div>
			</div>
		</div>
		<!--// 왼쪽 영역-->
	</div>
	<!--// ***** wrap *****-->


	<script>
		/* function openTab(evt, resultName) {
			var i, tabcontent, tablinks;
			tabcontent = document.getElementsByClassName("tabcontent");
			for (i = 0; i < tabcontent.length; i++) {
				tabcontent[i].style.display = "none";
			}
			tablinks = document.getElementsByClassName("tablinks");
			for (i = 0; i < tablinks.length; i++) {
				tablinks[i].className = tablinks[i].className.replace(
						" active", "");
			}
			document.getElementById(resultName).style.display = "block";
			evt.currentTarget.className += " active";
		} */
		
		function openTab(evt, resultName) {
		    var i, tabcontent, tablinks;
		    tabcontent = $(".tabcontent");
		    for (i = 0; i < tabcontent.length; i++) {
		        tabcontent[i].style.display = "none";
		        //tablinks[i].css({'display': 'none'});
		    }
		    //console.log(evt);
		    tablinks = $(".tablinks");
		    //console.log(tablinks);
		    for (i = 0; i < tablinks.length; i++) {
		        tablinks[i].className = tablinks[i].className.replace(" active", "");
		    	//tablinks[i].remove("active");
		    }
		    document.getElementById(resultName).style.display = "block";
		    //$('#'+resultName).css('display', 'block');
		    //console.log(evt.srcElement);
		    
		    $("#tab-2").hide();
			$("#tab-3").hide();
			$("#tab-4").hide();
			//evt.currentTarget.className += " active";
			evt.srcElement.className += " active";
		}
	</script>
	<script>
		$(document).ready(
				function() {

					/* $('#tableContainer').fixTableHeader();
					$('#tableContainer2').fixTableHeader(); */

					$('.tab-toggle').click(
							function() {
								$('.section').each(function() {
									$(this).addClass(" hidden");
								})

								$('#left-' + $(this).attr('data-target') + '')
										.removeClass("hidden");
								$('#right-' + $(this).attr('data-target') + '')
										.removeClass("hidden");

							});

					$('.tab-toggle').click(
							function() {
								$('.section').each(function() {
									$(this).addClass(" hidden");
								})

								$('#left-' + $(this).attr('data-target') + '')
										.removeClass("hidden");
								$('#right-' + $(this).attr('data-target') + '')
										.removeClass("hidden");
							});
				})
	</script>

</body>
</html>
