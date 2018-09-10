package Dto;

import java.io.Serializable;

public class PdsDto implements Serializable{
/*
CREATE TABLE PDS(
   SEQ NUMBER(8) PRIMARY KEY,
   ID VARCHAR2(50) NOT NULL,
   TITLE VARCHAR2(200) NOT NULL,
   CONTENT VARCHAR2(4000) NOT NULL,
   FILENAME VARCHAR2(50) NOT NULL,
    DEL NUMBER(8) NOT NULL,
   READCOUNT NUMBER(8) NOT NULL,
   DOWNCOUNT NUMBER(8) NOT NULL,
   REGDATE DATE NOT NULL
);*/
	private int seq;
	private String id;
	private String title;
	private String content;
	private String filename;
	private int del;
	private int readcount;
	private int downcount;
	private String regdate;
	
	
	public PdsDto() {
		
	}


	public PdsDto(int seq, String id, String title, String content, String filename, int del, int readcount,
			int downcount, String regdate) {
		super();
		this.seq = seq;
		this.id = id;
		this.title = title;
		this.content = content;
		this.filename = filename;
		this.del = del;
		this.readcount = readcount;
		this.downcount = downcount;
		this.regdate = regdate;
	}
	
	


	public PdsDto(String id, String title, String content, String filename) {
		super();
		this.id = id;
		this.title = title;
		this.content = content;
		this.filename = filename;
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


	public String getFilename() {
		return filename;
	}


	public void setFilename(String filename) {
		this.filename = filename;
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


	public int getDowncount() {
		return downcount;
	}


	public void setDowncount(int downcount) {
		this.downcount = downcount;
	}


	public String getRegdate() {
		return regdate;
	}


	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}


	@Override
	public String toString() {
		return "PdsDto [seq=" + seq + ", id=" + id + ", title=" + title + ", content=" + content + ", filename="
				+ filename + ", del=" + del + ", readcount=" + readcount + ", downcount=" + downcount + ", regdate="
				+ regdate + "]";
	}
	
	

		
}
