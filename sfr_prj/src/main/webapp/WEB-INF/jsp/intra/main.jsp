<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ include file="/WEB-INF/jsp/layout/include/incHeader.jspf" %>
<link rel="stylesheet" type="text/css" href="../css/common.css" />
<link rel="stylesheet" type="text/css" href="../css/tabs.css" />

<!-- <link rel="stylesheet" type="text/css"	href="../jsTree/jstree.3.3.5//dist/themes/default/style.min.css" /> -->
<link rel="stylesheet" type="text/css"	href="../jsTree/intraTree/dist/themes/default/style.min.css" /> 
<link rel="stylesheet" type="text/css"	href="../jqueryui/jquery-ui.css" />
<link rel="stylesheet" type="text/css"	href="../css/17/scroll.css" />

<script type="text/javascript"	src="../jsTree/jstree.3.3.5/jquery-1.12.1.js"></script>

<script type="text/javascript" src="../js/tabs.js"></script>
<script type="text/javascript"	src="../jsTree/intraTree/dist/jstree.min.js"></script>
<script type="text/javascript"	src="../jqueryui/jquery-ui.js"></script>

<script type="text/javascript" src="/MaWebDRM/MaWebDRM_Common.js"></script>
<script type="text/javascript" src="/MaWebDRM/MaWebDRM.js"></script>


