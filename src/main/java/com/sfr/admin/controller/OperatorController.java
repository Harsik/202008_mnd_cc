package com.sfr.admin.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
public class OperatorController {

	@Autowired
	private AdminService userService;
	
	
	/**
	 * 교환원 리스트
	 * @return
	 */
	@RequestMapping("/operatorList.do")
	public String operatorList(@RequestParam Map paramMap, ModelMap model, HttpServletRequest requset, @ModelAttribute("searchVO") PagerVO vo ) throws Exception{
		
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
		
		
		List<Map> list =  userService.selectOperatorList(paramMap);
		//int cnt = userService.getAdminCount(paramMap);
		
		//paginationInfo.setTotalRecordCount(cnt);
		
		model.addAttribute("list", list);
		//model.addAttribute("cnt", cnt);
        //model.addAttribute("paginationInfo", paginationInfo);
        
		
		
		return "admin/operator/operatorList.admin";
	}	
}
