package com.sfr.intra.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

//육군
import com.precursor.siteminder.agent.SiteminderAgentAPI2;
import com.sfr.admin.service.AdminService;
import com.sfr.common.SessionCheck;
import com.sfr.common.StringUtils;
import com.sfr.intra.service.IntraService;

//해군
import WiseAccess.SSO;
//공군
//국방
import kr.co.iniline.swift.sp.api.SPApiManager;
import netegrity.siteminder.javaagent.AttributeList;


@Controller
@RequestMapping("/intra")
public class IntraLoginController {


	@Autowired
	private AdminService adminService;
	
	
	@Autowired
	private IntraService intraService;
	
	@RequestMapping("/login.do")
	public String login() {
		return "intra/loginPro";
//		return "intra/login";
	}
	
	@RequestMapping("/loginT.do")
	public String loginT() {
		return "intra/login";
		//return "intra/login";
	}
	
	@RequestMapping(value="/loginProc.do", method={RequestMethod.POST})
	public @ResponseBody Map loginProc(ModelMap model, HttpServletRequest request, @RequestParam Map paramMap) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		paramMap.put("id", "04-501205");
		paramMap.put("mildsc", "D");
		String id = StringUtils.nullCheck(paramMap.get("id"), "");
		//String pw = StringUtils.nullCheck(paramMap.get("pw"), "");
		String mildsc = StringUtils.nullCheck(paramMap.get("mildsc"), "");
		
		Map loginMap = intraService.intraLogin(paramMap);
		Map rtnMap = new HashMap();
		
		if(loginMap != null) {
			
			String loginId = loginMap.get("id").toString();
			/*
			 * pw 비밀번호 암호화 
			 * */
			 
			//if(pw.equals(loginMap.get("pw"))) {
				
				/*
				 * 아이디 중복 로그인 체크
				 * */
				if((!SessionCheck.getInstance().isLogin(mildsc+loginId)) || "true".equals(paramMap.get("loginFlag"))){
					
					SessionCheck.getInstance().doLogout(mildsc+loginId);
					
					HttpSession session = request.getSession();
					
					session.setAttribute("user_id", loginId);
					session.setAttribute("user_name", loginMap.get("nm"));
					session.setAttribute("mildsc", loginMap.get("mildsc"));
					session.setAttribute("deptCd", loginMap.get("deptCd"));
					session.setAttribute("deptNm", loginMap.get("deptNm"));
					session.setAttribute("FullDeptNm", loginMap.get("FullDeptNm"));
					session.setAttribute("milNo", loginMap.get("milNo"));  
					session.setAttribute("rspsbltBiznes", loginMap.get("rspsbltBiznes"));
					session.setAttribute("rank", loginMap.get("rank"));
					session.setAttribute("rspofcNm", loginMap.get("rspofcNm"));
					
					session.setAttribute("telno", loginMap.get("telno"));
					session.setAttribute("mpno", loginMap.get("mpno"));
					session.setAttribute("email", loginMap.get("email"));
					session.setAttribute("opnpblYn", loginMap.get("opnpblYn"));
					session.setAttribute("state", loginMap.get("state"));
					
					
					session.setAttribute("userCd", "2");  //userCd 0 : 슈퍼관리자   1: 교환   2: 일반사용자   3: 일반관리자
										
					
					rtnMap.put("code","0");
					rtnMap.put("user_id", loginId);
					
					
					SessionCheck.getInstance().doLogin(mildsc+loginId, mildsc+loginId, request.getRemoteAddr(), session);
					
					Map logMap = new HashMap();
					logMap.put("mildsc", loginMap.get("mildsc"));
					logMap.put("id", loginId);
					logMap.put("connCd", "1");						// 1=ip/pw, 2=sso, 3=공인인증서
					logMap.put("userCd", "2"); 						// 0=슈퍼관리자, 1=교환원, 2=일반사용자, 3=일반관리자
					logMap.put("regIp", request.getRemoteAddr());
					adminService.connlog(logMap);
					
					
				}else{
					rtnMap.put("code", "-2");
					rtnMap.put("msg", "해당 아이디가 이미 로그인 ("
							+SessionCheck.getInstance().getSessionUser(mildsc+loginId).getIpAddress()
							+") 되어 있습니다. \n다시 로그인 하시겠습니까?");
				}
				
//			} else {
//				rtnMap.put("code", "-1");
//				rtnMap.put("msg", "비밀번호를 잘못 입력하셨습니다.");
//			}
			
		} else {
			rtnMap.put("code", "-1");
			rtnMap.put("msg", "등록되지 않은 아이디입니다. 아이디를 다시 확인하세요.");
		}
		
