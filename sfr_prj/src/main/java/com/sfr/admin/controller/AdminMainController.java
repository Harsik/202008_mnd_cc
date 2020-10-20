package com.sfr.admin.controller;

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
