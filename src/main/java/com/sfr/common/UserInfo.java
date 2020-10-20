package com.sfr.common;


import java.io.Serializable;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class UserInfo implements Serializable {

	private static final long serialVersionUID = 7695702774678556249L;

	private String userId       = null;     // 아이디
	private String userName        = null;     // 성명
	
	public String toString() {
		StringBuffer str = new StringBuffer();

		str.append("+ 성명 : ").append(this.getUserName()).append(" [").append(this.getUserId()).append("]\n");

		return str.toString();
	}

	public UserInfo() {
	}

	/**
	 * 임시로.. ㅡㅡ;
	 * @param req
	 */
	public void init(HttpServletRequest req) {
		HttpSession session = req.getSession();

		this.setUserId((String) session.getAttribute("user_id"));
		this.setUserName((String)  session.getAttribute("user_name"));

	}

	/**
	 * 아이디
	 * @return the userId
	 */
	public String getUserId() {
		return userId;
	}

	/**
	 * 아이디
	 * @param userId the userId to set
	 */
	public void setUserId(String userId) {
		this.userId = userId;
	}

	/**
	 * 성명
	 * @return the userName
	 */
	public String getUserName() {
		return userName;
	}

	/**
	 * 성명
	 * @param userName the userName to set
	 */
	public void setUserName(String userName) {
		this.userName = userName;
	}


}

