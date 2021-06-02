package com.sfr.admin.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sfr.admin.dao.AdminDao;
import com.sfr.admin.service.AdminService;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service
public class AdminServiceImpl extends EgovAbstractServiceImpl implements AdminService  {

	@Autowired
	private AdminDao adminDao;


	@Override
	public List selectDeptList(Map paramMap) throws Exception {
		return adminDao.selectDeptList(paramMap);
	}
	
	

	@Override
	public Map selectDeptNm(Map paramMap) throws Exception {
		return adminDao.selectDeptNm(paramMap);
	}
	
	@Override
	public Map selectDeptTopNm(Map paramMap) throws Exception {
		return adminDao.selectDeptTopNm(paramMap);
	}
	
	@Override
	public List selectUserList(Map map) throws Exception {
		return adminDao.selectUserList(map);
	}

	@Override
	public int getUserCount(Map map) throws Exception {
		return adminDao.getUserCount(map);
	}

	/*
	 * 공지사항 리스트
	 * */
	@Override
	public List<Map> selectBoardList(Map paramMap) throws Exception {
		
		return adminDao.selectBoardList(paramMap);
	}
	/*
	 * 공지사항 총 카운트
	 * */
	@Override
	public int getBoardCount(Map paramMap) throws Exception {
		 
		return adminDao.getBoardCount(paramMap);
	}

	/*
	 * 공지사항 상세 
	 * */
	@Override
	public List<Map> selectBoardDetail(Map paramMap) throws Exception {
		
		return adminDao.selectBoardDetail(paramMap);
	}

	@Override
	public void updateBoard(Map paramMap) throws Exception {
		adminDao.updateBoard(paramMap);
		
	}

	@Override
	public void insertBoard(Map paramMap) throws Exception {
		adminDao.insertBoard(paramMap);
		
	}

	@Override
	public void deleteBoard(Map paramMap) throws Exception {
		adminDao.deleteBoard(paramMap);
		
	}
	
	@Override
	public Map adminLogin(Map paramMap) throws Exception {
		return adminDao.adminLogin(paramMap);
	}

	@Override
	public void connlog(Map paramMap) throws Exception {
		adminDao.connLog(paramMap);
	}
	
	@Override
	public void connErrlog(Map paramMap) throws Exception {
		adminDao.connErrLog(paramMap);
	}
		
	@Override
	public void connMngr(Map paramMap) throws Exception {
		adminDao.connMngr(paramMap);
	}

	
	
	
	
	@Override
	public List selectFacList(Map paramMap) throws Exception {
		return adminDao.selectFacList(paramMap);
	}

	@Override
	public int getFacCount(Map paramMap) throws Exception {
		return adminDao.getFacCount(paramMap);
	}

	@Override
	public Map selectFacDetail(Map paramMap) throws Exception {
		return adminDao.selectFacDetail(paramMap);
	}

	@Override
	public int insertFac(Map paramMap) throws Exception {
		return adminDao.insertFac(paramMap);
	}

	@Override
	public int deleteFac(Map paramMap) throws Exception {
		return adminDao.deleteFac(paramMap);
	}

	@Override
	public int updateFac(Map paramMap) throws Exception {
		return adminDao.updateFac(paramMap);
	}



	@Override
	public List selectGeneralDeptList(Map paramMap) throws Exception {
		
		return adminDao.selectGeneralDeptList(paramMap);
	}



	@Override
	public void insertMngr(Map paramMap) throws Exception {
		
		adminDao.insertMngr(paramMap);
	}



	@Override
	public List<Map> selectGeneralList(Map paramMap) throws Exception {
		
		return adminDao.selectGeneralList(paramMap);
	}



	@Override
	public int getMngrCount(Map paramMap) throws Exception {
		return adminDao.getMngrCount(paramMap);
	}



	@Override
	public List<Map> selectMngrDetail(Map paramMap) throws Exception {
		
		return adminDao.selectMngrDetail(paramMap);
	}



	@Override
	public void deleteMngr(Map paramMap) throws Exception {
		adminDao.deleteMngr(paramMap);
		
	}


	@Override
	public void updateMngr(Map paramMap) throws Exception {
		adminDao.updateMngr(paramMap);
		
	}


	@Override
	public List<Map> selectOperatorList(Map paramMap) throws Exception {
		
		return adminDao.selectOperatorList(paramMap);
	}



	@Override
	public List<Map> selectAdminList(Map paramMap) throws Exception {
		
		return adminDao.selectAdminList(paramMap);
	}



	@Override
	public List<Map> selectuserListCk(Map paramMap) throws Exception {
		return adminDao.selectuserListCk(paramMap);
	}



	@Override
	public String getDeptCd(Map paramMap) throws Exception {
		
		return adminDao.getDeptCd(paramMap);
	}



	@Override
	public List selectDeptTopList(Map paramMap) throws Exception {

		return adminDao.selectDeptTopList(paramMap);
	}



	@Override
	public void changeMngrPw(Map paramMap) throws Exception {
		adminDao.changeMngrPw(paramMap);
	}

	   /*
     * 공지사항 첨부파일 정보 저장
     * */
    @Override
    public void insertNoticeFileAtch(Map paramMap) throws Exception {
        adminDao.insertNoticeFileAtch(paramMap);
    }

    /*
     * 공지사항 첨부파일 키 생성 
     * */    
    @Override
    public int getFileAtchSer() throws Exception {
        return adminDao.getFileAtchSer();
    }
    
    /*
     * 공지사항 첨부파일 리스트 조회 
     * */    
    @Override
    public List noticeFileAtchListAjax(Map paramMap) throws Exception {

        return adminDao.noticeFileAtchListAjax(paramMap);
    }    
    
    /*
     * 공지사항 첨부파일 삭제 
     * */    
    @Override
    public int deleteFileAtchListAjax(Map paramMap) throws Exception {

        return adminDao.deleteFileAtchListAjax(paramMap);
    } 
    
    /*
     * 공지사항 첨부파일 다운로드 정보
     * */   
    @Override
    public Map selectFile(HashMap paramMap) throws Exception {
        return adminDao.selectFile(paramMap);
    }


}
