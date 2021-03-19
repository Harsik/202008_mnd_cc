var sSoftphoneType = "";
var arBtn = new Array(10);

//기능 버튼 ID 정의
arBtn["0"] = "softphone_1";//대기
arBtn["1"] = "softphone_2";//걸기
arBtn["2"] = "softphone_3";//끊기
arBtn["3"] = "softphone_4";//보류
arBtn["4"] = "softphone_5";//협의
arBtn["5"] = "softphone_6";//3자통화
arBtn["6"] = "softphone_7";//업무
arBtn["7"] = "softphone_8";//이석
arBtn["8"] = "softphone_9";//재접속
arBtn["9"] = "softphone_10";//로그아웃

//arBtn["0"] = "but_waiting";//대기
//arBtn["1"] = "but_call";//걸기
//arBtn["2"] = "but_quit";//끊기
//arBtn["3"] = "but_hold";//보류
//arBtn["4"] = "but_confer";//협의
//arBtn["5"] = "softphone_6";//3자통화
//arBtn["6"] = "softphone_7";//업무
//arBtn["7"] = "but_rest";//이석
//arBtn["8"] = "but_reconnect";//재접속
//arBtn["9"] = "but_logout";//로그아웃

//var arBtnR = new Array(8);
//
//arBtnR["0"] = "softphone_11";      //
//arBtnR["1"] = "softphone_12";      //
//arBtnR["2"] = "softphone_13";      //
//arBtnR["3"] = "softphone_14";      //
//arBtnR["4"] = "softphone_15";      //
//arBtnR["5"] = "softphone_16";      //
//arBtnR["6"] = "softphone_17";      //
//arBtnR["7"] = "softphone_18";

// not ready 상태 문구 정의
var arStateText = new Array();
arStateText["41"] = "식사";
arStateText["42"] = "교육";
arStateText["43"] = "채팅";
arStateText["44"] = "업무";
arStateText["45"] = "휴식";
arStateText["46"] = "기타";
arStateText["47"] = "미스콜";
arStateText["48"] = "콜백";

arStateText["0"] = "휴식"; //
arStateText["1"] = "준비"; //개인
arStateText["2"] = "식사"; //
arStateText["3"] = "티타임"; //삭제
arStateText["4"] = "교육"; //
arStateText["5"] = "문자상담"; //회의
arStateText["6"] = "상담"; //삭제
arStateText["7"] = "업무"; // 다른업무
arStateText["8"] = "이석"; //기타, 개인업무
arStateText["9"] = "수리"; // 삭제
 
var REASONCODE = "";
var RECKEY = "";                             // CTI에서 제공하는 Call Id

//var callObject = {
//	"objstat" : "init", //객체상태
//	//call packet
//    "callid" : "", //call id
//    "recid" : "", //recording id
//    "queue" : "", //큐
//    "extno" : "", //내선번호
//    "telno" : "", //전화번호
//    "message" : "", //메세지
//    "command" : "", //이벤트 명령
//    "callType" : "", // inb:1, outb:2 , inter:4
//    "reasoncd" : "", //사유코드
//    "result" : "", //결과
//    "status" : "", //상태
//    "agenthangup" : "",
//    //상태값
//    "tr" : "", //input,output
//    "ticketid" : "", //티켓id
//    "custid" : "", //고객ID
//    "custnm" : "", //고객이름
//    "custfiller" : "", //비고
//    "event_tm" : "", //이벤트 시간
//    "bReady" : false, //대기중
//    "bBusy" : false, //통화중
//    "bHold" : false, // 보류즁
//    "bCalling" : false, //인바운드 상태
//    "bDialing" : false, //아웃바운드 상태
//    "bConsult" : false, // 협의중
//    "bTransfer" : false, // 호전환
//    "nHoldCnt" : 0, // 보류 카운트
//    "outbound" : "", //아웃바운드 구분 콜백, 해피콜..
//    "arsauth" : "", //ars인증 구분 본인확인, 주민번호, 위치동의 ...
//    "currState" : "", //현재상태 코드
//    "textState" : "", //상태 문자
//    "prevStatus" : "", // 이전 전화상태 
//    "prevEvent" : "", //이전 이벤트
//    "prevTelno" : "", //이전 전화번호
//    "prevEventTm" : "", //이전 이벤트 시간
//    "prevConntact" : "",// 이전연결구분
//    "callStartTm" : "", //전화연결 시각
//    "callFinishTm" : "",//전화끊긴 시각
//    "callConntactTm" : ""
//}

var INBOUND = "1";
var OUTBOUND = "2";
var IVR_Message = "1";  // IVR 언어별 서비스구분  1:한글, 2:영어, 3:중국어, 4:일어
var AGENT_HANGUP = "0";

var nMsgLine = 0;

var gCallStartTime = "";                      // 통화시작시간
var gCallReleaseTime = "";                    // 통화종료시간
var gCallConnectTime = "";                    // 통화연결시간

var gInitCallStartTime = "";                  // 초기 통화시작시간 

var bDialing = false;                         // Dialing 
var bCalling = false;                         // 통화중
var bReleased = true;                         // 통화종료여부

var bInter = false;                         // 내선

