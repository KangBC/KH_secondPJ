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
		DBConnection.initConnect();
	}
	
	public static QADao getInstance() {
		return bbsQAdao;
	}
	
		//리스트
		public List<QADto> getList() {
			
			String sql = " SELECT * "
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

					
			QADto dto = new QADto (rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getInt(4), rs.getInt(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getInt(9), rs.getInt(10), rs.getInt(11));
				
			list.add(dto);
				}
				System.out.println("3/6 getBbsList success");
				
			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println("getBbsList fail");
			} finally {
				DBClose.close(psmt, conn, rs);
			}
			return list;
		}
		
		// ADD(추가)
		public boolean QAinsert(QADto dto) {
			
			String sql = " INSERT INTO BBS (SEQ, ID, REF, STEP, DEPTH, TITLE, CONTENT, WDATE, PARENT, DEL, READCOUNT) "
							+ " VALUES (SEQ_BBS.NEXTVAL, ?, SEQ_BBS.CURRVAL, 0, 0, ?, ?, SYSDATE, 0, 0, 0) ";
			
			// SEQ_BBS.CURRVAL			REF 값 표현하는 다른 방법
			
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
				e.printStackTrace();
				System.out.println("writeBBS fail");
			} finally {
				DBClose.close(psmt, conn, null);
			}
			
			System.out.println("sql : " + sql);
			
			return count>0?true:false;
		}



	}

