package com.sfr.operator.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class OperatorDao {
	
	
	@Autowired
	@Resource(name="sqlSessionTemplate")
	private SqlSession sqlSession;


	@Autowired
	@Resource(name="sqlSessionTemplate1")
	private SqlSession sqlSessionTemplate1;
	
	

	@Autowired
	@Resource(name="sqlSessionTemplate2")
	private SqlSession sqlSessionTemplate2;
	
	
	/**
	 * mildsc,deptCd 상위부서 코드로 1 depth 아래 하위부서 리스트를 가져옴
	 * 
	 * @param 
	 * mildsc, deptCd
	 * 
	 * */
	public List selectDeptList(Map paramMap) {
		return (List)sqlSession.selectList("operator.operator.selectDeptList", paramMap);
	}

	
	/**
	 * mildsc, hgrnkDeptCd 상위부서 코드로 1 depth 아래 하위부서 갯수
	 * 
	 * 
	 * @param 
	 * mildsc, deptCd
	 * */
	public int getDeptCount(Map paramMap) {
		return sqlSession.selectOne("operator.operator.getDeptCount", paramMap);
	}
	
	
	/**
	 * telno 전화번호로 부서정보 가져옴
	 * 
	 * 
	 * @param 
	 * telno
	 * 
	 * */
	public Map selectDeptTel(Map paramMap) {
		return (Map)sqlSession.selectOne("operator.operator.selectDeptTel", paramMap);
	}

	
	
	
	/**
	 * mildsc, deptCd 부서 코드 로 부서에 소속된 User 리스트 를 가져옴
	 * 
	 * @param 
	 * mildsc, deptCd
	 * 
	 * */
	public List selectDeptUserList(Map paramMap) {
		return (List)sqlSession.selectList("operator.operator.selectDeptUserList", paramMap);
	}

	
	
	
	/**
	 * 공지사항(게시판) 가져옴
	 * 
	 * @param 
	 * boardCd
	 * 
	 * boardCd 1=공지사항
	 * tbl_code 테이블 cd 400 번 확인
	 * 
	 * 
	 *  Paging .. admin user list 참고
	 * 
	 * */
	public List selectBoardList(Map paramMap) {
		return (List)sqlSession.selectList("operator.operator.selectBoardList", paramMap);
	}
	
	
	/**
	 * 공지사항(게시판) 상세 페이지
	 * 
	 * @param 
	 *  seq, boardCd
	 * 
	 * */
	public List selectBoardDetail(Map paramMap) {
		return (List)sqlSession.selectList("operator.operator.selectBoardDetail", paramMap);
	}
	
	
	
	/**
	 * 공지사항(게시판) 조회수 + 1
	 * 
	 * @param 
	 * seq, boardCd
	 * 
	 * */
	public int updateBoardCnt(Map paramMap) {
		return sqlSession.update("operator.operator.updateBoardCnt", paramMap);
	}
	
	public int getTotalCount(Map paramMap) {
		return sqlSession.selectOne("operator.operator.getBoardCount", paramMap);
	}

	/**
	 * mildsc, hgrnkDeptCd  하위부서 tree 가져옴
	 * 
	 * @param 
	 * mildsc, hgrnkDeptCd
	 * 
	 * */
	public List selectDeptTree(Map paramMap) {
		return (List)sqlSession.selectList("operator.operator.selectDeptTree", paramMap);
	}


	public Map selectCtiUser(Map paramMap) {
		
		return sqlSessionTemplate1.selectOne("operator.operator.selectCtiUser", paramMap);
	}


	public List selectCtiList(Map paramMap) {
		
		return (List)sqlSessionTemplate1.selectList("operator.operator.selectCtiList", paramMap);
	}


	public List selectoperatorList(Map paramMap) {
		return (List)sqlSessionTemplate1.selectList("operator.operator.selectoperatorList", paramMap);
	}
	
	public List selectoperatorList70(Map paramMap) {
		return (List)sqlSessionTemplate2.selectList("operator.operator.selectoperatorList70", paramMap);
	}


	public Map selectCtiUserInfo70(Map paramMap) {
		return sqlSessionTemplate2.selectOne("operator.operator.selectCtiUserInfo70", paramMap);
	}
	
	public Map selectUser(Map paramMap) {
		return (Map)sqlSession.selectOne("operator.operator.selectUser", paramMap);
	}
	
	public int insertBlock(Map paramMap) {
		return sqlSession.update("operator.operator.insertBlock", paramMap);
	}
	
	public List selectBlockList(Map paramMap) {
		return (List)sqlSession.selectList("operator.operator.selectBlockList", paramMap);
	}
	
	public int updateBlock(Map paramMap) {
		return sqlSession.update("operator.operator.updateBlock", paramMap);
	}
	
	public int selectBlockCheck(Map paramMap) {
		return sqlSession.selectOne("operator.operator.selectBlockCheck", paramMap);
	}
	
	public int getBlockUserCount(Map paramMap) {
		return sqlSession.selectOne("operator.operator.getBlockUserCount", paramMap);
	}
	
	public int insertPrompt(Map paramMap) {
		return sqlSession.update("operator.operator.insertPrompt", paramMap);
	}
	
	public Map selectReqPrompt(Map paramMap) {
		return (Map)sqlSession.selectOne("operator.operator.selectReqPrompt", paramMap);
	}
}
