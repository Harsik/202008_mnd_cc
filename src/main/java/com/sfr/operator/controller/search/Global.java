package com.sfr.operator.controller.search;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.forcewin.mirserver.client.Connector;
import com.forcewin.mirserver.client.Parser;
import com.forcewin.mirserver.util.Collection;
import com.forcewin.mirserver.util.Input;
import com.forcewin.mirserver.util.Output;
import com.sfr.intra.service.IntraService;
import com.sfr.operator.service.OperatorService;

import net.sf.json.JSONArray;

@Controller
public class Global {

	@Autowired
	private IntraService intraService;
	
	@Autowired
	private OperatorService operatorService;
	
	// 전화번호 검색 자동완성 기능 추가 20.10.20
	@RequestMapping(value="/search2.do", method=RequestMethod.POST)
	public @ResponseBody ModelAndView selectDeptList(HttpServletRequest request, @RequestParam Map paramMap) throws Exception {
		
		ModelAndView model = new ModelAndView("jsonView");
		
		String str = (String) paramMap.get("searchContent");
        List<String> usr_info = Arrays.asList(str.split(" "));
		
		paramMap.put("searchContent", paramMap.get("searchContent"));
		paramMap.put("searchCnt", paramMap.get("searchCnt"));
		paramMap.put("usr_info", usr_info);
		
		List<Map> list = new ArrayList<>();
		
		// searchServer 없어서 임의로 deptTable 에서 조회
		list = operatorService.selectDeptTelMain(paramMap);

		model.addObject("list",list);
		
		return model;
	}

