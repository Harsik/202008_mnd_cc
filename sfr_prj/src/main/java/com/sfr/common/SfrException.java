package com.sfr.common;

public class SfrException extends Exception {

	private static final long serialVersionUID = -2473766205162602999L;
		
	private String errMsg;
	private String errCode;
	private String job;
	 
	public SfrException(String errMsg, String errCode, String job) {
		this.errMsg = errMsg;
		this.errCode = errCode;
		this.job = job;
	}
	
	@Override
	public String getMessage() {
		return errCode + " : " + errMsg + "( " + job + " )";
	}
}