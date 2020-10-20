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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sfr.admin.service.AdminService;
import com.sfr.common.PagerVO;
import com.sfr.common.SHA256Util;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestMapping("/admin")
public class GeneralManagerController {

	@Autowired
	private AdminService userService;
	
	
	@RequestMapping("/generalManagerList.do")
	public String generalManagerList(@RequestParam Map paramMap, ModelMap model, HttpServletRequest request, @ModelAttribute("searchVO") PagerVO vo ) throws Exception {
		
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
		paramMap.put("auth",'1');
		paramMap.put("chkAuth", session.getAttribute("auth").toString());
		
		//System.out.println("################### chkAuth : " + session.getAttribute("auth"));
		
		List<Map> list =  userService.selectGeneralList(paramMap);
		int cnt = userService.getMngrCount(paramMap);
		
		paginationInfo.setTotalRecordCount(cnt);
		
		model.addAttribute("list", list);
		model.addAttribute("cnt", cnt);
		model.addAttribute("paramMap", paramMap);
        model.addAttribute("paginationInfo", paginationInfo);
		
		
		
		
		return "admin/generalManager/generalManagerList.admin";
	}	

	
	@RequestMapping("/generalManagerWrite.do")
	public String generalManagerWrite(@RequestParam Map paramMap, ModelMap model, HttpServletRequest request) throws Exception {
		
		HttpSession session  = request.getSession();
		
		String mildsc = session.getAttribute("mildsc").toString();
		String[] deptCdArray = session.getAttribute("fullDeptCd").toString().split("\\^");
		
		paramMap.put("hgrnkDeptCd", session.getAttribute("deptCd").toString());
		paramMap.put("mildsc", mildsc);
		
		
		//List deptList = userService.selectDeptList(paramMap);
		List deptList = userService.selectDeptTopList(paramMap);
		
		
		List deptNmList = new ArrayList();
		
		for(int i=1;i<deptCdArray.length;i++){
			
			paramMap.put("deptCd", deptCdArray[i]);
			
			Map temp = userService.selectDeptNm(paramMap);
			
			deptNmList.add(temp);
		}
		
		
		model.addAttribute("deptNmList", deptNmList);
		model.addAttribute("deptList", deptList);
		model.addAttribute("mildsc",mildsc);
		
		
		return "admin/generalManager/generalManagerWrite.admin";
	}
	
	
	@RequestMapping("/generalManagerInsert.do")
	public @ResponseBody Map generalManagerInsert(@RequestParam Map paramMap, ModelMap model, HttpServletRequest request) throws Exception {
		
		HttpSession session  = request.getSession();
		
		String [] deptCd = request.getParameterValues("deptCd");
		
		String fullDeptCd = paramMap.get("mildsc").toString();
		
		Map rtnMap = new HashMap();
		
		List<Map> list  = userService.selectAdminList(paramMap);
		
		List<Map> userCk = userService.selectuserListCk(paramMap);
		
		for (int i = 0; i < list.size(); i++) {
			
			if(list.get(i).get("mngrId").equals(paramMap.get("mngrId").toString()) ) {
				System.out.println("mngr들어오니??");
				rtnMap.put("resultCd", "200");// 중복값
				return rtnMap;
			} 
		} // mng for 
		
		for (int j = 0; j < userCk.size(); j++) {
			
			if(userCk.get(j).get("mngrId").equals(paramMap.get("mngrId").toString()) ) {
				System.out.println("mngr들어오니??");
				rtnMap.put("resultCd", "200");// 중복값
				return rtnMap;
			} 
		} // user for 

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
		
		String pw = paramMap.get("mngrPw").toString();
		pw = SHA256Util.encrypt(pw);
		
		paramMap.put("mildsc", session.getAttribute("mildsc").toString());
		paramMap.put("mngrId", paramMap.get("mngrId").toString());
		paramMap.put("mngrPw", pw);
		paramMap.put("fullDeptCd", fullDeptCd);
		paramMap.put("deptCd", fullDeptCd.substring(fullDeptCd.lastIndexOf("^")+1));
		paramMap.put("auth", '1');
		
		
		userService.insertMngr(paramMap);
		rtnMap.put("resultCd", "100");
				
		
		return rtnMap;
		
	}
	
	
	
