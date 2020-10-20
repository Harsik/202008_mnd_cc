<%@ page pageEncoding="UTF-8"%>
  	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" >	
	<meta http-equiv="Content-Script-Type" content="text/javascript" >
	<meta http-equiv="Content-Style-Type" content="text/css" >
	<meta http-equiv="X-UA-Compatible" content="IE=edge" >
	<title>:::통합검색:::</title>
	<!-- <link href="../css/style.css" rel="stylesheet" type="text/css" > --> 
	<link href="../css/board.css" rel="stylesheet" type="text/css" >  
	<link href="../css/common.css" rel="stylesheet" type="text/css" >  
	<LINK REL="SHORTCUT ICON" TYPE="image/x-icon" HREF ="#none" >
	<script type="text/javascript" src="../js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="../js/search.js"></script>	<!-- 검색관련 자바스크립트 -->		  
  	
  	<!-- 달력 자바스크립트 -->
  	<script type="text/javascript" src="../js/select.js"></script>
 
<script type="text/javascript">
		$(document).ready(function(){
			
			exampleSelect_1 = new cf_select('#exampleSelect1');
			exampleSelect_1.ready();

			exampleSelect_2 = new cf_select('#exampleSelect2');
			exampleSelect_2.ready();

			exampleSelect_2 = new cf_select('#exampleSelect3');
			exampleSelect_2.ready();

			exampleSelect_2 = new cf_select('#exampleSelect4');
			exampleSelect_2.ready();

			searchSelect = new cf_select('#searchSelect');
			searchSelect.ready();

			$('#searchAcBtn').click(function(){
			var btnStatus = $(this).hasClass('up');
			if(btnStatus){
				$(this).removeClass('up');
				$(this).addClass('down');
				//$('.searchAccordion').css('height','2px');
				$('.searchAccordionLayer').slideUp('slow');           
			}else{
				$(this).addClass('up');
				$(this).removeClass('down');
				//$('.searchAccordion').css('height','76px');
				$('.searchAccordionLayer').slideDown('slow');   
			}
		});
	
        });
    </script>