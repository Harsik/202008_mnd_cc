package com.sfr.admin.controller;

import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRichTextString;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sfr.admin.service.AdminService;
import com.sfr.operator.service.OperatorService;

import egovframework.rte.psl.dataaccess.util.EgovMap;

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
			params.put("mildsc", "A");	//??????
		}
		if(deptCdArray.length > 1) {
			params.put("deptCd", deptCdArray[deptCdArray.length-1]);	//????????????
		}
		
		System.out.println("paramMap >> " + params);
		
		//?????????
		List<Map<String, Object>> data = userService.selectFacList(params);
        List<Map<String, String>> data2 = new ArrayList<Map<String, String>>();
        
        //CSV??? ?????? ????????? ??????
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
		mav.addObject("columnNames","???????????????,????????????,????????????,?????????,?????????");
		mav.addObject("csvFileNm","??????????????????");
        mav.addObject("excelDataList", data2);
        
        mav.setViewName("excelCsvWriteView");

        return mav;
	}
	
	private XSSFSheet hssfSheet;
	private XSSFRow hssfRow;
	private XSSFCell hssfCell;
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/blockIvrCsvDownload.do")
    private void excelDownload(Model model, XSSFWorkbook workbook, @RequestParam Map params,HttpServletRequest req, HttpServletResponse res) throws Exception {
        /*
         * ???????????? Json -> Object
         */
		System.out.println("/excelDownload.do >> ");
		ObjectMapper mapper = new ObjectMapper();
		String json = ((String) params.get("excelDown")).replaceAll("&quot;","\\\"");
		
		Map<String, String> pMap = mapper.readValue(json, Map.class);
//		System.out.println("excelDownload pMap >> " + pMap);

		String excelFileName = URLEncoder.encode((String) (pMap.get("title")), "utf-8"); // ??????????????????
        String title = URLDecoder.decode(excelFileName, "utf-8"); // ???????????? ???????????? ?????? ????????????

        // ?????????
        ArrayList<?> data = (ArrayList<Object>) operatorService.selectBlockIvrList(pMap);
        
        if (title == null || title.equals("") || pMap == null)
            return;

        // ???????????? ??????
        this.createExcel(workbook, pMap, data);
        // ?????? ????????????
        this.fileDownload(workbook, res, excelFileName);
    }
    
    
    @SuppressWarnings("unchecked")
    private void createExcel(Workbook workbook,@RequestParam Map param,ArrayList<?> data) throws UnsupportedEncodingException {
    	hssfSheet = null;
        hssfRow = null;
        hssfCell = null;
        int rowNum = 0;
        
        ArrayList<String> headerMap = (ArrayList<String>)param.get("colHeader");
        ArrayList<String> colMap = (ArrayList<String>)param.get("colName");
        String title = URLDecoder.decode(URLEncoder.encode((String)(param.get("title")), "utf-8"), "utf-8");
        
        try 
		{
        
	        //?????? ??????
	        hssfSheet = (XSSFSheet) workbook.createSheet(title);

	        hssfRow = hssfSheet.createRow(rowNum);
	     	for(int i = 0; i < colMap.size(); i++)
			{
				hssfCell = hssfRow.createCell(i);
				hssfCell.setCellValue(new XSSFRichTextString(colMap.get(i)));
			}
	     	
	     	// data ??????
	     	for(int i = 0; i < data.size(); i++)
	     	{	
	     		hssfRow = hssfSheet.createRow(++rowNum);
	     		
	     		EgovMap rowData = (EgovMap)data.get(i);
	     		//HashMap<String, Object> rowData = (HashMap<String, Object>)data.get(i);
	     		for(int j = 0; j < headerMap.size(); j++)
	     		{
	     			String tmp = String.valueOf(rowData.get(headerMap.get(j)));
	     			
	     			if (tmp == "null") {
	     			    tmp = "";
	     			}
	     			
	     			hssfCell = hssfRow.createCell(j);
	     			hssfCell.setCellValue(new XSSFRichTextString(tmp));
	     		}
	     	}
     	
     	
		} catch(ArrayIndexOutOfBoundsException e) {
		    System.out.println("?????? ?????? ?????? ??????");
		}
		catch(Exception e) {
		    System.out.println(e.getMessage());
		}
    }
    
    private void fileDownload(Workbook workbook, HttpServletResponse response, String ps_file) throws IOException {
        OutputStream out = null;
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd");
        String date = simpleDateFormat.format(new Date());
        try {
            response.setContentType("Application/Msexcel");
			response.setHeader("Content-Disposition", "attachment; filename=\"" + ps_file + "_" + date + ".xlsx\";");
			response.setContentType("application/vnd.ms-excel");
            
            out = new BufferedOutputStream(response.getOutputStream());
            workbook.write(out);
            out.flush();
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            if(out != null) out.close();
        }
    }
    
}
