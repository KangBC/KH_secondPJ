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
	
	public boolean addMember(MemberDto dto) {
		int count = 0;
		
		return count > 0? true : false;
	}
	
	public MemberDto Login(String id, String pw) {

		String sql = " SELECT ID, NAME, AUTH FROM MEMBER WHERE ID = ? AND PWD = ? ";
		
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
