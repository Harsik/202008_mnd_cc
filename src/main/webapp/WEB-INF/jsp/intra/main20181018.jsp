<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ include file="/WEB-INF/jsp/layout/include/incHeader.jspf" %>
<link rel="stylesheet" type="text/css" href="../css/common.css" />
<link rel="stylesheet" type="text/css" href="../css/tabs.css" />

<!-- <link rel="stylesheet" type="text/css"	href="../jsTree/jstree.3.3.5//dist/themes/default/style.min.css" /> -->
<link rel="stylesheet" type="text/css"	href="../jsTree/intraTree/dist/themes/default/style.min.css" /> 
<link rel="stylesheet" type="text/css"	href="../jqueryui/jquery-ui.css" />


<script type="text/javascript"	src="../jsTree/jstree.3.3.5/jquery-1.12.1.js"></script>

<script type="text/javascript" src="../js/tabs.js"></script>
<script type="text/javascript"	src="../jsTree/intraTree/dist/jstree.min.js"></script>
<script type="text/javascript"	src="../jqueryui/jquery-ui.js"></script>



<script type="text/javascript">
	var mildsc = "";
	var id = "";
	var dept_cd = "";
	var nodeId = "";
	
	var ckMildsc = "";
	
	var JsonArrayA = new Array();
	var JsonArrayB = new Array();
	var JsonArrayC = new Array();
	var JsonArrayD = new Array();

	$(document).ready(function() {

		// 사용자/ 조직도
		$( ".tab>li>a" ).click(function() {
			$(this).parent().addClass("on").siblings().removeClass("on");
			return false;
		});
		//게시판 
		onListPage("0");
		//즐겨찾기
		myPageAjax("0");
		
		
		// 정렬 start
		$("th[name=sortbtn]").click(function(){
			var compare = $("#sortField").val();
			var order = $("#sortOrder").val();
			
			if(compare === $(this).attr("data")){
				if(order==="desc"){
					$("#sortOrder").val("asc");
				}else{
					$("#sortOrder").val("desc");
				}
			}
			$("#sortField").val($(this).attr("data"));
			search();
		});
		// 정렬 end
			
		$("#searchThead").hide();
		$("#popWrap").hide();
		
		
		/* 국방부 */
		$.ajax({
			url : "/intra/getTree.do",
			dataType : 'json',
			async : true,
			data : {
				"mildsc" : "A",
				"hgrnkDeptCd" : "#"
			},
			success : function(data) {

				$.each(data, function(idx, item) {
					JsonArrayA[idx] = {
						id : item.id,
						parent : item.parent,
						text : item.text
					};
				});

			},
			complete : function() {
				createTree("A");
			}

		});

		/* 육군 */
		$.ajax({
			url : "/intra/getTree.do",
			dataType : 'json',
			async : true,
			data : {
				"mildsc" : "B",
				"hgrnkDeptCd" : "#"
			},
			success : function(data) {

				$.each(data, function(idx, item) {
					JsonArrayB[idx] = {
						id : item.id,
						parent : item.parent,
						text : item.text
					};
				});

			},
			complete : function() {
				createTree("B");
			}

		});

		/* 해군 */
		$.ajax({
			url : "/intra/getTree.do",
			dataType : 'json',
			async : true,
			data : {
				"mildsc" : "C",
				"hgrnkDeptCd" : "#"
			},
			success : function(data) {

				$.each(data, function(idx, item) {
					JsonArrayC[idx] = {
						id : item.id,
						parent : item.parent,
						text : item.text
					};
				});

			},
			complete : function() {
				createTree("C");
			}

		});

		/* 공군 */
		$.ajax({
			url : "/intra/getTree.do",
			dataType : 'json',
			async : true,
			data : {
				"mildsc" : "D",
				"hgrnkDeptCd" : "#"
			},
			success : function(data) {

				$.each(data, function(idx, item) {
					JsonArrayD[idx] = {
						id : item.id,
						parent : item.parent,
						text : item.text
					};
				});

			},
			complete : function() {
				createTree("D");
			}

		});
	}); // ready END 

	
	function createTree(mildsc) {
		/* $("#popWrap").dialog({
			autoOpen: false,
		    resizable: false, 
		    width: 1000,
		    height : 700,
		   // modal: true,
		    draggable: true,
		    closeOnEscape: false,
		    open: function(event, ui)
		    {
		    	$(".ui-dialog-titlebar", ui.dialog | ui).hide();
		    	$(".ui-dialog-titlebar-close", ui.dialog | ui).hide();
		    	
	    	}
	     }); */
	    
		
		if (mildsc == 'A') {
			$('#treeA').jstree({
				'core' : {
					"check_callback" : false,
					/*  'data' : [
					       { "id" : "ajson1", "parent" : "#", "text" : "Simple root node" },
					       { "id" : "ajson2", "parent" : "#", "text" : "Root node 2" },
					       { "id" : "ajson3", "parent" : "ajson2", "text" : "Child 1" },
					       { "id" : "ajson4", "parent" : "ajson2", "text" : "Child 2" },
					    ] */
					'data' : JsonArrayA

				}
			}).bind("select_node.jstree", function(evt, data) { // 노드가 선택된 뒤 처리할 이벤트
				//console.log("nodeId : A" + data.node.id);
				nodeId = data.node.id;
				
 
 					treeInit("0",mildsc,nodeId);
 
			}).bind("loaded.jstree", function(evt, data) { // jstree 한단계 열기
                var depth = 2; 
                data.instance.get_container().find('li').each(function (i) {
                    //console.log(i+"        "+data.instance.get_path($(this)).length);
                    if (data.instance.get_path($(this)).length <= depth) {
                        data.instance.open_node($(this));
                    }
                });
                
                //$('#treeA').jstree(true).select_node("#");
                
            });
		} else if (mildsc == 'B') {
			$('#treeB').jstree({
				'core' : {
					"check_callback" : false,
					/* 'data' : [
					      { "id" : "ajson1", "parent" : "#", "text" : "Simple root node" },
					      { "id" : "ajson2", "parent" : "#", "text" : "Root node 2" },
					      { "id" : "ajson3", "parent" : "ajson2", "text" : "Child 1" },
					      { "id" : "ajson4", "parent" : "ajson2", "text" : "Child 2" },
					   ] */
					'data' : JsonArrayB

				}
			}).bind("select_node.jstree", function(evt, data) { // 노드가 선택된 뒤 처리할 이벤트
				//console.log("nodeId : B " + data.node.id);
				 nodeId = data.node.id;
				
				treeInit("0",mildsc,nodeId);

			}).bind("loaded.jstree", function(evt, data) { // jstree 한단계 열기
                var depth = 2; 
                data.instance.get_container().find('li').each(function (i) {
                    //console.log(i+"        "+data.instance.get_path($(this)).length);
                    if (data.instance.get_path($(this)).length <= depth) {
                        data.instance.open_node($(this));
                    }
                });
                
                //$('#treeA').jstree(true).select_node("#");
                
            });
		} else if (mildsc == 'C') {
			$('#treeC').jstree({
				'core' : {
					"check_callback" : false,
					/* 'data' : [
					      { "id" : "ajson1", "parent" : "#", "text" : "Simple root node" },
					      { "id" : "ajson2", "parent" : "#", "text" : "Root node 2" },
					      { "id" : "ajson3", "parent" : "ajson2", "text" : "Child 1" },
					      { "id" : "ajson4", "parent" : "ajson2", "text" : "Child 2" },
					   ] */
					'data' : JsonArrayC

				}
			}).bind("select_node.jstree", function(evt, data) { // 노드가 선택된 뒤 처리할 이벤트
						//console.log("nodeId : C" + data.node.id);
						 nodeId = data.node.id;
					
						treeInit("0",mildsc,nodeId);
					}).bind("loaded.jstree", function(evt, data) { // jstree 한단계 열기
		                var depth = 2; 
		                data.instance.get_container().find('li').each(function (i) {
		                    //console.log(i+"        "+data.instance.get_path($(this)).length);
		                    if (data.instance.get_path($(this)).length <= depth) {
		                        data.instance.open_node($(this));
		                    }
		                });
		                
		                //$('#treeA').jstree(true).select_node("#");
		                
		            });
		} else if (mildsc == 'D') {
			$('#treeD').jstree({
				'core' : {
					"check_callback" : false,
					/* 'data' : [
					      { "id" : "ajson1", "parent" : "#", "text" : "Simple root node" },
					      { "id" : "ajson2", "parent" : "#", "text" : "Root node 2" },
					      { "id" : "ajson3", "parent" : "ajson2", "text" : "Child 1" },
					      { "id" : "ajson4", "parent" : "ajson2", "text" : "Child 2" },
					   ] */
					'data' : JsonArrayD

				}
			}).bind("select_node.jstree", function(evt, data) { // 노드가 선택된 뒤 처리할 이벤트
				//console.log("nodeId : D" + data.node.id);
				 nodeId = data.node.id;
				
				treeInit("0",mildsc,nodeId);
			}).bind("loaded.jstree", function(evt, data) { // jstree 한단계 열기
                var depth = 2; 
                data.instance.get_container().find('li').each(function (i) {
                    //console.log(i+"        "+data.instance.get_path($(this)).length);
                    if (data.instance.get_path($(this)).length <= depth) {
                        data.instance.open_node($(this));
                    }
                });
                
                //$('#treeA').jstree(true).select_node("#");
                
            });
		}

	}
	
	
	function treeInit(num,mildsc,nodeId) {
		
		treeFacilityInit(num,mildsc,nodeId);
		
		
		if(nodeId == "1290000" ) {	
			
		} else if ( nodeId == "1290451") {
			
		} else {
			layer_open('layer3','3');
		}
		$.ajax({
			url : "/intra/selectDeptList.do",
			type : "post",
			dataType : 'json',
			data : {
				"mildsc" : mildsc,
				"deptCd" : nodeId,
				"setPageNum":num
			},
			success : function(data) {
				treePopup(data,mildsc,nodeId);
			}

		});
		
	}
	
	/*시설물 처리  */
	function treeFacilityInit(num,mildsc,nodeId) {
		if(nodeId == "1290000" ) {	
			
		} else if ( nodeId == "1290451") {
			
		} else {
			layer_open('layer3','3');
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
	
	
	$(document).on("click","#closeBt", function() {
		$('.treePopWrap').dialog('close');
	}) 
	
	function treeFacilityPopup(result,mildsc,nodeId) {
		setTreeFacilltyPaging(result,mildsc,nodeId);	
		var html = "";
		
		if(result.list.length != 0) {
			
			$.each(result.list, function(i, value) {
				var fullDeptNm = value.fullDeptNm.split(" ");
				var last = fullDeptNm.length -1;
					html += "	<tr id='treeTr'>";
					html += "		<td>"+ fullDeptNm[1] +" "+fullDeptNm[last]+"</td>";
				//	html += "		<td>"+ value.deptNm +"</td>";
					html += "		<td>"+ value.tel +"</td>";
					html += "		<td></td>";
					html += "		<td>"+ value.facilityNm +"</td>";
					html += "		<td></td>";
					html += "		<td></td>";
					html += "	</tr>";
					
						
			});
			$("#tPop2").show();
			$("#datatext2").hide();
			$("#tPop2").html(html);
		    $("#thPop2").show();
		} else {
				//console.log(result.list.length);
			$("#thPop2").hide();
			$("#tPop2").hide();
			$("#datatext2").show();
			html = "<p>시설물 정보가 없습니다.</p>";
			$("#datatext2").html(html);
		}	
		$("#popWrap").dialog("open");
	}
	
	
	

	function treePopup(result,mildsc,nodeId) {
		
		setTreePaging(result,mildsc,nodeId);	
		var html = "";
		if(result.list.length != 0) {
			
			$.each(result.list, function(i, value) {

			var fullDeptNm = value.fullDeptNm.split(" ");
			var length = fullDeptNm.length;
			var last = fullDeptNm.length -1;

				//console.log(value);
				html += "	<tr id='treeTr'>";
				/* if(length <= 3 ) {
					html += "		<td>"+ value.fullDeptNm + "</td>"
				} else if(length <= 4 ) {
					
					html += "		<td>"+ fullDeptNm[4]+" "+ fullDeptNm[last] + "</td>"; 
				} else if(length == 5 ) {
					
					html += "		<td>"+ fullDeptNm[4]+" "+ fullDeptNm[5] +" "+ fullDeptNm[last] + "</td>";
				}  */
				
				 //html += "		<td>"+ fullDeptNm[1]+ " "+ fullDeptNm[last] + "</td>"; 
				 html += "		<td>"+ value.fullDeptNm + "</td>"; 
//				 html += "		<td>"+ value.fullDeptNm + "</td>"; 
			//	html += "		<td>"+ value.deptNm +"</td>";
				html += "		<td>"+ value.telno +"</td>";
				html += "		<td>"+ value.rank +"</td>";
				html += "		<td>"+ value.nm +"</td>";
				if(value.mildsc == "A") {
				html += "		<td>"+ value.rspofcNm +"</td>";
				} else {
				html += "               <td>"+ value.rspsbltBiznes +"</td>";
				}
				html += "		<td>"+ value.mpno +"</td>";
				html += "	</tr>";
				
			});
			$("#tPop").show();
			$("#datatext").hide();
			$("#tPop").html(html);
		        $("#thPop").show();
		} else {
				//console.log(result.list.length);
			$("#thPop").hide();
			$("#tPop").hide();
			html = "<p>조직정보가 없습니다.</p>";
			$("#datatext").html(html);
		}	
		$("#popWrap").dialog("open");
	}

	function paginTree(num,mildsc,nodeId) {
		treeInit(num,mildsc,nodeId);
	}
	
	function paginTree2(num,mildsc,nodeId) {
		treeFacilityInit(num,mildsc,nodeId);
	}
	
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
	
	function setTreePaging(result,mildsc,nodeId){
		var htmlStr = "";
		htmlStr += "<div class='pagination'>";
		htmlStr += "<a href='javascript:void(0)' id='"+ result.paging.prevPageNo+ ","+mildsc +","+nodeId+"' class='list_btn'><img src='../images/operator/paging_btn_prev.png' alt='이전'/></a>";
		var pageSizeVal = result.paging.endPageNo - result.paging.startPageNo;

		for (var i = result.paging.startPageNo; i <= result.paging.endPageNo; i++) {
			if (i == result.paging.pageNo) {
				htmlStr += "<a href='javascript:void(0)' id='" + i + ","+mildsc +","+nodeId+"' class='list_btn'><b>" + i + "</b></a>";
			} else {
				htmlStr += "<a href='javascript:void(0)' id='" + i + ","+mildsc +","+nodeId+"' class='list_btn'>" + i + "</a>";
			}
		}
		htmlStr += "<a href='javascript:void(0)' id='"+ result.paging.nextPageNo+ ","+mildsc +","+nodeId+"' class='list_btn'><img src='../images/operator/paging_btn_next.png' alt='다음'/></a>";
		htmlStr += "</div>";
		$("#paging").html(htmlStr);
	}
	
	
	function setTreeFacilltyPaging(result,mildsc,nodeId){
		var htmlStr = "";
		htmlStr += "<div class='pagination2'>";
		htmlStr += "<a href='javascript:void(0)' id='"+ result.paging.prevPageNo+ ","+mildsc +","+nodeId+"' class='list_btn'><img src='../images/operator/paging_btn_prev.png' alt='이전'/></a>";
		var pageSizeVal = result.paging.endPageNo - result.paging.startPageNo;

		for (var i = result.paging.startPageNo; i <= result.paging.endPageNo; i++) {
			if (i == result.paging.pageNo) {
				htmlStr += "<a href='javascript:void(0)' id='" + i + ","+mildsc +","+nodeId+"' class='list_btn'><b>" + i + "</b></a>";
			} else {
				htmlStr += "<a href='javascript:void(0)' id='" + i + ","+mildsc +","+nodeId+"' class='list_btn'>" + i + "</a>";
			}
		}
		htmlStr += "<a href='javascript:void(0)' id='"+ result.paging.nextPageNo+ ","+mildsc +","+nodeId+"' class='list_btn'><img src='../images/operator/paging_btn_next.png' alt='다음'/></a>";
		htmlStr += "</div>";
		$("#paging2").html(htmlStr);
	}
	
	
	
	$(document).on("mouseenter","#treeTr", function() {
		$( this ).css( "background-color", "#f4f4f4" );
		 $( this).children("td").css( "cursor", "pointer" );

	});
	
	$(document).on( "mouseleave","#treeTr", function() {
		 $( this ).css( "background-color", "white" );
	 }); 
	
	
	/* 조직도 끝  */
	function Enter_Check() {
		// 엔터키의 코드는 13입니다.
		if (event.keyCode == 13) {

			search(); // 실행할 이벤트
		}
	};
	function search(pageNm) {
		
		var special_pattern = /['~!@#$%^&*|\\\'\";:\/"]/gi;

		if ($("#query").val() == "" || $("#query").val() == null) {
			alert("검색어를 입력해주세요.");
			return;
		}
		if ($("#query").val() == "씨발" ) {
		       alert("비속어를 입력 하지마세요.");
		        
		      return $("#query").val("");
		 }
		    
		 if ($("#query").val() == "미친" ) {
		       alert("비속어를 입력 하지마세요.");
		       
		      return $("#query").val("");
		 }
		
		if(special_pattern.test($("#query").val()) == true){
			alert("특수문자는 사용할수 없습니다.");
		        
		        return $("#query").val("");
	         }

		
		    var tmp = "";
		    $("input[name=range]").each(function(idx,val){
	                 if($(this).is(":checked")){
	                 	tmp += $(this).val();
	                 	tmp += "$";
	                 }
	            });

		$.ajax({
			url : "/intraSearch.do",
			type : "post",
			dataType : 'json',
			data : {
				"value" : $("#query").val()
				, "setPageNum" : pageNm
				, "range" : tmp
				, "tar_range" : $("#tar_range").val()
                , "sortField" : $("#sortField").val()
                , "sortOrder" : $("#sortOrder").val()},
			success : function(data) {
				setSearch(data);
			}
		})
	};

	function setSearch(result) {

		if (result.data.length != 0) {

			$("#searchThead").show();
			$("#searchTbody").html(makeSearchString(result.data));
			setPaging(result.paging);
		} else {
			$("#searchTbody").html("검색어 결과가 없습니다.");
		}
	};

	function resultCnt(result) {
		var rscnt = "";
		var rscntext = "";
		if(result.data[0].temp != "") {
			rscnt = result.data[0].temp;
			rscntext = rscnt+"건이 검색되었습니다.";
		} else {
			rscntext = "";
		}

		$("#rscnt").html(rscntext);
	};
	
	function makeSearchString(result) {
		var searchHtml = "";

		$.each(result,function(i, value) {
			var mildsc = value.mildsc;
			var id = value.id;
			var dept_cd = value.dept_cd;
					
			var fullDeptNm = value.full_dept_nm.split(" ");
			var last = fullDeptNm.length -1;
	
			searchHtml += "<tr id='searchTr'>";
			if(value.facility_nm != "") {
						searchHtml += "  <td>" + fullDeptNm[0]+ " "+ fullDeptNm[last] + "<br/>/ "+value.facility_nm+"</td>";
						searchHtml += "  <td style='text-align:center;' ></td>";
						searchHtml += "  <td style='text-align:center;' >" + value.rank + "</td>";
                        searchHtml += "  <td style='text-align:center;' >" + value.nm + "</td>";
                        if(value.telno.length == 8) {
                                searchHtml += "  <td>군)"+ value.telno +"</td>";
                        } else {
                                searchHtml += "  <td>"+ value.telno.replace("일반)","일)") +"</td>";
                        }

                        searchHtml += "<td style='text-align:center;' >" + value.mpno + "</td>";
                        searchHtml += "<td class='star'>";
                        searchHtml += "<label class='myCheckbox '>";
                        searchHtml += "<a  href='javascript:void(0);'><img src='../images/operator/ico_favorite_off.png' id='"+mildsc+","+id+","+dept_cd+"' alt='즐겨찾기' ></a>";
                        searchHtml += "</label>";
                        searchHtml += "</td>";
                        searchHtml += "</tr>";

			} else {
								searchHtml += "  <td>" + fullDeptNm[0]+ " "+ fullDeptNm[last] + "</td>";
							if(value.mildsc == "A" ) {
        		                searchHtml += "  <td style='text-align:center;' >" + value.rspofc_nm+ "</td>";
                       		 } else  {
		                        searchHtml += "  <td style='text-align:center;' >" + value.rspsblt_biznes+ "</td>";
                	         }
								searchHtml += "  <td style='text-align:center;' >" + value.rank + "</td>";
        	                	searchHtml += "  <td style='text-align:center;' >" + value.nm + "</td>";
	                        if(value.telno.length == 8) {
        	                        searchHtml += "  <td>군)"+ value.telno +"</td>";
	                        } else {
                        	        searchHtml += "  <td>"+ value.telno.replace("일반)","일)") +"</td>";
                	        }

        	                searchHtml += "<td style='text-align:center;' >" + value.mpno + "</td>";
	                        searchHtml += "<td class='star'>";
                        	searchHtml += "<label class='myCheckbox '>";
                       		searchHtml += "<a  href='javascript:void(0);'><img src='../images/operator/ico_favorite_off.png' id='"+mildsc+","+id+","+dept_cd+"' alt='즐겨찾기' ></a>";
                	        searchHtml += "</label>";
        	                searchHtml += "</td>";
	                        searchHtml += "</tr>";

			}
		});

		return searchHtml;
	};

	function paging(result) {
		search(result);
	};

	function setPaging(result) {

		var htmlStr = "";
		htmlStr += "<div class='pagination'>";
		htmlStr += "<a href='javascript:void(0)' onclick='paging("+ result.prevPageNo+ ");' class='list_btn'><img src='../images/operator/paging_btn_prev.png' alt='이전'/></a>";
		var pageSizeVal = result.endPageNo - result.startPageNo;

		for (var i = result.startPageNo; i <= result.endPageNo; i++) {
			if (i == result.pageNo) {
				htmlStr += "<a href='javascript:void(0)' onclick='paging(" + i + ");' class='list_btn'><b>" + i + "</b></a>";
			} else {
				htmlStr += "<a href='javascript:void(0)' onclick='paging(" + i + ");' class='list_btn'>" + i + "</a>";
			}
		}
		htmlStr += "<a href='javascript:void(0)' onclick='paging("+ result.nextPageNo+ ");' class='list_btn'><img src='../images/operator/paging_btn_next.png' alt='다음'/></a>";
		htmlStr += "</div>";
		$(".tbl_bottom").html(htmlStr);
	};

	$(document).on("click", "#searchTr", function() {

		var tr = $(this);
		var td = tr.children();

		var mildsc = td.eq(0).text();
		var deptNm = td.eq(1).text();
		var rank = td.eq(2).text();
		var fullNm = td.eq(3).text();
		var telno = td.eq(6).text();
		if(td.eq(4).text() == "") {
			var nm = td.eq(5).text();
		} else {
			var nm = td.eq(4).text();
		}
		

		$("input[id=outNm]").val(nm);
		$("input[id=outTelno]").val(telno);
		$("input[id=outDeptNm]").val(deptNm);

		$("input[id=outMildsc]").val(mildsc);
		$("input[id=outFullDeptNm]").val(fullNm);

	});

	$(document).on("mouseenter", "#searchTr", function() {
		$(this).css("background-color", "#f4f4f4");
		$(this).children("td").css("cursor", "pointer");

	});

	$(document).on("mouseleave", "#searchTr", function() {
		$(this).css("background-color", "white");
	});

	$(document).on("click", ".myCheckbox img", function() {
		var src = $(this).attr("src");

		var val = $(this).attr("id");

		if (src.substring(19) == "ico_favorite_off.png") {
			$(this).attr("src", "../images/operator/ico_favorite_on.png");
			var data = val.split(",");

			var mildsc = data[0];
			var id = data[1];
			var dept_cd = data[2];

			$.ajax({
				url : "/intra/insertBookmark.do",
				type : "post",
				dataType : 'json',
				data : {
					"bookmarkMildsc" : mildsc,
					"bookmarkId" : id,
					"bookmarkDeptCd" : dept_cd
				},
				success : function(data) {
					//console.log(data);
					//myPageAjax();
					if(data.result === 1) {
						myPageAjax();
					}else if(data.result === "200") {
						alert("등록되어있습니다.");
					}
				}
			})

		} else if (src.substring(19) == "ico_favorite_on.png") {
			$(this).attr("src", "../images/operator/ico_favorite_off.png");

		}

	});

// range check box
function checkRange(num){
	if($("input[name=range]").is(":checked")){
		var length = $("input[name=range]").length;
		var tmp = "";
		for(var i=0; i < length; i++){
			var anchor = $("input[name=range]").eq(i);
			var relAttribute = anchor.attr("rel");
			if(relAttribute != num){
				anchor.prop("checked", false);
			}
		}
	}else{
		$("input[name=range]").eq(0).prop("checked", true);
	}
}

//공지사항
function noticeDetail(seq) {
	layer_open('layer2','2');
	//alert(seq);
	var frm =  document.form1;
	frm.seq.value = seq;
	frm.target = "list"
	frm.action = "/intra/intraNoticeDetail.do";
	frm.submit();
}
 

function onListPage(pageNm) {
	//var frm = document.form1;
	//frm.currentPage.value = page;
	//frm.action = "/intra/intraNoticeList.do";
	//frm.submit();
	$.ajax({
		url : "/intra/intraNoticeListAjax.do",
		type : "post",
		dataType : 'json',
		data : {
			"setPageNum" : pageNm,
		},
		success : function(data) {
			
			$("#noticeBody").html(noticeAjax(data));
			noticePaging(data.paginationInfoAjax);
		}

	});
	
};

function noticeAjax(result) {
	var makeHtml = "";
	$.each(result.list,function(i, value) {
		makeHtml += "<tr>";
		makeHtml += "<td class='center'>"+value.rnum+"</td>";
		makeHtml += "<td><a id='seq'  href='#' onclick=noticeDetail('"+value.seq+"') >"+value.title+"</a></td>";
		makeHtml += "<td class='c_left' >관리자</td>";
		makeHtml += "<td>"+value.regDt+"</td>";
		//makeHtml += "<td><c:out value='${data.cnt}'/></td>";
		makeHtml += "</tr>";
	
	})
	return makeHtml;
}

function noticePagingCk(result) {
	onListPage(result);
}


function noticePaging(result){
	var htmlStr = "";
	htmlStr += "<div class='paginationNOtiec'>";
	htmlStr += "<a href='javascript:void(0)' onclick='noticePagingCk("+ result.prevPageNo+ ");' class='list_btn'><img src='../images/operator/paging_btn_prev.png' alt='이전'/></a>";
	var pageSizeVal = result.endPageNo - result.startPageNo;

	for (var i = result.startPageNo; i <= result.endPageNo; i++) {
		if (i == result.pageNo) {
			htmlStr += "<a href='javascript:void(0)' onclick='noticePagingCk(" + i + ");' class='list_btn'><b>" + i + "</b></a>";
		} else {
			htmlStr += "<a href='javascript:void(0)' onclick='noticePagingCk(" + i + ");' class='list_btn'>" + i + "</a>";
		}
	}
	htmlStr += "<a href='javascript:void(0)' onclick='noticePagingCk("+ result.nextPageNo+ ");' class='list_btn'><img src='../images/operator/paging_btn_next.png' alt='다음'/></a>";
	htmlStr += "</div>";
	$(".noticePaging").html(htmlStr);
}


//마이페이지

function myPageAjax(pageNm) {
	
		$.ajax({
			url : "/intra/myPageAjax.do",
			type : "post",
			dataType : 'json',
			data : {
				"setPageNum" : pageNm,
			},
			success : function(data) {
				$("#myPageBody").html(makeMyPage(data));
				myPaging(data.myPaginationInfo);
			}

		});
	
}


function makeMyPage(result) {
	var makeHtml = "";
	$.each(result.list,function(i, value) {
           var fullDeptNm = value.bookmarkFullDeptNm.split(" ");
	   var last = fullDeptNm.length -1;	

	     makeHtml += " <tr>";
	  /* makeHtml += " 	<td>업무</td>"; */
	     makeHtml += " <td>"+fullDeptNm[1]+" " + fullDeptNm[last] +"</td>";
	    /* if(value.bookmarkUserRspofcNm == "" || value.bookmarkUserRspofcNm == null) {
	    	 makeHtml += " <td>"+value.bookmarkUserRspsbltBiznes+"</td>";
	     } else {
		     makeHtml += " <td>"+value.bookmarkUserRspofcNm+"</td>";
	     }*/
	     makeHtml += " 	<td>"+value.bookmarkUserRank+"</td>";
	     makeHtml += " 	 <td>"+value.bookmarkUserNm+"</td>";
	     makeHtml += " 	<td style='text-align: left;' >"+value.bookmarkUserTelno+"</td>";
	     makeHtml += " 	<td>"+value.bookmarkUserMpno+"</td>";
	     makeHtml += " 	<td><a href='#'target='_self' class='btn' onclick='deleteBookMark("+ value.seq+ ");'>삭제</a></td>";
	     makeHtml += " </tr>";
	})
	
	return makeHtml;
};

function myPagingCk(result) {
	myPageAjax(result);
}


function myPaging(result){
	var htmlStr = "";
	htmlStr += "<div class='paginationMy'>";
	htmlStr += "<a href='javascript:void(0)' onclick='myPagingCk("+ result.prevPageNo+ ");' class='list_btn'><img src='../images/operator/paging_btn_prev.png' alt='이전'/></a>";
	var pageSizeVal = result.endPageNo - result.startPageNo;

	for (var i = result.startPageNo; i <= result.endPageNo; i++) {
		if (i == result.pageNo) {
			htmlStr += "<a href='javascript:void(0)' onclick='myPagingCk(" + i + ");' class='list_btn'><b>" + i + "</b></a>";
		} else {
			htmlStr += "<a href='javascript:void(0)' onclick='myPagingCk(" + i + ");' class='list_btn'>" + i + "</a>";
		}
	}
	htmlStr += "<a href='javascript:void(0)' onclick='myPagingCk("+ result.nextPageNo+ ");' class='list_btn'><img src='../images/operator/paging_btn_next.png' alt='다음'/></a>";
	htmlStr += "</div>";
	$(".myPaging").html(htmlStr);
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
				if(data.result == 1) {
					myPageAjax("0")
				}
			}

		});
		
		/* 
		frm.seq.value = seq;
		frm.target = "myIframe";
		frm.action = "/intra/deleteBookMark.do";
		frm.submit(); */
	}
		//setInterval(myPageAjax("0"),3000);
		
		//window.location.reload();
		
}
$(document).on("click","#belong", function() {
	var tab = $(this).val();
	if(tab == "tab-1") {
		$("#tab-1").show();
		$("#tab-2").hide();
		$("#tab-3").hide();
		$("#tab-4").hide();
		
	} else if(tab == "tab-2") {
		$("#tab-1").hide();
		$("#tab-2").show();
		$("#tab-3").hide();
		$("#tab-4").hide();
		
	} else if(tab == "tab-3") {
		$("#tab-1").hide();
		$("#tab-2").hide();
		$("#tab-3").show();
		$("#tab-4").hide();
		
	} else if(tab == "tab-4") {
		$("#tab-1").hide();
		$("#tab-2").hide();
		$("#tab-3").hide();
		$("#tab-4").show();
		
	}
	
	
});




