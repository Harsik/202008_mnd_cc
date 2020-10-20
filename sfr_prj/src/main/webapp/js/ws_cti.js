/**
 * SoftPhone Control 
 * 통신방식 : WebSocket
 *  
 */

// 웹소켓 오브젝트
var ws;

var gCTIInfoObj = new Object();
gCTIInfoObj.IP1 = "192.168.1.71";
gCTIInfoObj.IP2 = "192.168.1.72";
gCTIInfoObj.IP3 = "";
gCTIInfoObj.PORT1 = "9707";
gCTIInfoObj.PORT2 = "9707";
gCTIInfoObj.PORT3 = "";

var g_Prefix = "";                            // 내외선 구분
var g_AreaCode = "";                        // 센터지역 전화번호
var g_CallerId = "";                           // 발신자표시번호(발신자표시번호가 여러개인 경우 사용하며 CTI 미들웨어에서 지원이 되어야 한다.)
var g_TeamQue ="";								// 상담사 큐

/**
 * WebSocket을 통해 데몬에 Command전송
 */
function sendCmd(jsonObj){
	try {
		var finalJsonData = JSON.stringify(jsonObj);                   // Object 객체에서 Json형태로 데이터 생성
		console.log("send:"+finalJsonData);
		ws.send(finalJsonData);                                        // WebSocket을 통해 데이터 전송                                        
	} catch(e) {
		alert('cause : ' + e.description + ', ' + e.name);
	}
}

/**
 * CTI Initialize 및 CTI Login  
 */
function fnInitCTI() {
	var jsonObj = new Object();
	jsonObj.CMD = "INITCTI";                                              // CTI 초기화 및 로그인 Command
	jsonObj.CTI_SERVER_IP1 = gCTIInfoObj.IP1;                             // CTI Primary Server IP
	jsonObj.CTI_SERVER_PORT1 = gCTIInfoObj.PORT1;                         // CTI Primary Server Port
	jsonObj.CTI_SERVER_IP2 = gCTIInfoObj.IP2;                             // CTI Secondary Server IP
	jsonObj.CTI_SERVER_PORT2 = gCTIInfoObj.PORT2;                         // CTI Secondary Server Port
	jsonObj.CTI_SERVER_IP3 = gCTIInfoObj.IP3;                             // CTI Third Server IP - Not Used
	jsonObj.CTI_SERVER_PORT3 = gCTIInfoObj.PORT3;                         // CTI Third Server Port - Not Used
	jsonObj.CTI_USER_ID = $("#CTIID").val();     // CTI Login Id
	jsonObj.CTI_PASSWORD = "";                                            // CTI Login Password - Not Used
	jsonObj.USER_NAME = $("#CTIID").val();                             // User Name
	jsonObj.EXT_NO = $("#EXTNO").val();                                     // Extension No
	// Record Server Information - Not Used
	jsonObj.REC_SERVER_IP1 = "";
	jsonObj.REC_SERVER_PORT1 = "";
	jsonObj.REC_SERVER_IP2 = "";
	jsonObj.REC_SERVER_PORT2 = "";
	jsonObj.REC_SERVER_IP3 = "";
	jsonObj.REC_SERVER_PORT3 = "";
	///////////////////////////////////////
	jsonObj.EMP_NO = $("#CTIID").val();                                   // Employee No
	jsonObj.USER_ID = window.sessionStorage.getItem("USERID");            // Application Login ID
	
//	alert('Websocket Opened!! CTI ID:'+window.sessionStorage.getItem("CTI_LGN_ID"));
	sendCmd(jsonObj);                                                     // Request Send
}

/**
 * CTI 로그아웃
 */
function fnLogoutCTI() {
	var jsonObj = new Object();
	jsonObj.CMD = "LOGOUT";                                               // CTI Logout Command
	
	sendCmd(jsonObj);                                                     // Request Send
}

/**
 * 전화걸기
 * 
 * @param dialNumber
 * @param custId
 * @param custNo
 * @param custName
 */
function fnMakeCall(dialNumber, custId, custNo, custName) {
	var jsonObj = new Object();
	
	jsonObj.CMD = "DIAL";                                                // CTI MakeCall Command
	jsonObj.CTI_USER_ID = $("#USERID").val();                            // CTI Login ID
	jsonObj.USER_NAME = $("#USERNAME").val();                            // User Name
	jsonObj.CTI_PASSWORD = "";                                           // CTI Login Password - Not Used
	jsonObj.EMP_NO = $("#EMPNO").val();                                  // Employee No
	jsonObj.CUST_TEL_NO = dialNumber;                                    // 고객전화번호
	jsonObj.CUST_ID = custId;                                            // 고객식별자
	jsonObj.CUST_NAME = custName;                                        // 고객명
	jsonObj.CUST_NO = custNo;                                            // 고객번호
	jsonObj.TEL_PREFIX = g_Prefix;                                       // 내외선 구분
	jsonObj.AREA_CODE = g_AreaCode;                                      // 센터 지역번호
	jsonObj.CAMP_NAME = "";                                              // 캠페인명
	jsonObj.CAMP_NO = "";                                                // 캠페인번호
	jsonObj.CALL_GB = "";                                                // 통화구분 - Not Used
	jsonObj.CALLER_ID = g_CallerId;                                      // 발신자 표시 번호
	jsonObj.CALL_ID = "";                                                // Call Id
	
	sendCmd(jsonObj);                                                    // Request Send
}

