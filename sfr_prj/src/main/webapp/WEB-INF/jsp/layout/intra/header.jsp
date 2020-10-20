<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ include file="/WEB-INF/jsp/layout/include/incHeader.jspf" %>
<tiles:importAttribute name="user_name" />
<!-- 상단 레이아웃 -->
<script type="text/javascript">

	$(document).ready(function () {
		$(document).click(".myCheckbox>input[type='checkbox']", function() {
			//클릭되었으면
			if ($(this).is(':checked')) {
				var val = $(this).attr("id");
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
						if (data.result === 1) {
							myPageAjax();
						} else if (data.result === "200") {
							alert("등록되어있습니다.");
						}
					}
				});
			}

		});
	});
 	  
	function intraLogout(){
		location.href = "/intra/logout.do";
		localStorage.clear();
	};
	
	//공지사항 팝업
	function popup_notice(){ //경로, 가로, 세로, 아이디
		//gfn_popup("/intra/intraNoticeList.do", "700", "460", "noticepopup");
		//layer_open('layer1','1');
	};
	
	function myPage() {
		//active(3);
		location.href= "/intra/myPage.do"
	}

	function main() {
		active(0);
		location.href= "/intra/main.do"
	}
	
	function qna() {
		//active(2);
		location.href= "/intra/qnaBoard.do"
	}
	
	function notice() {
		//active(1);
		location.href= "/intra/intraNoticeList.do"
	}
	
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
		
</script>
<%-- <div id="hd">
	<ul class="con">
    	<a href="javascript:void(0)" onclick="main();" class="logo"><img src="../images/intra/logo.png" alt="전화번호 통합검색체계" /></a>
        <li class="member">
        	<img src="../images/intra/icon_member.png" alt="회원 아이콘" /> <b><c:out value="${user_name}"/></b>
        </li>
        <li class="menu">
        	<a href="javascript:void(0)" onclick="main();" class="icon1"><span class="icon"></span><span>홈</span></a>
            <a href="javascript:void(0)" onclick="layer_open('layer1','1');return false;" class="icon2"><span class="icon"></span><span>공지사항</span></a>
            <a href="javascript:void(0)" onclick="myPage();"class="icon3"><span class="icon"></span><span>마이페이지</span></a>
            <a href="javascript:void(0))" onclick="intraLogout();"class="icon4"><span class="icon"></span><span>로그아웃</span></a>
        </li>
    </ul>
</div>   --%>  

<div class="header">
    <ul>
		<li class="logo" onclick="main();">로고</li>
		<li class="wrap_log"><img src="../images/intra_new/i_nav_log.png" alt="회원 아이콘"><c:out value="${user_name}"/></li>
		<li class="wrap_navbar">
			<div class="navbar">
			    <a class="active" href="javascript:void(0)" onclick="main();" ><img src="../images/intra_new/i_nav_home.png" alt="홈">홈</a> 
				<a href="javascript:void(0)" onclick="notice();"><img src="../images/intra_new/i_nav_notice.png" alt="공지사항"><span>공지사항</span></a> 
			  <a href="javascript:void(0)" onclick="qna();"><img src="../images/intra_new/i_nav_qna.png" alt="Q&A">Q&A</a>
			    <a href="javascript:void(0)" onclick="myPage();"><img src="../images/intra_new/i_nav_mypage.png" alt="마이페이지">마이페이지</a>
				<a href="javascript:void(0)" onclick="intraLogout();"><img src="../images/intra_new/i_nav_logout.png" alt="로그아웃">로그아웃</a>
			</div>
		</li>
		
	</ul>
</div>
    
<!-- <div class="layer1 layer">
	<div class="bg bg_layer1"></div>
	<div id="layer1" class="pop-layer layer1">
		<div class="pop-container">
		    <div class="noticeTitle"><span class="icon_title"></span>공지사항<a href="#" class="cbtn btnClose"></a></div>
            <iframe src="/intra/intraNoticeList.do" style="width:700px; height:457px;" name="commentList" width="98%"  frameborder="0" scrolling="no" ></iframe>
       </div>
       <iframe src="/intra/intraNoticeList.do" style="width:100%; height:100%;" name="commentList" width="98%"  frameborder="0" scrolling="no" ></iframe>
	</div>
</div> -->
    