	@RequestMapping(value = "/search.do", method = RequestMethod.POST)
	public @ResponseBody ModelAndView search(@RequestParam Map paramMap, ModelMap moelMap, HttpServletRequest requset,
			@ModelAttribute("searchVO") PagingVO vo) {
		System.out.println("====================> search");
		ModelAndView model = new ModelAndView("jsonView");

		Connector connector = new Connector();
		Input input = new Input();
		Output output = new Output();
		Parser jparser = new Parser();

		// request.setCharacterEncoding("UTF-8");

		vo.setPageSize(10); // 한 페이지에 보일 게시글 수
		vo.setPageNo(1); // 현재 페이지 번호

		if (vo.getSetPageNum() != 0) {
			vo.setPageNo(vo.getSetPageNum());
		}
		vo.setBlockSize(10);

		// paging--
		System.out.println("(String)paramMap====> "+(String)paramMap.toString());
		// 검색 초기값 설정
		String target = "0"; // Category(tab, select box)
		String collist = "total"; // Collection Name
		String query = ""; // query
//		String sortfield = "score"; // sort field
//		String sortorder = "desc"; // sort order
		String sortfield = (String)paramMap.get("sortField");
		String sortorder = (String)paramMap.get("sortOrder");
		String resrch = "no"; // 결과내재검색
		String arr_range = (String)paramMap.get("range");
		String tar_range = (String)paramMap.get("tar_range");
		
		if(arr_range.indexOf("all") != -1){
			arr_range = "";
		}else{
			arr_range = "(" + arr_range.substring(0, arr_range.length()-1) + ")<in>mildsc ";
		}
		
		if(tar_range.indexOf("tot") != -1){
			tar_range = "";
		}else{
			tar_range = query+"<in>"+tar_range;
		}		
		
//		String arr_range = "all"; // zone(제목, 작성자....)
		if (vo.getSetPageNum() == 0) {
			vo.setSetPageNum(1);
		}

		String pagenum = Integer.toString(vo.getSetPageNum()); // 페이지 번호
		String pagemax = "10"; // 화면에 출력될 건수
		String requery = ""; // 결과내 재검색용 검색어
		String refirst = ""; // 결과내 재검색용 체크

		String serverhost = "11.2.17.191"; // Mir-Search server(테스트)
//		String serverhost = "127.0.0.1"; // Mir-Search server(테스트)
		String searchport = "9100"; // Mir-Search port
		String searchtarget = "total"; // 검색방식(total : 1번 검색으로 모든 컬렉션 검색,each :
										// 1번에 1개의 컬렉션 검색)
		int totalpage = 0; // 전체 페이지(Page 사용)
		String user = ""; // 사용자(통계용)
		String incharset = ""; // 입력 케릭터셋 설정
		String outcharset = ""; // 출력 케릭터셋 설정
		String filter = ""; // 필더 설정
		String qy = ""; // 인기검색어용 검색어
		String parser = "type_one"; // 파서 설정
		String code = "";

		int pagemax_int = Integer.parseInt(pagemax); // 페이징용 페이지 출력 건수
		int pagenum_int = Integer.parseInt(pagenum); // 페이징용 현재 페이지
		int totalcount = 0; // 전체건수 출력용 변수

		String fields = "full_dept_nm,facility_nm,rspsblt_biznes,rspofc_nm,dept_nm,id,nm,email,rank,mildsc_nm,telno,mpno,dept_abrvwd,dept_abrvwd2,teltest";
		// Collection
		// fields
		String full_dept_nm="",facility_nm="",rspsblt_biznes="",rspofc_nm="",dept_nm="",dept_cd="",id="",nm="",email="",rank="",mildsc_nm="",telno="",mpno="",dept_abrvwd="",dept_abrvwd2="";
		
		String value = (String) paramMap.get("value");
		//System.out.println(value);
		

		// 초기 검색어 저장
		String query_org = value;

		// 검색어 ngram 검색 방식 파싱 시작
		//query = value.replace(" ", "*");
		query = value;
		
		// 숫자6글자 이상인 경우 와일드카드 붙이기
/*		String str0 = "";
		String str1 = "";
		str1 = StringReplace(query);
		
		String[] str2 = str1.split(" ");
		
		for (String str3 : str2) {
			if(isNumber(str3) == true) {
				if(str3.length() > 5) {
					str3 = str3 + "%";	
				}
			}
			str0 = str0 + str3 + " ";
		}
		query = str0;*/
		
//		if(query.indexOf(",,") != -1){
//			String[] queryTemp = query.split(",,");
//			String range = "(" + queryTemp[0] + ")<in>mildsc ";
//			String queryChange = range + queryTemp[1];
//			query = queryChange;
//			query_org = queryTemp[1];
//		}
		
		//System.out.println(query);
		

		String targetnamelist[] = { "통합검색" };
		String temptargetlist[] = { "0" };
		// String tempColllist[]={"tbl_user,tbl_dept","tbl_user","tbl_dept"};
		String tempColllist[] = { "tbl" };

		int targetcount = targetnamelist.length - 1;
		String targetname = targetnamelist[0];
		String temptarget = temptargetlist[0];

		//System.out.println("쿼리 : "+ arr_range+query);
		System.out.println(arr_range+query+tar_range);
		
		collist = tempColllist[Integer.parseInt(target)];
		input = connector.setParam(serverhost, searchport, arr_range+"("+query+")"+tar_range, qy, parser, collist, fields, filter, pagemax,
				pagenum, "mildsc asc rsort asc rank asc "+sortfield, sortorder, user, incharset, outcharset);
		output = connector.getJson(input);
		code = jparser.getCode(output);

		if (code.equals("0")) {

			jparser.getCondition(output);
			String searchmode = jparser.getSearchmode(output);
			System.out.println("=================================================================<br>");
			System.out.println("[searchmode : " + searchmode + "]<br>");
			// 묶음검색
			if (searchmode.equals("Unify")) {
				Collection collection = new Collection();
				collection = jparser.getCollection(output);
				System.out.println("=================================================================11<br>");
				System.out.println("[Collection]<br>");
				System.out.println("Resultcount : " + collection.getResultcount() + "<br>");
				System.out.println("Totalcount : " + collection.getTotalcount() + "<br>");

				String temp = collection.getResultcount();
				int resultcount = Integer.parseInt(temp);
				if (resultcount == 0) {
					System.out.println(".................................................................<br>");
					System.out.println("검색어 [" + query + "] 결과가 없습니다.<br>");

				} else {
					for (int i = 0; i < collection.getCurresultcount(); i++) {

					}

					if ((resultcount % pagemax_int) == 0) {
						totalpage = resultcount / pagemax_int;
					} else {
						totalpage = (resultcount / pagemax_int) + 1;
					}
					int middle = (((int) ((double) pagenum_int / 10 + 0.9)) - 1) * 10 + 1;

					for (int m = middle; m <= totalpage; m++) {
						if (m >= (pagemax_int + middle))
							break;
						if (pagenum_int == m) {

						} else {

						}
					} // end for
						// 페이지 네비게이션 끝
				}

			}
			// 개별검색
			else {

				JSONArray jArray = jparser.getCollist(output);

				ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();

				for (int i = 0; i < jArray.size(); i++) {
					Collection collection = new Collection();
					collection = jparser.getCollection(output, i);

					System.out.println("=================================================================<br>");
					System.out.println("[Collection : " + jArray.get(i).toString() + "]<br>");
					System.out.println("Resultcount : " + collection.getResultcount() + "<br>");
					System.out.println("Totalcount : " + collection.getTotalcount() + "<br>");

					String temp = collection.getResultcount();
					int resultcount = Integer.parseInt(temp);

					if (jArray.get(i).toString().equals("tbl")) {
						vo.setTotalCount(Integer.parseInt(collection.getResultcount()));
					}
//					if (jArray.get(i).toString().equals("tbl_user")) {
//						vo.setTotalCount(Integer.parseInt(collection.getResultcount()));
//					} else if (jArray.get(i).toString().equals("tbl_facility")) {
//						vo.setTotalCount(Integer.parseInt(collection.getResultcount()));
//					}

					if (resultcount == 0) {
						System.out.println("............................................<br>");
						System.out.println("검색어 [" + query + "] 결과가 없습니다.<br>");

					} else {
						
						//2018.06.08 
						//ORDER_NO HGRNK_DEPT_CD telno2 KEYWORD_AREA
						for (int j = 0; j < collection.getCurresultcount(); j++) {
							HashMap<String, Object> row = new HashMap<String, Object>(collection.getCurresultcount());
							full_dept_nm = jparser.getFieldVal(output, i, j, "full_dept_nm");
							facility_nm = jparser.getFieldVal(output, i, j, "facility_nm");
							rspsblt_biznes = jparser.getFieldVal(output, i, j, "rspsblt_biznes");
							rspofc_nm = jparser.getFieldVal(output, i, j, "rspofc_nm");
							dept_nm = jparser.getFieldVal(output, i, j, "dept_nm");
							
							id = jparser.getFieldVal(output, i, j, "id");
							nm = jparser.getFieldVal(output, i, j, "nm");
							email = jparser.getFieldVal(output, i, j, "email");
							rank = jparser.getFieldVal(output, i, j, "rank");
							mildsc_nm = jparser.getFieldVal(output, i, j, "mildsc_nm");
							
							telno = jparser.getFieldVal(output, i, j, "telno");
							mpno = jparser.getFieldVal(output, i, j, "mpno");
//							dept_abrvwd = jparser.getFieldVal(output, i, j, "dept_abrvwd");
//							dept_abrvwd2 = jparser.getFieldVal(output, i, j, "dept_abrvwd2");

							row.put("full_dept_nm", full_dept_nm);
							row.put("facility_nm", facility_nm);
							row.put("rspsblt_biznes", rspsblt_biznes);
							row.put("rspofc_nm", rspofc_nm);
							row.put("dept_nm", dept_nm);
							row.put("id", id);
							row.put("nm", nm);
							row.put("email", email);
							row.put("rank", rank);
							row.put("mildsc_nm", mildsc_nm);
							row.put("telno", telno);
							row.put("mpno", mpno);
							row.put("temp", temp);

							list.add(row);
						}
						// 페이지 네비게이션 시작
						if ((resultcount % pagemax_int) == 0) {
							totalpage = resultcount / pagemax_int;
						} else {
							totalpage = (resultcount / pagemax_int) + 1;
						}
						int middle = (((int) ((double) pagenum_int / 10 + 0.9)) - 1) * 10 + 1;

						for (int m = middle; m <= totalpage; m++) {
							if (m >= (pagemax_int + middle))
								break;
							if (pagenum_int == m) {

							} else {
							}
						} // end for
							// 페이지 네비게이션 끝
						//System.out.println("<br>");
					}

				}
				model.addObject("data", list);

			}
		} else {
			System.out.println("=================================================================<br>");
			System.out.println("[ERROR]<br>");
			System.out.println(jparser.getMessage(output));
			model.addObject("data", "Error");

			// 검색어 원상복귀
			query = query_org;
			//System.out.println("query[input] : " + query);

		}

		model.addObject("paging", vo);

		return model;
	}

