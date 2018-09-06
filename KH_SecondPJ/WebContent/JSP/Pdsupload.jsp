<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.io.IOException"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.io.File"%>
<%@page import="Dto.PdsDto"%>
<%@page import="Dao.PdsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String file = request.getParameter("fileload");
System.out.println("file:" + file);
%>    



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>


<%!
public String processUploadFile(FileItem fileItem, String dir, JspWriter out) throws IOException {
	
	String fileName = fileItem.getName();
	long sizeInBytes = fileItem.getSize();
	
	// 업로드한 파일이 정상일 경우
	if(sizeInBytes > 0){		
 		int idx = fileName.lastIndexOf("\\");
		if(idx == -1){		
			idx = fileName.lastIndexOf("/");
		}
		fileName = fileName.substring(idx+1);	
		
		
		
		try{
			File uploadedFile = new File(dir, fileName);
			fileItem.write(uploadedFile);		
		}catch(Exception e){}
	}
	return fileName;
}
%>


<%
//System.out.println(request.getRealPath("/"));
//String fupload = request.getRealPath("/")+"upload\\";
//"C:\\Users\\SJ\\Desktop\\project\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\KH_SecondPJ\\upload\\";
//request.getContextPath()+"/upload/";

String fupload = "C:\\tmp";

System.out.println("파일 업로드 : " + fupload);

String yourTempDirectory = fupload;

int yourMaxRequestSize = 100 * 1024 * 1024; 
int yourMaxMemorySize = 100 * 1024;


String id = "";
String title = "";
String content = "";
String filename = "";


boolean isMultipart = ServletFileUpload.isMultipartContent(request);
if(isMultipart){
	
	
	DiskFileItemFactory factory = new DiskFileItemFactory();
	
	factory.setSizeThreshold(yourMaxMemorySize);
	factory.setRepository(new File(yourTempDirectory));
	
	ServletFileUpload upload = new ServletFileUpload(factory);
	upload.setSizeMax(yourMaxRequestSize);	

	/////////////////////////////////////////////////////////////////
	
	
	List<FileItem> items = upload.parseRequest(request);
	
	Iterator<FileItem> it = items.iterator();
	
	while(it.hasNext()){
		FileItem item = it.next();
		
		if(item.isFormField()){ 
			if(item.getFieldName().equals("id")){
				id = item.getString("utf-8");	
			}else if(item.getFieldName().equals("title")){
				title = item.getString("utf-8");
			}else if(item.getFieldName().equals("content")){
				content = item.getString("utf-8");
			}
			
		}
		else{ 
			if(item.getFieldName().equals("fileload")){
				filename = processUploadFile(item, fupload, out);
			}
			System.out.println("filename : " + filename);
		}
	}
		
	/////////////////////////////////////////////////////////////////
}else{
	System.out.println("Multipart가 아닙니다");
}


 
boolean isS = PdsDao.getInstance().writePds(new PdsDto(id, title, content, filename));
if(isS){
%>
	<script type="text/javascript">
	alert("파일 업로드 성공");
	location.href = "../PdsController?command=list";	
	</script>
<%
}else{
%>
	<script type="text/javascript">
	alert("다시 업로드를 진행해 주십시오");
	location.href = "<%=request.getContextPath()%>/JSP/PdsList.jsp";
	</script>
<%
}
%>



</body>
</html>














