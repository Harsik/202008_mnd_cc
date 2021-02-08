<!-- PM -->









<!-- 총납부요금 -->


<!-- 총할인요금 -->


<!-- 총이용요금 -->



<!-- 총이용요금(미납제외) -->


<!-- 총미납요금 -->


<!-- 출금일 -->




<!--LTHAL 안내문구 두번 안타게 노승훈 -->

<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />

<title>LG 유플러스 이메일 청구서입니다.</title>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page buffer="16kb" %>
<%@ page language="java" extends="xecure.servlet.jsp.XecureHttpJspPage"  %>
<%@ page import="xecure.servlet.*" %>
<%@ page import="xecure.crypto.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.security.*" %>
<%@ page import="java.util.Random" %>
<script language='javascript' src='../anySign4PCInterface.js'></script>
<script>
<%
    VidVerifier vid = new VidVerifier(new XecureConfig());
    out.println(vid.ServerCertWriteScript());

	// AnySign 세션ID 설정
	String HashedSessionID = "";

	// 1. 고정 세션 ID
	HashedSessionID = "reaverTestSID19810531";
	
	// 2. 웹세션ID 해쉬
	//String id = session.getId();
	//HashedSessionID = cipher.getHash("SHA256",id);

	out.println("AnySign.mAnySignSID = '" + HashedSessionID + "';");
	//


	// 데몬 무결성 검증 기능 선택사항
	String HashedRandomValue = "";
	
	// 1. 무결성 검증 비활성화
	//    AnySign.mAnySignITGT 변수 "" 설정 - 2번 부분 주석처리.
	//

	// 2. 랜덤값 기반 무결성 검증 설정
	//    AnySign.mAnySignITGT = HashedRandomValue
	//
	Cipher cipher = new Cipher( new XecureConfig());
	HashedRandomValue = cipher.getRamdomMsg(30);

	out.println("AnySign.mAnySignITGT = '" + HashedRandomValue + "';");
%>
PrintObjectTag ();
</script>
</head>
<body>
<!---BEGIN_ENC--->
<script type="text/javascript">
<!--

// Tab Content
function initTabMenu(tabContainerID) {
var tabContainer = document.getElementById(tabContainerID);
var tabAnchor = tabContainer.getElementsByTagName("a");
var i = 0;

for(i=0; i<tabAnchor.length; i++) {
if (tabAnchor.item(i).className == "tab")
thismenu = tabAnchor.item(i);
else
continue;

thismenu.container = tabContainer;
thismenu.targetEl = document.getElementById(tabAnchor.item(i).href.split("#")[1]);
thismenu.targetEl.style.display = "none";
thismenu.imgEl = thismenu.getElementsByTagName("img").item(0);
thismenu.onclick = function tabMenuClick() {
currentmenu = this.container.current;
if (currentmenu == this)
return false;

if (currentmenu) {
currentmenu.targetEl.style.display = "none";
if (currentmenu.imgEl) {
currentmenu.imgEl.src = currentmenu.imgEl.src.replace("on.gif", ".gif");
} else {
currentmenu.className = currentmenu.className.replace(" on", "");
}
}
this.targetEl.style.display = "";
if (this.imgEl) {
this.imgEl.src = this.imgEl.src.replace(".gif", "on.gif");
} else {
this.className += " on";
}
this.container.current = this;

return false;
};

if (!thismenu.container.first)
thismenu.container.first = thismenu;
}
if (tabContainer.first)
tabContainer.first.onclick();
}

//faq
function faq(n){
var p = "a"+n;
var i = "i"+n;
if ( document.getElementById(p).style.display == "none" ){
document.getElementById(p).style.display = "";
document.getElementById(i).src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/table01_btn_on.gif";
} else{
document.getElementById(p).style.display = "none";
document.getElementById(i).src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/table01_btn.gif";
}
}

//all
function allfaq(){
var s1 = document.getElementById('a1');
var s2 = document.getElementById('a2');
var s3 = document.getElementById('a3');
var b1 = document.getElementById('i1');
var b2 = document.getElementById('i2');
var b3 = document.getElementById('i3');
var btn = document.getElementById('allbtn');
if ( s1.style.display == "none" || s2.style.display == "none" || s3.style.display == "none"){
s1.style.display = "";
s2.style.display = "";
s3.style.display = "";
b1.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/table01_btn_on.gif";
b2.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/table01_btn_on.gif";
b3.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/table01_btn_on.gif";
btn.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/table01_allbtn_on.gif";
} else {
s1.style.display = "none";
s2.style.display = "none";
s3.style.display = "none";
b1.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/table01_btn.gif";
b2.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/table01_btn.gif";
b3.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/table01_btn.gif";
btn.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/table01_allbtn.gif";
}
}

//navi tab
function click_check(url,opc){

var cont1_flag = false;
var cont2_flag = false;
var cont3_flag = false;
var cont4_flag = false;
var cont5_flag = false;
var cont6_flag = false;
var cont7_flag = false;
var cont8_flag = false;
var cont9_flag = false;

var navi1 = document.getElementById('content1');
var navi2 = document.getElementById('content2');
var navi3 = document.getElementById('content3');
var navi4 = document.getElementById('content4');
var navi5 = document.getElementById('content5');
var navi6 = document.getElementById('content6');
var navi7 = document.getElementById('content7');
var navi8 = document.getElementById('content8');
var navi9 = document.getElementById('content9');

if(document.getElementById('contb1') != null){
var navib1 = document.getElementById('contb1');
cont1_flag = true;
}
if(document.getElementById('contb2') != null){
var navib2 = document.getElementById('contb2');
cont2_flag = true;
}
if(document.getElementById('contb3') != null){
var navib3 = document.getElementById('contb3');
cont3_flag = true;
}
if(document.getElementById('contb4') != null){
var navib4 = document.getElementById('contb4');
cont4_flag = true;
}
if(document.getElementById('contb5') != null){
var navib5 = document.getElementById('contb5');
cont5_flag = true;
}
if(document.getElementById('contb6') != null){
var navib6 = document.getElementById('contb6');
cont6_flag = true;
}
if(document.getElementById('contb7') != null){
var navib7 = document.getElementById('contb7');
cont7_flag = true;
}
if(document.getElementById('contb8') != null){
var navib8 = document.getElementById('contb8');
cont8_flag = true;
}
if(document.getElementById('contb9') != null){
var navib9 = document.getElementById('contb9');
cont9_flag = true;
}

if (opc=='n1'){
if(cont1_flag == true){
navi1.style.display = "block";
navib1.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_1_on.jpg";
}
if(cont2_flag == true){
navi2.style.display = "none";
navib2.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_2_off.jpg";
}
if(cont3_flag == true){
navi3.style.display = "none";
navib3.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201207/mail_content_sidetab_3_off.jpg";
}
if(cont4_flag == true){
navi4.style.display = "none";
navib4.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_4_off.jpg";
}
if(cont5_flag == true){
navi5.style.display = "none";
navib5.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_5_off.jpg";
}
if(cont6_flag == true){
navi6.style.display = "none";
navib6.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_6_off.jpg";
}
if(cont7_flag == true){
navi7.style.display = "none";
navib7.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_7_off.jpg";
}
if(cont8_flag == true){
navi8.style.display = "none";
navib8.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_n8_off.jpg";
}
if(cont9_flag == true){
navi9.style.display = "none";
navib9.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_n9_off.jpg";
}
} else if(opc=='n2'){
if(cont1_flag == true){
navi1.style.display = "none";
navib1.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_1_off.jpg";
}
if(cont2_flag == true){
navi2.style.display = "block";
navib2.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_2_on.jpg";
}
if(cont3_flag == true){
navi3.style.display = "none";
navib3.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201207/mail_content_sidetab_3_off.jpg";
}
if(cont4_flag == true){
navi4.style.display = "none";
navib4.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_4_off.jpg";
}
if(cont5_flag == true){
navi5.style.display = "none";
navib5.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_5_off.jpg";
}
if(cont6_flag == true){
navi6.style.display = "none";
navib6.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_6_off.jpg";
}
if(cont7_flag == true){
navi7.style.display = "none";
navib7.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_7_off.jpg";
}
if(cont8_flag == true){
navi8.style.display = "none";
navib8.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_n8_off.jpg";
}
if(cont9_flag == true){
navi9.style.display = "none";
navib9.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_n9_off.jpg";
}
}else if(opc=='n3'){
if(cont1_flag == true){
navi1.style.display = "none";
navib1.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_1_off.jpg";
}
if(cont2_flag == true){
navi2.style.display = "none";
navib2.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_2_off.jpg";
}
if(cont3_flag == true){
navi3.style.display = "block";
navib3.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201207/mail_content_sidetab_3_on.jpg";
}
if(cont4_flag == true){
navi4.style.display = "none";
navib4.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_4_off.jpg";
}
if(cont5_flag == true){
navi5.style.display = "none";
navib5.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_5_off.jpg";
}
if(cont6_flag == true){
navi6.style.display = "none";
navib6.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_6_off.jpg";
}
if(cont7_flag == true){
navi7.style.display = "none";
navib7.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_7_off.jpg";
}
if(cont8_flag == true){
navi8.style.display = "none";
navib8.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_n8_off.jpg";
}
if(cont9_flag == true){
navi9.style.display = "none";
navib9.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_n9_off.jpg";
}
}else if(opc=='n4'){
if(cont1_flag == true){
navi1.style.display = "none";
navib1.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_1_off.jpg";
}
if(cont2_flag == true){
navi2.style.display = "none";
navib2.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_2_off.jpg";
}
if(cont3_flag == true){
navi3.style.display = "none";
navib3.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201207/mail_content_sidetab_3_off.jpg";
}
if(cont4_flag == true){
navi4.style.display = "block";
navib4.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_4_on.jpg";
}
if(cont5_flag == true){
navi5.style.display = "none";
navib5.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_5_off.jpg";
}
if(cont6_flag == true){
navi6.style.display = "none";
navib6.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_6_off.jpg";
}
if(cont7_flag == true){
navi7.style.display = "none";
navib7.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_7_off.jpg";
}
if(cont8_flag == true){
navi8.style.display = "none";
navib8.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_n8_off.jpg";
}
if(cont9_flag == true){
navi9.style.display = "none";
navib9.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_n9_off.jpg";
}
}else if(opc=='n5'){
if(cont1_flag == true){
navi1.style.display = "none";
navib1.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_1_off.jpg";
}
if(cont2_flag == true){
navi2.style.display = "none";
navib2.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_2_off.jpg";
}
if(cont3_flag == true){
navi3.style.display = "none";
navib3.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201207/mail_content_sidetab_3_off.jpg";
}
if(cont4_flag == true){
navi4.style.display = "none";
navib4.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_4_off.jpg";
}
if(cont5_flag == true){
navi5.style.display = "block";
navib5.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_5_on.jpg";
}
if(cont6_flag == true){
navi6.style.display = "none";
navib6.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_6_off.jpg";
}
if(cont7_flag == true){
navi7.style.display = "none";
navib7.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_7_off.jpg";
}
if(cont8_flag == true){
navi8.style.display = "none";
navib8.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_n8_off.jpg";
}
if(cont9_flag == true){
navi9.style.display = "none";
navib9.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_n9_off.jpg";
}
}else if(opc=='n6'){
if(cont1_flag == true){
navi1.style.display = "none";
navib1.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_1_off.jpg";
}
if(cont2_flag == true){
navi2.style.display = "none";
navib2.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_2_off.jpg";
}
if(cont3_flag == true){
navi3.style.display = "none";
navib3.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201207/mail_content_sidetab_3_off.jpg";
}
if(cont4_flag == true){
navi4.style.display = "none";
navib4.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_4_off.jpg";
}
if(cont5_flag == true){
navi5.style.display = "none";
navib5.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_5_off.jpg";
}
if(cont6_flag == true){
navi6.style.display = "block";
navib6.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_6_on.jpg";
}
if(cont7_flag == true){
navi7.style.display = "none";
navib7.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_7_off.jpg";
}
if(cont8_flag == true){
navi8.style.display = "none";
navib8.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_n8_off.jpg";
}
if(cont9_flag == true){
navi9.style.display = "none";
navib9.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_n9_off.jpg";
}
}else if(opc=='n7'){
if(cont1_flag == true){
navi1.style.display = "none";
navib1.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_1_off.jpg";
}
if(cont2_flag == true){
navi2.style.display = "none";
navib2.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_2_off.jpg";
}
if(cont3_flag == true){
navi3.style.display = "none";
navib3.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201207/mail_content_sidetab_3_off.jpg";
}
if(cont4_flag == true){
navi4.style.display = "none";
navib4.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_4_off.jpg";
}
if(cont5_flag == true){
navi5.style.display = "none";
navib5.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_5_off.jpg";
}
if(cont6_flag == true){
navi6.style.display = "none";
navib6.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_6_off.jpg";
}
if(cont7_flag == true){
navi7.style.display = "block";
navib7.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_7_on.jpg";
}
if(cont8_flag == true){
navi8.style.display = "none";
navib8.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_n8_off.jpg";
}
if(cont9_flag == true){
navi9.style.display = "none";
navib9.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_n9_off.jpg";
}
}else if(opc=='n8'){
if(cont1_flag == true){
navi1.style.display = "none";
navib1.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_1_off.jpg";
}
if(cont2_flag == true){
navi2.style.display = "none";
navib2.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_2_off.jpg";
}
if(cont3_flag == true){
navi3.style.display = "none";
navib3.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201207/mail_content_sidetab_3_off.jpg";
}
if(cont4_flag == true){
navi4.style.display = "none";
navib4.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_4_off.jpg";
}
if(cont5_flag == true){
navi5.style.display = "none";
navib5.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_5_off.jpg";
}
if(cont6_flag == true){
navi6.style.display = "none";
navib6.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_6_off.jpg";
}
if(cont7_flag == true){
navi7.style.display = "none";
navib7.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_7_off.jpg";
}
if(cont8_flag == true){
navi8.style.display = "block";
navib8.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_n8_on.jpg";
}
if(cont9_flag == true){
navi9.style.display = "none";
navib9.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_n9_off.jpg";
}
}else if(opc=='n9'){
if(cont1_flag == true){
navi1.style.display = "none";
navib1.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_1_off.jpg";
}
if(cont2_flag == true){
navi2.style.display = "none";
navib2.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_2_off.jpg";
}
if(cont3_flag == true){
navi3.style.display = "none";
navib3.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201207/mail_content_sidetab_3_off.jpg";
}
if(cont4_flag == true){
navi4.style.display = "none";
navib4.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_4_off.jpg";
}
if(cont5_flag == true){
navi5.style.display = "none";
navib5.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_5_off.jpg";
}
if(cont6_flag == true){
navi6.style.display = "none";
navib6.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_6_off.jpg";
}
if(cont7_flag == true){
navi7.style.display = "none";
navib7.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_7_off.jpg";
}
if(cont8_flag == true){
navi8.style.display = "none";
navib8.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_n8_off.jpg";
}
if(cont9_flag == true){
navi9.style.display = "block";
navib9.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_n9_on.jpg";
}
}
}


//navi tab
function navi_tab(opc){
var cont6_flag = false;
var cont7_flag = false;
var navi1 = document.getElementById('content1');
var navi2 = document.getElementById('content2');
var navi3 = document.getElementById('content3');
var navi4 = document.getElementById('content4');
var navi5 = document.getElementById('content5');
var navi6 = document.getElementById('content6');
var navi7 = document.getElementById('content7');
var navib1 = document.getElementById('contb1');
var navib2 = document.getElementById('contb2');
var navib3 = document.getElementById('contb3');
var navib4 = document.getElementById('contb4');
var navib5 = document.getElementById('contb5');
if(document.getElementById('contb6') != null){
var navib6 = document.getElementById('contb6');
cont6_flag = true;
}
if(document.getElementById('contb7') != null){
var navib7 = document.getElementById('contb7');
cont7_flag = true;
}
if (opc=='n1'){
navi1.style.display = "block";
navi2.style.display = "none";
navi3.style.display = "none";
navi4.style.display = "none";
navi5.style.display = "none";

navib1.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_1_on.jpg";
navib2.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_2_off.jpg";
navib3.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201207/mail_content_sidetab_3_off.jpg";
navib4.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_4_off.jpg";
navib5.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_5_off.jpg";
//alert("navib6.src : " );
if(cont6_flag == true){
navi6.style.display = "none";
navib6.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_6_off.jpg";
}
if(cont7_flag == true){
navi7.style.display = "none";
navib7.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_7_off.jpg";
}
} else if(opc=='n2'){
navi1.style.display = "none";
navi2.style.display = "block";
navi3.style.display = "none";
navi4.style.display = "none";
navi5.style.display = "none";

navib1.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_1_off.jpg";
navib2.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_2_on.jpg";
navib3.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201207/mail_content_sidetab_3_off.jpg";
navib4.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_4_off.jpg";
navib5.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_5_off.jpg";

if(cont6_flag == true){
navi6.style.display = "none";
navib6.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_6_off.jpg";
}
if(cont7_flag == true){
navi7.style.display = "none";
navib7.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_7_off.jpg";
}
}else if(opc=='n3'){
navi1.style.display = "none";
navi2.style.display = "none";
navi3.style.display = "block";
navi4.style.display = "none";
navi5.style.display = "none";

navib1.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_1_off.jpg";
navib2.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_2_off.jpg";
navib3.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201207/mail_content_sidetab_3_on.jpg";
navib4.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_4_off.jpg";
navib5.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_5_off.jpg";

if(cont6_flag == true){
navi6.style.display = "none";
navib6.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_6_off.jpg";
}
if(cont7_flag == true){
navi7.style.display = "none";
navib7.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_7_off.jpg";
}
}else if(opc=='n4'){
navi1.style.display = "none";
navi2.style.display = "none";
navi3.style.display = "none";
navi4.style.display = "block";
navi5.style.display = "none";

navib1.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_1_off.jpg";
navib2.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_2_off.jpg";
navib3.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201207/mail_content_sidetab_3_off.jpg";
navib4.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_4_on.jpg";
navib5.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_5_off.jpg";

if(cont6_flag == true){
navi6.style.display = "none";
navib6.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_6_off.jpg";
}
if(cont7_flag == true){
navi7.style.display = "none";
navib7.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_7_off.jpg";
}
}else if(opc=='n5'){
navi1.style.display = "none";
navi2.style.display = "none";
navi3.style.display = "none";
navi4.style.display = "none";
navi5.style.display = "block";

navib1.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_1_off.jpg";
navib2.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_2_off.jpg";
navib3.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201207/mail_content_sidetab_3_off.jpg";
navib4.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_4_off.jpg";
navib5.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_5_on.jpg";

if(cont6_flag == true){
navi6.style.display = "none";
navib6.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_6_off.jpg";
}
if(cont7_flag == true){
navi7.style.display = "none";
navib7.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_7_off.jpg";
}
}else if(opc=='n6'){
navi1.style.display = "none";
navi2.style.display = "none";
navi3.style.display = "none";
navi4.style.display = "none";
navi5.style.display = "none";

navib1.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_1_off.jpg";
navib2.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_2_off.jpg";
navib3.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201207/mail_content_sidetab_3_off.jpg";
navib4.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_4_off.jpg";
navib5.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_5_off.jpg";

if(cont6_flag == true){
navi6.style.display = "block";
navib6.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_6_on.jpg";
}
if(cont7_flag == true){
navi7.style.display = "none";
navib7.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_7_off.jpg";
}

}else if(opc=='n7'){
navi1.style.display = "none";
navi2.style.display = "none";
navi3.style.display = "none";
navi4.style.display = "none";
navi5.style.display = "none";

navib1.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_1_off.jpg";
navib2.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_2_off.jpg";
navib3.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201207/mail_content_sidetab_3_off.jpg";
navib4.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_4_off.jpg";
navib5.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_5_off.jpg";

if(cont6_flag == true){
navi6.style.display = "none";
navib6.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_6_off.jpg";
}
if(cont7_flag == true){
navi7.style.display = "block";
navib7.src = "http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_7_on.jpg";
}
}
}



