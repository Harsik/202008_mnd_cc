<!DOCTYPE HTML>
<!-- saved from url=(0036)https://mnd.mous.mil/index.do -->
<!DOCTYPE html PUBLIC "" ""><HTML lang="ko"><HEAD><META content="IE=11.0000" 
http-equiv="X-UA-Compatible">
	     
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">     <!-- Meta, title, CSS, favicons, etc. --> 
         
<META http-equiv="X-UA-Compatible" content="IE=edge">	 
<META name="description" content="국방전산정보원">	 
<META name="author" content="국방전산정보원">     <TITLE>전군 사용자정보 통합관리 체계 
[MOUS]</TITLE>     
<META name="viewport" content="width=device-width, initial-scale=1">         <!-- Favicon --> 
    <LINK href="/images/oms/favicon/favicon.ico" rel="shortcut icon" type="image/x-icon"> 
    <!-- jQuery -->     
<SCRIPT src="전군%20사용자정보%20통합관리%20체계%20[MOUS]_do_files/jquery-3.4.1.min.js"></SCRIPT>
         <!-- bootstrap -->     
<SCRIPT src="전군%20사용자정보%20통합관리%20체계%20[MOUS]_do_files/bootstrap.min.js"></SCRIPT>
         <!-- jQuery-ui -->     
<SCRIPT src="전군%20사용자정보%20통합관리%20체계%20[MOUS]_do_files/jquery-ui.min.js"></SCRIPT>
     <LINK href="전군%20사용자정보%20통합관리%20체계%20[MOUS]_do_files/jquery-ui.min.css" 
rel="stylesheet">	 <!-- jQuery mask -->	 
<SCRIPT src="전군%20사용자정보%20통합관리%20체계%20[MOUS]_do_files/jquery.inputmask-5.x.js"></SCRIPT>
	     <!-- DataTables -->     
<SCRIPT src="전군%20사용자정보%20통합관리%20체계%20[MOUS]_do_files/datatables.min.js"></SCRIPT>
     
<SCRIPT src="전군%20사용자정보%20통합관리%20체계%20[MOUS]_do_files/dataTablesCommon.js"></SCRIPT>
     <LINK href="전군%20사용자정보%20통합관리%20체계%20[MOUS]_do_files/datatables.css" rel="stylesheet"> 
   	 <!-- 공통 js  -->	 
<SCRIPT src="전군%20사용자정보%20통합관리%20체계%20[MOUS]_do_files/oms_common.js"></SCRIPT>
	 
<SCRIPT src="전군%20사용자정보%20통합관리%20체계%20[MOUS]_do_files/search.js"></SCRIPT>
		<!--  design -->	 <LINK href="전군%20사용자정보%20통합관리%20체계%20[MOUS]_do_files/bootstrap.min.css" 
rel="stylesheet">	 <LINK href="전군%20사용자정보%20통합관리%20체계%20[MOUS]_do_files/style.css" 
rel="stylesheet">	 <LINK href="전군%20사용자정보%20통합관리%20체계%20[MOUS]_do_files/font.css" 
rel="stylesheet">	 <LINK href="전군%20사용자정보%20통합관리%20체계%20[MOUS]_do_files/login.css" 
rel="stylesheet"> 
<META name="GENERATOR" content="MSHTML 11.00.10570.1001"></HEAD> 
<BODY>
<DIV class="login_wrapper"><!-- login area  -->     
<DIV class="login_area"><!-- page content -->

<LINK href="전군%20사용자정보%20통합관리%20체계%20[MOUS]_do_files/kcase.css" rel="stylesheet"> 
<SCRIPT src="전군%20사용자정보%20통합관리%20체계%20[MOUS]_do_files/kcaseagent.js"></SCRIPT>
 
<SCRIPT src="전군%20사용자정보%20통합관리%20체계%20[MOUS]_do_files/nppfs-1.9.0.js"></SCRIPT>
 
<SCRIPT language="JavaScript" type="text/javascript">
 

var SSL_URL = "";
var SSL_CHECK = false;
if( true == SSL_CHECK ){
	SSL_URL = "https://mnd.mous.mil";
	if( location.href.indexOf("https") == -1 ){
		location.href = SSL_URL;
	}
}

