package com.sfr.common;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * PagerVO
 * @author LMS
 * @since 2014.12.09
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2014.12.09  LMS         최초 생성
 *  
 *  </pre>
 */
public class PagerVO implements Serializable {

	private static final long serialVersionUID = 5745131850727129844L;

    /** 현재페이지 */
    private int pageIndex = 1;

    /** 현재페이지 */
    private int pageSubIndex = 1;

    /** 페이지갯수 */
    private int pageUnit = 10;

    /** 페이지사이즈 */
    private int pageSize = 10;

    /** 페이지사이즈 */
    private int subPageSize = 10;

    /** firstIndex */
    private int firstIndex = 1;

    /** lastIndex */
    private int lastIndex = 1;

    /** recordCountPerPage */
    private int recordCountPerPage = 10;
    
    private int currentPage = 1;
    

	@Override
	public String toString() {
		return "PagerVO [pageIndex=" + pageIndex + ", pageSubIndex=" + pageSubIndex + ", pageUnit=" + pageUnit
				+ ", pageSize=" + pageSize + ", subPageSize=" + subPageSize + ", firstIndex=" + firstIndex
				+ ", lastIndex=" + lastIndex + ", recordCountPerPage=" + recordCountPerPage + ", currentPage="
				+ currentPage + "]";
	}

	/**
	 * pageIndex attribute 를 리턴한다.
	 * @return the int
	 */
	public int getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}

	public void setPageIndex(String pageIndex) {
		try {
			if (pageIndex != null && pageIndex.length()>0) {
				this.pageIndex = Integer.parseInt(pageIndex);
			} else {
				this.pageIndex = 1;
			}
		} catch (Exception e) {
			this.pageIndex = 1;
		}
	}


	/**
	 * pageIndex attribute 를 리턴한다.
	 * @return the int
	 */
	public int getPageSubIndex() {
		return pageSubIndex;
	}

	public void setPageSubIndex(int pageSubIndex) {
		this.pageSubIndex = pageSubIndex;
	}

	public void setPageSubIndex(String pageSubIndex) {
		try {
			if (pageSubIndex != null && pageSubIndex.length()>0) {
				this.pageSubIndex = Integer.parseInt(pageSubIndex);
			} else {
				this.pageSubIndex = 1;
			}
		} catch (Exception e) {
			this.pageSubIndex = 1;
		}
	}

	/**
	 * pageUnit attribute 를 리턴한다.
	 * @return the int
	 */
	public int getPageUnit() {
		return pageUnit;
	}

	public void setPageUnit(int pageUnit) {
		this.pageUnit = pageUnit;
	}

	public void setPageUnit(String pageUnit) {
		if (pageUnit != null && pageUnit.length()>0) {
			this.pageUnit = Integer.parseInt(pageUnit);
		} else {
			this.pageUnit = 10;
		}
	}

	/**
	 * pageSize attribute 를 리턴한다.
	 * @return the int
	 */
	public int getPageSize() {
		return pageSize;
	}

	/**
	 * pageSize attribute 값을 설정한다.
	 * @return pageSize int
	 */
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	/**
	 * firstIndex attribute 를 리턴한다.
	 * @return the int
	 */
	public int getFirstIndex() {
		return firstIndex;
	}

	/**
	 * firstIndex attribute 값을 설정한다.
	 * @return firstIndex int
	 */
	public void setFirstIndex(int firstIndex) {
		this.firstIndex = firstIndex;
	}

	/**
	 * lastIndex attribute 를 리턴한다.
	 * @return the int
	 */
	public int getLastIndex() {
		return lastIndex;
	}

	/**
	 * lastIndex attribute 값을 설정한다.
	 * @return lastIndex int
	 */
	public void setLastIndex(int lastIndex) {
		this.lastIndex = lastIndex;
	}

	/**
	 * recordCountPerPage attribute 를 리턴한다.
	 * @return the int
	 */
	public int getRecordCountPerPage() {
		return recordCountPerPage;
	}

	/**
	 * recordCountPerPage attribute 값을 설정한다.
	 * @return recordCountPerPage int
	 */
	public void setRecordCountPerPage(int recordCountPerPage) {
		this.recordCountPerPage = recordCountPerPage;
	}

	public int getSubPageSize() {
		return subPageSize;
	}

	public void setSubPageSize(int subPageSize) {
		this.subPageSize = subPageSize;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}


}
