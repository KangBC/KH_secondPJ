package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import DB.DBClose;
import DB.DBConnection;
import Dto.MemberDto;

public class MemberDao {
	private static MemberDao mDao = new MemberDao();
	
	private MemberDao() {
		DBConnection.initConnect();
	}
	
	public static MemberDao getInstance() {
		return mDao;
	}
	
	public MemberDto getMember(String id) {
		MemberDto member = null;
		String sql = " SELECT ID, NAME, PARTNER, PHONE, EMAIL FROM KH_MEMBER WHERE ID = '" + id + "' ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try {
			conn = DBConnection.makeConnection();
			psmt = conn.prepareStatement(sql);
			
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				member = new MemberDto(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, null);
		}

		return member;
	}
	
	public boolean addMember(MemberDto dto) {
		int count = 0;
		String sql = " INSERT INTO KH_MEMBER VALUES(?, ?, ?, ?, ?, ?, 0) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;

		try {
			conn = DBConnection.makeConnection();
			psmt = conn.prepareStatement(sql);

			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getPw());
			psmt.setString(3, dto.getName());
			psmt.setString(4, dto.getPartner());
			psmt.setString(5, dto.getPhone());
			psmt.setString(6, dto.getEmail());

			count = psmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, null);
		}

		return count > 0? true : false;
	}
	
	public boolean idCheck(String id) {
		int count = 0;
		String sql = " SELECT ID FROM KH_MEMBER WHERE ID = '" + id + "' ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		try {
			conn = DBConnection.makeConnection();
			psmt = conn.prepareStatement(sql);

			count = psmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, null);
		}
		return count > 0? true : false;
	}
	
	public boolean update(MemberDto dto) {
		int count = 0;
		String sql = " UPDATE KH_MEMBER SET NAME=?, PARTNER=?, PHONE=?, EMAIL=? WHERE ID=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;

		try {
			conn = DBConnection.makeConnection();
			psmt = conn.prepareStatement(sql);

			psmt.setString(1, dto.getName());
			psmt.setString(2, dto.getPartner());
			psmt.setString(3, dto.getPhone());
			psmt.setString(4, dto.getEmail());
			psmt.setString(5, dto.getId());

			count = psmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, null);
		}

		return count > 0? true : false;
	}
	
	public MemberDto Login(String id, String pw) {

		String sql = " SELECT ID, NAME, AUTH FROM KH_MEMBER WHERE ID = ? AND PWD = ? ";
		
		MemberDto dto = null;

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try {
			conn = DBConnection.makeConnection();
			psmt = conn.prepareStatement(sql);

			psmt.setString(1, id);
			psmt.setString(2, pw);
			
			rs = psmt.executeQuery();
			if(rs.next()) {
				dto = new MemberDto(rs.getString(1), rs.getString(2), rs.getInt(3));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		
		return dto;
	}
	
}
