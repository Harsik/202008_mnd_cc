<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/layout/include/incHeader.jspf"%>
<!-- <link rel="stylesheet" href="../css/intra/intra.css" /> -->
<link href="../../css/17/sub.css" rel="stylesheet" type="text/css" />
<!-- <link href="../../css/17/notice.css" rel="stylesheet" type="text/css" /> -->
<script>
$(document).ready(function() {
	$("#detailView").hide();
	
	//init();
	var pageURL = location.href;
	active(1);
	
	//첨부파일 리스트 조회
	var fAtch_Num = $("#fileAtch_Num").val();
  if ($("#fileAtch_Num").val() != "")
      selectFileAtchList(fAtch_Num);
});

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


function noticeDetail(seq) {
	var frm = document.form1;
	//frm.seq.value = seq;
	frm.action = "/intra/intraNoticeDetail.do";
	
	frm.submit();
}

function back(){
 	
	
}

/*
function viewClick() {
	$("#detailView").show();
	$("#view").hide();
};

function confirm() {
	$("#detailView").hide();
	$("#view").show();
}
 */

 function back() {
	 location.href = "/intra/intraNoticeList.do";
 }

 //첨부파일 박스추가
 var fileBox_idx = 0;
  
 function selectFileAtchList(fAtch_Num) {
     
     //alert($("#seq").val() + " / " + $("#title").val() + " / " + $("#content").val() + " / " + $("#fileAtch_Num").val());
             
     $.ajax({
         type : "post",
         dataType: "json",
         async : true,
         url : "/intra/noticeFileAtchListAjax.do",
         data : {"tbl_pk":fAtch_Num},
         success : function(data) {

             for(i=0; i<data.result.length; i++) {
                 var url = "http://" + location.host 
                 + "/intra/fileDownload.do?id=" 
                 + (data.result[i].flId);
                 
                 var tr = "<tr id='" + data.result[i].flId + "'>";
                 tr += "<td class='w100p' style='border:none;'>";
                 tr += "<input type='hidden' name='record_" +data.result[i].flId + "' value='' />";
                 tr += "<span><a href='" + url + "'>" + data.result[i].locFlNm + "</a></span></td>"; 
                 tr += "<td style='border:none;'>";
                 //tr += "<span>" + data.result[i].flKbSz + "</span>";
                 tr += "</td>";
                 tr += "</tr>";
                 
                 fileBox_idx++;
                 $("#fileInfos").parent().append(tr);
               }             

             if(fileBox_idx >= 3) {
               $("#files").prop("disabled", true);
               $("#btnRmFilebox").prop("disabled", true);
             }
         },
         error : function(data, status, err) {
           console.log("[" + data.status + "] " + "서비스 오류가 발생하였습니다. 잠시후 다시 실행하십시오.");  
         }
       });
   
 }
 
</script>

<style>
.customers_view textarea{
  height:360px;
}
</style>
<%-- 

		<div class="noticeList">
              <ul>
                	<li class="board">
                    	<table class="board_st1" cellpadding="0" cellspacing="0">
                        	<colgroup>
                            	<col width="60">
                                <col width="">
                                <col width="60">
                                <col width="100">
                            </colgroup>
                            <tbody>
							<c:forEach items="${list}" var="data" varStatus="status">
							
	                            <tr><th class="line" colspan="4"></th></tr>
								<tr class="sub3">
	                            	<th colspan="4"><c:out value="${ data.title}" /></th>
	                            </tr>
	                        	<tr class="sub2">
	                            	<td><b>작성자</b></td>
	                                <td class="color">관리자</td>
	                                <td><b>등록일</b></td>
	                                <td class="color"><c:out value="${fn:substring(data.regDt,0,11) }" /></td>
	                            </tr>
	                            <tr class="sub2">
	                            	<td colspan="4" class="view">
	                                	<textarea style="padding:0; width:653px;height:260px;overflow-y:auto;"><c:out value="${data.content}" /></textarea>
	                                </td>
	                            </tr>
							</c:forEach>	
							</tbody>
                            
                        </table>
                        <p class="btn_area">
						    <a href="#" class="btn_notice_st1" onClick="back();">목록</a>
							<!-- <a href="#" class="btn_notice_st2 cbtn">닫기</a> -->
                        </p>
                    </li>
                   
                </ul>
			</div> --%>

