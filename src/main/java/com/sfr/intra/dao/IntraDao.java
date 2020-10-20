package com.sfr.intra.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class IntraDao {
	
	@Autowired
	@Resource(name="sqlSessionTemplate")
	private SqlSession sqlSession;
	
	/**
	 * 전화번호 검색 자동완성 기능 추가 
	 * 생성일 : 20.10.20
	 * 
	 * @param 
	 * telno
	 * 
	 * */
	public List selectDeptTelTest(Map paramMap) {
		return sqlSession.selectList("intra.intra.selectDeptTelTest", paramMap);
	}
	
	/**
	 * mildsc, hgrnkDeptCd 상위부서 코드로 1 depth 아래 하위부서 리스트를 가져옴
	 * 
	 * @param 
	 * mildsc, hgrnkDeptCd
	 * 
	 * */
	public List selectDeptList(Map paramMap) {
		return (List)sqlSession.selectList("intra.intra.selectDeptList", paramMap);
	}

	
	/**
	 * mildsc, hgrnkDeptCd 상위부서 코드로 1 depth 아래 하위부서 갯수
	 * 
	 * 
	 * @param 
	 * mildsc, hgrnkDeptCd
	 * */
	public int getTotalCount(Map paramMap) {
		return sqlSession.selectOne("intra.intra.getTotalCount", paramMap);
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
		return (Map)sqlSession.selectOne("intra.intra.selectDeptTel", paramMap);
	}

	
	
	
	/**
	 * mildsc, deptCd 부서 코드 로 부서에 소속된 User 리스트 를 가져옴
	 * 
	 * @param 
	 * mildsc, deptCd
	 * 
	 * */
	public List selectDeptUserList(Map paramMap) {
		return (List)sqlSession.selectList("intra.intra.selectDeptUserList", paramMap);
	}

	
	
	
	/**
	 * 공지사항(게시판) 가져옴
	 * 
	 * @param 
	 * 	boardCd
	 * 
	 * boardCd 1=공지사항
	 * tbl_code 테이블 cd 400 번 확인
	 * 
	 * 
	 *  Paging .. admin user list 참고
	 * 
	 * */
	public List selectBoardList(Map paramMap) {
		return (List)sqlSession.selectList("intra.intra.selectBoardList", paramMap);
	}

	public List selectBoardListAjax(Map paramMap) {
		return (List)sqlSession.selectList("intra.intra.selectBoardListAjax", paramMap);
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
		return (List)sqlSession.selectList("intra.intra.selectBoardDetail", paramMap);
	}
	
	
	
	/**
	 * 공지사항(게시판) 조회수 + 1
	 * 
	 * @param 
	 *  seq, boardCd
	 * 
	 * boardCd 1=공지사항
	 * tbl_code 테이블 cd 400 번 확인
	 * 
	 * */
	public int updateBoardCnt(Map paramMap) {
		return sqlSession.update("intra.intra.updateBoardCnt", paramMap);
	}
	
	/**
	 * 즐겨찾기 List 가져옴 ( 최근 20 개)
	 * 
	 * @param 
	 *  mildsc, id
	 * 
	 * */
	public List selectBookmarkList(Map paramMap) {
		return (List)sqlSession.selectList("intra.intra.selectBookmarkList", paramMap);
	}
	
	/**
	 * 즐겨찾기  삭제
	 * 
	 * @param 
	 * mildsc, id
	 * 
	 * */
	public int deleteBookmarK(Map paramMap) {
		 return sqlSession.delete("intra.intra.deleteBookmarK", paramMap);
	}
	
	/**
	 * 즐겨찾기 총 카운트
	 * 
	 * @param 
	 * mildsc, id
	 * 
	 * */
	public int getBookmarkCount(Map paramMap) {
		return sqlSession.selectOne("intra.intra.getBookmarkCount", paramMap);
	}
	
	/**
	 * 즐겨찾기 추가
	 * 
	 * @param 
	 * mildsc, id, bookmarkMildsc, bookmarkId, bookmarkDeptCd
	 * 
	 * */
	public int insertBookmark(Map paramMap) {
		return sqlSession.update("intra.intra.insertBookmark", paramMap);
	}

	/**
	 * 검색이력 List 가져옴 ( 최근 10 개)
	 * 
	 * @param 
	 *  mildsc, id
	 * 
	 * */
	public List<Map> selectSearchHistList(Map paramMap) {
		return (List)sqlSession.selectList("intra.intra.selectSearchHistList", paramMap);
	}
	
	
	
	/**
	 * 검색이력 추가
	 * 
	 * @param 
	 * mildsc, id, userCd, sechwd, regIp
	 * 
	 * userCd 0=슈퍼관리자, 1=교환원, 2=일반사용자, 3=관리자
	 * tbl_code 테이블 cd 300 번 확인
	 * 
	 * */
	public int inserSearchHist(Map paramMap) {
		return sqlSession.update("intra.intra.insertSearchHist", paramMap);
		
	}
	
	
	/**
	 * intra login
	 * 
	 * @param 
	 * 	id mildsc
	 * 
	 * 
	 * */
	public Map intraLogin(Map paramMap) {
		return (Map)sqlSession.selectOne("intra.intra.intraLogin", paramMap);
	}
	
	/**
	 * mildsc, deptCd  하위부서 tree 가져옴
	 * 
	 * @param 
	 * mildsc, deptCd
	 * 
	 * */
	public List selectDeptTree(Map paramMap) {
		return (List)sqlSession.selectList("intra.intra.selectDeptTree", paramMap);
	}
	
	/**
	 * mildsc, deptCd  하위부서 tree 가져옴
	 * 
	 * @param 
	 * mildsc, deptCd
	 * 
	 * */
	public int getDeptCount(Map paramMap) {
		return sqlSession.selectOne("intra.intra.getDeptCount", paramMap);
	}

	public Map intraLoginA(Map paramMap) {
		return (Map)sqlSession.selectOne("intra.intra.intraLoginA", paramMap);
	}
	
	public List<Map> selectBookmarkListAjax(Map paramMap) {
		return (List)sqlSession.selectList("intra.intra.selectBookmarkListAjax", paramMap);
	}


	public int BookUserCk(Map paramMap) {
		
		return sqlSession.selectOne("intra.intra.BookUserCk", paramMap);
	}


	public List<Map> selectfacilityList(Map paramMap) {
	
		return sqlSession.selectList("intra.intra.selectfacilityList", paramMap);
	}


	public int getfacilityCount(Map paramMap) {
		
		return sqlSession.selectOne("intra.intra.getfacilityCount", paramMap);
	}
	

	/**
	 * QnA 게시판  질문 추가
	 * 
	 * @param 
	 *  
	 * 
	 * */
	public int insertQnaBoard(Map paramMap) {
		return sqlSession.update("intra.intra.insertQnaBoard", paramMap);
	}
	public int deleteQnaBoard(Map paramMap) {
		return sqlSession.update("intra.intra.deleteQnaBoard", paramMap);
	}
	/**
	 * Qna 게시판 가져옴 
	 * 
	 * @param 
	 *  
	 * 
	 * */
	public int getQnaCount(Map paramMap) {
		return sqlSession.selectOne("intra.intra.getQnaCount", paramMap);
	}
	
	public int selectDual(Map paramMap) {
		return sqlSession.selectOne("intra.intra.selectDual", paramMap);
	}
	
	public List<Map> selectQnaBoardList(Map paramMap) {
		return (List)sqlSession.selectList("intra.intra.selectQnaBoardList", paramMap);
	}
 
    /*
     * 공지사항 첨부파일 리스트 조회 
     * */ 
    public List noticeFileAtchListAjax(Map paramMap) {
        return (List)sqlSession.selectList("intra.intra.fileList", paramMap);
    }
    
 
    /*
     * 공지사항 첨부파일 다운로드 정보 
     * */    
    public Map selectFile(Map paramMap) {
        //intra.intra.selectDeptTel
        //<select id="selectDeptTel" parameterType="map" resultType="egovMap">
        return (Map)sqlSession.selectOne("intra.intra.selectFile", paramMap);
        
    }
    
    /**
     * 즐겨찾기 그룹
     * 
     * @param 
     *  
     * 
     * */
    
    public List selectBookmarkGroupAjax(Map paramMap) {
        return (List)sqlSession.selectList("intra.intra.selectBookmarkGroupAjax", paramMap);
    }

    public List selectBookmarkGroupList(Map paramMap) {
        return (List)sqlSession.selectList("intra.intra.selectBookmarkGroupList", paramMap);
    }

    public int getBookmarkGroupCount(Map paramMap) {
        return sqlSession.selectOne("intra.intra.getBookmarkGroupCount", paramMap);
    }
    
    public int deleteBookmarkGroup(Map paramMap) {
        return sqlSession.delete("intra.intra.deleteBookmarkGroup", paramMap);
    }
    
    public int saveBkmkGroupNm(Map paramMap) {
        return sqlSession.update("intra.intra.saveBkmkGroupNm", paramMap);
    }
    
    public List selectGroupNm(Map paramMap) {
        return (List)sqlSession.selectList("intra.intra.selectGroupNm", paramMap);
    }
    
    public int updateBkmkUserGroup(Map paramMap) {
        return sqlSession.update("intra.intra.updateBkmkUserGroup", paramMap);
    }
	
    /*
     * 20181212 2ksystem 즐겨찾기 추가
     * public List selectBkmkGroupList
     * public List selectBkmkSubGroupList
     * */
    public List selectBkmkGroupList(Map paramMap) {
        return (List)sqlSession.selectList("intra.intra.selectBkmkGroupList", paramMap);
    }    
    
    
    public List selectBkmkSubGroupList(Map paramMap) {
        return (List)sqlSession.selectList("intra.intra.selectBkmkSubGroupList", paramMap);
    }   
    
}
