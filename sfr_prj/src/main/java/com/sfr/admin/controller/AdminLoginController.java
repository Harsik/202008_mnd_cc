package com.sfr.admin.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sfr.admin.service.AdminService;
import com.sfr.common.SHA256Util;
import com.sfr.common.SessionCheck;
import com.sfr.common.StringUtils;

@Controller
@RequestMapping("/admin")
public class AdminLoginController {

	@Autowired
	private AdminService adminService;
	
	/**
	 * 로그인 화면
	 * @return
	 */
	@RequestMapping("/login.do")
	public String login(){
		return "admin/adminLogin";
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

		
		Map loginMap = adminService.adminLogin(paramMap);
		Map rtnMap = new HashMap();
		
		if(loginMap != null) {
			
			String loginId = loginMap.get("mngrId").toString();
			String mildsc =  loginMap.get("mildsc").toString();
			/*
			 * pw 비밀번호 암호화 
			 * */
			pw = SHA256Util.encrypt(pw);
					
			if(pw.equals(loginMap.get("mngrPw"))) {
				
				
				/*
				 * 로그인 실패 횟수 5회, 5분 제한
				 * */
				int failCnt = Integer.parseInt(loginMap.get("connFailCnt").toString());
				
				
				
				SimpleDateFormat reFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
				Date activityDate = reFormat.parse(loginMap.get("connFailDt").toString());
				
				float diff = (float)( (System.currentTimeMillis() - activityDate.getTime())  
						 / (1000f * 60f ) ); //분으로 계산
				
				System.out.println("System.currentTimeMillis()--------------	"+System.currentTimeMillis());
				System.out.println("fail Time			------------------		"+activityDate.getTime());
				
				System.out.println("diff minutes		------------------		"+diff);
				
				if(failCnt < 5 || diff > 5){ // 로그인 실패 횟수 < 5회, 시간 > 5분 
					/*
					 * 아이디 중복 로그인 체크
					 * */
					if((!SessionCheck.getInstance().isLogin(mildsc+loginId)) || "true".equals(paramMap.get("loginFlag"))){
						
						SessionCheck.getInstance().doLogout(mildsc+loginId);
						
						HttpSession session = request.getSession();
						
						session.setAttribute("user_id", loginId);
						session.setAttribute("user_name", loginId);
						session.setAttribute("mildsc", loginMap.get("mildsc"));
						session.setAttribute("deptCd", loginMap.get("deptCd"));
						session.setAttribute("fullDeptCd", loginMap.get("fullDeptCd"));
						
						session.setAttribute("userCd", "0".equals(loginMap.get("auth"))?"0":"3");  //userCd 0 : 슈퍼관리자   1: 교환   2: 일반사용자   3: 일반관리자
						session.setAttribute("auth", loginMap.get("auth"));							// auth = 0 : 슈퍼관리자 1: 일반관리자
						
						
						rtnMap.put("code","0");
						rtnMap.put("user_id", loginId);
						rtnMap.put("auth", loginMap.get("auth"));
						
						
						SessionCheck.getInstance().doLogin(mildsc+loginId, mildsc+loginId, request.getRemoteAddr(), session);
						
						
						Map logMap = new HashMap();
						logMap.put("mildsc", loginMap.get("mildsc"));
						logMap.put("id", loginId);
						logMap.put("connCd", "1");				// 1=ip/pw, 2=sso, 3=공인인증서
						logMap.put("userCd", "0".equals(loginMap.get("auth"))?"0":"3"); // 0=슈퍼관리자, 1=교환원, 2=일반사용자, 3=일반관리자
						logMap.put("regIp", request.getRemoteAddr());
						adminService.connlog(logMap);
						
						
						//로그인 실패 cnt 초기화
						logMap.put("cnt", "0");
						adminService.connMngr(logMap);
					}else{
						rtnMap.put("code", "-2");
						rtnMap.put("msg", "해당 아이디가 이미 로그인 ("
								+SessionCheck.getInstance().getSessionUser(mildsc+loginId).getIpAddress()
								+") 되어 있습니다. \n다시 로그인 하시겠습니까?");
					}
					
				}else{
					rtnMap.put("code", "-3");
					rtnMap.put("msg", "5회 이상 로그인에 실패했습니다.\n5분 간 로그인이 제한됩니다.");
				}
				
			} else {
				
				//로그인 실패 cnt + 1
				Map logMap = new HashMap();
				logMap.put("id", loginId );
				logMap.put("cnt", Integer.parseInt(loginMap.get("connFailCnt").toString())+1);
				adminService.connMngr(logMap);
				
				rtnMap.put("code", "-1");
				rtnMap.put("msg", "비밀번호를 잘못 입력하셨습니다.");
			}
			
		} else {
			rtnMap.put("code", "-1");
			rtnMap.put("msg", "등록되지 않은 아이디입니다. 아이디를 다시 확인하세요.");
		}
		
		
		return rtnMap;
		
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
		    SessionCheck.getInstance().doLogout(session.getAttribute("mildsc").toString()+session.getAttribute("user_id"));
		}catch(Exception e){
			
		}

		return "redirect:/admin/login.do";
	}
	
}