		//return new ModelAndView("redirect:/intra/main.do");
		return rtnMap;
	}
	
	@RequestMapping(value="/logina.do")
	public @ResponseBody ModelAndView loginProcA(String uid, ModelMap model, HttpServletRequest request,HttpServletResponse response ,@RequestParam Map paramMap) throws Exception {
				
		System.out.println("loginId :" +uid);
		
		String id = uid;
		String mildsc = "A";
		System.out.println("###" +id);
		System.out.println("###" +mildsc);
		paramMap.put("id", id);
		paramMap.put("mildsc", mildsc);
		
		Map loginMap = intraService.intraLoginA(paramMap);
		Map rtnMap = new HashMap();
		
		if(loginMap != null) {
			System.out.println("0");
			String loginId = loginMap.get("id").toString();
				/*
				 * 아이디 중복 로그인 체크
				 * */
				SessionCheck.getInstance().doLogout(mildsc+loginId);
				
				if((!SessionCheck.getInstance().isLogin(mildsc+loginId))){
					System.out.println("1");
					SessionCheck.getInstance().doLogout(mildsc+loginId);
					
					HttpSession session = request.getSession();
					
					session.setAttribute("user_id", loginId);
					session.setAttribute("user_name", loginMap.get("nm"));
					session.setAttribute("mildsc", loginMap.get("mildsc"));
					session.setAttribute("deptCd", loginMap.get("deptCd"));
					session.setAttribute("deptNm", loginMap.get("deptNm"));
					session.setAttribute("FullDeptNm", loginMap.get("FullDeptNm"));
					session.setAttribute("milNo", loginMap.get("milNo"));  
					session.setAttribute("rspsbltBiznes", loginMap.get("rspsbltBiznes"));
					session.setAttribute("rank", loginMap.get("rank"));
					session.setAttribute("rspofcNm", loginMap.get("rspofcNm"));
					
					session.setAttribute("telno", loginMap.get("telno"));
					session.setAttribute("mpno", loginMap.get("mpno"));
					session.setAttribute("email", loginMap.get("email"));
					session.setAttribute("opnpblYn", loginMap.get("opnpblYn"));
					session.setAttribute("state", loginMap.get("state"));
					
					System.out.println("2");
					session.setAttribute("userCd", "2");  //userCd 0 : 슈퍼관리자   1: 교환   2: 일반사용자   3: 일반관리자
										
					
					rtnMap.put("code","0");
					rtnMap.put("user_id", loginId);
					
					System.out.println("3");
					SessionCheck.getInstance().doLogin(mildsc+loginId, mildsc+loginId, request.getRemoteAddr(), session);
					
					System.out.println("4");
					Map logMap = new HashMap();
					logMap.put("mildsc", loginMap.get("mildsc"));
					logMap.put("id", loginId);
					logMap.put("connCd", "1");						// 1=ip/pw, 2=sso, 3=공인인증서
					logMap.put("userCd", "2"); 						// 0=슈퍼관리자, 1=교환원, 2=일반사용자, 3=일반관리자
					logMap.put("regIp", request.getRemoteAddr());
					adminService.connlog(logMap);
					System.out.println("5");
					
				}
				
			
		} else {
			rtnMap.put("code", "-1");
			rtnMap.put("msg", "등록되지 않은 아이디입니다. 아이디를 다시 확인하세요.");
			System.out.println("7");
		}
		
		//model.put("nm", loginMap.get("nm"));
		
		//return new ModelAndView("redirect:/intra/main.do");
		//return rtnMap;
		return new ModelAndView("redirect:/intra/main.do");
	}
	
	@RequestMapping(value="/loginb.do")
	public @ResponseBody ModelAndView loginProcB(String uid, String SMSESSION, ModelMap model, HttpServletRequest request, HttpServletResponse response,@RequestParam Map paramMap) throws Exception {

		
		SiteminderAgentAPI2 agent = new SiteminderAgentAPI2();

		try {
			String ssoToken = agent.getSMSESSION(request, response);
			ssoToken = SMSESSION;
		        if (ssoToken == null || ssoToken.equals("")) {
		                //ssoToken = request.getParameter("SMSESSION");
		        		ssoToken = SMSESSION;
		                ssoToken = ssoToken.replaceAll(" ", "+");
		        }

		        ssoToken = ssoToken.replaceAll(" ", "+");
			if (ssoToken != null && !ssoToken.equals("")) {
				boolean init = agent.initAgent();
				System.out.println("Agent initialization : " + init + "<br>");

				if (init) {
					AttributeList attributeList = new AttributeList();
					String result = agent.doAuthorization("GET", "/", ssoToken, attributeList);
				
					System.out.println("URI authorization : " + result + "<br>");
				
					if (result.equals(SiteminderAgentAPI2.AUTHORIZED)) {
						String SSO_ID = agent.getReponseInformation(attributeList, "SSO_ID");
						System.out.println("heder information SSO_ID : " + SSO_ID + "<br>");
						String[] ssoId = SSO_ID.split("\\^");
						uid = ssoId[0];
					}
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			try {
				if (agent != null) {
					agent.cleanupAgent();
				}
			} catch (Exception ex) {ex.printStackTrace();}

		}
		
		
		
		System.out.println("loginId :" +uid);
		
		String id = uid;
		String mildsc = "B";
		System.out.println("###" +id);
		System.out.println("###" +mildsc);
		paramMap.put("id", id);
		paramMap.put("mildsc", mildsc);
		
		Map loginMap = intraService.intraLogin(paramMap);
		Map rtnMap = new HashMap();
		
		if(loginMap != null) {
			
			String loginId = loginMap.get("id").toString();
				/*
				 * 아이디 중복 로그인 체크
				 * */
					SessionCheck.getInstance().doLogout(mildsc+loginId);
			
				if((!SessionCheck.getInstance().isLogin(mildsc+loginId)) || "true".equals(paramMap.get("loginFlag"))){
					
					SessionCheck.getInstance().doLogout(mildsc+loginId);
					
					HttpSession session = request.getSession();
					
					session.setAttribute("user_id", loginId);
					session.setAttribute("user_name", loginMap.get("nm"));
					session.setAttribute("mildsc", loginMap.get("mildsc"));
					session.setAttribute("deptCd", loginMap.get("deptCd"));
					session.setAttribute("deptNm", loginMap.get("deptNm"));
					session.setAttribute("FullDeptNm", loginMap.get("FullDeptNm"));
					session.setAttribute("milNo", loginMap.get("milNo"));  
					session.setAttribute("rspsbltBiznes", loginMap.get("rspsbltBiznes"));
					session.setAttribute("rank", loginMap.get("rank"));
					session.setAttribute("rspofcNm", loginMap.get("rspofcNm"));
					
					session.setAttribute("telno", loginMap.get("telno"));
					session.setAttribute("mpno", loginMap.get("mpno"));
					session.setAttribute("email", loginMap.get("email"));
					session.setAttribute("opnpblYn", loginMap.get("opnpblYn"));
					session.setAttribute("state", loginMap.get("state"));
					
					
					session.setAttribute("userCd", "2");  //userCd 0 : 슈퍼관리자   1: 교환   2: 일반사용자   3: 일반관리자
										
					
					rtnMap.put("code","0");
					rtnMap.put("user_id", loginId);
					
					
					SessionCheck.getInstance().doLogin(mildsc+loginId, mildsc+loginId, request.getRemoteAddr(), session);
					
					Map logMap = new HashMap();
					logMap.put("mildsc", loginMap.get("mildsc"));
					logMap.put("id", loginId);
					logMap.put("connCd", "1");						// 1=ip/pw, 2=sso, 3=공인인증서
					logMap.put("userCd", "2"); 						// 0=슈퍼관리자, 1=교환원, 2=일반사용자, 3=일반관리자
					logMap.put("regIp", request.getRemoteAddr());
					adminService.connlog(logMap);
					
					
				}
				
			
		} else {
			rtnMap.put("code", "-1");
			rtnMap.put("msg", "등록되지 않은 아이디입니다. 아이디를 다시 확인하세요.");
		}
		
		//return new ModelAndView("redirect:/intra/main.do");
		//return rtnMap;
		return new ModelAndView("redirect:/intra/main.do");
	}
	
	
	
	@RequestMapping(value="/loginc.do")
	public @ResponseBody ModelAndView loginProcC(String uid,String ssotoken ,ModelMap model, HttpServletRequest request, @RequestParam Map paramMap) throws Exception {
		
		String sToken = null;
		sToken = ssotoken;
        System.out.println("sToken :  " + sToken);
        
        // SSO 연동
        String sApiKey="368B184727E89AB69FAF";
        SSO sso = new SSO(sApiKey);
        sso.setPortNumber(7500);
        //sso.setReceiveCharsetName("UTF-8");
        
        if( sToken != null && sToken.length() > 0) {
              //  System.out.println("if ");
                int nResult = sso.verifyToken( sToken, request.getRemoteAddr() );
                
                if( nResult >= 0 ) {

                        uid  =   sso.getValueUserID();
                        //response.sendRedirect("http://11.2.17.190/intra/loginc.do?ssotoken="+sToken);
                        System.out.println("sendRedirext");
                }
        }
		
			System.out.println("loginId :" +uid);
			
			String id = uid;
			String mildsc = "C";
			System.out.println("###" +id);
			System.out.println("###" +mildsc);
			paramMap.put("id", id);
			paramMap.put("mildsc", mildsc);
			
			Map loginMap = intraService.intraLogin(paramMap);
			Map rtnMap = new HashMap();
			
			if(loginMap != null) {
				
				String loginId = loginMap.get("id").toString();
					/*
					 * 아이디 중복 로그인 체크
					 * */
				
						SessionCheck.getInstance().doLogout(mildsc+loginId);
					if((!SessionCheck.getInstance().isLogin(mildsc+loginId)) || "true".equals(paramMap.get("loginFlag"))){
						
						SessionCheck.getInstance().doLogout(mildsc+loginId);
						
						HttpSession session = request.getSession();
						
						session.setAttribute("user_id", loginId);
						session.setAttribute("user_name", loginMap.get("nm"));
						session.setAttribute("mildsc", loginMap.get("mildsc"));
						session.setAttribute("deptCd", loginMap.get("deptCd"));
						session.setAttribute("deptNm", loginMap.get("deptNm"));
						session.setAttribute("FullDeptNm", loginMap.get("FullDeptNm"));
						session.setAttribute("milNo", loginMap.get("milNo"));  
						session.setAttribute("rspsbltBiznes", loginMap.get("rspsbltBiznes"));
						session.setAttribute("rank", loginMap.get("rank"));
						session.setAttribute("rspofcNm", loginMap.get("rspofcNm"));
						
						session.setAttribute("telno", loginMap.get("telno"));
						session.setAttribute("mpno", loginMap.get("mpno"));
						session.setAttribute("email", loginMap.get("email"));
						session.setAttribute("opnpblYn", loginMap.get("opnpblYn"));
						session.setAttribute("state", loginMap.get("state"));
						
						
						session.setAttribute("userCd", "2");  //userCd 0 : 슈퍼관리자   1: 교환   2: 일반사용자   3: 일반관리자
											
						
						rtnMap.put("code","0");
						rtnMap.put("user_id", loginId);
						
						
						SessionCheck.getInstance().doLogin(mildsc+loginId, mildsc+loginId, request.getRemoteAddr(), session);
						
						Map logMap = new HashMap();
						logMap.put("mildsc", loginMap.get("mildsc"));
						logMap.put("id", loginId);
						logMap.put("connCd", "1");						// 1=ip/pw, 2=sso, 3=공인인증서
						logMap.put("userCd", "2"); 						// 0=슈퍼관리자, 1=교환원, 2=일반사용자, 3=일반관리자
						logMap.put("regIp", request.getRemoteAddr());
						adminService.connlog(logMap);
						
						
					}
					
				
			} else {
				rtnMap.put("code", "-1");
				rtnMap.put("msg", "등록되지 않은 아이디입니다. 아이디를 다시 확인하세요.");
			}
			
			//return new ModelAndView("redirect:/intra/main.do");
			//return rtnMap;
			return new ModelAndView("redirect:/intra/main.do");
	}


	@RequestMapping(value="/logind.do")
	public @ResponseBody ModelAndView loginProcD(String uid,  String sofotoken,ModelMap model, HttpServletRequest request,HttpServletResponse response,@RequestParam Map paramMap) throws Exception {

		 	response.setHeader("Pragma", "no-cache");
	        response.setHeader("Cache-Control", "no-cache");
	        response.setDateHeader("Expires", 0);
	        //String sToken = request.getParameter("sofotoken");
	        
	        String sToken = null;
	        
	       /* Cookie cookies[] = request.getCookies();
	        //System.out.println("##" +cookies.length);
	       
	        if(cookies != null) {
	        	for(int i = 0; i < cookies.length; i++) {
	            	System.out.println("length " + cookies[i].getName());
	               if (cookies[i].getName().equals("ka_sso_token")) {
	                  sToken = cookies[i].getValue();
	                  //whichToken = "softforum";
	                  break;
	               }
	            }
	        }   

*/
	        sToken = sofotoken;
	        System.out.println("sToken :  " + sToken);
	        
	        // SSO 연동
	        String sApiKey="368B184727E89AB69FAF";
	        SafeIdentity.SSO  sso = new SafeIdentity.SSO(sApiKey);
	        //sso.setPortNumber(7000);
	        sso.setReceiveCharsetName("UTF-8");

	        if( sToken != null && sToken.length() > 0) {
	              //  System.out.println("if ");
	                int nResult = sso.verifyToken( sToken, request.getRemoteAddr() );
	                
	                if( nResult >= 0 ) {

	                        uid  =   sso.getValueUserID();
	                        //response.sendRedirect("http://11.2.17.190/intra/loginc.do?ssotoken="+sToken);
	                        System.out.println("sendRedirext");
	                }
	        }
	        
		System.out.println("loginId :" +uid);
		
		String id = uid;
		String mildsc = "D";
		System.out.println("###" +id);
		System.out.println("###" +mildsc);
		paramMap.put("id", id);
		paramMap.put("mildsc", mildsc);
		
		Map loginMap = intraService.intraLogin(paramMap);
		Map rtnMap = new HashMap();
		
		if(loginMap != null) {
			
			String loginId = loginMap.get("id").toString();
				/*
				 * 아이디 중복 로그인 체크
				 * */
			
					SessionCheck.getInstance().doLogout(mildsc+loginId);
				if((!SessionCheck.getInstance().isLogin(mildsc+loginId)) || "true".equals(paramMap.get("loginFlag"))){
					
					SessionCheck.getInstance().doLogout(mildsc+loginId);
					
					HttpSession session = request.getSession();
					
					session.setAttribute("user_id", loginId);
					session.setAttribute("user_name", loginMap.get("nm"));
					session.setAttribute("mildsc", loginMap.get("mildsc"));
					session.setAttribute("deptCd", loginMap.get("deptCd"));
					session.setAttribute("deptNm", loginMap.get("deptNm"));
					session.setAttribute("FullDeptNm", loginMap.get("FullDeptNm"));
					session.setAttribute("milNo", loginMap.get("milNo"));  
					session.setAttribute("rspsbltBiznes", loginMap.get("rspsbltBiznes"));
					session.setAttribute("rank", loginMap.get("rank"));
					session.setAttribute("rspofcNm", loginMap.get("rspofcNm"));
					
					session.setAttribute("telno", loginMap.get("telno"));
					session.setAttribute("mpno", loginMap.get("mpno"));
					session.setAttribute("email", loginMap.get("email"));
					session.setAttribute("opnpblYn", loginMap.get("opnpblYn"));
					session.setAttribute("state", loginMap.get("state"));
					
					
					session.setAttribute("userCd", "2");  //userCd 0 : 슈퍼관리자   1: 교환   2: 일반사용자   3: 일반관리자
										
					
					rtnMap.put("code","0");
					rtnMap.put("user_id", loginId);
					
					
					SessionCheck.getInstance().doLogin(mildsc+loginId, mildsc+loginId, request.getRemoteAddr(), session);
					
					Map logMap = new HashMap();
					logMap.put("mildsc", loginMap.get("mildsc"));
					logMap.put("id", loginId);
					logMap.put("connCd", "1");						// 1=ip/pw, 2=sso, 3=공인인증서
					logMap.put("userCd", "2"); 						// 0=슈퍼관리자, 1=교환원, 2=일반사용자, 3=일반관리자
					logMap.put("regIp", request.getRemoteAddr());
					adminService.connlog(logMap);
					
					
				}
				
			
		} else {
			rtnMap.put("code", "-1");
			rtnMap.put("msg", "등록되지 않은 아이디입니다. 아이디를 다시 확인하세요.");
		}
		
		//return new ModelAndView("redirect:/intra/main.do");
		//return rtnMap;
		return new ModelAndView("redirect:/intra/main.do");
	}
	
	
	
	
	@RequestMapping("/logout.do")
	public String logoutProc(HttpServletRequest request, HttpSession session) throws Exception {
		
		try{
		    SessionCheck.getInstance().doLogout(session.getAttribute("mildsc").toString()+session.getAttribute("user_id"));
		}catch(Exception e){
			
		}
		
		return "redirect:/intra/login.do";
	}
	
}
