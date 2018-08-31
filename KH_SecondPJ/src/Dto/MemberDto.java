package Dto;

public class MemberDto {
	private String id;
	private String pw;
	
	private String name;
	private String phone;
	private String email;
	
	private int auth;
	
	public MemberDto() {
	}

	public MemberDto(String id, String name, int auth) {
		super();
		this.id = id;
		this.name = name;
		this.auth = auth;
	}

	public MemberDto(String id, String pw, String name, String phone, String email) {
		super();
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.phone = phone;
		this.email = email;
	}

	public String getId() {
		return id;
	}

	public String getPw() {
		return pw;
	}

	public String getName() {
		return name;
	}

	public String getPhone() {
		return phone;
	}

	public String getEmail() {
		return email;
	}

	public int getAuth() {
		return auth;
	}
	
}
