//화면 초기화
function initView(){
	$("#MainStatusNm").html("준비");
	// 	$("#btnMdalTransfer").hide();
}


 //페이지 초기화
$(document).ready(function()
{
	//CTI connect,openserver,login
	ctiInit();
	
	//빠른전화걸기 모달창
	teleModalCondition();
	
	//화면 초기화
	initView();
	
// 	$(function(){
//		setLogoutTimer();
//	}); 
	
	setNotLogoutTimer();
	
	setTime();
	
			var arState = new Array( "3", "3", "3", "3", "3", "3", "3", "3", "2", "2");
			OnButtonProc(arBtn, arState);
			
			//arState = new Array( "2", "2", "2", "2", "2", "2", "2", "1");
		//	OnButtonProc(arBtnR, arState);
			
		
		//모달 x버튼 팝업닫기 
		$("#modalClose").bind("click", function(e)
		{
			$("#dialogCallPopup").dialog("close");
	  });
 
		// 전화받기 팝업 전화받기 버튼 이벤트
		$("#btnDialogAnswer").bind("click", function(e)
		{
			//fnLog("Request [fnAnswer]");
			fnAnswer();
			$("#dialogCallPopup").dialog("close");
		});

		//전화기 버튼 이벤트
		$("#softphone_1, #softphone_2, #softphone_3, #softphone_4, #softphone_5, #softphone_6, #softphone_7, #softphone_8, #softphone_9, #softphone_10").bind("click", function(e)
		{
			//$("#"+this.id).attr("src",getContextPath() + "/images/operator/but_bg_off.png"); 
			var bgImg =$("#"+this.id).css('background-image');
			var arrPath=bgImg.split("/");
				
			var imgNm = arrPath[arrPath.length-1];
	//		console.log(this.id+":"+imgNm);
				if(imgNm.match("but_bg_off.png") != "but_bg_off.png"){
					fnProcButton(this.id);
				}
		});		
	


  	// 호전환 클릭 이벤트
	$("#btnTransfer").bind("click", function(e)
	{
			if(bCalling)
			{
				 	var outTelno=$("#outTelno").val(); //화면 
					var pureNum=phoneNumber(outTelno); //입력 값  
			
					if(pureNum=="" && pureNum.length<4){
						alert("전화번호를 정확하게 입력해 주세요.");
						$("#outTelno").focus();
						return;
					}
					
					//현재 연결된 전화번호 체크
					if(!curCallCheck(pureNum)){
						return;
					}
					
					var sStat=$("#MainStatusNm").html();
							
					if(sStat=="[보류]"||sStat=="[통화중]"){
						 window.sessionStorage.setItem("callType","transfer"); // onestep Transfer
				 		makeCall(pureNum);
					}
					else
					{
						alert("통화중에만 호전환이 가능합니다.");
					}
			}
			else
			{
				alert("통화중에만 호전환이 가능합니다.");
			}
	});
  	
  	
 	// 협의연결 클릭 이벤트
	$("#btnConsult").bind("click", function(e)
	{
		var outTelno=$("#outTelno").val(); //화면 
		var pureNum=phoneNumber(outTelno); //입력 값  
		
		if(pureNum=="" && pureNum.length<4){
			alert("전화번호를 정확하게 입력해 주세요.");
			$("#outTelno").focus();
			return;
		}

		//현재 연결된 전화번호 체크
		if(!curCallCheck(pureNum)){
			return;
		}
					
		makeCall(pureNum);
	});	 
		
	// 팝업 다이얼로그 설정
	$("#dialogMainConfirmPopup").dialog({
		autoOpen: false,
		resizable: false,
		position: {my: "left+600 top+100", at: "left+30 top+30", of: document},
		width: 360, 
		buttons: [
			{
				text: "협의전달",
				click: function()
				{
					 
					fnTransfer();
					g_transFlag = false;
					
					$(this).dialog("close");
				}
			},
			{
				text: "3자통화", 
				click: function()
				{
					fnConference();
					g_transFlag = false;
					
					$(this).dialog("close");
				}
			},
			{
				text: "협의취소",
				click: function()
				{
					$("#popupMessageConfirmPopup").show();
					$("#labTransferDialog").html("");
				 
					if(g_transFlag){
							if(g_holdFlag== true){
								fnUnHold();
								g_holdFlag = false;
							}
						fnConsultCancel(""); 
					}else{
						fnHangup();
					}
					
					g_transFlag = false;
					
					/*
					// 만약 취소 했다면 0.2초 후 언홀드
					setTimeout(function(){
						CT_UNHOLDCALL($("#EXT").val());
						g_holdFlag = false;
					}, 200);
					*/
					$(this).dialog("close");
				}
			} 
		]
	});
	
		// 일반전화용 인입 팝업 다이얼로그 설정
		$("#dialogCallPopup").dialog({
			autoOpen: false,
		    resizable: false, 
		    width: 500,
		    modal: true,
		    draggable: true,
		    closeOnEscape: false,
		    open: function(event, ui)
		    {
		    	$(".ui-dialog-titlebar", ui.dialog | ui).hide();
		    	$(".ui-dialog-titlebar-close", ui.dialog | ui).hide();
		    	$("#btnDialogAnswer").focus();
	    	}
		});
		
		//console.log("ready load!!");					

	// x버튼으로 창닫을 때 이벤트 등록
		$(window).bind("beforeunload", unloadPage);
	
	//빠른 전화걸기 창	
		//	modalPhone();
});
// ready

