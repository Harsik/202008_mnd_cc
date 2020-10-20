package com.sfr.admin.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.sfr.admin.service.AdminService;
import com.sfr.admin.service.FileService;
import com.sfr.common.PagerVO;
import com.sfr.common.StringUtils;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import kr.co.twoksystem.config.Config;

import egovframework.com.cmm.Util;

@Controller
@RequestMapping("/admin")
public class NoticeController {

	@Autowired
	private AdminService adminService;
	
	@Autowired
	@Resource(name = "fileService")
    private FileService fileService;
	 
	/**
	 * 게시판  리스트
	 * @return
	 */
	@RequestMapping("/noticeList.do")
	public String noticeList(@RequestParam Map paramMap, ModelMap model, HttpServletRequest requset, @ModelAttribute("searchVO") PagerVO vo) throws Exception{
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
		
		
		paramMap.put("boardCd", 1);
		
		List<Map> list =  adminService.selectBoardList(paramMap);
		int cnt = adminService.getBoardCount(paramMap);
		
		paginationInfo.setTotalRecordCount(cnt);
		
		model.addAttribute("list", list);
		model.addAttribute("cnt", cnt);
		model.addAttribute("paramMap", paramMap);
        model.addAttribute("paginationInfo", paginationInfo);
		return "admin/notice/noticeList.admin";
	}	
	
	

	@RequestMapping("/noticeWrite.do")
	public String noticeWrite() throws Exception{
	
		
		return "admin/notice/noticeWrite.admin";
	}	
	
	@SuppressWarnings("unchecked")
    @RequestMapping("/noticeInsert.do" )
	public String noticeWrite(@RequestParam Map paramMap, HttpServletRequest requset, HttpServletResponse res) throws Exception{

	    try {
	        /*게시판과 첨부파일 키 맞추기*/
	        int serFileNum = 0;
	        
	        /*게시판 첨부파일 업로드*/
    	    MultipartHttpServletRequest mReq = (MultipartHttpServletRequest)requset;
            //MultipartFile mFile = mReq.getFile("BOARD");
    	    List<MultipartFile> files = mReq.getFiles("files");

    	    if(null != files && files.get(0).getSize() > 0) 
    	    {   	        
    	        /*게시판과 첨부파일 연결키 생성(시퀀스 호출)*/
    	        serFileNum = adminService.getFileAtchSer();
    	        
        	    DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
                String ls_date = dateFormat.format(new Date());
                String fPath = Config.PATH_FILE_UPLOAD + "/" + ls_date.substring(0, 4) + "/" + ls_date.substring(4, 6) + "/" + ls_date.substring(6, 8);
                
                //String fPath = "C:\\test";
                fPath = StringUtils.replace(fPath, "\\", "/");
                
                File lf_Path = new File(fPath);
                if (!lf_Path.exists()) lf_Path.mkdirs();
               
        	    for (int i = 0; i < files.size(); i++) {
        	        
        	        MultipartFile mFile = files.get(i); 
        	    
                    String fName = mFile.getOriginalFilename();
                    
                    //if (fName == "") break;
                    
                    String ls_fileExt = fName.substring(fName.lastIndexOf(".")+1, fName.length());
                    File file = File.createTempFile("BOARD" + '_', '.' + ls_fileExt, lf_Path);
                    
                    String server_filename = file.getPath();
                    server_filename = server_filename.replace('\\', '/');
                    
                    //long file_id = fileService.insertFile(fileVO);
                    long file_id = 123456789L;
                    //String aliasFileNm = file_id + "_" + userSession.getTbUserVO().getCompany_id() + "_" + userSession.getTbUserVO().getUser_id();
                    String aliasFileNm = file.getName();
        
                    if(fileService.fileUpload(mFile, fPath, aliasFileNm, 2000000000L))  //2000000000L:20MByte
                    {
                        //fileService.updateFile(fileVO);
                                        
                        /*게시판 첨부파일 정보 저장*/
                        paramMap.put("tbl_nm", "tbl_board");
                        paramMap.put("tbl_pk",  Integer.toString(serFileNum));
                        paramMap.put("tbl_pk2", ls_fileExt);
                        paramMap.put("locfl_nm", fName);
                        paramMap.put("fl_sz", mFile.getSize());
                        paramMap.put("fl_ext", ls_fileExt.toLowerCase());
                        paramMap.put("svrfl_nm", server_filename.substring(server_filename.lastIndexOf("/")+1, server_filename.length()));
                        paramMap.put("svrfl_pth", server_filename);
                        paramMap.put("id", requset.getSession().getAttribute("user_id"));
                        
                        adminService.insertNoticeFileAtch(paramMap);
                        
                    }
                    
                    PrintWriter printwriter = res.getWriter();
                    printwriter.print(file_id);
            	
        	    }
    	    
    	    }
    	    
            /*게시판 테이블에 정보 저장*/
            paramMap.put("boardCd", 1);
            paramMap.put("title", paramMap.get("title"));
            paramMap.put("content", paramMap.get("content"));
            paramMap.put("fileatch_num",  Integer.toString(serFileNum));
            paramMap.put("regId", requset.getSession().getAttribute("user_id"));

            adminService.insertBoard(paramMap);  
            
	    } catch(IOException e) {
            e.printStackTrace();
        }
	       
	    return "redirect:/admin/noticeList.do"; 

	}
	
/*	
	@RequestMapping("/noticeInsert.do" )
	public String noticeWrite(@RequestParam Map paramMap, HttpServletRequest requset) throws Exception{
		
		paramMap.put("boardCd", 1);
		paramMap.put("title", paramMap.get("title"));
		paramMap.put("content", paramMap.get("content"));
		paramMap.put("regId", requset.getSession().getAttribute("user_id"));

		adminService.insertBoard(paramMap);
		
		return "redirect:/admin/noticeList.do";
	}	
*/	
	
	

