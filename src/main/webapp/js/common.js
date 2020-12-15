// javascript hashMap 사용
Map = function(){
	this.map = new Object();
};   
Map.prototype = {   
	put : function(key, value){   
		this.map[key] = value;
	},
	putMap : function(key, value){
		this.map[key] = value.map;
	},
	putList : function(key, value){
		var list = new Array();
		for(var i=0;i<value.length;i++){
			list.push(value[i].map);
		}
		this.map[key] = list;
	},  
	get : function(key){   
		return this.map[key];
	},
	containKey : function(key){    
		return key in this.map;
	},
	containVal : function(value){    
		for(var prop in this.map){
			if(this.map[prop] == value) return true;
		}
		return false;
	},
	isEmpty : function(key){    
		return (this.size() == 0);
	},
	clear : function(){   
		for(var prop in this.map){
			delete this.map[prop];
		}
	},
	remove : function(key){    
		delete this.map[key];
	},
	keys : function(){
		var keys = new Array();
		for(var prop in this.map){
			keys.push(prop);
		}
		return keys;
	},
	values : function(){   
		var values = new Array();   
		for(var prop in this.map){   
			values.push(this.map[prop]);
		}   
		return values;
	},
	size : function() {
		var count = 0;
		for (var prop in this.map) {
			count++;
		}
		return count;
	},
	jsonString: function(){
		return JSON.stringify(this.map);    
	}
};


//null check
function isEmpty(value) {
	if ( value == undefined || value == null || value == "" ) {
		return true;
	} else {
		return false;
	}
}

/**
* 딜레이 함수
* @param msecs 딜레이 시간 (1000 = 1초)
*/
function sleep(msecs){
	  var start =new Date().getTime();
	  varcur=start;
	  while(cur-start<msecs){
	    cur=new Date().getTime();
	  }
	}

/**<pre>
 * 단순 팝업창을 호출하는 경우
 * 예) gfn_popup("/test/testPopup.do",500,350)
 * 예) gfn_popup("/test/testPopup.do",500,350,"팝업창이름")
 * </pre>
 * @param strURL
 * @param strW
 * @param strH
 * @param strWinName
 */
function gfn_popup(strURL,strW,strH,strWinName){
	// ---------------------------
	var pwidth = strW;		// 팝업창 width값
	var pheight = strH;	// 팝업창 height값
	var pName; // 팝업창명
	var winX = window.screenLeft;
	var winY = window.screenTop;
	if(strWinName == undefined || strWinName == null){
		pName = "popup";
	}else{
		pName = strWinName;
	}
	// ---------------------------
	if(navigator.appName.indexOf("Microsoft") != -1) {
	} else if (navigator.appName.indexOf("Netscape") != -1) {
		pwidth = Number(strW)+5;	// 팝업창 width값
		pheight = Number(strH)+5;	// 팝업창 height값
	
	}
	// ---------------------------
	var sw  = screen.availWidth ;
	var sh  = screen.availHeight ;
	px= winX + (sw - pwidth)/2;
	py= winY +(sh - pheight)/2;
		
	var option = "scrollbars=yes,menubar=no,resizable=no,width="+pwidth+"px,height="+pheight+"px, top="+py+",left="+px;
	var nw = window.open(strURL,pName,option);
	nw.focus();
}


//null 값check
var Acc_Auh = "N";                   /*세목권한여부*/
var initChk = "" ;
function isNull(value) {
	if (value == "" ||  value == null || value == 'undefined' || value == "<undefined>"  || value == " " || typeof(value) == undefined) {
		return true;
	}
	
	return false;
}

/**
 * getToday : 오늘날짜
 */
function getToday()
{
	var nowDate = new Date();
	var nowYear = nowDate.getYear();
	var nowMonth = nowDate.getMonth()+1;
	var nowDay = nowDate.getDate();
	if(nowMonth <10) nowMonth = "0"+nowMonth;
	if(nowDay <10)   nowDay   = "0"+nowDay;
	var toDay = nowYear +""+ nowMonth +""+ nowDay;

	return toDay;
}

/**
 * getDate : 현재날짜
 */
