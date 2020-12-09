package com.sfr.intra.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sfr.intra.dao.IntraDao;
import com.sfr.intra.service.IntraService;

@Service
public class IntraServiceImpl implements IntraService{
	
	@Autowired
	private IntraDao intraDao;
	
	@Override
	public Map intraLogin(Map paramMap) throws Exception{
		return intraDao.intraLogin(paramMap);
	}
	
	/*
	 * 
	 * 게시판 리스트
	 * */
	@Override
	public List selectBoardList(Map paramMap) throws Exception {
		 
		
		return  intraDao.selectBoardList(paramMap);
	}



	@Override
	public List selectBoardListAjax(Map paramMap) throws Exception {
		return intraDao.selectBoardListAjax(paramMap);
	}
	
	
	/*
	 * 
	 * 게시판 총카운트
	 * */
	@Override
	public int getTotalCount(Map paramMap) throws Exception {
		
		return intraDao.getTotalCount(paramMap);
	}


	/*
	 * 게시판 상세
	 * 
	 * */
	@Override
	public List<Map> selectNoticeDetail(Map paramMap) throws Exception {
		
		return intraDao.selectBoardDetail(paramMap);
	}
	/*
	 * 게시판 조회수
	 * */
	@Override
	public void updateBoardCnt(Map paramMap) throws Exception {
		intraDao.updateBoardCnt(paramMap);
		
	}

	/*
	 * 즐겨찾기 등록
	 * */
	@Override
	public int insertBookmark(Map paramMap) {
		
		return intraDao.insertBookmark(paramMap);
	}

	/*
	 * 즐겨찾기 리스트
	 * */
	@Override
	public List<Map> selectBookmarkList(Map paramMap) throws Exception {
		
		return intraDao.selectBookmarkList(paramMap);
	}

	/*
	 * 조직도
	 * */
	@Override
	public List selectDeptTree(Map paramMap) {
		
		return intraDao.selectDeptTree(paramMap);
	}

	@Override
	public int getBookmarkCount(Map paramMap) throws Exception {
		
		return intraDao.getBookmarkCount(paramMap);
	}

	@Override
	public int deleteBookMark(Map paramMap) throws Exception {
	 return	intraDao.deleteBookmarK(paramMap);
		
	}

	@Override
	public int insertSearchHist(Map paramMap) throws Exception {
		return intraDao.inserSearchHist(paramMap);
		
	}

	@Override
	public List<Map> selectSearchHistList(Map paramMap) throws Exception {
		
		return intraDao.selectSearchHistList(paramMap);
	}

	@Override
	public List<Map> selectDeptList(Map paramMap) throws Exception {
		
		return intraDao.selectDeptList(paramMap);
	}

	@Override
	public int getDeptCount(Map paramMap) throws Exception {
		
		return intraDao.getDeptCount(paramMap);
	}

	@Override
	public Map intraLoginA(Map paramMap) throws Exception {
		return intraDao.intraLoginA(paramMap);
	}
	
	@Override
	public List<Map> selectBookmarkListAjax(Map paramMap) throws Exception {
		
		return intraDao.selectBookmarkListAjax(paramMap);
	}
	
	@Override
	public int BookUserCk(Map paramMap) throws Exception {
		return intraDao.BookUserCk(paramMap);
	}
	
	@Override
	public List<Map> selectfacilityList(Map paramMap) throws Exception {
		
		return intraDao.selectfacilityList(paramMap);
	}

	@Override
	public int getfacilityCount(Map paramMap) throws Exception {
		
		return intraDao.getfacilityCount(paramMap);
	}
	
	@Override
	public int insertQnaBoard(Map paramMap) throws Exception {
		return intraDao.insertQnaBoard(paramMap); 
	}

	@Override
	public int deleteQnaBoard(Map paramMap) throws Exception {
		return intraDao.deleteQnaBoard(paramMap); 
	}

	@Override
	public int getQnaCount(Map paramMap) throws Exception {
		return intraDao.getQnaCount(paramMap); 
	}
	
	@Override
	public List<Map> selectQnaBoardList(Map paramMap) throws Exception {
		return intraDao.selectQnaBoardList(paramMap); 
	}

	@Override
	public int selectDual(Map paramMap) throws Exception {
		return intraDao.selectDual(paramMap); 
	}

    /*
     * 공지사항 첨부파일 리스트 조회 
     * */    
    @Override
    public List noticeFileAtchListAjax(Map paramMap) throws Exception {
        return intraDao.noticeFileAtchListAjax(paramMap);
    }  
    
    /*
     * 공지사항 첨부파일 다운로드 정보
     * */   
    @Override
    public Map selectFile(HashMap paramMap) throws Exception {
        return intraDao.selectFile(paramMap);
    }
    
    /*
     * 
     * 즐겨찾기 그룹 리스트
     * */
    @Override
    public List selectBookmarkGroupAjax(Map paramMap) throws Exception {
        return intraDao.selectBookmarkGroupAjax(paramMap);
    }

    @Override
    public List selectBookmarkGroupList(Map paramMap) throws Exception {
        return intraDao.selectBookmarkGroupList(paramMap);
    }

    /*
     * 
     * 즐겨찾기 그룹 총카운트
     * */
    @Override
    public int getBookmarkGroupCount(Map paramMap) throws Exception {       
        return intraDao.getBookmarkGroupCount(paramMap);
    }
    
    @Override
    public int deleteBookmarkGroup(Map paramMap) throws Exception {
        return intraDao.deleteBookmarkGroup(paramMap); 
    }
    
    @Override
    public int saveBkmkGroupNm(Map paramMap) throws Exception {
        return intraDao.saveBkmkGroupNm(paramMap); 
    }
    
    @Override
    public List selectGroupNm(Map paramMap) throws Exception {
        return intraDao.selectGroupNm(paramMap);
    }
    
    @Override
    public int updateBkmkUserGroup(Map paramMap) throws Exception {
        return intraDao.updateBkmkUserGroup(paramMap); 
    }
    
    /*
     * 20181212 2ksystem 즐겨찾기 추가
     * selectBkmkGroupList
     * selectBkmkSubGroupList
     * */
    @Override
    public List selectBkmkGroupList(Map paramMap) throws Exception {
        return intraDao.selectBkmkGroupList(paramMap);
    }    
    
    @Override
    public List selectBkmkSubGroupList(Map paramMap) throws Exception {
        return intraDao.selectBkmkSubGroupList(paramMap);
    }
    
}