function lay01(HID,OID){
var hlay = document.getElementById(HID);
var olay = document.getElementById(OID);
hlay.style.display = 'none';
olay.style.display = 'block';
}

function lay02(OID,HID1,HID2){
var hlay1 = document.getElementById(HID1);
var hlay2 = document.getElementById(HID2);
var olay = document.getElementById(OID);
hlay1.style.display = 'none';
hlay2.style.display = 'none';
olay.style.display = 'block';
}

//[PM]이번달이용서비스상세내역
function sevi_dtil(opc, num){
var scontHead = 'content3';
var stabHead = 's_tab';

var thisScontId = scontHead;
var thisTabId = stabHead+opc+'_'+num; //ex) s_tab02_1
var max = document.getElementById(thisScontId).getElementsByTagName('div');
for(i=0;i<max.length;i++){
var thisId = max[i].id;

if(thisId.indexOf(stabHead)>=0){
if(thisId == thisTabId){
document.getElementById(thisId+'_tab').style.color = '#8d224e';
document.getElementById(thisId).style.display = 'block';//보임
}else{
document.getElementById(thisId+'_tab').style.color = '#979797';
document.getElementById(thisId).style.display = 'none';//가림
}
}
}
}
function lay04(OID,HID){
var hlay = document.getElementById(HID);
var olay = document.getElementById(OID);
hlay.style.display = 'none';
olay.style.display = 'block';
}

function lay05_ori(OID,HID1,HID2,HID3){
var hlay1 = document.getElementById(HID1);
var hlay2 = document.getElementById(HID2);
var hlay3 = document.getElementById(HID3);
var olay = document.getElementById(OID);
hlay1.style.display = 'none';
hlay2.style.display = 'none';
hlay3.style.display = 'none';
olay.style.display = 'block';
}

function lay05(OID,HID1,HID2,HID3){
var hlay1;
var hlay2;
var hlay3;
var olay;

if(document.getElementById(HID1) != null){
hlay1 = document.getElementById(HID1);
hlay1.style.display = 'none';
}
if(document.getElementById(HID2) != null){
hlay2 = document.getElementById(HID2);
hlay2.style.display = 'none';
}
if(document.getElementById(HID3) != null){
hlay3 = document.getElementById(HID3);
hlay3.style.display = 'none';
}
if(document.getElementById(OID) != null){
olay = document.getElementById(OID);
olay.style.display = 'block';
}
}

//특정부분출력 스크립트 START//-->
var print_id;

function printDiv (obj) {
print_id=obj; //프린트할 영역 ID를 전역 변수에 입력합니다.

if (window.print) {
window.onbeforeprint = beforeDivs;//프린트 전에 시행하는 메소드
window.onafterprint = afterDivs;  //프린트 후 복구 시행하는 메소드
window.print(); //프린트 실행
}
}

// id영역을 지정한 objSelection 영역으로 이동하고 전체를 감싸는 objContents는 안보이게 처리합니다.
function beforeDivs () {
if (document.all) {
//전체영역은 안보이게 처리
document.getElementById('objContents').style.display = 'none';

//objSelection에 프린트할 영역을 입력해서 프린트할 부분만 보이게 처리
document.getElementById('objSelection').innerHTML = document.getElementById(print_id).innerHTML;
}
}