//로딩창 표시 유무, 없거나 true면 Loading 창 출력, false면 로딩창 미출력
var ksign_visibleLoading = false;

//true 일 경우 인증서 삭제 -> 인증서 찾기로 대체
var ksign_disableDelete = true;						


$(document).ready(function() {
	
	$("#srvno").css("ime-mode", "inactive");
	
	function textareaResize(obj) {
         obj.style.height = "1px";
         obj.style.height = (20 + obj.scrollHeight) + "px";
     }
	 
	var aaa = null;
	var testServerEnvCert = "MIIF1DCCBLygAwIBAgIUb3NtU2HefRfpcak+Od6Ultu1zYkwDQYJKoZIhvcNAQELBQAwUDELMAkGA1UEBhMCS1IxHDAaBgNVBAoME0dvdmVybm1lbnQgb2YgS29yZWExDTALBgNVBAsMBEdQS0kxFDASBgNVBAMMC0NBMTM0MTAwMDMxMB4XDTE3MTIxOTAyMzM1NVoXDTIwMDMxOTAyMzM1NFowcjELMAkGA1UEBhMCS1IxHDAaBgNVBAoME0dvdmVybm1lbnQgb2YgS29yZWExGDAWBgNVBAsMD0dyb3VwIG9mIFNlcnZlcjESMBAGA1UECwwJ6rWQ7Jyh67aAMRcwFQYDVQQDDA5TVlJaMTIzNDU2NzA5NDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKq6G0I0PlHjdDStbChMOthnp4xK9lgiLeYwcgEzLh2DhA9A+Plm916Dob9wZ7JgcxQwPfy4j9UxPcXYPK1eACfI/1YVC2rcea+NHQ3WV+fm2x8Ut6E6fTfr3YuWAl22gx/tuiJYXgL+gEOQU+qYfNt4rHfXqB6jyvzlSMjHnJFtu6qLRu6jV7CLo4Ep9MxQQc2IZRUdWREsc6iNDW9UIxA8Z1glDs+RS8GPBSi2wFjlYCiDWKB4d5yYYO39Zem6GXJh6Xr8j0Mj2V0rY9IbIvrVQPJM5Dn5F0hbgTYcNzSaDzPbofc5GjWAsee8XkRhaB07v/BUhaLA7SvykQkiFlkCAwEAAaOCAoIwggJ+MDcGCCsGAQUFBwEBBCswKTAnBggrBgEFBQcwAYYbaHR0cDovL29jc3AuZXBraS5nby5rcjo4MDgwMHkGA1UdIwRyMHCAFI5G+A2eeHaizBrkD1F/UtdNnFsboVSkUjBQMQswCQYDVQQGEwJLUjEcMBoGA1UECgwTR292ZXJubWVudCBvZiBLb3JlYTENMAsGA1UECwwER1BLSTEUMBIGA1UEAwwLR1BLSVJvb3RDQTGCAicZMB0GA1UdDgQWBBQ/o1GJ3SqZdGYBwl2CQ1/eFOWe+TAOBgNVHQ8BAf8EBAMCBDAwbQYDVR0gAQH/BGMwYTBfBgoqgxqGjSEFAwEHMFEwKgYIKwYBBQUHAgEWHmh0dHA6Ly93d3cuZXBraS5nby5rci9jcHMuaHRtbDAjBggrBgEFBQcCAjAXGhVFZHVjYXRpb24gQ2VydGlmaWNhdGUwMQYDVR0SBCowKKAmBgkqgxqMmkQKAQGgGTAXDBXqtZDsnKHqs7ztlZnquLDsiKDrtoAwbAYDVR0RBGUwY6BhBgkqgxqMmkQKAQGgVDBSDA0xOTIuMTY4LjExLjEwMEEwPwYKKoMajJpECgEBATAxMAsGCWCGSAFlAwQCAaAiBCBOfZvLAu2tJvDMHkm5EOM32F6qR2x9A2Nh+7k3v9FI/zCBiAYDVR0fBIGAMH4wfKB6oHiGdmxkYXA6Ly9sZGFwLmVwa2kuZ28ua3I6Mzg5L2NuPWNybDFwMWRwMTYzMDYsb3U9Q1JMLG91PUdQS0ksbz1Hb3Zlcm5tZW50IG9mIEtvcmVhLGM9a3I/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdDtiaW5hcnkwDQYJKoZIhvcNAQELBQADggEBAEDxnm/rzCaivxdx+TqrnYzTBlm0ngJq/kpRrRoWxCnuZGdBjRxmWr7WI05dhFa9+MYahjHrlp8VPwwEyzAzwSeBFcFUh0H1Zv9nyQ7dkPYbAYy/2rWjYyK2F0g6ChN7mgrWN5dji5FDS0xyAT2VeCZtdWSlfte1HhwSc19t7JWSsRXr9IMLyY9Eync52lYlehdLPwTfEwJk4ayvDigXcCazthwDF8RSuyohwAtZyeOcWwvfIXjvuNjFPPCthNmA8OZhNhirm58YWTNHbe3+9ZdPp3YgTGqtynSwIqog/7qiVvWUKpigQ23DzX/iE4/CXF5tssUm6nf/0NGchLH9jtE=";
	
	var kcaseAgentFile = location.protocol + "//" + location.host + "/HTML5/kcase/lib/download/KSignCASE For HTML5_Windows_v1.3.19.exe";
	
    var sectionList = $("section");
    sectionList.css("display", "none");

    var menuList = $(".menu li");

    var menuLen = menuList.length;
    for (var i = 0; i < menuLen; i++) {
        menuList.eq(i).click(function () {
            sectionList.css("display", "none");
            sectionList.eq($(this).index()).css("display", "block");
        });
    }
    menuList.eq(0).click();

    /* 설치 체크 */
    var installText = $("#kc_install .table-input-text");

    $("#kc_install .table-input-text").find("input").click(function() {
        npPfsStartup(null, false, true, false, false, "npkencrypt", "on");
        kcaseagt.enableNosAdapter();
        alert("nos 설정 완료");
    });

    kcaseagt.checkInstallAgent({
        success: function() {
            installText.eq(0).text("설치됨");
            kcaseagt.init({
                debug: false,
                libRoot: location.protocol + "//" + location.host + "/HTML5/kcase/lib",
                sessId: "UrNMylmmAQAjAYCL1yykDaa2EEInkM74dy0fn8h3nbF9vU5GJGAdzyBgeifjEgaH.amV1c19kb21haW4vcG9ydGFsMg==",
                mainTitle: "인증서 로그인(전자서명)",
                adminTitle: "인증서 관리",
		chkexpiredcert: 1,
                position: "center",
                maxpwdcnt: 5, // maxpwdcnt 0 이면 비밀번호 변경시 비밀번호 체크하지 않음  
                mediaOpt: kcaseagt.enable.all,
										invisibleMedia: kcaseagt.enable.pkcs11,
										//kcaseagt.enable.harddisk : 하드디스크 숨김 
										//kcaseagt.enable.remdisk: 이동식 디스크 숨김 
										//kcaseagt.enable.savetoken: 저장토큰 숨김 
										//kcaseagt.enable.pkcs11: 보안토큰 숨김 
										//kcaseagt.enable.mobile: 유비키 숨김 
                success: function() {
                    //kcaseagt.enableNosAdapter();
                	/*
                    kcaseagt.secureChannelLogin({
			                    peerCert: testServerEnvCert,
			                    algorithm: kcaseagt.algorithm.SEED,
			                    success: function (output) {
			                    	var input = "secureChannelLoginRequest=" + encodeURIComponent(output);
			                        $.ajax({
							                    type : "POST",
							                    url : "channel/Channel_Login.jsp",
							                    dataType: "json",
							                    data : input,
							                    success : function(data) {
							                    		alert("[ " + data.result + " ]\n" +
							                    		 "인증서 DN : [ " + data.dn + " ]\n" +
							                    		 "발급자 DN : [ " + data.issuerDN + " ]\n" +
							                    		 "인증서 SN : [ " + data.serial + " ]");
							                    },
							                    error : function() {
							                        alert("jsp 에러");
							                    }
							                });
			                    }, error: function (c, msg) {
			                        alert(c + ": " + msg);
			                    }
        						});
	                */
                    },
                    error: function (c, msg) {
                    alert(c + ": " + msg);
                },
                serviceError: function() {
                    alert("Module Load Fail!!");
                    //location.reload(true);
                },
                error: function(errCode, errMsg) {
                    alert(errCode + ": "+ errMsg);
                },
                sessionError: function() {
                    alert("세션 만료");
                },
                noUbiKey: function() {
                    alert("서비스 준비중입니다.");
                }
            });
        },
        error: function(errCode, errMsg) {
            alert(errCode + "::: "+ errMsg);
            installText.eq(0).text("설치가 필요합니다.");
            location.href=kcaseAgentFile ; 
        }
    });

    /* 채널보안 로그인 동시 수행 */
    var channelAndLoginTexts = $("#kc_channelAndLogin .table-input-text").find("textarea");
    
  
    
    $("#crtLogin").click(function() {  
    	var algorithm;
      	kcaseagt.secureChannelLogin({
            peerCert: testServerEnvCert,
            algorithm: algorithm,
            success: function (output) {
                channelAndLoginTexts.eq(0).val(output);     
                $.ajax({
                    type : "POST",
                    url : "/adm/lgn/admLogin/ChannelLogin.do",
                    dataType: "json",
                    data : $("#kc_channelAndLogin #channel_login_req_data").serialize(),
                    success : function(data) {
                       	
                    	/*
                    	var certino = data.dn;
                    	alert(data.dn);
                    	return;
                       	*/
                       	
                       	//alert(data.dn);
                    	//return;
                       	
                    	fnSsoLogin(data.dn);
                    	
                       	/*
                    	var url = "/adm/mns/chngPsninf/updateUsrCrtIno.do";
                       	var param = {certino: certino};


                       	$.post(url, param, function(res){
                       		var objRes = JSON.parse(res);
                       		alert(objRes.message);

                       	}).fail(function(){
                       		alert("인증서 등록 중 오류가 발생하였습니다.");
                       	});
                       	
                       	*/
                    },
                    error : function() {
                        alert("jsp 에러");
                    }
                });
            }, error: function (c, msg) {
                alert(c + ": " + msg);
            }
        });
    });
});


