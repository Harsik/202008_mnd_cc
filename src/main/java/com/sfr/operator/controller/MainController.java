package com.sfr.operator.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.sfr.common.PagerVO;
import com.sfr.operator.controller.search.PagingVO;
import com.sfr.operator.service.OperatorService;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestMapping("/operator")
public class MainController {

	private Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Value("#{sfr_config['file.upload.path']}")
	private String uploadpath1;

	@Autowired
	private OperatorService operatorService;

	
	
	@RequestMapping(value="/callUser.do", method={RequestMethod.POST})
	public @ResponseBody ModelAndView callUser(@RequestParam Map paramMap, Model model, HttpServletRequest requset ) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView("jsonView");
		paramMap.put("telno", paramMap.get("telno"));
		paramMap.put("mpno", paramMap.get("mpno"));
		
		
		Map map = new HashMap<>();
		
		map = operatorService.selectDeptTel(paramMap);

		modelAndView.addObject("map", map);
		
		return modelAndView;
	}
	
	/**
	 * 메인 화면
	 * @return
	 */
	@RequestMapping("/main.do")
	public String operator_main(){
		//프로퍼티 
    	Properties prop = null;
    	String uploadPath2 =  null;

        if (prop == null) {
            try {
            	prop = new Properties();
            	prop.load(getClass().getClassLoader().getResourceAsStream("properties/sfr.properties"));
            	
            	uploadPath2 = prop.getProperty("file.upload.path");
            } catch (Exception e) { // catch 문에도 반드시 처리 문 넣어야함.
                prop = null;
            }
        }		
        
        log.debug(uploadpath1);	//전역
        log.debug(uploadPath2); //지역
		
		return "operator/main.operator";
	}
	
	/*
	 * 교환원 공지사항 리스트 
	 * 
	 */
	@RequestMapping("/operatorNoticeList.do")
	public String noticeList(@RequestParam Map paramMap, Model model, HttpServletRequest requset, @ModelAttribute("searchVO") PagerVO vo ) throws Exception {
		
		
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
		
		List<Map> list =  operatorService.selectBoardList(paramMap);
		int cnt = operatorService.getTotalCount(paramMap);
		System.out.println(list.size());
		paginationInfo.setTotalRecordCount(cnt);
		model.addAttribute("list", list);
		model.addAttribute("cnt", cnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        
		return "operator/notice/noticePopup.popup";
	}

	/*
	 * 교환원 공지사항 리스트 상세
	 *  
	 * 
	 */
	@RequestMapping("/operatorNoticeDetail.do")
	public String operatorNoticeDetail(@RequestParam Map paramMap, Model model, HttpServletRequest requset, @ModelAttribute("searchVO") PagerVO vo ) throws Exception {
		
		paramMap.put("boardCd", 1);
		paramMap.put("seq", paramMap.get("seq"));
			
		operatorService.updateBoardCnt(paramMap);	
		
		List<Map> list =  operatorService.selectNoticeDetail(paramMap);
		model.addAttribute("list", list);
        
        
		return "operator/notice/noticeDetailPopup.popup";
	}
	
	
	
	@RequestMapping("/operatorPopup.do")
	public String operatorPopup1(@RequestParam Map paramMap, Model model, HttpServletRequest requset, @ModelAttribute("searchVO") PagerVO vo ) {
		
		
		List<Map> list = new ArrayList<Map>();
		
		try {
		System.out.println("### :");
		
		String id = requset.getSession().getAttribute("user_id").toString();
		System.out.println("######### :" +id);
		//paramMap.put("id", "1019");
		paramMap.put("id",  requset.getSession().getAttribute("user_id").toString());
		
		
		if(requset.getRemoteAddr().equals("172.17.0.30")) {
			list = operatorService.selectoperatorList(paramMap);
		} else {
			list = operatorService.selectoperatorList70(paramMap);
		}
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		model.addAttribute("list", list);
		return "operator/operatorPopup.popup";   
	}

	
	/**
	 * search 뷰
	 * @return
	 */
	@RequestMapping("/search.do")
	public String search(){
		
		return "operator/search/search.operator";
	}	
	
	

	@RequestMapping("/callMain.do")
	public String callMain(ModelMap model, String name, String talNo){
		System.out.println("인입콜 받은 값 :: ");

		model.addAttribute("name", name);
		model.addAttribute("talNo", talNo);
		model.addAttribute("dept", "육군");
		model.addAttribute("mpNo", "010-1111-2222");
		
		return "operator/main.operator";
	}	

	/**
	 * 팝업 레이아웃 샘플 화면
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/ctiCallPoup.do", method=RequestMethod.POST)
	public @ResponseBody ModelAndView callOperatorPopup(@RequestParam Map paramMap,  HttpServletRequest requset ) throws Exception{
		
		ModelAndView model = new ModelAndView("josnView");

		paramMap.put("telno", paramMap.get("telno"));
		
		Map map = new HashMap<>();
		
		map = operatorService.selectDeptTel(paramMap);

		model.addObject("dept", map);
		
		
		return model;
	}	

	@RequestMapping("/getTree.do")
	public @ResponseBody List getMenu(ModelMap model, HttpServletRequest request, @RequestParam Map paramMap) throws Exception{
		
		paramMap.put("mildsc", paramMap.get("mildsc"));
		paramMap.put("hgrnkDeptCd", paramMap.get("hgrnkDeptCd"));
		
		List<Map> list = new ArrayList<>();
		
		/*Map tempMap = new HashMap();
		
		tempMap.put("id", "0");
		tempMap.put("parent", "#");
		tempMap.put("text", "ROOT");
		
		list.add(tempMap);*/
		
		list.addAll(operatorService.selectDeptTree(paramMap));
		
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
		list = operatorService.selectDeptList(paramMap);
		int toTalCount = operatorService.getDeptCount(paramMap);
		vo.setTotalCount(toTalCount);
		
		System.out.println("############" +toTalCount);
		
		model.addObject("paging",vo);
		model.addObject("list",list);
		
		return model;
	}
	
	@RequestMapping("/blockPopup.do")
	public String blockPopup(@RequestParam Map paramMap, Model model, HttpServletRequest requset) {
		System.out.println(" >>>> 악성민원 팝업");
		System.out.println(paramMap);
		
		model.addAttribute("nm", paramMap.get("nm"));
		model.addAttribute("tel", paramMap.get("tel"));
		model.addAttribute("stat", paramMap.get("stat"));
		model.addAttribute("type", paramMap.get("type"));
		
		return "operator/blockPopup.popup";   
	}
	
	@RequestMapping(value="/selectUser.do", method={RequestMethod.POST})
	public @ResponseBody ModelAndView selectUser(@RequestParam Map paramMap, Model model, HttpServletRequest requset ) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView("jsonView");
		paramMap.put("telno", paramMap.get("telno"));
		paramMap.put("fulnm", paramMap.get("fulnm"));
		
		
		Map map = new HashMap<>();
		
		map = operatorService.selectUser(paramMap);

		modelAndView.addObject("map", map);
		
		return modelAndView;
	}
	
	@RequestMapping(value="/insertBlock.do", method=RequestMethod.POST)
	public @ResponseBody ModelAndView insertBlock(@RequestParam Map paramMap, HttpServletRequest requset ) throws Exception{
		System.out.println("paramMap >> " + paramMap);
		
		ModelAndView model = new ModelAndView("jsonView");
		
		String end_date = (String) paramMap.get("end_date");
		paramMap.put("end_date", end_date.replace("&lrm;", ""));
		
		System.out.println("paramMap >> " + paramMap);
		
		int result =	operatorService.insertBlock(paramMap);
		System.out.println("result >> "+result);
		model.addObject("result", result);

		return model;
	} 
	
	/*
	@RequestMapping(value="/selectBlockList.do", method=RequestMethod.POST)
	public @ResponseBody ModelAndView selectBlockList(@RequestParam Map paramMap, HttpServletRequest requset, @ModelAttribute("searchVO") PagingVO vo ) throws Exception{
		System.out.println("paramMap >> " + paramMap);
		
		vo.setPageSize(10); // 한 페이지에 보일 게시글 수
		vo.setPageNo(1); // 현재 페이지 번호
		
		if(vo.getSetPageNum() != 0){
			vo.setPageNo(vo.getSetPageNum());
		}
		vo.setBlockSize(10);
		
		ModelAndView model = new ModelAndView("jsonView");
		
		System.out.println("paramMap >> " + paramMap);
		
		List<Map> list = new ArrayList<>();
		list = operatorService.selectBlockList(paramMap);
		int toTalCount = list.size();
		vo.setTotalCount(toTalCount);
		
		System.out.println("toTalCount >>" +toTalCount);
		
		System.out.println("list >> "+list);
		
		model.addObject("paging",vo);
		model.addObject("list", list);

		return model;
	}
	*/
	
	/*
	 * 악성민원 IVR 조회
	 */
	@RequestMapping(value="/blockCheck.do", produces="application/text;charset=utf8")
	@ResponseBody
	public String blockCheck(@RequestParam Map paramMap, HttpServletRequest requset){
		System.out.println(" >>>> blockCheck");
		System.out.println(paramMap);
		
		int result;
		String check ="";
		try {
			result = operatorService.selectBlockCheck(paramMap);
			
			System.out.println("int >>> "+result);
			
			if(result!=0) {
				check = "Y";
			}else {
				check = "N";
			}
		} catch (Exception e) {
			check = "N";
		}
		System.out.println("check >>>" + check);
		
		return check;   
	}
	
	@RequestMapping(value="/insertPrompt.do", method=RequestMethod.POST)
	public @ResponseBody ModelAndView insertPrompt(@RequestParam Map paramMap, HttpServletRequest requset ) throws Exception{
		System.out.println("paramMap >> " + paramMap);
		
		ModelAndView model = new ModelAndView("jsonView");
		
		System.out.println("paramMap >> " + paramMap);
		
		int result =	operatorService.insertPrompt(paramMap);
		System.out.println("result >> "+result);
		model.addObject("result", result);

		return model;
	}
	
	/*
	 * 상담사 자동 전화 연결 안내멘트
	 */
	@RequestMapping(value="/reqPrompt.do", produces="application/text;charset=utf8")
	@ResponseBody
	public String reqPrompt(@RequestParam Map paramMap, HttpServletRequest requset ){
		System.out.println(" >>>> reqPromptCheck");
		System.out.println(paramMap);
		
		String result = "";
		String name	= "";
		String rank = "";
		String telno = "";
		
		Map map = new HashMap<>();
		try {
			map = operatorService.selectReqPrompt(paramMap);
			System.out.println("map >>>" + map);
			name	= (String) map.get("fulnm");
			rank = (String) map.get("rankNm");
			telno = (String) map.get("telno");
			result= "문의하신 "+name+" "+rank+" 전화번호는 "+telno+" 입니다";
			
		} catch (Exception e) {
			result = "해당 전화번호가 없습니다 다시 문의해 주시기 바랍니다.";
		}
		
		System.out.println("check >>> " +result);
		return result;   
	}
}
