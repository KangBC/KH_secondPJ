package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import DB.DBClose;
import DB.DBConnection;
import Dto.QADto;
import Dto.ReplyDto;

public class QADao {

	private static QADao bbsQAdao = new QADao();

	public QADao() {
		DBConnection.initConnect();
	}

	public static QADao getInstance() {
		return bbsQAdao;
	}
	
	// list page
		public int getAllCount(int searchfor,String search) {
			String sql ="";
			
			int count = 0;

			if (searchfor == 0) {
				 sql = " SELECT COUNT(*) " + " FROM BBS " + "WHERE DEL=0 ";
			} else if (searchfor == 1) {
				 sql = " SELECT COUNT(*) " + " FROM BBS " + " WHERE ID LIKE '%"+search+"%' AND DEL=0 ";
			} else if (searchfor == 2) {
				 sql = " SELECT COUNT(*) " + " FROM BBS " + " WHERE TITLE LIKE '%"+search+"%' AND DEL=0 ";
			} else if (searchfor == 3) {
				 sql = " SELECT COUNT(*) " + " FROM BBS " + " WHERE CONTENT LIKE '%"+search+"%' AND DEL=0 ";
			}
			
			Connection conn = null;
			PreparedStatement psmt = null;
			ResultSet rs = null;

			try {
				// 쿼리 준비
				conn = DBConnection.makeConnection();
				psmt = conn.prepareStatement(sql);

				// 쿼리 실행 후 결과 리턴
				rs = psmt.executeQuery();
				if (rs.next()) { // 데이터가 있다면
					count = rs.getInt(1);

				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return count;
		}
		
		 // 모든 (화면에 보여질 데이터를 10기씩 추출해서 리턴하는 메소드)
		public List<QADto> getQAList(int startnum, int endnum, int option, String str){
			str = "%"+str+"%";
			
			String sql = "";
			if(option == 0) {
				sql  ="SELECT * FROM (SELECT A.* , ROWNUM RNUM FROM (SELECT * FROM BBS WHERE DEL=0 ORDER by REF DESC,STEP ASC ) A ) "
		                + " WHERE RNUM >= ? AND RNUM <= ?";
			}else if(option == 1) {
				sql  ="SELECT * FROM (SELECT A.* , ROWNUM RNUM FROM (SELECT * FROM BBS WHERE DEL=0 AND ID LIKE ? ORDER by REF DESC,STEP ASC ) A ) "
		                + " WHERE RNUM >= ? AND RNUM <= ? ";
			}else if(option == 2) {
				sql  ="SELECT * FROM (SELECT A.* , ROWNUM RNUM FROM (SELECT * FROM BBS WHERE DEL=0 AND TITLE LIKE ? ORDER by REF DESC,STEP ASC ) A ) "
		                + " WHERE RNUM >= ? AND RNUM <= ? ";
			}else if(option == 3) {
				sql  ="SELECT * FROM (SELECT A.* , ROWNUM RNUM FROM (SELECT * FROM BBS WHERE DEL=0 AND CONTENT LIKE ? ORDER by REF DESC,STEP ASC ) A ) "
		                + " WHERE RNUM >= ? AND RNUM <= ?";
			}
		      
		      Connection conn = null;
		      PreparedStatement psmt = null;
		      ResultSet rs = null;
		      System.out.println(startnum);
		      
		      List<QADto> list = new ArrayList<>();
		      
		      try {
		         conn = DBConnection.makeConnection();
		         psmt = conn.prepareStatement(sql);
		         
		         
		         if(option == 0) {
		        	 psmt.setInt(1, startnum);
			         psmt.setInt(2, endnum);
		        	 
		         }else {
		        	 psmt.setString(1, str);
		        	 psmt.setInt(2, startnum);
			         psmt.setInt(3, endnum);
		         }
		         
		         
		         rs = psmt.executeQuery();
		         
		         while(rs.next()) {
		        	 QADto dto = new QADto(
		        			  rs.getInt(1), 
		        			  rs.getString(2), 
		        			  rs.getInt(3), 
		        			  rs.getInt(4), 
		        			  rs.getInt(5),
		        	          rs.getString(6), 
		        	          rs.getString(7), 
		        	          rs.getString(8).substring(0, 16), 
		        	          rs.getInt(9), 
		        	          rs.getInt(10),
		        	          rs.getInt(11));
		        	 dto.setRownum(rs.getInt(12));
		         
		        	 list.add(dto);   
		         }
		         
		      } catch (SQLException e) {
		         e.printStackTrace();
		      } finally {
		         DBClose.close(psmt, conn, rs);
		      }
		      return list;
		   }
		
		/*
		 // 전체 글의 갯수를 리턴하는 메소드
	    public int getAllCount() {
	        getCon();
	        int count = 0;
	        System.out.println("2/6 QnA_List Success");
	        try {
	            //쿼리 준비
	            String sql = "SELECT COUNT(*) FROM QNABBS";
	            psmt = conn.prepareStatement(sql);
	            System.out.println("3/6 QnA_List Success");
	            //쿼리 실행 후 결과 리턴
	            rs = psmt.executeQuery();
	            if (rs.next()) { //데이터가 있다면
	                count = rs.getInt(1);
	                System.out.println("4/6 QnA_List Success");
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return count;
	    }

	    //모든 (화면에 보여질 데이터를 10기씩 추출해서 리턴하는 메소드
	    public Vector<QADto> getAllBoard(int startRow, int endRow) {
	        int a = 0;
	        Vector<QnABbsVo> v = new Vector<>();
	        getCon();
	        System.out.println("2/6 QnA_AllBoard Success");
	        try {
	            //쿼리작성
	            String sql = "SELECT * FROM (SELECT A.* ,ROWNUM RNUM FROM (SELECT * FROM QNABBS ORDER BY REF DESC ,RE_STEP ASC)A) "
	                    + " WHERE RNUM >= ? AND RNUM <= ?";
	            //쿼리 실행할 객체 선언
	            psmt = conn.prepareStatement(sql);
	            // ? 값을 입력
	            psmt.setInt(1, startRow);
	            psmt.setInt(2, endRow);

	            rs = psmt.executeQuery();
	        System.out.println("3/6 QnA_AllBoard Success");
	             while (rs.next()) {
	                System.out.println("while");
	                //데이터를 패키징( 가방 = helpBBSVo) 해줌
	                QnABbsVo qdto = new QnABbsVo();

	                 qdto.setNum(rs.getInt(1));
	                 qdto.setWriter(rs.getString(2));
	                 qdto.setSubject(rs.getString(3));
	                 qdto.setPassword(rs.getString(4));
	                 qdto.setReg_date(rs.getString(5));
	                 qdto.setRef(rs.getInt(6));
	                 qdto.setRe_step(rs.getInt(7));
	                 qdto.setRe_depth(rs.getInt(8));
	                 qdto.setReadcount(rs.getInt(9));
	                 qdto.setContent(rs.getString(10));
	                 qdto.setDel(rs.getInt(11));
	                //패키징 데이터를 벡터에 저장
	                v.add(qdto);
	                System.out.println("4/6 QnA_AllBoard Success");
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }finally {
	            DBClose.close(psmt,conn,rs);

	        }
	        return v;
	    }
		
		 */

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
		System.out.println("-------------" + content);
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
	
	public List<ReplyDto> getreplist(int seq){
		
		String sql = "SELECT * FROM REP WHERE REF=? ORDER BY STEP ASC";
		

	      Connection conn = null;
	      PreparedStatement psmt = null;
	      ResultSet rs = null;
	      
	      List<ReplyDto> list = new ArrayList<>();
	      
	      try {
	         conn = DBConnection.makeConnection();
	         psmt = conn.prepareStatement(sql);
	         
	         psmt.setInt(1, seq);
	         
	         rs = psmt.executeQuery();
	         
	         while(rs.next()) {
	        	 ReplyDto dto = new ReplyDto(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getInt(4), rs.getInt(5), rs.getInt(6), rs.getString(7), rs.getString(8).substring(0, 16), rs.getInt(9));
	         
	        	 list.add(dto);   
	         }
	         
	      } catch (SQLException e) {
	         e.printStackTrace();
	      } finally {
	         DBClose.close(psmt, conn, rs);
	      }

		return list;
	}
	public ReplyDto getreply(int seq) {
		String sql = " SELECT * " + " FROM REP "
				+ " WHERE SEQ=? ";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		ReplyDto dto = null;
		try {
			conn = DBConnection.makeConnection();
			psmt = conn.prepareStatement(sql);

			psmt.setInt(1, seq);
			rs = psmt.executeQuery();

			while (rs.next()) {
				dto = new ReplyDto(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getInt(4), rs.getInt(5), rs.getInt(6), rs.getString(8), rs.getString(9), rs.getInt(10));
			}

		} catch (SQLException e) {
			System.out.println("getBbs failed");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return dto;
	}
	
	
	public boolean reply(ReplyDto dto) {
		// 밀어주는 작업
		
				String sql1 = "UPDATE BBS SET STEP=STEP+1 WHERE SEQ=?";
				
				String sql = " UPDATE REP " + " SET STEP=STEP+1 " + " WHERE REF=?"
						+ "  		AND STEP> (SELECT STEP FROM REP WHERE SEQ=?) ";


				// 집어넣는 작업 (INSERT)
				String sql2 = " INSERT INTO REP VALUES(SEQ_REP.NEXTVAL, ?, "
				+ " 				?, "
				+ " 				(SELECT STEP FROM REP WHERE SEQ=?)+1, "
				+ " 				(SELECT DEPTH FROM REP WHERE SEQ=?)+1, "
				+ " 				?, ?, SYSDATE, 0) ";
				
				
				String sql3 =  " UPDATE REP " + " SET STEP=STEP+1 " + " WHERE REF=?";
				
				String sql4 =  " INSERT INTO REP VALUES(SEQ_REP.NEXTVAL, ?, "
						+ " 				?, "
						+ " 				0, "
						+ " 				0, "
						+ " 				0, ?, SYSDATE, 0) ";
				
				
				Connection conn = null;
				PreparedStatement psmt = null;
				

				int count = 0;

				try {
					//seq; id; ref;step;depth;parent;content; wdate;del;
					conn = DBConnection.makeConnection();
					
					psmt = conn.prepareStatement(sql1);
					psmt.setInt(1, dto.getRef());
					
					psmt.executeQuery();
					psmt.clearParameters(); // 쿼리문 두개 이상 썼을때 클리어
					System.out.println(dto.getParent());
					
					if(dto.getParent() != 0) {
						psmt = conn.prepareStatement(sql);
						psmt.setInt(1, dto.getRef());
						psmt.setInt(2, dto.getParent());
						psmt.executeQuery();
						psmt.clearParameters(); // 쿼리문 두개 이상 썼을때 클리어
						psmt = conn.prepareStatement(sql2);
						psmt.setString(1, dto.getId());

						psmt.setInt(2, dto.getRef()); // ref
						psmt.setInt(3, dto.getParent()); // step
						psmt.setInt(4, dto.getParent()); // depth

						psmt.setInt(5, dto.getParent()); // parent
						psmt.setString(6, dto.getContent().trim());  //content
						System.out.println("4/6 answer success");

						count = psmt.executeUpdate();
						System.out.println("5/6 answer success");
					}else {
						psmt = conn.prepareStatement(sql3);
						psmt.setInt(1, dto.getRef());
						
						psmt.executeQuery();
						
						psmt = conn.prepareStatement(sql4);
						psmt.setString(1, dto.getId());
						psmt.setInt(2, dto.getRef());
						psmt.setString(3, dto.getContent());
						
						count = psmt.executeUpdate();
					}

				} catch (SQLException e) {
					e.printStackTrace();
				} finally {
			DBClose.close(psmt, conn, null);
					System.out.println("6/6 answer success");
				}

				return count > 0 ? true : false;
		
		
	}
	
	public boolean repdelete(int seq, int ref) {
		
		//원글 댓글수
				//String sql1 = "UPDATE BBS SET STEP=STEP-1 WHERE SEQ=?";
				
				//스텝 원상복귀
				/*String sql = " UPDATE REP " + " SET STEP=STEP-1 " + " WHERE REF=?"
						+ "  		AND STEP> (SELECT STEP FROM REP WHERE SEQ=?) ";*/


				// 집어넣는 작업 (INSERT)
				String sql2 = " UPDATE REP SET DEL=1 WHERE SEQ=? ";
				
				
				Connection conn = null;
				PreparedStatement psmt = null;


				int count = 0;

				try {
					//seq; id; ref;step;depth;parent;content; wdate;del;
					conn = DBConnection.makeConnection();
					
					/*psmt = conn.prepareStatement(sql2);
					psmt.setInt(1, ref);
					psmt.executeQuery();
					psmt.clearParameters(); // 쿼리문 두개 이상 썼을때 클리어
					
					psmt = conn.prepareStatement(sql);
					psmt.setInt(1, ref);
					psmt.setInt(2, seq);
					psmt.executeQuery();
					psmt.clearParameters(); // 쿼리문 두개 이상 썼을때 클리어
*/					
					psmt = conn.prepareStatement(sql2);
					psmt.setInt(1, seq);
					count = psmt.executeUpdate();

				} catch (SQLException e) {
					e.printStackTrace();
				} finally {
			DBClose.close(psmt, conn, null);
					System.out.println("6/6 answer success");
				}

				return count > 0 ? true : false;
		
		
	}
	public boolean repupdate(int seq, String content) {
		
		//원글 댓글수
				String sql1 = "UPDATE REP SET CONTENT=?, WDATE=SYSDATE WHERE SEQ=?";
				
				
				
				
				Connection conn = null;
				PreparedStatement psmt = null;


				int count = 0;

				try {
					//seq; id; ref;step;depth;parent;content; wdate;del;
					conn = DBConnection.makeConnection();
					
					psmt = conn.prepareStatement(sql1);
					psmt.setString(1, content);
					psmt.setInt(2, seq);
					count = psmt.executeUpdate();
					

				} catch (SQLException e) {
					e.printStackTrace();
				} finally {
			DBClose.close(psmt, conn, null);
					System.out.println("6/6 answer success");
				}

				return count > 0 ? true : false;
		
		
	}
}
