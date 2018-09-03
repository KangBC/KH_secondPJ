package Controller;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.Month;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;
import Dao.ReservDao;
import Dto.ReservDto;

public class ReservController extends HttpServlet{

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}
	
	public void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String command = req.getParameter("command");
		ReservDao dao = ReservDao.getInstance();
		
		String tempid = "msuh";
		
		
		if(command.equals("list")) {
			
			String month = this.formatTwo(req.getParameter("month"));
			String year = req.getParameter("year");

			/*LocalDateTime now = LocalDateTime.now();
			String month = this.formatTwo(now.getMonth().getValue() +"");
			String year = now.getYear()+"";*/
			
			System.out.println(year+month);
			
			
			List<String> list = dao.getCalendarList(tempid, year+month);
			
		String json ="[";
			
			for (int i = 0; i < list.size(); i++) {
				json += list.get(i);
				
				if(i < list.size()-1) {
					json += ",";
				}
			}
			json += "]";
			
			resp.setContentType("text/html;charset=UTF-8");
	        resp.getWriter().write(json);
			
			
		}else if(command.equals("reservepage")) {
			
			this.dispatch("./JSP/Reserve.jsp", req, resp);
			
		}else if(command.equals("reserve")) {
			String title= req.getParameter("title");
			String date = req.getParameter("date");
			String time= req.getParameter("time");
			String content= req.getParameter("content");
			
			
			
			date = date.replaceAll("-", "");
			date += time;
			content = content.replace("\r\n", "&#10;");
			
			System.out.println(title);
			System.out.println(date);
			System.out.println(content);
			
			boolean result1 =dao.checkpossible(date);
			
			if(result1) {
				ReservDto tmp = new ReservDto("msuh", title.trim(), content.trim(), date.trim());
				
				boolean result2 = dao.makeSchedule(tmp);
				
				resp.sendRedirect("./JSP/Calendar.jsp");
				
			}else {
				resp.sendRedirect("./JSP/ErrorPage.jsp?error=schedule");
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
