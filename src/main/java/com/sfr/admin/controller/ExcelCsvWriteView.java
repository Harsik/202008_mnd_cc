package com.sfr.admin.controller;

import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Repository;
import org.springframework.web.servlet.view.AbstractView;
import org.supercsv.io.CsvMapWriter;
import org.supercsv.io.ICsvMapWriter;
import org.supercsv.prefs.CsvPreference;

@Repository("excelCsvWriteView")
public class ExcelCsvWriteView extends AbstractView {
	@Override
    protected void renderMergedOutputModel(Map<String, Object> modelMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
        response.setContentType("text/csv; charset=MS949");
        
        SimpleDateFormat dateFormat = new SimpleDateFormat ( "yyyyMMdd_HHmmss");
        Date date = new Date();
        
        String csvFileName = URLEncoder.encode("시설물명현황_" + dateFormat.format(date) + ".csv", "utf-8");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + csvFileName +  "\"");
        
        excelDataPurification(modelMap, request, response);
    }
 
    /**
     * 엑셀 데이터 리스트 정제 
     *
     * @param model
     * @param wb
     * @param req
     * @param resp
     * @throws Exception
     */
    protected void excelDataPurification(Map<String, Object> modelMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	// Map 을 사용한다면 CsvMapWriter 사용
        ICsvMapWriter csvMapWriter = new CsvMapWriter(response.getWriter(), CsvPreference.STANDARD_PREFERENCE);
 
        // VO 를 사용한다면 CsvBeanWriter 사용
        //        ICsvBeanWriter csvBeanWriter = new CsvBeanWriter(response.getWriter(), CsvPreference.STANDARD_PREFERENCE);
 
        String columnIds = (String) modelMap.get("columnIds");
        String columnNames = (String) modelMap.get("columnNames");
        String[] colids = columnIds.split(",");
        String[] colnms = columnNames.split(",");
 
        // 엑셀 데이터
        List<Map<String, Object>> excelDataList = (List<Map<String, Object>>) modelMap.get("excelDataList");
 
        csvMapWriter.writeHeader(colnms);
        
        for (int i = 0; i < excelDataList.size(); i++) {
                Map<String, Object> rowData = (Map<String, Object>) excelDataList.get(i);
                csvMapWriter.write(rowData, colids);
        }
        
        csvMapWriter.close();
    }


}