</script>

<div id="wrapper">
	<ul class="con">
    	<li class="area1">
        
            <div class="tap_wrapper">		
                <ul class="tab" >
                    <li class="on">
                        <a href="#">사용자</a>
                        <div>
                        	<!-- Contents View -->
                            <div class="tap_contents1">
                            	<ul class="hd">
                                	<li>                                   	
                                    	<span class="checkbox">
	                                        <input type="checkbox" name="range" rel="1" value="all" onclick="checkRange(1);" checked="checked">전체
											<input type="checkbox" name="range" rel="2" id="A" value="A" onclick="checkRange(2);">국방부/합참
											<input type="checkbox" name="range" rel="2" id="B" value="B" onclick="checkRange(2);">육군
											<input type="checkbox" name="range" rel="2" id="C" value="C" onclick="checkRange(2);">해군/해병대
											<input type="checkbox" name="range" rel="2" id="D" value="D" onclick="checkRange(2);">공군
                                        </span>
                                        <p>
                                            <span class="a1">
                                                <select id="tar_range" class="select">
					           						<option value="tot">통합검색</option>
					           						<option value="full_dept_nm,full_dept_nm2">소속</option>
                                                    <option value="nm2">이름</option>
                                                    <option value="rspsblt_biznes,rspofc_nm">직책</option>
                                                    <option value="facility_nm2">시설물명</option>
						    						<option value="telno2">사무실번호</option>
						    						<option value="mpno2">휴대번호</option>
                                                </select>
                                            </span>
                                            <span class="a2">
                                                <input type="text" class="frm" id="query" name="query" value="" title="검색어를 입력하세요"
											onkeydown="JavaScript:Enter_Check();">
                                                <input type="button" onclick="javascript:search('1')" class="submit">
                                            </span>
                                        </p>
                                    </li>
                                </ul>
                                <ul class="list" >
                                	<li>
                                    	<table class="board_st3" cellpadding="0" cellspacing="0">
                                            <colgroup>
                                                <col width="">
                                                <col width="170">
                                                <col width="127">
                                                <col width="70">
                                                <col width="113">
                                                <col width="100">
											<!--	<col width="90"> -->
                                                <col width="70">
                                            </colgroup>
                                            <tr><th class="line" colspan="7"></th></tr>
                                            <thead>
	                                            <tr>
	                                                <th scope="col" name="" data="full_dept_nm">소 속</th>
													<th scope="col">직책</th>
	                                                <th scope="col" name="" data="rank">계급</th>
	                                                <th scope="col" name="" data="nm">성명</th>
	                                                <th scope="col" name="" data="telno">사무실번호</th>
	                                                <th scope="col">휴대번호</th>
													<!--	<th scope="col" >시설물명</th> -->
	                                                <th scope="col">즐겨<br>찾기</th>
	                                            </tr>
	                                           
                                         	</thead>
                                            
                                            <tbody id="searchTbody">
											</tbody>
                                          </table>
                                    </li>
                                </ul>

                            </div>
                            <!--// Contents View -->
                        </div>
                    </li>
                    <li>
                        <a href="#">조직</a>
                        <div>
                        	<!-- Contents View -->
                            <div class="tap_contents2">
								<ul class="hd">
										<li class="ra">
											<span class="radio">
												<!-- <input type="radio" name="belong" value="all"> 전체 -->
												<input type="radio" name="belong" id="belong" value="tab-1" checked > 국방부/합참
												<input type="radio" name="belong" id="belong" value="tab-2"> 육군
												<input type="radio" name="belong" id="belong" value="tab-3"> 해군/해병대
												<input type="radio" name="belong" id="belong" value="tab-4"> 공군
											</span>
										</li>
									</ul>
                                <div id="tab-1" class="tab-content03 current">
									<!--국방부-->
									<div id="treeA"></div>
								</div>
								<div id="tab-2" class="tab-content03">
									<!--육군-->
									<div id="treeB"></div>
								</div>
								<div id="tab-3" class="tab-content03">
									<!--해군-->
									<div id="treeC"></div>
								</div>
								<div id="tab-4" class="tab-content03">
									<!--공군-->
									<div id="treeD"></div>
								</div>
                            </div>
                            <!--// Contents View -->
                        </div>
                    </li>
                </ul>
        	</div>
        
        </li>
        
        <li class="area2">
            <div class="contents">
            	<ul style="height:422px;">
                	<li class="title"><span class="icon_title"></span>공지사항</li>
					<li class="more"><a href="#" onclick="layer_open('layer1','1');return false;">더보기</a><span class="icon_plus"></span></li>                  
                    <li class="board" style="height:344px;">
                    <form id="form1" name="form1" method="POST" action="#" class="search-box_ad">
						<input type="hidden" id="seq" name="seq" value="" />
					</form>
                    
                    	<table class="board_st1" cellpadding="0" cellspacing="0">
                        	<colgroup>
                            	<col width="8%">
                                <col width="59%">
                                <col width="15%">
                                <col width="18%" style="min-width:78px;">
                            </colgroup>
                            <tr><th class="line" colspan="4"></th></tr>
                            <tr>
                            	<th>번호</th>
                                <th>제목</th>
                                <th>작성자</th>
                                <th>등록일</th>
                            </tr>
                            
                            <tbody id="noticeBody">
                            <c:if test="${fn:length(list) == 0}">
									<tr>
					                	<td colspan="13">
					                		NO SEARCH DATA
										</td>
									</tr>
							</c:if>
	                        	<!-- <tr>
	                            	<td>10</td>
	                                <td><a href="#" onclick="layer_open('layer2','2');return false;">국방전화번호 통합검색체계</a></td>
	                                <td>서흥권</td>
	                                <td>2018-06-24</td>
	                            </tr> -->
                            </tbody>
                        </table>
                    </li>
                     <li class="paging noticePaging">
		             </li>
                </ul>
                <ul class="tempty" >
                	<li class="title"><span class="icon_title"></span>즐겨찾기</li>
					<li class="more"><a href="/intra/myPage.do" > 더보기<span class="icon_plus"></span></a></li>
                    <li class="board" style="height:309px; overflow: auto;">
                     <form id="form2" name="form2" method="POST" action="#" class="search-box_ad">
						<iframe name="myIframe" width="0" height="0" frameborder="0"></iframe> 
						<input type="hidden" id="seq" name="seq" value="" />
					</form>
                    	<table class="board_st2"  cellpadding="0" cellspacing="0">
						     <colgroup>
                            	<!-- <col width="15%"> -->
                                <col width="26%">
                              <!--  <col width="14%"> -->
				<col width="10%">
				<col width="10%">
				<col width="16%">
				<col width="15%">
                                <col width="11%" style="min-width:60px;">
                            </colgroup>
                        	<tr><th class="line" colspan="6"></th></tr>
                            <tr>
                            	<!-- <th>그룹</th> -->
                                <th>소 속</th>
                               <!--  <th>직책</th> -->
                                <th>계급</th>
                                <th>성명</th>
                                <th>사무실번호</th>
                                <th>휴대폰번호</th>
                                <th>설정</th>
                            </tr>
                        	<tbody id="myPageBody">
							</tbody>
                        </table>
                    </li>
                        <li class="paging myPaging">
		                </li>
                </ul>
			</div>

        </li>
    </ul>