function setNotLogoutTimer(urlName){
	setInterval(function(){goNotLogout(urlName)},600000); 
}

function goNotLogout(urlName) { 
 
	$.ajax({   
		url:"/operator/operatorPopup.do",
		dataType:'json',
		async:true,
		data:{"seq":"0"},
		success:function(data) {
			 console.log(data);
		} 
		
	});
}

/* 고객정보 초기화 
 */
function initInfo()
{
		//메인화면 초기화
		$("#nm").val(""); 			//성명
		$("#tfTelno").val(""); 		//연락처
		$("#fullDeptNm").val("");	//조직 
		$("#deptNm").val(""); 		//부서
		$("#mildsc").val(""); 	//군
	 
		//outbound
		$("#outNm").val(""); 			//성명
		$("#outTelno").val(""); 		//연락처
		$("#outFullDeptNm").val("");	//조직 
		$("#outDeptNm").val(""); 		//부서
		$("#outMildsc").val(""); 	//군
		
		$("#CALLNO").val("");  //연결된 콜번호
}

//setTime	
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
	    	   
		        sec = '00:00:'+ checkTime(sec) + '초';
	    	   
	      } else if (sec < 3600) {
		        sec = '00:'+checkTime(Math.floor((sec % 3600) / 60))+ ':' + checkTime(sec % 60) + '초';
	      } else {
	        sec = Math.floor(sec / 3600) + '시간 ' + checkTime(Math.floor((sec % 3600) / 60)) +  '분 ' +  checkTime(sec % 60) + '초';
	      }

	      curSecond++;
	      localStorage.setItem('second', curSecond);
	      $('#time').text(sec);
	    }, 1000);
	  }
//setTime --	  

  function checkTime(i) {
    if (i < 10) {i = "0" + i}; // 숫자가 10보다 작을 경우 앞에 0을 붙여줌
    return i;
  }

	function logout(){
		location.href = "/operator/logout.do";
		localStorage.clear();
	};
	
	//공지사항 팝업
	function popup_notice(){ //경로, 가로, 세로, 아이디
		gfn_popup("/operator/noticepopup.do", "700", "460", "noticepopup");
	};

	//상담이력
	function popup_operator(){ //경로, 가로, 세로, 아이디
		gfn_popup("/operator/operatorPopup.do", "700", "460", "noticepopup");
	};

	function popup_call(){ //경로, 가로, 세로, 아이디
		gfn_popup("/operator/ctiCallPoup.do", "600", "400", "callPopup");
	};
	