/**
 * 화면 팝업
 */
function fnPopup(nSel){
	
	var sURL = "/usr/ent/newentr/popNewEntrStep1Scr.do";
	var nWidth = 1005, nHeight = 900;
	var sPopupNm = "NEWENTR";
	
	switch(nSel){
	
		case 1: // 신규
			sPopupNm = "NEWENTR";
			sURL = "/usr/ent/nen/newentr/popNewEntrStep1Scr.do";
			break;
		case 2: // 등록신청/확인
			sPopupNm = "NEWENTR";
			sURL = "/usr/ent/stu/aplcfmtn/popAplCfmtnStep1Scr.do";
			break;
		case 3: // 비밀번호 찾기
			sPopupNm = "FINDPW";
			nWidth = 850, nHeight = 650;
			sURL = "/usr/ent/pwf/pwfndng/popUserPwFndng.do";
			break;
		case 4: // FAQ
			nWidth = 1005, nHeight = 700;
			sPopupNm = "FAQ";
			sURL = "/usr/ent/inf/faq/popFaqExpsrList.do";
			break;
		case 5: // 문의게시판(로그인 이전 접근 가능)
			nWidth = 1005, nHeight = 700;
			sPopupNm = "INA";
			sURL = "/usr/inf/ina/inaExpsr/popInaExpsrList.do";
			break;
	
	}//--end--switch
	
	cfPopupCentr(sURL, sPopupNm, nWidth, nHeight);
}

