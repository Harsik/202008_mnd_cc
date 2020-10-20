package com.sfr.admin.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sfr.admin.service.AdminService;
import com.sfr.common.PagerVO;
import com.sfr.common.SHA256Util;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestMapping("/admin")
public class AdminMangerController {

	
	@Autowired
	private AdminService userService;

	
	/**
	 * 최상위 관리자
	 * @return
	 */
	@RequestMapping("/adminList.do")
	public String adminList(@RequestParam Map paramMap, ModelMap model, HttpServletRequest request, @ModelAttribute("searchVO") PagerVO vo ) throws Exception {
		
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
		HttpSession session  = request.getSession();
		
		paramMap.put("mildsc", session.getAttribute("mildsc").toString());
		paramMap.put("auth",'0');
		
		List<Map> list =  userService.selectGeneralList(paramMap);
		int cnt = userService.getMngrCount(paramMap);
		
		paginationInfo.setTotalRecordCount(cnt);
		
		model.addAttribute("list", list);
		model.addAttribute("cnt", cnt);
		model.addAttribute("paramMap", paramMap);
        model.addAttribute("paginationInfo", paginationInfo);
		
		
		return "admin/adminManager/adminList.admin";
	}	

	@RequestMapping("/adminWrite.do")
	public String adminWrite(@RequestParam Map paramMap, ModelMap model, HttpServletRequest request) throws Exception {
		HttpSession session  = request.getSession();
		
		String mildsc = session.getAttribute("mildsc").toString();
		String[] deptCdArray = session.getAttribute("fullDeptCd").toString().split("\\^");
		
		paramMap.put("hgrnkDeptCd", session.getAttribute("deptCd").toString());
		paramMap.put("mildsc", mildsc);
		
		
		List deptList = userService.selectDeptList(paramMap);
		
		List deptNmList = new ArrayList();
		
		for(int i=1;i<deptCdArray.length;i++){
			
			paramMap.put("deptCd", deptCdArray[i]);
			
			Map temp = userService.selectDeptNm(paramMap);
			
			deptNmList.add(temp);
		}
		
		
		model.addAttribute("deptNmList", deptNmList);
		model.addAttribute("deptList", deptList);
		model.addAttribute("mildsc",mildsc);
		return "admin/adminManager/adminWrite.admin";
	}	

	@RequestMapping("/adminInsert.do")
	public @ResponseBody Map adminInsert(@RequestParam Map paramMap, ModelMap model, HttpServletRequest request) throws Exception {
		
		HttpSession session  = request.getSession();
		
		Map rtnMap = new HashMap();
		
		List<Map> list  = userService.selectAdminList(paramMap);
		
		for (int i = 0; i < list.size(); i++) {
			
			if(list.get(i).get("mngrId").equals(paramMap.get("mngrId").toString()) ) {
				rtnMap.put("resultCd", "200");// 중복값
				return rtnMap;
			} 
		} // mng for 
		
			//String [] deptCd = request.getParameterValues("deptCd");
			
			String fullDeptCd = paramMap.get("mildsc").toString();
			
			/*paramMap.put("mildsc", fullDeptCd);
			
			String deptCd = userService.getDeptCd(paramMap);
			
			for (String temp : deptCd){
				if(!"".equals(temp)){
					fullDeptCd += "^"+temp;
				}
			}*/
			
			String pw = paramMap.get("mngrPw").toString();
			pw = SHA256Util.encrypt(pw);
			
			paramMap.put("mildsc", fullDeptCd);
			paramMap.put("mngrId", paramMap.get("mngrId").toString());
			paramMap.put("mngrPw", pw);
			paramMap.put("fullDeptCd", "");
			paramMap.put("deptCd", "");
			paramMap.put("auth", '0');
			
			
			userService.insertMngr(paramMap);
			rtnMap.put("resultCd", "100"); //성공
		return rtnMap;
	}
	
	
	
	@RequestMapping("/adminModify.do")
	public String adminModify(@RequestParam Map paramMap, ModelMap model, HttpServletRequest request) throws Exception {
		
		paramMap.put("seq", paramMap.get("seq"));
		
		List<Map> list = userService.selectMngrDetail(paramMap);

		String mildsc = list.get(0).get("mildsc").toString();
		
		model.addAttribute("list", list);
		model.addAttribute("mildsc",mildsc);
		model.addAttribute("paramMap",paramMap);
		
		return "admin/adminManager/adminModify.admin";
	}	
	
	
	@RequestMapping("/updateAdmin.do" )
	public  String updateAdmin(@RequestParam Map paramMap, HttpServletRequest requset) throws Exception{
		
		//paramMap.put("seq", paramMap.get("seq"));
		//paramMap.put("mildsc", paramMap.get("mildsc"));
		//paramMap.put("mngrId", paramMap.get("mngrId"));
		
		String pw = "";		
		if(paramMap.get("mngrPw") != null && !paramMap.get("mngrPw").equals("")) {
			pw = paramMap.get("mngrPw").toString();
			pw = SHA256Util.encrypt(pw);
		}
		
		paramMap.put("mngrPw", pw);
		paramMap.put("fullDeptCd", "");
		paramMap.put("deptCd", "");
		
		
		userService.updateMngr(paramMap);
		
		return "redirect:/admin/adminList.do";
	}
	
	
	@RequestMapping("/deleteAdmin.do")
	public String deleteAdmin(@RequestParam Map paramMap, HttpServletRequest request) throws Exception {
		
		paramMap.put("seq", paramMap.get("seq"));
		
		userService.deleteMngr(paramMap);
		
		return "redirect:/admin/adminList.do";
	}
}
