/*------------------------------------------------------
 * 정렬
 * @param file : form , resrch
-------------------------------------------------------*/
function autosubmit(f,resrch){
		  f.resrch.value = resrch;
		  f.submit();
}

/*------------------------------------------------------
 * 도움말 팝업
 * @param file : file name
-------------------------------------------------------*/
function openhelp(){  
	var lsParam = '';
	lsParam ='help.jsp';
	var win=window.open(lsParam,'help_search','menubar=no, resize=no, scrollbars=no, width=400, height=460');
  if(win) win.focus();
}

/*------------------------------------------------------
 * Target 변경
 * @param file : file name
-------------------------------------------------------*/
function changetarget(target){
	var fnm = document.search;
	fnm.target.value = target;
}
/*------------------------------------------------------
 * 결과내재검색
 * @param
-------------------------------------------------------*/
function resrch_chk()
{
   var fnm = document.search;          
   if(fnm.resrch_check.checked) {            
    	fnm.resrch.value = "yes";
    }else{
	    fnm.resrch.value = "";
	}	
}

/*------------------------------------------------------
 * 검색
-------------------------------------------------------*/
function goSearch(){

    var fnm = document.search;
    var query=fnm.query.value;
    query=query.replace(/^\s+/,""); 

    if (query == "" || query == null) {
        alert("검색어를 입력해주세요.");
        return;
    }
    
    rangeValue="";
    for(var i=0; i<fnm.range.length; i++){    	
    	if(fnm.range[i].checked){    		
    		if(rangeValue!="") rangeValue = rangeValue+",";
    		rangeValue = rangeValue+fnm.range[i].value;    		    		
    	}
    }
    
   fnm.arr_range.value = rangeValue;    
    fnm.refirst.value="yes";    
    setLatestQuery("MYQUERY",fnm.query.value);	// Cookie 저장(내가찾은 검색어)  
    fnm.submit();
    return false;
}

/*------------------------------------------------------
 * 인기검색어,내가 찾은 검색어
-------------------------------------------------------*/
function favoriteMyQuery(query){
	var fnm = document.search;
	fnm.query.value=query;
	fnm.startDate.value="";
	fnm.endDate.value="";
	setLatestQuery("MYQUERY",fnm.query.value);	// Cookie 저장
	fnm.submit();
	return false;
}

/*------------------------------------------------------
 * 더 많은 검색결과 보기
 * @param page : pagenum number
 * @param target : target name
 * @param resrch : resrch Use
-------------------------------------------------------*/
function moreResult(pagenum,target,resrch) {
	
	  var fnm = document.search;
	    if (document.search ) {
	    	fnm.pagenum.value = pagenum;
	    	fnm.target.value = target;
	    	fnm.resrch.value = resrch;
	    	if( resrch == "yes") fnm.resrch.checked=true;	    	
	    	fnm.submit();    	
	      return false;
	    }
}

/*------------------------------------------------------
 * 페이징 
 * @param page : page number
-------------------------------------------------------*/
function changePage(pagenum,resrch) {
		
	 var fnm = document.search;
	 fnm.resrch.value = resrch;
	 fnm.pagenum.value = pagenum;
	 fnm.submit();
}	

/*------------------------------------------------------
 * input 창에서 엔터키로 검색
 * @param page :keyCode 
-------------------------------------------------------*/
 function CheckEnt(obj)
 {
 	if (event.keyCode == 13)
 	{
 		goSearch();
 	}
 }
 
 /*------------------------------------------------------
  * 체크박스 그룹별 선택, 해제
  * @param num
 -------------------------------------------------------*/
 function check(num) {	
 	for (var i = 0; i < document.search.range.length; i++) {		
 		var anchor = document.search.range[i];
 		var relAttribute = String(anchor.getAttribute('rel'));		
 		if(relAttribute!=num) {
 			anchor.checked=false;
 		}
 	}
 }

 /*------------------------------------------------------
 * 달력에서 사용하는 메소드
 * @param page : date
-------------------------------------------------------*/
 function padZero(s)
{
		return (""+s).length<2?"0"+s:s;
}

