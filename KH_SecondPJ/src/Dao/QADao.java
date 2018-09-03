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

	// Main리스트
	public List<QADto> getList() {

		String sql = " SELECT * " + " FROM BBS " + " ORDER BY REF DESC, STEP ASC ";

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

			while (rs.next()) {

				QADto dto = new QADto(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getInt(4), rs.getInt(5),
						rs.getString(6), rs.getString(7), rs.getString(8), rs.getInt(9), rs.getInt(10), rs.getInt(11));

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

		// SEQ_BBS.CURRVAL REF 값 표현하는 다른 방법

		Connection conn = null;
		PreparedStatement psmt = null;

		int count = 0;

		try {
			conn = DBConnection.makeConnection();
			psmt = conn.prepareStatement(sql);

			System.out.println("1/6 QAinsert success");

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

		return count > 0 ? true : false;
	}

	// Detail
	public boolean QADetail(QADto dto) {

		String sql = " INSERT INTO BBS (SEQ, ID, REF, STEP, DEPTH, TITLE, CONTENT, WDATE, PARENT, DEL, READCOUNT) "
				+ " VALUES (SEQ_BBS.NEXTVAL, ?, SEQ_BBS.CURRVAL, 0, 0, ?, ?, SYSDATE, 0, 0, 0) ";

		// SEQ_BBS.CURRVAL REF 값 표현하는 다른 방법

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
			System.out.println("writeBBS fail");
		} finally {
			DBClose.close(psmt, conn, null);
		}

		System.out.println("sql : " + sql);

		return count > 0 ? true : false;
	}

	// 순서
	public QADto getBbs(int seq) {
		String sql = " SELECT SEQ, ID, REF, STEP, DEPTH, TITLE, CONTENT, WDATE, PARENT, DEL, READCOUNT " + " FROM BBS "
				+ " WHERE SEQ=? ";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		QADto dto = null;

		try {
			conn = DBConnection.makeConnection();
			psmt = conn.prepareStatement(sql);

			psmt.setInt(1, seq);
			rs = psmt.executeQuery();

			while (rs.next()) {
				seq = rs.getInt(1);
				String id = rs.getString(2);
				int ref = rs.getInt(3);
				int step = rs.getInt(4);
				int depth = rs.getInt(5);
				String title = rs.getString(6);
				String content = rs.getString(7);
				String wdate = rs.getString(8);
				int parent = rs.getInt(9);
				int del = rs.getInt(10);
				int readcount = rs.getInt(11);

				dto = new QADto(seq, id, ref, step, depth, title, content, wdate, parent, del, readcount);
			}

		} catch (SQLException e) {
			System.out.println("getBbs failed");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return dto;
	}

	// 조회수
	public void QAreadcount(int seq) {

		String sql = " UPDATE BBS " + " SET READCOUNT=READCOUNT+1 " + " WHERE SEQ=? ";

		Connection conn = null;
		PreparedStatement psmt = null;

		try {
			conn = DBConnection.makeConnection();
			System.out.println("1/6 readcount success");

			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/6 readcount success");

			psmt.executeUpdate();
			System.out.println("3/6 readcount success");

		} catch (SQLException e) {
			System.out.println("readcount fail");
		} finally {
			DBClose.close(psmt, conn, null);
			System.out.println("4/6 readcount success");
		}
	}

	// 업데이트 (수정)
	public boolean QABbupdate(int seq, String title, String content) {

		String sql = " UPDATE BBS SET " + " TITLE=?, CONTENT=? " + " WHERE SEQ=? ";

		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		System.out.println("-------------"+content);
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

	// 삭제한 글을 DB에서 처리하기 위한 메서드
	public boolean QAdelete(int seq) {
		String sql = "UPDATE BBS SET DEL = 1 WHERE SEQ =?";

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

	// answer(댓글)
	public boolean QAanswer(int seq, QADto bbs) {

		// 밀어주는 작업
		String sql1 = " UPDATE BBS " + " SET STEP=STEP+1 " + " WHERE REF=(SELECT REF FROM BBS WHERE SEQ=?) "
				+ "  		AND STEP> (SELECT STEP FROM BBS WHERE SEQ=?) ";

		/*
		 * REF STEP DEPTH 3 0 0 3 1 1 3 2 1
		 */

		// 집어넣는 작업 (INSERT)
		String sql2 = " INSERT INTO BBS " + " (SEQ, ID, REF, STEP, DEPTH, "
				+ " TITLE, CONTENT, WDATE, PARENT, DEL, READCOUNT) " + " VALUES(SEQ_BBS.NEXTVAL, ?, "
				+ " 				(SELECT REF FROM BBS WHERE SEQ=?), "
				+ " 				(SELECT STEP FROM BBS WHERE SEQ=?)+1, "
				+ " 				(SELECT DEPTH FROM BBS WHERE SEQ=?)+1, "
				+ " 				?, ?, SYSDATE, ?, 0, 0) ";

		Connection conn = null;
		PreparedStatement psmt = null;

		int count = 0;

		try {
			conn = DBConnection.makeConnection();
			conn.setAutoCommit(false);
			System.out.println("1/6 answer success");

			psmt = conn.prepareStatement(sql1); // update
			psmt.setInt(1, seq);
			psmt.setInt(2, seq);
			System.out.println("2/6 answer success");

			count = psmt.executeUpdate();
			System.out.println("3/6 answer success");

			psmt.clearParameters(); // 쿼리문 두개 이상 썼을때 클리어

			psmt = conn.prepareStatement(sql2);
			psmt.setString(1, bbs.getId());

			psmt.setInt(2, seq); // ref
			psmt.setInt(3, seq); // step
			psmt.setInt(4, seq); // depth

			psmt.setString(5, bbs.getTitle()); // title
			psmt.setString(6, bbs.getContent()); // content
			psmt.setInt(7, seq); // parent
			System.out.println("4/6 answer success");

			count = psmt.executeUpdate();
			conn.commit();
			System.out.println("5/6 answer success");

		} catch (SQLException e) {
			System.out.println("answer fail");
		} finally {
			try {
				conn.setAutoCommit(true);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			DBClose.close(psmt, conn, null);
			System.out.println("6/6 answer success");
		}

		return count > 0 ? true : false;
	}

	// 검색
	public List<QADto> getBbsFindList(String findStr) {

		String sWord = "%" + findStr + "%";

		String sql = " SELECT SEQ, ID, REF, STEP, DEPTH, " + " TITLE, CONTENT, " + " WDATE, PARENT, "
				+ " DEL, READCOUNT " + " FROM BBS " + " WHERE TITLE LIKE ? " + " ORDER BY REF DESC, STEP ASC ";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		List<QADto> list = new ArrayList<QADto>();

		try {
			conn = DBConnection.makeConnection();
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, sWord);
			System.out.println("1/6 getBbsList success");

			rs = psmt.executeQuery();
			System.out.println("2/6 getBbsList success");

			while (rs.next()) {
				int i = 1;

				QADto dto = new QADto(rs.getInt(i++), rs.getString(i++), rs.getInt(i++), rs.getInt(i++), rs.getInt(i++),
						rs.getString(i++), rs.getString(i++), rs.getString(i++), rs.getInt(i++), rs.getInt(i++),
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
