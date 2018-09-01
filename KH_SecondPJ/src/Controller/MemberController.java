package Controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Dao.MemberDao;
import Dto.MemberDto;

public class MemberController extends HttpServlet{

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}
	
	public void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		resp.setContentType("text/html; charset=utf-8");
		
		MemberDao memberDao = MemberDao.getInstance();
		
		String command = req.getParameter("command");
		
		if(command.equals("login")) {
			String id = req.getParameter("id");
			String pw = req.getParameter("pw");
			
			MemberDto member = memberDao.Login(id, pw);
			
			HttpSession session = req.getSession(true);
			session.setAttribute("member", member);
			session.setMaxInactiveInterval(30*60);
			
			dispatch("JSP/About.jsp", req, resp);
		}else if(command.equals("regist_submit")) {
			String id = req.getParameter("id");
			String pw = req.getParameter("pw");
			String name = req.getParameter("name");
			String partner = req.getParameter("partner");
			String phone = req.getParameter("phone");
			String email = req.getParameter("email");
			
			MemberDto member = new MemberDto(id,pw,name,partner,phone,email);

			if(memberDao.addMember(member)) {
				resp.sendRedirect("JSP/Login.jsp");
			}else {
				resp.sendRedirect("JSP/Regi.jsp");
			}
			
		}else if(command.equals("")) {
			
		}
	}

	public void dispatch(String urls, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		RequestDispatcher dispatch = req.getRequestDispatcher(urls);
		
		dispatch.forward(req, resp);
	}
}
