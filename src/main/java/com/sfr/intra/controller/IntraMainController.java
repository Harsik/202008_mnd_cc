package com.sfr.intra.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.sfr.common.PagerVO;
import com.sfr.intra.service.IntraService;
import com.sfr.operator.controller.search.PagingVO;

import egovframework.com.cmm.Util;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestMapping("/intra")
public class IntraMainController {

	private Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Value("#{sfr_config['file.upload.path']}")
	private String uploadpath1;

	@Autowired
	private IntraService intraService;
	
	
	/**
	 * 메인 화면
	 * @return
	 */
	@RequestMapping("/main.do")
	public String intra_main(ModelMap model, HttpServletRequest request, @RequestParam Map paramMap) throws Exception {
		//HttpSession session = request.getSession();
		String id  = (String) request.getSession().getAttribute("user_id");
		
		System.out.println("maind : id ="+id);
		//session.setAttribute("user_name", "name");
		//session.setAttribute("userCd","2");
    	
		return "intra/main.intra";
	}

	
	/*
	 * 인트라넷 공지사항 리스트 
	 * 
	 */
	@RequestMapping("/intraNoticeList.do")
	public String intranoticeList(@RequestParam Map paramMap, Model model, HttpServletRequest requset, @ModelAttribute("searchVO") PagerVO vo ) throws Exception {
		
		
		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(vo.getCurrentPage()); //현재 페이지 번호
		paginationInfo.setRecordCountPerPage(vo.getRecordCountPerPage());
		paginationInfo.setPageSize(vo.getPageSize());
		
		vo.setFirstIndex(paginationInfo.getFirstRecordIndex());
		vo.setLastIndex(paginationInfo.getLastRecordIndex());
		vo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		paramMap.put("firstIndex", paginationInfo.getFirstRecordIndex());
		paramMap.put("lastIndex", paginationInfo.getLastRecordIndex());
		paramMap.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());
		
		
		//paramMap.put("mildsc" , "A");
		
		paramMap.put("boardCd", 1);
		
		List<Map> list =  intraService.selectBoardList(paramMap);
		int cnt = intraService.getTotalCount(paramMap);
		paginationInfo.setTotalRecordCount(cnt);
		list.get(0).put("content", list.get(0).get("content").toString().replace("\r\n", "</br>").replace("&quot;", "'"));
		model.addAttribute("list", list);
		model.addAttribute("cnt", cnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        
		return "intra/notice/noticePopup.intra";
	}

	@RequestMapping("/intraNoticeListAjax.do")
	public @ResponseBody ModelAndView intranoticeListAjax(@RequestParam Map paramMap,  HttpServletRequest requset, @ModelAttribute("searchVO") PagingVO vo ) throws Exception {
		ModelAndView model = new ModelAndView("jsonView");
		
		/** pageing */
		

		vo.setPageSize(5); // 한 페이지에 보일 게시글 수
		vo.setPageNo(1); // 현재 페이지 번호
		
		if(vo.getSetPageNum() != 0){
			vo.setPageNo(vo.getSetPageNum());
		}
		vo.setBlockSize(10);
		
		paramMap.put("boardCd", 1);
		
		paramMap.put("endRowNum", vo.getEndRowNum());
		paramMap.put("startRowNum", vo.getStartRowNum());
		
		List<Map> list =  intraService.selectBoardListAjax(paramMap);
		
		int cnt = intraService.getTotalCount(paramMap);
		System.out.println(list.size());
		vo.setTotalCount(cnt);
		model.addObject("list", list);
        model.addObject("paginationInfoAjax", vo);
        
        
		return model;
	}
	
	
	/*
	 * 인트라넷 공지사항 리스트 상세
	 *  
	 * 
	 */
	@RequestMapping("/intraNoticeDetail.do")
	public String intraNoticeDetail(@RequestParam Map paramMap, Model model, HttpServletRequest requset, @ModelAttribute("searchVO") PagerVO vo ) throws Exception {
		
		paramMap.put("boardCd", 1);
		paramMap.put("seq", paramMap.get("seq"));
			
		intraService.updateBoardCnt(paramMap);	
		
		List<Map> list =  intraService.selectNoticeDetail(paramMap);
		model.addAttribute("list", list);
        
        
		return "intra/notice/noticeDetailPopup.intra";
	}
	
	
	
