package com.sfr.admin.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sfr.admin.service.AdminService;
import com.sfr.common.PagerVO;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestMapping("/admin")
public class AdminMainController {

	private Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private AdminService userService;



	/**
	 * 슈퍼관리자 메인
	 * @return
	 */
	@RequestMapping("/superMain.do")
	public String superMain(@RequestParam Map paramMap, ModelMap model, HttpServletRequest requset, @ModelAttribute("searchVO") PagerVO vo ) throws Exception {
		
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
		
		
		//paramMap.put("mildsc" , "A");
		
		
		List<Map> list =  userService.selectUserList(paramMap);
		int cnt = userService.getUserCount(paramMap);
		
		paginationInfo.setTotalRecordCount(cnt);
		
		model.addAttribute("list", list);
		model.addAttribute("cnt", cnt);
		model.addAttribute("paramMap", paramMap);
        model.addAttribute("paginationInfo", paginationInfo);
        
        
		return "admin/user/userList.admin";
	}
	
	
	
	
	

	
	
	
	/**
	 * 일반관리자 메인
	 * @return
	 */
	@RequestMapping("/main.do")
	public String main(@RequestParam Map paramMap, ModelMap model, HttpServletRequest requset, @ModelAttribute("searchVO") PagerVO vo ) throws Exception {
		System.out.println("paramMap >>> "+paramMap);
		if(!paramMap.isEmpty()) {
			String mildsc = paramMap.get("mildsc").toString();
			String[] deptCdArray = null;
			deptCdArray = 	paramMap.get("fullDeptCd").toString().split("\\^");

			List subDeptList = new ArrayList();
			List supDeptNmList = new ArrayList();
			// 1. 현재 사용자의 최상위 부서 코드에 맞는 하위부서 목록 호출
			paramMap.put("mildsc", mildsc);

			// 1-1. 국방부/합참 분리 기능 추가
			String mdcdFlg = "";
			if(mildsc.equals("1290451")) {
				mdcdFlg = "Y";	//합참
			}	
			paramMap.put("mdcdFlg", mdcdFlg);	
				
			List deptTopList = new ArrayList();
			if(mdcdFlg.equals("Y")) {
				paramMap.put("mildsc", "A");
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
				
			model.addAttribute("subDeptNmList", supDeptNmList);
			model.addAttribute("subDeptList", subDeptList);
			model.addAttribute("mildsc",mildsc);
			model.addAttribute("mdcdFlg",mdcdFlg);
		}else {
			model.addAttribute("mildsc","all");
		}
		
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
		
		paramMap.put("regId", requset.getSession().getAttribute("user_id"));
		paramMap.put("auth", requset.getSession().getAttribute("auth"));
		
		List<Map> list =  userService.selectFacList(paramMap);
		int cnt = userService.getFacCount(paramMap);
		
		paginationInfo.setTotalRecordCount(cnt);
		
		model.addAttribute("list", list);
		model.addAttribute("cnt", cnt);
		model.addAttribute("paramMap", paramMap);
        model.addAttribute("paginationInfo", paginationInfo);
        
		return "admin/facility/facilityList.admin";
	}
}