function show(object) {
	if (document.layers && document.layers[object] != null) document.layers[object].visibility = 'visible';
	else if (document.all) document.all[object].style.visibility = 'visible';
}

function hide(object) {
	if (document.layers && document.layers[object] != null) document.layers[object].visibility = 'hidden';
	else if (document.all) document.all[object].style.visibility = 'hidden';
}

/*------------------------------------------------------
 * 기간 선택
-------------------------------------------------------*/
var gdCtrl = new Object();
var gcGray = "#FFFFFF";
var gcToggle = "#FFFFFF";
var gcBG = "#FFFFFF";
var gcBGTitle = "#F0F0F0";
var tableColor = "#C2E0E0";

var gdCurDate = new Date();
var giYear = gdCurDate.getFullYear();
var giMonth = gdCurDate.getMonth()+1;
var giDay = gdCurDate.getDate();

function nowDateSet() 
{
  var date = new Date();
  var year = date.getFullYear();
  var mon = date.getMonth() + 1;
  var day = date.getDate();
  if (mon < 10) 
  {
    mon = "0" + mon;
  }
  if (day < 10) 
  {
    day = "0" + day;
  }
  document.forms['search'].stday.value = year + "." + mon + "." + day;
  document.forms['search'].edday.value = year + "." + mon + "." + day;
}

function changeDate(i) 
{
	/*	라디오박스 추가부분 - Start */	
 	var form_tartget = document.search;
 	if(i!=0){
 	 	form_tartget.term0.checked=false;
 	}
 	if(i!=1){
 	 	form_tartget.term1.checked=false;
 	}
 	if(i!=2){
 	 	form_tartget.term2.checked=false;
 	}
 	if(i!=3){
 	 	form_tartget.term3.checked=false;
	}
 	if(i!=4){
 	 	form_tartget.term4.checked=false;
	}
 	/*	라디오박스 추가부분 - End */
  if(i===0)
 {
	  document.forms['search'].stday.value ="";
      document.forms['search'].edday.value ="";
	return;
 }
	  
  nowDateSet();
  
  var dminus = 0;
  var mminus = 0;
  var yminus = 0;
  var reset=0;
  
  var from;
  var date=new Date();
  var yy;
  var oldfrdate1=new Date();
  var oldfr1yy;
  var minus;
  var basicday = document.forms['search'].edday.value;
  var nowyear = basicday.substring(0,4);
  var nowmonth = basicday.substring(5,7) ;
  var nowday = basicday.substring(8,10);
  date.setYear(nowyear);
  date.setMonth(nowmonth - 1);
  date.setDate(nowday);

  switch(i)
  {
    case 0:
      break;
    case 1:
      dminus = 6;
      from=date.getDate() - dminus;
      date.setDate(from);
      break;
    case 2:
      mminus = 1;
      from=date.getMonth() - mminus;
      date.setMonth(from);
      break;     
    case 3:
      mminus = 3;
      from=date.getMonth()-mminus;
      date.setMonth(from);
      break;    
    case 4:
      mminus = 6;
      from=date.getMonth()-mminus;
      date.setMonth(from);
      break;
    case 5:
      yminus = 1;
      from=date.getFullYear()-yminus;
      date.setYear(from);
      break;
    case 6:
      yminus = 3;
      from=date.getFullYear()-yminus;
      date.setYear(from);
      break;
    case 7:
        yminus = 5;
        from=date.getFullYear()-yminus;
        date.setYear(from);
        break;
    case 8:
      //stimg.style.display="";
      //edimg.style.display="";
      reset=1;
      break;
}
   
  yy=date.getFullYear();
  mm = date.getMonth()+1;
  dd = date.getDate();
  if (mm < 10)
  { 
     mm = "0" + mm;
  }
  if (dd < 10)
  { 
     dd = "0" + dd;
  }
  
  if(reset==1)
  {
	  document.forms['search'].stday.value ="";
      document.forms['search'].edday.value ="";
  }else
  {
	  document.forms['search'].stday.value = yy+ "." + mm + "." +dd;
  }
  
  //document.forms['search'].stday.value = yy+ "-" + mm + "-" +dd;
} 

