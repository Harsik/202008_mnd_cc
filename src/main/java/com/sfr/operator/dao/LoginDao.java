package com.sfr.operator.dao;

import com.sfr.common.CommandMap;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

//@Mapper("loginDao")
public interface LoginDao {

	/**
	 * 입력된 정보로 회원정보가 있는지 확인
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	EgovMap selectUserInfo(CommandMap commandMap) throws Exception;
	
	/**
	 * 로그인 아이디로 회원정보 조회
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */	
	EgovMap selectLoginInfo(CommandMap commandMap) throws Exception;

	
}
