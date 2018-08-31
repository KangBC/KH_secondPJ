package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import DB.DBClose;
import DB.DBConnection;
import Dto.QADto;

public class QADao {
	
	private static QADao bbsQAdao = new QADao();

	public QADao() {
	}
	
	public static QADao getInstance() {
		return bbsQAdao;
	}
	
		//리스트
		public List<QADto> getList() {
			
			String sql = " SELECT SEQ, ID, REF, STEP, DEPTH, "
					+ " TITLE, CONTENT, "
					+ " WDATE, PARENT, "
					+ " DEL, READCOUNT "
					+ " FROM BBS "
					+ " ORDER BY REF DESC, STEP ASC ";
			
			Connection conn = null;			
			PreparedStatement psmt = null;	
			ResultSet rs = null;
			
			List<QADto> list = new ArrayList<QADto>();
			
			try {
				conn = DBConnection.makeConnection();
				psmt = conn.prepareStatement(sql);
				
				System.out.println("1/6 getBbsList success");
				
				rs = psmt.executeQuery();
				System.out.println("2/6 getBbsList success");
				
				while(rs.next()) {
					int i = 1;
					
			QADto dto = new QADto (rs.getInt(i++),
					rs.getString(i++), //임시 아이디
					rs.getString(i++), //임시 이름
					rs.getString(i++), //임시 주소
					rs.getInt(i++), 
					rs.getInt(i++),
					rs.getInt(i++),
					rs.getString(i++), 
					rs.getString(i++), 
					rs.getString(i++), 
					rs.getInt(i++),
					rs.getInt(i++),
					rs.getInt(i++));
				
			list.add(dto);
				}
				System.out.println("3/6 getBbsList success");
				
			} catch (SQLException e) {
				System.out.println("getBbsList fail");
			} finally {
				DBClose.close(psmt, conn, rs);
			}
			return list;
		}


	}