	@RequestMapping(value="/insertBookmark.do", method=RequestMethod.POST)
	public @ResponseBody ModelAndView insertBookmark(@RequestParam Map paramMap, HttpServletRequest requset ) throws Exception{
		
		ModelAndView model = new ModelAndView("jsonView");
		
		Map logMap = new HashMap<>();
		
		String mildsc = (String) requset.getSession().getAttribute("mildsc");
		String id =  (String) requset.getSession().getAttribute("user_id");
		
		paramMap.put("mildsc", mildsc);
		paramMap.put("id", id);
		paramMap.put("bookmarkMildsc", paramMap.get("bookmarkMildsc"));
		paramMap.put("bookmarkId", paramMap.get("bookmarkId"));
		paramMap.put("bookmarkDeptCd", paramMap.get("bookmarkDeptCd"));
		

		int count = intraService.BookUserCk(paramMap);
		
		if(count == 0) {
			int result =	intraService.insertBookmark(paramMap);
		//	System.out.println(result);
			model.addObject("result", result);
		}else {
			
			model.addObject("result", "200");
		}
		
		
		return model;
	}
	
	/**
	 * 마이페이지 (즐겨찾기 리스트)
	 * @return
	 */
	@RequestMapping("/myPage.do")
	public String myPage(@RequestParam Map paramMap, Model model, HttpServletRequest requset, @ModelAttribute("searchVO") PagerVO vo) throws Exception {

		return "intra/myPage.intra";
	}	
/*	
 * 20181212 2ksysatem 즐겨찾기 수정
 * 
	@RequestMapping("/myPage.do")
	public String myPage(@RequestParam Map paramMap, Model model, HttpServletRequest requset, @ModelAttribute("searchVO") PagerVO vo) throws Exception {

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(vo.getCurrentPage()); //현재 페이지 번호
		paginationInfo.setRecordCountPerPage(vo.getRecordCountPerPage());
		paginationInfo.setPageSize(vo.getPageSize());
		
		vo.setFirstIndex(paginationInfo.getFirstRecordIndex());
		vo.setLastIndex(paginationInfo.getLastRecordIndex());
		vo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		paramMap.put("firstIndex", paginationInfo.getFirstRecordIndex());
		paramMap.put("lastIndex", paginationInfo.getLastRecordIndex());
		paramMap.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());
		
		
		//paramMap.put("mildsc" , "A");
		
		//paramMap.put("boardCd", 1);
		String mildsc = (String) requset.getSession().getAttribute("mildsc");
		String id =  (String) requset.getSession().getAttribute("user_id");
		
		paramMap.put("mildsc", mildsc);
		paramMap.put("id", id);
		
		List<Map> list =  intraService.selectBookmarkList(paramMap);
		int cnt = intraService.getBookmarkCount(paramMap);
		
		paginationInfo.setTotalRecordCount(cnt);
		model.addAttribute("list", list);
		model.addAttribute("cnt", cnt);
        model.addAttribute("paginationInfo", paginationInfo);
		
		return "intra/myPage.intra";
	}	
*/	
	@RequestMapping("/myPageAjax.do")
	public @ResponseBody ModelAndView myPageAjax(@RequestParam Map paramMap,  HttpServletRequest requset, @ModelAttribute("searchVO") PagingVO vo) throws Exception {
		
	ModelAndView model = new ModelAndView("jsonView");
		
		
		/** pageing */
		
		vo.setPageSize(10); // 한 페이지에 보일 게시글 수
		vo.setPageNo(1); // 현재 페이지 번호
		
		if(vo.getSetPageNum() != 0){
			vo.setPageNo(vo.getSetPageNum());
		}
		vo.setBlockSize(10);
		
		//paramMap.put("mildsc" , "A");
		
		paramMap.put("boardCd", 1);
		String mildsc = (String) requset.getSession().getAttribute("mildsc");
		String id =  (String) requset.getSession().getAttribute("user_id");
		
		paramMap.put("mildsc", mildsc);
		paramMap.put("id", id);
		
		paramMap.put("endRowNum", vo.getEndRowNum());
		paramMap.put("startRowNum", vo.getStartRowNum());
		
		List<Map> list =  intraService.selectBookmarkListAjax(paramMap);
		int cnt = intraService.getBookmarkCount(paramMap);
		vo.setTotalCount(cnt);
		model.addObject("list", list);
        model.addObject("myPaginationInfo", vo);
        
		return model;
	}
	