//전화걸기 창 
	function modalPhone(){
	
		// 좌표 새로 설정
		$("#modalLayer").css({
		   "top" : "72px",
		   "left" : "466px"
		});
	
		if($(".modalContent").css("display") == "none"){
		  	$(".modalContent").show();
		  	$("#popupCollapse").attr("src","/images/operator/sel_dub_arrow2.png");
		}  
		
		$("#modalLayer").fadeIn("slow");
	    $("#modalCallNum").focus(); 

    return;
}	


/**
 * 전화걸기 함수
 * (상황에 따른 callType 셋팅 필요)
 * 
 * @param p_phoneNum
 */
function makeCall(p_phoneNum)
{

	var argumVal="";
	var plength = arguments.length;
	var calltype="";
	var phonNum=p_phoneNum;

	if(!phonNum){
		alert("전화번호를 입력해 주세요.");
		return;
	}
	
	if(plength == 2){
		argumVal=arguments[1];
	}
	
	if(argumVal=="popupOrg"){
		plength =1;
	}else {
		phonNum=phoneNumber(p_phoneNum);
		if(!phonNum){
			alert("전화번호를 입력해 주세요.");
			return;
		}
	}
 
	// cti 사용유무를 체크하여 통화연결
	if(!ws)
	{
			alert("cti와 연결되어 있지 않습니다. 재접속후 전화를 걸어 주세요.");
		return;
	}
	
		// 보류상태일 경우 전화 연결 불가 '업무'에서 전화 가능
	var sStat=$("#MainStatusNm").html();
//		if( sStat=="[후처리]" || sStat=="[대기]"
//		   ||sStat=="[준비]"||sStat=="[휴식]"|| sStat == "[식사]"
//		   || sStat=="[교육]"|| sStat=="[기타]" || sStat=="[3자통화]" 
//		   || sStat=="[협의통화]" || sStat=="[로그인]" || sStat=="[]") 
//		{
//			alert(sStat+"상태에서는 전화연결을 할 수 없습니다.");
//			return;
//		}
		
		 if( sStat=="[후처리]" || sStat=="[대기]" ||sStat=="[준비]"
		   || sStat=="[휴식]"|| sStat=="[식사]" || sStat=="[이석]"
		   || sStat=="[교육]"|| sStat=="[기타]" || sStat=="[3자통화]" 
		   || sStat=="[협의통화]" || sStat=="[로그인]" || sStat=="[업무]") 
		{
			window.sessionStorage.setItem("callType","makecall");  // 아웃바운드 
		}else if(sStat=="[보류]"||sStat=="[통화중]"){
			if(window.sessionStorage.getItem("callType")!="transfer"){
				window.sessionStorage.setItem("callType","consult"); // 협의
			}
		}else{
			alert("전화기 상태를 확인해 주세요."); 
			return;
		}
		 
		calltype=window.sessionStorage.getItem("callType");	
 
	if(calltype == "consult")
	{
		if( sStat=="[통화중]" || sStat=="[보류]")
		{
			var arState = new Array( "3", "3", "3", "3", "3", "3", "3", "3", "3", "2");
			OnButtonProc(arBtn, arState);
	
			// 협의통화일경우
			fnConsult("CONSULT", phonNum, "", $("#CALLNO").val());
			
			//실제로 협의 연결시 값 true로 변경
		//	g_transFlag = true;
			
			$("#popupMessageConfirmPopup").show();
			$("#labTransferDialog").html("");
			// 호전환 확인 팝업 표시
			$("#dialogMainConfirmPopup").dialog("open");
			// 협의통화 연결시 버튼 비활성화
			$(":button:contains('협의전달'), :button:contains('3자통화')").prop("disabled", true).addClass( 'ui-state-disabled' );
		}else{
			alert("통화중에만 협의통화를 할 수 있습니다.");
		}
		 
	}
	else if(calltype == "transfer")
	{
		// 호전환일 경우
		//fnLog("Request [fnSingleStepTransfer]");
		fnSingleStepTransfer( phonNum, "", $("#CALLNO").val());
	}
	else if(calltype == "makecall")
	{
				var tmpOutDIAL="";
				var tmpCustId="";
				var tmpCALLNO="";
				var tmpCustNm="";
				$("#tfMainTicketId").val(""); //티켓ID  초기화
	 
				// 통화중이 아닐경우
				fnMakeCall(phonNum, tmpCustId, tmpCALLNO, tmpCustNm);
	}
	
	//초기화
	window.sessionStorage.setItem("callType","");
 
}


