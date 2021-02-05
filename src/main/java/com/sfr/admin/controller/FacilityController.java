package com.sfr.admin.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.sfr.admin.service.AdminService;
import com.sfr.common.FileDownloadView;
import com.sfr.common.PagerVO;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestMapping("/admin")
public class FacilityController {



	@Autowired
	private AdminService userService;
	
	
	/**
	 * 시설물 리스트
	 * @return
	 */
	@RequestMapping(value="/facilityList.do", method={RequestMethod.POST})
	public String facilityList(@RequestParam Map paramMap, ModelMap model, HttpServletRequest request, @ModelAttribute("searchVO") PagerVO vo ) throws Exception {
		
		
		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(vo.getCurrentPage()); //현재 페이지 번호
		paginationInfo.setRecordCountPerPage(vo.getRecordCountPerPage());
		paginationInfo.setPageSize(vo.getPageSize());
		
		vo.setFirstIndex(paginationInfo.getFirstRecordIndex());
		vo.setLastIndex(paginationInfo.getLastRecordIndex());
		vo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		paramMap.put("firstIndex", paginationInfo.getFirstRecordIndex());
		paramMap.put("lastIndex", paginationInfo.getLastRecordIndex());
		paramMap.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());
		
		
		paramMap.put("regId", request.getSession().getAttribute("user_id"));
		paramMap.put("auth", request.getSession().getAttribute("auth"));
		
		
		
		List<Map> list =  userService.selectFacList(paramMap);
		int cnt = userService.getFacCount(paramMap);
		
		paginationInfo.setTotalRecordCount(cnt);
		
