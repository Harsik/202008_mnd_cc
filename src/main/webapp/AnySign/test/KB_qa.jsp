<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>KB국민카드</title>
</head>
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

<body>
<!---BEGIN_ENC--->
	<table width="796" border="0" cellspacing="0" cellpadding="0" align="center">
		<tr>
			<td style="background:url('https://img1.kbcard.com/LT/images/email/layout2_1.gif') repeat-y">
				<a href="https://www.kbcard.com" target="_blank">
					<img src="https://img1.kbcard.com/LT/images/email/layout1_1.gif" alt="KB국민카드 / 공지 " width="796" height="64" border="0" style="margin:0px;display:block;"/>
				</a>
			</td>
		</tr>
		<tr>
			<td align="center" style="background:url('https://img1.kbcard.com/LT/images/email/layout2_1.gif') repeat-y; padding-bottom:20px">
			<!-----////////////////////// 본인이 제작한 컨텐츠 테이블 시작///////////////---------->
			<!--
			<div style="padding:0; margin:0;">
				<img src="https://img1.kbcard.com/LT/img/mail/billing/webzine1/1203a/20141222_email_top.jpg" alt="" usemap="#Map" border="0" />
				<div style="display: block; font-size: 0; height: 0px; left: -9999px; line-height: 0; overflow: hidden; text-indent: -9999px; width: 0px;">
				  <p>e-메일명세서</p>
					<span>명세서를 확인하시려면 첨부파일을 클릭하세요! * 보안메일의 비밀번호는 주민등록 상 생년월일 6자리입니다.</span>
					<ul>
						<li>
							피싱방지를 위한 개인인식문자란? e-메일명세서 제목에 개인인식문자를 넣어 안전하게 발송해드립니다.
							<a href="#">상세보기</a>
						</li>
						<li>
							나의 명세서 보안여부 변경하기
							<a href="#">상세보기</a>
						</li>
					</ul>
				</div>
			</div>
			<p style="margin-top:5px; width:700px; font-size:12px; text-align:left; color:#97220e; text-indent:-10px; padding-left:12px; line-height:16px;">
				* e-Catalog는 정보통신망법 제 50조 제 4항(영리목적의 광고성 정보 명시)에 따라 향후 e-메일명세서와 함께 발송해 드리지<br/>
				못하오니  <a href="https://www.kbcard.com" target="_blank">KB국민카드 홈페이지</a> 회사소개 > 회사안내 > 사이버홍보관 > KB국민카드매거진 > 'e-Life'를 통하여 확인하시기 바랍니다.
			</p>
			<map name="Map">
				<area shape="rect" coords="29,214,452,273" href="https://customer.kbcard.com/CXCCSFICinfo.cms" target="_blank" alt="e-메일명세서 개인인식문자 상세보기" />
				<area shape="rect" coords="511,217,680,272" href="https://card.kbcard.com/cxo/jsp/cmn/kbcardGTM.jsp?cmsId=CXPPPMYS0135.cms" target="_blank" alt="나의 명세서 보안여부 변경 상세보기" />
			</map>
			-->
			<!-----////////////////////// 본인이 제작한 컨텐츠 테이블 끝/////////////////---------->
		</td>
	</tr>
	<tr>
		<td>
			<img src="https://img1.kbcard.com/LT/images/email/mailing_crd_foot_bar.gif" width="796" border="0" style="margin:0px; display:block;"/>
		</td>
	</tr>
	<tr>
		<td width="100%" style="background:url('https://img1.kbcard.com/LT/images/email/layout2_1.gif') repeat-y" align="center">
			<img src="https://img1.kbcard.com/LT/images/email/mailing_crd_foot_0107_2.jpg" alt="이 메일은 KB국민카드에서 발송한 발신전용 메일입니다." width="625" height="44" style="margin-top:6px"/>
		</td>
	</tr>
	<tr>
		<td style="background:url('https://img1.kbcard.com/LT/images/email/layout2_1.gif') repeat-y; padding-bottom:15px;" align="center">
			<img src="https://img1.kbcard.com/LT/images/email/mailing_crd_foot_13.gif" alt="국번없이 어디서나 1588-1688(유료)" width="198" height="16"/>
			<a href="https://customer.kbcard.com/CXCUTCEC0002.cms" target="_blank" style="text-decoration:none">
				<img src="https://img1.kbcard.com/LT/images/email/mailing_crd_foot_11.gif" width="26" height="16" border="0"alt=""/>
				<img src="https://img1.kbcard.com/LT/images/email/mailing_crd_foot_14.gif" alt="ARS 메뉴안내" width="79" height="16" border="0"/>
			</a>
			<img src="https://img1.kbcard.com/LT/images/email/mailing_crd_foot_11.gif" width="26" height="16" alt="" />
			<a href="https://customer.kbcard.com/CXCUTCECINDE.cms" target="_blank" style="text-decoration:none">
				<img src="https://img1.kbcard.com/LT/images/email/mailing_crd_foot_15.gif" alt="고객센터" width="55" height="16" border="0"/>
			</a>
			<img src="https://img1.kbcard.com/LT/images/email/mailing_crd_foot_11.gif" width="26" height="16"alt=""/>
			<a href="http://www.kbcard.com" target="_blank" style="text-decoration:none">
				<img src="https://img1.kbcard.com/LT/images/email/mailing_crd_foot_18.gif" alt="KB국민카드 홈페이지" width="110" height="16" border="0"/>
			</a>
		</td>
	</tr>
	<tr>
		<td>
			<img style="margin:0px;display:block;" src="https://img1.kbcard.com/LT/images/email/layout6_31.gif" width="796" alt="이메일 하단 내용"/>
			<div style="display: block; font-size: 0; height: 0px; left: -9999px; line-height: 0; overflow: hidden; text-indent: -9999px; width: 0px;">
				<span>서울특별시 종로구 새문안로3길 30 (주)KB국민카드 대표이사 김덕수</span>
				<ul>
					<li>사업자등록번호 : 101-86-61717</li>
					<li>통신판매업신고 : 제2011-서울종로-0277호</li>
                    <li>관광사업자등록번호 : 26004-2011-8호</li>
                </ul>
                <span>copyrightⓒ2011 KB Kookmin Card Co.Ltd.All Rights Reserved</span>
                <ul>
					<li>국가고객만족도 신용카드부문 2년연속 1위(2012-2013)한국생산성본부 선정</li>
					<li>한국산업의 고객만족도 체크카드부문 3년연속 1위(2011-2013)KMAC선정</li>
                    <li>한국서비스품질지수 신용카드부문 3년 연속 1위(2011-2013)한국표준협회-중앙일보 공동 선정</li>
                </ul>
                <span>국민을 먼저 생각합니다 KB금융그룹</span>				
			</div>
		</td>
	</tr>
