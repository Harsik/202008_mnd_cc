<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/layout/include/incHeader.jspf"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!-- <link rel="stylesheet" href="../css/intra/intra.css" />  -->
<link href="../../css/17/sub.css" rel="stylesheet" type="text/css" />

<script>
$(document).ready(function() {
  
  $("#detailView").hide();
  var pageURL = location.href;
  active(1);
    
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

//그룹 삭제
function deleteBkmk(seq, groupNm) {    
        
    if(confirm(groupNm+"을(를) 삭제하시겠습니까? ")) {
    	var frm = document.form1;
    	
      frm.seq.value = seq;
      frm.action = "/intra/deleteBkmk.do";
      frm.submit();
    }
    
  }

function bkmkSavePopup(dType, seq, gNm) {
    var x = (window.screen.width / 2) - (650 / 2);
    var y = (window.screen.height / 2) - (200 / 2);
    
    window.open('./bkmkGroupPopup.do?dType='+dType+'&seq='+seq+'&gNm='+gNm+'', '즐겨찾기'
          , "location=no,scrollbars=no,resizable=no,top="+y+",left="+x+
          ",width=650,height=200, screenX="+x+", screenY="+y+"");
}

function back() {
	   location.href = "/intra/myPage.do";
	}

function onListPage(page) {
  var frm = document.form1;
  frm.currentPage.value = page;
  frm.action = "/intra/intraBookmarkGroupList.do";
  frm.submit();
};

</script>

<style>
@font-face {
  font-family: 'Nanum Gothic';
  font-style: normal;
  font-weight: 400;
  src: url(../../fonts/NanumGothic-Regular.eot);
  src: url(../../fonts/NanumGothic-Regular.eot?#iefix)
    format('embedded-opentype'),
    url(../../fonts//NanumGothic-Regular.woff2) format('woff2'),
    url(../../fonts/NanumGothic-Regular.woff) format('woff'),
    url(../../fonts/NanumGothic-Regular.ttf) format('truetype');
}

@font-face {
  font-family: 'Nanum Gothic';
  font-style: normal;
  font-weight: 700;
  src: url(../../fonts/NanumGothic-Bold.eot);
  src: url(../../fonts/NanumGothic-Bold.eot?#iefix)
    format('embedded-opentype'), url(../../fonts/NanumGothic-Bold.woff2)
    format('woff2'), url(../../fonts/NanumGothic-Bold.woff) format('woff'),
    url(../../fonts/NanumGothic-Bold.ttf) format('truetype');
}

@font-face {
  font-family: 'Nanum Gothic';
  font-style: normal;
  font-weight: 800;
  src: url(../../fonts/NanumGothic-ExtraBold.eot);
  src: url(../../fonts/NanumGothic-ExtraBold.eot?#iefix)
    format('embedded-opentype'),
    url(../../fonts/NanumGothic-ExtraBold.woff2) format('woff2'),
    url(../../fonts/NanumGothic-ExtraBold.woff) format('woff'),
    url(../../fonts/NanumGothic-ExtraBold.ttf) format('truetype');
}


</style>

<!--***** wrap *****-->
<div class="wrap">
  <!--왼쪽 영역-->
  <div class="cont_center">
    <div class="tit">
      <img src="../../images/intra_new/icon_favorite2.png" alt="그룹관리"><span>즐겨찾기 그룹관리</span>
    </div>
    <form id="form1" name="form1" method="POST" action="#" class="search-box_ad">
      <input type="hidden" id="seq" name="seq" value="" />
      <input type="hidden" id="currentPage" name="currentPage" value='<c:out value="${paginationInfo.currentPageNo}"/>' />
      <input type="hidden" id="recordCountPerPage" name="recordCountPerPage" value='<c:out value="${paginationInfo.recordCountPerPage}"/>' />
      <input type="hidden" onclick="onListPage('1')">
    </form>
    <div id="result_tab1" class="tabcontent_notice" style="display: block;">
      <div class="custom_basic">
        <table class="customers">
          <colgroup>
            <col style="width: 7%;">
            <col style="width: 65%;">
            <col style="width: 13%;">
            <col style="width: 15%;">
          </colgroup>
          <thead>
            <tr>
              <th>번호</th>
              <th>그룹명</th>
              <th>등록일</th>
              <th>설정</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach items="${list}" var="data" varStatus="status">
              <tr>
                <td><c:out
                    value="${(paginationInfo.currentPageNo-1) * paginationInfo.recordCountPerPage + status.count}" /></td>
                <td class="ellipsis">
                  <a id="seq" href="javascript:{bkmkSavePopup('D', '<c:out value="${data.seq}"/>','<c:out value="${data.groupNm}"/>')}">
                  <!-- <a id="seq" href="javascript:{bkmkSavePopup(D)}"> -->
                    <c:out value="${data.groupNm}" />
                  </a>
                </td>                
                <td><c:out value="${data.regDt}" /></td>
                <td><a href="#" class="btn" onclick="deleteBkmk('<c:out value="${data.seq}"/>','<c:out value="${data.groupNm}"/>');"><img src="../images/intra_new/i_btn_del.png" alt="삭제"></a></td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
      <div class="paging">
        <page:paging paginationInfo="${paginationInfo}" jsFunction="onListPage" rowControl="false"  />
      </div>
    </div>


    <!--btn_area-->
    <div>
      <div class="btn_area_write" style="float: right;margin:50px 0px;">
        <a href="#" class="btn_write" id="btnSavePopup" onClick="bkmkSavePopup('S','null','null');">등록</a> 
        <a href="#" class="btn_write" id="btnCancle" onClick="back();">취소</a> 
      </div>
    </div>
    <!--//btn_area-->
        
        
  </div>
  <!--// 왼쪽 영역-->

      
</div>
<!--// ***** wrap *****-->