<!-- 조직도상세 팝업 -->

<div class="layer3 layer">
	<div class="bg bg_layer3"></div>
	<div id="layer3" class="pop-layer layer3" style="width:960px; height:760px;">
		<div class="pop-container">
		    <div class="organTitle"><span class="icon_title"></span>조직도 상세<a href="#" class="cbtn btnClose"></a></div>
			
		    <div class="organList">
              <ul>
                	    <li class="board" style="height:540px; overflow:auto;">
                    	<table class="board_st6" cellpadding="0" cellspacing="0">
                        	<colgroup>
                            	<col width="9%">
							<!--	<col width="15%"> -->
								<col width="19%">
								<col width="11%">
                                <col width="10%">
                                <col width="17%">
                                <col width="19%">
                            </colgroup>
                            <thead id="thPop">
                            <tr><th class="line" colspan="6"></th></tr>
	                            <tr>
								    <th>소 속</th>
	                               <!--  <th>부서</th> -->
	                                <th>전화번호</th>
									<th>계급</th>
									<th>성명</th>
									<th>직책</th>
									<th>휴대폰번호</th>
	                            </tr>
                            </thead>
                            <tbody id="tPop">
			</tbody>
                        </table>
                    </li>
                    
                    <li class="paging">
                    <div class="tbl_bottom" id="paging"></div>
                    </li>
					<p class="btn_area">
					    <a href="#" class="btn_notice_st2 cbtn">닫기</a>
                    </p>
                </ul>
			</div>
       </div>
	</div>
</div>
<!-- 조직도상세 팝업 end -->


<!-- 공지사항 내용 팝업 -->
<div class="layer2 layer">
	<div class="bg bg_layer2"></div>
	<div id="layer2" class="pop-layer layer2">
		<div class="pop-container">
		    <div class="noticeTitle"><span class="icon_title"></span>공지사항<a href="#" class="cbtn btnClose"></a></div>
			<iframe src="#" style="width:700px; height:457px;" name="list" width="98%"  frameborder="0" scrolling="no" ></iframe>
			

</div>