function curCallCheck(phoneNum){
	if($("#CALLNO").val()==phoneNum){
		alert("현재 통화중인 전화번호로 다시 연결할 수 없습니다. 현재:"+$("#CALLNO").val() +" 시도:"+phoneNum);
		return false;
	}
	return true;
}

/**
 * 전화번호 체크
 * @param callnum
 * @returns {String}
 */
function phoneNumber(callnum){
	var ext_no=$("#EXTNO").val();
	if(ext_no==callnum){
		alert("현재 사용중인 전화기입니다.");
		return;
	}
	callnum=callnum.trim();
	
	var pLength = arguments.length;
	if(pLength==2){
		return callnum;
	}
	
	if(!callnum) return "";

	var pattern =/[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi; // 정규식
	var filtNum=callnum.replace(pattern, "");
	
	//숫자체크
	if(isNaN(filtNum) == true) {
		alert("전화번호는 숫자만 가능합니다.");
		////console.log("입력된 값 : " + filtNum + " / 문자");
		 return "";
	} else {
		////console.log("입력된 값 : " + filtNum + " / 숫자");
	}
 
	return filtNum;
}	


	// 로그아웃 메소드
function fnLogout()
{
 		// cti logout
 		if(ws){
			fnLogoutCTI(); 
 		}
 	logout(); //로그인 화면으로 이동
}

//unloade page event
function unloadPage()
{
	//console.log("unloadPage!!");
	if(ws){
		fnLogout(); //로그아웃 
	}
}

//********************* 전화걸기 모달 ****************************
function teleModalCondition(){
  var modalLayer = $("#modalLayer");
  var modalLayerheader = $("#modalLayerheader");
  var modalLink = $(".modalLink");
  var modalCont = $(".modalContent");
  var marginLeft = modalCont.outerWidth()/2;
  var marginTop = modalCont.outerHeight()/2;
  //로딩시 숨기기
  modalLayer.hide();
  
//  $("#imgShorcutCall").click(function(){
//    modalLayer.fadeIn("slow");
//   // modalLayerheader.css({"margin-top" : -marginTop+10, "margin-left" : -marginLeft+10});
//   // modalCont.css({"margin-top" : -marginTop, "margin-left" : -marginLeft});
//    //$(this).blur();
//    $("#modalCallNum").focus(); 
//    return false;
//  });

  	$("#modalCallNum").bind("keydown", function(key) 
	{
	  	var len=$("#modalCallNum").val().length;
			if (key.keyCode == 13 && len > 4){
				$("#btnModalCall").trigger("click");
				return false;
			}
	});
  	
  	// 호전환 전화 끊기 클릭 이벤트
	$("#btnModalHangUp").bind("click", function(e)
	{
		if(g_transFlag)
		{
			fnConsultCancel("");
			g_transFlag = false;
			$("#dialogMainConfirmPopup").dialog("close");
		}
		else
		{
			fnHangup();
		}
	});
	
  	// 호전환 전화 끊기 클릭 이벤트
	$("#btnMdalTransfer").bind("click", function(e)
	{
			if(bCalling)
			{
				 	var textbox=$("#modalCallNum").val(); //화면 
					var pureNum=phoneNumber(textbox); //입력 값  
			
					if(pureNum=="" && pureNum.length<4){
						alert("전화번호를 정확하게 입력해 주세요.");
						$("#modalCallNum").focus();
						return;
					}
					
					//현재 연결된 전화번호 체크
					if(!curCallCheck(pureNum)){
						return;
					}
					
					var sStat=$("#MainStatusNm").html();
							
					if(sStat=="[보류]"||sStat=="[통화중]"){
						 window.sessionStorage.setItem("callType","transfer"); // onestep Transfer
				 		makeCall(pureNum);
					}
					else
					{
						alert("통화중에만 가능합니다.");	
					}
			}
			else
			{
				alert("통화중에만 가능합니다.!");	
			}
	});
  	
  	
 	// 호전환 전화기 클릭 이벤트
	$("#btnModalCall").bind("click", function(e)
	{
		var textbox=$("#modalCallNum").val(); //화면 
		var pureNum=phoneNumber(textbox); //입력 값  
		
		if(pureNum=="" && pureNum.length<4){
			alert("전화번호를 정확하게 입력해 주세요.");
			$("#modalCallNum").focus();
			return;
		}
		
		//현재 연결된 전화번호 체크
		if(!curCallCheck(pureNum)){
			return;
		}
		
//		var sStat=$("#MainStatusNm").html();
//		
//		// 상태를 확인하고 조정후  바로 연결
//		if( sStat=="[후처리]" || sStat=="[대기]" || sStat=="[준비]"
//		   || sStat=="[휴식]"|| sStat=="[식사]" || sStat=="[이석]"
//		   || sStat=="[교육]"|| sStat=="[기타]" || sStat=="[3자통화]" 
//		   || sStat=="[협의통화]" || sStat=="[로그인]" || sStat=="[업무]") 
//		{
//			//$("#MainStatusNm").html("업무");  
//			window.sessionStorage.setItem("callType", "makecall"); // 아웃바운드
			makeCall(pureNum);
//		}else if(sStat=="[보류]"||sStat=="[통화중]"){
//			window.sessionStorage.setItem("callType", "consult"); // 협의콜
//			makeCall(pureNum);
//		}else{
//			alert("전화기 상태를 확인해 주세요.");
//			$("#modalCallNum").focus();
//			return;
//		}
		
	});	 
	
	  $("#popupCollapse").click(function(){
		if($(".modalContent").css("display") == "none"){
			$(".modalContent").show();
			$("#popupCollapse").attr("src","/images/operator/sel_dub_arrow2.png");
			$("#modalCallNum").val("");
			$("#modalCallNum").focus();
		} else {  
		    $(".modalContent").hide();
		    $("#popupCollapse").attr("src","/images/operator/sel_dub_arrow.png");
	    }
	  });
  
   

  
  $("#popupClose").click(function(){
    modalLayer.fadeOut("slow");
    modalLink.focus();
  });		

	// 클리어
	$("#modalCallNum").bind("dblclick", function(e)
	{
		$("#modalCallNum").val(""); //화면  
	});

//  $(".modalContent").resizable({
//      maxHeight: 250,
//      maxWidth: 450,
//      minHeight: 30,
//      minWidth: 450
//    });

  	//Make the DIV element draggagle:
	dragElement(document.getElementById(("modalLayer")));
  //*********************** 전화걸기 모달 **************************
}

 //*********************** 전화걸기 모달 드래그 **************************
function dragElement(elmnt) {
  var pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 0;
  if (document.getElementById(elmnt.id + "header")) {
    /* if present, the header is where you move the DIV from:*/
    document.getElementById(elmnt.id + "header").onmousedown = dragMouseDown;
  } else {
    /* otherwise, move the DIV from anywhere inside the DIV:*/
    elmnt.onmousedown = dragMouseDown;
  }

  function dragMouseDown(e) {
    e = e || window.event;
    // get the mouse cursor position at startup:
    pos3 = e.clientX;
    pos4 = e.clientY;
    document.onmouseup = closeDragElement;
    // call a function whenever the cursor moves:
    document.onmousemove = elementDrag;
  }

  function elementDrag(e) {
    e = e || window.event;
    // calculate the new cursor position:
    pos1 = pos3 - e.clientX;
    pos2 = pos4 - e.clientY;
    pos3 = e.clientX;
    pos4 = e.clientY;
    // set the element's new position:
    elmnt.style.top = (elmnt.offsetTop - pos2) + "px";
    elmnt.style.left = (elmnt.offsetLeft - pos1) + "px";
  }

  function closeDragElement() {
    /* stop moving when mouse button is released:*/
    document.onmouseup = null;
    document.onmousemove = null;
  }
}
//*********************** 전화걸기 모달 드래그 ************************** 
