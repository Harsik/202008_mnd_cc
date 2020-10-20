<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />	
	<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />	
	<meta name="keywords" content="전화번호 통합검색체계" />
	<meta name="description" content="국방부,육군,공군,해군 전화번호 통합검색체계" />
	
    <title>전화번호 통합검색체계</title>

  <link rel="stylesheet" href="../css/layout.css" />
  <link rel="stylesheet" href="../css/common.css" />
  <link rel="stylesheet" href="../css/fonts.css" />
  <link rel="stylesheet" href="../js/lib/jquery-ui-custom/jquery-ui.css" type="text/css"/>
 
  <script type="text/javascript" src="../js/jquery-1.7.1.min.js"></script> 	
  <script type="text/javascript" src="../js/jquery.bpopup.min.js"></script>
  <script type="text/javascript" src="../js/lib/jquery-ui-custom/jquery-ui.js"></script>
  <script type="text/javascript" src="../js/ws_cti.js"></script>
  <script type="text/javascript" src="../js/ws_controller.js"></script>
  <script type="text/javascript" src="../js/common.js"></script>

  
</head>


<body>
	<tiles:insertAttribute name="operator_header" />
	
	<tiles:insertAttribute name="operator_content" />

	<tiles:insertAttribute name="operator_footer" />
</body>
</html>