<script type="text/javascript">
	var mildsc = "";
	var id = "";
	var dept_cd = "";
	var nodeId = "";
	
	var ckMildsc = "";
	
	var t1 = "";
	var t2 = "";
	
	var p1 = "";
	var p2 = "";
	
	var nw = "";
	var JsonArrayA = new Array();
	var JsonArrayB = new Array();
	var JsonArrayC = new Array();
	var JsonArrayD = new Array();

	
	//사용자검색 즐겨찾기 클릭할때 넘겨주는 체크박스
	var objChkbox = [];
	
	//즐겨찾기 그룹값 리턴 및 저장
	function gChildEvent(gGroupCd) {
    //alert('pGroupCd : '+gGroupCd);
    
    if(!objChkbox.prevAll('input[type="checkbox"]').is(":checked")) {
        objChkbox.prevAll('input[type="checkbox"]').attr('checked', "checked");
      } else {
        objChkbox.prevAll('input[type="checkbox"]').removeAttr('checked');
      }
      
     // console.log($(this).prevAll('input[type="checkbox"]').is(":checked"));
    if(objChkbox.prevAll('input[type="checkbox"]').is(':checked')) {
      var val = objChkbox.prevAll('input[type="checkbox"]').attr("id");
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
          "bookmarkDeptCd" : dept_cd,
          "bookmarkGroupId" : gGroupCd != "" ? gGroupCd : "" 
        },
        success : function(data) {
          if(data.result === 1) {
            myPageAjax();
          }else if(data.result === "200") {
            alert("등록되어있습니다.");
          }
        }
      });
    }    
  }	
	
	$(document).ready(function() {
		checkedALL();
		scroll();
			//setLogoutTimer("intra");
		$('#jstree').jstree();
        // 7 bind to events triggered on the tree
        $('#jstree').on("changed.jstree", function (e, data) {
            /* console.log(data.selected);
            console.log(data);
            console.log(e); */
        });
        // 8 interact with the tree - either way is OK
        $('button').on('click', function () {
          $('#jstree').jstree(true).select_node('child_node_1');
          $('#jstree').jstree('select_node', 'child_node_1');
          $.jstree.reference('#jstree').select_node('child_node_1');
        });
        
        $("#ALL").on("click", function(){
            //클릭되었으면
            var check = $("#ALL").prop("checked");
        	$("input[name=range]").prop("checked", check);
        })
        
        $(document).on('click', '.wrap_checkbox input[type="checkbox"]',function(){
        	//var t = $(".wrap_checkbox input[type='checkbox']").length;
        	var t =$(".wrap_checkbox input[type='checkbox']:checked").length;
        	if($(".wrap_checkbox input[type='checkbox']:checked").length == 1) {
        		if($('#ALL').is(':checked')) {
        			checkedALL();
        		}
        	}
        });

        //$(".myCheckbox>input[type='checkbox']").on('click', function(){
        $(document).on('click','.myCheckbox span',function(){ 
			var facilityNm = $(this).attr("id");
			if(	facilityNm != null) {
				alert("시설물은 등록할수 없습니다.");
				    	
        	} else {
				
				objChkbox = $(this);

				//즐겨찾기 그룹 선택 팝업창 호출
				var x = (window.screen.width / 2) - (650 / 2);
				var y = (window.screen.height / 2) - (200 / 2);
				
				var popType = "I";
				
				window.open("./bkmkSelectGroupPopup.do?popType="+popType+"", "즐겨찾기"
					  , "location=no,scrollbars=no,resizable=no,top="+y+",left="+x+
					  ",width=650,height=200, screenX="+x+", screenY="+y+"");    
			}
        	
/* 
  아래 저장하는 내용은 다음 함수로 따로 분리함. gChildEvent(gGroupCd)         	
*/		
/*
		
            //클릭되었으면
            //console.log($(this).prevAll('input[type="checkbox"]').attr('checkbox', true));
            
            if(!$(this).prevAll('input[type="checkbox"]').is(":checked")) {
            	//alert('1');
            	$(this).css("background", "url('../../images/intra_new/icon_favorite2.png')");
		$(this).prevAll('input[type="checkbox"]').attr('checked', "checked");
            } else {
            	//alert('2');
            	$(this).css("background", "url('../../images/intra_new/icon_favorite1.png')");
            	$(this).prevAll('input[type="checkbox"]').removeAttr('checked');
            }
           // console.log($(this).prevAll('input[type="checkbox"]').is(":checked"));
        	if($(this).prevAll('input[type="checkbox"]').is(':checked')) {
        		var val = $(this).prevAll('input[type="checkbox"]').attr("id");
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
    					if(data.result === 1) {
    						myPageAjax();
    					}else if(data.result === "200") {
    						alert("등록되어있습니다.");
    					}
    				}
    			});
        	}
 */			
			
        });
        
        
        
        /* $("input:checkbox").on('click', function() { 
        	if ( $(this).prop('checked') ) { 
        		var val = $(this).attr("id");
        		var data = val.split(",");

    			var mildsc = data[0];
    			var id = data[1];
    			var dept_cd = data[2];
    			
    			console.log(mildsc);
    			console.log(id);
    			console.log(dept_cd);
    			
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
    					console.log(data);
    					if(data.result === 1) {
    						myPageAjax();
    					}else if(data.result === "200") {
    						alert("등록되어있습니다.");
    					}
    				}
    			})
        	} else {
        		// 체크 해제
        	} 
        }); */

        
        //$('#tableContainer').fixTableHeader();
        //$('#tableContainer2').fixTableHeader();

        $('.tab-toggle').click(function() {
            $('.section').each(function() {
                $(this).addClass(" hidden");
            })

            $('#left-' + $(this).attr('data-target') + '').removeClass("hidden");
            $('#right-' + $(this).attr('data-target') + '').removeClass("hidden");

            
        });

        $('.tab-toggle').click(function() {
            $('.section').each(function() {
                $(this).addClass(" hidden");
            })

            $('#left-' + $(this).attr('data-target') + '').removeClass("hidden");
            $('#right-' + $(this).attr('data-target') + '').removeClass("hidden");
        });
		
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
				
				
 					//treeInit("0",mildsc,nodeId);
 					
 					var w = window.screen.width;
 					var h = window.screen.height;
 					
 					var x = (w / 2) - (850 / 2);
 					var y = (h / 2) - (700 / 2);
 					
 				nw =	window.open('./onpeOrganization.do?page='+0+'&mildsc='+mildsc+'&nodeId='+nodeId+'', 'organization'
 							, "location=no,scrollbars=no,resizable=no,top="+y+",left="+x+",width=850,height=700, screenX="+x+", screenY="+y+"");
				nw.focus();
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
				
				//treeInit("0",mildsc,nodeId);
				 var w = window.screen.width;
				var h = window.screen.height;
					
				var x = (w / 2) - (850 / 2);
				var y = (h / 2) - (700 / 2);
					
			nw =	window.open('./onpeOrganization.do?page='+0+'&mildsc='+mildsc+'&nodeId='+nodeId+'', 'organization'
				, "location=no,scrollbars=no,resizable=no,top="+y+",left="+x+",width=850,height=700, screenX="+x+", screenY="+y+"");
			nw.focus();
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
					
						//treeInit("0",mildsc,nodeId);
						 
						var w = window.screen.width;
		 				var h = window.screen.height;
		 					
		 				var x = (w / 2) - (850 / 2);
		 				var y = (h / 2) - (700 / 2);
		 					
		 			nw = 	window.open('./onpeOrganization.do?page='+0+'&mildsc='+mildsc+'&nodeId='+nodeId+'', 'organization'
		 				, "location=no,scrollbars=no,resizable=no,top="+y+",left="+x+",width=850,height=700, screenX="+x+", screenY="+y+"");
			
						
					nw.focus();
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
				
				//treeInit("0",mildsc,nodeId);
				
				var w = window.screen.width;
				var h = window.screen.height;
					
				var x = (w / 2) - (850 / 2);
				var y = (h / 2) - (700 / 2);
					
			nw =	window.open('./onpeOrganization.do?page='+0+'&mildsc='+mildsc+'&nodeId='+nodeId+'', 'organization'
				, "location=no,scrollbars=no,resizable=no,top="+y+",left="+x+",width=850,height=700, screenX="+x+", screenY="+y+"");
				
			nw.focus(); 
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
		//	layer_open('layer3','3');
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
		var nm = [];
		if(result.list.length != 0) {
			
			$.each(result.list, function(i, value) {
				var fullDeptNm = value.fullDeptNm.split(" ");
				var last = fullDeptNm.length -1;
					html += "	<tr id='treeTr'>";
					html += "		<td>"+ fullDeptNm[1] +" "+fullDeptNm[last]+"</td>";
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
			t1 = "";
			t1 = html;
			
			//$("#tPop").show();
			//$("#datatext").hide();
			//$("#tPop").html(html);
		    //$("#thPop").show();
		} else {
				//console.log(result.list.length);
			//$("#thPop").hide();
			//$("#tPop").hide();
			//$("#datatext").show();
			html = "<p>조직정보가 없습니다.</p>";
			t1 = "";
			t1 = html;
			//$("#datatext").html(html);
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
		//htmlStr += "<div class='pagination'>";
		htmlStr += "<a href='javascript:void(0)' id='"+ result.paging.prevPageNo+ ","+mildsc +","+nodeId+"' class='num'><img src='../images/operator/paging_btn_prev.png' alt='이전'/></a>";
		var pageSizeVal = result.paging.endPageNo - result.paging.startPageNo;

		for (var i = result.paging.startPageNo; i <= result.paging.endPageNo; i++) {
			if (i == result.paging.pageNo) {
				htmlStr += "<a href='javascript:void(0)' id='" + i + ","+mildsc +","+nodeId+"' class='num'><b>" + i + "</b></a>";
			} else {
				htmlStr += "<a href='javascript:void(0)' id='" + i + ","+mildsc +","+nodeId+"' class='num'>" + i + "</a>";
			}
		}
		//htmlStr += "<a href='javascript:void(0)' id='"+ result.paging.nextPageNo+ ","+mildsc +","+nodeId+"' class='num'><img src='../images/operator/paging_btn_next.png' alt='다음'/></a>";
		htmlStr += "<a href='javascript:void(0)' onclick='noticePagingCk("+ result.nextPageNo+ ");' class='btn_next'>></a>";
		//htmlStr += "</div>";
		
		p1 = htmlStr;
		
		//$("#paging").html(htmlStr);
	}

	function setTreeFacilltyPaging(result,mildsc,nodeId){
		var htmlStr = "";
		htmlStr += "<div class='pagination2'>";
		htmlStr += "<a href='javascript:void(0)' id='"+ result.paging.prevPageNo+ ","+mildsc +","+nodeId+"' class='num'><img src='../images/operator/paging_btn_prev.png' alt='이전'/></a>";
		var pageSizeVal = result.paging.endPageNo - result.paging.startPageNo;

		for (var i = result.paging.startPageNo; i <= result.paging.endPageNo; i++) {
			if (i == result.paging.pageNo) {
				htmlStr += "<a href='javascript:void(0)' id='" + i + ","+mildsc +","+nodeId+"' class='num'><b>" + i + "</b></a>";
			} else {
				htmlStr += "<a href='javascript:void(0)' id='" + i + ","+mildsc +","+nodeId+"' class='num'>" + i + "</a>";
			}
		}
		htmlStr += "<a href='javascript:void(0)' id='"+ result.paging.nextPageNo+ ","+mildsc +","+nodeId+"' class='num'><img src='../images/operator/paging_btn_next.png' alt='다음'/></a>";
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

	$(document).ready(function(){
		$("#query").keyup(function (key) {
			if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
				search();
			}
		});
	});	
	function search(pageNm) {
		//setLogoutTimer("intra");
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
			//$("#searchTbody").html(makeSearchString(result.data));
			//$(".searchTbody").html(makeSearchString(result.data));
			//scroll();
			//setPaging(result.paging);
			resultCnt(result);
			
			$(".searchTbody").html(makeSearchString(result.data));
			setPaging(result.paging);
		} else {
			//$("#searchTbody").html("검색어 결과가 없습니다.");
			//resultCnt(result);
			$('.searchTbody').html("<tr><th colspan='7'>검색 결과가 없습니다.</th></tr>");
			var htmlStr="";
			htmlStr += "<a href='javascript:void(0)' class='btn_prev'><</a>";
			htmlStr += "<a href='javascript:void(0)' class='num on'><b>1</b></a>";
			htmlStr += "<a href='javascript:void(0)' class='btn_next'>></a>";
			$('.tbl_bottom').html(htmlStr);
			
			//$('.tbl_bottom').chailed.remove();;
		}
	};
	
	function resultCnt(result) {
		if(result.data[0].temp != "") {
			rscnt = result.data[0].temp;
			rscntext = rscnt+"건이 검색되었습니다.";
		} else {
			rscntext = "";
		}
		//rscntext="<tr><td></td></tr>"
		$('#searchTbody').html("<tr><th colspan='7'>검색 결과가 없습니다.</th></tr>");
		$('#searchTbody').html(rscntext);
		$('#search_count').text(rscnt);

	};

	function makeSearchString(result) {
		var searchHtml = "";
		//console.log(result);
		var count = 0;
		$.each(result,function(i, value) {
			var mildsc = value.mildsc;
			var id = value.id;
			var dept_cd = value.dept_cd;
			
			var fullDeptNm = value.full_dept_nm.split(" ");
			var last = fullDeptNm.length - 1;
			
			searchHtml += "<tr id='searchTr'>";
			
			// 소속
			if(value.facility_nm != "") {
				searchHtml += "  <td>" + value.full_dept_nm + " <br/>/"+value.facility_nm+"</td>";
				//searchHtml += "  <td>" + fullDeptNm[0] +" "+fullDeptNm[last]+ " <br/>/"+value.dept_nm+"</td>";
			} else if(value.facility_nm == "") {
				searchHtml += "  <td>"+ value.full_dept_nm +"</td>";
			}
			
			// 직책
			if(value.mildsc == "A" ) {
				searchHtml += "	 <td>" + value.rspofc_nm+ "</td>";
			} else  {
				searchHtml += "  <td>" + value.rspsblt_biznes+ "</td>";
			}
			
			// 계급
			searchHtml += "  <td>" + value.rank + "</td>";

			// 성명
			searchHtml += "	 <td>" + value.nm + "</td>";
		//	searchHtml += "	 <td style='text-align:center;' >" + value.telno + "</td>";
		
			// 사무실번호
			if(value.telno.length == 8) {
				searchHtml += "	 <td class='txt_left'>군)"+ value.telno +"</td>";
			} else {
				var t = value.telno.replace("일반)","일)");
				t = t.replace(',', ',<br>')
				searchHtml += "	 <td class='txt_left'>"+ t +"</td>";
			}
			
			// 휴대폰번호
			searchHtml += "<td>" + value.mpno + "</td>";
		//	searchHtml += "  <td>" + value.facility_nm + "</td>";
		
			// 즐겨찾기
			searchHtml += "<td class='star'>";
			searchHtml += "		<label class='myCheckbox' >";
			
			if(value.facility_nm != "") {
				searchHtml += "<input type='checkbox' name='' hidden value='' onclick='reAlert();'/>";
			} else {
				searchHtml += "<input type='checkbox' name='' hidden value='' id='"+mildsc+","+id+","+dept_cd+"' />";
			}
			
			//searchHtml += "			<a  href='javascript:void(0);'><img src='../images/operator/ico_favorite_off.png' id='"+mildsc+","+id+","+dept_cd+"' alt='즐겨찾기' ></a>";
			if(value.facility_nm != "") {
				searchHtml += "		<span id='"+value.facility_nm+"'></span>";
			} else {
				searchHtml += "         <span></span>";
			}
			searchHtml += "		</label>";
			searchHtml += "</td>";
			
			searchHtml += "</tr>";
			count++;
		});
	//	$('#search_count').text(count);
		return searchHtml;
	};

	function reAlert() {
	
   	   alert("시설물은 등록되지 않습니다.");
	
         }		

	function paging(result) {
		search(result);
	};

	function setPaging(result) {

		var htmlStr = "";
		//htmlStr += "<div class='pagination'>";
		//htmlStr += "<a href='javascript:void(0)' onclick='paging("+ result.prevPageNo+ ");' class='num'><img src='../images/operator/paging_btn_prev.png' alt='이전'/></a>";
		htmlStr += "<a href='javascript:void(0)' onclick='paging("+ result.prevPageNo+ ");' class='btn_prev'><</a>";
		var pageSizeVal = result.endPageNo - result.startPageNo;

		for (var i = result.startPageNo; i <= result.endPageNo; i++) {
			if (i == result.pageNo) {
				htmlStr += "<a href='javascript:void(0)' onclick='paging(" + i + ");' class='num on'><b>" + i + "</b></a>";
			} else {
				htmlStr += "<a href='javascript:void(0)' onclick='paging(" + i + ");' class='num'>" + i + "</a>";
			}
		}
		//htmlStr += "<a href='javascript:void(0)' onclick='paging("+ result.nextPageNo+ ");' class='num'><img src='../images/operator/paging_btn_next.png' alt='다음'/></a>";
		//htmlStr += "</div>";
		htmlStr += "<a href='javascript:void(0)' onclick='paging("+ result.nextPageNo+ ");' class='btn_next'>></a>";
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

	/* $(document).on("click", ".myCheckbox img", function() {
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
					console.log(data);
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

	}); */

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
	//layer_open('layer2','2');
	//alert(seq);
	var frm =  document.form1;
	frm.seq.value = seq;
	//frm.target = "list"
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
		makeHtml += "<td>"+value.rnum+"</td>";
		makeHtml += "<td class='center'><a id='seq'  href='#' onclick=noticeDetail('"+value.seq+"') >"+value.title+"</a></td>";
		//if (value.atchCnt != 0) 
		//	makeHtml += "<td><img src='../images/admin/ico_attach.png' /></td>";
		//else 
		//	makeHtml += "<td></td>";
		makeHtml += "<td>관리자</td>";
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
	//htmlStr += "<div class='paginationNOtiec'>";
	htmlStr += "<a href='javascript:void(0)' onclick='noticePagingCk("+ result.prevPageNo+ ");' class='btn_prev'><</a>";
	var pageSizeVal = result.endPageNo - result.startPageNo;

	for (var i = result.startPageNo; i <= result.endPageNo; i++) {
		if (i == result.pageNo) {
			htmlStr += "<a href='javascript:void(0)' onclick='noticePagingCk(" + i + ");' class='num on'>" + i + "</a>";
		} else {
			htmlStr += "<a href='javascript:void(0)' onclick='noticePagingCk(" + i + ");' class='num'>" + i + "</a>";
		}
	}
	htmlStr += "<a href='javascript:void(0)' onclick='noticePagingCk("+ result.nextPageNo+ ");' class='btn_next'>></a>";
	//htmlStr += "</div>";
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
				$(".myPageBody").html(makeMyPage(data));
				//scroll();
				myPaging(data.myPaginationInfo);
				//$('#tableContainer2').fixTableHeader();
			}

		});
	
}


