package com.sfr.intra.service;

import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface IntraService {
	
	Map intraLogin(Map paramMap) throws Exception;
	
	Map intraLoginU(Map paramMap) throws Exception;

	Map intraLoginP(Map paramMap) throws Exception;
	
	List<Map> selectBoardList(Map paramMap) throws Exception;

	List<Map> selectBoardListAjax(Map paramMap) throws Exception;
	
	int getTotalCount(Map paramMap) throws Exception;

	List<Map> selectNoticeDetail(Map paramMap) throws Exception;

	void updateBoardCnt(Map paramMap) throws Exception;

	int insertBookmark(Map paramMap);

	List selectDeptTree(Map paramMap);

	List<Map> selectBookmarkList(Map paramMap) throws Exception;

	int getBookmarkCount(Map paramMap) throws Exception;

	int deleteBookMark(Map paramMap) throws Exception;

	int insertSearchHist(Map paramMap) throws Exception;

	List<Map> selectSearchHistList(Map paramMap) throws Exception;

	List<Map> selectDeptList(Map paramMap) throws Exception;

	int getDeptCount(Map paramMap) throws Exception;

	Map intraLoginA(Map paramMap) throws Exception;
	
	List<Map> selectBookmarkListAjax(Map paramMap) throws Exception;
	
	int BookUserCk(Map paramMap) throws Exception;	
	
	List<Map> selectfacilityList(Map paramMap) throws Exception;

	int getfacilityCount(Map paramMap) throws Exception;
	
	int insertQnaBoard(Map paramMap) throws Exception;
	
	int deleteQnaBoard(Map paramMap) throws Exception;
	
	int selectDual(Map paramMap) throws Exception;
	int getQnaCount(Map paramMap) throws Exception;
	
	List<Map> selectQnaBoardList(Map paramMap) throws Exception;
	
	
    /**
     * 공지게시판 첨부파일 리스트 조회
     */    
    List<Map> noticeFileAtchListAjax(Map paramMap) throws Exception;

    /**
     * 공지게시판 첨부파일 다운로드 정보
     */
    public Map selectFile(HashMap paramMap) throws Exception;  
    
    
    /**
     * 즐겨찾기 그룹 조회
     */  
    
    List<Map> selectBookmarkGroupAjax(Map paramMap) throws Exception;
    
    List<Map> selectBookmarkGroupList(Map paramMap) throws Exception;
    
    int getBookmarkGroupCount(Map paramMap) throws Exception;    
    
    int deleteBookmarkGroup(Map paramMap) throws Exception;
    
    int saveBkmkGroupNm(Map paramMap) throws Exception;
    
    public List selectGroupNm(Map paramMap) throws Exception;
    
    int updateBkmkUserGroup(Map paramMap) throws Exception;
	
    /*
     * 20181212 2ksystem 즐겨찾기 추가
     * selectBkmkGroupList
     * selectBkmkSubGroupList
     * */
    
    List<Map> selectBkmkGroupList(Map paramMap) throws Exception;
    
    List<Map> selectBkmkSubGroupList(Map paramMap) throws Exception;    
    
}