/*------------------------------------------------------
 * 주간 인기검색어, 월간 인기검색어
 * @param page : target string
-------------------------------------------------------*/
function viewFavoriteWList(target){
	var favoriteWArray=["검색","동아","중앙","경향","특수문자","법률","인기","홈페이지","이상","문서"]; // 대체 검색어
	var favoriteWresultnum=10;								  									  // 출력 건수
	var optionnullYN="N";																		  // "Y" 값이 없을 때, 대체 검색어 출력 , "N" 값이 없어도, 대체 검색어 출력 안함
	var cutstringnum=18;																		  // 검색어 길이 조정(한글 2, 영어 1)
	   
	$.ajax({
		type : "POST",
		url : "./include/favorite.jsp",
		dataType : "json",
		data: {"target_bestword":target},
		success : function(result){
			$.each(result, function(key){
				var list = result[key];
				                  
				var content = "";
				
				content += "<ol>";
				//<li><span>1</span><a href="#">인사발령</a></li>
				for(var i = 0; i < list.length; i++){
					content += "<li>";
					content += "<span>" + list[i].Rank + "</span>";
					content += "<a href=\"javascript:favoriteMyQuery(\'" + list[i].Key + "\');\">";

					var keytemp = list[i].Key;
					var keycount=0;
					if(keytemp!=null){
						for (var h = 0; h < keytemp.length; h++) {
							keycount += (keytemp.charCodeAt(h) > 128) ? 2 : 1;
							if (keycount > cutstringnum){
								keytemp=keytemp.substring(0,h)+"...";
								break;    
							}
						}
					}
					
					if(i == 0){
						content += keytemp + "</a></li>";
					}else{
						content += keytemp + "</a></li>";
					}
					//content +="<strong class='rankpoint'>"+Number(list[i].Rate).toFixed(1) + "%</strong>";
					//content += "</a>";
					//content += "</li>";
					  
					if(i == (favoriteWresultnum-1)){
						break;
					} 
				}
				if(optionnullYN=="Y")
				{
					for(var i = list.length; i < favoriteWresultnum; i++){
						content += "<li>";
						content += "<span>" + (i+1) + "</span>";
						content += "<a href=\"javascript:favoriteMyQuery(\'" + favoriteWArray[i] + "\');\">";
						
						if(i == 0){
							content += favoriteWArray[i] + "</a></li>";
						}else{
							content += favoriteWArray[i] + "</a></li>";
						}  
						//content +="<strong class='rankpoint'>0.1%</strong>";
						//content += "</a>";
						//content += "</li>";
					}
				}
				content += "</ol>";

				if(target=='weekly'){
					$("#ranklist1").html(content);
				}else if(target=='monthly'){
					$("#ranklist2").html(content);
				}
			});
		}
	});
} 

