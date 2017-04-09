package com.flame.model;


public class ResponseBean {
	private String retnCode = null;
	private String retnDesc = null;
	private Object results = null;

	public ResponseBean(){}

	public ResponseBean(String retnCode, String retnDesc){
		this.retnCode = retnCode;
		this.retnDesc = retnDesc;
	}

	public static ResponseBean ERROR_400(String retnDesc){
		return new ResponseBean("-1", retnDesc);
	}

	public String getRetnCode() {
		return retnCode;
	}

	public void setRetnCode(String retnCode) {
		this.retnCode = retnCode;
	}

	public String getRetnDesc() {
		return retnDesc;
	}

	public void setRetnDesc(String retnDesc) {
		this.retnDesc = retnDesc;
	}

	public Object getResults() {
		return results;
	}

	public void setResults(Object results) {
		this.results = results;
	}



}
