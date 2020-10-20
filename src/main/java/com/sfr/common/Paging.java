package com.sfr.common;

import java.io.IOException;
import java.text.MessageFormat;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


public class Paging extends TagSupport {
	private static final long serialVersionUID = 1L;
	private PaginationInfo paginationInfo;
	private String type;
	private String jsFunction;
	private String jsRowFunction;
	private boolean rowControl;
	
	private String firstPageLabel;
	private String previousPageLabel;
	private String currentPageLabel;
	private String otherPageLabel;
	private String nextPageLabel;
	private String lastPageLabel;
	private String numberSpliter;
	
	public int doEndTag() throws JspException {
		try {
			JspWriter out = this.pageContext.getOut();
			
			/* tyep of paging design  = portal, support, mngt */
			
			this.firstPageLabel    = "<a href=javascript:{0}({1}) class=btn_first><span>첫페이지로 이동</span></a> ";
			this.previousPageLabel = "<a href=javascript:{0}({1}) class=btn_prev><span>이전 페이지로 이동</span></a> ";
			this.currentPageLabel  = "<a href=javascript:void(0) class=on>{0}</a> ";
			this.otherPageLabel    = "<a href=javascript:{0}({1})>{2}</a> ";
			this.nextPageLabel     = "<a href=javascript:{0}({1}) class=btn_next><span>다음 페이지로 이동</span></a> ";
			this.lastPageLabel     = "<a href=javascript:{0}({1}) class=btn_last><span>마지막페이지로 이동</span></a> ";
			this.numberSpliter     = "";
			
			/*
			if( "mgnt".equals(this.type)) {
				this.firstPageLabel    = "<a href=javascript:{0}({1}) class=btn_first><span>첫페이지로 이동</span></a> ";
				this.previousPageLabel = "<a href=javascript:{0}({1}) class=btn_prev><span>이전 페이지로 이동</span></a> ";
				this.currentPageLabel  = "<a href=javascript:void(0) class=on>{0}</a> ";
				this.otherPageLabel    = "<a href=javascript:{0}({1})>{2}</a> ";
				this.nextPageLabel     = "<a href=javascript:{0}({1}) class=btn_next><span>다음 페이지로 이동</span></a> ";
				this.lastPageLabel     = "<a href=javascript:{0}({1}) class=btn_last><span>마지막페이지로 이동</span></a> ";
				this.numberSpliter     = "";
			}
			*/
			/*if( "portal".equals(this.type) ) {
				this.firstPageLabel    = "<a href=javascript:{0}({1}) class=mr5><img src=/theme/00001/ko/support/images/paging_01.jpg alt=처음으로 /></a> ";
				this.previousPageLabel = "<a href=javascript:{0}({1}) onclick={0}({1});return false;  class=mr10><img src=/theme/00001/ko/support/images/paging_02.jpg alt=이전 /></a> ";
				this.currentPageLabel  = "<a href=javascript:void(0) class=on>{0}</a> ";
				this.otherPageLabel    = "<a href=javascript:{0}({1})>{2}</a> ";
				this.nextPageLabel     = "<a href=javascript:{0}({1}) class=ml10><img src=/theme/00001/ko/support/images/paging_03.jpg alt=다음 /></a> ";
				this.lastPageLabel     = "<a href=javascript:{0}({1}) class=ml5><img src=/theme/00001/ko/support/images/paging_04.jpg alt=마지막으로 /></a> ";
				this.numberSpliter     = "<span class=\"gray1 ml5 mr5\">|</span> ";
			} else if( "support".equals(this.type) ) {
				this.firstPageLabel    = "<a href=javascript:{0}({1}) class=mr5><img src=/theme/00001/ko/support/images/paging_01.jpg alt=처음으로 /></a> ";
				this.previousPageLabel = "<a href=javascript:{0}({1}) class=mr10><img src=/theme/00001/ko/support/images/paging_02.jpg alt=이전 /></a> ";
				this.currentPageLabel  = "<a href=javascript:void(0) class=on>{0}</a> ";
				this.otherPageLabel    = "<a href=javascript:{0}({1})>{2}</a> ";
				this.nextPageLabel     = "<a href=javascript:{0}({1}) class=ml10><img src=/theme/00001/ko/support/images/paging_03.jpg alt=다음 /></a> ";
				this.lastPageLabel     = "<a href=javascript:{0}({1}) class=ml5><img src=/theme/00001/ko/support/images/paging_04.jpg alt=마지막으로 /></a> ";
				this.numberSpliter     = "<span class=\"gray1 ml5 mr5\">|</span> ";
			} else if( "mgnt".equals(this.type)) {
				this.firstPageLabel    = "<a href=javascript:{0}({1}) class=mr5><img src=/theme/00001/ko/support/images/paging_01.jpg alt=처음으로 /></a> ";
				this.previousPageLabel = "<a href=javascript:{0}({1}) class=mr10><img src=/theme/00001/ko/support/images/paging_02.jpg alt=이전 /></a> ";
				this.currentPageLabel  = "<a href=javascript:void(0) class=on>{0}</a> ";
				this.otherPageLabel    = "<a href=javascript:{0}({1})>{2}</a> ";
				this.nextPageLabel     = "<a href=javascript:{0}({1}) class=ml10><img src=/theme/00001/ko/support/images/paging_03.jpg alt=다음 /></a> ";
				this.lastPageLabel     = "<a href=javascript:{0}({1}) class=ml5><img src=/theme/00001/ko/support/images/paging_04.jpg alt=마지막으로 /></a> ";
				this.numberSpliter     = "<span class=\"gray1 ml5 mr5\">|</span> ";
			} else {
				this.firstPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\">[처음]</a>&#160;";
				this.previousPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\">[이전]</a>&#160;";
				this.currentPageLabel = "<strong>{0}</strong>&#160;";
				this.otherPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\">{2}</a>&#160;";
				this.nextPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\">[다음]</a>&#160;";
				this.lastPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\">[마지막]</a>&#160;";
				this.numberSpliter = "";
			}*/
			
			String contents = renderPagination(this.paginationInfo, this.jsFunction, this.jsRowFunction);

			out.println(contents);

			return 6;
		} catch (IOException e) {
			throw new JspException();
		}
	}