/*------------------------------------------------------
 * 실시간 인기검색어
-------------------------------------------------------*/
function viewFavoriteRList(){
	var favoriteRArray=["검색","동아","중앙","경향","특수문자","법률","인기","홈페이지","이상","문서"]; // 대체 검색어
	var favoriteRresultnum=5;								 									  // 출력 건수
	var optionnullYN="Y";																		  // "Y" 값이 없을 때, 대체 검색어 출력 , "N" 값이 없어도, 대체 검색어 출력 안함
	var cutstringnum=18;																		  // 검색어 길이 조정(한글 2, 영어 1)
	
	$.ajax({
		type : "POST",  
		url : "./include/favorite.jsp",
		dataType : "json",
		data: {"target_bestword":"realtime"},
		success : function(result){
			$.each(result, function(key){
				var list = result[key];
				var content = "";
				var img ="";

				content += "<ol>";
				
				for(var i = 0; i < list.length; i++){
					content += "<li>";
					content += "<a href=\"javascript:favoriteMyQuery(\'" + list[i].Key + "\');\">";
					content += "<em class='rank'>" + list[i].Rank + "</em>";
					
					var keytemp = list[i].Key;
					var keycount=0;
					if(keytemp!=null){
						for (var h = 0; h < keytemp.length; h++) {
							keycount += (keytemp.charCodeAt(h) > 128) ? 2 : 1;
							if (keycount > cutstringnum){
								keytemp=keytemp.substring(0,h)+"...";
								break;    
							}
						}
					}

					if(i == 0){
						content += "<strong class='text'><b>" + keytemp +"</b></strong>";
					}else{
						content += "<strong class='text'>" + keytemp + "</strong>";
					}
					
					if(list[i].Fluc>0){
						if(list[i].Fluc==10000){
							img="<img src='static/image/icon_realtimerank_new.gif'>";
						}else{
							img="<img src='static/image/icon_realtimerank_up.jpg'><span class='ranking_num'>"+list[i].Fluc+"</span>";
						}
					}else if(list[i].Fluc<0){
						img="<img src='static/image/icon_realtimerank_down.jpg'><span class='ranking_num'>"+(list[i].Fluc).replace("-","");+"</span>";
					}else{
						img="<img src='static/image/icon_realtimerank_none.gif'>";
					}
					content +=img;
					content += "</a>";
					content += "</li>";
					  
					if(i == (favoriteRresultnum-1)){
						break;
					} 
					
				}  
				
				if(optionnullYN=="Y")
				{
					for(var i = list.length; i < favoriteRresultnum; i++){
						content += "<li>";
						content += "<a href=\"javascript:favoriteMyQuery(\'" + favoriteRArray[i] + "\');\">";
						content += "<em class='rank'>" + (i+1) + "</em>";
						if(i == 0){
							content += "<strong class='text'><b>" + favoriteRArray[i] + "</b></strong>";
						}else{
							content += "<strong class='text'>" + favoriteRArray[i] + "</strong>";
						}
						img="<img src='static/image/icon_realtimerank_new.gif'>";
						content +=img;
						content += "</a>";
						content += "</li>";
					}
				}
				content += "</ol>";
				
				$("#realfavorite").html(content);
			});
		}
	});
} 

function date_mask(formd, textid) {

	/*
	input onkeyup에서
	formd == this.form.name
	textid == this.name
	*/
	   
	var form = eval("document."+formd);
	var text = eval("form."+textid);

	var textlength = text.value.length;

	if (textlength == 4) {
	text.value = text.value + ".";
	} else if (textlength == 7) {
	text.value = text.value + ".";
	} else if (textlength > 9) {
	//날짜 수동 입력 Validation 체크
	var chk_date = checkdate(text);

	if (chk_date == false) {
	return;
	}
	}
	}

	 
/*------------------------------------------------------
 * 날짜포맷
-------------------------------------------------------*/
	function checkdate(input) {
	   var validformat = /^\d{4}\.\d{2}\.\d{2}$/; //Basic check for format validity 
	   var returnval = false;
	   if (!validformat.test(input.value)) {
	    alert("날짜 형식이 올바르지 않습니다. YYYY.MM.DD");
	   } else { //Detailed check for valid date ranges 
	    var yearfield = input.value.split(".")[0];
	    var monthfield = input.value.split(".")[1];
	    var dayfield = input.value.split(".")[2];
	    var dayobj = new Date(yearfield, monthfield - 1, dayfield);
	   }
	   
	   if(dayobj!=null){
		   if ((dayobj.getMonth() + 1 != monthfield)
				     || (dayobj.getDate() != dayfield)
				     || (dayobj.getFullYear() != yearfield)) {
				    alert("날짜 형식이 올바르지 않습니다. YYYY.MM.DD");
			} else {
				    returnval = true;
			}
	   }else{
		   input.value="";
	   }
	   
	   if (returnval == false) {
	    input.select();
	   }
	   return returnval;
	  }

	function date_clean(name){
		 if(name=='startDate'){
			 document.search.startDate.value ="";
		 }
		 if(name=='endDate'){
			 document.search.endDate.value ="";
		 }
	}