//원래대로 복구합니다.
function afterDivs () {
if (document.all) {
document.getElementById('objContents').style.display = 'block';
document.getElementById('objSelection').innerHTML = "";
}
}
//특정부분출력 스크립트 END -->
</script>
<style type="text/css">
* { margin: 0; padding: 0; font-family: Dotum, Arial, Verdana, sans-serif; font-size: 12px; line-height: 16px; color:#777; }
body { margin: 0; padding: 0; font-family: Dotum, Arial, Verdana, sans-serif; font-size: 12px; line-height: 16px; color:#777; background: #FFF; }

#acount { background: #FFF; }
#content { background: #FFF; }

.sectionTab { margin: 0 0 30px 0; width: 100%; height: 28px; border-bottom: 1px solid #D7D7D7; overflow: hidden; }
.sectionTab li { float: left; display: inline; list-style: none}

.s_tab02 ul { width: 100%; list-style: none; overflow: hidden; }
.s_tab02 ul li { float: left; display: inline; list-style: none; }

.chargeage { position: relative; }

.datatable1 { width: 100%; border-collapse: collapse; border-spacing: 0; }
.datatable1 tr td { padding:10px 13px 10px 13px; border-bottom: 1px solid #e4e4e4; }
.datatable1 tr td.title { padding:10px 13px 10px 13px; border-bottom: 1px solid #e4e4e4; font-weight: bold; color: #555; }
.datatable1 tr th.title { padding: 10px 0; border-top: 1px solid #e4e4e4; border-bottom: 1px solid #c80752; border-left: 0px; text-align: center; }

.datatable2 { width: 100%; border-collapse: collapse; border-spacing: 0; }
.datatable2 tr td { padding:10px 13px 10px 13px; border-bottom: 1px solid #e4e4e4; border-left: 1px solid #e4e4e4; text-align: center; }
.datatable2 tr td.first { border-left: 0!important; }
.datatable2 tr th.title { padding: 10px 0; border-top: 1px solid #e4e4e4; border-bottom: 1px solid #c80752; border-left: 0px; text-align: center; }
.datatable2 tr th { padding: 10px 0; border-top: 1px solid #e4e4e4; border-bottom: 1px solid #e4e4e4; border-left: 0px; text-align: center; }
.datatable2 tr td.price { text-align: right; }
.datatable2 tr td.txt { text-align: left; }
.datatable2 tr th.Lbord { padding: 10px 0; border-top: 1px solid #e4e4e4; border-left: 1px solid #e4e4e4; text-align: center; }
.datatable2 tr td.txtleft { padding:10px 13px 10px 13px; border-bottom: 1px solid #e4e4e4; border-left: 1px solid #e4e4e4; text-align: left; }
.datatable2 tr td.tline { padding:10px 13px 10px 13px;border-top: 1px solid #e4e4e4; border-bottom: 1px solid #e4e4e4; border-left: 1px solid #e4e4e4;}
.datatable2 tr td.soek { padding:10px 3px 10px 3px; border-bottom: 1px solid #e4e4e4; border-left: 1px solid #e4e4e4; text-align: center; }
.datatable2 tr td.txtright { border-right: 1px solid #e4e4e4; }

.datatable3 { width: 100%; border-collapse: collapse; border-spacing: 0; }
.datatable3 tr td { padding:8px 13px 6px 13px; border-bottom: 1px solid #e4e4e4; border-left: 1px solid #e4e4e4; }
.datatable3 tr td.first { border-left: 0!important; }
.datatable3 tr th.title {text-align: center;  padding: 10px 0; border-top: 1px solid #e4e4e4; border-bottom: 1px solid #c80752; border-left: 0px; }
.datatable3 tr td.price { text-align: right; }
.datatable3 tr td.txtCt { text-align: center; }
.datatable3 tr.blue { background: #f8f8f8; }
.datatable3 tr.blue2 { background: #f8f8f8; font-size: 14px; font-weight: bold;}
.datatable3 tr td.blue3 { background: #f8f8f8; font-size: 14px; font-weight: bold;}
.datatable3 tr.pink { background: #f7f0f3; }
.datatable3 .bg01 {background-color:#F7FAF6;}

.datatable4 { width: 100%; border-collapse: collapse; border-spacing: 0; }
.datatable4 tr th.title { padding: 10px 0; border-top: 1px solid #e4e4e4; border-bottom: 1px solid #e4e4e4; text-align: center; }
.datatable4 tr th.titlesub { padding: 10px 0; border-top: 1px solid #e4e4e4; border-bottom: 1px solid #c80752; border-left: 1px solid #e4e4e4; text-align: center; }
.datatable4 tr th.first { border-left: 0!important; }
.datatable4 tr td { padding:10px 13px 10px 13px; border-bottom: 1px solid #e4e4e4; border-left: 1px solid #e4e4e4; }
.datatable4 tr td.BLnone { padding:10px 7px 10px 7px; border-bottom: 0px solid #e4e4e4; border-left: 0px solid #e4e4e4; }
.datatable4 tr td.Bnone { padding:10px 7px 10px 7px; border-bottom: 0px solid #e4e4e4; border-left: 1px solid #e4e4e4; }
.datatable4 tr td.Lnone { padding:10px 7px 10px 7px; border-bottom: 1px solid #e4e4e4; border-left: 0px solid #e4e4e4; }
.datatable4 tr td.price { text-align: right; }
.datatable4 tr td.price strong.black { color: #555; }
.datatable4 tr td strong.black { color: #555; }
.datatable4 tr.pink { background: #fadde9; }
.datatable4 tr.total { background: #b3c7ef; }

.datatable5 { border-collapse: collapse; border-spacing: 0; border-top: 1px solid #e4e4e4; }
.datatable5 tbody tr.blue { background: #eff2f8; }
.datatable5 tbody tr.red { background: #f7f0f3; }
.datatable5 tbody tr th { padding: 10px 7px 10px 7px; color:#5f5f5f; border-bottom: 1px solid #e4e4e4; text-align: left; }
.datatable5 tbody tr th .inner { padding-left: 15px; }
.datatable5 tbody tr td { padding: 10px 7px 10px 7px; border-bottom: 1px solid #e4e4e4; border-left: 1px solid #e4e4e4; color:#555; }
.datatable5 tbody tr td.price { padding: 10px 7px 10px 7px; border-bottom: 1px solid #e4e4e4; border-left: 1px solid #e4e4e4; color:#555; text-align: right; }
.datatable5 tbody tr td.brd_none { padding: 0; height: 15px; border-bottom: 0px solid #e4e4e4; border-left: 0px solid #e4e4e4; }
.datatable5 tfoot tr { background: #bdcce8; }
.datatable5 tfoot tr th { padding: 10px 0 10px 13px; color:#33459a; font-size: 14px; font-weight: bold; border-bottom: 1px solid #e4e4e4; border-top: 1px solid #e4e4e4; text-align: left; }
.datatable5 tfoot tr td { padding: 10px 0 10px 13px; color:#33459a; font-size: 14px; font-weight: bold; border-bottom: 1px solid #e4e4e4; border-left: 1px solid #e4e4e4; border-top: 1px solid #e4e4e4; }

.datatable6 { width: 100%; border-collapse: collapse; border-spacing: 0; }
.datatable6 tr td { padding:10px 13px 10px 13px; border-bottom: 1px solid #d5efda; border-left: 1px solid #d5efda; text-align: center; }
.datatable6 tr td.first { border-left: 0!important; }
.datatable6 tr th.title { padding: 10px 0; border-top: 1px solid #d5efda; border-bottom: 1px solid #359649; border-left: 0px; font-size: 12px; }
.datatable6 tr td.price { text-align: right; }
.datatable6 tr td.txtCt { text-align: center; }
.datatable6 tr.blue { background: #f8f8f8; }
.datatable6 tr.pink { background: #f7f0f3; }

.datatable7 { width: 100%; border-collapse: collapse; border-spacing: 0; }
.datatable7 tr td.Lnone { border-left: 0!important; }
.datatable7 tr td { padding:10px 8px 10px 8px; border-bottom: 1px solid #d1d1d1; border-left: 1px solid #d1d1d1; text-align: center; font-size: 11px; }
.datatable7 tr td.first { border-left: 0!important; }
.datatable7 tr th.title { padding:10px 8px 10px 8px; border-top: 1px solid #d1d1d1; border-bottom: 1px solid #b1b1b1; border-left: 1px solid #d1d1d1; font-size: 11px; background: #737373; color: #fff; }
.datatable7 tr th.titleFirst { padding:10px 8px 10px 8px; border-top: 1px solid #d1d1d1; border-bottom: 1px solid #b1b1b1; border-left: 0px solid #d1d1d1; font-size: 11px; background: #737373; color: #fff; }
.datatable7 tr td.price { text-align: right; }
.datatable7 tr td.txtCt { text-align: center; }
.datatable7 tr.blue { background: #bdbcbc; }
.datatable7 tr.pink { background: #f7f0f3; }

.table01 { border-top:1px solid #E4E4E4; width:100%; margin:0 0 68px 0; border-collapse: collapse; }
.table01 th { border-bottom:1px solid #C80752; padding:8px 0; }
.table01 td { border-bottom:1px solid #E4E4E4; border-left:1px solid #E4E4E4; color:#979797; padding:6px 12px 6px 0; text-align:right;  font-size:12px; }
.table01 td.first {border-bottom:1px solid #E4E4E4;border-left:0 none;padding:6px 0 6px 20px;text-align:left;color:#979797; font-size:12px;}
.table01 td.btn {border-bottom:1px solid #E4E4E4;border-left:0 none;padding:6px 0;text-align:center;}
.table01 .bg01 {background-color:#F7FAF6;}
.table01 .bg01 td { border-bottom:1px solid #E4E4E4; border-left:1px solid #E4E4E4; color:#979797; padding:6px 12px 6px 0; text-align:right;  font-size:12px; }
.table01 .bg01 td.first { border-bottom:1px solid #E4E4E4; border-left:0 none;  padding:6px 0 6px 20px; text-align:left; color:#979797;  font-size:12px; }
.table01 .bg01 td.btn { border-bottom:1px solid #E4E4E4; border-left:0 none; padding:6px 0; text-align:center; }
.table01 .bg01 td.innertd { padding: 0pt;  border: 0pt none;  background-color: rgb(247, 250, 246); }
.table01 .bg01 td.innertd2 { padding: 0pt;  border: 0pt none;  background-color: rgb(245, 248, 249); }
.table01 .bg01 td.innertd3 { padding: 0pt;  border: 0pt none;  background-color: rgb(253, 248, 245); }
.table01 .bg02 {background-color:#F5F8F9;}
.table01 .bg02 td { border-bottom:1px solid #E4E4E4; border-left:1px solid #E4E4E4; color:#979797; padding:6px 12px 6px 0; text-align:right;  font-size:12px; }
.table01 .bg02 td.first {border-bottom:1px solid #E4E4E4;border-left:0 none;padding:6px 0 5px 20px;text-align:left;color:#979797; font-size:12px;}
.table01 .bg02 td.btn {border-bottom:1px solid #E4E4E4;border-left:0 none;padding:6px 0;text-align:center;}
.table01 .bg03 {background-color:#FDF8F5;}
.table01 .bg03 td {border-bottom:1px solid #E4E4E4;border-left:1px solid #E4E4E4;color:#979797;padding:6px 12px 6px 0; text-align:right; font-size:12px;}
.table01 .bg03 .first {border-bottom:1px solid #E4E4E4; border-left:0 none;padding:6px 0 6px 20px;text-align:left;color:#979797; font-size:12px;}
.table01 .bg03 .btn {border-left:0 none;padding:6px 0;text-align:center;border-bottom:1px solid #E4E4E4;}
.table01 .total {background-color:#F7F0F3;}
.table01 .total .first {border-bottom:1px solid #E4E4E4;border-left:0 none;padding:6px 0 6px 20px;text-align:left;color:#979797; font-size:12px;}
.table01 .total .first .txt01 {font-size:14px;color:#5f5f5f;}
.table01 .total .btn {border-bottom:1px solid #E4E4E4;border-left:0 none;padding:6px 0;text-align:center;color:#979797;}
.table01 .total td {border-bottom:1px solid #E4E4E4;border-left:1px solid #E4E4E4;color:#979797;padding:6px 12px 6px 0;text-align:right;}
.table01 .total td .point {color:#8D224E; font-size:12px;}
.table01 tr.pink { background: #f7f0f3; }

.table02 {
border-top:0 none;
width:100%;
border-collapse: collapse;
}
.table02 tr td {
border-bottom:1px solid #E4E4E4;
border-left:1px solid #E4E4E4;
color:#979797;
padding:8px 12px 8px 0;
text-align:right;
font-size:12px;
}

.table02 tr td.first1 {
border-bottom:1px solid #E4E4E4;
border-left:0 none;
padding:8px 0 8px 20px;
text-align:left;
color:#979797;
}
.table02 tr td.first1 strong {
color: rgb(125, 170, 137);
padding-left: 5px;
font-size:12px;
}
.table02 tr td.btn {
border-bottom:1px solid #E4E4E4;
border-left:0 none;
padding:8px 0;
text-align:center;
}
.table02 tr td.bff {
background:none repeat scroll 0 0 #FFFFFF;
border-left:0 none;padding:8px 0 8px 20px;
text-align:left;
border-bottom:1px solid #E4E4E4;
font-size:12px;
}

.datatabel3 {
border-top:1px solid #c80752;
margin:0 0 10px 0;
border-collapse: collapse;
width: 100%;
}
.datatabel3 th {
padding:0 0 0 22px;
border-bottom:1px solid #e4e4e4;
text-align:left;
height:35px;
font-size:12px;
}
.datatabel3 td {
padding:0 0 0 22px;
border-bottom:1px solid #e4e4e4;
border-left:1px solid #e4e4e4;
height:35px;
font-size:12px;
}
.datatabel3 td.price {
padding:0 20px 0 0;
text-align:right;
}
.datatabel3 .total .first {
background:#f7f0f3;
border-right:1px solid #e4e4e4;
border-left:0;
border-bottom:1px solid #e4e4e4;
padding:0 0 0 21px;
height:35px;
font-weight:bold;
font-size:12px;
color:#696969;
}
.datatabel3 .total .price {
background:#f7f0f3;
border-bottom:1px solid #e4e4e4;
padding:0 23px 0 0;
height:35px;
text-align:right;
font-size:12px;
font-weight:bold;
color:#8d224e;
}

#navi_tab { margin: 0 0 0 31px; padding: 0; width: 129px; }
#navi_tab ul { margin: 0; padding: 0; list-style: none; }
#navi_tab ul li { margin: 0; padding: 0; list-style: none; }
#navi_tab ul li.categori { position:relative; width:129px; }
#navi_tab ul li.categori span { position:absolute; top:30px; left:25px; color:#fff; font-size:12px; font-weight:bold; }

.graphbox { background:url(http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/cont_2_box_graph.gif) no-repeat left top; height:188px; }
.graphbox .graphtable td { height:165px; text-align:center; font-size:12px; font-weight:bold; color:#a40282; }
.graphbox .graphtable td span {color:#495aad;}
.graphbox .graphtable tr.item td { height:40px; text-align:center; font-size:12px; font-weight:bold; color:#666666;}

.acount-wrap { width: 100%; border-collapse: collapse; border-spacing: 0; }

.s_tab02 ul { margin:0;  padding:0; width:640px; overflow:hidden;margin-top:20px;}
.s_tab02 ul li { list-style:none;  float:left;}

.event-box .title { margin: 0 0 20px 0; }
.event-box .event-img { margin: 0 0 48px 0; }

.conducttable td.title { padding: 0 0 20px 0; }
.conducttable td.textcontent { padding: 0 0 50px 0; }
.conducttable td.textcontent p { background: url(http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/cont_bullet.gif) no-repeat 0 2px; margin: 0; padding: 0 0 14px 8px; line-height: 14px; color: #8e8e8e; font-size: 12px; }
.conducttable td.textcontent p span { line-height: 14px; color: #8e8e8e; font-size: 12px; }
.conducttable td.textcontent .notice { height: 100px; overflow: auto; }

/* 20120113 추가 */
ul.default-list02 li {
background: url("http://image.uplus.co.kr/lgtel/images/common/bl/bl_square05.gif") no-repeat scroll 0 5px transparent;
font-size: 11px;
line-height: 1.3;
margin-top: 5px;
padding-left: 5px;
list-style: none outside none;
}
/* 20120113 추가 end */

.normallist li {float:left;padding:0 0 22px 22px;list-style:none;}
.normallist li.fir {float:left;padding-left:0;}
</style>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=2.0, user-scalable=yes" />
</head>

<body>
<div id="PC" style="display:none; width:0px; overflow:hidden;">
<div id="objContents">
<table width="100%" cellpadding="0" cellspacing="0" border="0" id="acount">
<tr>
<td style="padding: 0 0 0 30px;"><!-- header -->
<table width="709" cellpadding="0" cellspacing="0" border="0">
<tr>
<td width="26" valign="top" style="background: url(http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/header_boxLine_left.gif) repeat-y;   left: top;"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/header_boxLine_left.gif" border="0" alt=""></td>
<td width="654" valign="top"  style="background: url(http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/header_bg.gif) repeat-x;   left: top;">
<table width="654" cellpadding="0" cellspacing="0" border="0">
<tr>
<td height="27"></td>
</tr>
<tr>
<td width="411" align="right"><a href="http://58.150.244.95:80/Check.html?TV9JRD0yODMwMDExODcyOTBfMjkxOTAwMDM=&U1RZUEU9QVVUTw==&TElTVF9UQUJMRT1BVVRPMTIw&UE9TVF9JRD0yMDE0MDkxMl83NA==&VEM9MjAxNDA5MTk=&U0VSVkVSX0lEPTAx&S0lORD1D&Q0lEPTAwMQ==&URL=http://www.uplus.co.kr/" target="_blank()" onfocus="this.blur()"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/header_logo.gif" border="0" alt=""></a></td>
<td width="172" align="right" style="padding-top: 7px; font-size: 18px; font-weight: bold; letter-spacing: -1px;">2014. 09</td>
<td width="100" align="right"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/header_text01.gif" border="0" alt=""></td>
</tr>
</table>
</td>
<td width="29" valign="top"  style="background: url(http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/header_boxLine_right.gif) repeat-y;   left: top;"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/header_boxLine_right.gif" border="0" alt=""></td>
</tr>
<tr>
<td colspan="3"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/header_boxLine_btm.gif" border="0" alt=""></td>
</tr>
</table>
<!-- //header -->
<!-- balnk -->
<table width="100%" cellpadding="0" cellspacing="0" border="0">
<tr>
<td height="30"></td>
</tr>
</table>
<!-- //balnk -->
<!-- contrainer -->
<table width="841" cellpadding="0" cellspacing="0" border="0">
<tr>
<td colspan="3"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/contrainer_boxLine_top.gif" border="0" alt=""></td>
</tr>
<tr>
<td width="26"  valign="top" style="background: url(http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/contrainer_boxLine_left.gif) repeat-y;   left: top;"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/contrainer_boxLine_left.gif" border="0" alt=""></td>
<!-- content -->
<td width="640" valign="top" id="content">
<!-- print START -->
<div id="print01_yo_area" >
<!-- date 시작 -->
<!-- 청구요약 -->
<div id="content1"  style="display: block;">








<table width="640" cellpadding="0" cellspacing="0" border="0">
<tr>
<td height="60" align="center" style="padding-top: 7px; font-size: 18px; font-weight: bold;"><span style="font-size: 18px; color: #700459;">윤철수</span> 고객님의 <span style="font-size: 18px; color: #700459;">2014년 09월</span> 청구서 입니다.</td>
</tr>
<tr>
<td height="2" style="background: url(http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_dot.gif) repeat-x;   left top;">&nbsp;</td>
</tr>
<tr>
<td style="padding: 10px 0 10px 0;">


</br>
<div style="font-size: 14px; font-weight: bold; text-align:center;">이번달 요금은 <span style="font-size: 16px; color: red;">09</span>월 <span style="font-size: 16px; color: red; ">26</span>일부터 <span style="font-size: 16px; color: red; ">우리은행 </span>계좌에서 출금될 예정입니다.</div>
</br></br>

<!-- BS 는 8월청구수정 미반영건 "일 부터 ****은행에서 출금 "-->



<div style="text-align:right;"><a href="#" onclick="printDiv('print01_yo_area'); return false;"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/btn_print.jpg" border="0" alt=""></a></div>
</td>
</tr>
</table>
<table width="100%" cellpadding="0" cellspacing="0" border="0" style="table-layout: fixed;">
<tr>
<td><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201207/title_1.jpg" border="0" alt=""></td>
<td><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201207/title_2.jpg" border="0" alt=""></td>
<td><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201207/title_3.jpg" border="0" alt=""></td>
</tr>
<tr>
<td height="62" style="background: url(http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_charge_1.jpg) no-repeat left top;" valign="top">
<table width="155" cellpadding="0" cellspacing="0" border="0" style="margin: 17px 0 0 0;">
<tr>
<td align="right" style="padding-top: 7px; font-size: 21px; font-weight: bold; color: #5b5b5b;">42,682</td>
</tr>
</table>
</td>
<td height="62" style="background: url(http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_charge_1.jpg) no-repeat left top;" valign="top">
<table width="155" cellpadding="0" cellspacing="0" border="0" style="margin: 17px 0 0 0;">
<tr>
<td align="right" style="padding-top: 7px; font-size: 21px; font-weight: bold; color: #5b5b5b;">-8,322</td>
</tr>
</table>
</td>
<td height="62" style="background: url(http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_charge_2.jpg) no-repeat left top;" valign="top">
<table width="155" cellpadding="0" cellspacing="0" border="0" style="margin: 17px 0 0 0;">
<tr>
<td align="right" style="padding-top: 7px; font-size: 21px;font-weight: bold;  color: #c40452;">34,360</td>
</tr>
</table>
</td>
</tr>
</table>

<table width="100%" cellpadding="0" cellspacing="0" border="0" style="margin: 20px 0 0 0; table-layout: fixed;">
<tr>
<td><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/text_content_8.gif" border="0" alt=""></td>
<!--// 2014.08 납기일 이미지 추가 노승훈 시작 -->

<td>
<div style="float:right;">
<table width="220" cellpadding="0" cellspacing="0" border="0" style="margin-top:15px;">
<tr>

<td style="width:400px; font-size: 17px;color:#5e5e5e;font-weight: bold;line-height:30px;border-bottom:1px solid #cbcbcb;">

<span style="font-size:17px;font-weight:bold;color:#5e5e5e;">납기일 2014년 09월 30일</span>

</td>
</tr>
<tr><td  style="padding:8px 0 0 0;">※ 납기일이 지나서 요금을 납부하시면 <br />&nbsp;&nbsp;&nbsp;&nbsp;<strong>2% 연체가산금</strong>이 <strong>다음달 요금에 <br />&nbsp;&nbsp;&nbsp;추가되어 청구</strong>됩니다.</td></tr>
</table>
</div>
</td>

<!--// 2014.08 납기일 이미지 추가 노승훈 끝 -->
</tr>

<!-- MVNO 사업자 문구 추가 -->

</table>
<!-- 201308 수정 -->
<!-- 상세 납부금액 -->

<br/><br/>
<!-- //상세 납부금액 -->
<!-- 이용중인 서비스 -->

<table width="100%" cellpadding="0" cellspacing="0" border="0" style="margin: 50px 0 0 0; table-layout: fixed;">
<tr>
<td><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/title_4.jpg" border="0" alt=""> <img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/btn_checkList.jpg" border="0" onclick="navi_tab('n2');" style="cursor: pointer; margin-left: 10px;" alt="청구내역 바로가기"></td>
<td align="right" valign="bottom">[VAT 포함]</td>
</tr>
</table>
<table class="table01" style="margin: 10px 0 0 0; table-layout: fixed;">
<tbody>
<tr>
<th width="20%"><img alt="" src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/table01_01.gif"></th>
<th width=""><img alt="" src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/table14_01.gif"></th>
<th width=""><img alt="" src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/table14_02.gif"></th>
<th width=""><img alt="" src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/table14_03.gif"></th>
</tr>














<!-- 04월 청구항목 표기 변경-->


























































































<tr class="bg01">
<td class="first"><strong>U+ 인터넷</strong></td>
<td>36,000원</td>
<td>-7,800원</td>
<td>28,200원</td>
</tr>



































































































































































































<tr class="bg01">
<td class="first"><strong>U+ 070</strong></td>
<td>3,558원</td>
<td>0원</td>
<td>3,558원</td>
</tr>


<tr class="bg01">
<td class="first"><strong>세금 및 공통요금</strong></td>
<td>3,124원</td>
<td>-522원</td>
<td>2,602원</td>
</tr>




<tr class="pink">
<td class="first"><strong>합계</strong></td>
<td>42,682원</td>
<td>-8,322원</td>
<td>34,360원</td>
</tr>
</tbody>
</table>

<!-- //이용중인 서비스 -->
<!-- 4개월간 사용패턴 -->
<!-- 그래프 시작 -->









<table width="100%" cellpadding="0" cellspacing="0" border="0" style="margin: 50px 0 0 0; table-layout: fixed;">
<tr>
<td><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/title_6.gif" alt=""></td>
<td align="right" valign="bottom">[VAT포함]</td>
</tr>
</table>
<table width="100%" cellpadding="0" cellspacing="0" border="0" style="margin: 10px 0 0 0;">
<tr>
<td><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/cont_2_box_top_7.gif" alt=""></td>
</tr>
<tr>
<td style="padding: 0 15px; background: url(http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/cont_2_box_mid.gif) repeat-y;  ;   left top;">
<table width="100%" cellpadding="0" cellspacing="0" border="0">
<tr>
<td height="181" style="padding: 0 15px; background: url(http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/cont_2_box_graph.gif) no-repeat left top;" valign="bottom">
<table width="100%" cellpadding="0" cellspacing="0" border="0" style="table-layout: fixed;">
<tr>

<td align="center" valign="bottom" style="font-weight: bold; color: #d7286f;">32,870원<br>
<img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/cont_2_box_graphbar.gif" width="25" height="133.92898719441212" alt="" />
</td>


<td align="center" valign="bottom" style="font-weight: bold; color: #d7286f;"> 32,940원<br>
<img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/cont_2_box_graphbar.gif" width="25" height="134.21420256111756" alt="" />
</td>


<td align="center" valign="bottom" style="font-weight: bold; color: #d7286f;"> 34,160원<br>
<img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/cont_2_box_graphbar.gif" width="25" height="139.1850989522701" alt="" />
</td>


<td align="center" valign="bottom" style="font-weight: bold; color: #d7286f;"> 34,360원<br>
<img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/cont_2_box_graphbar.gif" width="25" height="140.0" alt="" />
</td>

</tr>
<tr>

<td height="30" align="center"><strong>2014년 06월</strong></td>


<td height="30" align="center"><strong>2014년 07월</strong></td>


<td height="30" align="center"><strong>2014년 08월</strong></td>


<td height="30" align="center"><strong>2014년 09월</strong></td>

</tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
<tr>
<td><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/cont_2_box_btm.gif" alt=""></td>
</tr>
</table>

<!-- //4개월간 사용패턴 -->
<!-- 서비스 약정기간 -->














<!--인터넷 약정 만료일 문구 표기_201307추가-->


<!-- //서비스 약정기간-->

</div>
<!-- //청구요약 -->
<!-- 청구내역 -->
<div id="content2" style="display: none; position: relative;">

<table width="640" cellpadding="0" cellspacing="0" border="0">
<tr>
<td height="60" align="center" style="padding-top: 7px; font-size: 18px; font-weight: bold;"><span style="font-size: 18px; color: #700459;">윤철수</span> 고객님의 <span style="font-size: 18px; color: #700459;">2014년 09월</span> 청구서 입니다.</td>
</tr>
<tr>
<td height="2" style="background: url(http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_dot.gif) repeat-x;   left top;">&nbsp;</td>
</tr>
<tr>
<td align="right" style="padding: 10px 0 10px 0;"><a href="#" onclick="printDiv('print01_yo_area'); return false;"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/btn_print.jpg" border="0" alt=""></a></td>
</tr>
</table>
<!-- //청구내역 테이블 -->
<table class="datatable1" style="margin: 10px 0 0 0;">
<tr>
<th colspan="4" class="title" style="font-size: 14px;">
<span style="font-size: 14px; font-weight: bold; color: #700459;">윤철수</span> 고객님께서 이번달 납부하실 금액은 <span style="font-size: 14px; font-weight: bold; color: #a40282;">34,360원</span> 입니다.</th>
</tr>
<tr>
<td class="title">고객명</td>
<td>윤철수</td>
<td class="title">고객번호</td>
<td>283001187290</td>
</tr>
<tr>
<td class="title">서비스번호</td>
<td>406073346275<br>
</td>


<td class="title">이용기간</td>
<tD>2014년 08월 01일 <br>~ 2014년 08월 31일</td>


</tr>

<tr>
<td class="title">납기일</td>
<td>2014년 09월 30일</td>
<td class="title">출금일</td>
<td>09월 26일(9/29,30,10/2,6,8,10,13,15,17)&nbsp;</td>
</tr>
<tr>
<td class="title">납부방법</td>
<td>은행자동이체&nbsp;</td>
<td class="title">금융기관</td>
<td>우리은행&nbsp;</td>
</tr>
<tr>
<td class="title">카드/계좌번호</td>
<td>422*******7&nbsp;</td>
<td class="title">예금주명</td>
<td>윤철수&nbsp;</td>
</tr>


</table>
<!-- //청구내역 테이블 -->

<!-- 이번달요금청구내역 -->
<!-- 간단히 보기 -->
<div  id="js01" style="display:block;width: 100%; position: relative;">
<table width="100%" cellpadding="0" cellspacing="0" border="0" style="margin: 30px 0 0 0; table-layout: fixed;">
<tr>
<td><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/cont02_title01.gif" border="0" alt=""></td>
<td align="right"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201105/bt_detail.gif" border="0" style="cursor: pointer;" onclick="lay01('js01','js02');" alt=""></td>
</tr>
</table>
<div class="chargeage" style="margin: 10px 0 0 0;">
<table class="datatable3">
<col width="70%">
<col width="30%">
<tr>
<th class="title"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/table02_01.gif" /></th>
<th class="title"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/table02_02.gif" /></th>
</tr>





























































<!-- 소계 flag 추가 20120211 -->






<tr class="blue2" >
<td class="first">
<span style="font-size: 14px; font-weight: bold;">&nbsp;&nbsp;

U+ 인터넷</span>
</td>
<td class="price">

<strong>



28,200원



</strong>

</td>
</tr>






<tr  >
<td class="first">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

<strong>기본요금</strong>
</td>
<td class="price">



&nbsp;



</td>
</tr>






<tr  >
<td class="first">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

기본료
</td>
<td class="price">



33,000원



</td>
</tr>






<tr  >
<td class="first">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

<strong>부가서비스</strong>
</td>
<td class="price">



&nbsp;



</td>
</tr>






<tr  >
<td class="first">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

클린웹
</td>
<td class="price">



3,000원



</td>
</tr>






<tr  >
<td class="first">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

<strong>할인요금</strong>
</td>
<td class="price">



-7,800원



</td>
</tr>






<tr class="blue2" >
<td class="first">
<span style="font-size: 14px; font-weight: bold;">&nbsp;&nbsp;

U+ 070</span>
</td>
<td class="price">

<strong>



3,558원



</strong>

</td>
</tr>






<tr  >
<td class="first">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

<strong>기본요금</strong>
</td>
<td class="price">



&nbsp;



</td>
</tr>






<tr  >
<td class="first">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

기본료
</td>
<td class="price">



2,000원



</td>
</tr>






<tr  >
<td class="first">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

<strong>통화요금</strong>
</td>
<td class="price">



&nbsp;



</td>
</tr>






<tr  >
<td class="first">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

국내통화료
</td>
<td class="price">



1,558원



</td>
</tr>








































<tr class="blue2" >
<td class="first"><span style="font-size: 14px; font-weight: bold;">&nbsp;&nbsp;
세금 및 공통요금</span>&nbsp;
</td>
<td class="price">2,602원</td>
</tr>



<tr  >
<td class="first">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
자동이체할인&nbsp;
</td>
<td class="price">-314원</td>
</tr>



<tr  >
<td class="first">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
e-mail청구할인&nbsp;
</td>
<td class="price">-200원</td>
</tr>



<tr  >
<td class="first">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
부가가치세&nbsp;
</td>
<td class="price">3,124원</td>
</tr>



<tr  >
<td class="first">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<span style="color: #ec008c;"> (*) </span>10원미만 할인&nbsp;
</td>
<td class="price">-8원</td>
</tr>







































<tr class="pink">
<td class="first"><span style="font-size: 14px; font-weight: bold; color: #555;">이번달 요금 계(A)</span></td>
<td class="first price aleft"><span style="font-size: 14px; font-weight: bold; color: #8d224e;">34,360원</span></td>
</tr>



<tr class="pink">
<td class="first"><span style="font-size: 14px; font-weight: bold; color: #555;">미납 요금 계(B)</span></td>
<td class="first price aleft"><span style="font-size: 14px; font-weight: bold; color: #8d224e;">0원</span></td>
</tr>

<tr class="pink">
<td class="first"><span style="font-size: 14px; font-weight: bold; color: #555;">총 납부하실 금액(A+B)</span></td>
<td class="first price aleft"><span style="font-size: 14px; font-weight: bold; color: #8d224e;">34,360원</span></td>
</tr>

</table>
</br>
<table width="100%" cellpadding="0" cellspacing="0" border="0">
<tr>
<td><!--<img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/table_bottomtext.gif" /> -->


<!-- 2013.03 추가  -->

※ 부가서비스는 신규가입/해지 시점의 사용일자에 따라 일할계산되어 청구됩니다.<br/>
( 선불형 상품 및 1개월 의무사용 부가서비스는 1개월 이용료가 청구됩니다. )

&nbsp;</td>
</tr>
</table>
</div>

</div>
<!-- 자세히 보기 -->
<div  id="js02" style="display:none;width: 100%; position: relative;">
<table width="100%" cellpadding="0" cellspacing="0" border="0" style="margin: 30px 0 0 0; table-layout: fixed;">
<tr>
<td><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/cont02_title01.gif" border="0" alt=""></td>
<td align="right"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201105/bt_simple.gif" border="0" style="cursor: pointer;" onclick="lay01('js02','js01');" alt=""></td>
</tr>
</table>
<div class="chargeage" style="margin: 10px 0 0 0;">
<table class="datatable3">
<col width="40%">
<col width="20%">
<col width="">
<tr>
<th class="title"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/table02_01.gif" /></th>
<th class="title"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/table02_02.gif" /></th>
<th class="title"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/table02_03.gif" /></th>
</tr>




<!-- 소계 flag 추가 20120211 -->





<tr class="blue2" >
<td class="first">

<span style="font-size: 14px; font-weight: bold;">&nbsp;&nbsp;


U+ 인터넷

</span>
</td>
<td class="price">

<strong>



28,200원



</strong>

</td>
<!-- 항목메세지 수정 20120210 -->
<!-- 201305 Discription 하드코딩 추가-->
<td>

&nbsp;

</td>
</tr>





<tr  >
<td class="first">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

<strong>
기본요금
</strong>

</td>
<td class="price">



&nbsp;



</td>
<!-- 항목메세지 수정 20120210 -->
<!-- 201305 Discription 하드코딩 추가-->
<td>

&nbsp;

</td>
</tr>





<tr  >
<td class="first">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;


기본료


</td>
<td class="price">



33,000원



</td>
<!-- 항목메세지 수정 20120210 -->
<!-- 201305 Discription 하드코딩 추가-->
<td>

U+ 인터넷 기본이용료로 이용기간에 따라 일할 계산됩니다&nbsp;

</td>
</tr>





<tr  >
<td class="first">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

<strong>
부가서비스
</strong>

</td>
<td class="price">



&nbsp;



</td>
<!-- 항목메세지 수정 20120210 -->
<!-- 201305 Discription 하드코딩 추가-->
<td>

&nbsp;

</td>
</tr>





<tr  >
<td class="first">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;


클린웹


</td>
<td class="price">



3,000원



</td>
<!-- 항목메세지 수정 20120210 -->
<!-- 201305 Discription 하드코딩 추가-->
<td>

유해 웹사이트를 차단시켜주는 서비스 입니다&nbsp;

</td>
</tr>





<tr  >
<td class="first">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

<strong>
할인요금
</strong>

</td>
<td class="price">



-7,800원



</td>
<!-- 항목메세지 수정 20120210 -->
<!-- 201305 Discription 하드코딩 추가-->
<td>

&nbsp;

</td>
</tr>





<tr class="blue2" >
<td class="first">

<span style="font-size: 14px; font-weight: bold;">&nbsp;&nbsp;


U+ 070

</span>
</td>
<td class="price">

<strong>



3,558원



</strong>

</td>
<!-- 항목메세지 수정 20120210 -->
<!-- 201305 Discription 하드코딩 추가-->
<td>

&nbsp;

</td>
</tr>





<tr  >
<td class="first">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

<strong>
기본요금
</strong>

</td>
<td class="price">



&nbsp;



</td>
<!-- 항목메세지 수정 20120210 -->
<!-- 201305 Discription 하드코딩 추가-->
<td>

&nbsp;

</td>
</tr>





<tr  >
<td class="first">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;


기본료


</td>
<td class="price">



2,000원



</td>
<!-- 항목메세지 수정 20120210 -->
<!-- 201305 Discription 하드코딩 추가-->
<td>

서비스 사용시 기본적으로 부과되는 요금입니다.&nbsp;

</td>
</tr>





<tr  >
<td class="first">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

<strong>
통화요금
</strong>

</td>
<td class="price">



&nbsp;



</td>
<!-- 항목메세지 수정 20120210 -->
<!-- 201305 Discription 하드코딩 추가-->
<td>

&nbsp;

</td>
</tr>





<tr  >
<td class="first">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;


국내통화료


</td>
<td class="price">



1,558원



</td>
<!-- 항목메세지 수정 20120210 -->
<!-- 201305 Discription 하드코딩 추가-->
<td>

유선전화 및 인터넷전화와의 통화료입니다&nbsp;

</td>
</tr>







































<tr class="blue2" >
<td class="first"><span style="font-size: 14px; font-weight: bold;">&nbsp;&nbsp;
세금 및 공통요금&nbsp;
</td>
<td class="price">2,602원</td>
<!-- 항목메세지 수정 20120210 -->
<td>

&nbsp;

</td>
</tr>



<tr  >
<td class="first">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
자동이체할인&nbsp;
</td>
<td class="price">-314원</td>
<!-- 항목메세지 수정 20120210 -->
<td>

(은행)자동이체 할인은 전월 요금을 말일까지 완납하신 경우, 전월 납부요금(부가세 등 일부 항목 제외)의 1% 금액입니다.&nbsp;

</td>
</tr>



<tr  >
<td class="first">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
e-mail청구할인&nbsp;
</td>
<td class="price">-200원</td>
<!-- 항목메세지 수정 20120210 -->
<td>

e-mail청구서 신청고객에 대하여 할인해드린 금액입니다.&nbsp;

</td>
</tr>



<tr  >
<td class="first">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
부가가치세&nbsp;
</td>
<td class="price">3,124원</td>
<!-- 항목메세지 수정 20120210 -->
<td>

부가가치세는 (*)표시가 없는 항목 요금 합계의 10% 금액입니다. ((*) 항목은 이미 부가세가 포함되어 있거나 비과세항목으로제외되었습니다)&nbsp;

</td>
</tr>



<tr  >
<td class="first">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<span style="color: #ec008c;"> (*) </span>10원미만 할인&nbsp;
</td>
<td class="price">-8원</td>
<!-- 항목메세지 수정 20120210 -->
<td>

10원 미만의 원단위 금액은 부과되지 않습니다.&nbsp;

</td>
</tr>







































<tr class="pink">
<td class="first"><span style="font-size: 14px; font-weight: bold; color: #555;">이번달 요금 계(A)</span></td>
<td class="first price aleft"><span style="font-size: 14px; font-weight: bold; color: #8d224e;">34,360원</span></td>
<!-- 201305 Discription 하드코딩 추가-->
<td class="first">

&nbsp;

</td>
</tr>



<tr class="pink">
<td class="first"><span style="font-size: 14px; font-weight: bold; color: #555;">미납 요금 계(B)</span></td>
<td class="first price aleft"><span style="font-size: 14px; font-weight: bold; color: #8d224e;">0원</span></td>
<!-- 201305 Discription 하드코딩 추가-->
<td class="first">

&nbsp;

</td>
</tr>

<tr class="pink">
<td class="first"><span style="font-size: 14px; font-weight: bold; color: #555;">총 납부하실 금액(A+B)</span></td>
<td class="first price aleft"><span style="font-size: 14px; font-weight: bold; color: #8d224e;">34,360원</span></td>
<!-- 201305 Discription 하드코딩 추가-->
<td class="first">

&nbsp;

</td>
</tr>

</table>
</br>
<table width="100%" cellpadding="0" cellspacing="0" border="0">
<tr>
<td><!--<img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/table_bottomtext.gif" /> -->


<!-- 2013.03 추가  -->

※ 부가서비스는 신규가입/해지 시점의 사용일자에 따라 일할계산되어 청구됩니다.<br/>
( 선불형 상품 및 1개월 의무사용 부가서비스는 1개월 이용료가 청구됩니다. )

&nbsp;</td>
</tr>
</table>
</div>

</div>
<!-- //이번달요금청구내역 -->


<!-- 이번달 할인 상세내역 -->




































<!-- 간단히 보기 -->
<div  id="sale01" style="display:block;width: 100%; position: relative;">
<table width="100%" cellpadding="0" cellspacing="0" border="0" style="margin: 30px 0 0 0; table-layout: fixed;">
<tr>
<td><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/cont02_title_sale.gif" border="0" alt=""></td>
<td align="right"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201105/bt_detail.gif" border="0" style="cursor: pointer;" onclick="lay01('sale01','sale02');" alt=""></td>
</tr>
</table>
<div class="chargeage" style="margin: 10px 0 0 0;">
<table class="datatable3">
<col width="70%">
<col width="30%">
<tr>
<th class="title"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/table02_sale01.gif" /></th>
<th class="title"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/table02_02.gif" /></th>
</tr>








<!-- 소계 flag 추가 20120211 -->





<tr class="blue2" >
<td class="first">

<span style="font-size: 14px; font-weight: bold;">&nbsp;&nbsp;


U+ 인터넷

</span>

</td>
<td class="price">

<strong>


&nbsp;


</strong>

</td>
</tr>



<tr  >
<td class="first">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;


약정할인

</td>
<td class="price">


-5,000원


</td>
</tr>



<tr  >
<td class="first">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;


결합상품할인

</td>
<td class="price">


-2,800원


</td>
</tr>



<tr class="blue2" >
<td class="first">

<span style="font-size: 14px; font-weight: bold;">&nbsp;&nbsp;


기타할인

</span>

</td>
<td class="price">

<strong>


&nbsp;


</strong>

</td>
</tr>



<tr  >
<td class="first">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;


자동이체할인

</td>
<td class="price">


-314원


</td>
</tr>



<tr  >
<td class="first">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;


e-mail청구할인

</td>
<td class="price">


-200원


</td>
</tr>



<tr  >
<td class="first">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;


<span style="color: #ec008c;"> (*) </span>

10원미만 할인

</td>
<td class="price">


-8원


</td>
</tr>





















<tr class="pink">
<td class="first"><span style="font-size: 14px; font-weight: bold; color: #555;">총계</span></td>
<td class="first price aleft"><span style="font-size: 14px; font-weight: bold; color: #8d224e;">-8,322원</span></td>
</tr>


</table>
</div>
</div>
<!-- 자세히 보기 -->
<div id="sale02" style="display:none;width: 100%; position: relative;">
<table width="100%" cellpadding="0" cellspacing="0" border="0" style="margin: 30px 0 0 0; table-layout: fixed;">
<tr>
<td><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/cont02_title_sale.gif" border="0" alt=""></td>
<td align="right"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201105/bt_simple.gif" border="0" style="cursor: pointer;" onclick="lay01('sale02','sale01');" alt=""></td>
</tr>
</table>
<div class="chargeage" style="margin: 10px 0 0 0;">
<table class="datatable3">
<col width="35%">
<col width="17%">
<col width="">
<tr>
<th class="title"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/table02_sale01.gif" /></th>
<th class="title"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/table02_02.gif" /></th>
<th class="title"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/table02_sale03.gif" /></th>
</tr>





<!-- 소계 flag 추가 20120211 -->




<tr class="blue2">
<td class="first">

<span style="font-size: 14px; font-weight: bold;">&nbsp;&nbsp;



U+ 인터넷

</span>

</td>
<td class="price">

<strong>


&nbsp;


</strong>

</td>
<!-- 항목메세지 수정 20120210 -->
<td>

&nbsp;

</td>
</tr>



<tr >
<td class="first">

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;



약정할인

</td>
<td class="price">


-5,000원


</td>
<!-- 항목메세지 수정 20120210 -->
<td>

약정기간에 따라 기본료를 할인해 드립니다(중도해지/무약정변경 시 할인금액 청구됨)&nbsp;

</td>
</tr>



<tr >
<td class="first">

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;



결합상품할인

</td>
<td class="price">


-2,800원


</td>
<!-- 항목메세지 수정 20120210 -->
<td>

U+ 070, U+ TV를 함께 이용 시 기본료를 할인해 드립니다.(약정이내 해지/무약정 변경 시 할인금액 청구됨)&nbsp;

</td>
</tr>



<tr class="blue2">
<td class="first">

<span style="font-size: 14px; font-weight: bold;">&nbsp;&nbsp;



기타할인

</span>

</td>
<td class="price">

<strong>


&nbsp;


</strong>

</td>
<!-- 항목메세지 수정 20120210 -->
<td>

&nbsp;

</td>
</tr>



<tr >
<td class="first">

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;



자동이체할인

</td>
<td class="price">


-314원


</td>
<!-- 항목메세지 수정 20120210 -->
<td>

(은행)자동이체 할인은 전월 요금을 말일까지 완납하신 경우, 전월 납부요금(부가세 등 일부 항목 제외)의 1% 금액입니다.&nbsp;

</td>
</tr>



<tr >
<td class="first">

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;



e-mail청구할인

</td>
<td class="price">


-200원


</td>
<!-- 항목메세지 수정 20120210 -->
<td>

e-mail청구서 신청고객에 대하여 할인해드린 금액입니다.&nbsp;

</td>
</tr>



<tr >
<td class="first">

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;



<span style="color: #ec008c;"> (*) </span>

10원미만 할인

</td>
<td class="price">


-8원


</td>
<!-- 항목메세지 수정 20120210 -->
<td>

10원 미만의 원단위 금액은 부과되지 않습니다.&nbsp;

</td>
</tr>





















<tr class="pink">
<td class="first"><span style="font-size: 14px; font-weight: bold; color: #555;">총계</span></td>
<td class="first price aleft"><span style="font-size: 14px; font-weight: bold; color: #8d224e;">-8,322원</span></td>
<td class="first">&nbsp;</td>
</tr>


</table>
</div>
</div>
<!-- //이번달 할인 상세내역 -->


<!-- 20130509 수정 -->
<!-- 전월미청구금액-->




<!-- //전월미청구금액-->
<!-- //20130509 수정 -->

<!-- 기타 세부사항 -->





<!-- //기타 세부사항 -->

<!-- 20101104 수정 -->
<!-- 요금제 안내 -->































<div style="margin-top: 30px;"> <img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201011/title_content_1.gif" alt="" /></div>




<div class="s_tab02" style="display:block;" id="s_tab05_2" >
<!-- 탭 -->
<ul>

<li><img style="cursor: pointer;" alt="" onclick="lay05('s_tab05_2','s_tab05_1','s_tab05_3','s_tab05_4');" src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201112/con_stab05_02on.gif"></li>
<li><img style="cursor: pointer;" alt="" onclick="lay05('s_tab05_3','s_tab05_1','s_tab05_2','s_tab05_4');" src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201112/con_stab05_03.gif"></li>

</ul>
<table class="datatabel3" style="margin-top:10px;">
<col width="30%" />
<col width="" />



<tr>
<th>요금제명</th>
<td>광랜</td>
</tr>
<tr>
<th>기본료(원)</th>
<td>33,000원</td>
</tr>
<tr>
<th>약정기간</th>
<td>3년 약정</td>
</tr>
<tr>
<th>약정할인</th>
<td>-5,000원</td>
</tr>
<tr>
<th>비고</th>
<td></td>
</tr>

</table>
</div>



<div class="s_tab02" style="display:none;" id="s_tab05_3" >
<!-- 탭 -->
<ul>

<li><img style="cursor: pointer;" alt="" onclick="lay05('s_tab05_2','s_tab05_1','s_tab05_3','s_tab05_4');" src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201112/con_stab05_02.gif"></li>
<li><img style="cursor: pointer;" alt="" onclick="lay05('s_tab05_3','s_tab05_1','s_tab05_2','s_tab05_4');" src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201112/con_stab05_03on.gif"></li>

</ul>
<table class="datatabel3" style="margin-top:10px;">
<col width="30%" />
<col width="" />





<tr>
<th>요금제명</th>
<td>표준</td>
</tr>
<tr>
<th>기본료(원)</th>
<td>2,000원</td>
</tr>
<tr>
<th>국내통화료(원)</th>
<td>국내:38원/180초, 이동:11.7원/10초, 문자:15원/건</td>
</tr>
<tr>
<th>기본제공</th>
<td></td>
</tr>
<tr>
<th>비고</th>
<td>070 가입자간 음성통화료 무료(번호이동 제외) 070 가입자간 SMS 10원/건, 070 가입자 외 15원/건</td>
</tr>

</table>
</div>







<br/><br/><br/><br/>
<img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201104/text_content_3.gif" alt="" /><br />

<br/>
<img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201104/text_content_3_4.gif" alt="" />


<!--div style="margin-top: 30px;"><img src="http://58.150.244.96/uni_bill/images/text_yogum.gif" alt="" /></div-->
<!--div style="margin-top: 10px;"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201104/text_content_3_4.gif" alt="" /></div-->
<br/><br/>
<div style="margin-top: 10px;"> <img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201203/text_content_3_1.gif" alt="" />
<table class="datatable2">
<tr>
<th class="title"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/table11_01.gif" alt="" /></th>
<th class="title"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/table11_02.gif" alt="" /></th>
<th class="title"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/table11_03.gif" alt="" /></th>
</tr>
<tr>
<td class="first">국민은행</td>
<td>710890-78-035659</td>
<td rowspan="3" class="center">엘지유플러스</td>
</tr>
<tr>
<td class="first">우리은행</td>
<td>449-025369-18-129</td>
</tr>

<tr>
<td class="first">하나은행</td>
<td>225-930093-82937</td>
</tr>

</table>
</div>
<!--div> <img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201203/text_content_4_1.gif" alt="" /></div-->
<div><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201207/text_content_4.gif" alt="" /></div>



<!--br-->
<!--div><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201203/text_content_4_2.gif" alt="" /-->
<br/><br/>
<div>
<table class="datatabel3">
<tr>
<th rowspan="1">고객센터</th>
<td>
<ul class="default-list02">
<li>이동통신 : 휴대폰에서 114 (무료), 1544-0010(유료)</li>
<li>인터넷, 070, TV : 국번없이 101</li>
<li>기업 : 1544-0001(유료)</li>
</ul>
</td>
<td>월~금</td>
</tr>
<tr>
<th rowspan="2">대리점</th>
<td rowspan="2"><ul class="default-list02"><li><a href="http://58.150.244.95:80/Check.html?TV9JRD0yODMwMDExODcyOTBfMjkxOTAwMDM=&U1RZUEU9QVVUTw==&TElTVF9UQUJMRT1BVVRPMTIw&UE9TVF9JRD0yMDE0MDkxMl83NA==&VEM9MjAxNDA5MTk=&U0VSVkVSX0lEPTAx&S0lORD1D&Q0lEPTAwNQ==&URL=http://www.uplus.co.kr/css/sinf/brsc/RetrivePosSvc.hpi?mid=2504" target="_blank">가까운대리점찾아보기</a></li></ul></td>
<td>월~토</td>
</tr>
<tr>
<td>오전10시~ 오후06시</td>
</tr>
<tr>
<th>홈페이지</th>
<td>
<ul class="default-list02"><li><a href="http://58.150.244.95:80/Check.html?TV9JRD0yODMwMDExODcyOTBfMjkxOTAwMDM=&U1RZUEU9QVVUTw==&TElTVF9UQUJMRT1BVVRPMTIw&UE9TVF9JRD0yMDE0MDkxMl83NA==&VEM9MjAxNDA5MTk=&U0VSVkVSX0lEPTAx&S0lORD1D&Q0lEPTAwNg==&URL=http://www.uplus.co.kr/bil/pymt/paym/InitOnlinePaymentIntd.hpi?mid=2293" target="_blank">홈페이지납부바로가기</a></li></ul>
</td>
<td>24시간</td>
</tr>
<tr>
<th>ARS</th>
<td>
<ul class="default-list02">
<li>이동통신 : 휴대폰에서 114 (무료), 1544-0010(유료)</li>
<li>인터넷, 070, TV : 국번없이 101</li>
<li>기업 : 1544-0001(유료)</li>
</ul>
</td>
<td>24시간</td>
</tr>
</table>
<!-- //20120113 수정 -->
</div>
</div>
<!-- //청구내역 -->
<!-- 서비스 상세내역 -->
<div id="content3" style="display: none; position:relative;">


<table width="640" cellpadding="0" cellspacing="0" border="0">
<tr>
<td height="60" align="center" style="padding-top: 7px; font-size: 18px; font-weight: bold;"><span style="font-size: 18px; color: #700459;">윤철수</span> 고객님의 <span style="font-size: 18px; color: #700459;">2014년 09월</span> 청구서 입니다.</td>
</tr>
<tr>
<td height="2" style="background: url(http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_dot.gif) repeat-x;   left top;">&nbsp;</td>
</tr>
<tr>
<td align="right" style="padding: 10px 0 10px 0;"><a href="#" onclick="printDiv('print01_yo_area'); return false;"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/btn_print.jpg" border="0" alt=""></a></td>
</tr>
</table>

<!-- 할부요금 상세내역-->






<!-- //할부요금 상세내역 -->

<!-- 201308 수정 -->












<!-- 이번달 이용내역 -->

<p class="title3"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/cont_2_2_title_1.gif" /></p>

<!-- 최근 3개월간 사용내역만 있을때 -->

<div class="s_tab02" style="display: block;" id="tab01_1">
<!-- 탭 -->
<ul>
<li><span style=" font-weight:bold; color:#9c5c77;">최근 3개월간 사용내역</span></li>

</ul>
<!-- //탭 -->
<table width="100%" cellpadding="0" cellspacing="0" border="0">
<tr>
<td><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201101/cont_2_box_top.gif" alt=""></td>
</tr>
<tr>
<td style=" padding: 0 15px; background: url(http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/cont_2_box_mid.gif) repeat-y;   left top;">
<strong>최근 3개월간 사용내역 (사용월 기준)</strong>
<table class="datatable2" style="margin: 10px 0 0 0;" >

<tr>
<th class="title"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/table03_01.gif" /></th>
<th class="title"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201307/table03_02_1.gif" /></th>



<th class="title">2014.06</th>
<th class="title">2014.07</th>
<th class="title">2014.08</th>
<th class="title">평균사용량</th>


 

 

</tr>
<!-- 9월청구작업시 막음 길상민대리 요청사항노승훈 -->
<!--
<tr>
<th class="title">총사용내역</th>
<th class="title">총사용내역</th>
<th class="title">총사용내역</th>
<th class="title">총사용내역</th>
</tr>
-->






<tr>



<td class="first" rowspan="3">070-**52-2939</td> 
<td style="text-align: left;">국내</td>
<td>6분 00초</td>
<td>81분 00초</td>
<td>123분 00초</td>
<td>70분 00초</td>
</tr>







<tr>





 
<td style="text-align: left;">이동</td>
<td>0분 00초</td>
<td>4분 50초</td>
<td>0분 00초</td>
<td>4분 50초</td>
</tr>







<tr>





 
<td style="text-align: left;">기타</td>
<td>5분 15초</td>
<td>0분 00초</td>
<td>0분 00초</td>
<td>5분 15초</td>
</tr>







</table>
</td>
</tr>
<tr><td><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/cont_2_box_btm.gif" alt=""></td></tr>
</table>
</div>
※ 개통시기, 이용여부에 따라 사용내역 제공기간이 변경될 수 있습니다.</br>

<br><br>

<!-- 무료사용내역 만 있을때  -->


<!-- //이번달 이용내역 -->


<!-- 이번달이용서비스상세내역 -->














































<!-- 2011.07 수신자부담 추가-->




<!-- 2012.12 구글 스토어, U+ 스토어 -->






<!-- 2014.08 IDC 종량제 -->





<!-- //이번달이용서비스상세내역 -->
<!-- 20120806 수정 -->
<!-- 반환금 확인-->




<!-- 예상 해지비용 -->










<!-- 위약금 있을경우, 예상 해지비용 미출력 20130408 수정-->


<!-- 201405 방통위 수정 -->
<!-- //예상해지비용 미출력시 무조건 False  1, 4 , 7 , 10 월 일??만 출력 -->

<!--3개월에 한번씩 수정됨 --> <!--방통위 start -->
  <!--방통위 end -->
<!-- //예상 해지비용 -->
<!-- //20120806 수정 -->
<!-- 20111223 수정 -->







<!-- 070 통화유형별 사용내역 -->
<table width="100%" cellpadding="0" cellspacing="0" border="0" style="margin: 30px 0 0 0;">
<tr>
<td><img border="0" alt="" src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201112/cont02_titlen01.gif"></td>
</tr>
</table>
<table class="datatable3" style="margin: 10px 0 0 0;">
<tr>
<th class="title" rowspan="2" width="15%">구분</th>
<th class="title" style="border-bottom: 1px solid  #e4e4e4;"colspan="3">통화내역</th>
<th class="title" rowspan="2" width="">비고</th>
</tr>
<tr>
<th class="title" width="15%">금액</th>
<th class="title" width="15%">통화량</th>
<th class="title" width="15%">비중</th>
</tr>


<tr>
<td class="first">국내</td>
<td class="price">1,558원</td>
<td class="txtCt">123분</td>
<td class="txtCt">100%</td>
<td class="txtCt"></td>
</tr>





<tr class="pink">
<td class="txtCt"><span style="font-size: 12px; font-weight: bold; color: #555;">합계</span></td>
<td class="price"><span style="font-size: 12px; font-weight: bold; color: #8d224e;">1,558원</span></td>
<td class="txtCt"><span style="font-size: 12px; font-weight: bold; color: #8d224e;">123분</span></td>
<td class="txtCt"><span style="font-size: 12px; font-weight: bold; color: #8d224e;">100%</span></td>
<td class="txtCt"><span style="font-size: 12px; font-weight: bold; color: #8d224e;"></span></td>
</tr>


</table>
<p style="margin-top:5px;">
※ 통화량은 도수(1도수 : 국내전화 3분, 이동전화 10초)로 환산된 시간으로 실제 통화시간과 다를 수 있습니다.
</p>
<!-- //070 통화유형별 사용내역 -->








<!-- 5월 이후 상세내역 -->










<!--// 20111223 수정 -->

<!-- 5월 이전월 상세내역 -->

<!-- 나의 통화패턴 -->

<!-- 6개월간요금패턴 -->

<!-- 6개월간요금패턴 -->
<!-- 음성통화 사용안내 -->































<!--// 20101203 수정 -->

<!-- 포인트 &amp; 마일리지 -->










<!--  * MVNO 사업자인 경우
- ez-point 점수 상세내역 (모바일)
-멤버십 점수 상세내역 (모바일)
미표기 요청 ( 2번 레코드에 정보 있음)
-->



<!-- //포인트 &amp; 마일리지 -->

</div>
<!-- //서비스 상세내역 -->

<!--  201405 수정 -->
<!-- 안내사항 -->

<div id="content4" style="display: none; position:relative;">
<table class="conducttable" width="100%" cellpadding="0" cellspacing="0"  border="0" style="margin-top:34px;">
<tr>
<td class="title"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/cont_2_3_title_1.gif" alt="" /></td>
</tr>
<tr>
<td class="textcontent" style="width:100%;">





















⊙<약정기간 내 해지 시 할인반환금 청구 안내>  LG U+ 인터넷, 070, TV 서비스를 약정기간 내에 해지 하시는  경우 해지 한 다음달에 할인반환금이 청구 됩니다. 단, 해지를  신청 하였으나 신청한 다음달에 해지되는 경우 신청한 다음  다음달에 할인반환금이 청구됩니다.  (예시. 1/31일 해지신청, 2/1 해지완료, 3월 할인반환금 청구)
</br></br>





⊙이동전화 및 유선전화를 해지하신 경우 KTOA 통신요금  정보포털(www.smartchoice.or.kr)에서 해지된 서비스에  남아있는 미환급액을 조회 및 환불 신청하실 수 있습니다.
</br></br>





⊙<여성 가족부 매주 수요일 ＇가족 사랑의 날＇ 캠페인>  매주 수요일은 ＇가족 사랑의 날＇! 정시 퇴근하여 가족사랑을  실천해보세요. 가족사랑 실천방법은 여성가족부 홈페이지  (www.mogef.go.kr)를 참고하시기 바랍니다.
</br></br>





⊙<인터넷전화 문자메세지 발신번호 변경 차단 안내>  2014년 7월부터 인터넷전화를 통해 문자메세지를 발송하는  경우 임의로 발신번호를 변경하실 수 없습니다. (변경 시  전송이 차단됩니다.) 이는 스팸, 스미싱, 문자폭력으로부터  이용자의 피해를 예방하기 위한 미래창조과학부의 정책이오니  이용이 다소 불편하시더라도 고객님의 양해를 부탁드립니다.
</br></br>





⊙은행자동납부의 경우 출금일로 부터 최대 2일(영업일 기준) 후에 납부 확인이 가능하며,<BR/>
&nbsp;&nbsp;&nbsp;카드자동납부의 경우 카드 승인일로 부터 최대 4일(영업일 기준) 이후에 납부확인이 가능합니다.
<BR/><BR/>





⊙홈페이지를 통해서도 청구서 또는 세금계산서를 재발행  신청하여 받으실 수 있습니다.  (홈페이지 : http://www.uplus.co.kr)
</br></br>




</td>
</tr>

<tr>
<td class="title"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201304/cont_2_3_title_5.gif" alt="" /></td>
</tr>
<tr>
<td class="textcontent" style="width:100%;">
최근 개인들이 관심을 가질만한 내용의 문자메세지(SMS)를 발송하여 문자수신인의 악성앱 설치를 유도하고<br/>
소액결제용 승인번호를 알아내어 몰래 소액결제를 하는 스미싱(Smishing) 사기사건이 지속 발생하고 있는 바, <br/>
고객 여러분께서는 각별히 주의하시기 바랍니다.
<br/><br/>
■ 피해예방 안내<br/><br/>
1. 출처가 불분명한 발신자의 문자에 담긴 인터넷주소(URL)는 악성앱을 설치하고자 하는 사기일 가능성이 높으니<br/>
&nbsp;&nbsp;&nbsp;&nbsp;접속을 피하시고 해당업체에 문의 하는 등 주의가 필요합니다.<br/>
&nbsp;&nbsp;&nbsp;&nbsp;(문화상품권 및 무료쿠폰 증정, 법원등기부달, 소액결제완료통보, 모임/청첩장, 명세서 등)<br/><br/>
2. 소액결제 비밀번호 설정<br/>
&nbsp;&nbsp;&nbsp;&nbsp;고객님만 알 수 있는 별도의 소액결제 비밀번호를 설정하시어 피해를 미리 방지하실 수 있습니다.<br/>
&nbsp;&nbsp;&nbsp;&nbsp;(신청방법 : (고객센터) 휴대폰에서 114 또는 1544-0010 )<br/>
<br/>
※ 사전에 스미싱유형을 파악하고 적절한 조치를 통해 피해예방이 가능합니다.<br/>
&nbsp;&nbsp;&nbsp;&nbsp;자세한 사항은 홈페이지(<a href="http://58.150.244.95:80/Check.html?TV9JRD0yODMwMDExODcyOTBfMjkxOTAwMDM=&U1RZUEU9QVVUTw==&TElTVF9UQUJMRT1BVVRPMTIw&UE9TVF9JRD0yMDE0MDkxMl83NA==&VEM9MjAxNDA5MTk=&U0VSVkVSX0lEPTAx&S0lORD1D&Q0lEPTAwOQ==&URL=http://www.uplus.co.kr" target="_blank" title="새창열림">http://www.uplus.co.kr</a>) 공지사항을 확인해 주세요.
</td>
</tr>
<tr>
<td class="title"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201407/cont_2_3_title_6.gif" alt="" /></td>
</tr>
<tr>
<td class="textcontent" style="width:100%;">
<p>휴대폰(선불폰)을 잃어버렸을 때는 즉시 통신사에 신고(1544-0010)를 해야 소중한 개인정보를 보호할 수 있고, 유료게임 결제, 모바일 상품권 구입 등으로 인한 2차 피해를 방지할 수 있습니다.</p>
<p>도난방지 기술인 킬스위치(Kill Switch)*가 탑재된 스마트폰의 경우, 단말기에서 킬스위치 기능을 사전 설정해 놓아야 고가 스마트폰의 분실/도난으로 인한 피해를 예방할 수 있습니다. (*킬스위치:단말기 제조단계에서 도난방지 소프트웨어를 탑재하여 분실/도난 시 원격제어 또는 사용자 설정을 통해 타인이 아예 쓸 수 없는 상태로 만들어 버리는 기능)<br />- 탑재모델 : LG(G3), 삼성(갤럭시S5), 팬텍(베가 No.6, 아이언, 아이언2, 시크릿노트, 시크릿업) 등</p>
<p>습득한 휴대폰을 경찰관서에 신고하지 않고 사용할 경우, 형사 처벌을 받을 수 있습니다. [‘점유이탈물횡령죄’로 1년 이하의 징역 또는 300만원 이하의 벌금에 처함(형법 제 360조)]</p>
</td>
</tr>

</table>
</div>
<!-- //안내사항 -->

<!-- 청구서/영수증 -->
<div id="content5" style="display: none; position:relative;">


<table width="640" cellpadding="0" cellspacing="0" border="0">
<tr>
<td height="60" align="center" style="padding-top: 7px; font-size: 18px; font-weight: bold;"><span style="font-size: 18px; color: #700459;">윤철수</span> 고객님의 <span style="font-size: 18px; color: #700459;">2014년 09월</span> 청구서 입니다.</td>
</tr>
<tr>
<td height="2" style="background: url(http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_dot.gif) repeat-x;   left top;">&nbsp;</td>
</tr>
<tr>
<td align="right" style="padding: 10px 0 10px 0;">&nbsp;</td>
</tr>
</table>
<table width="100%" cellpadding="0" cellspacing="0" border="0" style="table-layout: fixed;">
<tr>
<td><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/cont_2_4_title_1.gif" alt="" /></td>
<td align="right">
<!--if BLTXT_KD_SETUP_CD == "C"><a href="#" onclick="openTax();return false;"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/btn_print_form.gif" border="0" alt="세금계산서 양식 인쇄하기"></a></if-->
<a href="#" onclick="printDiv('print02_yo_area'); return false;"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/bt_print2.gif" border="0" /></a>
</td>
</tr>
</table>
<!-- <table width="100%" cellpadding="0" cellspacing="0" border="0">
<tr>
<td height="60">
<img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/faq_text01.gif" border="0" usemap="#goLink" alt="" style="vertical-align: top;">
<map name="goLink" id="goLink">
<area shape="rect" coords="268,2,314,19" href="#" target="_blank" alt="FAQ">
</map>
</td>
</tr>
</table> -->
<!-- 청구서 영수증 프린트 영역 시작 -->
<div id="print02_yo_area" >
<table class="acount-wrap" style="margin: 10px 0 0 0; table-layout: fixed;">
<tr>
<td valign="top">
<!-- 청구서 -->
<table width="308" cellpadding="0" cellspacing="0" border="0">
<tr>
<td colspan="3"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/tax_paper1_top.gif" border="0" /></td>
</tr>
<tr>
<!--td width="20" valign="top"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/tax_paper1_1_left.gif" border="0" /></td-->
<td width="20" valign="top" style="border-left: 1px solid #e4e4e4;">&nbsp;</td>
<td width="268" valign="top">
<table width="100%" cellpadding="0" cellspacing="0" border="0">
<tr>
<td height="60" align="center" style="font: bold 14px Dotum; color: #4f4f4f;"><span style="font: bold 14px Dotum; color: #700459;">2014년 09월</span> 청구서</td>
</tr>
</table>
<table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-top: 1px solid #c80752;">
<tr>
<th width="40%" style="padding: 10px 5px 8px 5px; border-bottom: 1px solid #e4e4e4; text-align: left; color: #696969;"><strong>고객명</strong></th>
<td width="60%" style="padding: 10px 5px 8px 5px; border-left: 1px solid #e4e4e4; border-bottom: 1px solid #e4e4e4; font-weight: bold; text-align: right;"><strong>윤철수&nbsp;</strong></td>
</tr>
<tr>
<th style="padding: 10px 5px 8px 5px; border-bottom: 1px solid #e4e4e4; text-align: left; color: #696969;"><strong>고객번호</strong></th>
<td style="padding: 10px 5px 8px 5px; border-left: 1px solid #e4e4e4; border-bottom: 1px solid #e4e4e4; font-weight: bold; text-align: right;"><strong>283001187290&nbsp;</strong></td>
</tr>
<tr>
<th style="padding: 10px 5px 8px 5px; border-bottom: 1px solid #e4e4e4; text-align: left; color: #696969;"><strong>서비스번호</strong></th>
<td style="padding: 10px 5px 8px 5px; border-left: 1px solid #e4e4e4; border-bottom: 1px solid #e4e4e4; font-weight: bold; text-align: right;"><strong>406073346275&nbsp;</strong></td>
</tr>

<tr>
<th width="40%" style="padding: 10px 5px 8px 5px; border-bottom: 1px solid #e4e4e4; text-align: left; color: #696969;"><strong>이용기간</strong></th>
<td width="60%" style="padding: 10px 5px 8px 5px; border-left: 1px solid #e4e4e4; border-bottom: 1px solid #e4e4e4; font-weight: bold; text-align: right;"><strong>2014년 08월 01일 <br>~ 2014년 08월 31일</strong></td>
</tr>

<!-- 명세서 지로 START -->

<!--
<tr>
<th style="padding: 10px 5px 8px 5px; border-bottom: 1px solid #e4e4e4; text-align: left; color: #696969;">납부방법</th>
<td style="padding: 10px 5px 8px 5px; border-left: 1px solid #e4e4e4; border-bottom: 1px solid #e4e4e4; font-weight: bold; text-align: right;"></td>
</tr>
-->
<tr>
<th style="padding: 10px 5px 8px 5px; border-bottom: 1px solid #e4e4e4; text-align: left; color: #696969;">납기일</th>
<td style="padding: 10px 5px 8px 5px; border-left: 1px solid #e4e4e4; border-bottom: 1px solid #e4e4e4; font-weight: bold; text-align: right;">2014년 09월 30일&nbsp;</td>
</tr>
<tr>
<th style="padding: 10px 5px 8px 5px; border-bottom: 1px solid #e4e4e4; text-align: left; color: #696969;">출금일</th>
<td style="padding: 10px 5px 8px 5px; border-left: 1px solid #e4e4e4; border-bottom: 1px solid #e4e4e4; font-weight: bold; text-align: right;">09월 26일(9/29,30,</br>10/2,6,8,10,13,15,17)</td>
</tr>
<tr>
<th style="padding: 10px 5px 8px 5px; border-bottom: 1px solid #e4e4e4; text-align: left; color: #696969;">금융기관</th>
<td style="padding: 10px 5px 8px 5px; border-left: 1px solid #e4e4e4; border-bottom: 1px solid #e4e4e4; font-weight: bold; text-align: right;">우리은행&nbsp;</td>
</tr>
<tr>
<th style="padding: 10px 5px 8px 5px; border-bottom: 1px solid #e4e4e4; text-align: left; color: #696969;">예금주명</th>
<td style="padding: 10px 5px 8px 5px; border-left: 1px solid #e4e4e4; border-bottom: 1px solid #e4e4e4; font-weight: bold; text-align: right;">윤철수&nbsp;</td>
</tr>
<tr>
<th style="padding: 10px 5px 8px 5px; border-bottom: 1px solid #e4e4e4; text-align: left; color: #696969;">계좌/</br>카드번호</th>
<td style="padding: 10px 5px 8px 5px; border-left: 1px solid #e4e4e4; border-bottom: 1px solid #e4e4e4; font-weight: bold; text-align: right;">422*******7&nbsp;</td>
</tr>


<tr>
<th style="padding: 10px 5px 8px 5px; border-bottom: 1px solid #e4e4e4; text-align: left; color: #696969;"><strong>이번달요금①</strong></th>
<td style="padding: 10px 5px 8px 5px; border-left: 1px solid #e4e4e4; border-bottom: 1px solid #e4e4e4; text-align: right; font-weight: bold;"><strong>34,360원</strong></td>
</tr>
<tr>
<th style="padding: 10px 5px 8px 5px; border-bottom: 1px solid #e4e4e4; text-align: left; color: #696969;"><strong>미납요금②</strong></th>
<td style="padding: 10px 5px 8px 5px; border-left: 1px solid #e4e4e4; border-bottom: 1px solid #e4e4e4; text-align: right; font-weight: bold;"><strong>0원</strong></td>
</tr>
<tr>
<th style="padding: 10px 5px 8px 5px; border-bottom: 1px solid #e4e4e4; text-align: left; color: #696969;"><strong style="font-family:dotum;font-size:12px;">이번달 납부<br>금액(①+②)</strong></th>
<td style="padding: 10px 5px 8px 5px; border-left: 1px solid #e4e4e4; border-bottom: 1px solid #e4e4e4; text-align: right; font-weight: bold; color:#CF118C;">34,360원</td>
</tr>




</table>
</td>
<!--td width="20" valign="top"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/tax_paper1_1_right.gif" border="0" /></td-->
<td width="20" valign="top" style="border-right: 1px solid #e4e4e4;">&nbsp;</td>
</tr>

<tr>
<td colspan="3"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/tax_paper1_btm.gif" border="0" /></td>
</tr>
</table>
<!-- //청구서 -->
</td>
<td valign="top" align="right">
<!-- 납부영수증 -->
<!--2010.10  영수금액 합계 추가 로직 시작  -->



<!--2010.10  영수금액 합계 추가 로직 끝 -->

<table width="310" cellpadding="0" cellspacing="0" border="0">
<tr>
<td colspan="3"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/tax_paper2_top.gif" border="0" /></td>
</tr>
<tr>
<td width="21" valign="top"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/tax_paper2_2_left.gif" border="0" /></td>
<td width="268" valign="top" bgcolor="#f8f8f8">
<table width="100%" cellpadding="0" cellspacing="0" border="0">
<tr>
<td height="60" align="center" style="font: bold 14px Dotum; color: #4f4f4f;"><span style="font: bold 14px Dotum; color: #700459;">전월</span> 납부영수증</td>
</tr>
</table>
<!-- 이전달 내역이 있는경우 -->

<table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-top: 1px solid #c80752;">
<tr>
<th style="padding: 10px 5px 8px 5px; border-bottom: 1px solid #e4e4e4; text-align: left; color: #696969;">고객명</th>
<td style="padding: 10px 5px 8px 5px; border-left: 1px solid #e4e4e4; border-bottom: 1px solid #e4e4e4; font-weight: bold; text-align: right;">윤철수&nbsp;</td>
</tr>
<tr>
<th style="padding: 10px 5px 8px 5px; border-bottom: 1px solid #e4e4e4; text-align: left; color: #696969;">고객번호</th>
<td style="padding: 10px 5px 8px 5px; border-left: 1px solid #e4e4e4; border-bottom: 1px solid #e4e4e4; font-weight: bold; text-align: right;">283001187290&nbsp;</td>
</tr>
<tr>
<th style="padding: 10px 5px 8px 5px; border-bottom: 1px solid #e4e4e4; text-align: left; color: #696969;">서비스번호</th>
<td style="padding: 10px 5px 8px 5px; border-left: 1px solid #e4e4e4; border-bottom: 1px solid #e4e4e4; font-weight: bold; text-align: right;">406073346275&nbsp;</td>
</tr>

<!-- 명세서 지로 START -->














<!--
<tr>
<th style="padding: 10px 5px 8px 5px; border-bottom: 1px solid #e4e4e4; text-align: left; color: #696969;">납부방법</th>
<td style="padding: 10px 5px 8px 5px; border-left: 1px solid #e4e4e4; border-bottom: 1px solid #e4e4e4; font-weight: bold; text-align: right;">FB</td>
</tr>
-->
<tr>
<th style="padding: 10px 5px 8px 5px; border-bottom: 1px solid #e4e4e4; text-align: left; color: #696969;">금융기관</th>
<td style="padding: 10px 5px 8px 5px; border-left: 1px solid #e4e4e4; border-bottom: 1px solid #e4e4e4; font-weight: bold; text-align: right;">우리은행&nbsp;</td>
</tr>

<tr>
<th style="padding: 10px 5px 8px 5px; border-bottom: 1px solid #e4e4e4; text-align: left; color: #696969;">계좌/</br>카드번호</th>
<td style="padding: 10px 5px 8px 5px; border-left: 1px solid #e4e4e4; border-bottom: 1px solid #e4e4e4; font-weight: bold; text-align: right;">422*******7&nbsp;</td>
</tr>
<!--	<tr>
<th style="padding: 10px 5px 8px 5px; border-bottom: 1px solid #e4e4e4; text-align: left; color: #696969;">영수금액(합계)</th>
<td style="padding: 10px 5px 8px 5px; border-left: 1px solid #e4e4e4; border-bottom: 1px solid #e4e4e4; font-weight: bold; text-align: right;">34,160원</td>
</tr>	-->


</table>

<!-- 이전달 내역이 없는경우  -->

<br>

<table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-top: 1px solid #c80752;">
<tr>
<th style="padding: 10px 5px 8px 5px; border-bottom: 1px solid #e4e4e4; color: #696969; color: #696969;">납부일자</th>
<th style="padding: 10px 5px 8px 5px; border-left: 1px solid #e4e4e4; border-bottom: 1px solid #e4e4e4; color: #696969;">영수금액</th>
<th style="padding: 10px 5px 8px 5px; border-left: 1px solid #e4e4e4; border-bottom: 1px solid #e4e4e4; color: #696969;">납부방법</th>
</tr>










<tr>
<td style="padding: 10px 5px 8px 5px; border-bottom: 1px solid #e4e4e4; text-align: center; color: #696969;">2014.08.26</td>
<td style="padding: 10px 5px 8px 5px; border-left: 1px solid #e4e4e4; border-bottom: 1px solid #e4e4e4; text-align: right;font-weight: bold; ">34,160원</td>
<td style="padding: 10px 5px 8px 5px; border-left: 1px solid #e4e4e4; border-bottom: 1px solid #e4e4e4; text-align: right; ">은행자동이체</td>
</tr>




<tr>
<td style="border-top: 1px solid #c80752; padding: 10px 5px 8px 5px; border-bottom: 1px solid #e4e4e4; text-align: center; color: #8d224e; font-weight:bold; background-color:#efdee5;">합계</td>
<td colspan="2" style="border-top: 1px solid #c80752; padding: 10px 5px 8px 5px; border-left: 1px solid #e4e4e4; border-bottom: 1px solid #e4e4e4; text-align:right; font-weight:bold;">34,160원</td>
<!-- <td style="border-top: 1px solid #c80752; padding: 10px 5px 8px 5px; border-left: 1px solid #e4e4e4; border-bottom: 1px solid #e4e4e4; text-align:center;">&nbsp;</td> -->
</tr>

</table>
</td>
<td width="21" valign="top"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/tax_paper2_2_left.gif" border="0" /></td>
<tr>
<td colspan="3"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/tax_paper2_btm.gif" border="0" /></td>
</tr>
</table>
<!-- //납부영수증 -->
</td>
</tr>
</table>
<table width="100%" cellpadding="0" cellspacing="0" border="0" style="margin: 5px 0 0 0;">
<tr>
<td>&nbsp;</td>
</tr>
<!-- </br>
<strong style="font-size:13px;">※ 전자세금계산서 승인번호 :  </strong> -->
<tr>
<td><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201012/table_bottomtext_00.gif" alt="" /></td>
</tr>
</table>
</div>
</div>
<!-- //청구서/영수증 -->

<!-- 201405 수정 -->
<!-- 이벤트/서비스 -->
<div id="content6" style="display: none; position:relative;">

<!-- 추후 삭제 -->
<!--이벤트/서비스 HS -->



<div class="event-box" style="margin-top:34px;">
<p class="title"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/cont_2_5_title_1.gif" alt="" /></p>
<div class="event-img"><a href="http://58.150.244.95:80/Check.html?TV9JRD0yODMwMDExODcyOTBfMjkxOTAwMDM=&U1RZUEU9QVVUTw==&TElTVF9UQUJMRT1BVVRPMTIw&UE9TVF9JRD0yMDE0MDkxMl83NA==&VEM9MjAxNDA5MTk=&U0VSVkVSX0lEPTAx&S0lORD1D&Q0lEPTA0MQ==&URL=http://www.uplus.co.kr/css/unws/lttr/RetrieveUbNsLetterDetail.hpi" target="_blank()" onfocus="this.blur()"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201409/img_event_main.jpg" border="0" alt="" /></a></div>
<br />
<p class="title"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/cont_2_5_title_2.gif" alt="" /></p>
<div class="event-img">
<a href=
"http://58.150.244.95:80/Check.html?TV9JRD0yODMwMDExODcyOTBfMjkxOTAwMDM=&U1RZUEU9QVVUTw==&TElTVF9UQUJMRT1BVVRPMTIw&UE9TVF9JRD0yMDE0MDkxMl83NA==&VEM9MjAxNDA5MTk=&U0VSVkVSX0lEPTAx&S0lORD1D&Q0lEPTA0Mg==&URL=http://www.uplus.co.kr/ent/iwifi/IWIHomeCCTV.hpi" target="_blank()" onfocus="this.blur()" alt="자세히 보기"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201409/img_event_6.jpg" alt="" border="0"  /></a>
</div>
<div class="event-img">
<a href="http://58.150.244.95:80/Check.html?TV9JRD0yODMwMDExODcyOTBfMjkxOTAwMDM=&U1RZUEU9QVVUTw==&TElTVF9UQUJMRT1BVVRPMTIw&UE9TVF9JRD0yMDE0MDkxMl83NA==&VEM9MjAxNDA5MTk=&U0VSVkVSX0lEPTAx&S0lORD1D&Q0lEPTA0Mw==&URL=http://www.uplus.co.kr/ent/prod/UpYoNewService1.hpi?WEB_BNNR_ID=email1409_UpYo" target="_blank()" onfocus="this.blur()" alt="자세히 보기"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201409/img_event_7.jpg" alt="" border="0"  /></a>
</div>
<br />
<p class="title"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/cont_2_5_title_3.gif" alt="" /></p>
<div class="event-img">
<ul class="normallist">
<li class="fir"><a href="http://58.150.244.95:80/Check.html?TV9JRD0yODMwMDExODcyOTBfMjkxOTAwMDM=&U1RZUEU9QVVUTw==&TElTVF9UQUJMRT1BVVRPMTIw&UE9TVF9JRD0yMDE0MDkxMl83NA==&VEM9MjAxNDA5MTk=&U0VSVkVSX0lEPTAx&S0lORD1D&Q0lEPTA0NA==&URL=http://www.uplus.co.kr/evt/evnt/evtv/RetrievePsTvEvtList.hpi" target="_blank()" onfocus="this.blur()"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201409/img_event_8.jpg" alt="" border="0"  /></a></li>
<li><a href="http://58.150.244.95:80/Check.html?TV9JRD0yODMwMDExODcyOTBfMjkxOTAwMDM=&U1RZUEU9QVVUTw==&TElTVF9UQUJMRT1BVVRPMTIw&UE9TVF9JRD0yMDE0MDkxMl83NA==&VEM9MjAxNDA5MTk=&U0VSVkVSX0lEPTAx&S0lORD1D&Q0lEPTA0NQ==&URL=http://www.uplus.co.kr/evt/evnt/evin/RetrieveUbEvIngElDetail.hpi?evntsrlno=227207" target="_blank()" onfocus="this.blur()"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201409/img_event_4.jpg" alt="" border="0"  /></a></li>
</ul>
</div>
<div class="event-img">
<a href="http://58.150.244.95:80/Check.html?TV9JRD0yODMwMDExODcyOTBfMjkxOTAwMDM=&U1RZUEU9QVVUTw==&TElTVF9UQUJMRT1BVVRPMTIw&UE9TVF9JRD0yMDE0MDkxMl83NA==&VEM9MjAxNDA5MTk=&U0VSVkVSX0lEPTAx&S0lORD1D&Q0lEPTA0Ng==&URL=http://www.itupp2014.go.kr/" target="_blank()" onfocus="this.blur()"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201408/img_info.gif" alt="" border="0"  /></a>
</div>
</div>



</div>
<!-- //이벤트/서비스 -->

<!-- 201405 수정 -->
<!-- 나만의혜택 -->
<div id="content7" style="display: none; position:relative;">

<br/>


<!-- 컨텐츠 시작 -->
<div style="margin-top:30px;"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/cont_7_title.gif" border="0" alt="" /></div>

<table width="590" height="" cellspacing="0" cellpadding="0" >
<tr>
<td valign="top" height="280px;" >
<table width="" height="38" cellspacing="0" cellpadding="0">
<tr>
<td valign="top"  height="59" style="padding:10px 0 0 5px; background: url('http://image.uplus.co.kr/img_server/ebill/new/mobile/201401/happy01.gif') no-repeat;"></td>
</tr>
<tr>
<td><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201409/happy01.jpg" alt="" border="0" usemap="#Map" /></td>
</tr>
</table>
</td>
</tr>
</table>
<map name="Map"><area shape="rect" coords="189,784,381,815" href="http://58.150.244.95:80/Check.html?TV9JRD0yODMwMDExODcyOTBfMjkxOTAwMDM=&U1RZUEU9QVVUTw==&TElTVF9UQUJMRT1BVVRPMTIw&UE9TVF9JRD0yMDE0MDkxMl83NA==&VEM9MjAxNDA5MTk=&U0VSVkVSX0lEPTAx&S0lORD1D&Q0lEPTA2MQ==&URL=http://www.uplus.co.kr/sqr/home/Index.hpi" target="_blank" alt="최신 스마트폰 자세히보기">
</map>
<br />

</div>
<!-- 나만의혜택 -->

<!-- 201405 수정 -->
<!-- 사랑을 전하는 청구서 -->

<div id="content8" style="display: none; position:relative;">
<div style="margin-top:30px;"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201104/cont_8_title.gif" border="0" alt="" /></div>
<div style="margin-top:30px;"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201409/lovesend_n.jpg" alt="" border="0" usemap="#love" /></div>

<MAP NAME="love">
<AREA SHAPE="rect" HREF="http://58.150.244.95:80/Check.html?TV9JRD0yODMwMDExODcyOTBfMjkxOTAwMDM=&U1RZUEU9QVVUTw==&TElTVF9UQUJMRT1BVVRPMTIw&UE9TVF9JRD0yMDE0MDkxMl83NA==&VEM9MjAxNDA5MTk=&U0VSVkVSX0lEPTAx&S0lORD1D&Q0lEPTA2Mg==&URL=http://www.uplus.co.kr/css/unws/ublv/RetrieveUbLvInfo.hpi?mid=2256" COORDS="506,376,570,387" ALT="자세히보기" target="_blank()" onfocus="this.blur()">
</MAP>

</div>
<!--// 사랑을 전하는 청구서 -->
<!--// 20110323 수정 -->

<!-- 201401 수정 -->
<!-- 분리청구 상세내역_모반 -->

<!-- //분리청구 상세내역 -->
<!-- 201401 수정 -->

<!-- //date 시작 -->
</div>
<!--  print end -->
</td>
<!-- //content -->
<!-- sideMenu -->
<td width="175" valign="top" style="background: url(http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/contrainer_boxLine_right.gif) repeat-y;   left: top;">
<!-- 오른쪽 메뉴 -->
<div id="navi_tab">
<ul>

<li> <a href="javascript:click_check('http://58.150.244.95:80/Check.html?TV9JRD0yODMwMDExODcyOTBfMjkxOTAwMDM=&U1RZUEU9QVVUTw==&TElTVF9UQUJMRT1BVVRPMTIw&UE9TVF9JRD0yMDE0MDkxMl83NA==&VEM9MjAxNDA5MTk=&U0VSVkVSX0lEPTAx&S0lORD1D&Q0lEPTA2NA==','n1');" ><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_1_on.jpg" border="0"  id="contb1" alt="청구요약" ></a> </li>

<li class="categori"><a href="javascript:click_check('http://58.150.244.95:80/Check.html?TV9JRD0yODMwMDExODcyOTBfMjkxOTAwMDM=&U1RZUEU9QVVUTw==&TElTVF9UQUJMRT1BVVRPMTIw&UE9TVF9JRD0yMDE0MDkxMl83NA==&VEM9MjAxNDA5MTk=&U0VSVkVSX0lEPTAx&S0lORD1D&Q0lEPTA2NQ==','n2');" > <img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_2_off.jpg" border="0" id="contb2" alt="청구내역" ></a></li>


<li class="categori"><a href="javascript:click_check('http://58.150.244.95:80/Check.html?TV9JRD0yODMwMDExODcyOTBfMjkxOTAwMDM=&U1RZUEU9QVVUTw==&TElTVF9UQUJMRT1BVVRPMTIw&UE9TVF9JRD0yMDE0MDkxMl83NA==&VEM9MjAxNDA5MTk=&U0VSVkVSX0lEPTAx&S0lORD1D&Q0lEPTA2Ng==','n3');" > <img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201207/mail_content_sidetab_3_off.jpg" border="0" id="contb3" alt="서비스 상세내역" ></a></li>


<li class="categori"><a href="javascript:click_check('http://58.150.244.95:80/Check.html?TV9JRD0yODMwMDExODcyOTBfMjkxOTAwMDM=&U1RZUEU9QVVUTw==&TElTVF9UQUJMRT1BVVRPMTIw&UE9TVF9JRD0yMDE0MDkxMl83NA==&VEM9MjAxNDA5MTk=&U0VSVkVSX0lEPTAx&S0lORD1D&Q0lEPTA2OA==','n4');" > <img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_4_off.jpg" border="0" id="contb4" alt="안내사항" ></a></li>

<li class="categori"><a href="javascript:click_check('http://58.150.244.95:80/Check.html?TV9JRD0yODMwMDExODcyOTBfMjkxOTAwMDM=&U1RZUEU9QVVUTw==&TElTVF9UQUJMRT1BVVRPMTIw&UE9TVF9JRD0yMDE0MDkxMl83NA==&VEM9MjAxNDA5MTk=&U0VSVkVSX0lEPTAx&S0lORD1D&Q0lEPTA2OQ==','n5');" > <img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_5_off.jpg" border="0" id="contb5" alt="청구서/영수증" ></a></li>

<!--이벤트/서비스 -->


<li class="categori"><a href="javascript:click_check('http://58.150.244.95:80/Check.html?TV9JRD0yODMwMDExODcyOTBfMjkxOTAwMDM=&U1RZUEU9QVVUTw==&TElTVF9UQUJMRT1BVVRPMTIw&UE9TVF9JRD0yMDE0MDkxMl83NA==&VEM9MjAxNDA5MTk=&U0VSVkVSX0lEPTAx&S0lORD1D&Q0lEPTA3MA==','n6');" > <img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_6_off.jpg" border="0" id="contb6" alt="이벤트/서비스" ></a></li>


<!--나만의 혜택 -->


<li class="categori"><a href="javascript:click_check('http://58.150.244.95:80/Check.html?TV9JRD0yODMwMDExODcyOTBfMjkxOTAwMDM=&U1RZUEU9QVVUTw==&TElTVF9UQUJMRT1BVVRPMTIw&UE9TVF9JRD0yMDE0MDkxMl83NA==&VEM9MjAxNDA5MTk=&U0VSVkVSX0lEPTAx&S0lORD1D&Q0lEPTA3MQ==','n7');" > <img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_7_off.jpg" border="0" id="contb7" alt="나만의혜택" ></a></li>




<li class="categori"><a href="javascript:click_check('http://58.150.244.95:80/Check.html?TV9JRD0yODMwMDExODcyOTBfMjkxOTAwMDM=&U1RZUEU9QVVUTw==&TElTVF9UQUJMRT1BVVRPMTIw&UE9TVF9JRD0yMDE0MDkxMl83NA==&VEM9MjAxNDA5MTk=&U0VSVkVSX0lEPTAx&S0lORD1D&Q0lEPTA3Mg==','n8');" > <img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/mail_content_sidetab_n8_off.jpg" border="0" id="contb8" alt="사랑을전하는소식" ></a></li>


</ul>


</div>
<!-- //오른쪽 메뉴 -->
</td>
<!-- //sideMenu -->
</tr>
<tr>
<td colspan="3"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/contrainer_boxLine_btm.gif" border="0" alt=""></td>
</tr>
</table>
<!-- //contrainer -->
<!-- balnk -->
<table width="100%" cellpadding="0" cellspacing="0" border="0">
<tr>
<td height="48"></td>
</tr>
</table>
<!-- //balnk -->
<!-- 20120113 수정 -->
<!-- footer -->
<table width="836" cellpadding="0" cellspacing="0" border="0">
<tr>
<td height="1" bgcolor="dbdbdb"></td>
</tr>
<tr>
<td valign="top" style="padding: 16px 0;">
<table width="836" cellpadding="0" cellspacing="0" border="0">
<tr>
<td width="127" valign="top" style="padding: 17px 0 0 0;"><a href="http://58.150.244.95:80/Check.html?TV9JRD0yODMwMDExODcyOTBfMjkxOTAwMDM=&U1RZUEU9QVVUTw==&TElTVF9UQUJMRT1BVVRPMTIw&UE9TVF9JRD0yMDE0MDkxMl83NA==&VEM9MjAxNDA5MTk=&U0VSVkVSX0lEPTAx&S0lORD1D&Q0lEPTA3Mw==&URL=http://www.uplus.co.kr/" target="_blank()" onfocus="this.blur()"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201009/footer_logo.gif" border="0" alt=""></a></td>
<td width="709" valign="top"><img src="http://image.uplus.co.kr/img_server/ebill/new/mobile/201112/footer_copyright3.gif" border="0" alt="" usemap="#foot"></td>
</tr>
</table>
</td>
</tr>
</table>
<!-- //footer -->
<!-- //20120113 수정 -->
</td>
</tr>
</table>
</div>
<div id="objSelection" style="width:643px"></div>
<div id="tax_area" class="tax_area" style="display: none;">



<!-- *************** 지로 대상일 경우 ****************** -->

<div class="tax_bg">
<!-- 책번호,일련번호/공급자/공급받은자-->

<table width="576" border="0" cellspacing="0" cellpadding="0">

<tr>

<td height="24" colspan="2" align="right" style="padding-right:5px;font-size:11px"><b>납입자번호 : 283001187290</b></td>

</tr>

<tr>

<td height="61" colspan="2" align="right" valign="top" style="padding:3px 4px 0 0">

<!-- 책번호 일련번호-->

<table width="126" border="0" cellspacing="0" cellpadding="0">

<tr>

<td width="60" height="26" align="right" style="padding:3px 20px 0 0"></td>

<td width="66" align="right" style="padding:3px 20px 0 0"></td>

</tr>

</table>

<table width="126" border="0" cellspacing="0" cellpadding="0">

<tr>

<!--<td width="24" height="27" align="right" style="padding-right:5px"></td>--><!-- 이메일 세금계선서의 일년번호는 년 미표기 -->

<td width="24" height="27" align="right" style="padding-right:5px"></td>

<td width="102" align="right" style="padding-right:5px">98</td>

</tr>

</table>

<!-- 책번호 일련번호//--></td>

</tr>

<tr>

<td width="260" height="143" valign="top"><table width="260" border="0" cellspacing="0" cellpadding="0">

<tr>

<td width="56" height="36"></td>

<td width="200" align="center"><input name="textfield" type="text" class="box" id="textfield" style="width:30px" value="220"> -

<input name="textfield" type="text" class="box" id="textfield" style="width:20px" value="81"> -

<input name="textfield" type="text" class="box" id="textfield" style="width:40px" value="39938"></td>

</tr>

<tr>

<td height="36"></td>

<td></td>

</tr>

<tr>

<td height="36"></td>

<td>서울특별시 중구 남대문로5가 827번지</td>

</tr>

</table></td>

<td width="306" valign="top"><table width="308" border="0" cellspacing="0" cellpadding="0">

<tr>

<td width="60" height="36"></td>

<td colspan="3" align="center"><input name="textfield" type="text" class="box" id="textfield" style="width:30px" value="500"> -

<input name="textfield" type="text" class="box" id="textfield" style="width:20px" value="31"> -

<input name="textfield" type="text" class="box" id="textfield" style="width:40px" value=""></td>

</tr>

<tr>

<td height="49"></td>

<td width="144"></td>

<td width="27"></td>

<td width="77">윤철수</td>

</tr>

<tr>

<td height="28"></td>

<td colspan="3"> </td>

</tr>

</table>

<table width="308" border="0" cellpadding="0" cellspacing="0">

<tr>

<td width="53" height="27"></td>

<td width="97" align="center"></td>

<td width="20"></td>

<td width="138"></td>

</tr>

</table></td>

</tr>

</table>

<!-- 책번호,일련번호/공급자/공급받은자//-->

<table width="576" border="0" cellspacing="0" cellpadding="0">

<tr>

<td width="316" height="63" valign="bottom">

<!-- 작성/공급가액/세액-->

<table width="316" border="0" cellpadding="0" cellspacing="0">

<tr>

<td width="40" height="20" align="center"></td>

<td width="19" align="center"></td>

<td width="19" align="center"></td>

<td width="28" align="center"></td>

<td width="10" align="center"></td>

<td width="10" align="center"></td>

<td width="10" align="center"></td>

<td width="10" align="center"></td>

<td width="10" align="center"></td>

<td width="10" align="center"></td>

<td width="10" align="center"></td>

<td width="10" align="center"></td>

<td width="10" align="center"></td>

<td width="10" align="center"></td>

<td width="10" align="center"></td>

<td width="10" align="center"></td>

<td width="10" align="center"></td>

<td width="10" align="center"></td>

<td width="10" align="center"></td>

<td width="10" align="center"></td>

<td width="10" align="center"></td>

<td width="10" align="center"></td>

<td width="10" align="center"></td>

<td width="10" align="center"></td>

<td width="10" align="center"></td>

</tr>

</table>

<!-- 작성/공급가액/세액//-->

</td>

<td align="right" valign="top">

<!-- 비고-->

<table width="97%" border="0" cellspacing="0" cellpadding="0">

<tr>

<td height="25"></td>

</tr>

<tr>

<td height="18"></td>

</tr>

<tr>

<td height="20"></td>

</tr>

</table>

<!-- 비고//-->            </td>

</tr>

</table>

<!-- 리스트-->

<table width="576" border="0" cellspacing="0" cellpadding="0">

<tr>

<td width="21" height="20"></td>

<td width="19"></td>

<td width="177"></td>

<td width="24"></td>

<td width="65"></td>

<td width="58"></td>

<td width="95"></td>

<td width="88"></td>

<td width="29"></td>

</tr>

<tr>

<td height="24" align="center"></td>

<td align="center"></td>

<td colspan="3" class="item"></td>

<!--<td align="center"></td>-->

<!--<td align="center"></td>-->

<td align="right" class="num_amount"></td>

<td align="right"  class="num_amount">0</td>

<td align="right"  class="num_amount">0</td>

<td align="center"></td>

</tr>

<tr>

<td height="24" align="center"></td>

<td align="center"></td>

<td class="item"></td>

<td align="center"></td>

<td align="center"></td>

<td align="right" class="num_amount"></td>

<td align="right"  class="num_amount"></td>

<td align="right"  class="num_amount"></td>

<td align="center"></td>

</tr>

<tr>

<td height="24" align="center"></td>

<td align="center"></td>

<td class="item"></td>

<td align="center"></td>

<td align="center"></td>

<td align="right" class="num_amount"></td>

<td align="right"  class="num_amount"></td>

<td align="right"  class="num_amount"></td>

<td align="center"></td>

</tr>

<tr>

<td height="24" align="center"></td>

<td align="center"></td>

<td class="item"></td>

<td align="center"></td>

<td align="center"></td>

<td align="right" class="num_amount"></td>

<td align="right"  class="num_amount"></td>

<td align="right"  class="num_amount"></td>

<td align="center"></td>

</tr>

</table>

<!-- 리스트//-->



<table width="576" border="0" cellspacing="0" cellpadding="0">

<tr>

<td width="117" height="25"></td>

<td width="82"></td>

<td width="82"></td>

<td width="87"></td>

<td width="82"></td>

<td width="126"></td>

</tr>

<tr>

<td height="45" align="center"><strong>34,360</strong></td>

<td align="center"></td>

<td align="center"></td>

<td align="center"></td>

<td align="center"></td>

<td></td>

</tr>

</table>
</div>



</div>

</div>
<div id="MOBILE" style="display:none; width:0px; max-height:0px; overflow:hidden;">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=1.0, width=device-width" />
<link rel="stylesheet" type="text/css" href='http://58.150.244.95/pm_bill/css/common.css' media="screen, projection, print" />
<link rel="stylesheet" type="text/css" href='http://58.150.244.95/pm_bill/css/compSmart.css' media="screen, projection, print" />
<script type="text/javascript" src="http://58.150.244.95/pm_bill/js/jquery.js">
</script>

<script type="text/javascript" src="http://58.150.244.95/pm_bill/js/common.js">
</script>


</head>





<body style="background:#ffffff">
<link rel="stylesheet" type="text/css" href="http://58.150.244.95/pm_bill/css/compUplus.css" media="screen, projection, print" />
<script src="http://58.150.244.95/pm_bill/js/m.min.js" type="text/javascript"></script>
<div id="wap">

<!-- 메뉴 위 상단  -->
<div class="top">
<div class="FL">
<IMG src="http://58.150.244.95/pm_bill/img/simbol_lgup.png" alt="">
</div>
<div class="FR">
<span class="logo"><IMG src="http://58.150.244.95/pm_bill/img/logo1_lgup.png" alt=""></SPAN>
<P class="month">
2014. <span style="FONT-SIZE: 135%"> 09</SPAN>
</P>
</div>
</div>


<nav id="navi2">
<!-- 메뉴 tab -->





<div class="tab tp" id="topMenu" style="overflow:hidden;">
<div id="scroller">
<a style="min-width:32.9%" id="link_1" class="on" onclick="tabView1(this, 'tab_2');jQuery('div').filter('#tab_1_id').show(); jQuery('div').filter('#tab_4_id').hide(); jQuery('tr').filter('#tab_25_detail').hide();">청구요약</a>
<a style="min-width:32.8%"class="" onclick="tabView1(this,'tab_3');jQuery('div').filter('#tab_1_id').show(); jQuery('div').filter('#tab_4_id').hide(); jQuery('tr').filter('#tab_5_detail').hide();jQuery('tr').filter('#tab_6_detail').hide();jQuery('tr').filter('#tab_8_detail').hide();jQuery('tr').filter('#tab_11_detail').hide(); jQuery('tr').filter('#tab_12_detail').hide();jQuery('tr').filter('#tab_13_detail').hide();jQuery('tr').filter('#tab_14_detail').hide(); jQuery('tr').filter('#tab_15_detail').hide();jQuery('tr').filter('#tab_16_detail').hide();jQuery('tr').filter('#tab_17_detail').hide(); jQuery('tr').filter('#tab_18_detail').hide();jQuery('tr').filter('#tab_19_detail').hide();jQuery('tr').filter('#tab_21_detail').hide(); jQuery('tr').filter('#tab_22_detail').hide();jQuery('tr').filter('#tab_26_detail').hide()">청구내역</a>
<a style="min-width:32.8%" id="link_5" class="" onclick="tabView1(this, 'tab_5');jQuery('div').filter('#tab_1_id').show();">영수증</a>

</div>
</div>

<!--<span class="arr_l"></span>
<span class="arr_r active"></span> -->
</nav>
<style>
#navi2 {position: relative;}
#scroller { margin-left:-2px;}
#navi2 .tab { height:35px;    text-align:center;    margin-left:0;    font-size:0;    white-space:nowrap;}
#navi2 .tab a { float:left; min-width:24.6%; display:block;    height:32px; text-align:center;    line-height:30px;    color:#fff;    font-size:13px;    letter-spacing:-1px; border:1px solid #fff; border-right:none; border-top:none; background:#c7accd;}
#navi2 .tab a.on{    background:#d0006f;    font-weight:bold; text-shadow:0 -1px #b70061;    color:#fff;  }
#navi2 .tab a:hover { text-decoration:none; cursor:pointer;}
#navi2 .tab.tp div { white-space:nowrap}

#tab_1, #tab_3, #tab_5, #tab_6, #tab_7, #tab_8 {
margin: 0 auto;
padding: 0 0 20px 0;
border-top: 1px solid #C7ACCD;
width: 95%;
}
</style>

<!-- 청구요약 tab 부분 -->

<div id="tab_2" class="main_page on" style="border-top:none;">
<!--mp_customizable_id="cst50"-->

<div id="tab_1_id" class="userinfo" style="height:auto; padding-tab:0px; padding-bottom:18px;">
<H2><span class="a1">윤철수</SPAN>
고객님께서 납부하실 금액은 <span class="a2">34,360원</SPAN>입니다
</H2>

</div>



<!--/mp_customizable_id="cst50"-->
<div class="priceTotal">
<table summary="청구내역 요약내용입니다.">
<COLGROUP>
<COL width="30%"><COL width="30%"><COL width="40%">
</COLGROUP>
<thead>
<tr>
<th scope="col">
총 이용하신 금액
</th>
<th scope="col">
할인받으신 금액
</th>
<th class="rn" scope="col" style="color:#d0006f">
납부하실 금액
</th>
</tr>
</thead>
<tbody>
<tr>
<td>
42,682원
</td>
<td>
-8,322원
</td>
<td class="total rn">
34,360원
</td>
</tr>
</tbody>
</table>
<div class='guidet MB0'>고객센터<br>- 모바일 : 휴대폰에서 국번없이 114(무료), 1544-0010(유료)<br>- 인터넷/TV/070 : 국번없이 101</div>

<div class="guidet MB10">
자세한 요금내역은 "이번달 요금 청구내역"을 참조하시기 바랍니다.
</div>
</div>

<!--/mp_customizable_id="cst1"-->
<div class="list_groupU on" onclick=m_slide1(this)>
<div class=Mtitle>
<H4>고객/납부정보</H4>
</div>
<div class=test>
<table id="t2" class="list_table on" summary="고객정보 내용입니다.">
<COLGROUP>
<COL width="50%"><COL width="50%">
</COLGROUP>
<tbody>
<tr>
<th class="bgc TL" scope=row>고객번호</th>
<td class="TR">283001187290</td>
</tr>
<tr>
<th class="bgc TL" scope=row>서비스번호</th>
<td class="TR">406073346275</td>
</tr>

<tr>
<th class="bgc TL" scope=row>이용기간</th>
<td class="TR">2014.08.01 ~ <BR>2014.08.31</td>
</tr>


 <!-- 자동 -->
<tr>
<th class="bgc TL" scope=row> 납기일</th>
<td class="TR">2014년 09월 30일</td>
</tr>
<tr>
<th class="bgc TL" scope=row>출금일 </th>
<td class="TR">09월 26일(9/29,30,10/2,6,8,10,13,15,17)&nbsp;</td>
</tr>

<tr>
<th class="bgc TL" scope=row>납부방법</th>
<td class=TR>은행자동이체</td>
</tr>

<tr>
<th class="bgc TL" scope=row>금융기관</th>
<td class="TR">우리은행</td>
</tr>
<tr>
<th class="bgc TL" scope=row>예금주명</th>
<td class="TR">윤철수</td>
</tr>
<tr>
<th class="bgc TL" scope=row>계좌/카드번호</th>
<td class="TR">422*******7</td>
</tr>

</tbody>
</table>
</div>
</div>


</div>
<!--mp_customizable_id="cst62"-->


<!-- 청구 내역 부분 tab02 -->
<div id="tab_3" class="main_page"><!--상세내역-->


<div class="list_groupU on" onClick="m_slide1(this)">
<div class=Mtitle>
<H4>이번달 요금 청구내역</H4>
</div>
<div class=test>
































































<table class="list_table on" summary="이번달 요금 청구내역입니다.">
<COLGROUP>
<COL width="70%"><COL><COL width="30%">
</COLGROUP>
<tbody>






<tr>


<td class='bgc bno' style='border-top:1px solid #c7accd;border-bottom:1px solid #c7accd;color:#333333;' >


<span style="font-size: 14px; font-weight: bold;">&nbsp;&nbsp;



U+ 인터넷


</span>

</td>


<td class='bgc TR bno' style='width:30%;border-top:1px solid #c7accd;border-bottom:1px solid #c7accd;' >


<strong>



28,200원



</strong>

</td>
</tr>






<tr>


<td class='TL bno' style='color:#333333;' >

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

<strong>


기본요금
</strong>


</td>


<td class='TR bno'>




&nbsp;



</td>
</tr>






<tr>


<td class='TL bno' style='color:#333333;' >

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;



기본료


</td>


<td class='TR bno'>




33,000원



</td>
</tr>






<tr>


<td class='TL bno' style='color:#333333;' >

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

<strong>


부가서비스
</strong>


</td>


<td class='TR bno'>




&nbsp;



</td>
</tr>






<tr>


<td class='TL bno' style='color:#333333;' >

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;



클린웹


</td>


<td class='TR bno'>




3,000원



</td>
</tr>






<tr>


<td class='TL bno' style='color:#333333;' >

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

<strong>


할인요금
</strong>


</td>


<td class='TR bno'>




-7,800원



</td>
</tr>






<tr>


<td class='bgc bno' style='border-top:1px solid #c7accd;border-bottom:1px solid #c7accd;color:#333333;' >


<span style="font-size: 14px; font-weight: bold;">&nbsp;&nbsp;



U+ 070


</span>

</td>


<td class='bgc TR bno' style='width:30%;border-top:1px solid #c7accd;border-bottom:1px solid #c7accd;' >


<strong>



3,558원



</strong>

</td>
</tr>






<tr>


<td class='TL bno' style='color:#333333;' >

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

<strong>


기본요금
</strong>


</td>


<td class='TR bno'>




&nbsp;



</td>
</tr>






<tr>


<td class='TL bno' style='color:#333333;' >

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;



기본료


</td>


<td class='TR bno'>




2,000원



</td>
</tr>






<tr>


<td class='TL bno' style='color:#333333;' >

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

<strong>


통화요금
</strong>


</td>


<td class='TR bno'>




&nbsp;



</td>
</tr>






<tr>


<td class='TL bno' style='color:#333333;' >

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;



국내통화료


</td>


<td class='TR bno'>




1,558원



</td>
</tr>








































<tr>


<td class='bgc bno' style='border-top:1px solid #c7accd;border-bottom:1px solid #c7accd;color:#333333;' >



<span style="font-size: 14px; font-weight: bold;">&nbsp;&nbsp;

세금 및 공통요금
</span>
&nbsp;
</td>


<td class='bgc TR bno' style='width:30%;border-top:1px solid #c7accd;border-bottom:1px solid #c7accd;' >


2,602원
</td>
</tr>



<tr>

<td class="TL bno">

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

자동이체할인
&nbsp;
</td>

<td class='TR bno'>

-314원
</td>
</tr>



<tr>

<td class="TL bno">

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

e-mail청구할인
&nbsp;
</td>

<td class='TR bno'>

-200원
</td>
</tr>



<tr>

<td class="TL bno">

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;




부가가치세
&nbsp;
</td>

<td class='TR bno'>

3,124원
</td>
</tr>



<tr>

<td class="TL bno">

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;


<span style="color: #ec008c;"> (*) </span>

10원미만 할인
&nbsp;
</td>

<td class='TR bno'>

-8원
</td>
</tr>








































<tr>
<td class='bgctl bno' style='border-top:1px solid #c7accd;border-bottom:1px solid #c7accd;;color:#333333;' >이번달 요금 계(A)</td>
<td class='bgctl TR bno' style='border-top:1px solid #c7accd;border-bottom:1px solid #c7accd;' >34,360원</td>
</tr>



<tr>
<td class="bgctl bno" style="border-top:1px solid #c7accd;color:#333333;">
미납 요금 계(B)
</td>
<td class="bgctl TR bno" style="border-top:1px solid #c7accd;">
0원
</td>
</tr>


<!--/mp_customizable_id="cst42"-->
<tr>
<td class="bgcbl" style="border-top:1px solid #c7accd;color:#333333;">
총 납부하실 금액
<BR>
(A)+(B)
</td>
<td class="bgcbl TR" style="border-top:1px solid #c7accd;">
34,360원
</td>
</tr>
</tbody>
</table>

</div>
</div>



<!--mp_customizable_id="cst46"-->




































<div class="list_groupU on" onClick="m_slide1(this)">
<div class=Mtitle>
<H4>이번달 할인 상세내역</H4>
</div>
<div class=test>
<table id="t2" class="list_table on" summary="이번달 할인 상세내역입니다.">
<COLGROUP>
<COL width="65%"><COL width="35%">
</COLGROUP>
<tr>
<td class="bgctl" scope="col"> 할인내역</td>
<td class="bgctr TC" scope="col">금액 </td>
</tr>
<!--lv21430-->




<!-- 소계 flag 추가 20120211 -->

<!--		


<tr>

<td class='bgc bno' style='border-top:1px solid #c7accd;border-bottom:1px solid #c7accd;color:#333333;' >&nbsp;&nbsp;<b>U+ 인터넷</b></td>



</td>



<td class='bgc TR bno' style='border-top:1px solid #c7accd;border-bottom:1px solid #c7accd;' ></td>



</tr>




<tr>


<td class='TL bno' style='color:#333333;' >
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 약정할인


</td>





<td class='TR bno'>
-5,000원
</td>

</tr>




<tr>


<td class='TL bno' style='color:#333333;' >
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 결합상품할인


</td>





<td class='TR bno'>
-2,800원
</td>

</tr>




<tr>

<td class='bgc bno' style='border-top:1px solid #c7accd;border-bottom:1px solid #c7accd;color:#333333;' >&nbsp;&nbsp;<b>기타할인</b></td>



</td>



<td class='bgc TR bno' style='border-top:1px solid #c7accd;border-bottom:1px solid #c7accd;' ></td>



</tr>




<tr>


<td class='TL bno' style='color:#333333;' >
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 자동이체할인


</td>





<td class='TR bno'>
-314원
</td>

</tr>




<tr>


<td class='TL bno' style='color:#333333;' >
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; e-mail청구할인


</td>





<td class='TR bno'>
-200원
</td>

</tr>




<tr>


<td class='TL bno' style='color:#333333;' >
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10원미만 할인


<span style="color: #ec008c;"> (*) </span>

</td>





<td class='TR bno'>
-8원
</td>

</tr>




-->


<tr>

<td class='bgc bno' style='border-top:1px solid #c7accd;border-bottom:1px solid #c7accd;color:#333333;' >


<span style="font-size: 14px; font-weight: bold;">&nbsp;&nbsp;


U+ 인터넷

</span>

</td>


<td class='bgc TR bno' style='width:35%;border-top:1px solid #c7accd;border-bottom:1px solid #c7accd;' >


<strong>


&nbsp;


</strong>

</td>
</tr>



<tr>

<td class='TL bno' style='color:#333333;' >

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;


약정할인

</td>


<td class='TR bno'>



-5,000원


</td>
</tr>



<tr>

<td class='TL bno' style='color:#333333;' >

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;


결합상품할인

</td>


<td class='TR bno'>



-2,800원


</td>
</tr>



<tr>

<td class='bgc bno' style='border-top:1px solid #c7accd;border-bottom:1px solid #c7accd;color:#333333;' >


<span style="font-size: 14px; font-weight: bold;">&nbsp;&nbsp;


기타할인

</span>

</td>


<td class='bgc TR bno' style='width:35%;border-top:1px solid #c7accd;border-bottom:1px solid #c7accd;' >


<strong>


&nbsp;


</strong>

</td>
</tr>



<tr>

<td class='TL bno' style='color:#333333;' >

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;


자동이체할인

</td>


<td class='TR bno'>



-314원


</td>
</tr>



<tr>

<td class='TL bno' style='color:#333333;' >

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;


e-mail청구할인

</td>


<td class='TR bno'>



-200원


</td>
</tr>



<tr>

<td class='TL bno' style='color:#333333;' >

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;


<span style="color: #ec008c;"> (*) </span>

10원미만 할인

</td>


<td class='TR bno'>



-8원


</td>
</tr>




<TFOOT>
















<tr>
<td class="bgctl fcp Fbold" style="color:#d0006f !important;background:#f0ddda !important;" scope="row"> 합계</td>
<td class="TR bgctr fcp Fbold" colSpan="2" style="background:#f5e8e6 !important;">-8,322원 </td>
</tr>


</TFOOT>
</table>
</div>
</div>

</div>



<!--/mp_customizable_id="cst46"-->
<!--/mp_customizable_id="cst62"-->
<!--mp_customizable_id="cst55"-->


<!-- 영수증 tab03-->
<div id="tab_5" class="main_page">
<!--mp_customizable_id="cst26"-->



<div class="list_groupU on" onclick=m_slide1(this)>
<div class=Mtitle>
<H4>전월납부 영수증</H4>
</div>
<div class="test rece">
<div style="PADDING-BOTTOM: 10px; MARGIN: auto; PADDING-LEFT: 10px; WIDTH: 230px; PADDING-RIGHT: 10px; BACKGROUND: rgb(255,255,255); PADDING-TOP: 10px">
<table id="t2" class="list_table2 on" summary="전월납부 영수증입니다." align=center>
<COLGROUP>
<COL width="50%"><COL width="50%">
</COLGROUP>
<!-- 이전달 내역이 있는경우 -->

<tbody>
<tr>
<th scope="row">고객명</th>
<td class="TR">윤철수</td>
</tr>
<tr>
<th scope="row"> 고객번호</th>
<td class="TR">283001187290</td>
</tr>
<tr>
<th scope="row">서비스번호</th>
<td class="TR">406073346275</td>
</tr>
















<tr>
<th scope="row">금융기관</th>
<td class="TR"> 우리은행 </td>
</tr>
<tr>
<th scope="row">예금주명</th>
<td class="TR">윤철수</td>
</tr>
<tr>
<th scope="row"> 계좌/카드번호</th>
<td class="TR">422*******7</td>
</tr>

</tbody>


</table>
<table id="t2" class="list_table2 on" summary="전월납부 영수증입니다." align=center>
<COLGROUP>
<COL width="30%"><COL width="25%"><COL width="45%">
</COLGROUP>











<tbody>
<tr>
<th class="bgc tbd" scope=row>납부일자</th>
<th class="TR bgc tbd" scope=row>영수금액</th>
<td class="TR bgc tbd">납부방법</td>
</tr>
<!--lv22550-->

<tr>
<th scope="row">2014.08.26</th>
<th class="TR" scope="row"> 34,160원</th>
<td class="TR PL5">은행자동이체</td>
</tr>




<!--/lv22550-->
</tbody>
</table>
</div>
</div>
</div>
<!--/mp_customizable_id="cst26"-->

</div>
<!--/mp_customizable_id="cst55"-->
<!--mp_customizable_id="cst56"-->

<!-- 단말기 할부 내역 tab04 -->






<div id="tab_6" class="main_page">




</div>
<!--/mp_customizable_id="cst56"-->

</div>

<!-- tab click check -->
<IMG width=0 height=0 id="tabopen" src="">
<!-- open action check -->
<IMG width=0 height=0 src="http://58.150.244.95:80/Check.html?TV9JRD0yODMwMDExODcyOTBfMjkxOTAwMDM=&U1RZUEU9QVVUTw==&TElTVF9UQUJMRT1BVVRPMTIw&UE9TVF9JRD0yMDE0MDkxMl83NA==&VEM9MjAxNDA5MTk=&U0VSVkVSX0lEPTAx&S0lORD1P">
</body>
</html>

</div>

</body>

<script defer type="text/javascript">





if(window.screen.width < 480){
//alert("navigator.userAgent :"+navigator.userAgent);
//if(navigator.userAgent.indexOf("Safari")!=-1){
if(navigator.userAgent.match(/iPhone|iPad|iPod/i)){
//alert("iphone");
document.getElementById('PC').style.display = 'block';
document.getElementById('PC').style.display = 'block';
document.getElementById('PC').style.width = '100%';
document.getElementById('PC').style.height = 'auto';
document.getElementById('PC').style.overflow = 'visible';
}else{
//alert("test1");
openwin = window.open("about:blank","mailbill4","toolbar=no,menubar=no,scrollbars=no,width=100px,height=100px");
openwin.document.write("<html><head>\r\n");
openwin.document.write("<meta http-equiv='Content-Type' content='text/html; charset=euc-kr' />");
openwin.document.write("<script language='JavaScript'>");
openwin.document.write("function viewMobile(){");
//openwin.document.write("alert('tttt');");

openwin.document.write("opener.document.getElementById('PC').style.display = 'none';");
openwin.document.write("opener.document.getElementById('PC').style.width = '0'; ");
openwin.document.write("opener.document.getElementById('PC').style.height = '0'; ");
openwin.document.write("opener.document.getElementById('PC').style.overflow = 'hidden';");
openwin.document.write("opener.document.getElementById('MOBILE').style.display = 'block';");
openwin.document.write("opener.document.getElementById('MOBILE').style.width = '100%';");
openwin.document.write("opener.document.getElementById('MOBILE').style.height = 'auto';");
openwin.document.write("opener.document.getElementById('MOBILE').style.overflow = 'visible';");
openwin.document.write("window.close();");

openwin.document.write("}");
openwin.document.write("function viewPC(){");
//openwin.document.write("alert('qqq');");

openwin.document.write("opener.document.getElementById('MOBILE').style.display = 'none';");
openwin.document.write("opener.document.getElementById('MOBILE').style.width = '0'; ");
openwin.document.write("opener.document.getElementById('MOBILE').style.height = '0'; ");
openwin.document.write("opener.document.getElementById('MOBILE').style.overflow = 'hidden';");
openwin.document.write("opener.document.getElementById('PC').style.display = 'block';");
openwin.document.write("opener.document.getElementById('PC').style.width = '100%';");
openwin.document.write("opener.document.getElementById('PC').style.height = 'auto';");
openwin.document.write("opener.document.getElementById('PC').style.overflow = 'visible';");
openwin.document.write("window.close();");

openwin.document.write("}");



openwin.document.write("<\/script>");
openwin.document.write("<style type='text/css'>");
//openwin.document.write("#overlay {position:fixed;top: 0;left: 0;width: //100%;height:100%;z-index:9989;background:url('http://hdev.uplus.co.kr:16081/common/ui/images/css/main/mobile/popup_bg.png');}");
openwin.document.write(".popup{width: 100%;margin: 0 auto;display: block;position: absolute;z-index: 9989;}");
openwin.document.write("#versionPop {width: 100%;height: 100%;position: absolute;z-index: 9990;background:none;}");
openwin.document.write("#versionPop .closePop {position:absolute;right:0;top:50px;}");
openwin.document.write(".versionarea {width:90%;border:3px solid #ccc;border-radius:4px;background:#fff;margin:200px auto 0 auto;}");
openwin.document.write(".versionarea ul {list-style:none;}");
openwin.document.write(".versionarea ul li {text-align:center;font-size:4.0em;font-weight:bold;color:#333;border-top:2px solid #ccc;margin:0;}");
openwin.document.write(".versionarea ul li:first-child {border-top:0;}");
openwin.document.write(".versionarea ul li a {display:block;padding:20px 0;text-decoration:none;}");
openwin.document.write("</style>");
openwin.document.write("</head>");
openwin.document.write("<body><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>");
openwin.document.write("<div id='versionPop' , style='display:block;'>");
openwin.document.write("<div class='popup'>");
openwin.document.write("<div class='versionarea'>");
openwin.document.write("<ul>");
openwin.document.write("<li><a href='javascript:viewPC();'>이메일(PC버전) 보기</a></li>");
openwin.document.write("<li><a href='javascript:viewMobile();'>이메일(모바일버전) 보기</a></li>");
openwin.document.write("</ul>");
openwin.document.write("</div>");
openwin.document.write("</div>");
openwin.document.write("</div>");
//openwin.document.write("<img src='http://biz.uplus.co.kr/ems50/images/btn_print.jpg'  border='0' onClick='javascript:bbb();' style='cursor:hand;'>");


openwin.document.write("</body></html>");
}
}else{
document.getElementById('PC').style.display = 'block';
document.getElementById('PC').style.width = '100%';
document.getElementById('PC').style.height = 'auto';
document.getElementById('PC').style.overflow = 'visible';
}


</script>
<!---END_ENC--->
</body>

</html>