function getDate()
{
	var date = new Date();
	var year = date.getFullYear();
	var month = date.getMonth() + 1;
	var day = date.getDate();
	
	if(month < 10)
		month = "0"+month;
	if(day < 10)
		day = "0"+day;
	
	return year + "-" + month + "-" + day; 
}

/**
 * getTime : 현재시간
 */
function getTime()
{
	var date = new Date();
	var hh = date.getHours();
	var mm = date.getMinutes();
	
	if (hh < 10) 
		hh = "0" + hh;
	if (mm < 10)
		mm = "0" + mm;
	
	return hh + ":" + mm;
}

/**
* 한달 전 날짜 반환 함수
* @return new Date()
*/
function retDate(){
	
	var prevDate = new Date();
	var FormatDate = prevDate.toLocaleDateString( prevDate.setMonth(prevDate.getMonth()-1) );
	var arrDate = FormatDate.split(" ");
	
	var y = arrDate[0].replace(/년/g, "");
	var m = arrDate[1].replace(/월/g, "");
	var d = arrDate[2].replace(/일/g, "");
	
	if(m.length == 3) m = "0" + m;
	if(d.length == 3) d = "0" + d;
	
	return y+"-"+ m +"-"+ d;
}

//==============================================================================
//Description  	: 지정날짜구하기
//Parameter    	: targetday : 지정일 
//Parameter    	: type      : YY:년도, MM:월, DD:날짜
//Parameter    	: args      : 더할 날짜.
//Return Value	: rtnVal    : 형식에 맞는 시간
//==============================================================================
function getAddDate( targetday, type, args )
{
	if(targetday.length != 8 ){
		return false;
	}

	var nowDate  = new Date(targetday.substring(0,4), targetday.substring(4,6), targetday.substring(6,8) );

	if(type == "YY"){
		nowDate.setYear( nowDate.getYear()+ parseInt(args));
	}else if (type == "MM"){
		nowDate.setMonth( nowDate.getMonth()+ parseInt((args-1)));
	}else if (type == "DD") {
		nowDate.setDate( nowDate.getDate()+ parseInt(args));
	}

	var nowYear  = nowDate.getFullYear();
	var nowMonth = nowDate.getMonth();
	if(type == "MM"){
		nowMonth = nowDate.getMonth()+1;
	}else{
		nowMonth = nowDate.getMonth();
	}
	var nowDay   = nowDate.getDate();

	if(nowMonth == 0) nowMonth = 12;
	if(nowMonth <10) nowMonth = "0"+nowMonth;
	if(nowDay <10)   nowDay   = "0"+nowDay;
	var rtnVal  = nowYear +""+ nowMonth +""+ nowDay;

	return rtnVal;
}

/**
 * @name	get_data_with_json
 * @desc	Transaction function
 * @author	Joseph Hong (str2350@nate.com)
 * @version	2011.12.12
 */
function get_data_with_json(sUrl, objData, callback, default_data, popupId)
{
	$.ajax({
        type:"POST",
        url: sUrl,
        data: objData,
        cache: false,
        beforeSend: function() {
            //console.log('[beforeSend]:');
        },
        success: function (data) {
        	if( typeof callback == "function" )
			{
        		callback(data, popupId);
        	}
        },
        complete:function () {
            //console.log('[complete]:');
        },
        error: function(data) {
        	if( typeof callback == "function" )
			{
        		callback(default_data, popupId);
        	}
        }
    });					
}

/**
 * @name	log_message
 * @desc	logging at browser console window
 * @author	Joseph Hong (str2350@nate.com)
 * @version	2011.12.12
 */
function log_message(message)
{
  try{
	  if(console)
	  {
	    console.log(message);
	  }
  } catch(e)
  {
  }
}

//bpopup open
function openBpopup( popupId, popupUrl, popupParam, width ){
	var bpopuplayer = $('<div />').attr('id', popupId).attr('style','background:#FFFFFF;width:' + width + 'px').appendTo($('body'));
	
	get_data_with_json(popupUrl, popupParam, bpopupCallback, "Error!!", popupId);
}

