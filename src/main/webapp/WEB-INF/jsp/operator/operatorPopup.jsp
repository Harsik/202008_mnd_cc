<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/layout/include/incHeader.jspf" %>

<link rel="stylesheet" type="text/css"	href="../jqueryui/jquery-ui.css" />

<script type="text/javascript"	src="../js/jquery-1.7.1.min.js"></script>
<script type="text/javascript"	src="../jsTree/jstree.3.3.5/jquery-1.12.1.js"></script>
<script type="text/javascript"	src="../jqueryui/jquery-ui.js"></script>

<link rel="stylesheet" type="text/css" href="../js/lib/jquery-ui-month-picker/MonthPicker.min.css" />
<script type="text/javascript"	src="../js/lib/jquery-ui-month-picker/MonthPicker.min.js"></script> 

<style>
#search input[type='text'] {
	width: 80px;
	height: 17px;
	line-height: 0px;
	font-size: 13px;
}
#search select {width: 80px;height: 20px;}
#search th {padding: 0px 5px 0px 30px;}
.popCnt button {padding: 0px; width: 40px; line-height: 20px; font-size: 13px; margin-bottom: 6px;}

</style>

<script type="text/javascript">
var adminYn = window.sessionStorage.getItem("ADMIN_YN");

$(document).on("click","#btn_close", function() {
	window.close();
})  

function fnInit(){
	//월별  set start
    $("#MonthStart").MonthPicker({
        MaxMonth: 0
    });
    
    $("#MonthEnd").MonthPicker({
        MaxMonth: 0
    });
    
    $('#MonthStart').val( getDate().substr(0, 7) );
    $('#MonthEnd').val( getDate().substr(0, 7) );
    //월별  set end
    
    //주별 set start
    $("#WeekDay").val( getDate() );
    datePicker("#WeekDay");
    //주별 set end
    
    //요일별 set start
    $('#DayStart').val( getDate() );
    $('#DayEnd').val( getDate() );
    
    datePicker("#DayStart");
    datePicker("#DayEnd");
    //요일별 set end
    
    //시간별 set
    $("#timeStart").val("00");
    $("#timeEnd").val("23");
    
    $("#optTerm").val("day");
    $("#Usrgbcd").val("");
    $("#Callgbcd").val("all");
    
    fnChangeTerm();
    
    fnSearch();
}

/*
 * selectbox change 함수
 */
function fnChangeTerm() {
    
    var termType = $("#optTerm").val();
    
    if(termType == "time"){
    	$("#dvTime").show();
        $("#dvMonth").hide();
        $("#dvWeek").hide();
        $("#dvDay").hide();
    }
    else if(termType == "month") {
        $("#dvTime").hide();
        $("#dvMonth").show();
        $("#dvWeek").hide();
        $("#dvDay").hide();
    }
    else if(termType == "day") {
        $("#dvTime").hide();
        $("#dvMonth").hide();
        $("#dvWeek").hide();
        $("#dvDay").show();
    }
    else if(termType == "week") {
        $("#dvTime").hide();
        $("#dvMonth").hide();
        $("#dvWeek").show();
        $("#dvDay").hide();
    }
    
}


function fnSearch(){
	var termType = $("#optTerm").val();
    
    var stDt  = "";
    var endDt = "";
    
    if(termType == "time"){
        stDt  = $('#timeStart').val().replace(/["시"]/g, "");
        endDt = $('#timeEnd').val().replace(/["시"]/g, "");
    }
    else if(termType == "month"){
        stDt  = $('#MonthStart').val();
        endDt = $('#MonthEnd').val();
    }
    else if(termType == "day"){
        stDt  = $('#DayStart').val();
        endDt = $('#DayEnd').val();
    }
    else if(termType == "week"){
        stDt  = commWeekStartDay($('#WeekDay').val());
        endDt = commWeekEndDay($('#WeekDay').val());
    }
    
    if(termType=="month" || termType == "day"){
    	var schStartDt = new Date(stDt);
    	var schEndDt = new Date(endDt);
    	
    	if( ( (schEndDt.getTime() - schStartDt.getTime()) / ( 1000 * 60 * 60 * 24 ) ) > 31 ){
    		alert("1개월 이상 검색할 수 없습니다.");
    		return false;
    	}
    }
    
    if($("#Usrgbcd").val().length > 0 && $("#Usrgbcd").val().length != 4){
    	alert("아이디가 제대로 입력되지 않았습니다.");
    	$("#Usrgbcd").focus();
    	return false;
    }
	
	$.ajax({   
		url:"/operator/selectPopupList.do",
		dataType:'json',
		type:"post",
		async:true,
		data:{
			"adminYn" : adminYn,
			"termType": termType,
			"startDt" : stDt.replace(/[-, :, \s]/g, ""),
			"endDt"	  : endDt.replace(/[-, :, \s]/g, ""),
			"Usrgbcd" : $("#Usrgbcd").val(),
			"Callgbcd": $("#Callgbcd").val()
		},
		success:function(data) {
			createTable(data);
		}
	});
}

