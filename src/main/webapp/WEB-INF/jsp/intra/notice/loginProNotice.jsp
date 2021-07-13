<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<body>
	<div class="login_notice_line">
		<a onclick="openModal(1)" >공지사항1</a><br />
		<a onclick="openModal(2)" >공지사항2</a><br />
		<a onclick="openModal(3)" >공지사항3</a><br />
	</div>

	<div id="myModal1" class="modal">
	    <div class="modal-content">
		    <span class="close">&times;</span>
		  	<p>공지사항1 내용 길게 작성 해보기</p>
		  	<p>공지사항1 내용</p>
		  	<p>공지사항1 내용</p>
		  	<p>공지사항1 내용</p>
		  	<p>공지사항1 내용</p>
		</div>
	</div>
	
	<div id="myModal2" class="modal">
	    <div class="modal-content">
		    <span class="close">&times;</span>
		  	<p>공지사항2 내용</p>
		  	<p>공지사항2 내용</p>
		  	<p>공지사항2 내용</p>
		</div>
	</div>
	
	<!-- SAMPLE -->
	<!-- color : red 글자색 변경 / a Tag : 해당 주소로 페이지 이동  -->
	<div id="myModal3" class="modal">
	    <div class="modal-content">
		    <span class="close">&times;</span>
		  	<p style="color: red;">공지사항3 내용</p>
		  	<p>공지사항3 내용</p>
		  	공지사항3내용 <a href="https://www.naver.com/" target="_blank">클릭</a> 누르면 이동합니다.
		</div>
	</div>
</body>