package com.sfr.common;

import javax.servlet.http.HttpSession;

public class SessionUser implements Comparable {

	String userNm, sessionId; 
	long lastAccessMiles ; 
	String ipAddress; 
	String  userId;
	HttpSession session;
	public String getUserNm() {
		return userNm;
	}
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	public String getSessionId() {
		return sessionId;
	}
	public void setSessionId(String sessionId) {
		this.sessionId = sessionId;
	}
	public long getLastAccessMiles() {
		return lastAccessMiles;
	}
	public void setLastAccessMiles(long lastAccessMiles) {
		this.lastAccessMiles = lastAccessMiles;
	}
	public String getIpAddress() {
		return ipAddress;
	}
	public void setIpAddress(String ipAddress) {
		this.ipAddress = ipAddress;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public int compareTo(Object o) {
		// TODO Auto-generated method stub
		SessionUser u = (SessionUser)o;
		if(u.getLastAccessMiles() > this.getLastAccessMiles())
			return 1;
		return 0;
	}
	public HttpSession getSession() {
		return session;
	}
	public void setSession(HttpSession session) {
		this.session = session;
	}
	
	
	
	
}
