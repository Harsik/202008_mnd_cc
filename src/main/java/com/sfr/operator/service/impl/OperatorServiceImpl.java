package com.sfr.operator.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sfr.operator.dao.OperatorDao;
import com.sfr.operator.service.OperatorService;

@Service
public class OperatorServiceImpl implements OperatorService{

	@Autowired
	private OperatorDao operatorDao;
	
	
	/*
	 * 
	 * 게시판 리스트
	 * */
	@Override
	public List selectBoardList(Map paramMap) throws Exception {
		return operatorDao.selectBoardList(paramMap);
	}


	/*
	 * 
	 * 게시판 총카운트
	 * */
	@Override
	public int getTotalCount(Map paramMap) throws Exception {
		
		return operatorDao.getTotalCount(paramMap);
	}


	/*
	 * 게시판 상세
	 * 
	 * */
	@Override
	public List<Map> selectNoticeDetail(Map paramMap) throws Exception {
		
		return operatorDao.selectBoardDetail(paramMap);
	}


	/*
	 * 인입전화번호 정보
	 * 
	 * */
	@Override
	public Map selectDeptTel(Map paramMap) throws Exception {
		
		return  operatorDao.selectDeptTel(paramMap);
	}


	/*
	 * 게시판 조회수
	 * */
	@Override
	public void updateBoardCnt(Map paramMap) throws Exception {
		operatorDao.updateBoardCnt(paramMap);
		
	}

	/*
	 * 조직도 가져오기
	 * */
	@Override
	public List selectDeptTree(Map paramMap) throws Exception {
		
		return operatorDao.selectDeptTree(paramMap);
	}

	/*
	 * 선택한 조직 인원
	 * */
	@Override
	public List<Map> selectDeptList(Map paramMap) throws Exception {
		
		return operatorDao.selectDeptList(paramMap);
	}

	/*
	 * 선택조직 총 카운트
	 * */
	@Override
	public int getDeptCount(Map paramMap) throws Exception {
		return operatorDao.getDeptCount(paramMap);
	}


	@Override
	public Map selectCtiUserInfo(Map paramMap) throws Exception {
		
		return operatorDao.selectCtiUser(paramMap);
	}


	@Override
	public List<Map> selectCtiList(Map paramMap) throws Exception {
		
		return operatorDao.selectCtiList(paramMap);
	}


	@Override
	public List<Map> selectoperatorList(Map paramMap) throws Exception {
		return operatorDao.selectoperatorList(paramMap);
	}
	
	@Override
	public List<Map> selectoperatorList70(Map paramMap) throws Exception {
		return operatorDao.selectoperatorList70(paramMap);
	}


	@Override
	public Map 	selectCtiUserInfo70(Map paramMap) throws Exception {
		return operatorDao.selectCtiUserInfo70(paramMap);
	}


}
