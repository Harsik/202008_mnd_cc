package com.sfr.operator.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.sfr.admin.service.AdminService;
import com.sfr.common.SessionCheck;
import com.sfr.common.StringUtils;
import com.sfr.operator.service.OperatorService;

@Controller
@RequestMapping("/operator")
public class LoginController {

	@Autowired
	private AdminService adminService;
	
	@Autowired
	private OperatorService operatorService; 

	/**
	 * 로그인 화면
	 * @return
	 */
	@RequestMapping("/login.do")
	public String login(){
		return "operator/login";
	}
	
	
	@RequestMapping("/test.do")
	public String error(){
		return "operator/test12";
	}
	
	
	/**
	 * 로그인 처리
	 * @param reqest
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/loginProc.do", method={RequestMethod.POST})
	public @ResponseBody Map loginProc(ModelMap model, HttpServletRequest request, @RequestParam Map paramMap) throws Exception{
		
		String id = StringUtils.nullCheck(paramMap.get("id"), "");
		String pw = StringUtils.nullCheck(paramMap.get("pw"), "");
		Map loginMap = new HashMap<>();
		
		System.out.println(" >>>>> /loginProc.do  >>> id : " + id);

		
		if(request.getRemoteAddr().equals("79.1.30.2")) { // 70대대
			loginMap = operatorService.selectCtiUserInfo70(paramMap);
			System.out.println(" >>>>> /loginProc.do  >>> 70 ip : " + request.getRemoteAddr());
		} else {
			loginMap = operatorService.selectCtiUserInfo(paramMap); // 60대대, 국방망 등등
			System.out.println(" >>>>> /loginProc.do  >>> else ip : " + request.getRemoteAddr());
		}
		
		Map rtnMap = new HashMap();

		if( loginMap != null ){
			String loginId = loginMap.get("loginId").toString();
			
				HttpSession session = request.getSession();
				session.setAttribute("user_id", loginMap.get("loginId"));
				session.setAttribute("user_name", loginMap.get("employeeName"));
				
				session.setAttribute("userCd", "1");
				
				if((!SessionCheck.getInstance().isLogin(loginId)) || "true".equals(paramMap.get("loginFlag"))){
					rtnMap.put("code","0");
					rtnMap.put("user_id", loginId);
				
					SessionCheck.getInstance().doLogin(loginId, loginId, request.getRemoteAddr(), session);
					
					Map logMap = new HashMap();
					logMap.put("mildsc", loginMap.get("mildsc"));
					logMap.put("id", loginId);
					logMap.put("connCd", "1");						// 1=ip/pw, 2=sso, 3=공인인증서
					logMap.put("userCd", "1"); 						// 0=슈퍼관리자, 1=교환원, 2=일반사용자, 3=일반관리자
					logMap.put("regIp", request.getRemoteAddr());
					adminService.connlog(logMap);
					System.out.println(" >>>>> /loginProc.do  >>> user_id : " + session.getAttribute("user_id"));
				} else {
					
					rtnMap.put("code", "-2");
					rtnMap.put("msg", "해당 아이디가 이미 로그인 ("
							+SessionCheck.getInstance().getSessionUser(loginId).getIpAddress()
							+") 되어 있습니다. \n다시 로그인 하시겠습니까?");
				}
		}else{
			rtnMap.put("code", "-1");
			rtnMap.put("msg", "등록되지 않은 아이디입니다. 아이디를 다시 확인하세요.");
		}
		//return new ModelAndView("redirect:/operator/main.do");
		return rtnMap;
	}
	
	/*@RequestMapping(value="/loginProc.do", method={RequestMethod.POST})
	public ModelAndView loginProc(ModelMap model, HttpServletRequest reqest, @RequestParam Map paramMap) throws Exception{
		
		String id = StringUtils.nullCheck(paramMap.get("id"), "");
		String pw = StringUtils.nullCheck(paramMap.get("pw"), "");

		HttpSession session = reqest.getSession();
		session.setAttribute("user_id", id);
		session.setAttribute("user_name", id);
		
		EgovMap eMap = loginService.selectUserInfo(commandMap);

		if( eMap != null ){
			if(eMap.size() > 0){
				HttpSession session = reqest.getSession();
				session.setAttribute("user_id", eMap.get("id"));
				session.setAttribute("user_name", eMap.get("nm"));
				
				if(eMap.get("id").equals("admin")) {
					return new ModelAndView("redirect:/operator/main.do"); 
				} else if(eMap.get("id").equals("user")) {
					return new ModelAndView("redirect:/intra/main.do"); 
				} else if(eMap.get("id").equals("system")) {
					return new ModelAndView("redirect:/admin/main.do"); 
				}
				
			}else{
				//로그인 정보 없음.
				return PageMove.alertAndBack(model, "로그인정보 없음");
			}
		}else{
			//로그인 정보 없음.
			return PageMove.alertAndBack(model, "로그인정보 없음");
		}
		return null;
		return new ModelAndView("redirect:/operator/main.do");
	}*/
	
	@RequestMapping(value="/ivrCallUser.do")
	public @ResponseBody ModelAndView ivrCallUser(@RequestParam Map paramMap, Model model, HttpServletRequest requset ) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView("jsonView");
		paramMap.put("telno", paramMap.get("telno"));
		paramMap.put("mpno", paramMap.get("mpno"));
		
		
		Map map = new HashMap<>();
		
		map = operatorService.selectDeptTel(paramMap);

		modelAndView.addObject("map", map);
		
		return modelAndView;
	}
	
	/**
	 * 로그아웃
	 * @param 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/logout.do")
	public String logoutProc(HttpServletRequest request, HttpSession session) throws Exception {

		try{
		    SessionCheck.getInstance().doLogout(session.getAttribute("user_id").toString());
		}catch(Exception e){
			
		}

		return "redirect:/operator/login.do";
	}
	
	
	
}