	@RequestMapping("/deleteBookMark.do")
	public String deleteBookMark(@RequestParam Map paramMap, Model model, HttpServletRequest requset) throws Exception {
		
		String mildsc = (String) requset.getSession().getAttribute("mildsc");
		String id =  (String) requset.getSession().getAttribute("user_id");
		
		paramMap.put("seq", paramMap.get("seq"));
		paramMap.put("mildsc", mildsc);
		paramMap.put("id", id);
		int result = intraService.deleteBookMark(paramMap);
		
		return "redirect:/intra/myPage.intra";
		
		/*
		 * 20181212 2ksystem 즐겨찾기 수정
		return "redirect:/intra/myPage.do";
		*/
	}
	
	
	@RequestMapping("/deleteBookMarkAjax.do")
	public @ResponseBody ModelAndView deleteBookMarkAjax(@RequestParam Map paramMap, HttpServletRequest requset) throws Exception {
		
		ModelAndView model = new ModelAndView("jsonView");
		
		String mildsc = (String) requset.getSession().getAttribute("mildsc");
		String id =  (String) requset.getSession().getAttribute("user_id");
		
		paramMap.put("seq", paramMap.get("seq"));
		paramMap.put("mildsc", mildsc);
		paramMap.put("id", id);
	
		int result = intraService.deleteBookMark(paramMap);
		
		model.addObject("result", result);
		
		return model;
	}
	
	
	/**
	 * 검색이력(리스트)
	 * @return
	 */
	@RequestMapping("/searchHistory.do")
	public String searchHistory(){
		
		return "intra/searchHistory.intra";
	}
	
	@RequestMapping(value="/selectSearchHistList.do", method=RequestMethod.POST)
	public @ResponseBody ModelAndView selectSearchHistList(@RequestParam Map paramMap,  HttpServletRequest requset) throws Exception {
		
		ModelAndView model = new ModelAndView("jsonView");
		
		String mildsc = (String) requset.getSession().getAttribute("mildsc");
		String id =  (String) requset.getSession().getAttribute("user_id");
		
		paramMap.put("mildsc", mildsc);
		paramMap.put("id", id);
		
		
		List<Map> map = intraService.selectSearchHistList(paramMap);
		
		model.addObject("list", map);
		
		return model;
	}

	/**
	 * 팝업 레이아웃 샘플 화면
	 * @return
	 */
	@RequestMapping("/callOperatorPopup.do")
	public String callOperatorPopup(){
		
		return "operator/operatorCallPoup.popup";
	}	

	
	
	/**
	 * 메뉴
	 * @return
	 */
	@RequestMapping(value="/getTree.do")
	public @ResponseBody List getMenu(ModelMap model, HttpServletRequest request, @RequestParam Map paramMap) throws Exception {
		/*
		paramMap.put("mildsc", "A");
		paramMap.put("hgrnkDeptCd", "0");
		*/
		List <Map> list = new ArrayList(); 
		/*		
		Map tempMap = new HashMap();
		
		tempMap.put("id", "0");
		tempMap.put("parent", "#");
		tempMap.put("text", "ROOT");
		
		list.add(tempMap);
		*/
		list.addAll(intraService.selectDeptTree(paramMap));
		
		//list.get(0).put("parent", "#");

		return list;
	}
	
	
	@RequestMapping(value="/selectDeptList.do", method=RequestMethod.POST)
	public @ResponseBody ModelAndView selectDeptList(HttpServletRequest request, @RequestParam Map paramMap, @ModelAttribute("searchVO") PagingVO vo) throws Exception {
		
		ModelAndView model = new ModelAndView("jsonView");
		
		vo.setPageSize(10); // 한 페이지에 보일 게시글 수
		vo.setPageNo(1); // 현재 페이지 번호
		
		if(vo.getSetPageNum() != 0){
			vo.setPageNo(vo.getSetPageNum());
		}
		vo.setBlockSize(10);
		
		
		paramMap.put("mildsc", paramMap.get("mildsc"));
		paramMap.put("deptCd", paramMap.get("deptCd"));
		
		paramMap.put("endRowNum", vo.getEndRowNum());
		paramMap.put("startRowNum", vo.getStartRowNum());
		
		
		List<Map> list = new ArrayList<>();
		list = intraService.selectDeptList(paramMap);
		int toTalCount = intraService.getDeptCount(paramMap);
		vo.setTotalCount(toTalCount);
		
		System.out.println("############" +toTalCount);
		
		model.addObject("paging",vo);
		model.addObject("list",list);
		
		return model;
	}
	
