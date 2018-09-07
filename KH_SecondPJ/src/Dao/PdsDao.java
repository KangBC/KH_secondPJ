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
import Dto.QADto;


public class PdsDao {

	private static PdsDao pdsdao = new PdsDao();
	
	private PdsDao() {
		DBConnection.initConnect();
	}
	
	public static PdsDao getInstance() {
		return pdsdao;
	}
	
	public int getAllCount(int option, String searchstr) {
        int count = 0;
        
        String sql = "SELECT COUNT(*) FROM PDS";
        
        if(searchstr != null) {
        	searchstr = "%"+searchstr+"%";
			
        	if(option == 1) {
        		sql += " WHERE ID LIKE ?";
        	}else if (option == 2) {
        		sql += " WHERE TITLE LIKE ?";
        	}
    		
        }
        Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

        try {
            //쿼리 준비
            conn = DBConnection.makeConnection();
            psmt = conn.prepareStatement(sql);
            if(option != 0) {
            	psmt.setString(1, searchstr);
            }

            //쿼리 실행 후 결과 리턴
            rs = psmt.executeQuery();
            if (rs.next()) { //데이터가 있다면
                count = rs.getInt(1);

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }
	
	public List<PdsDto> getPdsList(int startnum, int endnum){
		
		String sql ="SELECT * FROM (SELECT A.* , ROWNUM RNUM FROM (SELECT * FROM pds ORDER by seq desc) A ) "
                + " WHERE RNUM >= ? AND RNUM <= ?";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		System.out.println(startnum);
		
		List<PdsDto> list = new ArrayList<>();
		
		try {
			conn = DBConnection.makeConnection();
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, startnum);
			psmt.setInt(2, endnum);
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				PdsDto dto = new PdsDto(rs.getInt(1),
								rs.getString(2),
								rs.getString(3),
								rs.getString(4),
								rs.getString(5),
								rs.getInt(10),
								rs.getInt(7),
								rs.getInt(8),
								rs.getString(9));
				list.add(dto);	
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return list;
	}
	
	
	
	
	public boolean writePds(PdsDto pds) {
		String sql = " INSERT INTO PDS( "
				+ " SEQ, ID, TITLE, CONTENT, FILENAME, DEL, "
				+ " READCOUNT, DOWNCOUNT, REGDATE) "
				+ " VALUES(SEQ_PDS.NEXTVAL, "
				+ " ?, ?, ?, ?, 0, 0, 0, SYSDATE) ";
		
		int count = 0;
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		try {
			conn = DBConnection.makeConnection();
			psmt = conn.prepareStatement(sql);
			
			psmt.setString(1, pds.getId());
			psmt.setString(2, pds.getTitle());
			psmt.setString(3, pds.getContent());
			psmt.setString(4, pds.getFilename());
			
			count = psmt.executeUpdate();
			
		} catch (SQLException e) {
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
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			
			count = psmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("downloadcount fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, null);
		}
		
		return count>0?true:false;
	}
	
	public boolean detailPds(PdsDto dto) {

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

			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());

			count = psmt.executeUpdate();

		} catch (SQLException e) {
			
		} finally {
			DBClose.close(psmt, conn, null);
		}

		return count > 0 ? true : false;
	}
	
	
	
	
	public PdsDto getPDS(int seq) {

		String sql = " SELECT SEQ, ID, TITLE, CONTENT, FILENAME, DEL, READCOUNT, DOWNCOUNT, REGDATE " 
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
				int del = rs.getInt(6);
				int readcount = rs.getInt(7);
				int downcount = rs.getInt(8);
				String regdate = rs.getString(9);
				
				dto = new PdsDto(seq, id, title, content, filename, del, readcount, downcount, regdate);
			}
				
		} catch (SQLException e) {
			
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

			e.printStackTrace();
			
		} finally {
			DBClose.close(psmt, conn, rs);
		}
	}
	
	
	public boolean updatePds(int seq, String title, String content) {

		String sql = " UPDATE PDS SET "
					+ " TITLE=?, CONTENT=? "
					+ " WHERE SEQ=? ";

		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;

		try {
			conn = DBConnection.makeConnection();

			psmt = conn.prepareStatement(sql);
			psmt.setString(1, title);
			psmt.setString(2, content);
			psmt.setInt(3, seq);

			count = psmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			
			DBClose.close(psmt, conn, null);
		}

		return count > 0 ? true : false;
	}
	
	public boolean deletePds(int seq) {
		String sql = "DElETE FROM PDS "
					+ " WHERE SEQ =?";

		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;

		try {
			conn = DBConnection.makeConnection();
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);

			count = psmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}

		finally {
			DBClose.close(psmt, conn, null);
		}

		return count > 0 ? true : false;
	}
	public List<PdsDto> searchlist(int option, String str, int startnum, int endnum){
		String sql = "";
				
		str = "%"+str+"%";
				
		if(option == 1) {
			sql =" SELECT * FROM (SELECT A.* , ROWNUM RNUM FROM (SELECT * FROM pds  WHERE ID LIKE ? ORDER by seq desc) A )"
				+ " WHERE RNUM >= ? AND RNUM <= ?";
		}else {
			sql =" SELECT * FROM (SELECT A.* , ROWNUM RNUM FROM (SELECT * FROM pds WHERE TITLE LIKE ? ORDER by seq desc) A )"
					+ " WHERE RNUM >= ? AND RNUM <= ?";
		}
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<PdsDto> list = new ArrayList<>();
		
		try {
			conn = DBConnection.makeConnection();
			psmt = conn.prepareStatement(sql);
			
			psmt.setString(1, str);
			psmt.setInt(2, startnum);
			psmt.setInt(3, endnum);
			
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				PdsDto dto = new PdsDto(rs.getInt(1),
								rs.getString(2),
								rs.getString(3),
								rs.getString(4),
								rs.getString(5),
								rs.getInt(10),
								rs.getInt(7),
								rs.getInt(8),
								rs.getString(9));
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
	
	
}










