package Dao;

import Dto.ReservDto;
import java.util.*;
import java.sql.*;
import DB.*;

public class ReservDao {
	
private static ReservDao calDao = new ReservDao();
	
	private ReservDao() {
		DB.DBConnection.initConnect();
	}
	
	public static ReservDao getInstance() {
		return calDao;
	}

	public List<String> getCalendarList(String id, String yyyyMM) {
		
		String sql = " SELECT SEQ, ID, TITLE, CONTENT, RDATE, WDATE "
				+ " FROM("
				+ "		SELECT ROW_NUMBER() OVER(PARTITION BY SUBSTR(RDATE, 1, 8) "
				+ "								ORDER BY RDATE ASC) RN, "
				+ "			SEQ, ID, TITLE, CONTENT, RDATE, WDATE "
				+ "		FROM CALENDAR "
				+ "		WHERE ID=? AND SUBSTR(RDATE, 1, 6)=? ) "
				+ "	WHERE RN BETWEEN 1 AND 5";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<String> list = new ArrayList<>();
		
		try {
			conn = DBConnection.makeConnection();
			System.out.println("1/6 getCalendarList success");
				
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id.trim());
			psmt.setString(2, yyyyMM.trim());
			System.out.println("2/6 getCalendarList success");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 getCalendarList success");
			
			while(rs.next()) {
				ReservDto dto = new ReservDto();
				dto.setSeq(rs.getInt(1));
				dto.setId(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4));
				dto.setRdate(rs.getString(5));
				dto.setWdate(rs.getString(6));
				
				list.add(dto.toString());				
			}		
			System.out.println("4/6 getCalendarList success");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			
			DBClose.close(psmt, conn, rs);
			System.out.println("5/6 getCalendarList success");
		}		
		
		return list;
	}
	
	/*private int seq;
	private String id;
	private String title;
	private String content;
	private String rdate;
	private String wdate;*/

	public boolean makeSchedule(ReservDto dto) {
		String sql = "INSERT INTO CALENDAR VALUES(SEQ_CAL.NEXTVAL, ?, ?, ?, ?, SYSDATE)";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		try {
			conn = DBConnection.makeConnection();
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getRdate());
			
			count = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return count>0?true:false;
	}
	

	public ReservDto getSchedule(int seq) {
		String sql = "SELECT * FROM CALENDAR WHERE SEQ=?";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		ReservDto dto = null;
		
		try {
			conn = DBConnection.makeConnection();
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			
			rs = psmt.executeQuery();
			
			if (rs.next()) {
				dto = new ReservDto(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6));
			}
				
				
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}


	public List<ReservDto> getDayList(String id, String date) {
		
		String sql = "SELECT * FROM CALENDAR WHERE ID=? AND SUBSTR(RDATE, 1, 8)=?";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<ReservDto> list = new ArrayList<ReservDto>();
		
		try {
			conn = DBConnection.makeConnection();
			System.out.println("1/6 getCalendarList success");
				
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id.trim());
			psmt.setString(2, date.trim());
			System.out.println("2/6 getCalendarList success");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 getCalendarList success");
			
			while(rs.next()) {
				ReservDto dto = new ReservDto();
				dto.setSeq(rs.getInt(1));
				dto.setId(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4));
				dto.setRdate(rs.getString(5));
				dto.setWdate(rs.getString(6));
				
				list.add(dto);				
			}		
			System.out.println("4/6 getCalendarList success");
			
		} catch (SQLException e) {

			e.printStackTrace();
		} finally {
			
			DBClose.close(psmt, conn, rs);
			System.out.println("5/6 getCalendarList success");
		}		
		
		return list;

	}
	
	public boolean checkpossible(String date) {
		String sql = "SELECT * FROM CALENDAR WHERE RDATE=?";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		boolean result = false;
		
		
		try {
			conn = DBConnection.makeConnection();
			System.out.println("1/6 getCalendarList success");
				
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, date.trim());
			System.out.println("2/6 getCalendarList success");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 getCalendarList success");
			
			if(!rs.next()) {
				result = true;
			}
			
		} catch (SQLException e) {

			e.printStackTrace();
		} finally {
			
			DBClose.close(psmt, conn, rs);
			System.out.println("5/6 getCalendarList success");
		}
		
		return result;
	}

}