	@RequestMapping(value="/selectfacilityList.do", method=RequestMethod.POST)
	public @ResponseBody ModelAndView selectfacilityList(HttpServletRequest request, @RequestParam Map paramMap, @ModelAttribute("searchVO") PagingVO vo) throws Exception {
		
		ModelAndView model = new ModelAndView("jsonView");
		
		vo.setPageSize(10); // 한 페이지에 보일 게시글 수
		vo.setPageNo(1); // 현재 페이지 번호
		
		if(vo.getSetPageNum() != 0){
			vo.setPageNo(vo.getSetPageNum());
		}
		vo.setBlockSize(10);
		
		
		paramMap.put("mildsc", paramMap.get("mildsc"));
		paramMap.put("deptCd", paramMap.get("deptCd"));
		
		paramMap.put("endRowNum", vo.getEndRowNum());
		paramMap.put("startRowNum", vo.getStartRowNum());
		
		
		List<Map> list = new ArrayList<>();
		list = intraService.selectfacilityList(paramMap);
		
		int toTalCount = intraService.getfacilityCount(paramMap);
		vo.setTotalCount(toTalCount);
		
		
		model.addObject("paging",vo);
		model.addObject("list",list);
		
		return model;
	}
	
	@RequestMapping("/onpeOrganization.do")
	@ResponseBody
	public ModelAndView onpeOrganization(@RequestParam Map paramMap) {
		ModelAndView mav = new ModelAndView();

		// String page = paramMap.get("page").toString();
		// String mildsc = paramMap.get("mildsc").toString();
		// String nodeId = paramMap.get("nodeId").toString();

		mav.addObject("page", paramMap.get("page").toString());
		mav.addObject("mildsc", paramMap.get("mildsc").toString());
		mav.addObject("nodeId", paramMap.get("nodeId").toString());

		mav.setViewName("/intra/organization");

		return mav;
	}
	
	/**
	 * 묻고답하기 (Q&A 게시판)
	 * @return
	 */
	@RequestMapping("/insertQnaBoard.do")
	@ResponseBody
	public String insertQnaBoard(@RequestParam Map paramMap, Model model, HttpServletRequest requset) throws Exception {
		
		String mildsc = (String) requset.getSession().getAttribute("mildsc");
		String id =  (String) requset.getSession().getAttribute("user_id"); 
		String success = "500";
		
		paramMap.put("parentcd", paramMap.get("parentcd"));
		paramMap.put("seq", paramMap.get("seq"));
		paramMap.put("reply", paramMap.get("parent"));
		paramMap.put("title", paramMap.get("title"));
		paramMap.put("content", paramMap.get("content"));
		paramMap.put("regId", id);
		paramMap.put("mildsc", mildsc);
		paramMap.put("boardCd", "2");
		
		int result = intraService.insertQnaBoard(paramMap);
		
		if(result > 0) {
			success = "200";
		}
		
		return success;
	}
	
	@RequestMapping("/deleteQnaBoard.do")
	public String deleteQnaBoard(@RequestParam Map paramMap, Model model, HttpServletRequest requset) throws Exception {
		
		String mildsc = (String) requset.getSession().getAttribute("mildsc");
		String id =  (String) requset.getSession().getAttribute("user_id"); 
		
		paramMap.put("seq", paramMap.get("seq"));
		paramMap.put("reply", paramMap.get("parent"));
		paramMap.put("id", id);
		paramMap.put("mildsc", mildsc);
		int result = intraService.deleteQnaBoard(paramMap);
		
		return "redirect:/intra/qnaBoard.do";
	}
	
