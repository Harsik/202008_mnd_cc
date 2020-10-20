package com.sfr.operator.service;

import com.sfr.common.CommandMap;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface LoginService {

	/**
	 * 회원정보 조회
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	EgovMap selectUserInfo(CommandMap commandMap) throws Exception;
	
}
