<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ include file="/WEB-INF/jsp/layout/include/incHeader.jspf" %>
	<link rel="stylesheet" type="text/css" href="../css/common.css" />  
	<link rel="stylesheet" type="text/css" href="../css/tabs.css"/>
    <link rel="stylesheet" type="text/css" media="screen" href="../jqgrid/css/ui.jqgrid.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="../jqueryui/jquery-ui.css" />
    
	
	<script type="text/javascript" src="../js/tabs.js"></script>
    <script type="text/javascript" src="../jqgrid/js/jquery.jqGrid.min.js" ></script> 
	  
	<script type="text/javascript">
	
		var inputFile = [];
		
		//팝업 테스트. 공지사항 제목에 걸려있음.
		function popup_test(){ //경로, 가로, 세로, 아이디
			gfn_popup("/operator/testpopup.do", "400", "400", "bpopupTest");
		};

		function layer_popup_test(){ //아이디, 경로, 파라미터, 가로
			openBpopup("bpopupTest", "/operator/testpopup.do", "", "400");
		};
		
		/* $(document).on("click", ".mr5", function() {
			location.href= "/admin/noticeList.do";
		}); */		
		
		function insertBoard() {
			
			var frm = document.form1;
			//var frm = $('#form1');
			
			var rMsg = validator();
	        
	        if(rMsg != "")
	        {
	          alert(rMsg);
	          return;
	        }
			
	        /* 
	        if($("#title").val() == "") {
	          alert("제목을 입력해주세요.");
	          $("#title").focus();
	          return;
	        }
	        
	        if($("#content").val() == "") {
	          alert("내용을 입력해주세요.");
	          $("#content").focus();
	          return;
	        }
	         */
	         
	        if(confirm("등록하시겠습니까?")) {
	    
	        frm.title.value = $("#title").val();
	        frm.content.value= $("#content").val();
	        frm.action = "/admin/noticeInsert.do";
	        frm.submit();
				
			}
			
		}
		
	    /* ======================================================================== */  	      

		//첨부파일 박스추가
		var fileBox_idx = 0;
 
		function addFileBox() {
		  if (fileBox_idx >= 2) {
		    alert("첨부파일은 최대 3개까지 가능합니다.");
		  } else {
		    var html = $("#fileadd tr").parent().html();
			  html = html.replace(/XXX/g, "" + ++fileBox_idx);
		    $("#fileInfos").append(html);
		  }
		}
	
		//첨부파일박스삭제
		function removeFileBox(i) {
		  var el = $("#form1 input[name=record_" + i + "]");
		  if (el.next().val() == "add") {
		    el.parent().parent().remove();

		    //fileBox_idx--;
		  } else {
		    el.next().val("remove");
		    el.parent().parent().hide();
		    
		    fileBox_idx--;
		  }
		}
	
		//파일박스 내용삭제
		function btnRmFileBoxClickEvent() {
		  inputFile[1] = inputFile[0].clone(true);
		  $("#files").replaceWith(inputFile[1]);
		}
	
		//입력검증
		function validator() {
		  var rMsg = "";
		  
      if($("#title").val() == "") 
    	  rMsg += "\n제목을 입력해주세요."; 
        
        
      if($("#content").val() == "") 
       	rMsg += "\n내용을 입력해주세요.";
            		  
		  
		  //파일 업로드 용량 체크
		  var nLimitSize = 20; //제한사이즈 MB
		  var formName = $("#form1 input[name=files]");
		  
		  for(var i=0; i<formName.length; i++){
		    if(formName[i].value !=""){
		      //파일용량 체크
		      var nRtn=fileCheck(formName[i] , nLimitSize);
		      if(nRtn>nLimitSize){ 
		        rMsg += "\n\n[" + (i+1) + "번 파일] : ("+nRtn+"MB) 첨부파일 사이즈는 "+nLimitSize+"MB 이내로 등록 가능합니다.";
		      }
		      
		      //파일 확장자 체크
		      if (fileExtnsCheck(formName[i]) == false)
		        rMsg += "\n\n[" + (i+1) + "번 파일] : 그림/한글/한셀/MS 오피스/TXT/PDF 파일만 업로드 하실 수 있습니다!";
		            
		    }
		  }
		  
		  return rMsg;
		}
		
		$(document).ready(function() {
			  //파일폼 복사
			  inputFile.push($("#files").clone());

			  //파일박스취소버튼 클릭이벤트 등록
		    $("#btnRmFilebox").bind("click", btnRmFileBoxClickEvent);
			

		});			
		
	</script>
   <!--contents_area-->
    <div id="content_a">
		<!--content_main-->
		<div class="content_main">
			<!--contents-->
			<div class="contents_a">
				<!--title-->
				<h3>공지사항 등록</h3>
				<!--//title-->
				<!--공지게시판 등록 게시판-->
				<div class="board_type_n mt40">
				<form id="form1" name="form1" method="POST" enctype="multipart/form-data" action="#" class="search-box_ad">	
					<table class="tba_type_board" border="1" cellspacing="0" summary="공지게시판 등록 게시판입니다.">
						<caption>공지게시판 등록 게시판</caption>
						<colgroup>
						<col width="15%">
						<col width="13%">
						<col width="10%">
						<col>
						<col width="10%">
						<col width="6%">
						<col width="6%">
						</colgroup>
							<tbody>
								<tr>
									<th scope="col">제목<em class="check">필수</em></th>
									<td colspan="6"><input type="text" id="title" name="title" class="w100p" title="제목" /></td>
								</tr>
								<tr>
									<th scope="col">내용<em class="check">필수</em></th>
									<td colspan="6"><textarea id="content" name="content" class="w100% h300"></textarea></td>
								</tr>
								<tr>
								  <th scope="col">첨부파일</th>
									<td colspan="6">
									  <table id="fileInfos" style="margin-left: 5px; margin-right: 6px;">
										<tr>
										  <td style="width: 100%; border:none;">
											<input type="hidden" name="record_XXX" value="" />
											<input type="hidden" name="action" value="add" />
											<input type="file" id="files" name="files" class="w100p" />
										  </td>
										  <td style="width: 100%; border:none;">
											<img src="../images/board/btn_cancel.png" id="btnRmFilebox" style="cursor: pointer; margin-top: 4px; margin-left: 4px;" alt="취소" />
										  </td>
										  <td style="width: 100%; text-align: right; border:none;">
											<img src="../images/board/btn_fileadd.png" onClick="addFileBox()" alt="파일추가" style="cursor: pointer"/>
										  </td>
										</tr>
									  </table>
									</td>												  
								</tr>
							</tbody>
					</table>
				</form>
				
					<!-- 첨부파일 -->
					<table id="fileadd" style="display:none">
					  <tr>
						<td style="width: 100%; border:none;">
						  <input type="hidden" name="record_XXX" value="" />
						  <!-- <input type="hidden" name="action" value="add" /> -->
						  <input type="file" name="files" class="w100p" />
						</td>
						<td style="width: 100%; border:none;">
						  <img src="../images/board/btn_cancel.png" onClick="removeFileBox(XXX)" style="cursor: pointer; margin-top: 4px; margin-left: 4px;" alt="취소" />
						</td>
						<td style="width: 100%; text-align: right; border:none;"></td>
					  </tr>
					</table><!-- "첨부파일" --> 					
				
				</div>
				<!--//공지게시판 등록 게시판-->
				
				<!--btn_area-->
				<div class="tbl_bottom">
					<div class="t_right">
						<button type="submit" name="btnAdd" id="btnAdd" class="btnComm grblue mr5" title="등록" onclick="insertBoard();">등록</button>
						<button type="button" name="btnCancle" id="btnCancle" class="btnComm gr_line" title="취소" onClick="history.back();">취소</button>
					</div>
				</div>
				<!--//btn_area-->
			</div>
			<!--//contents-->
			
			
		</div>
		<!--//content_main-->
    </div>
    <!--//contents_area-->
</div>

