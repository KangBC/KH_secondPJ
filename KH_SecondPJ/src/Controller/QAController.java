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

public class QAController extends HttpServlet{
	
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
	
	//QAList 
	if(command.equals("list")) {
		
		List<QADto> QAList = dao.getList();
		
		req.setAttribute("QAList", QAList);
		
		dispatch("QAList.jsp", req, resp);
		
	
		
		
	}
		
		
	}
	
	//이동
	public void dispatch(String urls, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		RequestDispatcher dispatch = req.getRequestDispatcher(urls);
		dispatch.forward(req, resp);
	}
	
	public boolean isNull(String str){
		return str == null || str.trim().equals("");	
	}	

}
