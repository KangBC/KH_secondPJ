package Dto;

public class ReplyDto {
	
	private int seq;
	private String id;
	
	private int ref;
	private int step;
	private int depth;
	private int parent;
	
	private String content;
	private String wdate;
	private int del;
	
	public ReplyDto(int seq, String id, int ref, int step, int depth, int parent, String content, String wdate,
			int del) {
		super();
		this.seq = seq;
		this.id = id;
		this.ref = ref;
		this.step = step;
		this.depth = depth;
		this.parent = parent;
		this.content = content;
		this.wdate = wdate;
		this.del = del;
	}
	
	
	public ReplyDto(String id, int ref, int parent, String content) {
		super();
		this.id = id;
		this.ref = ref;
		this.parent = parent;
		this.content = content;
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
	public int getParent() {
		return parent;
	}
	public void setParent(int parent) {
		this.parent = parent;
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
	public int getDel() {
		return del;
	}
	public void setDel(int del) {
		this.del = del;
	}
	

	
	/*CREATE SEQUENCE SEQ_REP
	START WITH 1 INCREMENT BY 1;
	
	
	CREATE TABLE REP(
			SEQ NUMBER(8) PRIMARY KEY,
			ID VARCHAR2(50) NOT NULL,
			
			REF NUMBER(8) NOT NULL,
            STEP NUMBER(8) NOT NULL,
            DEPTH NUMBER(8) NOT NULL,
            PARENT NUMBER(8) NOT NULL,

			CONTENT VARCHAR2(4000) NOT NULL,
			WDATE DATE NOT NULL,
			DEL NUMBER(1) NOT NULL
		);
	
	ALTER TABLE REP
	ADD CONSTRAINT FK_REP_REF FOREIGN KEY(REF)
	REFERENCES BBS(SEQ);*/
	
	
	

}
