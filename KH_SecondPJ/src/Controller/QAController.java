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

		String command = req.getParameter("command");

		QADao dao = new QADao();
		PrintWriter out = resp.getWriter();

		// QAList(리스트)
		if (command.equals("list")) {

			List<QADto> QAList = dao.getList();

			System.out.println(QAList.size());

			req.setAttribute("QAList", QAList);

			// 다음 view 이동
			dispatch("/JSP/QAList.jsp", req, resp);
			// dispatch("CustUserControl?command=list", req, resp);

			// QA add (추가)
		} else if (command.equals("add")) {
			// 로그인 후 Dto에 저장된 객체값들을 가져옴.
			String id = req.getParameter("id");
			String title = req.getParameter("title");
			String content = req.getParameter("content");

			// 오류 확인용
			System.out.println("id = " + id);
			System.out.println("title = " + title);
			System.out.println("content = " + content);

			// id, name , address 하나라도 작성하지 않으면 작동안됨.
			if (isNull(id) || isNull(title) || isNull(content)) {
				System.out.println("모든 정보를 입력하지 않았음");
				
				//다시 작성하라고 QAwrite view로 넘어감
				resp.sendRedirect("QAwrite.jsp");
			}
			
			//쿼리 처리 데이터 받아옴.
			
			QADto dto = new QADto("id", title, content);
			boolean result = dao.QAinsert(dto);
			if (!result) {
				System.out.println("추가하지 못했습니다");
				// QAwrite 다시 작성
				resp.sendRedirect("QAwrite.jsp");
			}
			//추가 되면 List로 넘어감
			resp.sendRedirect("QAController?command=list"); // 입력만하고 다음 view 이동할떄 사용
			//dispatch("QAController?command=list", req, resp); //객체값을 가지고 다름 view 넘어갈떄

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
