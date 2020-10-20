package com.sfr.common;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class SessionCheck implements Runnable {
	private static final Logger logger = LoggerFactory.getLogger(SessionCheck.class);
	private static SessionCheck sessionManager ;
	private static Thread sessionThread;
	private static final int sessionCheckTime = 1000*20;  // 20초 마다 세션 체크
	private static final int sessionTime = 1000*60*60;  // 세션 시간 60분  
	
	Hashtable<String, SessionUser> accessUserList = new Hashtable<String, SessionUser>();
	
	
	private boolean isRunning = false; 
	private SessionCheck() { 
		
	}
	
	public static SessionCheck getInstance() { 
		if(sessionManager == null) { 
			sessionManager = new SessionCheck();
			
			
		}
		if(sessionThread == null){ 
			//sessionThread = new Thread( sessionManager);
			//sessionThread.start();
		}
		
		
		return sessionManager;
	}
	
	public void run() { 
		
		//logger.info("Session Check start.......");
		try { 
			while(true) { 
				//logger.info("Session Check Begin....");
				sessionCheckProc();
				isRunning= true;
				//logger.info("Session Check End....");
				Thread.sleep(sessionCheckTime);
				
			}
		} catch (Exception e) { 
			isRunning = false;
		} finally { 
			//logger.info("Session Check Terminated....");
			isRunning = false;
		}
	}

	private void sessionCheckProc() {
		// TODO Auto-generated method stub
		
		// sessionTime 초과 접속시 모두로그아웃 시킴 
		
		Enumeration e = accessUserList.keys();
		while(e.hasMoreElements()) { 
			String uid = (String)e.nextElement();
			
			
			SessionUser user = (SessionUser)accessUserList.get(uid);
			
			if(  System.currentTimeMillis() - user.getLastAccessMiles() > sessionTime) { 
				// logout target  
				accessUserList.remove(uid);
				user.getSession().invalidate();
				
				logger.info(">>SessionCheck Thread Remove user :"+uid);
			}
		} 
	}
	
	
	/**
	 *로그인을 시도 하였을 때 기존 로그인 정보를 삭제한다. 
	 *새로 로그인 된 정보를 입력하여 처리한다. 
	 * @param uid
	 */
	public void doLogin(String uid, String uname, String ipaddr, HttpSession session) { 
		SessionUser user = accessUserList.get(uid);
		// 다른곳에서로그인 되어 있거나 , 세션이 끊어지지 않았다면 세션을 종료 시킨다. 
		if(user != null) {  
			logger.info(">>SessionCheck logout/remove id : " + uid + ">> ip  : " + user.getIpAddress() );
			//user.getSession().invalidate();

			accessUserList.remove(uid);
		} 
		SessionUser newUser = new SessionUser();
		newUser.setLastAccessMiles(System.currentTimeMillis());
		newUser.setIpAddress(ipaddr);
		newUser.setUserNm(uname);
		newUser.setUserId(uid);
		newUser.setSessionId(session.getId());
		newUser.setSession(session);
		
		logger.info(">>SessionCheck login id : " + uid + ">> ip  : " + ipaddr );
		accessUserList.put(uid, newUser); 
	}
	
	public void doLogout(String uid) { 
		SessionUser user = accessUserList.get(uid);
		// 다른곳에서로그인 되어 있거나 , 세션이 끊어지지 않았다면 세션을 종료 시킨다. 
		if(user != null) {  
			logger.info(">>SessionCheck logout/remove id : " + uid + ">> ip  : " + user.getIpAddress() );
			try{
				user.getSession().invalidate();
			}catch(Exception e){
				
			}
			accessUserList.remove(uid);
		}  
	}
	
	public void doLogout(String uid, String sessionid, HttpServletRequest reqeust) { 
		SessionUser user = accessUserList.get(uid);
		// 다른곳에서로그인 되어 있거나 , 세션이 끊어지지 않았다면 세션을 종료 시킨다. 
		if(user != null) {  
			logger.info(">>SessionCheck logout/remove id : " + uid + ">> ip  : " + user.getIpAddress() );
//			try{
				user.getSession().invalidate();
//			}catch(Exception e){
				
//			}
			accessUserList.remove(uid);
		}  
//		try {
			reqeust.getSession().invalidate();
//		} catch (Exception e) {
			
//		}
	}
	
		
	public boolean isLogin(String uid) { 
		
		SessionUser user = accessUserList.get(uid);
		if(user == null)
			return false; 
		
		// 세션아이디 및 접속 아이피가 동일하여야 함. 
		//if(user.getIpAddress().equals(ip) && user.getSessionId().equals(SESSION_ID)) { 
			// 최종 접속시간을 변경하여 준다. 
		//	user.setLastAccessMiles(System.currentTimeMillis());
			//logger.info(user.getLastAccessMiles());
		//	return true;
		//}
		
		return true;
	}
	
	
	public void wow(HttpServletRequest request, HttpServletResponse response) { 
		
		
		HttpSession session = request.getSession();
		
		//String getJSessionId = request.getCookies()
	}
	
	public static String getJSessionID(HttpServletRequest request) { 
		Cookie[] cookies = request.getCookies();
		
		try { 
			for(int i=0; i<cookies.length; i++) { 
				String cname = cookies[i].getName();
				String value = cookies[i].getValue();
				if(cname.toUpperCase().equals("JSESSIONID"))
					return cookies[i].getValue(); 
			}
		} catch (Exception e) {  
			return null;
		}
		return null;
	}
 
	/**
	  로그인한 사용자 전체 목록 조회 . 
	*/
	public List<SessionUser> getLoginUsers() { 
		List<SessionUser> users = new ArrayList<SessionUser>();
		Enumeration e = accessUserList.keys();
		while(e.hasMoreElements()) { 
			String uid = (String)e.nextElement();
			
			SessionUser user = accessUserList.get(uid);
			
			logger.info(user.getUserId()+" "+user.getLastAccessMiles());
			users.add(user);
			 
		} 
		
		Collections.sort(users);
		return users;
	}
	
	/**
	  로그인한 전체 수 . 
	*/
	public int getLoginUserCnt() { 
		return accessUserList.size();
	}
	
	
	/**
	  로그인한 전체 수 . 
	*/
	public SessionUser getSessionUser(String uid) { 
		return accessUserList.get(uid);
	}
}