	@RequestMapping("/noticeModify.do")
	public String noticeModify(@RequestParam Map paramMap, ModelMap model, HttpServletRequest requset, @ModelAttribute("searchVO") PagerVO vo) throws Exception{
		
		paramMap.put("boardCd", 1);
		paramMap.put("seq", paramMap.get("seq"));
		List<Map> list =  adminService.selectBoardDetail(paramMap);
		
		model.addAttribute("list", list);	
		return "admin/notice/noticeModify.admin";
	}

	@SuppressWarnings("unchecked")
    @RequestMapping("/updateBoard.do" )
    public  String updateBoard(@RequestParam Map paramMap, HttpServletRequest requset, HttpServletResponse res) throws Exception{
        
        try {
            /*게시판과 첨부파일 키 맞추기*/
            //int serFileNum = 0;
            
            /*게시판 첨부파일 업로드*/
            MultipartHttpServletRequest mReq = (MultipartHttpServletRequest)requset;
            //MultipartFile mFile = mReq.getFile("BOARD");
            List<MultipartFile> files = mReq.getFiles("files");

            if(null != files && files.get(0).getSize() > 0) 
            {               
                /*게시판과 첨부파일 연결키 생성(시퀀스 호출)*/
                //serFileNum = adminService.getFileAtchSer();
                
                DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
                String ls_date = dateFormat.format(new Date());
                String fPath = Config.PATH_FILE_UPLOAD + "/" + ls_date.substring(0, 4) + "/" + ls_date.substring(4, 6) + "/" + ls_date.substring(6, 8);
                
                //String fPath = "C:\\test";
                fPath = StringUtils.replace(fPath, "\\", "/");
                
                File lf_Path = new File(fPath);
                if (!lf_Path.exists()) lf_Path.mkdirs();
               
                for (int i = 0; i < files.size(); i++) {
                    
                    MultipartFile mFile = files.get(i); 
                
                    String fName = mFile.getOriginalFilename();
                    
                    //if (fName == "") break;
                    
                    String ls_fileExt = fName.substring(fName.lastIndexOf(".")+1, fName.length());
                    File file = File.createTempFile("BOARD" + '_', '.' + ls_fileExt, lf_Path);
                    
                    String server_filename = file.getPath();
                    server_filename = server_filename.replace('\\', '/');
                    
                    //long file_id = fileService.insertFile(fileVO);
                    long file_id = 123456789L;
                    //String aliasFileNm = file_id + "_" + userSession.getTbUserVO().getCompany_id() + "_" + userSession.getTbUserVO().getUser_id();
                    String aliasFileNm = file.getName();
        
                    if(fileService.fileUpload(mFile, fPath, aliasFileNm, 2000000000L))  //2000000000L:20MByte
                    {
                        //fileService.updateFile(fileVO);
                                        
                        /*게시판 첨부파일 정보 저장*/
                        paramMap.put("tbl_nm", "tbl_board");
                        paramMap.put("tbl_pk",  paramMap.get("fileAtch_Num"));
                        paramMap.put("tbl_pk2", ls_fileExt);
                        paramMap.put("locfl_nm", fName);
                        paramMap.put("fl_sz", mFile.getSize());
                        paramMap.put("fl_ext", ls_fileExt.toLowerCase());
                        paramMap.put("svrfl_nm", server_filename.substring(server_filename.lastIndexOf("/")+1, server_filename.length()));
                        paramMap.put("svrfl_pth", server_filename);
                        paramMap.put("id", requset.getSession().getAttribute("user_id"));
                        
                        adminService.insertNoticeFileAtch(paramMap);
                        
                    }
                    
                    PrintWriter printwriter = res.getWriter();
                    printwriter.print(file_id);
                
                }
            
            }
            
            /*게시판 테이블에 정보 저장*/
            paramMap.put("boardCd", 1);
            paramMap.put("seq", paramMap.get("seq"));
            paramMap.put("title", paramMap.get("title"));
            paramMap.put("content", paramMap.get("content"));
            paramMap.put("uptId", requset.getSession().getAttribute("user_id"));    

            adminService.updateBoard(paramMap);  
            
        } catch(IOException e) {
            e.printStackTrace();
        }
           
        return "redirect:/admin/noticeList.do"; 
    }
/*	
	@RequestMapping("/updateBoard.do" )
	public  String updateBoard(@RequestParam Map paramMap, HttpServletRequest requset) throws Exception{
		
		paramMap.put("boardCd", 1);
		paramMap.put("seq", paramMap.get("seq"));
		paramMap.put("title", paramMap.get("title"));
		paramMap.put("content", paramMap.get("content"));		
		paramMap.put("uptId", requset.getSession().getAttribute("user_id"));		

		
		
		
		adminService.updateBoard(paramMap);
		
		return "redirect:/admin/noticeList.do";
	}
*/
	
	@RequestMapping("/deleteBoard.do")
	public String deleteBoard(@RequestParam Map paramMap, HttpServletRequest request) throws Exception {
		
		
		paramMap.put("boardCd", 1);
		paramMap.put("seq", paramMap.get("seq"));
		
		
		adminService.deleteBoard(paramMap);
		
		return "redirect:/admin/noticeList.do";
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
        result = adminService.noticeFileAtchListAjax(paramMap);
        
        model.addObject("result", result);
        
        return model;
        
    }
	
   @RequestMapping("/deleteFileAtchListAjax.do")
   public @ResponseBody ModelAndView deleteFileAtchListAjax(@RequestParam Map paramMap, HttpServletRequest requset) throws Exception {
       
       ModelAndView model = new ModelAndView("jsonView");
       
       paramMap.put("fl_id", paramMap.get("fl_id"));
   
       int result = adminService.deleteFileAtchListAjax(paramMap);
       
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
           Map getFile = adminService.selectFile(prop);
           
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
}
