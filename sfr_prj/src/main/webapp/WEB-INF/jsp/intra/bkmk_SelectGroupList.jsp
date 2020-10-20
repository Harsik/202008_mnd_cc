<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/layout/include/incHeader.jspf" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<title>그룹관리</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="../css/17/popup.css" rel="stylesheet" type="text/css" />
<link href="../css/17/sub.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="../css/common.css" />
<script type="text/javascript" src="../js/jquery-1.7.1.min.js"></script>
</head>

<script type="text/javascript">
var pGroupCd = "";
var pType = "";


function btnEvent(gType) {
	pType = gType;
	pGroupCd = $("#groupCd").val();
	
	var msg = ($("#popType").val() == "I" ? "즐겨찾기에 등록하시겠습니까?" : "즐겨찾기그룹을 수정하시겠습니까?");
	
  if (gType == 'C') {
    self.close();   
  } else if(gType == 'I') {
	  if (pGroupCd == "") {
		    alert("그룹명을 선택해주세요.");
		    return;
		}

	  if(confirm(msg)){		  
		  window.opener.gChildEvent(pGroupCd);
		  
		  self.close(); 
		  }
	}
	
}


</script>

<style>
  html,body{height:100%; width:100%;min-width:650px;margin:0;padding:0;}
  
.customers{width:97%;}

.customers td{text-align: left;}
</style>

<body style="background-color:#fff;">

  <!--***** wrap *****-->
  <div class="popupwrp" id="wrap">
    <div class="cont_center">
      <div class="tit">
        <img src="../../images/intra_new/icon_favorite2.png" alt="그룹관리"><span>그룹관리</span>
      </div>
      <form id="form1" name="form1" method="POST" action="#" class="search-box_ad">
        <input type="hidden" id="popType" name="popType" value="${popType}" />
	      <div id="result_tab1" class="popcontent" style="display: block;">
	        <div class="custom_basic">
	          <table class="customers">
	            <colgroup>
	              <col style="width:20px;">
	              <col style="width:55px;">
	            </colgroup>
	            <tr>
	              <th>그룹명</th>
	              <td>
	                <select name="groupCd" id="groupCd" title="조건을 선택하세요" class="select-type w250" >
                    <option value="" selected>- 선택 -</option>
                  <c:forEach items="${groupList}" var="data" varStatus="status">
                    <option value="${data.groupCd}">${data.groupNm}</option>
                  </c:forEach>
                  </select>
	              </td>
	            </tr>
	          </table>
	        </div>
	
			    <!--btn_area-->
			    <div>
			      
			      <div class="tbl_bottom">
	            <div class="t_right" style="margin:20px 10px;">
				        <button type="button" name="btnInsert" id="btnInsert" class="btnComm grblue addBt" title="등록" onclick="btnEvent('I');">등록</button>
				        <!-- <button type="button" name="btnUpdate" id="btnUpdate" class="btnComm grblue addBt" title="수정" onclick="bkmkSave('U');">수정</button> -->
		            <button type="button" name="btnCancle" id="btnCancle" class="btnComm gr_line ml5" title="닫기" onClick="btnEvent('C');">닫기</button>
				      </div>
		        </div>
			    </div>
			    <!--//btn_area-->
	    
	      </div>
      
      </form>
    </div>
  
  </div>
  <!--// ***** wrap *****-->

</body>
</html>