function createTable(data){
	$(".tbl_type_board tbody").empty();
	
	var datas = data.list;
	
	var str = "";
	if(datas.length != 0){ // data != null
		$.each(datas , function(i){
		str += '<TR>';
		if(datas[i].callType ==11){
			str += '<td>인바운드</td>';
		}else if(datas[i].callType ==14){
			str += '<td>인바운드후 협의</td>';
		}else if(datas[i].callType ==22){
			str += '<td>아웃바운드</td>';
		}else if(datas[i].callType ==33){
			str += '<td>내선통화</td>';
		}else if(datas[i].callType ==15){ // 21.01.04 악성민원/안내 추가
			if(datas[i].targetDn==3010){
				str += '<td>악성민원(언어폭력)</td>';
			}else if(datas[i].targetDn==3011){
				str += '<td>악성민원(성희롱)</td>';
			}else if(datas[i].targetDn==3012){
				str += '<td>악성민원(업무방해)</td>';
			}else if(datas[i].targetDn==3013){
				str += '<td>연결(아웃바운드)</td>';
			}
		}
		str += '<td>'+fnConvertDateFormat(datas[i].eventStarttime)+'</td>';
		str += '<td>'+(datas[i].ani==undefined?"":telnoFormat(datas[i].ani))+'</td>';
		str += '<td>'+(datas[i].callTime==undefined?"":datas[i].callTime)+'초</td>';
		if(datas[i].callType ==15){
			str += '<td>'+(datas[i].uei==undefined?"":telnoFormat(datas[i].uei))+'</td>';
		}else{
			str += '<td>'+(datas[i].targetDn==undefined?"":telnoFormat(datas[i].targetDn))+'</td>';
		}
		if(adminYn=="Y"){
			str += '<td>'+(datas[i].employeeId==undefined?"":datas[i].employeeId)+'</td>';
		}
		str += '</TR>';
		});
	}else{
		str += '<TR>';
		str += '<td colspan="13">NO SEARCH DATA</td>';
		str += '</TR>';
	}
	
	$(".tbl_type_board tbody").append(str); 
	
}

function telnoFormat(num){
	var formatNum = '';

    if(num.length>11){
        formatNum = num;
    }else if(num.length==11){
    	formatNum = num.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
    }else if(num.length==8){
        formatNum = num.replace(/(\d{4})(\d{4})/, '$1-$2');
    }else if(num.length==7){
        formatNum = num.replace(/(\d{3})(\d{4})/, '$1-$2');
    }else{
        if(num.indexOf('02')==0){
        	formatNum = num.replace(/(\d{2})(\d{4})(\d{4})/, '$1-$2-$3');
        }else{
            formatNum = num.replace(/(\d{3})(\d{3})(\d{4})/, '$1-$2-$3');
        }
    }

    return formatNum;
}

function divTimeSelBox(){
	var str="";
	var selId=["timeStart","timeEnd"];
	
	for(var i=0; i<2; i++){
		str += '<select id='+selId[i]+'>';
		for(var j=0; j<24; j++){
			if(j<10){
			str += '<option value =0'+j+'>0'+j+'시</option>';
			}else{
				if(i==0 && j==23){
				str += '<option value ='+j+' selected="selected">'+j+'시</option>';	
				}else{
				str += '<option value ='+j+'>'+j+'시</option>';
				}
				
			}
		}
		str += '</select>'
		if(i==0) str += '<span> ~ </span>';
	}
	
	$("#dvTime").append(str);
}