/**
 * 공지사항 상세보기 화면 팝업
 */
function fnPopupNotice(notice_seq){
	var sURL = "/usr/ent/inf/ntc/popNtcExpsr.do?notice_seq="+notice_seq;
	var nWidth = 1005, nHeight = 700;
	var sPopupNm = "NOTICE";
	
	cfPopupCentr(sURL, sPopupNm, nWidth, nHeight);
}


/**
 * 엔터키 처리 
 */
function fnEnterKey(){
	var evt_code = (window.netscape) ? ev.which : event.keyCode;
	if (evt_code == 13) {    
		event.keyCode = 0; 
		fnLogin();
	} 
}



/**
 * 로그인 
 */
function fnLogin() {
	
	var form = document.loginForm;
	var srvno = form.srvno.value.trim(); 
	var password = form.pw.value.trim();
	
	if ( "" == srvno ) {
		alert( 'ID를 입력하세요!' );
		form.srvno.focus();
		return false;
	} else{
		
		var nSrvnoLen = srvno.length;
		if( nSrvnoLen < 4 ){
			alert( 'ID를 입력하세요!' );
			form.srvno.focus();
			return false;
		}
	}
	
 	if ( 3 >  password.length ) {
		alert( '비밀번호를 입력하세요!' );
		form.pw.focus();
		return false;
	} 

 	/*
 	var pwdRule = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[~!@#$%^&*])[A-Za-z\d~!@#$%^&*]{9,}$/;
    if (! pwdRule.test(password)){
    	alert("비밀번호는 9자리 이상 영문,숫자,특수문자 조합으로 입력하세요.");
    	form.pw.focus();
		return false;															
	} 
	*/
	
	form.pw.value = cfEnc(srvno, password);	
	form.action = SSL_URL+"/actionSecurityAdmLogin.do";
	form.submit();
}