	@RequestMapping("/qnaBoard.do")
	public String qnaBoard(@RequestParam Map paramMap, Model model, HttpServletRequest requset, @ModelAttribute("searchVO") PagerVO vo) throws Exception {
		
		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(vo.getCurrentPage()); //현재 페이지 번호
		paginationInfo.setRecordCountPerPage(vo.getRecordCountPerPage());
		paginationInfo.setPageSize(vo.getPageSize());
		
		vo.setFirstIndex(paginationInfo.getFirstRecordIndex());
		vo.setLastIndex(paginationInfo.getLastRecordIndex());
		vo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		paramMap.put("firstIndex", paginationInfo.getFirstRecordIndex());
		paramMap.put("lastIndex", paginationInfo.getLastRecordIndex());
		paramMap.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());
		 
//		paramMap.put("boardCd", 2);
//		String mildsc = (String) requset.getSession().getAttribute("mildsc");
//		String id =  (String) requset.getSession().getAttribute("user_id");
//		
//		paramMap.put("mildsc", mildsc);
//		paramMap.put("id", id);
		
		List<Map> list =  intraService.selectQnaBoardList(paramMap);
		int cnt = intraService.getQnaCount(paramMap);
		
		paginationInfo.setTotalRecordCount(cnt);
		model.addAttribute("list", list);
		model.addAttribute("cnt", cnt);
        model.addAttribute("paginationInfo", paginationInfo);
		