$(document).ready(function(){
	divTimeSelBox();
	
	fnInit();
	
	//일별,월별 selectbox change 이벤트
	$("#optTerm").bind("change", fnChangeTerm);
	
	//조회 버튼 이벤트
	$("#btnSearch").bind("click", fnSearch);
	
	//초기화 버튼 이벤트
	$("#btnInit").bind("click", fnInit);
	
	if(adminYn=="N"){
		$("#UsrgbcdTh,#Usrgbcd").css( "visibility", "hidden" );
	}else{
		$(".tbl_type_board colgroup").append('<col width="15%">');
		$(".tbl_type_board tr").append('<th scope="col">상담사ID</th>');
	}
	
	$("#Usrgbcd").keyup(function (key) {
		if(key.keyCode == 13){
			fnSearch();
		}
	});
});


</script>
<div id="popWrap">
	<!--header-->
	<div class="popHead">
		<h1>상담이력 상세 팝업</h1>
		<a href="#" class="btn_close" id="btn_close"><img src="../images/operator/btn_p_close.gif" alt="닫기" /></a>
	</div>
    <!--//header-->
    <!--contents_area-->
    <div class="popCnt">
    	<!-- 검색 -->
    	<div style="float: right;">
    		<button title="조회" class="btnComm gray" id="btnSearch" type="button">조회</button>
    		<button title="초기화" class="btnComm gray" id="btnInit" type="button">초기화</button>
    	</div>
    	<div id="search">
    		<table>
    			<tr>
    				<td style="width: 49%;">
    					<select id="optTerm">
                            <option value = "time">시간별</option>
                            <option value = "month">월별</option>
                            <option value = "week">주별</option>
                            <option value = "day" selected="selected">일별</option>
                        </select>
                        <div id="dvTime" style="display: inline;"></div>
                        <div id="dvMonth" style="display: inline;">
                            <input type="text" class="text_Date" id="MonthStart" maxlength="7" style="width: 65px;"/>
                            <span>~</span>
                            <input type="text" class="text_Date" id="MonthEnd" maxlength="7" style="width: 65px;"/>
                        </div>
                        <div id="dvWeek" style="display: inline;">
                            <input type="text" class="text_Date" id="WeekDay" maxlength="10" />
                        </div>
                        <div id="dvDay" style="display: inline;">
                            <input type="text" class="text_Date" id="DayStart" maxlength="10" />
                            <span>~</span>
                            <input type="text" class="text_Date" id="DayEnd" maxlength="10" />
                        </div>
    				</td>
    				
    				<th id="UsrgbcdTh">교환원</th>
    				<td><input type="text" id="Usrgbcd" maxlength="4" placeholder="아이디" style="color: rgba(170, 170, 170, 1);"/></td>
    				
    				<th>전화구분</th>
    				<td>
    					<select id="Callgbcd">
    						<option value="all">전체</option>
    						<option value="telno">일반전화</option>
    						<option value="mpno">핸드폰</option>
    					</select>
    				</td>   	
    			</tr>
    		</table>
    	</div>
		<!--상담이력:list-->
		<div class="board_type">
			<table class="tbl_type_board" border="1" cellspacing="0" summary="상담이력 게시판입니다.">
				<caption>상담이력 게시판</caption>
				<colgroup>
				<col width="20%">
				<col width="30%">
				<col width="25%">
				<col width="15%">
				<col width="20%">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">구분</th>
						<th scope="col">시간</th>
						<th scope="col">전화번호</th>
						<th scope="col">통화시간</th>
						<th scope="col">전환대상</th>
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table> 
		</div>
		<!--//상담이력:list -->
			
			<!--페이징-->
			<!-- <div class="tbl_bottom">
				<div class="pagination">
					<a title="처음페이지" class="btn_first"><span>첫페이지로 이동</span></a>
					<a title="이전페이지" class="btn_prev"><span>이전 페이지로 이동</span></a>
					<a title="1" class="on">1</a>
					<a title="2">2</a>
					<a title="3">3</a>
					<a title="4">4</a>
					<a title="5">5</a>
					<a title="6">6</a>
					<a title="7">7</a>
					<a title="8">8</a>
					<a title="9">9</a>
					<a title="19">10</a>
					<a title="다음페이지" class="btn_next"><span>다음 페이지로 이동</span></a>
					<a title="마지막페이지" class="btn_last"><span>마지막페이지로 이동</span></a>
				</div>
			</div> -->
			<!--//페이징-->
			
			<!--btnArea-->
			<!-- <div class="btnArea t_center">
				<button type="button" class="btnComm gray mr5" title="확인">확인</button>
				<button type="button" class="btnComm gr_line" title="취소">취소</button>
			</div> -->
			<!--//btnArea-->
	</div>
	<!--//contents_area-->
	
</div>