var g_autoReadyTimer = null;
var g_getWaitCountTest = "ON";   // 테스트시 "TEST"
var g_getWaitStatus = "";
var g_ArsAuthProcess = "";
var g_ArsAuthStatus = "";
var g_ArsAuthDateTime = "";
var g_agentId= window.sessionStorage.getItem("USR_ID");
var g_holdCount=0;
var g_happyCallgb="";
var g_readyFlag=true;
var g_connStat=""; // 전화연결시 최종이 'ESTABLISHED'

var g_prevEvent="";
var g_prevTelnum="";
var gjtelno  = "";
var g_arr_UEI=[];

var g_transFlag="";
var g_holdFlag="";

var g_RecSvrIP="";
 
 
/*
90008	11000	로그인
90008	12000	대기
90008	13000	통화중
90008	14000	후처리
90008	20000	이석
90008	21041	식사
90008	21042	교육
90008	21043	미팅
90008	21044	업무
90008	21045	휴식
90008	21046	미스콜
90008	21047	콜백
*/

// 업무상태코드
var LOGIN   = "11000";     // 로그인
var READY   = "12000";     // 대기
var CALLING = "13000";     // 통화중
var ABD     = "21046";     // Abandon Call/포기콜
var ACW     = "14000";     // 후처리

// NotReady 상태
var VAC  = "20000";       // 이석
var EAT  = "21041";       // 식사
var EDU  = "21042";       // 교육
var MEET = "21043";       // 미팅
var WORK = "21044";       // 업무
var REST = "21045";       // 휴식

/*
0 : 일반휴식 - 삭제
1 : 작업 - 준비
2 : 이석 - 이석
3 : 식사 - 식사
4 : 휴식 - 휴식
5 : 회의 - 채팅
6 : 교육 - 교육
7 : 다른업무 - 다른업무
8 : 개인업무 - 삭제
9 : 수리 - 삭제
*/

var currStatus = "";

function openConn() {
	 
//	alert('openConn');
	// 웹소켓 오브젝트 할당, 데몬 웹소켓 서버주소가 파라미터
	ws = new WebSocket("ws://127.0.0.1:9068");

	// 웹소켓 서버 연결 성공
	ws.onopen = function() {
		//sendCmd(initCmd);
		//alert('Websocket Opened!!');
		fnInitCTI();
	}
	
	// 웹소켓 서버 연결 종료
	ws.onclose = function() {
		//putMsg("websocket server connection is closed...");
		//console.log("ws.onclose");
		setTimeout(function() {
	      openConn();
	    }, 2000);
	}
	
	// 웹소켓 에러 처리
	ws.onerror = function(evt){
		//putMsg(evt.data);
		console.log(evt);
		ws.close();
	}

	// 웹소켓 서버로부터 데이터 수신
	ws.onmessage = function(evt){
		fnGetEvent(evt.data);
	}
}

// 현재 컨텍스트를 반환
function getContextPath()
{
	// context path 존재 하지 않는 프로젝트일 경우
	var ctxPath = "http://" + location.host;
	
	return ctxPath;
    
	/*
	if(location.host.match("/"))
	{
		// context path 존재 하는 프로젝트일 경우
	    var offset = location.href.indexOf(location.host) + location.host.length;
	    var ctxPath = location.href.substring(offset, location.href.indexOf('/', offset + 1));
	    
	    //alert("if getContextPath() " + ctxPath);
	    return ctxPath;
	}
	else
	{
		// context path 존재 하지 않는 프로젝트일 경우
		var ctxPath = "http://" + location.host;
		//alert("else getContextPath() " + ctxPath);
		
		return ctxPath;
	}
	*/
}

/**
 * 통화종료중인 지를 리턴한다.
 * 
 * @returns {Boolean}
 */
function isReleased() {
	return bReleased;
}

// cti 초기 설정
function ctiInit()
{
	try
	{	
		$("#EXTNO").val(localStorage.getItem("EXTNO"));
		// cti id와 내선번호를 셋팅 후 서버 연결 시도
		USERID = $("#CTIID").val();
		EXT = $("#EXTNO").val();
		// 20.12.01 관리자/교환원 구분
		if(USERID == "2019"||USERID == "2002"||USERID == "1040"||USERID == "1041"){
			window.sessionStorage.setItem("ADMIN_YN","Y");
		}else{
			window.sessionStorage.setItem("ADMIN_YN","N");
		}
		window.sessionStorage.setItem("USERID",USERID); 
		window.sessionStorage.setItem("EXTNO",EXT); 
		if(USERID != "" && EXT != "")
		{
			//writeLogFile("Request [CT_CONNECTSERVER]");
			openConn();                                           // WebSocket 연결
		}
		else
		{
			alert("아이디 또는 내선번호를 확인해 주세요!");
		}
	}
	catch(e)
	{
		alert( "error = " + e.description);
	}
}

/**
 * 사용자 업무상태 저장
 */
//function fnSaveWorkStatus() 
//{
//	$.ajax({
//		type : "post",
//		dataType: "json",
//		async : true,
//		url : getContextPath() + "/ajax/main/insertWorkStatus.do",
//		data : "pJson=" + getJsonStrWorkStatusInsert(),
//		success : function(data)
//		{
//			console.log(data);
//		},
//		error : function(data, status, err) 
//		{
//			alert("업무상태 저장 실패!!");
//			//networkErrorHandler(data, status, err);
//		}
//	});
//}

