package Dto;

import java.io.Serializable;

//임시 커리문  로그인
/*
CREATE TABLE CUSTUSER(
	ID VARCHAR2(50) PRIMARY KEY,
	NAME VARCHAR2(50) NOT NULL,
	ADDRESS VARCHAR2(50) NOT NULL
);
*/

/* DB QURE
DROP TABLE BBS
CASCADE CONSTRAINTS;

DROP SEQUENCE SEQ_BBS;

CREATE TABLE BBS(
	SEQ NUMBER(8) PRIMARY KEY,
	ID VARCHAR2(50) NOT NULL,
	
	REF NUMBER(8) NOT NULL,
	STEP NUMBER(8) NOT NULL,
	DEPTH NUMBER(8) NOT NULL,
	
	TITLE VARCHAR2(200) NOT NULL,
	CONTENT VARCHAR2(4000) NOT NULL,
	WDATE DATE NOT NULL,
	
	PARENT NUMBER(8) NOT NULL,
	
	DEL NUMBER(1) NOT NULL,
	READCOUNT NUMBER(8) NOT NULL
);

CREATE SEQUENCE SEQ_BBS
START WITH 1 INCREMENT BY 1;

ALTER TABLE BBS
ADD CONSTRAINT FK_BBS_ID FOREIGN KEY(ID)
REFERENCES MEMBER(ID);
*/

public class QADto implements Serializable {

	private int seq; // 순서번호
	private String id; // 임시 로그인
	private String name; // 임시 이름
	private String address; // 임시 주소

	private int ref; // 그룹번호
	private int step; // 열번호
	private int depth; // 깊이

	private String title; // 제목
	private String content; // 내용
	private String wdate; // 작성날자

	private int parent; // 부모글 번호

	private int del; // 삭제 여부
	private int readcount; // 조회수

	//기본생성자
	public QADto() {
	}

	public QADto(String id, String name, String address) {
		super();
		this.id = id;
		this.name = name;
		this.address = address;
	}

	public QADto(int seq, String id, String name, String address, int ref, int step, int depth, String title,
			String content, String wdate, int parent, int del, int readcount) {
		super();
		this.seq = seq;
		this.id = id;
		this.name = name;
		this.address = address;
		this.ref = ref;
		this.step = step;
		this.depth = depth;
		this.title = title;
		this.content = content;
		this.wdate = wdate;
		this.parent = parent;
		this.del = del;
		this.readcount = readcount;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public int getRef() {
		return ref;
	}

	public void setRef(int ref) {
		this.ref = ref;
	}

	public int getStep() {
		return step;
	}

	public void setStep(int step) {
		this.step = step;
	}

	public int getDepth() {
		return depth;
	}

	public void setDepth(int depth) {
		this.depth = depth;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getWdate() {
		return wdate;
	}

	public void setWdate(String wdate) {
		this.wdate = wdate;
	}

	public int getParent() {
		return parent;
	}

	public void setParent(int parent) {
		this.parent = parent;
	}

	public int getDel() {
		return del;
	}

	public void setDel(int del) {
		this.del = del;
	}

	public int getReadcount() {
		return readcount;
	}

	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}

	@Override
	public String toString() {
		return "QADto [seq=" + seq + ", id=" + id + ", name=" + name + ", address=" + address + ", ref=" + ref
				+ ", step=" + step + ", depth=" + depth + ", title=" + title + ", content=" + content + ", wdate="
				+ wdate + ", parent=" + parent + ", del=" + del + ", readcount=" + readcount + "]";
	}

}