/**
 * 전화받기
 */
function fnAnswer() {
	var jsonObj = new Object();
	
	jsonObj.CMD = "ANSWER";
	
	sendCmd(jsonObj);
}

/**
 * 전화끊기
 * 
 * @param dialNumber
 */
function fnHangup(dialNumber) {
	var jsonObj = new Object();
	
	jsonObj.CMD = "HANGUP";                                               // CTI HangUp Command
	jsonObj.USER_ID = window.sessionStorage.getItem("USERID");            // Application Login ID
	jsonObj.CTI_PASSWORD = "";                                            // CTI Login Password - Not Used
	jsonObj.USER_NAME = $("#USERNAME").val();                             // User Name
	jsonObj.EMP_NO = $("#EMPNO").val();                                   // Employee No
	jsonObj.CUST_TEL_NO = dialNumber;                                     // 고겍전화번호
	jsonObj.CUST_ID = "";                                                 // 고객식별자
	jsonObj.CUST_NAME = "";                                               // 고객명
	jsonObj.CUST_NO = "";                                                 // 고객번호
	jsonObj.EXT_NO = $("#EXTNO").val();                                     // Extension No
	jsonObj.MEMO = "";                                      // 메모
	jsonObj.CALL_GB = "";                                                 // 통화처 구분
	
	sendCmd(jsonObj);                                                     // Request Send
}

/**
 * 상담사 대기
 * 
 * 인바운드 업무를 위해 상담사를 대기상태로 변경한다.
 */
function fnAgentReady() {
	var jsonObj = new Object();
	
	jsonObj.CMD = "READY";                                                // CTI Ready Command
	
	sendCmd(jsonObj);                                                     // Request Send
}

/**
 * 상담사 이석
 * 
 * @param reasonCd 사유코드
 */
function fnAgentNotReady(reasonCd) {
	var jsonObj = new Object();
	
	jsonObj.CMD = "NOTREADY";                                             // CTI NotReady Command
	jsonObj.REASON = reasonCd;                                            // NotReady Reason Code;
	
	sendCmd(jsonObj);                                                     // Request Send
}

/**
 * 보류
 * 
 * 현재콜에 대한 보류처리
 */
function fnHold() {
	if (bDialing == true) {
		var jsonObj = new Object();
		
		jsonObj.CMD = "HOLD";                                              // CTI Hold Command
		
		sendCmd(jsonObj);                                                  // Request Send
	} else {
		alert("통화중에만 사용가능합니다.");
	}
}

/**
 * 보류해제
 * 
 * 현재콜에 대한 보류상태를 해제한다.
 */
function fnUnHold() {
	var jsonObj = new Object();
	
	jsonObj.CMD = "UNHOLD";                                               // CTI UnHold Command
	
	sendCmd(jsonObj);                                                     // Request Send
}

/**
 * 협의콜
 * 
 * @param consultType
 * @param dialNumber
 * @param custNo
 */
function fnConsult(consultType, dialNumber, custNo, contents) {
	var jsonObj = new Object();
	
	jsonObj.CMD = "CONSULT";                                               // CTI Consult Command
	jsonObj.CONSULT_TYPE = consultType;                                    // Consult Type
	jsonObj.TEL_NO = dialNumber;                                           // 전화번호
	jsonObj.CUST_NO = custNo;                                              // 고객번호
	jsonObj.CONTENTS = contents;                                       // 내용
	if(consultType=="CONSULT"){
		jsonObj.RELAYNUM = contents;										// 고객 전화번호 전달용
	}else {
		jsonObj.RELAYNUM = "";										// ARS 인증용
	}
	sendCmd(jsonObj);                                                      // Request Send
}

/**
 * 협의콜 취소
 * 
 * @param consultType
 */
function fnConsultCancel(consultType) {
	var jsonObj = new Object();
	
	jsonObj.CMD = "CONSULT_CANCEL";                                        // CTI Consult Cancel Command
	jsonObj.CONSULT_TYPE = consultType;                                    // CTI Consult Type
	
	sendCmd(jsonObj);                                                      // Request Send
}

/**
 * 호전환
 * 
 * 협읰톨 이후에 호줄되어야 한다.
 */
function fnTransfer() {
	var jsonObj = new Object();
	
	jsonObj.CMD = "TRANSFER";                                              // CTI Transfer Command
	
	sendCmd(jsonObj);                                                      // Request Send
}

/**
 * 3자통화/회의통화
 * 
 * 협의콜이후에 호출되어야 한다.
 */