<!--***** wrap *****-->
<div class="wrap">
	<!--왼쪽 영역-->
	<div class="cont_center">
		<div class="tit">
			<img src="../../images/intra_new/tit_notice.png" alt="공지사항"><span>공지사항</span>
		</div>

		<div id="result_tab1" class="tabcontent_notice" style="display: block;">
			<div class="custom_basic custom_basic_w">
				<table class="customers_view">
					<colgroup>
						<col style="width: 80px;">
						<col style="width: 150px;">
						<col style="width: 80px;">
						<col style="width: 150px;">
						<col style="width: *;">

					</colgroup>
					<c:forEach items="${list}" var="data" varStatus="status">
						<tr>
							<th colspan="5"><c:out value="${ data.title}" /></th>
						</tr>
						<tr>
							<td class="view1">작성자</td>
							<td class="view2">관리자</td>
							<td class="view1">등록일</td>
							<td class="view2"><c:out value="${fn:substring(data.regDt,0,11) }" /></td>
							<td></td>
						</tr>
						<tr>
							<td colspan="5">
								<textarea><c:out value="${data.content}" /></textarea>
							</td>
						</tr>
						<tr>
						  <td class="view1" colspan="5">첨부파일</td>
						</tr>
						<tr>
              <td colspan="5">
                <table id="fileInfos" style="width: 100%; height:0px; border:none;">
                  <tr>
                    <td style="width: 100%; height:0px; border:none;">
                      <input type="hidden" id="fileAtch_Num" name="fileAtch_Num" value="${data.fileatchNum}" />
                    </td>
                  </tr>
                </table>
              </td> 						  				            
            </tr>
					</c:forEach>
				</table>
				<p class="btn_area">
					<a href="#" class="btn_list" onClick="back();">목록</a>
				</p>
			</div>

		</div>
	</div>
	<!--// 왼쪽 영역-->


</div>
<!--// ***** wrap *****-->

<!-- 공지사항 읽기 팝업 end -->
<%-- <div id="popWrap">
	<!--header-->
	<div class="popHead">
		<h1>공지사항 상세 팝업</h1>
		<a href="#" class="btn_close"><img src="../images/operator/btn_p_close.gif" alt="닫기" /></a>
	</div>
    <!--//header-->
    <!--contents_area-->
    <div class="popCnt">
		<div class="board_type">
			<!--공지사항 게시판 상세보기-->
			<table class="tbl_type_board" border="1" cellspacing="0" summary="공지사항 게시판 상세보기입니다.">
				<caption>공시사항 게시판 상세보기</caption>
				<colgroup>
				<col width="20%">
				<col>
				</colgroup>
				<tbody>
				<c:forEach items="${list}" var="data" varStatus="status">
					<tr>
						<th scope="col" class="p_th">번호</th>
						<td class="p_left"><c:out value="${ data.seq}" /></td>
					</tr>
					<tr>
						<th scope="col" class="p_th">이름</th>
						<td class="p_left"><c:out value="${ data.regId}" /></td>
					</tr>
					<tr>
						<th scope="col" class="p_th">내용</th>
						<td class="p_contents"><c:out value="${data.content}" /></td>
					</tr>
				</c:forEach>	
				</tbody>
			</table>
			<!--//공지사항 게시판 상세보기-->
		</div>
		<!--btnArea-->
		<div class="btnArea t_center">
			<button type="button" class="btnComm gray mr5" title="확인" onClick="back();">확인</button>
			<button type="button" class="btnComm gr_line" title="취소" onClick="back();">취소</button>
		</div>
		<!--//btnArea-->
	</div>
	<!--//contents_area-->
	
</div> --%>