/**
 * 2K SoftPhone에서 수신된 메시지를 처리한다.
 */

function fnGetEvent(data) {
	var jsonObj = JSON.parse(data);
	var command = jsonObj["CMD"]; 
	if(jsonObj["TEL_NO"]){
		gjtelno=jsonObj["TEL_NO"];
	}
	var resultCd = '';
	var callType = '';
	//var nowState = "";
	var textState = "";
	var prevStatus = currStatus;
	var prevEvent = g_prevEvent;
	var prevTelno = g_prevTelnum;
	g_prevTelnum=gjtelno;
	g_prevEvent=command; 
	
	console.log("event:"+JSON.stringify(jsonObj));
	
	var arState = new Array( "3", "3", "3", "3", "3", "3", "3", "3", "2", "2");
	
	switch(command) {
	case 'INITCTI':    // 초기화 및 로그인
		resultCd = jsonObj['RESULT_CD'];
		if ('0' == resultCd) {
			// CTI 연결 성공
			textState = "로그인";
			arState = new Array( "2", "2", "3", "3", "3", "3", "2", "2", "2", "2");
			//$("#mainTopCtiStatus").html("ON");
			bDialing = false;
			bReleased = true;
			bCalling = false;
			currStatus = LOGIN;
			
			fnProcButton("softphone_1"); //로그인 후 자동대기
			//fnSaveWorkStatus();
		}else{
			alert("CTI 로그인 실패! \n\n담당자에게 문의하세요.");
		    arState = new Array( "3", "3", "3", "3", "3", "3", "3", "3", "3", "2");
		}
		break;
	case 'DIAL':        // Dialing
		textState = "연결중";
		arState = new Array( "3", "3", "2", "2", "3", "3", "3", "3", "3", "3");
		RECKEY = "";
		g_connStat="DIAL";
		//gCallStartTime = jsonObj['EVT_TIME'];
		
//		if (!g_transFlag && !bCalling) {
//			gCallObj = new Object();
//			gCallObj.CallStartTime = jsonObj['EVT_TIME'];
//			gCallObj.CallGB = OUTBOUND;
//		}
		 
		//if(currStatus != CALLING){
		//	//협의콜시 인바운드 유지
		//	$("#selMainCallgbcd").val(OUTBOUND);
		//}
		var ticketId = $("#tfMainTicketId").val();
		
		// 협의콜인 경우에는 가져오지 않도록 수정필요
		//if (ticketId == '' || ticketId == null) {
			//fnLog("CMD [DIAL]");
		//	fnGetTicketId();
		//}
		
		break;
	case 'ESTABLISHED': // 통화연결됨
		bCalling = true;
		bDialing = true; //m20170705
		textState = "통화중";
		RECKEY = jsonObj['REC_KEY'];              // 녹취키(인바운드/아웃바운드)
		var estbTelno = jsonObj['TEL_NO'];           
		g_connStat="ESTABLISHED";
		
		gCallObj = new Object();
		gCallStartTime = gCallObj.CallStartTime;
//		console.log("Start gCallStartTime:"+gCallStartTime);
		if (gCallObj.CallGB == INBOUND) {
			//발신번호 제한 고객인 경우
			if(!estbTelno){
				estbTelno="99999999";
				prevTelno="99999999";
			}
			
			//내선 호전환인경우 RING전화번호 변경.
			if(prevTelno!=estbTelno){
				estbTelno=prevTelno;
			} 
		}
				
		gCallConnectTime = jsonObj['EVT_TIME'];
		arState = new Array( "3", "3", "2", "2", "2", "3", "3", "3", "2", "2");
		$("#tfRecId").val(RECKEY);
		//$.ajax({
		//	type : "post",
		//	async : false,
		//	url : "http://녹취서버/clientapi.php",
		//	data : "REC=REC1&DN=" + EXT + "&keycode=" + RECKEY + "&DATA1=01012345678&DATA2=8603141&DATA3=",
		//	error: function() {
		//		alert('error');
		//	}
		//});
		
		//내선 수신
		if(bInter==true){
			bInter=false;
			break;
		}
		 
		
		// 통화구분 고정 2017.08.08
		//$("#selMainCallgbcd").prop("disabled", true);
		
		currStatus = CALLING;
		
		var ticketId = $("#tfMainTicketId").val();
		
		if (ticketId == '' || ticketId == null) {
			//fnLog("fnGetTicketId [ESTABLISHED]");
			fnGetTicketId();
		}
		
		 
		var tmpTel=$("#CALLNO").val();
		if((estbTelno) && (tmpTel!=estbTelno)){
			$("#CALLNO").val(estbTelno);
		}
		
	 
		//setCustInfo(estbTelno, "DoNotEmpty");
		//fnSaveWorkStatus();
		//fnLog("fnSaveCnsl [ESTABLISHED]");
		//setTimeout(fnSaveCnsl, 1000);
		
//		flag_ck(g_agentId, $("#CALLNO").val(),gCallObj.CallGB); //감성솔루션 호출
 
		//fnGetWaitCount(g_getWaitCountTest);
		//$("#btnCnslInit").prop("disabled",true);//상담 초기화 비활성화
		
		
		break;
	case 'RELEASED':    // 통화끊김
		textState = "후처리중";
		bReleased = true;
		
		bDialing = false;
		AGENT_HANGUP = jsonObj['AGENT_HANGUP']; //상담사 Hang_up : "1"
		gCallReleaseTime = jsonObj['EVT_TIME'];
		console.log("RELEASED preTel:"+prevTelno+","+g_prevTelnum+" ,"+prevEvent);
		//전화끊어짐
		if((AGENT_HANGUP=="0" && prevEvent=="CONSULT") && prevTelno!="1997"){
			g_transFlag = false;
			if(g_prevTelnum==prevTelno) {
				fnConsultCancel("");
				$("#dialogMainConfirmPopup").dialog("close");
			}else{
				g_transFlag = true; //민원인이 전화를 끊으면 협의취소로 끊음
				$("#popupMessageConfirmPopup").hide();
				
				// 협의통화 연결시 버튼 비활성화
				$(":button:contains('협의전달'), :button:contains('3자통화')").prop("disabled", true).addClass( 'ui-state-disabled' );
				$("#labTransferDialog").html("상대방이 전화를 끊었습니다.");
			}
		}else if(prevEvent=="RINGING"){
			if ($("#dialogCallPopup").dialog("isOpen")) {
				// true
				$("#labInPopup").html("걸려온 전화가 끊겼습니다.");
				//$('#dialogCallPopup').dialog("close");
			} 
		}else{
		
			bCalling = false; //협의콜 중의 RELEASED는 무시
		}
		//gCallReleaseTime = new Date();
		arState = new Array( "2", "3", "3", "3", "3", "3", "2", "2", "2", "2");
		//$("#labCallNumStatus").html("");
		////fnSaveWorkStatus();
//		flag_ck("","",""); //감성솔루션 호출
		//$("#btnCnslInit").prop("disabled",false);//상담 초기화 활성화
	case 'CONSULTCANCEL':    // 통화끊김
		textState = "통화중"; 
		bCalling = true;
		bDialing = true;  
		if(prevEvent=="DIAL"){
			if(g_prevTelnum!=prevTelno) {
				$("#labTransferDialog").html("먼저온 전화가 끊겼습니다.");
			}
		}
		//gCallReleaseTime = new Date();
		arState = new Array( "3", "3", "2", "2", "2", "3", "3", "3", "2", "2");
		$("#labCallNumStatus").html($("#tfContactInform").val());
		////fnSaveWorkStatus();		
		break;
	case 'HELD':        // 보류
		textState = "보류";
		g_holdCount++;
		console.log(g_holdCount);
		arState = new Array( "3", "3", "3", "1", "2", "3", "3", "3", "2", "2");
		break;
	case 'UNHOLD':        // 보류해제 a20170705
		textState = "통화중";
		arState = new Array( "3", "3", "2", "2", "2", "3", "3", "3", "2", "2");
		break;			
	case 'READY':       // 대기 
		//대기를 위한 초기화 
		initInfo();
		g_readyFlag = false;
	
		//nowState = "Ready";
		
		//알카텔 전화으면 통화전(READY) 상태로 갔다가 후처리 상태됨.
		if(prevEvent=="RELEASED" || prevEvent=="TRANSFER" || prevEvent=="CONSULTCANCEL") { 
			break;
		}

		$("#tfMainTicketId").val("");   // 대기상태로 변경할 경우 TicketId 초기화
		textState = "대기";
		//currStatus = READY;
		currStatus = jsonObj['STATUS_CD'];
		g_connStat="READY";

		arState = new Array( "1", "2", "3", "3", "3", "3", "2", "2", "2", "2");
		//fnSaveWorkStatus();
		
		break;
	case 'NOTREADY':    // 이석
		
		//알카텔 전화으면 통화전(NOTREADY) 상태로 갔다가 후처리 상태됨.
		if(prevEvent=="RELEASED") { 
			break;
		}

		REASONCODE = jsonObj['REASON'];
		textState = arStateText[REASONCODE];
		// 업무
		if (REASONCODE == '7') {
			arState = new Array( "2", "2", "3", "3", "3", "3", "3", "2", "2", "2"); 
		} else {
			arState = new Array( "2", "2", "3", "3", "3", "3", "2", "1", "2", "2");
		}
		currStatus = jsonObj['STATUS_CD'];

		//fnSaveWorkStatus();
		
		fnGetWaitCount(g_getWaitCountTest);
		g_getWaitStatus="run";
		g_readyFlag = true; //대기버튼 바로동작
		break;
	case 'RINGING':     // 호인입
		arState = new Array( "3", "3", "3", "3", "3", "3", "3", "3", "2", "2");	
		var telNo ="";                                                  // 인입 전화번호
		var callGb = ""; // 콜구분
		var queueDn=jsonObj['QUEUE_DN']; // 큐
		var call_type =jsonObj['CALL_TYPE'];
		if(call_type=="3"){
			callType ="3";  //내선 인입
			telNo  = jsonObj['TEL_NO'];  //내선번호
		}else if(call_type=="4"){
			callType ="1";
			if(!jsonObj['MESSAGE']){
				telNo = "01000000000";
			}else{
				telNo = jsonObj['MESSAGE'];
				g_prevTelnum=telNo;
			}
			callGb   = "내선 호전환";
		}else{
			callType = jsonObj['CALL_TYPE'];// Call Type  1:인바운드 , 2:아웃바운드 , 4:내선 호전환인입
			telNo    = jsonObj['TEL_NO'];
			if(!telNo){
				//발신번호 제한 고객, 번호없으므로 '99999999'변환
				telNo="99999999";
			}
		}

		bCalling = true;
		bReleased = false;
		RECKEY = "";
		g_connStat="RINGING";
		currStatus = CALLING; 
		g_getWaitStatus="";
		gCallObj = new Object();
		
		if ($("#tfMainTicketId").val() != "") {
			 //fnLog("fnSaveCnsl [RINGING]");
		//	fnSaveCnsl('S');
		}
		
		
		var mildscNm="";
		var rspofcNm="";
		var deptNm="";
		var custNm="";
		var result="";
		
		if (callType == "1") {  // Inbound Call
			window.sessionStorage.setItem("setCustInfo", "false");
			textState = "전화옴"; 
			if(callGb == "내선 호전환"){
				textState = "내선전화 호전환"; 
			} 
 
			gCallObj.TelNo = telNo;
			gCallObj.CallGB = INBOUND;
			gCallObj.CallStartTime = jsonObj['EVT_TIME'];
			
			$("#CALLNO").val(telNo);
		 
			/**>>**************** 기존 및 신규 고객 처리 //신규고객 등록  2018.03.07 *******************/		
				 
			/**<<**************** 기존 및 신규 고객 처리 *******************/			

		} else if (callType == '2') { // Outbound Call
			textState = "연결중";
		} else if (callType == '3') { // Inner Call
			
			$("#CALLNO").val(telNo);

		} else if (callType == '4') { // Consult Call
			textState = "협의콜";
		} else if (callType == '5') { // Transfer Call
			textState = "호전환";
		} else if (callType == '6') { // Conference Call
			textState = "회의통화";
		}
		
		if(telNo!="99999999") {
		/**>>**************** 기존 및 신규 고객 처리 //신규고객 등록  2018.03.07 *******************/		
		var tempTelno = "";
		var tempCellno = "";
		if(telNo.substring(0,2)=="01"){
			//휴대폰
		   tempCellno=getPhoneNumFormat(telNo);
		}else{
		   tempTelno=getPhoneNumFormat(telNo);
		}	

                $("#tfDialogCustTelNo").html(getPhoneNumFormat(telNo));
                $("#btnDialogAnswer").focus();
                $("#dialogCallPopup").dialog("open");

				$.ajax({   
					url:"/operator/callUser.do",
					type:"post",
					dataType:'json',
					async : false,
					data:{"telno" :tempTelno, "mpno" :tempCellno},
					success:function(data) {
						if(!(data.map)){
				 			mildscNm="";
				 			rspofcNm="";
				 			deptNm="";
				 			custNm="미등록인";
				 			result="미등록 데이터";
				 			console.log("data Null!");
				 		}else{
				 			
						console.log(data);
						 
						mildscNm=data.map.mildscNm;
						rspofcNm=data.map.rspofcNm;
						deptNm=data.map.deptNm;
						custNm=data.map.nm;
						result="";
						
				 console.log("군:"+mildscNm+", 조직:"+rspofcNm+", dept:"+deptNm+", name:"+custNm+", telno:"+tempTelno);
				 		}
						
					},
					error : function(data, status, err){
						//alert("고객정보 가져오기 실패!! ["+telNo+"]");
						mildscNm="";
			 			rspofcNm="";
			 			deptNm="";
			 			custNm="";
			 			result="데이터 가져오기 오류";
			 			console.log("data error");
					}
				});
		/**<<**************** 기존 및 신규 고객 처리 *******************/			
		}else{
			mildscNm="";
 			rspofcNm="";
 			deptNm="";
 			custNm="발신번호표시제한인";
 			result="발신번호표시제한 ";
 			console.log("발신번호제한!");
		}
		
		//textState = "내선전화";
		bInter=true; 

		// 음성인식 반환 콜
		if(queueDn=="3004"){
			result+=" 음성인식 시도 ";
		} 

		//$("#tfDialogCustTelNo").html(getPhoneNumFormat(telNo));
		$("#tfDialogCustNm").html(custNm);
		$("#tfDialogDeptNm").html(deptNm);
		//$("#btnDialogAnswer").focus();
		//$("#dialogCallPopup").dialog("open");
		$("#labInPopup").html(result);
		
		//메인화면 셋팅
		$("#nm").val(custNm); 			//성명
		$("#tfTelno").val(telNo); 		//연락처
		$("#fullDeptNm").val(rspofcNm);	//조직 
		$("#deptNm").val(deptNm); 		//부서
		$("#mildsc").val(mildscNm); 	//군
		
		break;
	case 'DIALING': // Outbound
		arState = new Array( "3", "3", "2", "2", "3", "3", "3", "3", "3", "3");	
		callType = jsonObj['CALL_TYPE'];                                                // Call Type
		var telNo = jsonObj['TEL_NO'];                                                  // Dialing 전화번호
		g_connStat="DIALING";
//		if (g_Prefix) {
//			if (telNo > 4) {
//				if (telNo.indexOf(g_Prefix) == 0) {
//					telNo = telNo.substring(1);
//				}
//			}
//		}
		
		//TODO 인바운드후 호전환시 아웃바운도로 변경 되는현상 체크필요
		if (callType == '2') { // Outbound
			gCallObj = new Object();
			gCallObj.CallStartTime = jsonObj['EVT_TIME'];
			gCallObj.CallGB = OUTBOUND;
			gCallObj.TelNo = telNo;
			
			textState = "연결중";
			bDialing = true;
			bReleased = false;
			bCalling = false;
			
			 
			fnGetTicketId();
			$("#CALLNO").val(telNo);
			//$("#labCallNumStatus").html(getPhoneNumFormat(telNo));
			gCallStartTime = jsonObj['EVT_TIME'];
			//$("#tfContactInform").val(getPhoneNumFormat(telNo));
			//$("#selMainCallgbcd").val(OUTBOUND);			
			RECKEY = "";
			
			/**>>**************** 기존 및 신규 고객 처리 //신규고객 등록  2018.03.07 *******************/		
				 
			
			/**<<**************** 기존 및 신규 고객 처리 *******************/			
			
		}else{
			gCallObj = new Object();
			gCallObj.CallStartTime = jsonObj['EVT_TIME'];
			gCallObj.CallGB = OUTBOUND;
			gCallObj.TelNo = telNo;
			textState = "연결중";
		}

		break;
	case 'ACW': // 후처리
		textState = "후처리";
		arState = new Array( "2", "2", "3", "3", "3", "3", "2", "2", "2", "2");
		currStatus = jsonObj['STATUS_CD']; //ACW 
			if(prevEvent!="ACW"){
				//fnSaveWorkSta 
			}
			g_getWaitStatus="run";
			g_readyFlag = true; //대기버튼 바로 갈수 있게 
		break;
	case 'AFTERPROC':   // 상담이력 저장에 대한 응답
		break;
	case 'CONSULT':
		//대상 통화중이거나 연결 안됨
		g_transFlag = true;
		
 			// 협의통화 연결시 버튼 활성화
			$(":button:contains('협의전달'), :button:contains('3자통화')").prop("disabled", false).removeClass( 'ui-state-disabled' );
			textState = "협의통화";
			arState = new Array( "3", "3", "3", "3", "3", "3", "3", "3", "3", "3");
		 
		break;
	case 'IVRAUTH':
		if(prevEvent=="RELEASED"){
			//고객이 먼저 전화를 끊은 겨우
			break;
		} 
		 
		g_ArsAuthProcess=""; //초기화 
						
		break;		
	case 'CONFERENCE':
		textState = "3자통화";

		arState = new Array( "3", "3", "2", "3", "3", "3", "3", "3", "3", "3");
 
		var telNo = jsonObj['TEL_NO'];
		var extNo = jsonObj['EXT_NO'];
		RECKEY = jsonObj['REC_KEY'];
		
//			$.ajax({
//				type : "post",
//				async : true,
//				url : "http://"+g_RecSvrIP+":"+g_RecSvrPort+"/external/user",
//				data : "version=&call_id=" + RECKEY + "&cust_tel=&cust_no=&cust_name=&trans_tel="+ telNo +"&call_kind=" + gCallObj.CallGB + "&cust_etc1=&cust_etc2=&cust_etc3=&cust_etc4=&cust_etc5=&cust_etc6=&cust_etc7=&cust_etc8=",
//				error: function() {
//					alert('Consult Error');
//				}
//			});
			
			RECKEY="";
		 
		break;
	case 'TRANSFER':
		//내선 착신시 'TRANSFER' pass
		if(prevEvent=="ESTABLISHED"){ 
			arState = new Array( "3", "3", "2", "2", "2", "3", "3", "3", "2", "2");
			break;
		}
		
		RECKEY = jsonObj['REC_KEY'];              // 녹취키(인바운드/아웃바운드)
		$("#tfRecId").val(RECKEY);
		
		var telNo = jsonObj['TEL_NO'];
		var extNo = jsonObj['EXT_NO']; 
		gCallReleaseTime = jsonObj['EVT_TIME'];
//			$.ajax({
//				type : "post",
//				async : true,
//				url : "http://"+g_RecSvrIP+":"+g_RecSvrPort+"/external/user",
//				data : "version=&call_id=" + RECKEY + "&cust_tel=&cust_no=&cust_name=&trans_tel="+ telNo +"&call_kind=" + gCallObj.CallGB + "&cust_etc1=&cust_etc2=&cust_etc3=&cust_etc4=&cust_etc5=&cust_etc6=&cust_etc7=&cust_etc8=",
//				error: function() {
//					alert('Consult Error');
//				}
//			});
//			
//			RECKEY="";
		
		break;
	case 'LOGOUT':      // 로그아웃 
		arState = new Array( "3", "3", "3", "3", "3", "3", "3", "3", "2", "2");
		textState="로그아웃";
		currStatus = jsonObj['STATUS_CD'];
		//$("#mainTopCtiStatus").html("OFF");
		//fnSaveWorkStatus();
		break;
	default:
		alert("CTI와 연결이 끊겼습니다. 재로그인 하세요.");
	    break;	
	}
	 
	// 현재 상태 셋팅 및 상태유지 시간 초기화
	$("#MainStatusNm").html("["+textState+"]"); 
	g_statusStrtTime = new Date();
	
	OnButtonProc(arBtn, arState);
}