		model.addAttribute("list", list);
		model.addAttribute("cnt", cnt);
		model.addAttribute("paramMap", paramMap);
        model.addAttribute("paginationInfo", paginationInfo);
		
        
		return "admin/facility/facilityList.admin";
	}		

	@RequestMapping(value = "/facilityWrite.do", method={RequestMethod.GET})
	public String facilityWrite(@RequestParam Map paramMap, ModelMap model, HttpServletRequest request) throws Exception {
		
		HttpSession session  = request.getSession();
		
		String mildsc = "A";	// 기본 국방부 코드
		if(null != session.getAttribute("mildsc") && !session.getAttribute("mildsc").equals("")) {
			mildsc = session.getAttribute("mildsc").toString();
		}
		String[] deptCdArray = session.getAttribute("fullDeptCd").toString().split("\\^");
		
		List subDeptList = new ArrayList();
		List subDeptNmList = new ArrayList();
		
		// 1. 현재 사용자의 최상위 부서 코드에 맞는 하위부서 목록 호출
		paramMap.put("mildsc", mildsc);

		// 1-1. 국방부/합참 분리 기능 추가
		String mdcdFlg = "";
		if(mildsc.equals("A") && deptCdArray.length > 1) {
			if(deptCdArray[deptCdArray.length-1].equals("1290451")){
				mdcdFlg = "Y";	//합참
			}else{
				Map tempParam = new HashMap();
				tempParam.put("mildsc", mildsc);
				tempParam.put("deptCd", deptCdArray[1]); 
				// 두번째 군코드로 역추적
				Map tempTop = userService.selectDeptTopNm(tempParam);					
				if(tempTop.get("deptCd").equals("1290451")){ 
					mdcdFlg = "Y";	//합참
				}
			}			
		}		
		paramMap.put("mdcdFlg", mdcdFlg);		
		List deptTopList = new ArrayList();
		if(mdcdFlg.equals("Y")) {
			paramMap.put("hgrnkDeptCd", "1290451");
			deptTopList = userService.selectDeptList(paramMap);
		}else {
			deptTopList = userService.selectDeptTopList(paramMap);			
		}
		subDeptList.add(deptTopList);

		if(deptCdArray.length > 1) {
			paramMap.put("deptCd", deptCdArray[1]);
			Map temp1 = userService.selectDeptNm(paramMap);			
			subDeptNmList.add(temp1);
		
			if(deptCdArray.length > 2) {
				
				// 2. 일반 사용자의 하위 부서만큼  하위부서 목록 호출
				for(int i=2;i<deptCdArray.length;i++){
					
					paramMap.put("deptCd", deptCdArray[i]);
					paramMap.put("hgrnkDeptCd", deptCdArray[i-1]);
					
					Map temp = userService.selectDeptNm(paramMap);
					List subDeptListTemp = userService.selectDeptList(paramMap);
					
					subDeptNmList.add(temp);
					subDeptList.add(subDeptListTemp);
				}
			}

			// 3. 합참 자체일경우 호출제외
			if(!deptCdArray[deptCdArray.length-1].equals("1290451")){
				paramMap.put("hgrnkDeptCd", deptCdArray[deptCdArray.length-1]);
				List subDeptListTemp = userService.selectDeptList(paramMap);
				subDeptList.add(subDeptListTemp);
			}
		}
		
		
		model.addAttribute("subDeptNmList", subDeptNmList);
		model.addAttribute("subDeptList", subDeptList);
		model.addAttribute("mildsc",mildsc);
		model.addAttribute("mdcdFlg",mdcdFlg);
		
		
		return "admin/facility/facilityWrite.admin";
	}		
	
	/*@RequestMapping(value = "/getFacility.do", method={RequestMethod.POST})
	public @ResponseBody List getFacility(@RequestParam Map paramMap, ModelMap model, HttpServletRequest request) throws Exception {
		
		HttpSession session  = request.getSession();
		
		String mildsc = session.getAttribute("mildsc").toString();
		
		//paramMap.put("hgrnkDeptCd", deptCdArray[deptCdArray.length-1]);
		paramMap.put("mildsc", mildsc);
		
		List deptList = userService.selectDeptList(paramMap);
		
		
		return deptList;
	}	*/
	@RequestMapping(value = "/getFacility.do", method={RequestMethod.POST})
	public @ResponseBody List getFacility(@RequestParam Map paramMap, ModelMap model, HttpServletRequest request) throws Exception {
		
		List deptList = userService.selectDeptList(paramMap);
		
		return deptList;
	}	
	@RequestMapping(value = "/getFacilityTop.do", method={RequestMethod.POST})
	public @ResponseBody List getFacilityTop(@RequestParam Map paramMap, ModelMap model, HttpServletRequest request) throws Exception {
		
		List deptTopList = new ArrayList();
		
		String mdcd = paramMap.get("mildsc").toString();
		if(mdcd.equals("1290451")) {
			paramMap.put("mildsc", "A");
			paramMap.put("hgrnkDeptCd", "1290451");			
			deptTopList = userService.selectDeptList(paramMap);	
		}
		else {
			deptTopList = userService.selectDeptTopList(paramMap);			
		}
		
		return deptTopList;
	}	
	
	
	
	@RequestMapping(value = "/doFacWrite.do", method={RequestMethod.POST})
	public @ResponseBody Map  doFacWrite(@RequestParam Map paramMap, ModelMap model, HttpServletRequest request) throws Exception {
		
		HttpSession session  = request.getSession();
		
		Map rtnMap = new HashMap();
				
		String [] deptCd = request.getParameterValues("deptCd");
		
		String fullDeptCd = paramMap.get("mildsc").toString();
		
		//합참 별도처리 start
		if(fullDeptCd.equals("1290451")) {
			fullDeptCd = "A";
			if(deptCd.length == 1 && deptCd[0].equals("")) {
				fullDeptCd += "^1290451";		
			}
		}
		//합참 별도처리 end
		
		for (String temp : deptCd){
			if(!"".equals(temp)){
				fullDeptCd += "^"+temp;
			}
		}

    	//군)xxx-xxxx형식 변환, 콤마 이후는 일)xxx-xxxx형식으로 변환
    	String telStr = request.getParameter("tel");
    	String tels[] = telStr.split(",");

    	telStr = "";
    	int telCnt = 0;
		for (String tel : tels){
			
			int telLen = tel.length();
			/*if(tel.indexOf("02") == 0 && telLen > 2) {
				tel =  tel.substring(0,2) + "-" + tel.substring(2);
			}else if(telLen > 3) {
				tel =  tel.substring(0,3) + "-" + tel.substring(3);
			}
			
			if(telCnt==0) {
				telStr = "군)" + tel;
			}else{
				telStr = telStr + ",일)" + tel;				
			}*/			
			if(telCnt==0) {
				if(telLen > 3) {
					tel =  tel.substring(0,3) + "-" + tel.substring(3);
				}
				telStr = "군)" + tel;
			}else{
				if(tel.indexOf("02") == 0 && telLen > 2) {
					tel =  tel.substring(0,2) + "-" + tel.substring(2);
				}else if(telLen > 3) {
					tel =  tel.substring(0,3) + "-" + tel.substring(3);
				}		
				telLen = tel.length();		
				if(telLen > 7){
					tel =  tel.substring(0,telLen-4) + "-" + tel.substring(telLen-4);					
				}
				telStr = telStr + ",일)" + tel;				
			}
			telCnt++;
		}
		
    	paramMap.put("tel",telStr);    	
		paramMap.put("deptCd", fullDeptCd.substring(fullDeptCd.lastIndexOf("^")+1));
		paramMap.put("regId", session.getAttribute("user_id").toString());
		paramMap.put("regMildsc", session.getAttribute("mildsc").toString());
		paramMap.put("regIp", request.getRemoteAddr());
		paramMap.put("fullDeptCd", fullDeptCd);  
		
		userService.insertFac(paramMap);
		
		
		
		
		return rtnMap;
	}	
	
	

	@RequestMapping(value = "/doFacWriteExcel.do", method={RequestMethod.POST})
	public @ResponseBody Map  doFacWriteExcel(@RequestParam Map paramMap, ModelMap model, HttpServletRequest request) throws Exception {
		
		HttpSession session  = request.getSession();
		
		Map rtnMap = new HashMap();

		String [] deptCd = request.getParameterValues("deptCd");
		
		//System.out.println("1111====Excel to DB Insert====");
		
		//String fullDeptCd = paramMap.get("mildsc").toString();
		String fullDeptCd = request.getParameter("mildsc").toString();
		
		//합참 별도처리 start
		if(fullDeptCd.equals("1290451")) {
			fullDeptCd = "A";
			if(deptCd.length == 1 && deptCd[0].equals("")) {
				fullDeptCd += "^1290451";		
			}
		}
		//합참 별도처리 end
		
		//System.out.println("222====Excel to DB Insert====");
		
		for (String temp : deptCd){
			if(!"".equals(temp)){
				fullDeptCd += "^"+temp;
			}
		}
		
		
		//System.out.println("333====Excel to DB Insert====");
		
		
		List<Map> list = new ArrayList();
		
		MultipartHttpServletRequest mReg = (MultipartHttpServletRequest) request;
		
		//System.out.println("444====Excel to DB Insert====");
		
		
		CommonsMultipartFile file = (CommonsMultipartFile) mReg.getFile("file");
		
		
		//System.out.println("555====Excel to DB Insert====");
		
		FileOutputStream outputStream = null;
		
		try {
			
		
		
		//save & load location
		//String filePath = System.getProperty("java.io.tmpdir") + file.getOriginalFilename();
//		String filePath = "/app/src/webapps/sfr_prj.war/tmp/" + file.getOriginalFilename();
		
		// 21.01.25 경로 확인 --> app에 jboss만 들어가있음. 경로 바뀜
		String filePath = "/data/src/sfr_prj.war/tmp/" + file.getOriginalFilename();
		
		//System.out.println("666====Excel to DB Insert===="+filePath);
		//save
		outputStream = new FileOutputStream(new File(filePath));
		outputStream.write(file.getFileItem().get());
			
		//load
        FileInputStream fis = new FileInputStream(new File(filePath));
		
        //System.out.println("777====Excel to DB Insert====");
        
        // 21.02.05 기존 XSSF로 xlsx파일만 가능했던 부분 xls도 가능하게 변경
        Workbook workbook = WorkbookFactory.create(fis);
        Sheet sheet = workbook.getSheetAt(0);

        //System.out.println("888====Excel to DB Insert====");
        
        Iterator<Row> rowIterator = sheet.iterator();
        
        HashMap<String,String> map = new HashMap<String,String>();
        
        while (rowIterator.hasNext())
        {
        	Row row = (Row) rowIterator.next();
            //System.out.println(row.getRowNum());
            
            //System.out.println("====Excel to DB Insert====");
            
            if(row.getRowNum()<=1){
            	
            }else{
            	
            	Map temp = new HashMap();
            	temp.put("facilityNm",celltoString(row.getCell(1)));

            	//군)xxx-xxxx형식 변환, 콤마 이후는 일)xxx-xxxx형식으로 변환
            	String telStr = celltoString(row.getCell(2));
            	String tels[] = telStr.split(",");

            	telStr = "";
            	int telCnt = 0;
        		for (String tel : tels){
        			
        			int telLen = tel.length();
        			/*if(tel.indexOf("02") == 0 && telLen > 2) {
        				tel =  tel.substring(0,2) + "-" + tel.substring(2);
        			}else if(telLen > 3) {
        				tel =  tel.substring(0,3) + "-" + tel.substring(3);
        			}
        			
        			if(telCnt==0) {
        				telStr = "군)" + tel;
        			}else{
        				telStr = telStr + ",일)" + tel;				
        			}*/	
        			if(telCnt==0) {
        				if(telLen > 3) {
        					tel =  tel.substring(0,3) + "-" + tel.substring(3);
        				}
        				telStr = "군)" + tel;
        			}else{
        				if(tel.indexOf("02") == 0 && telLen > 2) {
        					tel =  tel.substring(0,2) + "-" + tel.substring(2);
        				}else if(telLen > 3) {
        					tel =  tel.substring(0,3) + "-" + tel.substring(3);
        				}		
        				telLen = tel.length();		
        				if(telLen > 7){
        					tel =  tel.substring(0,telLen-4) + "-" + tel.substring(telLen-4);					
        				}
        				telStr = telStr + ",일)" + tel;				
        			}
        			telCnt++;
        		}
            	temp.put("tel",telStr);
            	
            	//System.out.print(celltoString(row.getCell(1))+"\t");
            	//System.out.println(celltoString(row.getCell(2)));
            	
            	list.add(temp);
            }
        }
        fis.close();
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
        paramMap.put("deptCd", fullDeptCd.substring(fullDeptCd.lastIndexOf("^")+1));
		paramMap.put("regId", session.getAttribute("user_id").toString());
		paramMap.put("regMildsc", session.getAttribute("mildsc").toString());
		paramMap.put("regIp", request.getRemoteAddr());
		paramMap.put("fullDeptCd", fullDeptCd);
		
        for(int i=0;i<list.size();i++){
        	paramMap.put("facilityNm",list.get(i).get("facilityNm"));
        	paramMap.put("tel",list.get(i).get("tel"));
        	
    		userService.insertFac(paramMap);
    		
        }
        
		return rtnMap;
	}	
	
	
	public String celltoString(Cell cell){
		String str="";
		
		if(cell.getCellType()==Cell.CELL_TYPE_STRING){
			return cell.getStringCellValue();
		}else if(cell.getCellType()==Cell.CELL_TYPE_NUMERIC){
			return String.valueOf((int)cell.getNumericCellValue());
		}
		
		
		return str;
	}
	

	/**
	 * 시설물 상세화면
	 * @return
	 */
	@RequestMapping("/facilityModify.do")
	public String facilityModify(@RequestParam Map paramMap, ModelMap model, HttpServletRequest request) throws Exception{
		
		Map map =  userService.selectFacDetail(paramMap);
		
		String telStr = map.get("tel").toString();
		telStr = telStr.replaceAll("군\\)", "");
		telStr = telStr.replaceAll("-", "");
		telStr = telStr.replaceAll("일\\)", "");
		map.put("tel", telStr);
		
		// 군 부서 수정 가능하도록 추가
		String mildsc = map.get("mildsc").toString();
		String[] deptCdArray = null;
		deptCdArray = 	map.get("fullDeptCd").toString().split("\\^");
		paramMap.put("hgrnkDeptCd", map.get("deptCd").toString());

		List subDeptList = new ArrayList();
		List supDeptNmList = new ArrayList();

		// 1. 현재 사용자의 최상위 부서 코드에 맞는 하위부서 목록 호출
		paramMap.put("mildsc", mildsc);

		// 1-1. 국방부/합참 분리 기능 추가
		String mdcdFlg = "";
		if(mildsc.equals("A") && deptCdArray.length > 1) {
			if(deptCdArray[deptCdArray.length-1].equals("1290451")){
				mdcdFlg = "Y";	//합참
			}else{
				Map tempParam = new HashMap();
				tempParam.put("mildsc", mildsc);
				tempParam.put("deptCd", deptCdArray[1]); 
				// 두번째 군코드로 역추적
				Map tempTop = userService.selectDeptTopNm(tempParam);					
				if(tempTop.get("deptCd").equals("1290451")){ 
					mdcdFlg = "Y";	//합참
				}
			}			
		}		
		paramMap.put("mdcdFlg", mdcdFlg);	
		
		List deptTopList = new ArrayList();
		if(mdcdFlg.equals("Y")) {
			paramMap.put("hgrnkDeptCd", "1290451");
			deptTopList = userService.selectDeptList(paramMap);
		}else {
			deptTopList = userService.selectDeptTopList(paramMap);			
		}
		subDeptList.add(deptTopList);
		
		if(deptCdArray.length > 1) {
			paramMap.put("deptCd", deptCdArray[1]);
			Map temp1 = userService.selectDeptNm(paramMap);
			supDeptNmList.add(temp1);

			if(deptCdArray.length > 2) {

				// 2. 일반 사용자의 하위 부서만큼  하위부서 목록 호출
				for(int i=2;i<deptCdArray.length;i++){
					
					paramMap.put("deptCd", deptCdArray[i]);
					paramMap.put("hgrnkDeptCd", deptCdArray[i-1]);
					
					Map temp = userService.selectDeptNm(paramMap);
					List subDeptListTemp = userService.selectDeptList(paramMap);
					
					supDeptNmList.add(temp);
					subDeptList.add(subDeptListTemp);
				}
			}

			// 3. 합참 자체일경우 호출제외
			if(!deptCdArray[deptCdArray.length-1].equals("1290451")){
				paramMap.put("hgrnkDeptCd", deptCdArray[deptCdArray.length-1]);
				List subDeptListTemp = userService.selectDeptList(paramMap);
				subDeptList.add(subDeptListTemp);
			}
		}
		
		model.addAttribute("data",map);
		model.addAttribute("paramMap",paramMap);
		model.addAttribute("deptNmList", supDeptNmList);
		model.addAttribute("deptList", subDeptList);
		model.addAttribute("mildsc",mildsc);
		model.addAttribute("mdcdFlg",mdcdFlg);
		
		return "admin/facility/facilityModify.admin";
		
	}	
	@RequestMapping(value = "/doFacModify.do", method={RequestMethod.POST})
	public @ResponseBody Map  doFacModify(@RequestParam Map paramMap, ModelMap model, HttpServletRequest request) throws Exception {
		
		HttpSession session  = request.getSession();
		
		Map rtnMap = new HashMap();
						

    	//군)xxx-xxxx형식 변환, 콤마 이후는 일)xxx-xxxx형식으로 변환
    	String telStr = request.getParameter("tel");
    	String tels[] = telStr.split(",");

    	telStr = "";
    	int telCnt = 0;
		for (String tel : tels){
			
			int telLen = tel.length();
			/*if(tel.indexOf("02") == 0 && telLen > 2) {
				tel =  tel.substring(0,2) + "-" + tel.substring(2);
			}else if(telLen > 3) {
				tel =  tel.substring(0,3) + "-" + tel.substring(3);
			}
			
			if(telCnt==0) {
				telStr = "군)" + tel;
			}else{
				telStr = telStr + ",일)" + tel;				
			}*/		
			if(telCnt==0) {
				if(telLen > 3) {
					tel =  tel.substring(0,3) + "-" + tel.substring(3);
				}
				telStr = "군)" + tel;
			}else{
				if(tel.indexOf("02") == 0 && telLen > 2) {
					tel =  tel.substring(0,2) + "-" + tel.substring(2);
				}else if(telLen > 3) {
					tel =  tel.substring(0,3) + "-" + tel.substring(3);
				}		
				telLen = tel.length();		
				if(telLen > 7){
					tel =  tel.substring(0,telLen-4) + "-" + tel.substring(telLen-4);					
				}
				telStr = telStr + ",일)" + tel;				
			}
			telCnt++;
		}
		
		// 군부서코드
		String [] deptCd = request.getParameterValues("deptCd");
		
		String fullDeptCd = paramMap.get("mildsc").toString();

		//합참 별도처리 start
		if(fullDeptCd.equals("1290451")) {
			fullDeptCd = "A";
			if(deptCd.length == 1 && deptCd[0].equals("")) {
				fullDeptCd += "^1290451";		
			}
		}
		//합참 별도처리 end
		
		for (String temp : deptCd){
			if(!"".equals(temp)){
				fullDeptCd += "^"+temp;
			}
		}

		
    	paramMap.put("tel",telStr);		
		paramMap.put("uptId", session.getAttribute("user_id").toString());
		paramMap.put("uptMildsc", session.getAttribute("mildsc").toString());
		paramMap.put("uptIp", request.getRemoteAddr());
		paramMap.put("deptCd", fullDeptCd.substring(fullDeptCd.lastIndexOf("^")+1));
		paramMap.put("fullDeptCd", fullDeptCd); 
		
		userService.updateFac(paramMap);
		
		
		return rtnMap;
	}	
	
	
	
	@RequestMapping(value = "/templeteDownload.do", method={RequestMethod.GET})
	public ModelAndView  templeteDownload(@RequestParam Map paramMap, ModelMap model, HttpServletRequest request) throws Exception {
		
		String filepath = request.getSession().getServletContext().getRealPath("/")+"/WEB-INF/jsp/admin/facility/templete.xlsx";
		File file = new File(filepath);
		
		model.addAttribute("fileName", "templete.xlsx");
		model.addAttribute("downloadFile", file);
		
		return new ModelAndView(new FileDownloadView());
	}
	
	
	
	@RequestMapping("/facilityDelete.do")
	public @ResponseBody Map  facilityDelete(@RequestParam Map paramMap, ModelMap model, HttpServletRequest request) throws Exception {
		
		HttpSession session  = request.getSession();
		
		Map rtnMap = new HashMap();
		
		paramMap.put("regId", session.getAttribute("user_id").toString());
		
		userService.deleteFac(paramMap);
		
		return rtnMap;
	}	
	@RequestMapping("/facilityChkBoxDelete.do")
	public @ResponseBody Map  facilityChkBoxDelete(@RequestParam Map paramMap, ModelMap model, HttpServletRequest request) throws Exception {
		
		HttpSession session  = request.getSession();
		
		Map rtnMap = new HashMap();
		
		paramMap.put("regId", session.getAttribute("user_id").toString());

		String checkRow = paramMap.get("checkRow").toString();		
		String[] arrIdx = checkRow.split(",");
		
		for (int i=0; i<arrIdx.length; i++) {
		    paramMap.put("seq", arrIdx[i]);
			userService.deleteFac(paramMap);
		}
		
		return rtnMap;
	}	
	
}

