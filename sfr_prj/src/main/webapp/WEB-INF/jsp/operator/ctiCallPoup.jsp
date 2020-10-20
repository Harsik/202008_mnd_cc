<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/layout/include/incHeader.jspf" %>
<script>



 function call() {
	 window.opener.name = "/operator/callMain.do";
	 frm.target="/operator/callMain.do";
	 frm.action="/operator/callMain.do";
	 frm.submit();
	 self.close();
 }
 
 
 
</script>
<div id="popWrap">
	<!--header-->
	<div class="popHead">
		<h1>호인입</h1>
		<a href="#" class="btn_close"><img src="../images/operator/btn_p_close.gif" alt="닫기" /></a>
	</div>
    <!--//header-->
    <!--contents_area-->
    <div class="popCnt">
		<!--호인입 보기-->
		<div class="pop_call">
			<div class="pop_inner">
				<ul>
					<li class="pr45"><img src="../images/operator/pop_call.png" alt="호인입" /></li>
					<li><img src="../images/operator/img_unregister.png" alt="미등록자" /></li>
				</ul>
			</div>
		</div>
		<!--//호인입 보기-->
		<!--텍스트 보기-->
		<div class="pop_table">
				<div class="inputBox">
					<div class="input01">
						<div class="cont"><span class="txtid"><label for="txtid" title="발신경로" class="label_txt">발신경로 :</label></span>
							<span class="txt_loc">....</span></div>
						<div class="cont"><span class="txtpw"><label for="txtpw"  title="발신번호" class="label_txt">발신번호 :</label></span>
							<span class="txt_phone" >010-1234-5678</span> <input type="hidden" name="talNo" id="talNo" value="010-1234-5678"></div> 
						<div class="cont"><span class="txtpw"><label for="txtpw"  title="이름" class="label_txt" id="name">이름 :</label></span>
							<span class="txt_name">홍길동</span><input type="hidden" name="name" id="name" ></div> 
						</div>
					<div class="input02"><button type="button" name="callBt" id="callBt" onclick="call();">전화받기</button></div>
				</div>
		</div>
		<!--//텍스트 보기-->
	</div>
	<!--//contents_area-->
	
</div>