function fnConference() {
	var jsonObj = new Object();
	
	jsonObj.CMD = "CONFERENCE";                                            // CTI Conference Command
	
	sendCmd(jsonObj);                                                      // Request Send
}

/**
 * Single Step 호전환
 * 
 * @param dialNumber   전화번호
 * @param custNo       고객번호
 * @param contents     내용
 */
function fnSingleStepTransfer(dialNumber, custNo, contents) {
	var jsonObj = new Object();
	
	jsonObj.CMD = "SINGLE_STEP_TRANSFER";                                  // CTI Single Step Transfer Command
	jsonObj.TEL_NO = dialNumber;                                           // 전화번호
	jsonObj.CUST_NO = custNo;                                              // 고객번호
	jsonObj.CONTENTS = contents;                                           // 내용
	
	sendCmd(jsonObj);                                                      // Request Send
}
 
/**
 * 후처리완료(상담저장시 호출) 
 * 
 * @param custNo       고객번호
 * @param custName     고객명
 * @param custId       고객식별번호
 * @param counselCd    상담유형
 * @param counselName  상담유형명
 */
function fnAfterCallWork(custNo, custName, custId, counselCd, counselName) {
	var jsonObj = new Object();
	
	jsonObj.CMD = "AFTERPROC";                                             // CTI AfterCallWork Command
	jsonObj.REC_KEY = "";                                                  // 녹취키
	jsonObj.USER_ID = window.sessionStorage.getItem("USERID");             // Application Login ID
	jsonObj.USER_NAME = $("#USERNAME").val();                              // User Name
	jsonObj.CUST_NO = custNo;                                              // 고객번호
	jsonObj.CUST_NAME = custName;                                          // 고객명
	jsonObj.CUST_ID = custId;                                              // 고객식별자
	jsonObj.CNSL_CD = counselCd;                                           // 상담유형코드
	jsonObj.CNSL_NAME = counselName;                                       // 상담유형명
	
	sendCmd(jsonObj);
}

/**
 * 대기고객수 
 */
function fnGetWaitCount(test_gubun) {
	var teamQueue = $("#hidTeamQueue").val();

//	if(teamQueue !=""){
//		var jsonObj = new Object();
//		
//		jsonObj.CMD = "GETWAITCOUNT";                                                   // Log 기록 Command
//		jsonObj.QUEUE01 = "26672";                                        // 한국어
//		jsonObj.QUEUE02 = teamQueue;                                        // 팀큐
//		jsonObj.TESTING = test_gubun;                                        // 테스트 구분 "TEST"
//		
//		sendCmd(jsonObj);                                                      // Request Send
//	}
}

/**
 * 프로그램실행 
 */
function fnProcStart(filename,job) {
	 
		var jsonObj = new Object();
		
		jsonObj.CMD = "PROCSTART";                  // 프로그램 실행명령
		jsonObj.FILENAME =filename;                 // 실행 파일명
		jsonObj.JOBGB =job==""?"E":job;                 // 실행 파일명
		
		sendCmd(jsonObj);                                                      // Request Send
	 
}

function fnLog(logContents) {
	var jsonObj = new Object();
	
	jsonObj.CMD = "LOG";                                                   // Log 기록 Command
	jsonObj.CONTENTS = logContents;                                        // 로그 내용
	
	sendCmd(jsonObj);                                                      // Request Send
}

/**
 * 상담이력 Ticket ID 가져오기
 */
function fnGetTicketId() {
	g_holdCount=0; // 보류 누적횟수 초기화
	var getDateTime=yyyyMMddhhmmss("");
	var userId=window.sessionStorage.getItem("USERID");
	var ticketid=getDateTime+userId;
console.log("fnGetTicketId:"+ticketid);	 
	return 0; 
}

// yyyymmdd 형태리턴
function yyyyMMddhhmmss(job) {
	var date = new Date();
	var rtnDate="";
   var yyyy = date.getFullYear();
   var mm = (date.getMonth()+1)<10?"0"+""+(date.getMonth()+1):(date.getMonth()+1); // getMonth() is zero-based
   var dd  = date.getDate()<10?"0"+""+date.getDate():date.getDate();
	var hh = date.getHours()<10?"0"+""+date.getHours():date.getHours();
	var mi = date.getMinutes()<10?"0"+""+date.getMinutes():date.getMinutes();
	var ss = date.getSeconds()<10?"0"+""+date.getSeconds():date.getSeconds();
	rtnDate=yyyy+""+mm+""+dd+""+hh+""+mi+""+ss;
   return rtnDate;
}
 
// 전화번호 형태로 변환
function getPhoneNumFormat(p_num)
{
 
	if(p_num == null || p_num == "")
		return "";
	
	if(p_num.length == 7){
		return p_num.substr(0, 3) + "-" + p_num.substr(3, 7);
	}else if(p_num.length == 8){
		return p_num.substr(0, 4) + "-" + p_num.substr(4, 8);
	}else{
		return p_num.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/, "$1-$2-$3");
	}
}

function fnRecSend(connid, data1, data2) {
	$.ajax({
		
	});
	
}