// 버튼 상태 제어 메소드
function OnButtonProc(arButton, arState)
{
	var preImg=new Array();
	
	$("#readyText").html("대기");
	
	try
	{
		for(var i = 0; i < arState.length; i++ )
		{
			switch(arState[i])
			{
				case "1" : // display ( using img )
					var tmpBgNm="_red";
					if(i==0){
						$("#readyText").html("대기중");
					}
				        if(i==3){
						tmpBgNm="";
					}	
					$("#"+ arButton[i]).css('background-image',"url(/images/operator/but_bg_click"+tmpBgNm+".png)");
					$("#"+ arButton[i]).css('cursor','pointer');
					var $softPhoneImg = $("#" + arButton[i]);
				//	console.log("phonImg:"+ arButton[i]);
					// mouseover event
					$softPhoneImg.mouseover(function(e)
					{
						var $btnImg = $("#" + (this.id)); 
						$btnImg.css('background-image',"url(/images/operator/but_bg_click"+tmpBgNm+".png)");
					});
					
					// mouseout event
					$softPhoneImg.mouseout(function(e)
					{
						var $btnImg = $("#" + (this.id)); 
						$btnImg.css('background-image',"url(/images/operator/but_bg_click"+tmpBgNm+".png)");
					});
				
					// mousedown event
					$softPhoneImg.mousedown(function(e)
					{
						var $btnImg = $("#" + (this.id)); 
						$btnImg.css('background-image',"url(/images/operator/but_bg.png)");
					});
					
					// mouseup event
					$softPhoneImg.mouseup(function(e)
					{
						var $btnImg = $("#" + (this.id)); 
						$btnImg.css('background-image',"url(/images/operator/but_bg_click"+tmpBgNm+".png)");
					});
					
					break;
				case "2" : // dispay ( state img )
				{
					// 이미지 셋팅 및 클릭 이벤트 삽입
					$("#"+ arButton[i]).css('background-image',"url(/images/operator/but_bg.png)");
					$("#"+ arButton[i]).css('cursor','pointer');
 
					var $softPhoneImg = $("#" + arButton[i]);
			//		console.log("phonImg:"+ arButton[i]);
					// mouseover event
					$softPhoneImg.mouseover(function(e)
					{
						var $btnImg = $("#" + (this.id)); 
						$btnImg.css('background-image',"url(/images/operator/but_bg_on.png)");
					});
					
					// mouseout event
					$softPhoneImg.mouseout(function(e)
					{
						var $btnImg = $("#" + (this.id)); 
						$btnImg.css('background-image',"url(/images/operator/but_bg.png)");
					});
				
					// mousedown event
					$softPhoneImg.mousedown(function(e)
					{
						var $btnImg = $("#" + (this.id)); 
						$btnImg.css('background-image',"url(/images/operator/but_bg_click.png)");
					});
					
					// mouseup event
					$softPhoneImg.mouseup(function(e)
					{
						var $btnImg = $("#" + (this.id)); 
						$btnImg.css('background-image',"url(/images/operator/but_bg_on.png)");
					});
					
					break;
				}
				case "3" : // display ( disable img )
					$("#"+ arButton[i]).css('background-image',"url(/images/operator/but_bg_off.png)"); 
					$("#"+ arButton[i]).css('cursor','Default');
					var $softPhoneImg = $("#" + arButton[i]);
					// mouseover event
					$softPhoneImg.mouseover(function(e)
					{
						var $btnImg = $("#" + (this.id)); 
						$btnImg.css('background-image',"url(/images/operator/but_bg_off.png)");
					});
					
					// mouseout event
					$softPhoneImg.mouseout(function(e)
					{
						var $btnImg = $("#" + (this.id)); 
						$btnImg.css('background-image',"url(/images/operator/but_bg_off.png)");
					});
				
					// mousedown event
					$softPhoneImg.mousedown(function(e)
					{
						var $btnImg = $("#" + (this.id)); 
						$btnImg.css('background-image',"url(/images/operator/but_bg_off.png)");
					});
					
					// mouseup event
					$softPhoneImg.mouseup(function(e)
					{
						var $btnImg = $("#" + (this.id)); 
						$btnImg.css('background-image',"url(/images/operator/but_bg_off.png)");
					});
					break;
				case "4" : // none display
					//eval("document.getElementById( '"+ arButton[i] + "' ).innerHTML = '<img src=\"" + getContextPath() + "/images/operator/" + arButton[i] + "_off.png\" draggable=\"false\">';");
					//eval("document.getElementById( '"+ arButton[i] + "' ).style.display = 'none';");
					$("#"+ arButton[i]).attr("src",getContextPath() + "/images/operator/but_bg_off.png");
					break;
			}
		}
	}
	catch ( e )
	{
		alert("error = " + e.description);
	}
}

