package egovframework.example.servey.service;

public class UserVO {
	
	private static final long serialVersionUID = 1L;
	
	private String u_id;
	private String u_pwd;
	private String u_name;
	public String getU_id() {
		return u_id;
	}
	public void setU_id(String u_id) {
		this.u_id = u_id;
	}
	public String getU_pwd() {
		return u_pwd;
	}
	public void setU_pwd(String u_pwd) {
		this.u_pwd = u_pwd;
	}
	public String getU_name() {
		return u_name;
	}
	public void setU_name(String u_name) {
		this.u_name = u_name;
	}
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
}