		return "intra/qnaBoard.intra";
	}

	@RequestMapping("/detailQnaBoard.do")
	public @ResponseBody ModelAndView qnaDetailAjax(@RequestParam Map paramMap, HttpServletRequest requset, @ModelAttribute("searchVO") PagingVO vo ) throws Exception {
		ModelAndView model = new ModelAndView("jsonView");
		
		paramMap.put("seq", paramMap.get("seq"));
		paramMap.put("replyseq", paramMap.get("replyseq"));
		paramMap.put("mynm", paramMap.get("mynm"));
		List<Map> list =  intraService.selectQnaBoardList(paramMap);
		
		System.out.println(list.size());
		model.addObject("seq", paramMap.get("seq").toString());
		model.addObject("replyseq", paramMap.get("replyseq").toString());

		if(list.size() > 1) {
			Map map1 = list.get(0);
			Map map2 = list.get(1);
			model.addObject("list", map1);
			model.addObject("list_s", map2);
		} else if(list.size() == 1){
			model.addObject("list", list.get(0));
		}
		
		//model.addObject("list", list);
        model.setViewName("/intra/qna_modi");

		return model;
	}	
	
	@RequestMapping("/qnaWrite.do")
	public ModelAndView onpeQnaWrite(@RequestParam Map paramMap) {
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("mynm", paramMap.get("mynm").toString());
		
		if(paramMap.get("seq").toString() != "null") {
			mav.addObject("seq", paramMap.get("seq").toString());
		}
		
		if(paramMap.get("replyseq").toString() != "null") {
			mav.addObject("replyseq", paramMap.get("replyseq").toString());
		}
		
		mav.setViewName("/intra/qna_write");
		
		return mav;
	}
	
	@RequestMapping("/keepAlived.do")
	public @ResponseBody ModelAndView selectDual(@RequestParam Map paramMap, HttpServletRequest requset, @ModelAttribute("searchVO") PagerVO vo) throws Exception {
		ModelAndView model2 = new ModelAndView("jsonView");
		
		int cnt = intraService.selectDual(paramMap);    
		model2.addObject("result", cnt);
		return model2;
	}
	
    /**
     * 게시판  첨부파일 리스트
     * @return
     */
   @RequestMapping("/noticeFileAtchListAjax.do")
    public @ResponseBody ModelAndView noticeFileAtchListAjax(@RequestParam Map paramMap, HttpServletRequest requset) throws Exception {
        
        ModelAndView model = new ModelAndView("jsonView");
        
        paramMap.put("tbl_nm", "tbl_board");
        paramMap.put("tbl_pk",  paramMap.get("tbl_pk"));
    
        List<Map> result = new ArrayList<>();
        result = intraService.noticeFileAtchListAjax(paramMap);
        
        model.addObject("result", result);
        
        return model;
        
    }

   
   @SuppressWarnings("unchecked")
   @RequestMapping(value = "/fileDownload.do")
   public void fileDownload(HttpServletRequest req, HttpServletResponse res) throws Exception
   {
       //UserSession userSession = (UserSession)req.getSession().getAttribute("userSession");
       
       //if(userSession != null && !"".equals(userSession))
       //{

           HashMap prop = Util.paramsToMap(req);
           
           prop.put("fl_id", prop.get("id").toString());
           //Map getFile =  adminService.selectFile(paramMap);
           
           //TbFileVO getFile = intraService.selectFile(prop);
           //TbFileVO getFile = fileService.getFile(prop);
           Map getFile = intraService.selectFile(prop);
           
           String svr_fl_nm = getFile.get("svrFlNm").toString();
           String svrFilePath =  getFile.get("svrSvPth").toString();
           String fileName =  getFile.get("locFlNm").toString();
           
           fileName = URLEncoder.encode(fileName, "utf-8");
           
           File file = new File(svrFilePath);
           
           String mimetype = "application/download; charset=utf-8";

           res.setContentType(mimetype);
           
           res.setContentType("text/html;charset=ISO-8859-1");
           res.setContentLength((int) file.length());

           res.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\";");
           res.setHeader("Content-Transfer-Encoding", "binary");

           try (OutputStream out = res.getOutputStream();
                FileInputStream fis = new FileInputStream(file)) {
               FileCopyUtils.copy(fis, out);
               out.flush();
           } catch (Exception e) {
               e.printStackTrace();
           }
                     
   }
  
   /*
    * 인트라넷 즐겨찾기 그룹 리스트 
    * 
    */
   
   @RequestMapping("/intraBookmarkGroupListAjax.do")
   public @ResponseBody ModelAndView intraBookmarkGroupListAjax(@RequestParam Map paramMap,  HttpServletRequest requset, @ModelAttribute("searchVO") PagingVO vo ) throws Exception {
       ModelAndView model = new ModelAndView("jsonView");
       
       /** pageing */
       

       vo.setPageSize(10); // 한 페이지에 보일 게시글 수
       vo.setPageNo(1); // 현재 페이지 번호
       
       if(vo.getSetPageNum() != 0){
           vo.setPageNo(vo.getSetPageNum());
       }
       vo.setBlockSize(10);
       
       String id =  (String) requset.getSession().getAttribute("user_id");
       paramMap.put("id", id);
       
       paramMap.put("endRowNum", vo.getEndRowNum());
       paramMap.put("startRowNum", vo.getStartRowNum());
       
       List<Map> list =  intraService.selectBookmarkGroupAjax(paramMap);
       
       int cnt = intraService.getBookmarkGroupCount(paramMap);
       System.out.println(list.size());
       vo.setTotalCount(cnt);
       model.addObject("list", list);
       model.addObject("paginationInfoAjax", vo);
       
       
       return model;
   }
   
   @RequestMapping("/intraBookmarkGroupList.do")
   public  String intraBookmarkGroupList(@RequestParam Map paramMap, Model model, HttpServletRequest requset, @ModelAttribute("searchVO") PagerVO vo ) throws Exception {
       
       
       /** pageing */
       PaginationInfo paginationInfo = new PaginationInfo();
       paginationInfo.setCurrentPageNo(vo.getCurrentPage()); //현재 페이지 번호
       paginationInfo.setRecordCountPerPage(vo.getRecordCountPerPage());
       paginationInfo.setPageSize(vo.getPageSize());
       
       vo.setFirstIndex(paginationInfo.getFirstRecordIndex());
       vo.setLastIndex(paginationInfo.getLastRecordIndex());
       vo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
       
       paramMap.put("firstIndex", paginationInfo.getFirstRecordIndex());
       paramMap.put("lastIndex", paginationInfo.getLastRecordIndex());
       paramMap.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());
       
       
       String id =  (String) requset.getSession().getAttribute("user_id");
       paramMap.put("id", id);
       
       List<Map> list =  intraService.selectBookmarkGroupList(paramMap);
       int cnt = intraService.getBookmarkGroupCount(paramMap);
       System.out.println(list.size());
       paginationInfo.setTotalRecordCount(cnt);
       model.addAttribute("list", list);
       model.addAttribute("cnt", cnt);
       model.addAttribute("paginationInfo", paginationInfo);
       
       
       return "intra/bkmkGroupList.intra";
       
   }
   
   
   @RequestMapping("/deleteBkmk.do")
   public String deleteBkmk(@RequestParam Map paramMap, Model model, HttpServletRequest requset) throws Exception {
       paramMap.put("seq", paramMap.get("seq"));
       int result = intraService.deleteBookmarkGroup(paramMap);

       return "redirect:/intra/intraBookmarkGroupList.do";
       
   }   
   
   @RequestMapping("/bkmkGroupPopup.do")
   @ResponseBody
   public ModelAndView onpeBkmkPopup(@RequestParam Map paramMap) {
       ModelAndView mav = new ModelAndView();
             
       if(paramMap.get("dType").toString() != "null") {
           mav.addObject("dType", paramMap.get("dType").toString());
       }
       
       if(paramMap.get("seq").toString() != "null") {
           mav.addObject("seq", paramMap.get("seq").toString());
       }
       
       if(paramMap.get("gNm").toString() != "null") {
           mav.addObject("gNm", paramMap.get("gNm").toString());
       }       
       
       mav.setViewName("/intra/bkmk_Group");
       
       return mav;
   }   
   
   /**
    * 즐겨찾기 그룹명 저장
    * @return
    */
   @RequestMapping("/saveBkmkGroupNm.do")
   @ResponseBody
   public String saveBkmkGroupNm(@RequestParam Map paramMap, Model model, HttpServletRequest requset) throws Exception {

       String id =  (String) requset.getSession().getAttribute("user_id"); 
       String success = "500";
       
       paramMap.put("ptype", paramMap.get("pType"));
       paramMap.put("seq", paramMap.get("pSeq"));
       paramMap.put("group_nm", paramMap.get("pGNm"));

       paramMap.put("id", id);
       
       int result = intraService.saveBkmkGroupNm(paramMap);
       
       if(result > 0) {
           success = "200";
       }
       
       return success;
   }
   
   @RequestMapping("/bkmkSelectGroupPopup.do")
   public @ResponseBody ModelAndView bkmkSelectGroupPopup(@RequestParam Map paramMap, HttpServletRequest request) throws Exception {
       ModelAndView model = new ModelAndView("jsonView");
       
       String id =  (String) request.getSession().getAttribute("user_id");
       paramMap.put("id", id);
       
       model.addObject("popType", paramMap.get("popType").toString());
       
       List<Map> groupList =  intraService.selectGroupNm(paramMap);
       
       System.out.println(groupList.size());

       //if(groupList.size() == 1){
           model.addObject("groupList", groupList);
       //}

       model.setViewName("/intra/bkmk_SelectGroupList");

       return model;
   }   
   
   /**
    * 마이페이지 즐겨찾기 그룹명 수정
    * @return
    */
   @RequestMapping("/updateBkmkUserGroup.do")
   @ResponseBody
   public String updateBkmkUserGroup(@RequestParam Map paramMap, Model model, HttpServletRequest requset) throws Exception {

       String id =  (String) requset.getSession().getAttribute("user_id"); 
       String success = "500";
              
       paramMap.put("seq", paramMap.get("seq"));
       paramMap.put("mildsc", paramMap.get("mildsc"));
       paramMap.put("group_id", paramMap.get("group_id"));

       paramMap.put("id", id);
       
       int result = intraService.updateBkmkUserGroup(paramMap);
       
       if(result > 0) {
           success = "200";
       }
       
       return success;
   } 
   
   /*
    * 20181212 2ksystem 즐겨찾기 추가
    * @RequestMapping(value="/intraBkmkGroupList.do")
    * @RequestMapping(value="/intraBkmkSubGroupList.do")
    * */
   @RequestMapping(value="/intraBkmkGroupList.do")
   public @ResponseBody List intraBkmkGroupList(ModelMap model, HttpServletRequest request, @RequestParam Map paramMap) throws Exception {

       String id =  (String) request.getSession().getAttribute("user_id");
       paramMap.put("id", id);
       
       List <Map> list = new ArrayList(); 

       list.addAll(intraService.selectBkmkGroupList(paramMap));
       
       return list;
   }   
 
   @RequestMapping(value="/intraBkmkSubGroupList.do")
   public @ResponseBody List intraBkmkSubGroupList(ModelMap model, HttpServletRequest request, @RequestParam Map paramMap) throws Exception {

       String mildsc = (String) request.getSession().getAttribute("mildsc");       
       String id =  (String) request.getSession().getAttribute("user_id");
       
       paramMap.put("mildsc", mildsc);
       paramMap.put("id", id);
       paramMap.put("group_id", paramMap.get("group_id"));
       
       List <Map> list = new ArrayList(); 

       list.addAll(intraService.selectBkmkSubGroupList(paramMap));
       
       return list;
   }    
   
}
