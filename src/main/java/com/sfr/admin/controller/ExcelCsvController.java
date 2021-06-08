package com.sfr.admin.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sfr.admin.service.AdminService;
import com.sfr.operator.service.OperatorService;

@Controller
@RequestMapping("/csv")
public class ExcelCsvController {
	
	@Autowired
	private AdminService userService;
	
	@Autowired
	private OperatorService operatorService;
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/csvDownload.do")
	public ModelAndView facilityCsvDownload(HttpServletRequest request, HttpServletResponse response,@RequestParam Map params) throws Exception {
		System.out.println(">> csvDownload");
		ModelAndView mav = new ModelAndView("CsvDownloadView");
		
		String[] deptCdArray = null;
		deptCdArray = 	params.get("searchCd").toString().split("\\^");
		
		String mildsc = deptCdArray[0];
		
		params.put("regId", request.getSession().getAttribute("user_id"));
		params.put("auth", request.getSession().getAttribute("auth"));
		
		if(mildsc.equals("1290451")) {
			params.put("mildsc", "A");	//합참
		}
		if(deptCdArray.length > 1) {
			params.put("deptCd", deptCdArray[deptCdArray.length-1]);	//부서코드
		}
		
		System.out.println("paramMap >> " + params);
		
		//데이터
		List<Map<String, Object>> data = userService.selectFacList(params);
        List<Map<String, String>> data2 = new ArrayList<Map<String, String>>();
        
        //CSV에 넣을 데이터 추출
        for(int i=0; i<data.size(); i++) {
            Map<String, String> dataMap = new HashMap<String, String>();
            
            dataMap.put("facilityNm"    ,(String) data.get(i).get("facilityNm") );
            dataMap.put("fullDeptNm",(String)data.get(i).get("fullDeptNm") );
            dataMap.put("tel"      ,(String)data.get(i).get("tel") );
            dataMap.put("regId"       ,(String)data.get(i).get("regId") );
            dataMap.put("regDt"       ,(String)data.get(i).get("regDt") );
            
            data2.add(dataMap);
        }
        
		mav.addObject("columnIds","facilityNm,fullDeptNm,tel,regId,regDt");
		mav.addObject("columnNames","시설물이름,등록부대,전화번호,등록자,등록일");
		mav.addObject("csvFileNm","시설물명현황");
        mav.addObject("excelDataList", data2);
        
        mav.setViewName("excelCsvWriteView");

        return mav;
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/blockIvrCsvDownload.do")
	public ModelAndView blockIvrCsvDownload(HttpServletRequest request, HttpServletResponse response,@RequestParam Map params) throws Exception {
		System.out.println(">> blockIvrCsvDownload");
		ModelAndView mav = new ModelAndView("CsvDownloadView");
		
		System.out.println("paramMap >> " + params);
		//데이터
		List<Map<String, Object>> data = operatorService.selectBlockIvrList(params);
        List<Map<String, String>> data2 = new ArrayList<Map<String, String>>();
        
        System.out.println("data >> "+data);
        
        //CSV에 넣을 데이터 추출
        for(int i=0; i<data.size(); i++) {
            Map<String, String> dataMap = new HashMap<String, String>();
            
            dataMap.put("rownum"    , NVL( data.get(i).get("rownum") ) );
            dataMap.put("type"		, NVL( data.get(i).get("type") ) );
            dataMap.put("fulnm"     , NVL( data.get(i).get("fulnm") ) );
            dataMap.put("servno"    , NVL( data.get(i).get("servno") ) );
            dataMap.put("fullDeptNm", NVL( data.get(i).get("fullDeptNm") ) );
            dataMap.put("rankNm"    , NVL( data.get(i).get("rankNm") ) );
            dataMap.put("ani"       , NVL( data.get(i).get("ani") ) );
            dataMap.put("telno"     , NVL( data.get(i).get("telno") ) );
            dataMap.put("callDttm"  , NVL( data.get(i).get("callDttm") ) );
            dataMap.put("rgstDttm"  , NVL( data.get(i).get("rgstDttm") ) );
            dataMap.put("rgstId"    , NVL( data.get(i).get("rgstId") ) );
            
            data2.add(dataMap);
        }
        
		mav.addObject("columnIds","rownum,type,fulnm,servno,fullDeptNm,rankNm,ani,telno,callDttm,rgstDttm,rgstId");
		mav.addObject("columnNames","번호,유형,이름,군번,부대,계급,인입번호,군전화번호,인입시간,송출시간,교환원");
		mav.addObject("csvFileNm","악성민원 송출조회");
        mav.addObject("excelDataList", data2);
        
        mav.setViewName("excelCsvWriteView");

        return mav;
	}
	
	
	/**
      * NULL 값을 제거한다. 입력값(text)이 NULL이이면 공백("")을 리턴한다.
      * @param text NULL을 제거할 입력값
      * @return NULL을 제거한 값
      */
    public static String NVL(Object text) {
        if(text == null) {
         return "";
        } else {
         return "\t"+text.toString();
        
        }
    }
}