	public void setPaginationInfo(PaginationInfo paginationInfo) {
		this.paginationInfo = paginationInfo;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	public void setJsFunction(String jsFunction) {
		this.jsFunction = jsFunction;
	}
	
	public void setJsRowFunction(String jsRowFunction) {
		this.jsRowFunction = jsRowFunction;
	}
	
	public void setRowControl(boolean rowControl) {
		this.rowControl = rowControl;
	}
	
	/* logic of paging */
	public String renderPagination(PaginationInfo paginationInfo, String jsFunction, String jsRowFunction) {
		StringBuffer strBuff = new StringBuffer();

		int firstPageNo = paginationInfo.getFirstPageNo();
		int firstPageNoOnPageList = paginationInfo.getFirstPageNoOnPageList();
		int totalPageCount = paginationInfo.getTotalPageCount();
		int pageSize = paginationInfo.getPageSize();
		int lastPageNoOnPageList = paginationInfo.getLastPageNoOnPageList();
		int currentPageNo = paginationInfo.getCurrentPageNo();
		int lastPageNo = paginationInfo.getLastPageNo();
		int recordCountPerPage = paginationInfo.getRecordCountPerPage();
		strBuff.append("<div class=\"f_left\">");
		if( this.rowControl ) {
			strBuff.append("<select name=recordCountPerPage class=\"w120\" onchange="+jsRowFunction+"(this.value)>");
			for(int i=10; i<=30 ; i+=10) {
				if( recordCountPerPage == i) {
					strBuff.append("<option value="+i+" selected=selected>"+i+"개씩 보기</option>");
				} else {
					strBuff.append("<option value="+i+">"+i+"개씩 보기</option>");
				}
			}
			strBuff.append("</select>");
		}
		strBuff.append("</div>");
		strBuff.append("<div class=\"pagination\">");
		if (totalPageCount > pageSize) {
			if (firstPageNoOnPageList > pageSize) {
				strBuff.append(MessageFormat.format(this.firstPageLabel, new Object[] { jsFunction, Integer.toString(firstPageNo) }));
				strBuff.append(MessageFormat.format(this.previousPageLabel, new Object[] { jsFunction, Integer.toString(firstPageNoOnPageList - 1) }));
			} else {
				strBuff.append(MessageFormat.format(this.firstPageLabel, new Object[] { jsFunction, Integer.toString(firstPageNo) }));
				strBuff.append(MessageFormat.format(this.previousPageLabel, new Object[] { jsFunction, Integer.toString(firstPageNo) }));
			}
		}

		for (int i = firstPageNoOnPageList; i <= lastPageNoOnPageList; i++) {
			if (i == currentPageNo){
				strBuff.append(MessageFormat.format(this.currentPageLabel, new Object[] { Integer.toString(i) }));
				if (lastPageNoOnPageList != i) {
					strBuff.append(this.numberSpliter);
				}
			} else {
				strBuff.append(MessageFormat.format(this.otherPageLabel, new Object[] { jsFunction, Integer.toString(i), Integer.toString(i) }));
				if (lastPageNoOnPageList != i) {
					strBuff.append(this.numberSpliter);
				}
			}
		}

		if (totalPageCount > pageSize) {
			if (lastPageNoOnPageList < totalPageCount) {
				strBuff.append(MessageFormat.format(this.nextPageLabel, new Object[] { jsFunction, Integer.toString(firstPageNoOnPageList + pageSize) }));
				strBuff.append(MessageFormat.format(this.lastPageLabel, new Object[] { jsFunction, Integer.toString(lastPageNo) }));
			} else {
				strBuff.append(MessageFormat.format(this.nextPageLabel, new Object[] { jsFunction, Integer.toString(lastPageNo) }));
				strBuff.append(MessageFormat.format(this.lastPageLabel, new Object[] { jsFunction, Integer.toString(lastPageNo) }));
			}
		}
		
		strBuff.append("</div>");
		return strBuff.toString();
	}
}