//bpopup data callback 
function bpopupCallback( data, popupId ){
	$("#" + popupId).html( data );
	$('#' + popupId).bPopup();	
}

//bpopup close
function closeBpopup( popupId ){
	$('#' + popupId).bPopup().close();
	$('#' + popupId).remove();
}

/**
 * @name	fixalign
 * @desc	지정 개체를 화면 중앙 정렬
 * @author	Joseph Hong (str2350@nate.com)
 * @version	2011.12.12
 */
function fixalign(targetElement) 
{
	var screen = {
		x:$(window).width(),
		y:$(window).height()
	};

	var targetmatrix = {
		x:targetElement.width(),
		y:targetElement.height()
	};

	var fixmatrix = {
		x:(screen.x - targetmatrix.x)/2,
		y:(screen.y - targetmatrix.y)/2+$(window).scrollTop()
	};

	targetElement.css('left',fixmatrix.x);
	targetElement.css('top',fixmatrix.y);
}


function setLogoutTimer(urlName){
	setInterval(function(){goLogout(urlName)},1200000); //3분후 로그아웃시킴
	//setInterval(function(){goLogout(urlName)},6000); //3분후 로그아웃시킴
}

function goLogout(urlName) {
	if(urlName === "admin") {
		location.href = "/admin/logout.do";
	} else if(urlName === "operator") {
		location.href = "/operator/logout.do";
	} else if(urlName === "intra") {
		location.href = "/intra/logout.do";
	}
	localStorage.clear();
}

function fnSendService (sendUrl, sendData, callback) {
	
	var CONTENT_TYPE = "application/json; charset=utf-8";
	var DATA_TYPE = "json";
	var SEND_TIMEOUT = 10000;
	
	$.ajax({
		url : sendUrl
	    , type : "post"  
	    , contentType: CONTENT_TYPE
	    , dataType : DATA_TYPE
	    , data : sendData.jsonString()
	    , timeout: SEND_TIMEOUT
	    , beforeSend: function() {
	    	console.log("진행중");
	    }
	    , success : function(result){
	    	fnSetResult(result, callback);
	    }
	    , complete : function(data) {
	    	console.log("닫기");
	    }
	    , error:function(request, status, error){  
			//fnAlert_msg("[" + request.status + "] " + "서비스 오류가 발생하였습니다. 잠시후 다시 실행하십시오.");  
	    	console.log("[" + request.status + "] " + "서비스 오류가 발생하였습니다. 잠시후 다시 실행하십시오.");  
	    }  
	});

};

function fnSetResult(result, callback) {
	
	if(typeof callback === 'function') {
		callback(result.resultData);
	}
	
};



//2ksystem 파일 upload
//업로드  파일 사이즈 체크 
function fileCheck( fileFormName , limitSize )
{
  // 사이즈체크
  var maxSize  = 3 * 1024 * 1024    //30MB
  var fileSize = 0;

	// 브라우저 확인
	var browser=navigator.appName;
	// 익스플로러일 경우
	if (browser=="Microsoft Internet Explorer")
	{
		var oas = new ActiveXObject("Scripting.FileSystemObject");
		fileSize = oas.getFile( fileFormName.value ).size;
	}
	// 익스플로러가 아닐경우
	else
	{
		fileSize = fileFormName.files[0].size;
	}

	//alert("파일사이즈 : "+ fileSize/1000000 +"MB, 최대파일사이즈 : "+limitSize+"MB");
	return (fileSize/1000000).toFixed(2);
//      if(fileSize > maxSize)
//      {
//          alert("첨부파일 사이즈는 5MB 이내로 등록 가능합니다.    ");
//          return;
//      }
}

