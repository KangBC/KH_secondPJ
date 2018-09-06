package Controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Dao.PdsDao;
import Dto.PdsDto;

public class PdsController extends HttpServlet {

	

	private static final int BUFFER_SIZE = 8192;			
	private ServletConfig mConfig = null;
	private int seq;
	
	
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
		
		
	
		req.setCharacterEncoding("utf-8");
		resp.setContentType("text/html; charset=utf-8");

		String command = req.getParameter("command");
		
		PdsDao pdao = PdsDao.getInstance();
		
		
		
		if(command.equals("list")) {
			
			
			System.out.println("process 실행");
			
			List<PdsDto> pdslist = pdao.getPdsList();
			
			req.setAttribute("pdslist", pdslist);
			
			dispatch("/JSP/PdsList.jsp", req, resp);
			
		}
		else if(command.equals("write")) {
			
			String id = req.getParameter("id");
			String title = req.getParameter("title");
			String content = req.getParameter("content");
			String filename = req.getParameter("filename");
			
			System.out.println(id);
			System.out.println(title);
			System.out.println(content);
			System.out.println(filename);
			
			PdsDto pdto = new PdsDto(id, title, content, filename);
			
			if(pdao.writePds(pdto)) {
				dispatch("JSP/PdsList.jsp", req, resp);
			}else {
				dispatch("JSP/Pdswrite.jsp", req, resp);
			}
		}
		else if(command.equals("detail")) {
			String id = req.getParameter("id");
			
			PdsDto pdto = new PdsDto();
			
			boolean result = pdao.detailPds(pdto);
			req.setAttribute("detail", pdto);
			dispatch("Pdsdetail.jsp", req, resp);
			
		}
		else if(command.equals("update")) {
			int seq = Integer.parseInt(req.getParameter("seq"));
			String title = req.getParameter("title");
			String content = req.getParameter("content");
			
			boolean result = pdao.updatePds(seq, title, content);
			
			if(result == true) {
				System.out.println("수정되었습니다.");
			}
			else {
				System.out.println("수정 실패.");
			}
			resp.sendRedirect("PdsController?command=list");
		}
		else if(command.equals("delete")){
			
			int seq = Integer.parseInt(req.getParameter("seq"));
			boolean result = pdao.deletePds(seq);
			
			if(result == true) {
				System.out.println("삭제되었습니다.");
			}
			else {
				System.out.println("삭제 실패.");
			}
			resp.sendRedirect("PdsController?command=list");
			
		}else if(command.equals("search")) {
			PrintWriter writer = resp.getWriter();
			
				String str = req.getParameter("str");
				int option = Integer.parseInt(req.getParameter("option"));
				
				List<PdsDto> pdslist = new ArrayList<>();
				
				if(option == 0) {
					pdslist = pdao.getPdsList();
				}else {
					pdslist = pdao.searchlist(option, str);
				}
				
				if(pdslist.isEmpty()) {
					writer.println("<script>alert(\"찾으시는 내용이 없습니다.\"); location = \'PdsController?command=list\';  </script>");
			}else {
			
				req.setAttribute("pdslist", pdslist);
				
				dispatch("/JSP/PdsList.jsp", req, resp);
			}
			
		}else if(command.equals("download")) {
			
			//	String filename = new String(req.getParameter("filename").getBytes("8859_1"), "KSC5601");
				String filename = req.getParameter("filename");
				System.out.println("filename = " + filename);
				
				System.out.println("seq =" + req.getParameter("seq"));
				
				// download 회수를 증가
				String pdsseq = req.getParameter("seq");
				int seq = Integer.parseInt(pdsseq);
				
				PdsDao dao = PdsDao.getInstance();
				boolean isS = dao.downloadcount(seq);
				/*if(!isS) {
							
				}*/
				
				BufferedOutputStream out = new BufferedOutputStream(resp.getOutputStream());
				String filePath = "";
				
				if(pdsseq != null) {
					
					// tomcat
					//filePath = mConfig.getServletContext().getRealPath("/upload");

					
					// 개인폴더
					filePath = "C:\\tmp";			
				}
				
				try {
				
					filePath = filePath + "\\" + filename;
					
					File f = new File(filePath);
					System.out.println("filePath:" + filePath);
					
					if(f.exists() && f.canRead()) {
					
						// 다운 로드 window 설정(다운로드창)
						resp.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\";");
						resp.setHeader("Content-Transfer-Encoding", "binary;");
						resp.setHeader("Content-Length", "" + f.length());
						resp.setHeader("Pragma", "no-cache;"); 
						resp.setHeader("Expires", "-1;");
						
						// 파일 생성, 기입
						BufferedInputStream fileInput = new BufferedInputStream(new FileInputStream(f));
						byte buffer[] = new byte[BUFFER_SIZE];
						
						int read = 0;
						
						while((read = fileInput.read(buffer)) != -1) {
							out.write(buffer, 0, read);					
						}
						
						fileInput.close();
						out.flush();
					}else {
						System.out.println("파일이 존재하지 않습니다");
					}
				
				}catch (Exception e) {			
				}finally {
					if(out != null) {
						out.flush();
						out.close();
					}
				}
				
				
		}
				/*PrintWriter out = resp.getWriter();
				
				out.println("<script> location= \'./JSP/Pdsdetail.jsp?seq="+seq+"\';</script>");*/
		
		/*resp.sendRedirect("./JSP/Pdsdetail.jsp?seq="+seq);	*/
		
	}		
	
	
	
		
	public void dispatch(String urls, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		RequestDispatcher dispatch = req.getRequestDispatcher(urls);
		dispatch.forward(req, resp);
	}
}
