package Controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Dao.PdsDao;

public class PdsController extends HttpServlet {

	

	private static final int BUFFER_SIZE = 8192;			
	private ServletConfig mConfig = null;
	
	
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		super.init(config);
		
		mConfig = config;
	}
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	
	}
	

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}
	
	public void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		
		System.out.println("FileDownloader doget");
		
		String filename = new String(req.getParameter("filename").getBytes("8859_1"), "KSC5601");
		System.out.println("filename : " + filename);
		
		String pdsSeq = req.getParameter("seq");
		int seq = Integer.parseInt(pdsSeq.trim());
		
		/*
		iPdsDao dao = PdsDao.getInstance();
		boolean isS = dao.downloadcount(seq);
		if(!isS) {
			resp.sendRedirect("pdslist.jsp");
		}*/
		
		BufferedOutputStream out = new BufferedOutputStream(resp.getOutputStream());
		String filePath ="";
		
		if(pdsSeq != null) {
			
	
			// 개인 폴더
			filePath = "E:\\tmp";
		}
		
		try {
			
		
			filePath = filePath + "\\" + filename;
			
			File f = new File(filePath);
			System.out.println("filePath : " + filePath);
			
			if(f.exists() && f.canRead()) {
				
				// 다운 로드 window 설정(다운로드창)
				resp.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\";");
				resp.setHeader("Content-Transfer-Encoding", "binary;");
				resp.setHeader("Content-Length", "" + f.length());
				resp.setHeader("Pragma", "no-cache;"); 
				resp.setHeader("Expires", "-1;");
				
				BufferedInputStream fileInput = new BufferedInputStream(new FileInputStream(f));
				byte buffer[] = new byte[BUFFER_SIZE];
				
				int read = 0;
				
				while ((read = fileInput.read(buffer)) != -1) {
					out.write(buffer, 0, read);
				}
				
				fileInput.close();
				out.flush();
			}
			else {
				System.out.println("파일이 존재하지 않습니다");
			}
			
		} catch (Exception e) {
		} finally {
			
			if(out != null) {
				out.flush();
				out.close();
			}
		}
	}
	
	
	public void dispatch(String urls, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		RequestDispatcher dispatch = req.getRequestDispatcher(urls);
		dispatch.forward(req, resp);
	}
}