//버튼 클릭 시 실행 메소드
function fnProcButton(szButton)
{
	try
	{
		
		switch(szButton)
		{
			case "softphone_1" :		// 대기
			{
				  
				if(g_readyFlag)
				{
					g_readyFlag = false;
					fnAgentReady();
					
					//todo	대기를 위한 초기화 
					//initInfo();
				}
				else
				{ 
					g_readyFlag = true;
					fnAgentNotReady("7"); 
				}
				break;
				
			}
			case "softphone_2" :		// 걸기
			{
				writeLogFile("on Button Click [MAKECALL]");
				
				modalPhone();  // 빠른 전화 걸기 
				
				break;
			}
			case "softphone_3" :		// 끊기 x
			{//보류
				 writeLogFile("on Button Click [DROPCALL]");
				if(g_transFlag)
				{
					//CT_TRANSFERCANCEL();
					fnConsultCancel("");
					writeLogFile("Request [CT_TRANSFERCANCEL]");
					
					var arState = new Array( "2", "3", "3", "3", "3", "3", "3", "2", "2", "2");
					OnButtonProc(arBtn, arState);
					 
					$("#MainStatusNm").html("[후처리중]");
					
					g_transFlag = false;
				}
				else
				{
					//CT_DROPCALL($("#EXT").val());
					fnHangup();
					writeLogFile("Request [CT_DROPCALL]");
				}
				break;
				
			}
			case "softphone_4" :		// 보류 x
			{//협의
				
				writeLogFile("on Button Click [DROPCALL]");
				
				if(g_holdFlag)
				{
				//	alert(g_holdFlag + " : unhold");
					console.log("unhold");
					//CT_UNHOLDCALL($("#EXT").val());
					fnUnHold();
					writeLogFile("Request [CT_UNHOLDCALL]");
					g_holdFlag = false;
				}
				else
				{
					console.log("hold");
					//CT_HOLDCALL($("#EXT").val());
					fnHold();
					writeLogFile("Request [CT_HOLDCALL]");
					g_holdFlag = true;
				}
				
				break;
				
			}
			case "softphone_5" :		// 협의 x
			{
				modalPhone();  // 빠른 전화 걸기 
				
				writeLogFile("on Button Click [TRANSFERINIT]");
			  
				break;
				
			}
			case "softphone_6" :		// 3자통화
			{
				break;
			}
			case "softphone_7" :		// 업무
			{
				
				break;
			}
			case "softphone_8" :		// 이석 x
			{//끊기
				
				fnAgentNotReady("8");
				
				break;
				
			}
			case "softphone_9" :		// 재접속
			{
				writeLogFile("on Button Click [RECONNECT]");
				if(ws){
					ws.close();
					//웹소캣 재접속 
					ctiInit();
				}else{
					//웹소캣 재접속 
					ctiInit();
				}
			
				break;
			}
			case "softphone_10" :	// 로그아웃
			{
				writeLogFile("on Button Click [LOG OUT]");
				 
				fnLogout();
				break;
			}
			 
			default :
				break;
		}
	}
	catch(e)
	{
		
		alert("ws_cont fnProcButton Error : " + e.message);
		/*
		CT_CONNECTSERVER();
		writeLogFile("Request [CT_CONNECTSERVER(exception)]");
		*/
		
		//ctiConnError();
	}
}