	@SuppressWarnings("unused")
	@RequestMapping(value = "/intraSearch.do", method = RequestMethod.POST)
	public @ResponseBody ModelAndView intraSearch(@RequestParam Map paramMap, ModelMap moelMap,
			HttpServletRequest requset, @ModelAttribute("searchVO") PagingVO vo) {

		ModelAndView model = new ModelAndView("jsonView");

		//System.out.println("intraSearch1");
		
		Connector connector = new Connector();
		Input input = new Input();
		Output output = new Output();
		Parser jparser = new Parser();

		
		//System.out.println("intraSearch2");
		
		// request.setCharacterEncoding("UTF-8");

		vo.setPageSize(10); // 한 페이지에 보일 게시글 수
		vo.setPageNo(1); // 현재 페이지 번호

		if (vo.getSetPageNum() != 0) {
			vo.setPageNo(vo.getSetPageNum());
		}
		vo.setBlockSize(10);

		// paging--

		// 검색 초기값 설정
		String target = "0"; // Category(tab, select box)
		String collist = "total"; // Collection Name
		String query = ""; // query
//		String sortfield = "score"; // sort field
//		String sortorder = "desc"; // sort order
		String sortfield = (String)paramMap.get("sortField");
		String sortorder = (String)paramMap.get("sortOrder");
		String resrch = "no"; // 결과내재검색
//		String arr_range = "all"; // zone(제목, 작성자....)
		String arr_range = (String)paramMap.get("range");
		String tar_range = (String)paramMap.get("tar_range");
		
		if(arr_range.indexOf("all") != -1){
			arr_range = "";
		}else{
			arr_range = "(" + arr_range.substring(0, arr_range.length()-1) + ")<in>mildsc ";
		}
		
		if (vo.getSetPageNum() == 0) {
			vo.setSetPageNum(1);
		}
		
		if(tar_range.indexOf("tot") != -1){
			tar_range = "";
		}else{
			tar_range = "<in>"+tar_range;
		}		

		String pagenum = Integer.toString(vo.getSetPageNum()); // 페이지 번호
		String pagemax = "10"; // 화면에 출력될 건수
		String requery = ""; // 결과내 재검색용 검색어
		String refirst = ""; // 결과내 재검색용 체크

		String serverhost = "11.2.17.191"; // Mir-Search server(테스트)
//		String serverhost = "127.0.0.1"; // Mir-Search server(테스트)
		String searchport = "9100"; // Mir-Search port
		String searchtarget = "total"; // 검색방식(total : 1번 검색으로 모든 컬렉션 검색,each :
		// 1번에 1개의 컬렉션 검색)
		int totalpage = 0; // 전체 페이지(Page 사용)
		String user = ""; // 사용자(통계용)
		String incharset = ""; // 입력 케릭터셋 설정
		String outcharset = ""; // 출력 케릭터셋 설정
		String filter = ""; // 필더 설정
		String qy = ""; // 인기검색어용 검색어
		String parser = "type_one"; // 파서 설정
		String code = "";

		int pagemax_int = Integer.parseInt(pagemax); // 페이징용 페이지 출력 건수
		int pagenum_int = Integer.parseInt(pagenum); // 페이징용 현재 페이지
		int totalcount = 0; // 전체건수 출력용 변수

		String fields = "full_dept_nm,facility_nm,rspsblt_biznes,rspofc_nm,dept_nm,id,nm,email,rank,mildsc_nm,telno,mpno,dept_abrvwd,dept_abrvwd2,teltest,dept_cd,mildsc";
		// Collection
		// fields
		String full_dept_nm="",facility_nm="",rspsblt_biznes="",rspofc_nm="",dept_nm="",dept_cd="",id="",nm="",email="",rank="",mildsc_nm="",telno="",mpno="",dept_abrvwd="",dept_abrvwd2="",mildsc="";
		
		//System.out.println("intraSearch3");
		
		// fields
		// 변수
		String value = (String) paramMap.get("value");
		String query_org = value;
		query = value;

		
		if (!value.equals("")) {
			
			String SearchMildsc = (String) requset.getSession().getAttribute("mildsc");
			String SearchId = (String) requset.getSession().getAttribute("user_id");
			//System.out.println(SearchMildsc);
			//System.out.println(SearchId);
			//String SearchMildsc = (String) requset.getSession().getAttribute("mildsc");
			//String SearchMildsc = "D";
			//String SearchId = "04-501205";
			String ip = requset.getLocalAddr();
		 	
			paramMap.put("mildsc", SearchMildsc);
			paramMap.put("id", SearchId);
			//paramMap.put("userCd", userCd);
			paramMap.put("sechwd", value);
			paramMap.put("regIp", ip);
			//System.out.println("intraSearch3-2");
			try {
				int result = intraService.insertSearchHist(paramMap);
			} catch (Exception e) {
				e.printStackTrace();
			}

		}
		
		
		//System.out.println("intraSearch4");

		/*
		 * 수정날짜 : 2018-05-18 수정내용 : 기존의 광범위한 결과를 축소시키기 위함입니다. <in>검색이란?
		 * 검색어<in>필드명 해당 검색어를 지정한 필드명에서 검색하여 충족하는 결과만 가져옵니다. query -> 국통사 홍길동 기존
		 * query -> 국*통*사*홍*길*동 수정 query -> 국*통*사*홍길동<in>nm
		 */

		// 기존쿼리는 space -> * 변환
		// 변경쿼리는 space -> 스페이스 다음 결과값은 무조건 이름으로 분류 됩니다.

		// query = value.replace(" ", "*");
		
		// 괄호 2018.06.08
		// 체크박스 검색
//		if(query.indexOf(",,") != -1){
//			String[] queryTemp = query.split(",,");
//			String range = "(" + queryTemp[0] + ")<in>mildsc ";
//			String queryChange = range + queryTemp[1];
//			query = queryChange;
//			query_org = queryTemp[1];
//		}
		
		//System.out.println(query);
		
		//System.out.println("intraSearch5");
		
		
		// 구분자 & (이름 필드검색)가 있을 경우 검색어 앞(ngram 파싱)/뒤(이름 필드검색) 구분
		String query_front = null;
		String query_end = null;

		String targetnamelist[] = { "통합검색" };
		String temptargetlist[] = { "0" };
		// String tempColllist[]={"tbl_user,tbl_dept","tbl_user","tbl_dept"};
		String tempColllist[] = { "tbl" };

		int targetcount = targetnamelist.length - 1;
		//System.out.println("타겟카운트 : "+targetcount);
		
		String targetname = targetnamelist[0];
		String temptarget = temptargetlist[0];
		collist = tempColllist[Integer.parseInt(target)];
		input = connector.setParam(serverhost, searchport, arr_range+"("+query+")"+tar_range, qy, parser, collist, fields, filter, pagemax,
				pagenum, "mildsc asc rsort asc rank asc "+sortfield, sortorder, user, incharset, outcharset);
		output = connector.getJson(input);
		code = jparser.getCode(output);

		//System.out.println("코드 : "+code);
		
		
		if (code.equals("0")) {

			jparser.getCondition(output);
			String searchmode = jparser.getSearchmode(output);
			System.out.println("=================================================================<br>");
			System.out.println("[searchmode : " + searchmode + "]<br>");

			// 묶음검색
			if (searchmode.equals("Unify")) {
				Collection collection = new Collection();
				collection = jparser.getCollection(output);
				// System.out.println("=================================================================11<br>");
				// System.out.println("[Collection]<br>");
				// System.out.println("Resultcount : " +
				// collection.getResultcount() + "<br>");
				// System.out.println("Totalcount : " +
				// collection.getTotalcount() + "<br>");

				String temp = collection.getResultcount();
				int resultcount = Integer.parseInt(temp);

				if (resultcount == 0) {
					// System.out.println(".................................................................<br>");
					// System.out.println("검색어 [" + query + "] 결과가 없습니다.<br>");

				} else {
					for (int i = 0; i < collection.getCurresultcount(); i++) {

					}

					/*
					 * if ((resultcount % pagemax_int) == 0) { totalpage =
					 * resultcount / pagemax_int; } else { totalpage =
					 * (resultcount / pagemax_int) + 1; } int middle = (((int)
					 * ((double) pagenum_int / 10 + 0.9)) - 1) * 10 + 1;
					 * 
					 * for (int m = middle; m <= totalpage; m++) { if (m >=
					 * (pagemax_int + middle)) break; if (pagenum_int == m) {
					 * 
					 * } else {
					 * 
					 * } } // end for // 페이지 네비게이션 끝
					 */ }

			}
			// 개별검색
			else {

				JSONArray jArray = jparser.getCollist(output);

				ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();

				for (int i = 0; i < jArray.size(); i++) {
					Collection collection = new Collection();
					collection = jparser.getCollection(output, i);

					System.out.println("=================================================================<br>");
					System.out.println("[Collection : " + jArray.get(i).toString() + "]<br>");
					System.out.println("Resultcount : " + collection.getResultcount() + "<br>");
					System.out.println("Totalcount : " + collection.getTotalcount() + "<br>");

					String temp = collection.getResultcount();
					int resultcount = Integer.parseInt(temp);

					if (jArray.get(i).toString().equals("tbl")) {
						vo.setTotalCount(Integer.parseInt(collection.getResultcount()));
					}
//					if (jArray.get(i).toString().equals("tbl_user")) {
//						vo.setTotalCount(Integer.parseInt(collection.getResultcount()));
//					} else if (jArray.get(i).toString().equals("tbl_facility")) {
//						vo.setTotalCount(Integer.parseInt(collection.getResultcount()));
//					}

					if (resultcount == 0) {
						System.out.println("............................................<br>");
						System.out.println("검색어 [" + query + "] 결과가 없습니다.<br>");

					} else {

						for (int j = 0; j < collection.getCurresultcount(); j++) {
							HashMap<String, Object> row = new HashMap<String, Object>(collection.getCurresultcount());
							full_dept_nm = jparser.getFieldVal(output, i, j, "full_dept_nm");
							facility_nm = jparser.getFieldVal(output, i, j, "facility_nm");
							rspsblt_biznes = jparser.getFieldVal(output, i, j, "rspsblt_biznes");
							rspofc_nm = jparser.getFieldVal(output, i, j, "rspofc_nm");
							dept_nm = jparser.getFieldVal(output, i, j, "dept_nm");
							dept_cd = jparser.getFieldVal(output, i, j, "dept_cd");
							mildsc = jparser.getFieldVal(output, i, j, "mildsc");
							
							id = jparser.getFieldVal(output, i, j, "id");
							nm = jparser.getFieldVal(output, i, j, "nm");
							email = jparser.getFieldVal(output, i, j, "email");
							rank = jparser.getFieldVal(output, i, j, "rank");
							mildsc_nm = jparser.getFieldVal(output, i, j, "mildsc_nm");
							
							telno = jparser.getFieldVal(output, i, j, "telno");
							mpno = jparser.getFieldVal(output, i, j, "mpno");
//							dept_abrvwd = jparser.getFieldVal(output, i, j, "dept_abrvwd");
//							dept_abrvwd2 = jparser.getFieldVal(output, i, j, "dept_abrvwd2");

							row.put("full_dept_nm", full_dept_nm);
							row.put("facility_nm", facility_nm);
							row.put("rspsblt_biznes", rspsblt_biznes);
							row.put("rspofc_nm", rspofc_nm);
							row.put("dept_nm", dept_nm);
							row.put("dept_cd", dept_cd);
							row.put("mildsc", mildsc);
							row.put("id", id);
							row.put("nm", nm);
							row.put("email", email);
							row.put("rank", rank);
							row.put("mildsc_nm", mildsc_nm);
							row.put("telno", telno);
							row.put("mpno", mpno);
							row.put("temp", temp);
							
							list.add(row);
						}
					}

				}
				
				//System.out.println("모델 : "+list.size());
				model.addObject("data", list);

			}
		} else {
			System.out.println("=================================================================<br>");
			System.out.println("[ERROR]<br>");
			System.out.println(jparser.getMessage(output));

			// 검색어 원상복귀
			if (query_end != null) {
				query = query_front + " " + query_end;
			} else {
				query = query.replace("*", "");
			}
			query = query_org;
			//System.out.println("query[input] : " + query);

		}

		model.addObject("paging", vo);

		return model;
	}
	
	//검색어 중 숫자 확인
	public static boolean isNumber(String str) {
		boolean result = false;
		try {
			Double.parseDouble(str);
			result = true;
		} catch (Exception e) {
		}
		return result;
		
	}
	
	public static String StringReplace(String str) {
		String str_imsi = "";
		String[] filter_word = { "\\.","\\?","\\/","\\~","\\!","\\$","\\%","\\^","\\\\","\\-"};
		for (int i=0; i < filter_word.length; i++) {
			str_imsi = str.replaceAll(filter_word[i], " ");
			str = str_imsi.trim();
		}
		return str;
	}
	/*
	 * public static void main(String[] args) {
	 * 
	 * Global gl = new Global();
	 * 
	 * Map paramaMap = new HashMap<>(); paramaMap.put("value", "1001");
	 * 
	 * gl.search(paramaMap, null );
	 * 
	 * }
	 */

}
