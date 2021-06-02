package com.sfr.admin.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AdminDao {
	
	@Autowired
	@Resource(name="sqlSessionTemplate")
	private SqlSession sqlSession;


	@Autowired
	@Resource(name="sqlSessionTemplate1")
	private SqlSession sqlSessionTemplate1;

	
	/**
	 * mildsc, hgrnkDeptCd 상위부서 코드로 1 depth 아래 하위부서 리스트를 가져옴
	 * 
	 * @param 
	 * mildsc, hgrnkDeptCd
	 * 
	 * */
	public List selectDeptList(Map paramMap) {
		return (List)sqlSession.selectList("admin.admin.selectDeptList", paramMap);
	}
	
	
	/**
	 * mildsc, deptCd 부서 코드로 부서명을 가져옴
	 * 
	 * @param 
	 * mildsc, deptCd
	 * 
	 * */
	public Map selectDeptNm(Map paramMap) {
		return (Map)sqlSession.selectOne("admin.admin.selectDeptNm", paramMap);
	}
	
	/**
	 * User 리스트 가져옴
	 * 
	 * @param 
	 * 	mildsc, searchTxt
	 * 
	 * 
	 *  Paging .. 
	 * 
	 * */
	
	public List selectUserList(Map paramMap) {
		return (List)sqlSession.selectList("admin.admin.selectUserList", paramMap);
	}

	
	
	/**
	 * User 리스트 갯수 가져옴
	 * 
	 * @param 
	 * 	mildsc, searchTxt
	 * 
	 * 
	 * */
	public int getUserCount(Map paramMap) {
		return sqlSession.selectOne("admin.admin.getUserCount", paramMap);
	}
	
	

	
	/**
	 * 공지사항(게시판) 가져옴
	 * 
	 * @param 
	 * 	boardCd, searchTxt
	 * 
	 * boardCd 1=공지사항
	 * tbl_code 테이블 cd 400 번 확인
	 * 
	 * 
	 *  Paging .. admin user list 참고
	 * 
	 * */
	public List selectBoardList(Map paramMap) {
		return (List)sqlSession.selectList("admin.admin.selectBoardList", paramMap);
	}
	
	
	
	/**
	 * 공지사항(게시판) 가져옴
	 * 
	 * @param 
	 * 	boardCd, searchTxt
	 * 
	 * boardCd 1=공지사항
	 * tbl_code 테이블 cd 400 번 확인
	 * 
	 * 
	 * */
	public int getBoardCount(Map paramMap) {
		return sqlSession.selectOne("admin.admin.getBoardCount", paramMap);
	}
	
	
	/**
	 * 공지사항(게시판) 상세 페이지
	 * 
	 * @param 
	 *  seq, boardCd
	 *  
	 * boardCd 1=공지사항
	 * tbl_code 테이블 cd 400 번 확인
	 * 
	 * 
	 * */
	public List selectBoardDetail(Map paramMap) {
		return (List)sqlSession.selectList("admin.admin.selectBoardDetail", paramMap);
	}

	
	/**
	 * 공지사항(게시판) 등록
	 * 
	 * @param 
	 *  board_cd,	title,	content,	 cnt,	reg_id,	reg_mildsc,	reg_ip
	 *  
	 * boardCd 1=공지사항
	 * tbl_code 테이블 cd 400 번 확인
	 * 
	 * 
	 * */
	public int insertBoard(Map paramMap) {
		return sqlSession.insert("admin.admin.insertBoard", paramMap);
	}
	
	
	/**
	 * 공지사항(게시판) 수정
	 * 
	 * @param 
	 *  seq, board_cd,	title,	content,	upt_id,	upt_mildsc,	upt_ip
	 *  
	 * boardCd 1=공지사항
	 * tbl_code 테이블 cd 400 번 확인
	 * 
	 * 
	 * */
	public int updateBoard(Map paramMap) {
		return sqlSession.update("admin.admin.updateBoard", paramMap);
	}
	
	
	/**
	 * 공지사항(게시판) 삭제
	 * 
	 * @param 
	 *  seq, board_cd
	 *  
	 * boardCd 1=공지사항
	 * tbl_code 테이블 cd 400 번 확인
	 * 
	 * 
	 * */
	public int deleteBoard(Map paramMap) {
		return sqlSession.delete("admin.admin.deleteBoard", paramMap);
	}
	
	
	
	
	
	
	
	/**
	 * 관리자 리스트 가져옴
	 * 
	 * @param 
	 * 	auth, searchTxt
	 * 
	 * auth 0=최고관리자, 1=일반관리자
	 * tbl_code 테이블 cd 500 번 확인
	 * 
	 *  Paging .. admin user list 참고
	 * 
	 * */
	public List selectMngrList(Map paramMap) {
		return (List)sqlSession.selectList("admin.admin.selectMngrList", paramMap);
	}
	
	
	
	/**
	 * 관리자 갯수
	 * 
	 * @param 
	 * 	auth, searchTxt
	 * 
	 * auth 0=최고관리자, 1=일반관리자
	 * tbl_code 테이블 cd 500 번 확인
	 * 
	 * 
	 * */
	public int getMngrCount(Map paramMap) {
		return sqlSession.selectOne("admin.admin.getMngrCount", paramMap);
	}
	
	
	/**
	 * 관리자 상세 페이지
	 * 
	 * @param 
	 *  seq
	 * 
	 * */
	public List selectMngrDetail(Map paramMap) {
		return (List)sqlSession.selectList("admin.admin.selectMngrDetail", paramMap);
	}

	
	/**
	 * 관리자 등록
	 * 
	 * @param 
	 *  mildsc,	mngrId,	mngrPw, fullDeptCd,	deptCd,	auth
	 *  
	 * auth 0=최고관리자, 1=일반관리자
	 * tbl_code 테이블 cd 500 번 확인
	 * 
	 * fullDeptCd = deptCd 포함 상위부서코드 전체   
	 * ex) A^A10000^A110001^A111111
	 * 
	 * 
	 * */
	public int insertMngr(Map paramMap) {
		return sqlSession.insert("admin.admin.insertMngr", paramMap);
	}
	
	
	/**
	 * 관리자  수정
	 * 
	 * @param 
	 *  seq, mildsc,	mngrPw, fullDeptCd,	deptCd
	 *  
	 * auth 0=최고관리자, 1=일반관리자
	 * tbl_code 테이블 cd 500 번 확인
	 * 
	 * fullDeptCd = deptCd 포함 상위부서코드 전체   
	 * ex) A^A10000^A110001^A111111
	 * 
	 * 
	 * */
	public int updateMngr(Map paramMap) {
		return sqlSession.update("admin.admin.updateMngr", paramMap);
	}
	
	
	/**
	 * 관리자 삭제
	 * 
	 * @param 
	 *  seq
	 *  
	 * 
	 * 
	 * */
	public int deleteMngr(Map paramMap) {
		return sqlSession.delete("admin.admin.deleteMngr", paramMap);
	}
	
	/**
	 * 시설물 리스트 가져옴
	 * 
	 * @param 
	 * 	regId, searchTxt
	 * 
	 *  regId 는 관리자ID 임.. 각군 userId 아님..
	 * 
	 *  Paging .. admin user list 참고
	 * 
	 * */
	public List selectFacList(Map paramMap) {
		return (List)sqlSession.selectList("admin.admin.selectFacList", paramMap);
	}
	
	
	
	/**
	 * 시설물 갯수
	 * 
	 * @param 
	 * 	regId, searchTxt
	 * 
	 *  regId 는 관리자ID 임.. 각군 userId 아님..
	 * 
	 * 
	 * 
	 * */
	public int getFacCount(Map paramMap) {
		return sqlSession.selectOne("admin.admin.getFacCount", paramMap);
	}
	
	
	/**
	 * 시설물 상세 페이지
	 * 
	 * @param 
	 *  seq, regIp
	 * 
	 * */
	public Map selectFacDetail(Map paramMap) {
		return (Map)sqlSession.selectOne("admin.admin.selectFacDetail", paramMap);
	}
	
	
	
	
	
	
	/**
	 * 시설물 등록
	 * 
	 * @param 
	 * mildsc, facilityCd, deptCd, tel, regId, regMildsc, regIp, fullDeptCd
	 * 
	 * fullDeptCd = deptCd 포함 상위부서코드 전체   
	 * ex) A^A10000^A110001^A111111
	 * 
	 * 
	 * */
	public int insertFac(Map paramMap) {
		return sqlSession.insert("admin.admin.insertFac", paramMap);
	}
	
	
	
	/**
	 * 시설물 삭제
	 * 
	 * @param 
	 *  seq, regIp
	 *  
	 * 
	 * 
	 * */
	public int deleteFac(Map paramMap) {
		return sqlSession.delete("admin.admin.deleteFac", paramMap);
	}
	
	
	
	/**
	 * 시설물  수정
	 * 
	 * @param 
	 * facilityNm, tel,  uptId, uptMildsc, uptIp, seq
	 * 
	 * 
	 * */
	public int updateFac(Map paramMap) {
		return sqlSession.update("admin.admin.updateFac", paramMap);
	}
	
	/**
	 * admin login
	 * 
	 * @param 
	 * 	id
	 * 
	 * 
	 * */
	public Map adminLogin(Map paramMap) {
		return (Map)sqlSession.selectOne("admin.admin.adminLogin", paramMap);
	}
	
	
	/**
	 * 로그인 접속 로그
	 * 
	 * @param 
	 * 	#{mildsc},	#{id},	#{connCd},	#{userCd},	#{regIp}
	 * 
	 * 
	 * tbl_code 테이블 200
	 * 	connCd','1','ID/PW'
	 * 	connCd','2','SSO'
	 * 	connCd','3','공인인증서'
     *  
	 * tbl_code 테이블 300
	 * 	userCd','0','슈퍼관리자'
	 * 	userCd','1','교환원'
	 * 	userCd','2','일반사용자'
	 * 	userCd','3','관리자'
	 * 
	 * 
	 * */
	public void connLog(Map paramMap) {
		sqlSession.insert("admin.admin.connLog", paramMap);
	}
	
	public void connErrLog(Map paramMap) {
		sqlSession.insert("admin.admin.connErrLog", paramMap);
	}
	
	/**
	 * 관리자 접속
	 * 
	 * @param 
	 * 	#{id},	#{cnt}
	 * */
	public void connMngr(Map paramMap) {
		sqlSession.update("admin.admin.connMngr", paramMap);
	}


	public List<Map> selectAdminList(Map paramMap) {
	
		return sqlSession.selectList("admin.admin.selectAdminList", paramMap);
	}
	
	public List<Map> selectuserListCk(Map paramMap) {
		
		return sqlSession.selectList("admin.admin.selectuserListCk", paramMap);
	}

	public List selectGeneralDeptList(Map paramMap) {
		
		return (List)sqlSession.selectList("admin.admin.selectGeneralDeptList", paramMap);
	}


	public List<Map> selectGeneralList(Map paramMap) {
		
		return (List) sqlSession.selectList("admin.admin.selectGeneralList", paramMap);
	}
	
	
	
	public List<Map> selectOperatorList(Map paramMap) {
		
		return sqlSessionTemplate1.selectList("admin.admin.selectOperatorList", paramMap);
	}


	public String getDeptCd(Map paramMap) {
		
		return sqlSession.selectOne("admin.admin.getDeptCd", paramMap);
	}


	public List selectDeptTopList(Map paramMap) {

		return (List)sqlSession.selectList("admin.admin.selectDeptTopList", paramMap);
	}

	public Map selectDeptTopNm(Map paramMap) {
		return (Map)sqlSession.selectOne("admin.admin.selectDeptTopNm", paramMap);
	}

	public void changeMngrPw(Map paramMap) {
		sqlSession.update("admin.admin.changeMngrPw", paramMap);
	}
	
    /*
     * 공지사항 첨부파일 정보 저장
     * */
    public int insertNoticeFileAtch(Map paramMap) {
        return sqlSession.insert("admin.admin.insertNoticeFileAtch", paramMap);
        
    }

    /*
     * 공지사항 첨부파일 키 생성 
     * */  
    public int getFileAtchSer() {
        return sqlSession.selectOne("admin.admin.selectAtchSeqNum");
    }

    /*
     * 공지사항 첨부파일 리스트 조회 
     * */ 
    public List noticeFileAtchListAjax(Map paramMap) {
        return (List)sqlSession.selectList("admin.admin.fileList", paramMap);
    }

    /*
     * 공지사항 첨부파일 삭제 
     * */ 
    public int deleteFileAtchListAjax(Map paramMap) {
        return sqlSession.delete("admin.admin.deleteFileAtch", paramMap);
    }

    /*
     * 공지사항 첨부파일 다운로드 정보 
     * */ 
    public Map selectFile(Map paramMap) {
        return (Map)sqlSession.selectOne("admin.admin.selectFile", paramMap);
    }     	
}
