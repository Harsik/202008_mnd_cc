package com.sfr.admin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface AdminService {


	/**
	 * mildsc 상위부서 코드로 1 depth 아래 하위부서 리스트를 가져옴
	 * 
	 * @param mildsc,
	 *            hgrnkDeptCd
	 * 
	 */
	public List selectDeptTopList(Map paramMap) throws Exception;
	/**
	 * mildsc, hgrnkDeptCd 상위부서 코드로 1 depth 아래 하위부서 리스트를 가져옴
	 * 
	 * @param mildsc,
	 *            hgrnkDeptCd
	 * 
	 */
	public List selectDeptList(Map paramMap) throws Exception;


	public Map selectDeptNm(Map paramMap) throws Exception;
	
	public Map selectDeptTopNm(Map paramMap) throws Exception;

	List selectUserList(Map paramMap) throws Exception;

	int getUserCount(Map paramMap) throws Exception;

	/**
	 * 공지사한 리스트
	 */
	List<Map> selectBoardList(Map paramMap) throws Exception;

	/**
	 * 총 count
	 */
	int getBoardCount(Map paramMap) throws Exception;

	List<Map> selectBoardDetail(Map paramMap) throws Exception;

	void updateBoard(Map paramMap) throws Exception;

	void insertBoard(Map paramMap) throws Exception;

	void deleteBoard(Map paramMap) throws Exception;

	Map adminLogin(Map paramMap) throws Exception;

	void connlog(Map paramMap) throws Exception;

	void connMngr(Map paramMap) throws Exception;

	/**
	 * 시설물 리스트 가져옴
	 * 
	 * @param regId,
	 *            searchTxt, auth
	 * 
	 *            regId 는 관리자ID 임.. 각군 userId 아님..
	 * 
	 *            Paging .. admin user list 참고
	 * 
	 */
	public List selectFacList(Map paramMap) throws Exception;

	/**
	 * 시설물 갯수
	 * 
	 * @param regId,
	 *            searchTxt, auth
	 * 
	 *            regId 는 관리자ID 임.. 각군 userId 아님..
	 * 
	 * 
	 * 
	 */
	public int getFacCount(Map paramMap) throws Exception;

	/**
	 * 시설물 상세 페이지
	 * 
	 * @param seq,
	 *            regIp
	 * 
	 */
	public Map selectFacDetail(Map paramMap) throws Exception;

	/**
	 * 시설물 등록
	 * 
	 * @param mildsc,
	 *            facilityCd, deptCd, tel, regId, regMildsc, regIp, fullDeptCd
	 * 
	 *            fullDeptCd = deptCd 포함 상위부서코드 전체 ex) A^A10000^A110001^A111111
	 * 
	 * 
	 */
	public int insertFac(Map paramMap) throws Exception;

	/**
	 * 시설물 삭제
	 * 
	 * @param seq,
	 *            regIp
	 * 
	 * 
	 * 
	 */
	public int deleteFac(Map paramMap) throws Exception;

	/**
	 * 시설물 수정
	 * 
	 * @param seq,
	 *            regId, facilityCd, fullDeptCd, tel, deptCd, uptId, uptMildsc,
	 *            uptIp
	 * 
	 *            fullDeptCd = deptCd 포함 상위부서코드 전체 ex) A^A10000^A110001^A111111
	 * 
	 * 
	 */
	public int updateFac(Map paramMap) throws Exception;

	public List selectGeneralDeptList(Map paramMap) throws Exception;

	public void insertMngr(Map paramMap) throws Exception;

	public List<Map> selectGeneralList(Map paramMap) throws Exception;

	public int getMngrCount(Map paramMap) throws Exception;

	public List<Map> selectMngrDetail(Map paramMap) throws Exception;

	public void deleteMngr(Map paramMap) throws Exception;

	public void updateMngr(Map paramMap) throws Exception;


	public List<Map> selectOperatorList(Map paramMap) throws Exception;


	public List<Map> selectAdminList(Map paramMap) throws Exception;


	public List<Map> selectuserListCk(Map paramMap) throws Exception;


	public String getDeptCd(Map paramMap) throws Exception;
	
	public void changeMngrPw(Map paramMap) throws Exception;

    /**
     * 공지게시판 첨부파일 등록
     * 
     * @param locfl_nm :local file name,
     *          fl_sz : file size, 
     *          fl_ext : 확장자명,
     *          svrfl_nm : server file name
     *          svrfl_pth : server file path 
     * 
     */
    public void insertNoticeFileAtch(Map paramMap) throws Exception;
    
    /**
     * 공지게시판 첨부파일 시퀀스(시리얼) 생성
     * 
     * @param 
     * 
     */
    public int getFileAtchSer() throws Exception;
    
    /**
     * 공지게시판 첨부파일 리스트 조회
     * 
     * @param 
     * 
     */    
    public List<Map> noticeFileAtchListAjax(Map paramMap) throws Exception;
    
    /**
     * 공지게시판 첨부파일 삭제
     * 
     * @param 
     * 
     */    
    public int deleteFileAtchListAjax(Map paramMap) throws Exception;    
    
    /**
     * 공지게시판 첨부파일 다운로드 정보
     * 
     * @param 
     *         
     * 
     */
    public Map selectFile(HashMap paramMap) throws Exception;    
    
}