//인증서 로그인
function fnSsoLogin(crtNo) {
	
	var form = document.loginForm;

	form.certino.value =  crtNo;
	form.login_type.value =  "C"; //로그인타입 - 인증서 로그인
	
	if ( "" == form.certino.value) {
		alert( '인증서값이 존재하지 않습니다' );
		return false;
	} 

	form.action = SSL_URL+"/actionSecurityAdmLogin.do";
	form.submit();

}

</SCRIPT>
 
<DIV class="login_top_area">
<P class="login_tit"><SPAN>M O U S</SPAN></P>
<P class="login_txt">전군 사용자정보 통합관리 체계<SPAN>Management of Organization &amp; User 
System</SPAN></P></DIV>
<DIV class="login_notice_line"><A onclick="fnPopupNotice(367)" href="https://mnd.mous.mil/index.do?sso=ok#none">국방부·육·해·공군 
기관관리자 목록(210113 기준) &nbsp;[2021-01-13]</A><BR><A onclick="fnPopupNotice(353)" 
href="https://mnd.mous.mil/index.do?sso=ok#none">패스워드 초기화 관련 조치방법 
&nbsp;[2020-12-04]</A><BR></DIV><!--  form  --> 
<FORM name="loginForm" class="login_form" id="loginForm" onsubmit="return false;" 
method="post"><INPUT name="certino" id="certino" type="hidden">	 <INPUT name="login_type" id="login_type" type="hidden">
	 
<P class="login_p m_b_10">본래 소속 군을 선택해주세요. <SPAN class="col_r">(주의! 근무지 소속 
아님!)</SPAN></P>
<UL class="login_radio_wrap">
  <LI class="radio_1"><INPUT name="mdcd" id="mdcd1" type="radio" checked="" 
  value="m"><LABEL for="mdcd1"><SPAN></SPAN>국방부</LABEL></LI>
  <LI class="radio_2"><INPUT name="mdcd" id="mdcd2" type="radio" 
  value="a"><LABEL for="mdcd2"><SPAN></SPAN>육군</LABEL></LI>
  <LI class="radio_3"><INPUT name="mdcd" id="mdcd3" type="radio" 
  value="n"><LABEL for="mdcd3"><SPAN></SPAN>해군</LABEL></LI>
  <LI class="radio_4"><INPUT name="mdcd" id="mdcd4" type="radio" 
  value="f"><LABEL for="mdcd4"><SPAN></SPAN>공군</LABEL></LI></UL>
