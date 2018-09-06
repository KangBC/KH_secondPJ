package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Dao.QADao;
import Dto.QADto;

public class QAController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public QAController() {
		super();
		// TODO Auto-generated constructor stub
	}

	// 공개
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}

	// 비밀
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}

	// Get, Post 구분안하고 실행됨.
	public void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	

		req.setCharacterEncoding("utf-8");
		resp.setContentType("text/html; charset=utf-8");

		QADao QAmemberDao = QADao.getInstance();
		
		PrintWriter out = resp.getWriter();

		String command = req.getParameter("command");
		
		// QAList(리스트)
				if (command.equals("list")) {
					int searchfor = Integer.parseInt(req.getParameter("searchfor"));
					String search ="";

					if(searchfor!=0) {
						search = req.getParameter("findword");
					}
					
					List<QADto> QAList = QAmemberDao.getList(searchfor,search);

					req.setAttribute("QAList", QAList);

					// 다음 view 이동
					dispatch("/JSP/QAList.jsp", req, resp);

		
		
		     /* //화면에 보여질 게시글의 개수를 지정
		      if(command.equals("list")) { 
		    	  
		      int pasgeSize = 10;
		        //현재 보여지고 있는 페이지의 넘버값을 읽어드림
		        String pageNum = req.getParameter("pageNum");
		        //null 처리
		        if (pageNum == null) {
		            pageNum = "1";
		        }
		        //전체 게시글의 갯수를 파악
		        int count = 0;
		        
		        // jsp 내에서 보여질 넘버링 숫자값을 저장하는 변수
		        int number = 0;
		        
		        //현재 보여지고 있는 페이지 문자를 숫자로 형변환
		        int currentPage = Integer.parseInt(pageNum);
		       
		        //전체 게시글의 갯수를 가져와야 하기에 데이터베이스 객체 생성
		        QADao qdao = new QADao();
		        count = qdao.getAllCount();
		       
		        //현재 보여질 페이지 시작 번호를 설정
		        int startRow = (currentPage - 1) * pasgeSize + 1;
		        int endRow = currentPage * pasgeSize;
		       
		        //최신글 10개를 기준으로 게시글을 리턴 받아주는 메소드 호출
		        Vector<QADto> v = QAmemberDao.getAllBoard(startRow, endRow);
		        number = count - (currentPage - 1) * pasgeSize;

		        ////////QNAList.jsp 쪽으로 request객체에 담아서 넘겨줌
		        req.setAttribute("v", v);
		        req.setAttribute("number", number);
		        req.setAttribute("pageSize", pasgeSize);
		        req.setAttribute("count", count);
		        req.setAttribute("currentPage", currentPage);

		        RequestDispatcher dis = req.getRequestDispatcher("QnAList.jsp");
		        dis.forward(req, resp);*/
		      
				// 추가
		      } else if (command.equals("regist_add")) {
			
		    // 로그인 후 Dto에 저장된 객체값들을 가져옴.
			String id = req.getParameter("id");
			String title = req.getParameter("title");
			String content = req.getParameter("content");

			QADto QAadd = new QADto(id, title, content);

			if (QAmemberDao.QAinsert(QAadd)) {
				dispatch("QAController?command=list&searchfor=0", req, resp);
			} else {
				dispatch("JSP/QAwrite.jsp", req, resp);
			}

			// QADetail (개인정보)
		} else if (command.equals("QADetail")) {
		

			QADto dto = new QADto();
			boolean result = QAmemberDao.QADetail(dto);
			req.setAttribute("QADetail", dto);
			dispatch("QADetail.jsp", req, resp);

			// Update(수정)
		} else if (command.equals("QAupdate")) {

			int seq = Integer.parseInt(req.getParameter("seq"));
			// Parameter에서는 int 숫자를 받을떄 형변환을 해줘야한다.
			String title = req.getParameter("title");
			String content = req.getParameter("content");

			boolean result = QAmemberDao.QABbupdate(seq, title, content);

			if (result == true) {
				System.out.println("result was true");

				out.println("<script type=\"text/javascript\">");
				out.println("alert('수정되었습니다.');");
				out.println("location = \"QAController?command=list&searchfor=0\"");
				out.println("</script>");

			} else {
				out.println("<script>alert('오류가 생겼습니다.');</script>");
			}

			// QAdelete(삭제)
		} else if (command.equals("QAdelete")) {

			int seq = Integer.parseInt(req.getParameter("seq"));
			boolean result = QAmemberDao.QAdelete(seq);

			if (result == true) {
				System.out.println("result was true");

				out.println("<script type=\"text/javascript\">");
				out.println("alert('삭제되었습니다.');");
				out.println("location = \"QAController?command=list&searchfor=0\"");
				
				out.println("</script>");

			} else {
				out.println("<script>alert('오류가 생겼습니다.');</script>");
			}

			// answer (댓글)
		} else if (command.equals("QAanswer")) {
			int seq = Integer.parseInt(req.getParameter("seq"));
			String id = req.getParameter("id");
			String title = req.getParameter("title");
			String content = req.getParameter("content");

			// id, name , address 하나라도 작성하지 않으면 작동안됨.
			if (isNull(id) || isNull(title) || isNull(content)) {
				System.out.println("모든 정보를 입력하지 않았음");

				// 다시 작성하라고 QAwrite view로 넘어감
				resp.sendRedirect("QAController?command=list&searchfor=0"); // 입력만하고 다음 view 이동할떄 사용
			}

			// 쿼리 처리 데이터 받아옴.
			QADto dto = new QADto(id, title, content);
			boolean result = QAmemberDao.QAanswer(seq, dto);
			if (!result) {
				System.out.println("추가하지 못했습니다");

				resp.sendRedirect("../QAwrite.jsp");
			}
			resp.sendRedirect("QAController?command=list&searchfor=0"); // 입력만하고 다음 view 이동할떄 사용

		}

	}

	// 이동
	public void dispatch(String urls, HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		RequestDispatcher dispatch = req.getRequestDispatcher(urls);
		dispatch.forward(req, resp);
	}

	// 껍데기
	public boolean isNull(String str) {
		return str == null || str.trim().equals("");
	}

}
