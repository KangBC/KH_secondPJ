package Controller;

import java.io.IOException;
import java.io.PrintWriter;

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
			
			if(member != null) {
				HttpSession session = req.getSession(true);
				session.setAttribute("kh_member", member);
				session.setMaxInactiveInterval(30*60);
				
				dispatch("JSP/About.jsp", req, resp);
			}else {
				req.setAttribute("login_false", true);
				dispatch("JSP/Login.jsp", req, resp);
			}
		}else if(command.equals("logout")) {

			HttpSession session = req.getSession(false);

			if(session!=null) {
				session.invalidate();
			}
			
		}else if(command.equals("regist_submit")) {
			String id = req.getParameter("id");
			String pw = req.getParameter("pw");
			String name = req.getParameter("name");
			String partner = req.getParameter("partner");
			String phone = req.getParameter("phone");
			String email = req.getParameter("email");
			
			MemberDto member = new MemberDto(id,pw,name,partner,phone,email);

			if(memberDao.addMember(member)) {
				PrintWriter writer = resp.getWriter();
				writer.write("<script>alert(\"성공적으로 회원가입 되었습니다.\"); location.href=\"JSP/Login.jsp\"; </script>");
				writer.flush();
				writer.close();
			}else {
				PrintWriter writer = resp.getWriter();
				writer.write("<script>alert(\"회원가입에 실패했습니다.\"); location.href=\"JSP/Regi.jsp\"; </script>");
				writer.flush();
				
				writer.close();
			}
			
		}else if(command.equals("idCheck")){
			String id = req.getParameter("id");

			boolean b = memberDao.idCheck(id);
			System.out.println(b);
			
			StringBuffer msg = new StringBuffer();
			msg.append("{");
			msg.append(" \"status\" : \"success\", "); 
			msg.append(" \"duplicated\" : " + b); 
			msg.append(" } ");

			PrintWriter writer = resp.getWriter();
			writer.write(msg.toString());
			writer.flush();
			writer.close();

		}else if(command.equals("updateInfo")) {
			String id = req.getParameter("id");
			String name = req.getParameter("name");
			String partner = req.getParameter("partner");
			String phone = req.getParameter("phone");
			String email = req.getParameter("email");

			MemberDto member = new MemberDto(id,name,partner,phone,email);
			
			if(memberDao.update(member)) {
				System.out.println("성공");
			}else {
				System.out.println("실패");
			}
		}
	}

	public void dispatch(String urls, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		RequestDispatcher dispatch = req.getRequestDispatcher(urls);
		
		dispatch.forward(req, resp);
	}
}
