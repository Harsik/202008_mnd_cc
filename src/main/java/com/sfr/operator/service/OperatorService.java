package com.sfr.operator.service;

import java.util.List;
import java.util.Map;

public interface OperatorService {

	List selectBoardList(Map paramMap) throws Exception;

	int getTotalCount(Map paramMap) throws Exception;

	List<Map> selectNoticeDetail(Map paramMap) throws Exception;

	Map selectDeptTel(Map paramMap) throws Exception;

	void updateBoardCnt(Map paramMap) throws Exception;

	List selectDeptTree(Map paramMap) throws Exception;

	List<Map> selectDeptList(Map paramMap) throws Exception;

	int getDeptCount(Map paramMap) throws Exception;

	List<Map> selectCtiList(Map paramMap) throws Exception;

	List<Map> selectoperatorList(Map paramMap) throws Exception;
	
	List<Map> selectoperatorList70(Map paramMap) throws Exception;

	Map selectCtiUserInfo(Map paramMap) throws Exception;

	Map selectCtiUserInfo70(Map paramMap) throws Exception;
	
	Map selectUser(Map paramMap) throws Exception;
	
	int insertBlock(Map paramMap) throws Exception;

	List selectBlockList(Map paramMap) throws Exception;
	
	int getBlockUserCount(Map paramMap) throws Exception;
	
	int updateBlock(Map paramMap) throws Exception;
	
	int selectBlockCheck(Map paramMap) throws Exception;

	int insertPrompt(Map paramMap) throws Exception;
	
	Map selectReqPrompt(Map paramMap) throws Exception;
	
	List<Map> selectDeptTelMain(Map paramMap) throws Exception;	// 전화번호 검색 자동완성 기능 추가 20.10.20
}
