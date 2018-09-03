package Dto;

public class ReservDto {
	
	private int seq;
	private String id;
	private String title;
	private String content;
	private String rdate;
	private String wdate;
	
	public ReservDto(int seq, String id, String title, String content, String rdate, String wdate) {
		super();
		this.seq = seq;
		this.id = id;
		this.title = title;
		this.content = content;
		this.rdate = rdate;
		this.wdate = wdate;
	}

	public ReservDto(String id, String title, String content, String rdate) {
		super();
		this.id = id;
		this.title = title;
		this.content = content;
		this.rdate = rdate;
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

	public String getRdate() {
		return rdate;
	}

	public void setRdate(String rdate) {
		this.rdate = rdate;
	}

	public String getWdate() {
		return wdate;
	}

	public void setWdate(String wdate) {
		this.wdate = wdate;
	}

	@Override
	public String toString() {
		return "{\"seq\":" + seq + ", \"id\":\"" + id + "\", \"title\":\"" + title + "\", \"content\":\"" + content + "\", \"start\":\"" 
				+ rdate.substring(0, 4)+"-"+rdate.substring(4, 6) + "-" +rdate.substring(6,8) + "T" + rdate.substring(8, 10)+ ":" + rdate.substring(10, 12)+":00"
				+ "\", \"wdate\":\"" + wdate + "\",  \"allDay\" : false}";
	}

	public ReservDto() {

	}
	
	
	
	
	

}