<TABLE class="m_t_20">
  <CAPTION>로그인영역</CAPTION>
  <COLGROUP>
  <COL width="45%">
  <COL width="55%"></COLGROUP>
  <TBODY>
  <TR>
    <TD><INPUT name="srvno" tabindex="1" title="군번/ID" id="srvno" type="text" placeholder="군번/ID" value=""></TD>
    <TD rowspan="2"><BUTTON tabindex="3" class="login_btn" 
      onclick="fnLogin()">로그인</BUTTON>                 <BUTTON class="login_btn2" 
      id="crtLogin">인증서<BR>로그인</BUTTON>             </TD></TR>
  <TR>
    <TD><INPUT name="pw" tabindex="2" title="PASSWORD" id="pw" type="password" placeholder="PASSWORD" value="" autocomplete="off"></TD></TR></TBODY></TABLE>
<UL class="login_cont_wrap">
  <LI>    		※ 사용자 구분이 <SPAN class="col_b">군인/군무원 </SPAN>일 경우  <SPAN class="col_b">군번/순번</SPAN>,<BR><BR><SPAN 
  class="col_b">공무원/공무직근로자/민간인 </SPAN>일 경우에는  <SPAN class="col_b">아이디</SPAN>를 
  입력하세요.    	 </LI></UL>
<UL class="login_cont_wrap">
  <LI><A onclick="fnPopup(1)" 
  href="https://mnd.mous.mil/index.do?sso=ok#none">신규등록</A></LI>
  <LI><A onclick="fnPopup(2)" 
  href="https://mnd.mous.mil/index.do?sso=ok#none">신청확인</A></LI>
  <LI><A onclick="fnPopup(3)" 
  href="https://mnd.mous.mil/index.do?sso=ok#none">비밀번호 찾기</A></LI>
  <LI><A onclick="fnPopup(4)" 
  href="https://mnd.mous.mil/index.do?sso=ok#none">FAQ</A></LI>
  <LI><A onclick="fnPopup(5)" 
  href="https://mnd.mous.mil/index.do?sso=ok#none">문의게시판</A></LI><!--  임시 링크 임.  --> 
            </UL></FORM>
<DIV class="api-description-box" id="kc_channelAndLogin" style="display: none;">
<H3 class="api-description-msg">채널보안 로그인 동시수행</H3><!-- 테스트 설명 -->     
<DIV class="api-description-content">
<H5>            클라이언트와 서버 간 보안채널 형성과 로그인 절차에 대한 요청 메시지를 생성합니다.<BR></H5></DIV>
<DIV class=".api-description-box-gray">
<DIV class="api-description-subject">
<H4>기능 시험</H4></DIV>
<DIV class="api-description-func">
<FORM id="channel_login_req_data" style="width: 100%;">
<TABLE class="table table-bordered">
  <TBODY>
  <TR>
    <TD class="table-input-name">                            암호화 알고리즘          
                     </TD>
    <TD class="table-input-text"><SELECT><OPTION>SEED</OPTION>               
                          <OPTION>ARIA</OPTION>                                 
        <OPTION>3DES</OPTION>                                 
        <OPTION>AES</OPTION>                             </SELECT>                 
              </TD></TR>
  <TR>
    <TD class="table-input-name">세션 아이디                         </TD>
    <TD 
      class="table-input-text">UrNMylmmAQAjAYCL1yykDaa2EEInkM74dy0fn8h3nbF9vU5GJGAdzyBgeifjEgaH.amV1c19kb21haW4vcG9ydGFsMg== 
                              </TD></TR>
  <TR>
    <TD class="table-input-name">채널보안 로그인 동시수행 요청 메시지                         
    </TD>
    <TD 
class="table-input-text"><TEXTAREA name="secureChannelLoginRequest" ondblclick="textareaResize(this)"></TEXTAREA> 
                              </TD></TR></TBODY></TABLE></FORM></DIV></DIV></DIV><!--  // form  -->
				 <!-- //page content -->				 </DIV><!--// login area  -->		    	 <!-- footer content -->
	  <FOOTER class="login_footer">Copyright ⓒ 2020 Ministry of  National Defense 
All Right Reserved.</FOOTER><!-- //footer content --> </DIV></BODY></HTML>
