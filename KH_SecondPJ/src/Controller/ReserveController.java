package Controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.Session;

import java.util.*;
import Dao.ReserveDao;
import Dto.MemberDto;
import Dto.ReserveDto;

@SuppressWarnings("serial")
public class ReserveController extends HttpServlet{

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}
	
	public void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=utf-8");
		
		String command = req.getParameter("command");
		ReserveDao dao = ReserveDao.getInstance();
		
		PrintWriter out = resp.getWriter();
	

		HttpSession session = req.getSession();
		
		MemberDto logindto = (MemberDto)session.getAttribute("kh_member");
		
		
		if(command.equals("list")) {
			
			String month = this.formatTwo(req.getParameter("month"));
			String year = req.getParameter("year");
			
			System.out.println(year+month);
			List<String> list;
			
			if(logindto != null) {
				list = dao.getCalendarList(logindto.getId(), year+month);
			}else {
				list = dao.getCalendarList("", year+month);
			}
			
			
			
		String json ="[";
			
			for (int i = 0; i < list.size(); i++) {
				json += list.get(i);
				
				if(i < list.size()-1) {
					json += ",";
				}
			}
			json += "]";
			
	        resp.getWriter().write(json);
			
			
		}else if(command.equals("reservepage")) {

			
			this.dispatch("./JSP/Reserve.jsp", req, resp);
			
		}else if(command.equals("reserve")) {

			
			String title= req.getParameter("title");
			String date = req.getParameter("date");
			String time= req.getParameter("time");
			String content= req.getParameter("content");
			
			System.out.println(title);

			date = date.replaceAll("-", "");
			
			Calendar cal = Calendar.getInstance();
			cal.set(Calendar.YEAR, Integer.parseInt(date.substring(0, 4)));
			cal.set(Calendar.MONTH, Integer.parseInt(date.substring(4, 6))-1);
			cal.set(Calendar.DAY_OF_MONTH, Integer.parseInt(date.substring(6, 8)));
			
			System.out.println(cal.getTime());
			
			int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
			
			System.out.println(dayOfWeek);
			
			if(dayOfWeek == 1 || dayOfWeek == 7) {
				resp.sendRedirect("./JSP/ErrorPage.jsp?error=weekend");
			}else {
				
				date += time;
				content = content.replace("\r\n", "&#10;");
				
				
	
				
				boolean result1 =dao.checkpossible(date);
				
				if(result1) {
					ReserveDto tmp = new ReserveDto(logindto.getId(), title.trim(), content.trim(), date.trim());
					
					boolean result2 = dao.makeSchedule(tmp);
					
					resp.sendRedirect("./JSP/Calendar.jsp");
					
				}else {
					resp.sendRedirect("./JSP/ErrorPage.jsp?error=schedule");
				}
			}
			
		}else if(command.equals("detail")) {
			
			int seq = Integer.parseInt(req.getParameter("seq"));
			
			ReserveDto dto = dao.getSchedule(seq);
			
			req.setAttribute("dto", dto);
			
			this.dispatch("/JSP/ReserveDetail.jsp", req, resp);
			
			
		}else if(command.equals("delete")) {
			
			int seq = Integer.parseInt(req.getParameter("seq"));
			
			boolean result = dao.deleteschedule(seq);
			
			if(result) {
				out.println("<script>alert(\"성공적으로 삭제되었습니다\"); location = '/KH_SecondPJ/JSP/Calendar.jsp';</script>") ;
			}else {
				out.println("<script>alert(\"삭제중에 문제가 생겼습니다.\"); location = '/KH_SecondPJ/JSP/Calendar.jsp</script>';") ;
			}
			
		}else if(command.equals("update")) {
			
			int seq = Integer.parseInt(req.getParameter("seq"));
			
			ReserveDto dto = dao.getSchedule(seq);
			
			req.setAttribute("dto", dto);
			
			this.dispatch("/JSP/ReserveUpdate.jsp", req, resp);
			
			
			
			/*if(result) {
				out.println("<script>alert(\"성공적으로 삭제되었습니다\"); location = '/KH_SecondPJ/JSP/Calendar.jsp';</script>") ;
			}else {
				out.println("<script>alert(\"삭제중에 문제가 생겼습니다.\"); location = '/KH_SecondPJ/JSP/Calendar.jsp</script>';") ;
			}*/
			
		}else if(command.equals("mylist")) {
			
			
			
			List<ReserveDto> list = dao.mylist(logindto.getId());
			
			req.setAttribute("mylist", list);
			
			this.dispatch("/JSP/MyReserve.jsp", req, resp);
			
			
			
			/*if(result) {
				out.println("<script>alert(\"성공적으로 삭제되었습니다\"); location = '/KH_SecondPJ/JSP/Calendar.jsp';</script>") ;
			}else {
				out.println("<script>alert(\"삭제중에 문제가 생겼습니다.\"); location = '/KH_SecondPJ/JSP/Calendar.jsp</script>';") ;
			}*/
			
		}else if(command.equals("updateAF")) {
			
			int seq = Integer.parseInt(req.getParameter("seq"));
			
			String titlenew= req.getParameter("title");
			String datenew = req.getParameter("date");
			String timenew= req.getParameter("time");
			String contentnew= req.getParameter("content");
			
			datenew = datenew.replaceAll("-", "");

			
			Calendar cal = Calendar.getInstance();
			cal.set(Calendar.YEAR, Integer.parseInt(datenew.substring(0, 4)));
			cal.set(Calendar.MONTH, Integer.parseInt(datenew.substring(4, 6))-1);
			cal.set(Calendar.DAY_OF_MONTH, Integer.parseInt(datenew.substring(6, 8)));
			
			System.out.println(cal.getTime());
			
			int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
			
			System.out.println(dayOfWeek);
			
			if(dayOfWeek == 1 || dayOfWeek == 7) {
				resp.sendRedirect("./JSP/ErrorPage.jsp?error=weekend&");
			}else {

				datenew += timenew;
				contentnew = contentnew.replace("\r\n", "&#10;");
				
				boolean result1 =dao.checkpossible(datenew);
				
				if(result1) {
					ReserveDto tmp = new ReserveDto(logindto.getId(), titlenew.trim(), contentnew.trim(), datenew.trim());
					
					boolean result2 = dao.updateschedule(seq, new ReserveDto("msuh", titlenew, contentnew, datenew));
					
					if(result2) {
						out.println("<script>alert(\"성공적으로 예약이 변경되었습니다\"); location = '/KH_SecondPJ/JSP/Calendar.jsp';</script>") ;
					}else {
						out.println("<script>alert(\"예약 변경중에 문제가 생겼습니다.\"); location = '/KH_SecondPJ/JSP/Calendar.jsp</script>';") ;
					}
					
				}else {
					resp.sendRedirect("./JSP/ErrorPage.jsp?error=schedule");
				}
				
				
				
			}
			
		}
		
		
	}

	public void dispatch(String urls, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		RequestDispatcher dispatch = req.getRequestDispatcher(urls);
		
		dispatch.forward(req, resp);
	}
	
	public String formatTwo(String month) {
		if(month.length()== 1) {
			month = "0"+month;
		}
		return month;
	}
}