//파일 확장자 체크
function fileExtnsCheck(fileFormName) 
{   
	var file = fileFormName.value;  								// 폼.파일이름.value
	var fileExt = file.substring(file.lastIndexOf('.')+1); 	//파일의 확장자를 구합니다.
	var bSubmitCheck = true;

	if( !file )
	{ 
		alert( "파일을 선택하여 주세요!");
		return false;
	}

	if(fileExt.toUpperCase() == "XLS" || fileExt.toUpperCase() == "XLSX" || 
			fileExt.toUpperCase() == "DOC" || fileExt.toUpperCase() == "DOCX" ||
			fileExt.toUpperCase() == "PPT" || fileExt.toUpperCase() == "PPTX" || 
			fileExt.toUpperCase() == "HWP" || fileExt.toUpperCase() == "HWPX" ||
			fileExt.toUpperCase() == "NXL" || fileExt.toUpperCase() == "CELL" ||
			fileExt.toUpperCase() == "JPEG" || fileExt.toUpperCase() == "JPG" ||
			fileExt.toUpperCase() == "GIF" || fileExt.toUpperCase() == "PNG" ||
			fileExt.toUpperCase() == "BMP" || fileExt.toUpperCase() == "TXT" ||
			fileExt.toUpperCase() == "PDF" 
		)
	{
		return true;
	}
	else
		return false;

}
//jquery datepicker
function datePicker(id)
{
	$(function() {	    
	    $(id).datepicker({
	    	showOn: 'button',
	    	buttonImage : "/images/icon_cal_drop.gif",
	    	buttonImageOnly: true,
	    	dateFormat : 'yy-mm-dd',
	    	monthNamesShort : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	        dayNamesMin : ['일','월','화','수','목','금','토'],
	    	changeMonth : true,
	        changeYear : true,
	    	showMonthAfterYear : true,
	      });
	    
	    $(".ui-datepicker-trigger").css("vertical-align","middle");
	});
}


/*
 * 해당 일자가 속한 주의 시작일자를 구한다.
 * @param : 'YYYYMMDD'
 */
function commWeekStartDay(pStrDate){
    
    var sDate = pStrDate.replace(/[-, :, \s]/g, "");
    
    var year = sDate.substr(0,4);
    var month = sDate.substr(4,2);
    var day = sDate.substr(6,2);
    
    var iDay = parseInt(new Date(year, month-1, day).getDay());
    var sStartDate = new Date(year, parseInt(month)-1, parseInt(day) - iDay); //선택한 요일의 시작일을 구한다.
    
    var sStartYear = sStartDate.getFullYear();
    var sStartMonth = parseInt(sStartDate.getMonth() + 1);
    var sStartDay = sStartDate.getDate();
    
    var weekStartDay = '' + sStartYear + (sStartMonth < 10 ? '0' + sStartMonth : sStartMonth) + (sStartDay < 10 ? '0' + sStartDay : sStartDay);
    
    return weekStartDay;
}


/*
 * 해당 일자가 속한 주의 종료일자를 구한다.
 * @param : 'YYYYMMDD'
 */
function commWeekEndDay(pStrDate){
    
    var sDate = pStrDate.replace(/[-, :, \s]/g, "");
    
    var year = sDate.substr(0,4);
    var month = sDate.substr(4,2);
    var day = sDate.substr(6,2);
    
    var iDay = parseInt(new Date(year, month-1, day).getDay());
    
    var diffDay = 6 - iDay;
    
    
    var sEndDate = new Date(year, parseInt(month)-1, parseInt(day) + diffDay); //선택한 요일의 종료일을 구한다.
    
    var sEndYear = sEndDate.getFullYear();
    var sEndMonth = parseInt(sEndDate.getMonth() + 1);
    var sEndDay = sEndDate.getDate();
    
    var weekEndDay = '' + sEndYear + (sEndMonth < 10 ? '0' + sEndMonth : sEndMonth) + (sEndDay < 10 ? '0' + sEndDay : sEndDay);

    return weekEndDay;
}

/**
 * Date 형식으로 변환하여 리턴
 */
function fnConvertDateFormat(dateData) {
	var dateString = "";
	
	if (dateData != undefined && dateData != null) {
		if (dateData.length >= 8) {
			dateString = dateData.substr(0, 4) + "-" + dateData.substr(4, 2) + "-" + dateData.substr(6, 2);
		}
		
		if (dateData.length == 14) {
			dateString = dateString + " " + dateData.substr(8,2) + ":" + dateData.substr(10, 2) + ":" + dateData.substr(12, 2);
		}
	}
	
	return dateString;
}