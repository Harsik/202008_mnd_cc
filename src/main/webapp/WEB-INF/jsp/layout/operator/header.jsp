<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<tiles:importAttribute name="user_name" />

  <script type="text/javascript" src="../js/callmain.js"></script>
  <!-- <script type="text/javascript" src="../js/project.js"></script> -->
<script type="text/javascript">
/* 
$(document).ready(function () {
	$(function(){
	//	setLogoutTimer("operator");
	});
	
	
	//setTime();
});
	
	var curSecond = 0;
	  if (localStorage.getItem('second')) {
	    curSecond = localStorage.getItem('second');
	  }

	  function setTime() {
	    setInterval(function() {
	      var sec = curSecond;
	      var min = 0;
	      min = parseInt(sec/60);
	      //console.log(sec,"초");
	      //console.log(min,"분");
	      
	      if (sec < 60) {
	    	  if(sec < 10) {
		        sec = '00:00:0'+ sec + '초';
	    	  } else {
		        sec = '00:00:'+ sec + '초';
	    	  }
	      } else if (sec < 3600) {
		        sec = '00:0'+Math.floor((sec % 3600) / 60) + ':' + sec % 60 + '초';
	      } else {
	        sec = Math.floor(sec / 3600) + '시간 ' + Math.floor((sec % 3600) / 60) +  '분 ' +  sec % 60 + '초';
	      }

	      curSecond++;
	      localStorage.setItem('second', curSecond);
	      $('#time').text(sec);
	    }, 1000);
	  }
	  
	
	function logout(){
		location.href = "/operator/logout.do";
		localStorage.clear();
	};
	*/
	//공지사항 팝업
	function popup_notice(){ //경로, 가로, 세로, 아이디
		gfn_popup("/operator/operatorNoticeList.do", "700", "460", "noticepopup");
	};

	//상담이력
	function popup_operator(){ //경로, 가로, 세로, 아이디
		gfn_popup("/operator/operatorPopup.do", "800", "460", "noticepopup");
	};
/* 
	function popup_call(){ //경로, 가로, 세로, 아이디
		alert("call");
		gfn_popup("/operator/ctiCallPoup.do", "600", "400", "callPopup");
	}; */
	

	
</script>

 <style type="text/css">