function makeMyPage(result) {
	var makeHtml = "";
	$.each(result.list,function(i, value) {
		
		var fullDeptNm = value.bookmarkFullDeptNm.split(" ");
		var last = fullDeptNm.length - 1;
		
		
		 makeHtml += " <tr>";
		 /* makeHtml += " 	<td>업무</td>"; */
	     makeHtml += " <td>"+ fullDeptNm[1] + " " + fullDeptNm[last] + "</td>";
	     /* if(value.bookmarkUserRspofcNm == "" || value.bookmarkUserRspofcNm == null) {
	    	 makeHtml += " <td>"+value.bookmarkUserRspsbltBiznes+"</td>";
	     } else {
		     makeHtml += " <td>"+value.bookmarkUserRspofcNm+"</td>";
	     } */
	     makeHtml += " 	<td>"+value.bookmarkUserRank+"</td>";
	     makeHtml += " 	 <td>"+value.bookmarkUserNm+"</td>";
	     
	     if(value.bookmarkUserTelno.length == 8) {
		makeHtml += "      <td class='txt_left'>군)"+value.bookmarkUserTelno+"</td>";
	     } else {
		var t =  value.bookmarkUserTelno.replace("일반)","일)");
		
	    	 t = t.replace(',', ',<br>');
		 makeHtml += "      <td class='txt_left'>"+t+"</td>";
	     }	
	     
	     makeHtml += " 	<td>"+value.bookmarkUserMpno+"</td>";
	     //makeHtml += " 	<td><a href='#'target='_self' class='btn' onclick='deleteBookMark("+ value.seq+ ");'>삭제</a></td>";
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
$(document).on("click","input[name='belong']", function() {
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


function checkedALL() {
	$("input[name=range]").prop('checked', true);
}

function scroll() {
	// 1번 스크롤
    var fauxTable1 = document.getElementById("t1");
    var mainTable = document.getElementById("main-table");
    var clonedElement1 = mainTable.cloneNode(true);
    clonedElement1.id = "";
    fauxTable1.appendChild(clonedElement1);

    // 2번 스크롤
    var fauxTable2 = document.getElementById("t5");
    var mainTable2 = document.getElementById("main-table5");
    var clonedElement2 = mainTable2.cloneNode(true);
    clonedElement2.id = "";
    fauxTable2.appendChild(clonedElement2);
}

</script>

<div class="wrap">
   <!--왼쪽 영역-->  
   <div class="cont_left">
       <div class="tab">
           <ul>
               <li class="tablinks active" onclick="openTab(event, 'result_tab1')">사용자</li>
               <li class="tablinks" onclick="openTab(event, 'result_tab2')">조직</li>
           </ul>
        </div>

        <div id="result_tab1" class="tabcontent" style="display: block;">
            <div class="custom_basic">
                <div class="search">
					<div class="wrap_checkbox">
						<span class="checkbox">
                            <input type="checkbox" name="range" rel="1" value="all" onclick="checkRange(1);" id="ALL">
                            <label for="ALL">전체</label> 
                            <input type="checkbox"name="range" rel="2" id="A" value="A" onclick="checkRange(2);"> 
                            <label for="A">국방부/합참</label>
                            <input type="checkbox" name="range" rel="2" id="B" value="B" onclick="checkRange(2);"> 
                            <label for="B">육군</label>
                            <input type="checkbox" name="range" rel="2" id="C" value="C" onclick="checkRange(2);"> 
                            <label for="C">해군/해병대</label>
                            <input type="checkbox" name="range" rel="2" id="D" value="D" onclick="checkRange(2);">
                            <label for="D">공군</label>
                        </span>
					</div>
					<div class="wrap_search">
						<span class="a1">
                           <select id="tar_range" class="select">
                             <option value="tot">통합검색</option>
						     <option value="full_dept_nm,full_dept_nm2">소속</option>
	                                                    <option value="nm2">이름</option>
	                                                    <option value="rsp2">직책</option>
	                                                    <option value="facility_nm2">시설물명</option>
							    						<option value="telno2">사무실번호</option>
							    						<option value="mpno2">휴대번호</option>
                           </select>
                        </span>
						<span class="a2">
                           <input type="text" class="frm" name="query" id="query" style="ime-mode:active;" value="" title="검색어를 입력하세요">
                           <input type="button" class="submit" onclick="javascript:search('1')">
                           <input type="hidden" id="sortField" value="mildsc asc rsort asc rank">
                           <input type="hidden" id="sortOrder" value="asc">
                        </span>
					</div>  
					<div class="wrap_txt">
					총 <span id="search_count">0</span> 건 검색
					</div>
				</div> 
                <div id="right-fixedHeader" class="table-scroll">
                <div id="t1" class="scroll-wrap"></div>
                <div id="tableContainer" class="inner-wrap t2" style="height:480px; background: #fff;">
                    <table id="main-table" class="main-table customers_t">
                        <thead>
                            <tr>
                                <th style="width:23%;">소속</th>
                                <th style="width:14%;">직책</th>
                                <th style="width:15%;">계급</th>
                                <th style="width:10%;">성명</th>
                                <th style="width:15%;">사무실번호</th>
                                <th style="width:13%;">휴대번호</th>
                                <th style="width:10%; min-width:80px;">즐겨찾기</th>
                            </tr>
                        </thead>
                        <tbody id="searchTbody" class="searchTbody">
                            
                        </tbody>
                    </table>
		<div class="tbl_bottom paging">
		</div>	
                </div>
                </div>        
            </div>
       </div>
       <div id="result_tab2" class="tabcontent" style="min-height:680px;">
          <div class="org">
			  <span class="radio">
			  	<!-- <input type="radio" name="belong" value="all" id="radio_all"> 
                <label for="radio_all">전체</label> -->
				<input type="radio" name="belong" value="tab-1" id="national" checked="checked" > 
                <label for="national">국방부/합참</label>
				<input type="radio" name="belong" value="tab-2" id="army">
				<label for="army">육군</label>
				<input type="radio" name="belong" value="tab-3" id="navy">
				<label for="navy">해군/해병대</label>
				<input type="radio" name="belong" value="tab-4" id="airforce">
				<label for="airforce">공군</label>
			  </span>
		  </div>
		   <!---->
          <div id="tab-1" class="w_jstree">
			  <p><img src="../images/intra_new/i_jstree.png"></p>
			  <div id="treeA" >
				<!-- in this example the tree is populated from inline HTML -->
				<!--// -->
			  </div>
		   </div>
		   
		   <div id="tab-2" class="w_jstree">
			  <p><img src="../images/intra_new/i_jstree.png"></p>
			  <div id="treeB" >
				<!-- in this example the tree is populated from inline HTML -->
				<!--// -->
			  </div>
		   </div>
		   
		   <div id="tab-3" class="w_jstree">
			  <p><img src="../images/intra_new/i_jstree.png"></p>
			  <div id="treeC" >
				<!-- in this example the tree is populated from inline HTML -->
				<!--// -->
			  </div>
		   </div>
		   
		   <div id="tab-4" class="w_jstree">
			  <p><img src="../images/intra_new/i_jstree.png"></p>
			  <div id="treeD" >
				<!-- in this example the tree is populated from inline HTML -->
				<!--// -->
			  </div>
		   </div>
       </div>
   </div>
   <!--// 왼쪽 영역-->
   
   <!--오른쪽 영역-->
   <div class="cont_right">
       <!--공지사항-->
       <div class="noti">
           <div class="warp_rtab">
               <div class="rtab">공지사항 </div>
               <span><a href="#" onclick="notice();"><img src="../images/intra_new/icon_more.png" alt="더보기"></a></span>
           </div>
           <form id="form1" name="form1" method="POST" action="#" class="search-box_ad">
				<input type="hidden" id="seq" name="seq" value="" />
			</form>
           
           <div class="wrap_customers">
              <table class="customers">
              	<colgroup>
              		<col width="10%">
              		<col width="52%">
              	<!--	<col width="17%">	-->
			<col width="17%">
              		<col width="21%">
              	</colgroup>
              	<thead>
	                  <tr>
	                      <th>번호</th>
	                      <th>제목</th>
			<!--  <th>파일첨부</th>	-->
	                      <th>작성자</th>
	                      <th>등록일</th>
	                  </tr>
                  </thead>
                  <tbody id="noticeBody">
                  	<c:if test="${fn:length(list) == 0}">
				<tr><td colspan="13">NO SEARCH DATA</td></tr>
			</c:if>
                  </tbody>
               </table> 
           </div> 
		   <div class="paging noticePaging">

		   </div>  
       </div>
       <!--// 공지사항-->
       <p></p>
	   <!-- 즐겨찾기-->
       <div class="bmark">
	   	   <div class="warp_rtab">
               <div class="rtab">즐겨찾기</div>
               <span><a href="/intra/myPage.do"><img src="../images/intra_new/icon_more.png" alt="더보기"></a></span>
           </div>
           <div class="wrap_contb">
                <div id="right-fixedHeader" class="table-scroll">
                <div id="t5" class="scroll-wrap"></div>
                <div id="tableContainer2" class="inner-wrap t2" style="background: #fff;">
                    <table id="main-table5" class="main-table">
                        <thead>
                            <tr>
                                <th style="width:30%;">소속</th>
                                <th style="width:17%;">계급</th>
                                <th style="width:13%;">성명</th>
                                <th style="width:20%;">사무실번호</th>
								<th style="width:20%;">휴대폰번호</th>
                            </tr>
                        </thead>
                        <tbody id="myPageBody" class="myPageBody">
                        </tbody>
                    </table>
                    <!-- <div class="paging myPaging" style="border: none;"></div> -->
                </div>
                 
                </div>
           </div>
       </div>
       <!--// 즐겨찾기-->	   
   </div>
   <!--오른쪽 영역-->
</div>
<!--// ***** wrap *****--> 

<script type="text/javascript">

	function scroll() {
		// 1번 스크롤
	    var fauxTable1 = document.getElementById("t1");
	    var mainTable = document.getElementById("main-table");
	    var clonedElement1 = mainTable.cloneNode(true);
	    clonedElement1.id = "";
	    fauxTable1.appendChild(clonedElement1);
	
	    // 2번 스크롤
	    var fauxTable2 = document.getElementById("t5");
	    var mainTable2 = document.getElementById("main-table5");
	    var clonedElement2 = mainTable2.cloneNode(true);
	    clonedElement2.id = "";
	    fauxTable2.appendChild(clonedElement2);
	}	
</script>