	@RequestMapping(value = "/getGeneralManager.do", method={RequestMethod.POST})
	public @ResponseBody List getGeneralManager(@RequestParam Map paramMap, ModelMap model, HttpServletRequest request) throws Exception {
		
		HttpSession session  = request.getSession();
		
		String mildsc = session.getAttribute("mildsc").toString();
		
		//paramMap.put("hgrnkDeptCd", deptCdArray[deptCdArray.length-1]);
		paramMap.put("hgrnkDeptCd", paramMap.get("hgrnkDeptCd").toString());
		paramMap.put("mildsc", mildsc);
		
		List deptList = userService.selectDeptList(paramMap);
		
		
		return deptList;
	}	
	

	@RequestMapping("/generalManagerModify.do")
	public String generalManagerModify(@RequestParam Map paramMap, ModelMap model, HttpServletRequest request) throws Exception {
		
		HttpSession session  = request.getSession();
		
		Map rtnMap = new HashMap();
		
		paramMap.put("seq", paramMap.get("seq"));
		
		List<Map> list = userService.selectMngrDetail(paramMap);
		
		
		String mildsc = list.get(0).get("mildsc").toString();
		String[] deptCdArray = null;
		
		
		for (int i = 0; i < list.size(); i++) {
			deptCdArray = 	list.get(i).get("fullDeptCd").toString().split("\\^");
			paramMap.put("hgrnkDeptCd", list.get(i).get("deptCd").toString());
		}

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
				if(tempTop != null && tempTop.get("deptCd").equals("1290451")){ 
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
		
		model.addAttribute("list", list);
		model.addAttribute("deptNmList", supDeptNmList);
		model.addAttribute("deptList", subDeptList);
		model.addAttribute("mildsc",mildsc);
		model.addAttribute("paramMap", paramMap);
		model.addAttribute("mdcdFlg",mdcdFlg);
		
		return "admin/generalManager/generalManagerModify.admin";
	}
	
	@RequestMapping("/generalManagerUpdate.do")
	public @ResponseBody Map generalManagerUpdate(@RequestParam Map paramMap, ModelMap model, HttpServletRequest request) throws Exception {
		
		HttpSession session  = request.getSession();
		
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
		
		Map rtnMap = new HashMap();
		
		for (String temp : deptCd){
			if(!"".equals(temp)){
				fullDeptCd += "^"+temp;
			}
		}
		
		String pw = "";		
		if(paramMap.get("mngrPw") != null && !paramMap.get("mngrPw").equals("")) {
			pw = paramMap.get("mngrPw").toString();
			pw = SHA256Util.encrypt(pw);
		}
		
		//paramMap.put("mildsc", session.getAttribute("mildsc").toString());
		//paramMap.put("mngrId", paramMap.get("mngrId").toString());
		paramMap.put("mngrPw", pw);
		paramMap.put("fullDeptCd", fullDeptCd);
		paramMap.put("deptCd", fullDeptCd.substring(fullDeptCd.lastIndexOf("^")+1));
		//paramMap.put("auth", '1');
		
		
		userService.updateMngr(paramMap);
		rtnMap.put("resultCd", "100");
		
		return rtnMap;
		
	}
	
	
	@RequestMapping("/deleteGeneral.do")
	public String deleteGeneral(@RequestParam Map paramMap, HttpServletRequest request) throws Exception {
		
		
		paramMap.put("seq", paramMap.get("seq"));
		
		
		userService.deleteMngr(paramMap);
		
		return "redirect:/admin/generalManagerList.do";
	}
	
	/**
	 * 일반관리자 - 패스워드 변경 화면
	 * @return
	 */
	@RequestMapping("/changeMngrPw.do")
	public String changeMngrPw(@RequestParam Map paramMap, ModelMap model, HttpServletRequest request) throws Exception{
		
		return "admin/generalManager/changeMngrPw.admin";
		
	}	
	@RequestMapping(value = "/doChgMngrPw.do", method={RequestMethod.POST})
	public @ResponseBody Map  doChgMngrPw(@RequestParam Map paramMap, ModelMap model, HttpServletRequest request) throws Exception {
		
		HttpSession session  = request.getSession();
		
		Map rtnMap = new HashMap();

		String pw = paramMap.get("mngrPw").toString();
		pw = SHA256Util.encrypt(pw);
		
		paramMap.put("mngrId", session.getAttribute("user_id").toString());
		paramMap.put("mngrPw", pw);
		
		userService.changeMngrPw(paramMap);
		
		
		return rtnMap;
	}	
		
}
