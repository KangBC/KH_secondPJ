package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import DB.DBClose;
import DB.DBConnection;
import Dto.PdsDto;


public class PdsDao {

	private static PdsDao pdsdao = new PdsDao();
	
	private PdsDao() {
		DBConnection.initConnect();
	}
	
	public static PdsDao getInstance() {
		return pdsdao;
	}
	
	public List<PdsDto> getPdsList(){
		
		String sql =" SELECT SEQ, ID, TITLE, CONTENT, FILENAME, "
				+ " READCOUNT, DOWNCOUNT, REGDATE "
				+ " FROM PDS "
				+ " ORDER BY SEQ DESC ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<PdsDto> list = new ArrayList<>();
		
		try {
			conn = DBConnection.makeConnection();
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				PdsDto dto = new PdsDto(rs.getInt(1),
								rs.getString(2),
								rs.getString(3),
								rs.getString(4),
								rs.getString(5),
								rs.getInt(6),
								rs.getInt(7),
								rs.getString(8));
				list.add(dto);	
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return list;
	}
	
	
	
	
	public boolean writePds(PdsDto pds) {
		
		String sql =" INSERT INTO PDS( "
				+ " SEQ, ID, TITLE, CONTENT, FILENAME, "
				+ " READCOUNT, DOWNCOUNT, REGDATE) "
				+ " VALUES(SEQ_PDS.NEXTVAL, "
				+ " ?, ?, ?, ?, "
				+ " 0, 0, SYSDATE) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
			
			try {
				conn = DBConnection.makeConnection();
				psmt = conn.prepareStatement(sql);
				
				psmt.setString(1, pds.getId());
				psmt.setString(2, pds.getTitle());
				psmt.setString(3, pds.getContent());
				psmt.setString(4, pds.getFilename());
				
				count = psmt.executeUpdate();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				DBClose.close(psmt, conn, null);
			}
		return count>0?true:false;
		
	}
	
	public boolean downloadcount(int seq) {

		String sql = " UPDATE PDS "
				+ " SET DOWNCOUNT=DOWNCOUNT+1 "
				+ " WHERE SEQ=? ";
		
		Connection conn = null;			
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.makeConnection();
			System.out.println("1/6 downloadcount success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/6 downloadcount success");
			
			count = psmt.executeUpdate();
			System.out.println("3/6 downloadcount success");
			
		} catch (SQLException e) {
			System.out.println("downloadcount fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, null);
		}
		
		return count>0?true:false;
	}
	
	public PdsDto getPDS(int seq) {

		String sql = " SELECT SEQ, ID, TITLE, CONTENT, FILENAME, READCOUNT, DOWNCOUNT, REGDATE " 
					+ " FROM PDS " 
					+ " WHERE SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		PdsDto dto = null;
		
		try {
			conn = DBConnection.makeConnection();
			psmt = conn.prepareStatement(sql);
		
			psmt.setInt(1, seq);
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				seq = rs.getInt(1);
				String id = rs.getString(2);
				String title = rs.getString(3);
				String content = rs.getString(4);
				String filename = rs.getString(5);
				int readcount = rs.getInt(6);
				int downcount = rs.getInt(7);
				String regdate = rs.getString(8);
				
				dto = new PdsDto(seq, id, title, content, filename, readcount, downcount, regdate);
			}
				
		} catch (SQLException e) {
			System.out.println("getBbs failed");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return dto;
	}
	
	public void pdsReadCount(int seq) {

		String sql = " UPDATE PDS SET "
					+ " READCOUNT=READCOUNT+1 "
					+ " WHERE SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try {
			conn = DBConnection.makeConnection();
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			
			psmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("readCount failed");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
	}
	
	
}