.gnb_box2{width:60px;height:52px;}
.gnb_box2:hover{width:60px;height:52px;background:url(../images/operator/but_bg_on.png) no-repeat;}
.gnb_box2 .gnb_inner{text-align:center;padding:8px 0 0 0;}
.gnb_box2 .gnb_inner p{}
.gnb_box2 .gnb_inner span.gnb_txt{font-size:13px;letter-spacing:-1px;color:#394f88;font-weight:800;display:block;}

.button {
  display:inline-block;
  border-radius: 3px;
  border: 1px solid #2b91dd;
  line-height: 1;
  padding: 3px 4px;
  background: #0f71ba;
  background: -moz-linear-gradient(top, #3fa4f0 0%, #0f71ba 100%);
  background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #3fa4f0), color-stop(100%, #0f71ba));
  background: -webkit-linear-gradient(top, #3fa4f0 0%, #0f71ba 100%);
  background: -o-linear-gradient(top, #3fa4f0 0%, #0f71ba 100%);
  background: -ms-linear-gradient(top, #3fa4f0 0%, #0f71ba 100%);
  background: linear-gradient(to bottom, #3fa4f0 0%, #0f71ba 100%);
  font-family:'Dotum', sans-serif;
  font-size: 9pt;
  text-align: center; 
  font-weight:bold;
  color: #fff; 
  text-decoration:none;
}
.button:hover {
  border: 1px solid #336ac8;
  background: #2f65c0;
  background: -moz-linear-gradient(top, #427cdb 0%, #2559b1 100%);
  background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #427cdb), color-stop(100%, #2559b1));
  background: -webkit-linear-gradient(top, #427cdb 0%, #2559b1 100%);
  background: -o-linear-gradient(top, #427cdb 0%, #2559b1 100%);
  background: -ms-linear-gradient(top, #427cdb 0%, #2559b1 100%);
  background: linear-gradient(to bottom, #427cdb 0%, #2559b1 100%);
  color: #f4f4f4;
}
.button:active {
  border: 1px solid #336ac8;
  background: #2f65c0;
  background: -moz-linear-gradient(top, #427cdb 0%, #2559b1 100%);
  background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #427cdb), color-stop(100%, #2559b1));
  background: -webkit-linear-gradient(top, #427cdb 0%, #2559b1 100%);
  background: -o-linear-gradient(top, #427cdb 0%, #2559b1 100%);
  background: -ms-linear-gradient(top, #427cdb 0%, #2559b1 100%);
  background: linear-gradient(to bottom, #427cdb 0%, #2559b1 100%);
}

.text_ol { 
  height:23px !important;
  margin-left:1px;
  padding-left:6px;
  border-style: solid; 
  border-width: 1px; 
  border-color: #ccc !important;
  font-family: Dotum, sans-serif;
  font-size: 9pt; 
  color: #333 !important; 
  text-align: left;
}

 /******* 전화걸기 팝업 *******/
a{color:#000;}
.mask{width:100%; height:100%; position:fixed; left:0; top:0; z-index:10; background:#000; opacity:.5; filter:alpha(opacity=50);}
/* #modalLayer{display:none; position:relative;} */
#modalLayer{
	left: 203px; 
	top: 68px; 
	display: block;
	position: absolute; 
	z-index: 9;
	text-align: left;
	border-radius: 0px 0px 7px 7px; 
}
#modalLayer #modalLayerheader {
    /* padding: 5px; */ 
		padding-left: 15px;
    position:relative;
   /*  cursor: move; */
    z-index: 12;
    background-color: #003b91;
    color: #fff;
    font-weight:bold; 
}
/* #modalLayer .modalContent{width:440px; height:123px; padding:20px; border:1px solid #ccc; position:fixed; left:30%; top:19%; z-index:11; background:#fff;border-radius: 7px;} */
#modalLayer .modalContent{
	width:500px; 
	height:26px; 
	/* padding:3px 20px 3px 3px; */
	border:1px solid #ccc; 
	position:relative; 
	left:0; 
	top:19%; 
	z-index:11; 
	background:#f6f6f6;
	border-radius: 0px 0px 7px 7px; 
}
#modalLayer .modalContent button{
	/* position:absolute; */ 
	right:0; 
	top:0; 
	cursor:pointer;
}

#modalLayer .modalContent img{
	position:absolute;
	right:0; 
	top:0; 
	cursor:pointer;
}
/**************************/

/** 빠른걸기 전화걸기 입력란 x버튼 삭제*/
#modalCallNum::-ms-clear {display: none;}
 
 /* 추가  */
::-webkit-input-placeholder { /* 크롬 4–56 */
    color: #9e9e9e;
}

:-ms-input-placeholder { /* 인터넷 익스플로러 10+ */
   color:  #9e9e9e;
}

</style>

<!-- 상단 레이아웃 -->
<script language="javascript">

ObjectWrite();


</script>
<script language="javascript">

StartGuard(2);


</script>

<a href="#content_m" class="skip">본문 바로가기</a>
<div id="wrap">
	<!--header-->
    <div class="top_navi">
    	<div class="m_wrap">
            <!--logo-->
			<div class="logo"><a href="#" ><img src="/images/operator/logo_O1.png" alt="전화번호 통합검색" /></a></div>
			<!--//logo-->
			<!--gnb-->
			<div class="gnb" style="min-width:770px;">
				<ul>
					<li>
						<!---대기-->
					 	<a href="#">
							<div class="gnb_box2" id="softphone_1">
								<div class="gnb_inner">
									<p><img src="/images/operator/but_waiting.png" alt="대기" /><span class="gnb_txt" id="readyText">대기</span></p>
								</div>
							</div>
						</a>
						<!--//대기-->
					</li>
					<li>
						<!---걸기-->
						<a href="#">
							<div class="gnb_box2" id="softphone_2">
								<div class="gnb_inner">
									<p><img src="/images/operator/but_call.png" alt="걸기" /><span class="gnb_txt">걸기</span></p>
								</div>
							</div>
						</a>
						<!--//걸기-->
					</li>
					<li>
						<!---끊기-->
						<a href="#">
							<div class="gnb_box2" id="softphone_3">
								<div class="gnb_inner">
									<p><img src="/images/operator/but_quit.png" alt="끊기" /><span class="gnb_txt">끊기</span></p>
								</div>
							</div>
						</a>
						<!--//끊기-->
					</li>
					<li>
						<!---보류-->
						<a href="#">
							<div class="gnb_box2" id="softphone_4">
								<div class="gnb_inner">
									<p><img src="/images/operator/but_hold.png" alt="보류" /><span class="gnb_txt">보류</span></p>
								</div>
							</div>
						</a>
						<!--//보류-->
					</li>
					<li>
						<!---협의-->
						<a href="#">
							<div class="gnb_box2" id="softphone_5">
								<div class="gnb_inner">
									<p><img src="/images/operator/but_confer.png" alt="협의" /><span class="gnb_txt">협의</span></p>
								</div>
							</div>
						</a>
						<!--//협의-->
					</li>
					
					<li>
						<!---이석-->
						<a href="#">
							<div class="gnb_box2" id="softphone_8">
								<div class="gnb_inner">
									<p><img src="/images/operator/but_rest.png" alt="이석" /><span class="gnb_txt">이석</span></p>
								</div>
							</div>
						</a>
						<!--//이석-->
					</li>
					<li>
						<!---재접속-->
						<a href="#">
							<div class="gnb_box2" id="softphone_9">
								<div class="gnb_inner">
									<p><img src="/images/operator/but_reconnect.png" alt="재접속" /><span class="gnb_txt">재접속</span></p>
								</div>
							</div>
						</a>
						<!--//재접속-->
					</li>
					<li>
						<!---공지사항-->
						<a href="#" onclick="popup_notice();">
							<div class="gnb_box">
								<div class="gnb_inner">
									<p><img src="../images/operator/but_gongji.png"  alt="공지사항" /><span class="gnb_txt">공지사항</span></p>
								</div>
							</div>
						</a>
						<!--//공지사항-->
					</li>
					<li>
						<!---상담이력-->
						<a href="#" onclick="popup_operator();">
							<div class="gnb_box">
								<div class="gnb_inner">
									<p><img src="../images/operator/but_sangdam.png" alt="상담이력" /><span class="gnb_txt">상담이력</span></p>
								</div>
							</div>
						</a>
						<!--//상담이력-->
					</li>
					<li>
						<!---로그아웃--> 
							<div class="gnb_box2" id="softphone_10">
								<div class="gnb_inner">
									<p><img src="/images/operator/but_logout.png" alt="로그아웃" /><span class="gnb_txt">로그아웃</span></p>
								</div>
							</div> 
						<!--//로그아웃-->
					</li>
				</ul>
			</div>
			<!--// gnb-->
			<!--login_box-->
			<div class="login_box">
				<div class="login_box01"><span class="login_name">${user_name }님 </span><span class="login_status" id="MainStatusNm"></span></div>
				<div class="login_box02"><span class="login_time">로그인시간 : </span><span class="login_time_b" id="time">00:00:00</span></div>
				<input type=hidden id="tfMainTicketId">
				<input type=hidden id="tfRecId">
				<input type=hidden id="CTIID" value="${user_id}">
				<input type=hidden id="EXTNO" >
				<input type=hidden id="CALLNO">
				</div>
			<!--//login_box-->
    	</div>
    </div>
    <!--//header-->

   		<!-- 전화걸기 팝업 -->
		<!--Draggable DIV:-->
 			<div id="modalLayer">
				<div id="modalLayerheader" style="height: 22px;">	 
										<table >
											<tr>
												<th><label style="font-size: 10pt; color:#fff; cursor: move;">전화걸기</label> </th>
											 
												<td class="btn" style="padding-left: 10px; margin-left: 1px;">
												<img style="cursor:pointer; vertical-align: middle;" src="/images/operator/sel_dub_arrow2.png" id="popupCollapse">
												</td>
												<td class="btn" style="width: 396px; text-align: right; padding-left: 10px; margin-right: 10px;">
													<img style="cursor:pointer; vertical-align: middle;" src="/images/operator/modal_close.png" id="popupClose">
												</td>
											</tr>
										</table>
				</div>
			   <div class="modalContent">
							<div id="search" style="padding:0px; margin-left:2px; width:495px; border-radius:0 0 5px 5px;">
								<table class="search_tbl">
									<tr>
										<th style="width:10px; text-align:left;"></th>
										<td>
											<input type="text" id="modalCallNum" class="text_ol" style="width:320px;" maxlength="50" placeholder=" 전화번호 입력해주세요!">
										  <input type="hidden" id="hidDBCallNum" value=""> 
										  <input type="hidden" id="hidKeyInput" value=""> 
										</td>
										<td class="btn">
											&nbsp; &nbsp;<button type="button" id="btnModalCall" class="button">걸기</button>&nbsp;
											<button type="button" id="btnModalHangUp" class="button">끊기</button>
											&nbsp; &nbsp;&nbsp; &nbsp;<button type="button" id="btnMdalTransfer" class="button">호전환</button>
										</td>
									</tr>
								</table>
							 
					   </div>
					  
			   </div> 
		</div>  
 
	   	<!-- 일반전화용 인입 팝업 레이어 -->
	<div id="dialogCallPopup" style="width: 480px; min-height: 0px; max-height: none; padding:0px; background: white;">
		<div id="popWrap" > 
		<!--header-->
		<div class="popHead">
			<h1><label style="color:#fff;">호인입</label>&nbsp; &nbsp;<label id="labInPopup" style="color:#000;"></label></h1>
			<a href="#" class="btn_close" id="modalClose"><img src="../images/operator/btn_p_close.gif" alt="닫기" /></a>
		</div>
	    <!--//header-->
	    <!--contents_area-->
	    <div class="popCnt" style="padding: 10px;">
			<!--호인입 보기-->
			<div class="pop_call">
				<div class="pop_inner">
					<ul>
						<li class="pr45"><img src="../images/operator/pop_call.png" alt="호인입" /></li>
						<li><img src="../images/operator/img_unregister.png"  /></li>
					</ul>
				</div>
			</div>
			<!--//호인입 보기-->
			<!--텍스트 보기-->
			<div class="pop_table"> 
						<div class="inputBox" >
							  <div class="input01" style="position: absolute;">
								 	<div class="cont" style="width: 270px; display: inline-block;" > <span class="txtid"><label for="txtid" title="발신경로" class="label_txt">부서 :</label>	</span>
								 	 <span class="txt_phone" id="tfDialogDeptNm"></span>
									 
									</div>
							  	<div class="cont" style="width: 270px;"><span class="txtpw"><label for="txtpw"  title="발신번호" class="label_txt">발신번호 :</label></span>
									    <span class="txt_phone" id="tfDialogCustTelNo"></span>  
									</div> 
								  <div class="cont" style="width: 270px; position: absolute;"><span class="txtpw"><label for="txtpw"  title="이름" class="label_txt" id="name">이름 :</label></span>
									  <span class="txt_name" id="tfDialogCustNm"></span> 
									</div> 
								</div>
							<div class="input02" style="position: relative; float : right;">
							    <button type="button" name="callBt" id="btnDialogAnswer">전화받기</button>
							</div>
						</div> 
			</div>
			<!--//텍스트 보기-->
		</div>
		<!--//contents_area-->
		
	</div> 
</div>
	 	
		<!-- 협의 통화 팝업 레이어 -->
	<div id="dialogMainConfirmPopup" title="협의통화 요청">
	<label id="labTransferDialog" style="color:red; font-size: 13px;"></label> 
		<p id="popupMessageConfirmPopup" style="font-size: 13px;">
			협의통화를 요청중입니다.<br>
			상대편 전화가 연결되면 호전환 버튼을 눌러주세요
		</p>
	</div>
