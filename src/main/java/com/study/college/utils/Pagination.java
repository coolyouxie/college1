package com.study.college.utils;

public class Pagination {
	
	/**
	 * 当前页码
	 */
	private int page = 1;
	
	/**
	 * 显示行数
	 */
	private int rows = 10;
	
	/**
	 * 总页数
	 */
	private int total;
	
	/**
	 * 总行数
	 */
	private int records;
	
	/**
	 * 排序属性名
	 */
	private String sidx;
	
	/**
	 * 排序方式desc或asc
	 */
	private String sord;
	
	private boolean search = false;
	
	public Pagination(){
	}
	
	public Pagination(int page,int customRows){
		this.page = page;
		this.rows = customRows;
	}
	
	public Pagination(int page,int rows,String sidx,String sord){
		this.page = page;
		this.rows = rows;
		this.sidx = sidx;
		this.sord = sord;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		if(page<1){
			page = 1;
		}
		this.page = page;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public int getRecords() {
		return records;
	}

	public void setRecords(int records) {
		this.records = records;
	}

	public int getRows() {
		return rows;
	}

	public void setRows(int rows) {
		if(rows<0){
			rows=10;
		}
		if(rows>9999){
			rows = 9999;
		}
		this.rows = rows;
	}

	public String getSidx() {
		return sidx;
	}

	public void setSidx(String sidx) {
		this.sidx = sidx;
	}

	public String getSord() {
		return sord;
	}

	public void setSord(String sord) {
		this.sord = sord;
	}

	public boolean isSearch() {
		return search;
	}

	public void setSearch(boolean search) {
		if(search){
			page = 1;
		}
		this.search = search;
	}
	
	public void setRowsByCustom(int customRows){
		this.rows = customRows;
	}
	
	public void countRecords(int records){
		if(records<0){
			records = 0;
		}
		this.records = records;
		if(records%rows == 0){
			total = records/rows;
		}else{
			total = records/rows+1;
		}
		if(page>total){
			page = total;
		}else if(page<=0){
			page = 1;
		}
	}
	
	public int getStartRow(){
		return (this.page-1)*this.rows+1;
	}
	
	public int getEndRow(){
		int last = this.page*this.rows;
		return this.records>0 && last>this.records ? this.records : last;
	}
	
	@Override
    public String toString() {
        return "Pagination{" +
                "page=" + page +
                ", rows=" + rows +
                ", records=" + records +
                ", total=" + total +
                ", sidx='" + sidx + '\'' +
                ", sord='" + sord + '\'' +
                ", search=" + search +
                '}';
    }

}
