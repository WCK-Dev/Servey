package egovframework.example.servey.service;

import java.sql.Timestamp;

public class ServeyVO {
	
	private int s_seq;
	private String s_name;
	private Timestamp s_startdate;
	private Timestamp s_enddate;
	private String s_company;
	
	public int getS_seq() {
		return s_seq;
	}
	public void setS_seq(int s_seq) {
		this.s_seq = s_seq;
	}
	public String getS_name() {
		return s_name;
	}
	public void setS_name(String s_name) {
		this.s_name = s_name;
	}
	public Timestamp getS_startdate() {
		return s_startdate;
	}
	public void setS_startdate(Timestamp s_startdate) {
		this.s_startdate = s_startdate;
	}
	public Timestamp getS_enddate() {
		return s_enddate;
	}
	public void setS_enddate(Timestamp s_enddate) {
		this.s_enddate = s_enddate;
	}
	public String getS_company() {
		return s_company;
	}
	public void setS_company(String s_company) {
		this.s_company = s_company;
	}
	
}
