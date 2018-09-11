package Dto;

/*
 * CREATE TABLE KH_MEMBER(
		ID VARCHAR2(50) PRIMARY KEY,
		PWD VARCHAR2(50) NOT NULL,
		NAME VARCHAR2(50) NOT NULL,
		PARTNER VARCHAR2(50),
		PHONE VARCHAR2(50) NOT NULL,
		EMAIL VARCHAR2(50) NOT NULL,
		AUTH NUMBER(1) NOT NULL
);

INSERT INTO KH_MEMBER VALUES('ADMIN', '1', 'ADMIN', , 'NULL', 'NULL', 1);
*/

public class MemberDto {
	private String id;
	private String pw;
	
	private String name;
	private String partner;
	private String phone;
	private String email;
	
	private int auth;		// 0:User 1:Admin
	
	public MemberDto() {
	}

	public MemberDto(String id, String name, int auth) {
		super();
		this.id = id;
		this.name = name;
		this.auth = auth;
	}

	
	
	public MemberDto(String id, String name, String partner, String phone, String email) {
		super();
		this.id = id;
		this.name = name;
		this.partner = partner;
		this.phone = phone;
		this.email = email;
	}

	public MemberDto(String id, String pw, String name, String partner, String phone, String email) {
		super();
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.partner = partner;
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
	
	public String getPartner() {
		return partner;
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