</table>
</body>
</html>
<!--}            * IF CLAUSE PROCESSED BY RSL(Ricky Script Language) Interpreter.                 -->
<!--###################################################################################-->
<!--<SECURE-BENEATH>--><hr>
<!--<SECURE-MAIL-ARGS>Softforum</SECURE-MAIL-ARGS>-->
<!--###################################################################################-->
<html lang="ko">
<head>
<title>KB국민카드 e-메일명세서</title>
<script src="https://oimg1.kbstar.com/js/common/email/kbgraph.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<style type="text/css">
	.mail-style 					{color:#666; font-size:12px; line-height:130%;}
	.mail-style img					{display:inline;visibility: visible ;}
	.mail-style li					{background:url('https://img1.kbcard.com/LT/images/common/icon_dot01.gif') no-repeat 0 7px;padding-left:8px;line-height:160%;margin-top:7px;}
	.mail-style ul					{margin-top:13px;margin-bottom:10px; text-align:left; font-size:11px;list-style:none;padding:0px;margin:0px; color: #757270;line-height:1.6;}
	.mail-style table				{color:#666;}
	.mail-style .tbl_card1 		    {font-size:11px;border-top:1px solid #d7d7d7;border-bottom:0px solid #d7d7d7;color: #555555;}
	.mail-style .tbl_card1 th		{border-right:1px solid #d7d7d7;border-bottom:1px solid #d7d7d7;background-color:#f4f4f4; }
	.mail-style .tbl_card1 th.last	{border-right:0px;}
	.mail-style .tbl_card1 tr.even	{background-color:#F4F4F4;}
	.mail-style .tbl_card1 tr.odd	{background-color:#FFFFFF;}
	.mail-style .tbl_card1 td		{text-align:center; border-right:1px solid #d7d7d7;border-bottom:1px solid #d7d7d7;height: 30px}
	.mail-style .tbl_card1 td.right	{padding-right:5px;text-align:right;}
	.mail-style .tbl_card1 td.left	{text-align:left;}
	.mail-style .tbl_card1 td.last	{border-right:0px;}
	.mail-style .tbl_card1 a		{}
	.mail-style .details_view		{display:none;}
	.mail-style .hidettl 			{display:none;}
	.mail-style .color1				{color:#ff5400;} /* color 수정 */
	.mail-style .color2				{color:#be4c31;} /* color 수정 */
	.mail-style .color3				{color:#be4c31;} /* color 수정 */
	.mail-style .color4				{color:#930;}
	.mail-style .notice				{background-color:#f8f8f8;overflow-y:scroll;}
	.mail-style .height				{height: 140px;}
	.mail-style .height2			{height: 230px;}
	.mail-style .tglDisplay			{display:block;visibility: visible ;}
	.mail-style h4{display:none}

	.mail-style2 					{color:#000000; font-size:12px; line-height:130%;}
	.mail-style2 img				{display:none;}
	.mail-style2 li					{padding-left:8px;line-height:160%;}
	.mail-style2 table				{color:#000000;}
	.mail-style2 .tbl_card1 		{font-size:11px;border-top:1px solid #000000;border-bottom:0px solid #000000;color: #000000;}
	.mail-style2 .tbl_card1 th		{border-right:1px solid #000000;border-bottom:1px solid #000000;background-color:#FFFFFF; }
	.mail-style2 .tbl_card1 th.last	{border-right:0px;}
	.mail-style2 .tbl_card1 tr.even	{background-color:#FFFFFF;}
	.mail-style2 .tbl_card1 tr.odd	{background-color:#FFFFFF;}
	.mail-style2 .tbl_card1 td		{text-align:center; border-right:1px solid #000000;border-bottom:1px solid #000000;height: 30px}
	.mail-style2 .tbl_card1 td.right	{padding-right:5px;text-align:right;}
	.mail-style2 .tbl_card1 td.left	{text-align:left;}
	.mail-style2 .tbl_card1 td.last	{border-right:0px;}
	.mail-style2 .tbl_card1 a		{color:#000000;}
	.mail-style2 .details_view		{display:block;}
	.mail-style2 .hidettl 			{display:inline;}
	.mail-style2 .color1			{color:#000000;}
	.mail-style2 .color2			{color:#000000;}
	.mail-style2 .notice			{background-color:#FFFFFF;}
	.mail-style2 .height			{height: 100%;}
	.mail-style2 .height2			{height: 100%;}
	.mail-style2 .tglDisplay		{display:none;visibility: hidden ;}
	.mail-style2 h4{display:none}
	caption{visibility:hidden;font-size:0}
</style>

<script type="text/javascript">
	window.onload=setMenuPos;

function pie3()
{
	this.ct = 0;

	this.data      	= new Array();
	this.dataStr    = new Array();
	this.dataColor  = new Array();
	this.x_name    	= new Array();
	this.div_id		= new Array();
	this.max       	= 0;

	this.add = function(x_name, value, d_color, divId)
	{
		
		this.x_name.push(x_name);  
		this.data.push(parseInt(value,10));
		this.dataStr.push(value);
		this.dataColor.push(d_color);
		divId?this.div_id.push(divId):null;
		this.max += parseInt(value,10);
	}

	this.render = function(canvas, title, size)
	{
		var jg,cnv,r,sW,cH,sx,xy,st_angle,hyp;
		jg = new jsGraphics(canvas);
		cnv = document.getElementById(canvas);	
		cW = (cnv.style.width).substring(0,(cnv.style.width).lastIndexOf('px'));	
		cH = (cnv.style.height).substring(0,(cnv.style.height).lastIndexOf('px'));	

		r = size/2;
		sx = cW/2 - r-20;	
		sy = cH/2 - r ;
			
		hyp = r*1.25;	
		
		jg.setColor("gray");
		jg.fillEllipse(sx+3,sy+3,2*r,2*r);
		   
		st_angle = 0;
		for(i = 0; i<this.data.length; i++)
		{	if(this.data[i]<1){this.data[i]=1;}
			var angle = Math.round(this.data[i]/this.max*360);
			jg.setColor(this.dataColor[i]);
			jg.fillArc(sx,sy,2*r,2*r,st_angle,st_angle+angle);
			st_angle += angle;
			
		}

		st_angle = 0;
		my_old  = 0;
		for(i = 0; i<this.data.length; i++)
		{
			var angle = Math.round(this.data[i]/this.max*360);
			var pc = Math.round(this.data[i]/this.max*100);
			var ang_rads = (st_angle+(angle/2)) * (Math.PI/180);
			var my  = Math.sin(ang_rads) * hyp;
			var mx  = Math.cos(ang_rads) * hyp-35;
			
			mxa = (mx < 0 ? 55 : 0);
			if(st_angle==270){mxa=0;}
			if(st_angle>180 && st_angle<270){
				if(Math.abs(my-my_old)<10){
					my = my - 10;
				}
			}
			my_old  = my;

			st_angle += angle;

			
			jg.setColor("#666666");
			jg.setFont("verdana, arial, sans-serif","11px",Font.PLAIN);
			tx = parseInt(cW/2+mx-mxa);
			ty = parseInt(cH/2-my);
			if(pc>=5){
				jg.drawString( this.x_name[i],tx,ty, this.div_id[i]);
			}
			
		}
		jg.setColor("black");
		jg.drawEllipse(sx, sy, 2*r, 2*r);
		jg.paint();
	}
}

	function setMenuPos() {
		setInterval(setPosHeight, 100);
	}

	var tmpOffsetTop = 0;
    var h = new Array();
    function setPosHeight() {
        var t = new Array();
		if(!document.getElementById('subTab' )){return;}
		if(!document.getElementById('subTab2')){return;}

        if (tmpOffsetTop!=document.body.scrollTop)
        {
            var h1 = document.getElementById("subTab");
            var h2 = document.getElementsByTagName("h3");
            var h3 = document.getElementById("subTab2");
            
            if (!h.length) {
                h.push(parseInt(h1.style.top.replace(/\D/g,"")));
                for(var n=0;n<h2.length;n++) {
                    var tmp = parseInt(h2[n].style.top.replace(/\D/g,""));
                    h.push(tmp);
                }
                h.push(parseInt(h3.style.top.replace(/\D/g,"")));
            }

            t.push(h1);
            for(var n=0;n<h2.length;n++) {
                t.push(h2[n]);
            }
            t.push(h3);
            for(var n=0;n<t.length;n++) {
                t[n].style.top = (document.body.scrollTop+h[n])+"px";
            }
            tmpOffsetTop = document.body.scrollTop;
        }
    }


	function upp_viewLay_new(taborder, tabimg){
		//<!--IF Y == Y {--> 
		for (i=1;i<=5;i++){
			if(document.getElementById('contentsWrap0'+i)){
				if(taborder == i){
					tarimg = tabimg+ +i+"_on.gif";
					document.getElementById('contentsWrap0'+i).style.display = "block" ;
				}else{
					tarimg = tabimg+ +i+".gif";
					document.getElementById('contentsWrap0'+i).style.display = "none" ;
				}
			}
			if(document.getElementById('uppbtncontentsWrap0'+i)){document.getElementById('uppbtncontentsWrap0'+i).src = tarimg;}
		}
		//<!--} -->
	}

	function viewDetail(tabId, tabimg){
		if(document.getElementById(tabId)){
			if(document.getElementById(tabId).style.display!='block'||document.getElementById(tabId).style.display == "none"){
				document.getElementById(tabId).style.display = "block";
				document.getElementById('img'+tabId).src = tabimg + "_close.gif";
				if(document.getElementById(tabId).id.substring(0,12) =="details_view" ){document.getElementById('img'+tabId).alt = "상세보기 닫힘";}
				if(document.getElementById(tabId).id.substring(0,13) =="details_viewS"){document.getElementById('img'+tabId).alt = "이용안내 닫힘";}
			}else{
				document.getElementById(tabId).style.display = "none";
				document.getElementById('img'+tabId).src = tabimg + "_open.gif";
				if(document.getElementById(tabId).id.substring(0,12) =="details_view" ){document.getElementById('img'+tabId).alt = "상세보기 열림";}
				if(document.getElementById(tabId).id.substring(0,13) =="details_viewS"){document.getElementById('img'+tabId).alt = "이용안내 열림";}
			}
		}
	}

	function save2Xls_new(flg) { //<!-- * IF CLAUSE PROCESSED BY RSL(Ricky Script Language) Interpreter.  -->
	}


	function prtContent_1(flg,pop) { //<!--IF Y == Y {-->
		var bHtml = '';
		if(flg=='ALL'){
			if(document.getElementById('Header'))			{bHtml += document.getElementById('Header'		  ).innerHTML +'<br>';}
			if(document.getElementById('contentsWrap01'))	{bHtml += document.getElementById('contentsWrap01').innerHTML ;}
			if(document.getElementById('contentsWrap02'))	{bHtml += document.getElementById('contentsWrap02').innerHTML ;}
			if(document.getElementById('contentsWrap03'))	{bHtml += document.getElementById('contentsWrap03').innerHTML ;}
			if(document.getElementById('contentsWrap04'))	{bHtml += document.getElementById('contentsWrap04').innerHTML ;}
			if(document.getElementById('contentsWrap05'))	{bHtml += document.getElementById('contentsWrap05').innerHTML ;}
		}else{
			if(document.getElementById(flg)){bHtml = document.getElementById(flg).innerHTML ;}else{return;}
		}


		if(pop=="Y"){
			self.console=window.open('','dataview','width=680,height=600,menubar=0,toolbar=0,status=0,scrollbars=1,resizable=1');
			self.console.document.writeln(
				'<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" ><html><head>'
				+'<style type="text/css">'
				+'.mail-style2 .tbl_card1 		    {font-size:11px;border-top:1px   solid #000000;border-bottom:0px solid #000000;color: #000000;}'
				+'.mail-style2 .tbl_card1 th		{border-right:1px solid #000000;border-bottom:1px solid #000000;background-color:#FFFFFF; }'
				+'.mail-style2 .tbl_card1 th.last	{border-right:0px;}'
				+'.mail-style2 .tbl_card1 tr.even	{background-color:#FFFFFF;}'
				+'.mail-style2 .tbl_card1 tr.odd	{background-color:#FFFFFF;}'
				+'.mail-style2 .tbl_card1 td		{text-align:center; border-right:1px solid #000000;border-bottom:1px solid #000000;height: 24px}'
				+'.mail-style2 .tbl_card1 td.right	{padding-right:5px;text-align:right;}'
				+'.mail-style2 .tbl_card1 td.left	{text-align:left;}'
				+'.mail-style2 .tbl_card1 td.last	{border-right:0px;}'
				+'.mail-style2 .tbl_card1 a	'
				+'.mail-style2 .details_view	{display:block;}'
				+'.mail-style2 .hidettl			{display:inline;}'
				+'.mail-style2 img				{display:none;}'
				+'.mail-style2 .color1			{color:#000000;}'
				+'.mail-style2 .height			{height: 100%;}'
				+'.mail-style2 .height2			{height: 100%;}'
				+'.mail-style2 table			{color:#000000;}'
				+'.mail-style2 .tglDisplay		{display:none;visibility: hidden ;}'
				+'.mail-style2 li				{margin-left: 0px; margin-top:7px; list-style-type:disc;color:#000000;}'
				+'.mail-style2 ul				{padding: 2px; margin-left: 15px; margin-top:13px;margin-bottom:10px;text-align:left; font-size:11px;color: #000000;line-height:1.6;}'
				+'.mail-style2 a				{color:#000000;}'
				+'.mail-style2 h4				{display:none}'
				+'caption{visibility:hidden;font-size:0} '
				+'</style>'
				+'</head><body style="font-family:돋움, AppleGothic, sans-serif;color:#000000; font-size:11px;"><br/>'
				+'<div id="banner"><table width="650px" border="0" cellspacing="0" cellpadding="0">'
				+'<tr><td height="30" align="center" style="background-color:#ffcc3d "><a href="javascript:document.getElementById(\'banner\').style.display=\'none\';window.print();window.close();">'
				+'<img src="https://img1.kbcard.com/LT/images/mail/mail_details/printer_btn.gif" width="51" height="21" border="0" align="absmiddle"/></a>'
				+'</td></tr>'
				+'</table></div><br><br>'
				+'<table width="650px" border="0" cellspacing="0" >'
				+'<tr><td  style="color: #000000"><div class= "mail-style2" >\n<br>'
				+ bHtml
				+'</div></td></tr></table>'
				+ '<script>'
				+ 'var divTag = document.getElementsByTagName("DIV"); for (i=0;i<divTag.length;i++)  { if(divTag[i].id.substring(0,12) =="details_view"){divTag[i].style.display = "block";}}' 
				+ ' <\/script>' 
				+'</body></html>'
			)
			self.console.document.close();
		}else{
			if(document.getElementById('contents')){document.getElementById("contents").style.display="none";}
			if(document.getElementById('prtContens')){
				document.getElementById('prtContens').innerHTML = '<table style="width:650px;"><tr><td style="color: #000000;"><div class= "mail-style2" >' + bHtml + '</div></td></tr></table>';
				document.getElementById("prtContens").style.display="block";
				window.print();
				document.getElementById("prtContens").style.display="none";
			}
			if(document.getElementById('contents')){
				document.getElementById("contents").style.display="block";
			}
		}
	//  <!--} -->
	}

function hideTop() {
	if(document.getElementById('top_contents')){document.getElementById("top_contents").style.display="none";}
}

</script>

</head>
<body style="font-family:돋움, AppleGothic, sans-serif; background:url('https://img1.kbcard.com/LT/images/mail/mail_details/bg_wrap.gif') repeat; color:#666; ">
<center>
<img src="http://mailinfo.kbstar.com/check.jsp%AIMER_SYSTEM_KEY%&suc=2"  width="0" height="0">
<div id="prtContens"  class="mail-style2" style="width:650px;display:none;font-size:11px;background-color:#FFFFFF" ></div>
<div id="contents" class="mail-style"  style="width:1024px;height:100%; margin-left:-25px; background:url('https://img1.kbcard.com/LT/images/mail/mail_details/bg_wrap.gif') repeat;">
	<table border="0" cellspacing="0" cellpadding="0" style="position:relative;margin:25px;font-family:돋움, AppleGothic, sans-serif; font-size:11px; line-height:130%;">
		<tr>
		<!-- left_content -->
		<td style="vertical-align:top;">
			<!-- <a %OFR_ID=66% href='https://card.kbcard.com/CXPPPSVC5999.cms?returnURL=/KB/mall/kbpointree_email.asp' target="_new"><img src="https://img1.kbcard.com/LT/images/mail/mail_details/shopping_Bnr.gif" border="0" alt="e-메일명세서 고객님께 드리는 특별한 쇼핑제안" /></a> -->
		</td>
		<!-- //left_content -->
		<!-- middle_content -->
		<td style="width:698px;vertical-align:top;border:1px solid #d9d2d2;background-color:#fff;">
			<div id="top" style="padding-bottom: 30px;">
				<img src="https://img1.kbcard.com/LT/images/mail/mail_details/mail_details_top6.gif"  alt=""/>
			</div>
			
			<!-- Header -->
			<div id = "Header" style="padding-left: 25px;" >
				<table width="648px" border="0" cellspacing= "0" cellpadding="0" style="border-bottom: 1px solid #DFDFDF;vertical-align:top;">
				<tr>
					<td><span style="font-size:14px;color:#333;"><strong> 테스트</strong></span> <span style="font-size:14px;">고객님</span> <span style="font-size:12px;font-weight:normal;padding-left:15px;"> 2015년 06월 e-메일명세서입니다.</span></td>
					<td style="text-align: right;"><!--IF Y == Y {--> 
						<a href="javascript:prtContent_1('ALL','N')"><img src="https://img1.kbcard.com/LT/images/mail/mail_details/printer_btn.gif" border="0" alt="인쇄" style=".margin-top:13px;"/></a>
						<a href="javascript:prtContent_1('ALL','Y')"><img src="https://img1.kbcard.com/LT/images/mail/mail_details/preview_btn.gif" border="0" alt="인쇄미리보기" style=".margin-top:13px;"/></a> <!--} -->
					</td>
				</tr>
				</table>
			</div>
			<!--// Header -->

            <div id="subTab" style="position:absolute;right:-70px;top:0px"  ></div>

			<!-- 결제요약정보 -->
            <h3 class="sub-tab" style="position:absolute;right:-33px;top:90px"   >
                <a href='javascript:document.body.scrollTop=0;upp_viewLay_new("1","https://img1.kbcard.com/LT/images/mail/mail_details/mail_detailsMenu");'>
                    <img src="https://img1.kbcard.com/LT/images/mail/mail_details/mail_detailsMenu1_on.gif" border="0" alt="결제요약정보" id="uppbtncontentsWrap01"/>
                </a>
            </h3>
			<div id="contentsWrap01" style="width:100%;padding-top: 25px;padding-left: 25px; vertical-align:top; display:inline;min-height:700px;">
				<!-- 결제하실 총금액 -->
				<h4 style=" ">결제요약정보</h4>

				<table width="648px" border="0" cellspacing="0" cellpadding="0" style="margin-top:20px;padding-top: 20px;margin-bottom:8px;border-bottom:2px solid #5a5653;">
					<tr>
						<td style="padding-bottom:10px;">
							<span  class="hidettl" style=" font-size: 20px;font-weight: bold;">결제하실 총 금액</span>
							<img src="https://img1.kbcard.com/LT/images/mail/mail_details/tit_h2_email01.gif" alt="결제하실 총 금액" />
							<span class="color1" style="font-weight:bold; font-size:26px;  font-family: Tahoma,Geneva,sans-serif; padding-left:30px; line-height:1;">       3,199,702</span>
							<span  class="hidettl" style=" font-size: 20px;font-weight: bold;">원</span>
							<img src="https://img1.kbcard.com/LT/images/mail/mail_details/img_hyeWon.gif" alt="원" />
						</td>
						<td align="right">
							<p class="details_btn" style="text-align:right;"   >
							<a href="javascript:viewDetail('details_view01_1', 'https://img1.kbcard.com/LT/images/mail/mail_details/btn_view');"><img style='cursor:hand' id = 'imgdetails_view01_1' src="https://img1.kbcard.com/LT/images/mail/mail_details/btn_view_open.gif"  border="0" alt="상세보기 열림"   /></a>
							</p>
						</td>
					</tr>
					<!--IF Y == Y {-->
					<tr style="margin-top:0px;padding-top: 0px;padding-bottom: 5px;">
						<td colspan=2>
							<span  style="font-size: 12px;">카드 최소결제금액</span>&nbsp;
							<span style="color: #62492f;font-size: 11px;font-weight: bold;">433,601원</span>&nbsp;
							<span  style="font-size: 12px;">단, 장기카드대출(카드론) 제외. 일부결제금액이월약정(리볼빙) 등록 중</span>
						</td>

					</tr>
					<!--} -->
				</table>

				<table width="648px" border="0" cellspacing="0" cellpadding="0"  style="position:relative;top:5px;clear:both;color:#555;font-size:12px; margin-top:10px ;margin-bottom:20px;">
					<tr><td colspan="3">
						<div name = "details_view" id = "details_view01_1" class="details_view"   >
							<table width="648px" border="0" cellspacing="0" cellpadding="0" style=" border-bottom:1px solid #D7D7D7;" summary="청구내역,미결제금액,당월결제금액">
							<caption>청구내역,미결제금액,당월결제금액</caption>
							<colgroup><col width="50%"><col width="*"></colgroup>
							<tbody>
								<tr>
									<td style="padding:0px 0px 10px 5px;">
										<div style="width:100%;background:url('https://img1.kbcard.com/LT/images/mail/mail_details/img_line.gif') repeat-y right top;">
											<table width="100%" border="0" cellspacing="0" cellpadding="0" summary="결제금액 표" style="padding-right: 15px;font-size:12px; color#666;line-height:1.8;">
												<colgroup><col width="60%"><col width="40%"></colgroup>
												<tr><td style="color:#555; padding-top:4px;"><b>카드 결제하실 총 금액</b></td>	<td align="right"><b>       3,199,702</b></td></tr>
												<tr><td style="color:#555; padding-top:4px;">연회비/SMS</td>					<td align="right">               0</td></tr>
												<tr><td style="color:#555; padding-top:4px;">미결제 연체원금</td>		<td align="right">               0</td></tr>
												<tr><td style="color:#555; padding-top:4px;">미결제 연체이자</td>		<td align="right">               0</td></tr>
												<tr><td style="color:#555; padding-top:4px;">일시불</td>					<td align="right">             900</td></tr>
												<tr><td style="color:#555; padding-top:4px;">할부</td>					<td align="right">          87,352</td></tr>
												<tr><td style="color:#555; padding-top:4px;">단기카드대출(현금서비스)</td>				<td align="right">               0</td></tr>
												<tr><td style="color:#555; padding-top:4px;">해외이용</td>				<td align="right">               0</td></tr>
												<tr><td style="color:#555; padding-top:4px;">일부결제금액이월약정(리볼빙)</td>				<td align="right">       3,115,250</td></tr>
												<tr><td style="color:#555; padding-top:4px;">차감된 금액</td>			<td align="right">           3,800</td></tr>
											</table>
										</div>
									</td>
									<td style="padding:0px 0px 10px 5px;">
										<div>
											<table width="100%" border="0" cellspacing="0" cellpadding="0" summary="결제금액 표" style="font-size:12px; color#666;line-height:1.8;">
												<colgroup><col width="75%"><col width="*"></colgroup>
												<tr><td style="color:#555; padding-top:4px;"><b>장기카드대출(카드론) 결제하실 총 금액</b></td>	<td align="right"><b>-</b></td></tr>
												<tr><td style="color:#555; padding-top:4px;">미결제금액</td>					<td align="right">               0</td></tr>
												<tr><td style="color:#555; padding-top:4px;">이번달 결제하실 금액</td>			<td align="right">               0</td></tr>
												<tr><td style="color:#555; padding-top:4px;">수수료</td>						<td align="right">               0</td></tr>
												<tr><td style="color:#555; padding-top:4px;">&nbsp;</td>						<td align="right"></td></tr>
												<tr><td style="color:#555; padding-top:4px;">만기도래 금액</td>					<td align="right">               0</td></tr>
												<tr><td style="color:#555; padding-top:4px;">&nbsp;</td>						<td align="right"></td></tr>
												<tr><td style="color:#555; padding-top:4px;">&nbsp;</td>						<td align="right"></td></tr>
												<tr><td style="color:#555; padding-top:4px;">&nbsp;</td>						<td align="right"></td></tr>
												<tr><td style="color:#555; padding-top:4px;">&nbsp;</td>						<td align="right"></td></tr>
											</table>
										</div>
									</td>
								</tr>
							</tbody>
							</table>
							<!-- 이용안내 -->
							<div>
								<ul>
									<!--IF Y == Y {-->
									<li>카드 결제하실 최소금액 이상만 결제하셔도 정상적인 카드 사용이 가능합니다. 다만, 장기카드대출(카드론)의 결제일 및 결제계좌가 카드와 같은 경우 "카드 결제하실 총 금액+장기카드대출(카드론) 결제하실 금액"을 입금하셔야 정상 결제됩니다.</li>
									<!--} -->
									<li><b>명세서 작성기준일 현재 장기카드대출(카드론) 결제금액이 연체된 경우 안내가 제외될 수 있습니다.</b></li>
									<!-- * IF CLAUSE PROCESSED BY RSL(Ricky Script Language) Interpreter.  -->
								</ul>
							</div>
							<!-- //이용안내 -->
						</div>						
					</td></tr>
				</table>
				<!-- //결제하실 총금액 -->

				<!-- 이달의 할인금액 -->
				<!--IF YY != NN {-->
				<table width="648px" border="0" cellspacing="0" cellpadding="0" style="margin-top:20px;padding-top: 20px;margin-bottom:8px;border-bottom:2px solid #5a5653;">
					<tr>
						<td style="padding-bottom:10px;">
							<span  class="hidettl" style=" font-size: 20px;font-weight: bold;">이달의 할인금액</span>
							<img src="https://img1.kbcard.com/LT/images/mail/mail_details/tit_h2_email02.gif"  alt="이달의 할인금액"/>
							<span class="color1" style="font-weight:bold; font-size:26px;  font-family: Tahoma,Geneva,sans-serif; padding-left:30px; line-height:1;">      13,125</span>
							<img src="https://img1.kbcard.com/LT/images/mail/mail_details/img_hyeWon.gif" alt="원" />
							<span  class="hidettl" style=" font-size: 20px;font-weight: bold;">원</span>
						</td>
						<td align="right">
							<p class="details_btn" style="text-align:right;"   >
								<a href="javascript:viewDetail('details_view02', 'https://img1.kbcard.com/LT/images/mail/mail_details/btn_view' )"><img style='cursor:hand' id = 'imgdetails_view02' src="https://img1.kbcard.com/LT/images/mail/mail_details/btn_view_open.gif" border="0" alt="상세보기 열림" /></a>
							</p>
						</td>
					</tr>
					<tr style="margin-top:0px;padding-top: 0px;padding-bottom: 5px;">
						<td style="font-size: 12px;">2015년 누적할인혜택 (2015.01~2015.05)</td>
						<td style="text-align: right;padding-right:97px;padding-bottom:5px;color: #62492f;font-size: 11px;font-weight: bold;">107,302원</td>
					</tr>
				</table>
				<div class="details_view" name = "details_view" id = "details_view02" style="position:relative;.top:0px;"   >
					<table width="648px" border="0" cellspacing="0" cellpadding="0" style=" border-bottom:1px solid #D7D7D7;" summary="이달의 할인금액 표">
					<caption>이달의 할인금액</caption>
					<colgroup><col width="50%"><col width="50%"></colgroup>
					<tbody>
						<tr>
							<td style="padding:0px 0px 10px 15px;">
								<div style="width:100%;background:url('https://img1.kbcard.com/LT/images/mail/mail_details/img_line.gif') repeat-y right top;">
									<table width="100%" border="0" cellspacing="0" cellpadding="0" summary="이달의 할인금액 표" style="padding-right: 15px;font-size:12px; color#666;line-height:1.8;">
										<colgroup><col width="50%"><col width="50%"></colgroup>
										<tr><td style="color:#555;">스타샵 할인</td>		<td align="right">           0</td></tr>
										<tr><td style="color:#555;">주유할인</td>			<td align="right">           0</td></tr>
										<tr><td style="color:#555;">쇼핑할인</td>			<td align="right">           0</td></tr>
										<tr><td style="color:#555;">영화할인</td>			<td align="right">           0</td></tr>
										<tr><td style="color:#555;">엔터테인먼트할인</td>	<td align="right">           0</td></tr>
										<tr><td style="color:#555;">학원/서점/도서할인</td>	<td align="right">           0</td></tr>
										<tr><td style="color:#555;">의료비할인</td>			<td align="right">           0</td></tr>
										<tr><td style="color:#555;">통신요금할인</td>		<td align="right">       9,000</td></tr>
									</table>
								</div>
							</td>
							<td style="padding:0px 15px 10px 15px;">
								<div>
									<table width="100%" border="0" cellspacing="0" cellpadding="0" summary="이달의 할인금액 표" style="font-size:12px; color#666;line-height:1.8;">
										<colgroup><col width="50%"><col width="50%"></colgroup>
										<tr><td style="color:#555;">외식할인</td>		<td align="right">           0</td></tr>
										<tr><td style="color:#555;">여행/레저할인</td>	<td align="right">           0</td></tr>
										<tr><td style="color:#555;">교통할인</td>		<td align="right">           0</td></tr>
										<tr><td style="color:#555;">자동이체할인</td>	<td align="right">           0</td></tr>
										<tr><td style="color:#555;">유류세 환급</td>	<td align="right">           0</td></tr>
										<tr><td style="color:#555;">기타할인</td>		<td align="right">           0</td></tr>
										<tr><td style="color:#555;">무이자혜택금액</td>	<td align="right">       4,125</td></tr>
										<tr><td style="color:#555;">&nbsp;  </td>		<td align="right">&nbsp;</td>	</tr>
									</table>
								</div>
							</td>
						</tr>
					</tbody>
					</table>
				</div>
				<!--} -->
				<!-- //이달의 할인금액 -->
				
				<!-- 카드이용한도 / 카드론 가능금액-->
				<table width="648px" border="0" cellspacing="0" cellpadding="0" style="padding-top: 35px;">
					<tr>
						<td width="50%" style="vertical-align:top;">
							<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:50px;margin-bottom:8px;border-bottom:2px solid #5a5653;">
								<tr>
									<td style="padding-bottom:10px;padding-top:4px;"><span  class="hidettl" style=" font-size: 20px;font-weight: bold;">카드이용한도</span>
									<img src="https://img1.kbcard.com/LT/images/mail/mail_details/tit_h2_email03.gif" alt="카드이용한도"/></td>
									<td align="right" style="padding-bottom:5px;font-size:12px;">             500만원</td>
								</tr>
							</table>
							<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-bottom:1px solid #d7d7d7;font-size:12px;">
							<colgroup>
								<col width="50%"><col width="50%">
							</colgroup>

								<tr>
									<td height="20">일시불/할부</td><td align="right">카드이용한도 범위내</td>
								</tr>
								<tr>
									<td height="20">해외이용</td><td align="right"><!--IF                0 == 0 {-->               0<!--} --><!-- * IF CLAUSE PROCESSED BY RSL(Ricky Script Language) Interpreter.  --></td>
								</tr>
								<tr>
									<td height="20">단기카드대출(현금서비스)</td><td align="right">월간              170만원</td>
								</tr>
								<tr><td colspan="2" height="10"></td></tr>

							</table>
							<div>
								<p class="details_btn" style="text-align:right;margin-top:5px;margin-bottom:2px;"   >
									<a href="javascript:viewDetail('details_viewS04', 'https://img1.kbcard.com/LT/images/mail/mail_details/btnS_view' )" ><img style='cursor:hand' id = 'imgdetails_viewS04'   src="https://img1.kbcard.com/LT/images/mail/mail_details/btnS_view_open.gif" alt="이용안내 열림" border="0"/></a>
								</p>
							</div>
							<div class="details_view" name = "details_view" id = "details_viewS04" style="font-size:11px;"    >
								<ul>
									<!-- * IF CLAUSE PROCESSED BY RSL(Ricky Script Language) Interpreter.  -->
									<li>카드이용한도는 고객님의 신용도와 이용실적에 따라 수시로 변동될 수 있습니다. (현재 시점의 카드 잔여한도 조회☎1588-1688 ①→②번)</li>
									<li>해외이용한도는 국내이용한도에 실제환율(전신환매도율)이 적용된 금액으로 부여됩니다</li>
								</ul>
							</div>
						</td>
						<td width="50%" style="vertical-align:top;padding-left:15px;">
							<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:50px;margin-bottom:8px;border-bottom:2px solid #5a5653;">
								<tr>
									<td style="padding-bottom:10px;padding-top:4px;"><span  class="hidettl" style=" font-size: 20px;font-weight: bold;">장기카드대출(카드론) 가능금액</span><img src="https://img1.kbcard.com/LT/images/mail/mail_details/tit_h2_email04_1.gif" alt="장기카드대출(카드론) 가능금액" ></td>
									<td align="right" style="padding-bottom:5px;font-size:12px;"><a %OFR_ID=51% href="https://card.kbcard.com/cxo/jsp/cmn/kbcardGTM.jsp?cmsId=CXPPPFIS0047.cms" target="_blank"><img src="https://img1.kbcard.com/LT/images/mail/mail_details/btn_card_1.gif" border="0" alt="장기카드대출(카드론)신청"></a></td>
								</tr>
							</table>
							<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-bottom:1px solid #d7d7d7;font-size:12px;">
								<colgroup>
									<col width="50%">
									<col width="50%">
								</colgroup>
								<tbody>
									<tr>
										<td height="20">이지론</td>
										<td align="right">             100만원</td>
									</tr>
									<tr>
										<td height="20">작성기준일</td>
										<td align="right">2015년 05월 22일</td>
									</tr>
									<!-- * IF CLAUSE PROCESSED BY RSL(Ricky Script Language) Interpreter.  -->
									<tr><td colspan="2" height="10"></td></tr>
								</tbody>
							</table>
							<div>
								<p class="details_btn" style="text-align:right;margin-top:5px;margin-bottom:2px;"   >
									<a href="javascript:viewDetail('details_viewS05', 'https://img1.kbcard.com/LT/images/mail/mail_details/btnS_view' )" ><img style='cursor:hand' id = 'imgdetails_viewS05'   src="https://img1.kbcard.com/LT/images/mail/mail_details/btnS_view_open.gif" alt="이용안내 열림" border="0"/></a>
								</p>
							</div>
							<div class="details_view" name = "details_view" id = "details_viewS05" style="font-size:11px;"    >
								<ul>
									<!--IF N != Y {-->
									<li>장기카드대출(카드론) 이용에 동의하여 대상자 선정시 취급이 가능하며, 인터넷, 영업점, 고객센터(1588-1688), ARS(1588-2788)를 통해 이용동의를 철회할 수 있습니다.</li>
									<!--} -->
									<li>장기카드대출(카드론) 가능금액은 신용도 및 이용실적에 따라 변동 가능하며, 카드금융상품을 이용할 경우 신용등급에 영향이 있을 수 있습니다. (이지론 조회 및 신청: KB국민카드 홈페이지, ☎1588-2788, 모바일홈App , 이용가능시간 : 365일, 08:00~23:00)</li>
								</ul>
							</div>
						</td>
					</tr>
				</table>
				<!-- //카드이용한도 / 카드론 가능금액-->

				<!-- 작성기준 -->
				<table width="648px" border="0" cellspacing="0" cellpadding="0" style="margin-top:50px;">
					<tr>
						<td style="padding-bottom:10px;padding-top:4px;"><span  class="hidettl" style=" font-size: 20px;font-weight: bold;">작성기준</span><img src="https://img1.kbcard.com/LT/images/mail/mail_details/tit_h2_email05.gif" alt="작성기준"></td>
						<td align="right" style="padding-bottom:5px;"></td>
					</tr>
				</table>
				<table width="648px" border="0" cellspacing="0" cellpadding="0" class="notice" style="font-size:12px;border:1px solid #e9e9e9;" >
					<colgroup><col width="17%"/><col width="23%"/><col width="12%"/><col width="*"/></colgroup>
					<tr><td colspan="4" style="height: 20px;"> </td></tr>
					<tr>
						<td style="padding-left: 20px;" ><strong>작성기준일  </strong></td>
						<td>2015년 05월 22일</td>
						<td><strong>이용기간</strong></td>
						<td>[일시불/할부] 2015.04.22 ~ 2015.05.21</td>
					</tr>
					<tr>
						<td style="padding-left: 20px;height: 30px;"><strong>결제일    </strong></td>
						<td>2015년 06월 05일</td>
						<td> </td>
						<td>[단기카드대출(현금서비스)]  2015.04.07 ~ 2015.05.06</td>
					</tr>
					<tr>
						<td style="padding-left: 20px;"><strong>실제출금일</strong></td>
						<td>2015년 06월 05일</td>
						<td><strong>결제계좌</strong></td>
						<td> 국민은행 037-21-1***-*28</td>
					</tr>
					<tr><td colspan="4" style="height: 20px;"> </td></tr>
				</table>
				<div style="width:648px;margin-top: 7px;">
					<ul>
						<!-- * IF CLAUSE PROCESSED BY RSL(Ricky Script Language) Interpreter.  -->
						<!-- * IF CLAUSE PROCESSED BY RSL(Ricky Script Language) Interpreter.  -->
						<!--IF 3 == 3 {--><li style="font-weight: bold;">카드이용대금 및 장기카드대출(카드론) 결제금액을 은행영업시간(16시) 이후 입금하실 경우 결제일 당일 결제가 되지 않아 연체료가 부과될 수 있습니다.</li><!--} -->
						<!-- * IF CLAUSE PROCESSED BY RSL(Ricky Script Language) Interpreter.  -->
						<!-- * IF CLAUSE PROCESSED BY RSL(Ricky Script Language) Interpreter.  -->
						<!-- * IF CLAUSE PROCESSED BY RSL(Ricky Script Language) Interpreter.  -->
						<!-- * IF CLAUSE PROCESSED BY RSL(Ricky Script Language) Interpreter.  -->
						<!-- * IF CLAUSE PROCESSED BY RSL(Ricky Script Language) Interpreter.  -->
						<li>명세서 작성기준일이 휴무일인 경우에는 전 영업일을 작성기준일로 하며, 이 경우 이용기간은 명세서 작성일까지로 적용됩니다.			</li>
						<li>명세서 작성기준일 이후 발생한 매출취소 및 선결제금액은 명세서에 반영되지 않습니다.</li>
					</ul>
				</div>
				<!-- //작성기준 -->

				<!-- 공지사항-->
				<table width="648px" border="0" cellspacing="0" cellpadding="0" style="margin-top:50px;margin-bottom:8px;">
					<tr>
						<td style="padding-top:4px;padding-bottom:2px;"><span  class="hidettl" style=" font-size: 20px;font-weight: bold;">공지사항</span><img src="https://img1.kbcard.com/LT/images/mail/mail_details/tit_h2_email06.gif" alt="공지사항"></td>
					</tr>
					<tr>
						<td style="padding-top:4px;padding-bottom:2px;">
							<div class="height notice" style="border:solid 1px #d5d5d5; padding-left: 20px;padding-right: 20px;" tabindex="0">
								<dl style="font-size:12px;margin:0px;padding:0px;border:0px;">
									<dt style="font-weight:bold; margin-top:15px;" class="color4">보이스피싱 피해사례 및 예방 안내</dt>
									<dd style="line-height:1.5;color:#666; margin:3px 0px 0px 0px;">
										최근 금융회사 및 공공기관을 사칭하여 신용카드 비밀번호 등 개인정보를 알아낸 뒤 ARS, 인터넷 등을 통해 장기카드대출(카드론)/ 단기카드대출(현금서비스)의 부정 취급 후 불법자금의 송금(이체)을 유도하는 범죄가 늘고 있습니다. 고객님의 정보를 철저히 관리하시고, 유출 즉시 거래 금융기관, 경찰서, 금융감독원 등에 신고(지급정지 포함)하시기 바랍니다.
									</dd>
									<dt style="font-weight:bold;margin-top:15px; " class="color3">카드이용정지 안내 서비스</dt>
									<dd style="line-height:1.5;color:#666; margin:3px 0px 0px 0px;">
										- 카드대금 및 대출금이 연체(타 금융기관 포함)되어 장ㆍ단기연체정보가 발생하는 경우 신용정보회사를 통해 금융회사 간에 해당 연체정보가 공유되어 신용등급 하락 및 신용카드 사용정지, 카드금융상품 이용 등 금융거래가 제한될 수 있습니다.
									</dd>
									<dd style="line-height:1.5;color:#666; margin:3px 0px 0px 0px;">
										- ‘세금체납’ 등 기타 사유로 회원님의 카드이용이 정지될 수 있으며, 카드이용이 정지 및 해제되는 경우 개인회원 표준약관 제7조 제①항 및 제⑥항에 따라 SMS 및 E-MAIL, 서면 등을 통해 안내하여 드립니다.
									</dd>
									<dd style="line-height:1.5;color:#666; margin:3px 0px 0px 0px;">
										- 카드이용정지 및 해제안내를 원치 않는 경우에는 인터넷 홈페이지 (www.kbcard.com > 개인 > 서비스 > 고객안심서비스 > 카드이용정지안내신청/해지), ARS(1588-1688 ①→ ⑥→ ③) 또는 가까운 KB국민카드 영업점을 통해 신청하여 주시기바랍니다.
									</dd>
									<dd style="line-height:1.5;color:#666; margin:3px 0px 0px 0px;">
										- KB국민카드 또는 장기카드대출(카드론) 결제대금 미납금액이 5만원 미만 소액인 경우도 6개월 이상 미납시는 부득이 카드 이용이 제한될 수 있으므로 유의하여 주시기 바랍니다.
									</dd>
									<dt style="font-weight:bold;margin-top:15px; " class="color3">이용한도 반영시점</dt>
									<dd style="line-height:1.5;color:#666; margin:3px 0px 0px 0px;">
										- KB국민은행, 우리(Woori), 스탠다드차타드은행(구 SC제일은행) 이용 고객님은 결제일 당일 야간, 이를 제외한 타행계좌는 결제일 + 1영업일에 한도 반영됩니다.
									</dd>
								</dl>
							</div>								
						</td>
					</tr>
				</table>
				<!-- //공지사항 -->
				<!--IF Y == Y {-->
				<div style="width:648px;margin-top:30px;text-align:right;">
					<a href='javascript:document.body.scrollTop=0;upp_viewLay_new("2","https://img1.kbcard.com/LT/images/mail/mail_details/mail_detailsMenu");'><img alt="다음페이지" src="https://img1.kbcard.com/LT/images/mail/mail_details/btn_next.gif" border="0"/></a>
				</div>
				<!--} -->
				<div class="tglDisplay" style="width:648px;text-align:center;">
					<img src="https://img1.kbcard.com/LT/images/mail/mail_details/mail_details_bottom.gif" alt="55명이 12개월동안 이메일 명세서를 받으면 아름드리 나무 1그루를 심는 효과가 있습니다."/>
				</div>
			</div>
			<!-- //결제요약정보 -->

			<!-- 이용내역 -->
            <h3 class="sub-tab" style="position:absolute;right:-33px;top:205px"   >
                <a href='javascript:document.body.scrollTop=0;upp_viewLay_new("2","https://img1.kbcard.com/LT/images/mail/mail_details/mail_detailsMenu");'>
					<img src="https://img1.kbcard.com/LT/images/mail/mail_details/mail_detailsMenu2.gif" border="0" id="uppbtncontentsWrap02"  alt="이용내역"		/>
				</a>
            </h3>
			<div id="contentsWrap02" style="width:100%;padding-top: 25px;padding-left: 25px; vertical-align:top; display:inline;min-height:700px;">
				<h4 style=" ">카드이용내역</h4>
				<div class="tglDisplay" style="width:100%;margin-top:20px;text-align:center;">
					<a %OFR_ID=52% href="https://card.kbcard.com/cxo/jsp/cmn/kbcardGTM.jsp?cmsId=CXPPPMYS0051.cms" target="_blank"><img src="https://img1.kbcard.com/LT/images/mail/mail_details/btn_details01.gif" border="0" alt="바로출금결제 바로가기"/></a>
					<a %OFR_ID=53% href="https://card.kbcard.com/cxo/jsp/cmn/kbcardGTM.jsp?cmsId=CXPPPMYS0186.cms" target="_blank"><img src="https://img1.kbcard.com/LT/images/mail/mail_details/btn_details02.gif" border="0" alt="이용내역조회 바로가기"/></a>
					<a %OFR_ID=54% href="https://card.kbcard.com/cxo/jsp/cmn/kbcardGTM.jsp?cmsId=CXPPPMYS0187.cms" target="_blank"><img src="https://img1.kbcard.com/LT/images/mail/mail_details/btn_details03.gif" border="0" alt="교통/자판기 이용내역 바로가기"/></a>
					<!--IF 1 != 3 {-->
					<a %OFR_ID=55% href="https://card.kbcard.com/cxo/jsp/cmn/kbcardGTM.jsp?cmsId=CXPPPFIS0012.cms" target="_blank"><img src="https://img1.kbcard.com/LT/images/mail/mail_details/btn_details04_1.gif" border="0" alt="단기카드대출(현금서비스)로 결제 바로가기"/></a>
					<!--} -->
				</div>
				<table width="648px" border="0" cellspacing="0" cellpadding="0"  style="margin-top:50px;margin-bottom:8px;border-bottom:2px solid #5a5653;">
					<tr>
						<td style="padding-bottom:10px;color:#333;font-size:15px;letter-spacing:-1px;">
							고객님의 수수료등급은 <strong class="color2"> 최우수３（Ａ）</strong> 입니다.
						</td>
						<td align="right" style="padding-bottom:5px;font-size:12px;">
							<p class="details_btn" style="text-align:right;"   >
								<a href="javascript:viewDetail('details_view03', 'https://img1.kbcard.com/LT/cxh/images/mh/event/btn_susu_view' )" ><img style='cursor:hand' id = 'imgdetails_view03'   src="https://img1.kbcard.com/LT/cxh/images/mh/event/btn_susu_view_open.gif" border="0" alt="수수료율 상세보기" /></a>
							</p>
						</td>
					</tr>
				</table>

				<div class="details_view" name = "details_view" id = "details_view03"  class="details_view"   >
					<table width="648px" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td align="right" style="font-size:12px;line-height:1.8;">적용기준일 : 2014년11월01일
							</td>
						</tr>
					</table>
					<table width="648px" border="0" cellpadding="0" cellspacing="0" class="tbl_card1" style="font-size:11px;"  summary="수수료율을 단기카드대출(현금서비스) 수수료율, 단기카드대출(현금서비스) 취급수수료, 할부, 리볼빙결제 수수료율, 연체료율 별로 보여주는 표">
						<caption>수수료율 표</caption>
						<colgroup>
						<col width="*" />
						<col width="60" /><col width="75" /><col width="75" /><col width="75" />
						<col width="75" /><col width="75" /><col width="80" /><col width="75" />
						</colgroup>
						<tr>
							<th colspan="2" height="50" scope="col">단기카드대출<br>(현금서비스)</th>
							<td colspan="2" >연 19.95%</td>
							<td colspan="5" style = "text-align:right;padding-right:15px;" class="last">&nbsp;</td>
						</tr>
						<tr>
							<th scope="col" width="25" rowspan="3">할부</th>
							<th scope="col" width="90" height="50">개월수</th>
							<th scope="row" style="font-weight: normal;">2개월이내</th>
							<th scope="row" style="font-weight: normal;">3개월</th>
							<th scope="row" style="font-weight: normal;">4~5개월</th>
							<th scope="row" style="font-weight: normal;">6~8개월</th>
							<th scope="row" style="font-weight: normal;">9~11개월</th>
							<th scope="row" style="font-weight: normal;">12~17개월</th>
							<th scope="row" style="font-weight: normal;" class="last">18개월이상</th>
						</tr>
						<tr>
							<th scope="col" height="50">수수료율</th>
							<td>연 11.65% </td><td>연 15.15% </td>
							<td>연 16.15% </td><td>연 16.65% </td>
							<td>연 17.05%</td><td>연 17.15%</td>
							<td class="last">연 17.25%</td>
						</tr>
						<tr align='center'>
							<th scope="col" height="50">100원당<br />할부수수료</th>
							<td>1.41원</td>	<td>2.47원</td>
							<td>3.30~3.97원</td>	<td>4.79~6.18원</td>
							<td>7.04~8.46원</td><td>9.22~12.80원</td>
							<td class="last">13.59원</td>
						</tr>
						<tr>
							<th scope="col" colspan="2" height="50">일부결제금액<br>이월약정(리볼빙)</th>
							<th scope="col" colspan="2" style="font-weight: normal;">일시불</th>
							<td colspan="2">연   18.90%</td>
							<th scope="col" colspan="2" style="font-weight: normal;">단기카드대출<br>(현금서비스)</th>
							<td class="last">연   19.95%</td>
						</tr>
					</table>
					<br>
					<table width="648px" border="0" cellpadding="0" cellspacing="0" class="tbl_card1"  summary="수수료율을 단기카드대출(현금서비스) 수수료율, 단기카드대출(현금서비스) 취급수수료, 할부, 리볼빙결제 수수료율, 연체료율 별로 보여주는 표">
						<caption>연체이자율 표</caption>
						<colgroup>
						<col width="41%" /><col width="23%" /><col width="*" />
						</colgroup>
						<tr>
							<th scope="col" colspan="2" height="30">구분</th>
							<th class="last">연체이자율</th>
						</tr>
						<tr>
							<td colspan="2">일시불, 할부</td>
							<td class="last">연 22.9~23.7%</td>
						</tr>
						<tr>
							<td rowspan="3">일부결제금액이월약정(리볼빙)<br>/단기카드대출(현금서비스)<br>/장기카드대출(카드론)</td>
							<td >연 18%미만</td>
							<td class="last">연 22.9~23.7%</td>
						</tr>
						<tr>
							<td >연 18%이상~23%미만</td>
							<td class="last">연 23.9~24.7%</td>
						</tr>
						<tr>
							<td >연23%이상</td>
							<td class="last">연 28.5~29.3%</td>
						</tr>
						<tr>
							<td colspan="5" class="last" style="text-align:right;border-bottom:none;">※ 연체이자율은 연체기간별로 차등적용</td>
						</tr>
					</table>
					<div style="width: 648px;" >
						<ul>
							<li>단기카드대출(현금서비스) 수수료 : [이용금액 × 회원등급별 수수료율) × 이용일수 / 365]</li>
							<li>단기카드대출(현금서비스)를 KB국민은행 이외 기관에서 신청 시 별도의 ATM수수료(500~800원) 추가</li>
							<li><strong>단기카드대출(현금서비스)를 과도하게 이용하시는 경우 신용등급에 부정적 영향이 있을 수 있습니다.</strong></li>
							<li>할부수수료 : 1회차 (할부잔액 X 할부수수료율 X 이용일수(이용일-결제일)÷365)<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2회차 이후 (할부잔액 X 할부수수료율 ÷ 12)</li>
							<li>100원당 할부수수료는 100원을 할부 이용하신 경우, 회원님이 해당 할부 기간 동안 납부하여야 하는 할부수수료 총액을 1회차는 일할(29일-평균신용공여기간), 2회차 이후는 월할로 산출한 예시 금액입니다.</li>
							<li>할부기간은 18개월이내에서 가맹점별로 차등 적용될 수 있으며, 18개월을 초과하는 할부이용은 특정가맹점에서만 이용가능합니다.</li>
							<li>할부이용 후 90일을 초과하여 취소하는 경우, 할부 수수료가 환급되지 않습니다.</li>
							<li>장기카드대출(카드론) : 이지론 이자율은 고객님의 신용도(이용실적 및 연체경력)에 따라 연7.50 ~ 25.80%(적용일 : 2014.10.08) 가 적용되며, 취급수수료와 중도상환수수료가 없어 쉽고 편리하게, 부담 없이 신청하시고 자유롭게 상환하실 수 있습니다.</li>
							<li>대환론 취급금리 : 초기 선납비율에 따라 연 12 ~ 22%가 적용됩니다. (적용기준일: 2014.10.08)</li>
						</ul>
					</div>
				</div>

				<!-- 카드이용내역 -->
				<!--<ON-NULL-DEL-이용내역>-->
				
				<table width="648px" border="0" cellspacing="0" cellpadding="0" style="margin-bottom:8px;border-bottom:2px solid #5a5653;margin-top:50px;">
					<tr>
						<td style="padding-top:4px;padding-bottom:10px;"><span  class="hidettl" style=" font-size: 20px;font-weight: bold;">카드이용내역</span><img src="https://img1.kbcard.com/LT/images/mail/mail_details/tit_mail_details02_01.gif"  alt="카드이용내역" ></td>
						<td align="right" style="padding-bottom:5px;"><!--IF Y == Y {--> 
							<a href="javascript: prtContent_1('usage','N');"><img src="https://img1.kbcard.com/LT/images/mail/mail_details/printer_btn.gif" border="0" alt="인쇄" style=".margin-top:13px;"/></a>
							<a href="javascript: prtContent_1('usage','Y');"><img src="https://img1.kbcard.com/LT/images/mail/mail_details/preview_btn.gif" border="0" alt="인쇄미리보기" style=".margin-top:13px;"/></a> <!--} -->
							<!-- * IF CLAUSE PROCESSED BY RSL(Ricky Script Language) Interpreter.  -->
							<!--IF N == N {--> <a href="https://card.kbcard.com/cxo/jsp/cmn/kbcardGTM.jsp?cmsId=CXPPPMYS0205.cms" target="_blank"><img src="https://img1.kbcard.com/LT/images/mail/mail_details/excel_btn.gif" border="0" alt="엑셀파일저장" style=".margin-top:13px;"/></a> <!--} -->
						</td>
					</tr>
				</table>
				<div id="usage">
				<table  id="usage1" width="648px" cellpadding="0" cellspacing="0" summary="이용일자,이용하신분,이용자번호,가맹점,이번달결제금액,결제후 잔액,적립예정포인트리" class="tbl_card1" style="font-size:11px;" >
					<caption>카드이용내역표</caption>
					<colgroup>
						<col width="48px"/><col width="38px"/><col width="40px"/><col width="26px"/><col width="*"   /><col width="8px" /><col width="65px"/>
						<col width="10px"/><col width="10px"/><col width="65px"/><col width="60px"/><col width="10px"/><col width="60px"/><col width="30px"/>
					</colgroup>
					<thead>
						<tr>
							<th rowspan="2" scope="col">이용<br>일자</th>
							<th rowspan="2"scope="col">이용<br>하신분</th>
							<th rowspan="2" scope="col">이용자<br>번호</th>
							<th rowspan="2" scope="col">구분</th>
							<th colspan="2" rowspan="2" scope="col">이용하신 가맹점</th>
							<th rowspan="2" scope="col">이용금액</th>
							<th rowspan="2" scope="col">할부개월</th>
							<th colspan="3" style="height: 32px;"scope="colgroup">이번달 결제금액</th>
							<th colspan="2"scope="colgroup">결제후 잔액</th>
							<th rowspan="2" class="last"scope="col">적립<br>예정<br>포인<br>트리</th>
						</tr>
						<tr>
							<th style="height: 32px;"scope="col">회차</th>
							<th scope="col">원금</th>
							<th scope="col">수수료<br>(이자)</th>
							<th scope="col">회차</th>
							<th scope="col">원금</th>
						</tr>
					</thead>
					<tbody>
						
<tr class="odd"><td class="center">15.04.27</td><td class="center">테스트</td><td class="center">KK007</td><td class="center">일시</td><td class="center"><a href="https://card.kbcard.com/CXPPPSVC0800.cms?가맹점번호=68226994&가맹점구분=1&pg입점사업자번호= " target="_blank" ><u>홈플러스   서울남현점   온라인마트</u></a></td><td class="center">P</td><td class="right">-3,800</td><td class="center">&nbsp;</td><td class="center">&nbsp;</td><td class="right">-3,800</td><td class="right">&nbsp;</td><td class="center">&nbsp;</td><td class="right">&nbsp;</td><td class="right last">-2</td></tr>
<tr class="even"><td class="center">15.05.15</td><td class="center">테스트</td><td class="center">KK007</td><td class="center">일시</td><td class="center"><a href="https://card.kbcard.com/CXPPPSVC0800.cms?가맹점번호=61022044&가맹점구분=1&pg입점사업자번호= " target="_blank" ><u>Wise Info  플러스 (05 월분 )</u></a></td><td class="center">&nbsp;</td><td class="right">900</td><td class="center">&nbsp;</td><td class="center">&nbsp;</td><td class="right">900</td><td class="right">&nbsp;</td><td class="center">&nbsp;</td><td class="right">&nbsp;</td><td class="right last">&nbsp;</td></tr>
<tr class="odd"><td class="center">15.04.07</td><td class="center">테스트</td><td class="center">KK007</td><td class="center">할부</td><td class="center"><a href="https://card.kbcard.com/CXPPPSVC0800.cms?가맹점번호=68226994&가맹점구분=1&pg입점사업자번호= " target="_blank" ><u>홈플러스   서울남현점   온라인마트</u></a></td><td class="center">P</td><td class="right">128,750</td><td class="center">3</td><td class="center">2</td><td class="right">40,771</td><td class="right">1,029</td><td class="center">1</td><td class="right">40,771</td><td class="right last">&nbsp;</td></tr>
<tr class="even"><td >&nbsp;</td><td >&nbsp;</td><td >&nbsp;</td><td >&nbsp;</td><td class="center"> 무이자혜택금액</td><td class="center">&nbsp;</td><td class="right">&nbsp;</td><td class="center">&nbsp;</td><td class="right">&nbsp;</td><td class="right">&nbsp;</td><td class="right">-1,029</td><td class="center">&nbsp;</td><td class="right">&nbsp;</td><td class="last right">&nbsp;</td></tr>
<tr class="odd"><td class="center">15.04.08</td><td class="center">테스트</td><td class="center">KK007</td><td class="center">할부</td><td class="center"><a href="https://card.kbcard.com/CXPPPSVC0800.cms?가맹점번호=30716695&가맹점구분=1&pg입점사업자번호= " target="_blank" ><u>GS 샵 - 덴마크유산균</u></a></td><td class="center">&nbsp;</td><td class="right">197,000</td><td class="center">10</td><td class="center">2</td><td class="right">18,715</td><td class="right">2,393</td><td class="center">8</td><td class="right">149,720</td><td class="right last">&nbsp;</td></tr>
<tr class="even"><td >&nbsp;</td><td >&nbsp;</td><td >&nbsp;</td><td >&nbsp;</td><td class="center"> 무이자혜택금액</td><td class="center">&nbsp;</td><td class="right">&nbsp;</td><td class="center">&nbsp;</td><td class="right">&nbsp;</td><td class="right">&nbsp;</td><td class="right">-2,393</td><td class="center">&nbsp;</td><td class="right">&nbsp;</td><td class="last right">&nbsp;</td></tr>
<tr class="odd"><td class="center">15.04.09</td><td class="center">테스트</td><td class="center">KK007</td><td class="center">할부</td><td class="center"><a href="https://card.kbcard.com/CXPPPSVC0800.cms?가맹점번호=30716695&가맹점구분=1&pg입점사업자번호= " target="_blank" ><u>GS 샵 - (GS_150</u></a></td><td class="center">&nbsp;</td><td class="right">88,000</td><td class="center">3</td><td class="center">2</td><td class="right">27,866</td><td class="right">703</td><td class="center">1</td><td class="right">27,866</td><td class="right last">&nbsp;</td></tr>
<tr class="even"><td >&nbsp;</td><td >&nbsp;</td><td >&nbsp;</td><td >&nbsp;</td><td class="center"> 무이자혜택금액</td><td class="center">&nbsp;</td><td class="right">&nbsp;</td><td class="center">&nbsp;</td><td class="right">&nbsp;</td><td class="right">&nbsp;</td><td class="right">-703</td><td class="center">&nbsp;</td><td class="right">&nbsp;</td><td class="last right">&nbsp;</td></tr>
<tr class="odd"><td class="center">15.04.22</td><td class="center">테스트</td><td class="center">KK007</td><td class="center">RLS</td><td class="center"><a href="https://card.kbcard.com/CXPPPSVC0800.cms?가맹점번호=68542330&가맹점구분=1&pg입점사업자번호=2208162517" target="_blank" ><u>네이버페이-네이버(주)</u></a></td><td class="center">&nbsp;</td><td class="right">61,750</td><td class="center">&nbsp;</td><td class="center">&nbsp;</td><td class="right">61,750</td><td class="right">&nbsp;</td><td class="center">&nbsp;</td><td class="right">&nbsp;</td><td class="right last">&nbsp;</td></tr>
<tr class="even"><td class="center">15.04.24</td><td class="center">테스트</td><td class="center">KK007</td><td class="center">RLS</td><td class="center"><a href="https://card.kbcard.com/CXPPPSVC0800.cms?가맹점번호=13404061&가맹점구분=1&pg입점사업자번호= " target="_blank" ><u>( 주 ) 롯데닷컴</u></a></td><td class="center">&nbsp;</td><td class="right">3,000</td><td class="center">&nbsp;</td><td class="center">&nbsp;</td><td class="right">3,000</td><td class="right">&nbsp;</td><td class="center">&nbsp;</td><td class="right">&nbsp;</td><td class="right last">&nbsp;</td></tr>
<tr class="odd"><td class="center">15.04.27</td><td class="center">테스트</td><td class="center">KK007</td><td class="center">RLS</td><td class="center"><a href="https://card.kbcard.com/CXPPPSVC0800.cms?가맹점번호=40894564&가맹점구분=1&pg입점사업자번호=6218102895" target="_blank" ><u>이지스(정기과금)-쿠쿠전자주식회사</u></a></td><td class="center">&nbsp;</td><td class="right">21,900</td><td class="center">&nbsp;</td><td class="center">&nbsp;</td><td class="right">21,900</td><td class="right">&nbsp;</td><td class="center">&nbsp;</td><td class="right">&nbsp;</td><td class="right last">&nbsp;</td></tr>
<tr class="even"><td class="center">15.04.27</td><td class="center">테스트</td><td class="center">KK007</td><td class="center">RLS</td><td class="center"><a href="https://card.kbcard.com/CXPPPSVC0800.cms?가맹점번호=68226994&가맹점구분=1&pg입점사업자번호= " target="_blank" ><u>홈플러스   서울남현점   온라인마트</u></a></td><td class="center">P</td><td class="right">56,460</td><td class="center">&nbsp;</td><td class="center">&nbsp;</td><td class="right">56,460</td><td class="right">&nbsp;</td><td class="center">&nbsp;</td><td class="right">&nbsp;</td><td class="right last">44</td></tr>
<tr class="odd"><td class="center">15.04.28</td><td class="center">테스트</td><td class="center">KK007</td><td class="center">RLS</td><td class="center"><a href="https://card.kbcard.com/CXPPPSVC0800.cms?가맹점번호=68542330&가맹점구분=1&pg입점사업자번호=2208162517" target="_blank" ><u>네이버페이-네이버(주)</u></a></td><td class="center">&nbsp;</td><td class="right">18,000</td><td class="center">&nbsp;</td><td class="center">&nbsp;</td><td class="right">18,000</td><td class="right">&nbsp;</td><td class="center">&nbsp;</td><td class="right">&nbsp;</td><td class="right last">&nbsp;</td></tr>
<tr class="even"><td class="center">15.04.29</td><td class="center">테스트</td><td class="center">KK007</td><td class="center">RLS</td><td class="center"><a href="https://card.kbcard.com/CXPPPSVC0800.cms?가맹점번호=47809711&가맹점구분=1&pg입점사업자번호= " target="_blank" ><u>티머니서울택시</u></a></td><td class="center">&nbsp;</td><td class="right">6,500</td><td class="center">&nbsp;</td><td class="center">&nbsp;</td><td class="right">6,500</td><td class="right">&nbsp;</td><td class="center">&nbsp;</td><td class="right">&nbsp;</td><td class="right last">&nbsp;</td></tr>
<tr class="odd"><td class="center">15.05.02</td><td class="center">테스트</td><td class="center">KK007</td><td class="center">RLS</td><td class="center"><a href="https://card.kbcard.com/CXPPPSVC0800.cms?가맹점번호=47809711&가맹점구분=1&pg입점사업자번호= " target="_blank" ><u>티머니서울택시</u></a></td><td class="center">&nbsp;</td><td class="right">5,100</td><td class="center">&nbsp;</td><td class="center">&nbsp;</td><td class="right">5,100</td><td class="right">&nbsp;</td><td class="center">&nbsp;</td><td class="right">&nbsp;</td><td class="right last">&nbsp;</td></tr>
<tr class="even"><td class="center">15.05.03</td><td class="center">테스트</td><td class="center">KK007</td><td class="center">RLS</td><td class="center"><a href="https://card.kbcard.com/CXPPPSVC0800.cms?가맹점번호=30716666&가맹점구분=1&pg입점사업자번호= " target="_blank" ><u>GS 샵 - 뉴발란스_플립</u></a></td><td class="center">&nbsp;</td><td class="right">12,400</td><td class="center">&nbsp;</td><td class="center">&nbsp;</td><td class="right">12,400</td><td class="right">&nbsp;</td><td class="center">&nbsp;</td><td class="right">&nbsp;</td><td class="right last">&nbsp;</td></tr>
<tr class="odd"><td class="center">15.05.04</td><td class="center">테스트</td><td class="center">KK007</td><td class="center">RLS</td><td class="center"><a href="https://card.kbcard.com/CXPPPSVC0800.cms?가맹점번호=47809711&가맹점구분=1&pg입점사업자번호= " target="_blank" ><u>티머니서울택시</u></a></td><td class="center">&nbsp;</td><td class="right">3,000</td><td class="center">&nbsp;</td><td class="center">&nbsp;</td><td class="right">3,000</td><td class="right">&nbsp;</td><td class="center">&nbsp;</td><td class="right">&nbsp;</td><td class="right last">&nbsp;</td></tr>
<tr class="even"><td class="center">15.05.04</td><td class="center">테스트</td><td class="center">KK007</td><td class="center">RLS</td><td class="center"><a href="https://card.kbcard.com/CXPPPSVC0800.cms?가맹점번호=47809711&가맹점구분=1&pg입점사업자번호= " target="_blank" ><u>티머니서울택시</u></a></td><td class="center">&nbsp;</td><td class="right">4,400</td><td class="center">&nbsp;</td><td class="center">&nbsp;</td><td class="right">4,400</td><td class="right">&nbsp;</td><td class="center">&nbsp;</td><td class="right">&nbsp;</td><td class="right last">&nbsp;</td></tr>
<tr class="odd"><td class="center">15.05.04</td><td class="center">테스트</td><td class="center">KK007</td><td class="center">RLS</td><td class="center"><a href="https://card.kbcard.com/CXPPPSVC0800.cms?가맹점번호=47809711&가맹점구분=1&pg입점사업자번호= " target="_blank" ><u>티머니서울택시</u></a></td><td class="center">&nbsp;</td><td class="right">5,900</td><td class="center">&nbsp;</td><td class="center">&nbsp;</td><td class="right">5,900</td><td class="right">&nbsp;</td><td class="center">&nbsp;</td><td class="right">&nbsp;</td><td class="right last">&nbsp;</td></tr>
<tr class="even"><td class="center">15.05.05</td><td class="center">테스트</td><td class="center">KK007</td><td class="center">RLS</td><td class="center"><a href="https://card.kbcard.com/CXPPPSVC0800.cms?가맹점번호=69551061&가맹점구분=1&pg입점사업자번호=2208162517" target="_blank" ><u>네이버페이1-네이버주식회사</u></a></td><td class="center">&nbsp;</td><td class="right">20,160</td><td class="center">&nbsp;</td><td class="center">&nbsp;</td><td class="right">20,160</td><td class="right">&nbsp;</td><td class="center">&nbsp;</td><td class="right">&nbsp;</td><td class="right last">&nbsp;</td></tr>
<tr class="odd"><td class="center">15.05.11</td><td class="center">테스트</td><td class="center">KK007</td><td class="center">RLS</td><td class="center"><a href="https://card.kbcard.com/CXPPPSVC0800.cms?가맹점번호=8418915&가맹점구분=1&pg입점사업자번호= " target="_blank" ><u>OLLEH 모바일자동납부 (4992)</u></a></td><td class="center">&nbsp;</td><td class="right">128,510</td><td class="center">&nbsp;</td><td class="center">&nbsp;</td><td class="right">128,510</td><td class="right">&nbsp;</td><td class="center">&nbsp;</td><td class="right">&nbsp;</td><td class="right last">&nbsp;</td></tr>
<tr class="even"><td class="center">15.05.12</td><td class="center">테스트</td><td class="center">KK007</td><td class="center">RLS</td><td class="center"><a href="https://card.kbcard.com/CXPPPSVC0800.cms?가맹점번호=52307028&가맹점구분=1&pg입점사업자번호= " target="_blank" ><u>LGUPLUS  통신요금자동이체</u></a></td><td class="center">&nbsp;</td><td class="right">62,610</td><td class="center">&nbsp;</td><td class="center">&nbsp;</td><td class="right">53,610</td><td class="right">&nbsp;</td><td class="center">&nbsp;</td><td class="right">&nbsp;</td><td class="right last">&nbsp;</td></tr>
<tr class="odd"><td >&nbsp;</td><td >&nbsp;</td><td >&nbsp;</td><td >&nbsp;</td><td class="center">LG U+  통신요금   할인</td><td class="center">&nbsp;</td><td class="right">          -9,000</td><td class="center">&nbsp;</td><td class="right">&nbsp;</td><td class="right">&nbsp;</td><td class="right">&nbsp;</td><td class="center">&nbsp;</td><td class="right">&nbsp;</td><td class="last right">&nbsp;</td></tr>
<tr class="even"><td class="center">15.05.15</td><td class="center">테스트</td><td class="center">KK007</td><td class="center">RLS</td><td class="center"><a href="https://card.kbcard.com/CXPPPSVC0800.cms?가맹점번호=50700521&가맹점구분=1&pg입점사업자번호=1018223485" target="_blank" ><u>한국세계자연기-한국세계자연기금</u></a></td><td class="center">&nbsp;</td><td class="right">20,000</td><td class="center">&nbsp;</td><td class="center">&nbsp;</td><td class="right">20,000</td><td class="right">&nbsp;</td><td class="center">&nbsp;</td><td class="right">&nbsp;</td><td class="right last">&nbsp;</td></tr>
<tr class="odd"><td class="center">15.05.21</td><td class="center">테스트</td><td class="center">KK007</td><td class="center">RLS</td><td class="center"><a href="https://card.kbcard.com/CXPPPSVC0800.cms?가맹점번호=33234999&가맹점구분=1&pg입점사업자번호= " target="_blank" ><u>버스00001건</u></a></td><td class="center">&nbsp;</td><td class="right">1,050</td><td class="center">&nbsp;</td><td class="center">&nbsp;</td><td class="right">1,050</td><td class="right">&nbsp;</td><td class="center">&nbsp;</td><td class="right">&nbsp;</td><td class="right last">&nbsp;</td></tr>
<tr class="even"><td colspan=6 class="center">소   계     21 건&nbsp;</td><td >&nbsp;</td><td >&nbsp;</td><td class="center">&nbsp;</td><td class="right">506,192</td><td class="right">&nbsp;</td><td >&nbsp;</td><td class="right">218,357</td><td class="right last">42</td></tr>
<tr class="odd"><td colspan=6 class="center">합   계     21 건&nbsp;</td><td >&nbsp;</td><td >&nbsp;</td><td class="center">&nbsp;</td><td class="right">506,192</td><td class="right">&nbsp;</td><td >&nbsp;</td><td class="right">218,357</td><td class="right last">42</td></tr>
<tr class="even"><td colspan=6 class="center">일부결제금액이월약정(리볼빙)이월금액 합계</td><td >&nbsp;</td><td >&nbsp;</td><td class="center">&nbsp;</td><td class="right">2,651,705</td><td class="right">41,805</td><td >&nbsp;</td><td class="right">&nbsp;</td><td class="right last">&nbsp;</td></tr>
<tr class="odd"><td colspan=6 class="center">신용카드 결제하실 총금액&nbsp;</td><td >&nbsp;</td><td >&nbsp;</td><td class="center">&nbsp;</td><td class="right">3,157,897</td><td class="right">41,805</td><td >&nbsp;</td><td class="right">&nbsp;</td><td class="right last">&nbsp;</td></tr>     
					</tbody>
				</table>
				</div>
				<div>
					<p class="details_btn" style="width: 648px;text-align:right;margin-top:5px;margin-bottom:2px;"   >
						<a href="javascript:viewDetail('details_viewS08', 'https://img1.kbcard.com/LT/images/mail/mail_details/btnS_view' )" ><img style='cursor:hand' id = 'imgdetails_viewS08'   src="https://img1.kbcard.com/LT/images/mail/mail_details/btnS_view_open.gif" alt="이용안내 열림" border="0"/></a>
					</p>
				</div>
				<div style="width: 648px;" class="details_view" name = "details_view" id = "details_viewS08"   >
					<ul>
						<li>상기 이용내역은 2015년 05월 22일까지 접수된 매출전표 기준이며 이후 접수분은 다음달에 청구됩니다. 이 경우 할부매출의 수수료는 차기 결제일까지 일수만큼 계산되어 청구됩니다.</li>
						<li>RLS, RCA 매출은 이번달 결제일별 이용기간동안 사용한 내역만 표시됩니다.</li>
						<li>이용자번호 KK/BB(국내), KM/BM(마스터), KV/BV(비자), KJ/BJ(JCB), KA(아멕스), KC(은련) + 카드번호 3자리</li>
						<li>구분 : 일시-일시불, 할부-할부, 연회-연회비, 현금- 단기카드대출(현금서비스), RLS- 일부결제금액이월약정(리볼빙) 일시불, RCA- 일부결제금액이월약정(리볼빙) 단기카드대출(현금서비스)</li>
						<li>정상금액과 취소금액이 일치할 경우에는 해당내역이 표시되지 않을 수 있으며, 명세서 작성기준일 이후 취소할 경우에는 명세서 표기금액과 실제 결제할 금액이 상이할 수 있습니다.</li>
						<li>정상금액과 취소금액이 불일치 하는 경우에는 자동상계처리 되지 않을 수 있으며, 이 경우 취소전표 매입일 기준 해당 결제일에 차감 청구됩니다.</li>
						<li>수협, 신협, 상호저축은행, 지방은행, 한국시티, HSBC 결제계좌를 이용하시는 경우에는 미납금액 발생 시 2~3영업일 간격으로 출금됩니다.</li>
						<li>이용가맹점에 표시되는 “P”는 ‘포인트리 스타샵(적립) 가맹점’으로 포인트리 추가적립 및 포인트리를 현금처럼 이용 가능한 가맹점을 말합니다.</li>
						<li>교통카드 이용금액은 해당 이용기간의 합산금액을 표시하며, 상세내역은 KB국민카드 홈페이지에서 조회 가능합니다.</li>
						<li>해외이용대금은 국제카드사가 정한 환율에 의해 미달러화로 환산 후, 국제카드사가 부과하는 해외서비스수수료(비자,마스타:1%, 아멕스:1.4%)가 포함되며, 회원님께 원화로 청구되는 금액은 당사 접수일의 KB국민은행 최초 고시 전신환매도율이 적용되며, 청구금액에는 해외이용수수료(0.25%)가 포함됩니다.</li>
						<li>포인트리는 청구일 익영업일에 적립되며, 회원님의 명세서 작성기준일과 매출전표 매입일이 동일한 경우에는 적립예정 포인트리가 표기되지 않을 수 있습니다.</li>
						<li>고객의 매출 취소등의 사유로 포인트리가 차감되어 마이너스 포인트리가 발생할 경우에는 향후 적립되는 포인트리와 상계하며, 카드해지, 3개월간 포인트리 미적립등의 사유발생 시 마이너스 포인트리 1점당 1원으로 계산하여 고객에게 신용카드 대금으로 청구됩니다.</li>
						<li>카드 이용내역 중 이용 가맹점 정보(실제 판매자 상호, 구매 상품명 등)는 해당 가맹점에서 제공한 정보로, 고객님께서 실제 구매하신 정보와 상이할 수 있습니다.</li>
						<li>통신요금 자동납부 가맹점명 우측 괄호 안에 전화번호 뒤 4자리를 표시하고 있습니다.</li>
						<!-- * IF CLAUSE PROCESSED BY RSL(Ricky Script Language) Interpreter.  -->
					</ul>
				</div>
				<!--<ON-NULL-DEL-이용내역>-->
				<!-- //카드이용내역 -->

  				<!-- 할부가격안내-->
				<!--< * DELETED BY RSL(Ricky Script Language) Interpreter. ON-NULL-DEL-할부가격안내>-->
				<!-- //할부가격안내-->

				<!-- 카드별청구금액-->
				<!-- * IF CLAUSE PROCESSED BY RSL(Ricky Script Language) Interpreter.  -->
				<!-- 카드별청구금액-->

				<!-- 연회비청구사전안내-->
				<!--< * DELETED BY RSL(Ricky Script Language) Interpreter. ON-NULL-DEL-연회비청구사전안내>-->
				<!-- 연회비청구사전안내-->

				<!-- 해외이용내역-->
				<!--< * DELETED BY RSL(Ricky Script Language) Interpreter. ON-NULL-DEL-해외이용내역>-->
				<!-- //해외이용내역-->


				<!-- 카드론이용내역-->
				<!--< * DELETED BY RSL(Ricky Script Language) Interpreter. ON-NULL-DEL-대출내역>-->    
				<!-- //카드론이용내역-->


				<!-- 리볼빙결제 상세내역-->
				<!--IF Y == Y {-->
				<table width="648px" border="0" cellspacing="0" cellpadding="0" style="margin-bottom:0px;border-bottom:2px solid #5a5653;margin-top:50px;">
					<tr>
						<td style="padding-top:4px;padding-bottom:10px;"><span  class="hidettl" style=" font-size: 20px;font-weight: bold;">일부결제금액이월약정(리볼빙) 상세내역</span><img src="https://img1.kbcard.com/LT/images/mail/mail_details/tit_mail_details02_01_1_2.gif" alt="일부결제금액이월약정(리볼빙) 상세내역"></td>
					</tr>
				</table>
				<table width="648px" cellpadding="0" cellspacing="0">
					<tr>
						<td width="46%" style="vertical-align:top;">
							<table  class="tbl_card1" style="font-size:11px;"  width="100%" cellpadding="0" cellspacing="0" summary="청구내역, 금액, 청구내역, 금액(원)" style="margin-top:10px;">
								<caption>일부결제금액이월약정(리볼빙) 상세내역</caption>
								<colgroup>
								<col width="16%" /><col width="17%" /><col width="22%" /><col width="23%" /><col width="22%" />
								</colgroup>
								<thead>
									<tr height="30">
										<th colspan="2" scope="col">구분</th>
										<th scope="col">일시불</th>
										<th class="last" scope="col">단기카드대출(현금서비스)</th>

									</tr>
								</thead>
								<tbody>
									<tr height="30">
										<th style="font-weight:normal;" rowspan="2"  scope="rowgroup">이월분</th>
										<th style="font-weight:normal;" scope="row">금액</th>
										<td class="right">2,651,705</td>
										<td class="right last">0</td>
									</tr>
									<tr height="30">
										<th style="font-weight:normal;" scope="row">수수료</th>
										<td class="right">41,805</td>
										<td class="right last">0</td>
									</tr>
									<tr height="30">
										<th rowspan="2" style="font-weight:normal;"  scope="rowgroup">신규<br>
										이용분</th>
										<th style="font-weight:normal;" scope="row">금액</th>
										<td class="right">421,740</td>
										<td class="right last">0</td>
									</tr>
									<tr height="30">
										<th style="font-weight:normal;" scope="row">수수료</th>
										<td class="right">0</td>
										<td class="right last">0</td>
									</tr>
									<tr height="30">
										<th rowspan="2" style="font-weight:normal;" scope="rowgroup">합계</th>
										<th style="font-weight:normal;" scope="row">금액①</th>
										<td class="right">3,073,445</td>
										<td class="right last">0</td>
									</tr>
									<tr height="30">
										<th style="font-weight:normal;" scope="row">수수료②</th>
										<td class="right">41,805</td>
										<td class="right last">0</td>
									</tr>
								</tbody>
							</table>
						</td>
						<td width="54%" style="vertical-align:top;padding-left:10px;">
							<table class="tbl_card1" style="font-size:11px;"  width="100%" cellpadding="0" cellspacing="0" summary="리볼빙 결제금액 산출방법,희망결제,최소결제,결제비율" style="margin-top:10px;">
								<caption>일부결제금액이월약정(리볼빙) 상세내역</caption>
								<colgroup>
								<col width="50%" />
								<col width="25%" />
								<col width="25%" />
								</colgroup>
								<tbody>
								<tr height="30">
									<th style="font-weight:normal;"scope="col">산출방법</th>
									<th style="font-weight:normal;" scope="col">약정결제</th>
									<th style="font-weight:normal;" class="last" scope="col">최소결제</th>
								</tr>
								<tr height="30">
									<th style="font-weight:normal;"scope="row">결제비율③</th>
									<td class="right"> 100.00%</td>
									<td class="right last">10.00%</td>
								</tr>
								<tr height="40">
									<th style="font-weight:normal;"scope="row">금액④=①x③ <br/>(단, 최소 5만원 청구)</th>
									<td class="right">3,073,445</td>
									<td class="right last">307,344</td>
								</tr>
								<tr height="30">
									<th style="font-weight:normal;"scope="row">수수료⑤=②</th>
									<td class="right">41,805</td>
									<td class="right last">41,805</td>
								</tr>
								<tr height="40">
									<th  style="font-weight:normal;"scope="row"><b>이번달 결제금액</b><br>⑥=④+⑤</th>
									<td class="right"><b>3,115,250</b></td>
									<td class="right last"><b>349,149</b></td>
								</tr>
								<tr height="41">
									<th style="font-weight:normal;"scope="row">결제 후 잔액<br/>⑦=①-④</th>
									<td class="right">0</td>
									<td class="right last">2,766,101</td>
								</tr>
								</tbody>
							</table>
						</td>
					</tr>
				</table>
				<div>
					<p class="details_btn" style="width: 648px;text-align:right;margin-top:5px;margin-bottom:2px;"   > <a href="javascript:viewDetail('details_viewS02', 'https://img1.kbcard.com/LT/images/mail/mail_details/btnS_view' )" ><img style='cursor:hand' id = 'imgdetails_viewS02'   src="https://img1.kbcard.com/LT/images/mail/mail_details/btnS_view_open.gif" alt="이용안내 열림" border="0"/></a> </p>
				</div>
				<div class="details_view" style="width: 648px;" name = "details_view" id = "details_viewS02"    >
					<ul>
						<li> 이월된 금액은 일부결제금액이월약정(리볼빙) 수수료가 부과되며, 즉시 결제를 원하실 경우는 고객센터로 문의하시기 바랍니다. </li>
					</ul>
				</div>
				<!--} -->
				<!-- //리볼빙결제 상세내역-->

				<div class="tglDisplay" style="vertical-align: top;width:648px;height: 40px;text-align:center;margin-top:30px;">

					<table  cellpadding="0" cellspacing="0" border="0" style="width:100%"><!-- style="width:100%" 추가 -->
					<tr>
						<td style="vertical-align: middle; text-align:center"><!-- text-align:center; -->
							<a %OFR_ID=56% href="https://omoney.kbstar.com/quics?page=C019315&QSL=F" target="_blank"><img src="https://img1.kbcard.com/LT/images/mail/mail_details/btn_details05.gif" alt="가계부작성" border="0"/></a>
						</td>
					</tr>
					<tr>
						<td style="vertical-align: middle;font-size: 11px;padding-top: 4px; text-align:center"><!-- text-align:center; padding-top:10px로 수정 -->  공인인증서 소지고객만 가능합니다.</td>
					</tr>
					</table>

				</div>
				<!--IF Y == Y {-->
				<table class="tglDisplay" width="648px" cellpadding="0" cellspacing="0" style="margin-top:30px;margin-bottom:30px;">
					<tr>
						<td>
							<a href='javascript:document.body.scrollTop=0;upp_viewLay_new("1","https://img1.kbcard.com/LT/images/mail/mail_details/mail_detailsMenu");'><img alt="이전페이지" src="https://img1.kbcard.com/LT/images/mail/mail_details/btn_pre.gif" border="0"/></a>
						</td>
						<td align="right"> 
							<a href='javascript:document.body.scrollTop=0;upp_viewLay_new("3","https://img1.kbcard.com/LT/images/mail/mail_details/mail_detailsMenu");'><img alt="다음페이지" src="https://img1.kbcard.com/LT/images/mail/mail_details/btn_next.gif" border="0"/></a>
						</td>
					</tr>
				</table>
				<!--} -->
			</div>
			<!-- //이용내역 -->

			<!-- 서비스혜택 -->
            <h3 class="sub-tab" style="position:absolute;right:-33px;top:309px"   >
                <a href='javascript:document.body.scrollTop=0;upp_viewLay_new("3","https://img1.kbcard.com/LT/images/mail/mail_details/mail_detailsMenu");'>
					<img src="https://img1.kbcard.com/LT/images/mail/mail_details/mail_detailsMenu3.gif" border="0" id="uppbtncontentsWrap03"  alt="서비스혜택"	/>
				</a>
            </h3>
			<div id="contentsWrap03" style="width:100%;padding-top: 25px;padding-left: 25px; vertical-align:top; display:inline;min-height:700px;">
				<h4 style=" ">서비스혜택</h4>
				<!-- 포인트 마일리지적립안내 -->
				<table width="648px" border="0" cellspacing="0" cellpadding="0" style="margin-bottom:8px;border-bottom:2px solid #5a5653;margin-top:50px;">
					<tr>
						<td style="padding-top:4px;padding-bottom:10px;"><span  class="hidettl" style=" font-size: 20px;font-weight: bold;">포인트 및 마일리지 적립안내</span><img src="https://img1.kbcard.com/LT/images/mail/mail_details/tit_h2_email07.gif" alt="포인트 및 마일리지 적립안내" ></td>
						<td align="right" style="padding-bottom:5px;"></td>
					</tr>
				</table>
				<table width="648px" border="0" cellspacing="0" cellpadding="0" summary="고객정보" style="border-bottom:1px solid #d7d7d7;font-size:12px;">
				<caption>포인트 및 마일리지 적립안내</caption>
				<colgroup>
					<col width="50%">
					<col width="50%">
				</colgroup>
				<tbody>
					<!--IF &nbsp;포인트리 != NULL {--><tr><td height="20">&nbsp;포인트리</td><td align="right">             506</td></tr><!--} -->
					<!-- * IF CLAUSE PROCESSED BY RSL(Ricky Script Language) Interpreter.  -->
					<!-- * IF CLAUSE PROCESSED BY RSL(Ricky Script Language) Interpreter.  -->
					<!-- * IF CLAUSE PROCESSED BY RSL(Ricky Script Language) Interpreter.  -->
					<!-- * IF CLAUSE PROCESSED BY RSL(Ricky Script Language) Interpreter.  -->
					<!-- * IF CLAUSE PROCESSED BY RSL(Ricky Script Language) Interpreter.  -->
					<!-- * IF CLAUSE PROCESSED BY RSL(Ricky Script Language) Interpreter.  -->
					<!-- * IF CLAUSE PROCESSED BY RSL(Ricky Script Language) Interpreter.  -->
					<tr><td colspan="2" height="10"></td></tr>
				</tbody>
				</table>
				<!-- 이용안내 -->
				<div>
					<p class="details_btn" style="width: 648px;text-align:right;margin-top:5px;margin-bottom:2px;"   >
						<a href="javascript:viewDetail('details_viewS11', 'https://img1.kbcard.com/LT/images/mail/mail_details/btnS_view' )" ><img style='cursor:hand' id = 'imgdetails_viewS11'   src="https://img1.kbcard.com/LT/images/mail/mail_details/btnS_view_open.gif" alt="이용안내 열림" border="0"/></a>
					</p>
				</div>
				<div style="width: 648px;" class="details_view" name = "details_view" id = "details_viewS11"   >
					<ul>
						<li>적립포인트리가 1점 이상 시 스타샵 적립가맹점 및 포인트리 사은품몰(<a href="http://www.kbpointreemall.com"  target="_blank">www.kbpointreemall.com</a>)에서 사용 가능하시며, KB국민은행 영업점에서 송금수수료 및 예ㆍ적금, 대출금, 이자납부 등 금융거래에 이용하실 수 있습니다. 또한, 3만점 이상 시 신용카드 결제대금에서 차감이 가능합니다. </li>
						<li>포인트리는 매출전표 최초 청구일(결제일) 익영업일에 적립됩니다.</li>
						<li>항공 마일리지는 다른 제휴카드 마일리지와 비행기 탑승 마일리지가 합산되어 표시됩니다.</li>
						<!-- * IF CLAUSE PROCESSED BY RSL(Ricky Script Language) Interpreter.  -->
					</ul>
				</div>
				<!-- //이용안내 -->
				<div class="tglDisplay" style="width:648px;text-align:center;margin-top:20px;">
					<a %OFR_ID=61% href="http://life.kbcard.com/shopping/CXLSHZZC0003.cms" target="_blank"><img src="https://img1.kbcard.com/LT/images/mail/mail_details/btn_details09.gif" border="0" alt="사은품신청"/></a>
					<a %OFR_ID=62% href="https://card.kbcard.com/cxo/jsp/cmn/kbcardGTM.jsp?cmsId=CXPPPSVS5001.cms" target="_blank"><img src="https://img1.kbcard.com/LT/images/mail/mail_details/btn_details10.gif" border="0" alt="포인트리상세조회"/></a>
				</div>
				<!-- //포인트 마일리지적립안내 -->


				<!-- KB국민 와이즈카드 포인트리 적립안내 -->
				<!--< * DELETED BY RSL(Ricky Script Language) Interpreter. ON-NULL-DEL-WISEPOINT>--> 
				<!-- //KB국민 와이즈카드 포인트리 적립안내 -->

				<!-- 포인트리 사용내역 -->
				<!--< * DELETED BY RSL(Ricky Script Language) Interpreter. ON-NULL-DEL-PTUSEGE>-->
				<!-- //포인트리 사용내역>

				<!-- 포인트 실효안내 -->
				<!-- * IF CLAUSE PROCESSED BY RSL(Ricky Script Language) Interpreter.  -->

				<!--< * DELETED BY RSL(Ricky Script Language) Interpreter. ON-NULL-DEL-실효예정>-->
				<!--< * DELETED BY RSL(Ricky Script Language) Interpreter. ON-NULL-DEL-BC실효예정>--> 
				<!-- //포인트 실효안내 -->
				<!-- 서비스 -->
				<!-- * IF CLAUSE PROCESSED BY RSL(Ricky Script Language) Interpreter.  -->

				<!-- * IF CLAUSE PROCESSED BY RSL(Ricky Script Language) Interpreter.  -->
					<!-- * IF CLAUSE PROCESSED BY RSL(Ricky Script Language) Interpreter.  -->
					<!-- * IF CLAUSE PROCESSED BY RSL(Ricky Script Language) Interpreter.  -->
				<!-- * IF CLAUSE PROCESSED BY RSL(Ricky Script Language) Interpreter.  -->

				<!--< * DELETED BY RSL(Ricky Script Language) Interpreter. ON-NULL-DEL-맞춤정보>--> 
				<!--< * DELETED BY RSL(Ricky Script Language) Interpreter. ON-NULL-DEL-ECONOSAVE>--> 

				<!--IF 
N
N-1  == NN-1 {-->
				<table width="648px" border="0" cellspacing="0" cellpadding="0" style="margin-top:50px;">
					<tr>
						<td style="padding-top:4px;padding-bottom:10px;"> </td>
					</tr>
				</table>
				<!--} -->
				<!--IF Y == Y {-->
				<table class="tglDisplay" width="648px" cellpadding="0" cellspacing="0" style="margin-top:40px;margin-bottom:40px;">
					<tr>
						<td>
							<a href='javascript:document.body.scrollTop=0;upp_viewLay_new("2","https://img1.kbcard.com/LT/images/mail/mail_details/mail_detailsMenu");'><img alt="이전페이지" src="https://img1.kbcard.com/LT/images/mail/mail_details/btn_pre.gif" border="0"/></a>
						</td>
						<td align="right">
							<a href='javascript:document.body.scrollTop=0;upp_viewLay_new("5","https://img1.kbcard.com/LT/images/mail/mail_details/mail_detailsMenu");'><img alt="다음페이지" src="https://img1.kbcard.com/LT/images/mail/mail_details/btn_next.gif" border="0"/></a>
						</td>
					</tr>
				</table>
				<!--} -->
				<!-- //서비스 -->
			</div>
			<!-- //서비스혜택  -->

			<!-- 이벤트안내 -->
            <h3 class="sub-tab" style="position:absolute;right:-33px;top:413px"   >
                <a href='javascript:document.body.scrollTop=0;upp_viewLay_new("5","https://img1.kbcard.com/LT/images/mail/mail_details/mail_detailsMenu");'>
					<img src="https://img1.kbcard.com/LT/images/mail/mail_details/mail_detailsMenu5.gif" border="0" id="uppbtncontentsWrap05"  alt="이벤트&안내"  />
				</a>
            </h3>
			<div id="contentsWrap05" style="width:100%;margin:25px; vertical-align:top;display:block;min-height:700px;" class="contentsWrap" >
				<h4 style=" ">이벤트안내</h4>
				<!-- 전체이벤트이벤트 --><!-- //전체이벤트이벤트 -->

				<!-- 무이자할부상품안내 -->
				<!-- * IF CLAUSE PROCESSED BY RSL(Ricky Script Language) Interpreter.  -->
						<!-- * IF CLAUSE PROCESSED BY RSL(Ricky Script Language) Interpreter.  -->
				<!-- * IF CLAUSE PROCESSED BY RSL(Ricky Script Language) Interpreter.  -->
						<!-- * IF CLAUSE PROCESSED BY RSL(Ricky Script Language) Interpreter.  -->
				<!-- * IF CLAUSE PROCESSED BY RSL(Ricky Script Language) Interpreter.  -->
				<!-- //무이자할부상품안내 -->

				<!-- 분야별 이용현황 -->
				<!--IF Y == Y {-->
				<table width="648px" border="0" cellspacing="0" cellpadding="0" style="margin-top:50px;clear:both" class="tglDisplay">
					<tr>
						<td>
							<span   class="hidettl" style="font-size: 14px;font-weight: bold;">분야별 이용현황</span>
							<img src="https://img1.kbcard.com/LT/images/mail/mail_details/tit_mail_details150224.gif"  alt="분야별 이용현황">
						</td>
					</tr>
				</table>	
				<table width="648px" border="0" cellspacing="0" cellpadding="0"  style="margin-top:10px;"  class="tglDisplay">
					<colgroup>
					<col width="50%">
					<col width="50%">
					</colgroup>
					<tr>
						<td>
							<div style="width:646px; border: 1px solid #DDDDDD;margin-top:7px;text-align:center; font-size:11px;padding: 5px;">
							<table width="100%"  border="0" height="100%" cellspacing="0" cellpadding="0"  >
							<colgroup>
							<col width="65%">
							<col width="35%">
							</colgroup>
							<tr>
								<td style="border:0px solid #FF0000;">
									<div id="myCanvas1" style="border:0px solid #707070; background-color: #FFFFFF;overflow: auto; position:relative;height:240;width:390;"></div>
								</td>
								<td style="border:0px solid #FF0000;">
									<table width="100%"  border="0" cellspacing="0" cellpadding="0" style="font-size:11px;">
									<colgroup>
									<col width="10%">
									<col width="*">
									<col width="25%">
									</colgroup>
									<tr><td style="padding:2px 5px;height:15px;"><div style="width:100%;padding:2px 0;background-color: #5e9ce8;"></div></td><td>주유/자동차/보험          </td>	<td style="text-align:right;padding-right:25px;">0%</td></tr>
									<tr><td style="padding:2px 5px;height:15px;"><div style="width:100%;padding:2px 0;background-color: #B89E84;"></div></td><td>의료/스포츠/뷰티          </td>	<td style="text-align:right;padding-right:25px;">8%</td></tr>
									<tr><td style="padding:2px 5px;height:15px;"><div style="width:100%;padding:2px 0;background-color: #FB771F;"></div></td><td>항공/여행                 </td>	<td style="text-align:right;padding-right:25px;">0%</td></tr>
									<tr><td style="padding:2px 5px;height:15px;"><div style="width:100%;padding:2px 0;background-color: #59B8C0;"></div></td><td>쇼핑/전자상거래           </td>	<td style="text-align:right;padding-right:25px;">39%</td></tr>
									<tr><td style="padding:2px 5px;height:15px;"><div style="width:100%;padding:2px 0;background-color: #60b736;"></div></td><td>생활요금(교통/통신/관리비)</td>	<td style="text-align:right;padding-right:25px;">10%</td></tr>
									<tr><td style="padding:2px 5px;height:15px;"><div style="width:100%;padding:2px 0;background-color: #FFDC39;"></div></td><td>교육                      </td>	<td style="text-align:right;padding-right:25px;">0%</td></tr>
									<tr><td style="padding:2px 5px;height:15px;"><div style="width:100%;padding:2px 0;background-color: #C089D2;"></div></td><td>외식/공연/영화            </td>	<td style="text-align:right;padding-right:25px;">6%</td></tr>
									<tr><td style="padding:2px 5px;height:15px;"><div style="width:100%;padding:2px 0;background-color: #CFCFCF;"></div></td><td>기타                      </td>	<td style="text-align:right;padding-right:25px;">38%</td></tr>
									</table>
								</td>
							</tr>
							</table>
							</div>
						</td>
					</tr>
				</table>
				<div >
				<ul>
				<li>분야별 이용현황은 신용카드 및 체크카드 이용금액을 합산하여 작성되었으며, 고객님의 명세서 작성기준일 '전월1일~말일까지'<br/>이용현황입니다.</li>
				<li>이용현황 비율이 5% 미만인 경우 그래프 상 분야명이 표시되지 않습니다.</li>
				<li>기타 자세한 사항은 KB국민카드 홈페이지 카드이용내역조회에서 확인 가능합니다.
				<a %OFR_ID=66% href="https://card.kbcard.com/CXPPPMYS0186.cms" target="_new">
				<img src="https://img1.kbcard.com/LT/images/mail/mail_details/home_bt.gif" border="0" alt="바로가기" style="vertical-align:middle" onload='
				var p = new pie3();
				p.add("의료/스포츠/뷰티          ",8, "#B89E84" );p.add("쇼핑/전자상거래           ",39, "#59B8C0" );p.add("생활요금(교통/통신/관리비)",10, "#60b736" );p.add("외식/공연/영화            ",6, "#C089D2" );p.add("기타                      ",38, "#CFCFCF" );
				p.render("myCanvas1", " ",140);
				' />
				</a>
				</li>
				</ul>
				</div>
				<!--} -->
				<!-- //분야별 이용현황 -->

				<!--안내말씀 -->
				<table width="648px" cellspacing="0" cellpadding="0" border="0" style="margin-top:40px;">
					<tr>
						<td style="padding-top:4px;padding-bottom:5px;"><span  class="hidettl" style=" font-size: 20px;font-weight: bold;">안내말씀</span><img alt="안내말씀" src="https://img1.kbcard.com/LT/images/mail/mail_details/tit_mail_details05_02.gif"></td>
					</tr>
					<tr>
						<td style="padding-top:4px;padding-bottom:2px;">
							<div class="height2 notice" style="font-size:12px;border:solid 1px #d5d5d5; padding-left: 20px;padding-right: 20px;" tabindex="0">
								
 
								
 
								<!--<ON-NULL-DEL-공통1>--><br>
<br>
<font color="#be4c31">◈ <b>자동화기기 카드금융거래 이용 시 유의사항 안내</b></font><br>
1. 자동화기기 이용 시 불법 복제된 MS카드(IC칩이 없는 신용/체크카드)에 의한 사고를 예방하기 위하여 2015년 3월부터 모든 자동화기기에서 MS카드를 이용한 장기카드대출(카드론) 또는 단기카드대출(현금서비스) 거래가 제한됨을 안내드립니다.<br>
2. 현재 KB국민카드 중 MS카드를 소지하고 계신 고객님께서는 반드시 IC카드로 교체하여 주시기 바랍니다.<br>
<!--<ON-NULL-DEL-공통1>-->
								<!--<ON-NULL-DEL-공통2>--><br>
<br>
<font color="#be4c31">◈ <b>새우편번호 시행 관련 안내 말씀</b></font><br>
국가기초구역 체계로의 새우편번호 시행('15.8.1)으로 기존 우편번호가 6자리에서 5자리로 사용이 의무화 됨에 따라 고객님의 우편번호를 새우편번호로 일괄 전환할 예정입니다.<br>
아울러 새우편번호는 도로명 주소 사용을 기반으로 하고 있어 KB국민카드 고객님을 위한 이용대금명세서 등 우편물이 올바르게 배송될 수 있도록 자택 또는 직장 주소를 도로명 주소로 전환하여 주시기 바랍니다.<br>
※ 자세한 내용은 KB국민카드 홈페이지(www.kbcard.com) 및 고객센터(1588-1688)로 문의하시기 바랍니다.<br>
<br>
<!--<ON-NULL-DEL-공통2>-->
								<!--<ON-NULL-DEL-공통3>--><br>
<br>
<font color="#be4c31">◈ <b>장기카드대출(카드론) 결제대금 자동출금 변경안내</b></font><br>
장기카드대출(카드론) 결제계좌가 농협, 기업, SC, 외환, 신한, 하나, 우리은행인 경우 약정납입일에 납입하실 회차별 금액보다 출금가능잔액이 적을 경우 해당 결제대금 전체가 출금되지 않았으나 시행일(2015. 3.16)부터 출금가능잔액 범위내에서 출금되오니 이용에 참고하여 주시기 바랍니다.<br>
<br>
※ 자세한 내용은 홈페이지(www.kbcard.com) 및 고객센터(1588-1688)로 문의하여 주시기 바랍니다.<br>
<!--<ON-NULL-DEL-공통3>-->
								<!--<ON-NULL-DEL-공통4>--><br>
<br>
<font color="#be4c31">◈ <b>KB국민 굿세이브 서비스 변경안내</b></font> (시행(예정)일: 2015년 5월21일)<br>
- 서비스 명칭 변경: KB국민 굿세이브 서비스 → 포인트 연계 할부서비스(KB국민 굿세이브)<br>
- 세이브 이용가능금액: 최대70만원 → 최대 50만원 내 물품가격의 30%까지 제한<br>
- 세이브 이용 횟수 제한: 회원별 1회 (중복 약정 불가)<br>
※ 자세한 내용은 KB국민카드 홈페이지(www.kbcard.com) 새소식 게시판 또는 KB국민카드 세이브 전용 콜센터(☎1577-9900)로 문의하여 주시기 바라며, 시행일은 대내 외 사정에 의해 변경될 수 있습니다.<br>
<br>
<!--<ON-NULL-DEL-공통4>-->
								<!--< * DELETED BY RSL(Ricky Script Language) Interpreter. ON-NULL-DEL-공통5>-->
								<!--< * DELETED BY RSL(Ricky Script Language) Interpreter. ON-NULL-DEL-공통6>-->
								<!--< * DELETED BY RSL(Ricky Script Language) Interpreter. ON-NULL-DEL-공통7>-->
								<!--< * DELETED BY RSL(Ricky Script Language) Interpreter. ON-NULL-DEL-공통8>-->
								<br>
								<font color="#be4c31">◈ <b>도로명 주소 일괄 전환에 따른 안내</b></font><br>
								도로명주소법(법률 제10987호)에 따라 기 사용중인 고객님의 지번주소를 도로명주소로 전환하였습니다. 아직 전환되지 않은 고객님께서는 홈페이지, 고객센터, 영업점을 통해 개별 전환하여 주시기 바랍니다.
								<br>&nbsp;
							</div>
						</td>
					</tr>
				</table>
				<!--//안내말씀 -->

				<!-- 이용안내 -->
				<div >
					<ul>
						<li>명세서는 3회이상 반송 등록시 발송이 되지 않습니다.
						<!-- * IF CLAUSE PROCESSED BY RSL(Ricky Script Language) Interpreter.  -->
						<!-- * IF CLAUSE PROCESSED BY RSL(Ricky Script Language) Interpreter.  -->
						<!-- * IF CLAUSE PROCESSED BY RSL(Ricky Script Language) Interpreter.  -->
						<!-- * IF CLAUSE PROCESSED BY RSL(Ricky Script Language) Interpreter.  -->
						<!--IF ZZ == ZZ {--><li>고객센터 : ☎ 1588-1688 (전국단일망)<!--} -->
					</ul>
				</div>
				<!-- //이용안내 -->
				<!--IF Y == Y {-->
				<table  class="tglDisplay" border="0" width="100%" cellpadding="0" cellspacing="0" style="margin-top:40px;" >
					<tr>
						<td style="height: 40px">
							<a href='javascript:document.body.scrollTop=0;upp_viewLay_new("3","https://img1.kbcard.com/LT/images/mail/mail_details/mail_detailsMenu");'><img alt="이전페이지" src="https://img1.kbcard.com/LT/images/mail/mail_details/btn_pre.gif" border="0"/></a>
						</td>
					</tr>
				</table>
				<!--} -->
			</div>
			<!-- //이벤트안내 -->

            <div style="position:absolute;right:-65px;top:90px" id="subTab2"  >
			    <a href="#" ><img alt="맨위로 이동" src="https://img1.kbcard.com/LT/images/mail/mail_details/card_e_bt_top.gif" onclick="document.body.scrollTop=0;" border="0" style='cursor:hand' /></a>
    		</div>
		</td>
		<!-- //middle_content -->
		<!-- right_content -->
		<td style="background:url('https://img1.kbcard.com/LT/images/mail/mail_details/bg_wrap_right1.gif') no-repeat;vertical-align:top;min-height:700px;"> &nbsp;
			
		</td>
		<!-- //righ_content -->
		</tr>
		<tr>
		<td colspan="3" style='text-align: right;'>
			<img src="https://img1.kbcard.com/LT/images/mail/mail_details/mail_details_footer.gif" 
			onload='upp_viewLay_new("1","https://img1.kbcard.com/LT/images/mail/mail_details/mail_detailsMenu");hideTop();' 
			alt="서울 종로구 새문안로 3길 30 (주)KB국민카드 사업자등록번호 101-86-61717  COPYRIGHT(C)2011 KB KOOKMIN CARD CO.,LTD. ALL RIGHTS RESERVED." />
		</td>
		</tr>
	</table>
</div>
<!-- * IF CLAUSE PROCESSED BY RSL(Ricky Script Language) Interpreter.  -->
</center>
<!---END_ENC--->
</body>

</html>