// 로컬 파일에 로그 쓰기
function writeLogFile(text)
{
	//fnLog(text);
	/*
	// 기본 경로 및 파일시스템 객체 생성
	var logpath = "C:\\twokcommlog";
	var fileObj = new ActiveXObject("Scripting.FileSystemObject");
	
	// 오늘 날짜 계산
	var today = new Date();
    var yearNow = String(today.getFullYear());
    var monthNow = fnLPAD(String((today.getMonth() + 1)), "0", 2);
    var dateNow = fnLPAD(String(today.getDate()), "0", 2);
    var dateStr = yearNow + monthNow + dateNow;

    // 로그 내용에 날짜, 시간 추가
	var result = "[" + yearNow + "-" + monthNow + "-" + dateNow + " " + 
	                      fnLPAD(String(today.getHours()), "0", 2) + ":" + fnLPAD(String(today.getMinutes()), "0", 2) + ":" + fnLPAD(String(today.getSeconds()), "0", 2) + "]_" + text;
	                      
    // 클라이언트 IP 주소 가져오기
    var ip = window.sessionStorage.getItem("IP_ADDRESS");
    
    if(ip == null || ip.length < 1 || ip == "0:0:0:0:0:0:0:1")
    	ip = "127.0.0.1";
    
    // 파일 이름 및 전체경로 생성
    var fileName = "twokcomm_[" + dateStr + "]_[" + ip + "].txt";
	var fullPath = logpath + "\\" + fileName;
	
	// 만약 기본 경로의 폴더가 존재하지 않는다면 생성
	if(!fileObj.FolderExists(logpath))
		fileObj.CreateFolder(logpath);
	
	if(!fileObj.FileExists(fullPath))
	{
		// 파일이 존재하지 않는다면 파일 생성
		var fwrite = fileObj.CreateTextFile(fullPath, true);
		fwrite.writeLine(result);
		fwrite.close();
	}
	else
	{
		// 파일이 존재한다면 파일을 열어 마지막에 쓰기
		var fwrite = fileObj.OpenTextFile(fullPath, 8, true);
		fwrite.writeLine(result);
		fwrite.close();
	}
	*/
}
 
