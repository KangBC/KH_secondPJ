package Controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;
import Dao.ReservDao;

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
		
		
		if(command.equals("list")) {
			System.out.println("Reserve List");
			List<String> list = dao.getCalendarList("msuh", "201808");
			
		String json ="[";
			
			for (int i = 0; i < list.size(); i++) {
				json += list.get(i);
				
				if(i < list.size()-1) {
					json += ",";
				}
			}
			json += "]";
			
			//resp.getWriter().println(json);
			
			req.setAttribute("json", json);
			
			this.dispatch("/JSP/Calendar.jsp", req, resp);
		}
		
		
	}

	public void dispatch(String urls, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		RequestDispatcher dispatch = req.getRequestDispatcher(urls);
		
		dispatch.forward(req, resp);
	}
}
