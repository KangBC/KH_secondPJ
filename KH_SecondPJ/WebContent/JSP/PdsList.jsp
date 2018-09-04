<%@page import="Dao.PdsDao"%>
<%@page import="Dto.PdsDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>PdsList</title>
</head>
<body>

<%
List<PdsDto> list = PdsDao.getInstance().getPdsList();
%>


<h3>자료실!</h3>

<div align="center">


<table border="1">
	<col width="50"><col width="100"><col width="400"><col width="100">
	<col width="100"><col width="100">

	<tr bgcolor="pink">
		<th>번호</th><th>작성자</th><th>제목</th><th>조회수</th><th>작성일</th>
	</tr>

<%
for(int i = 0; i< list.size(); i++){
	PdsDto pds = list.get(i);

%>

	
	<tr align="center" height="10">
		<td><%=i+1 %></td>
		<td><%=pds.getId() %></td>
		<td>
		<a href="Pdsdetail.jsp?seq=<%=pds.getSeq()%>"> <%=pds.getTitle() %>
		</a>
		</td>
		
		<td><%=pds.getReadcount() %></td>
		<td><%=pds.getRegdate() %></td>
		
	</tr>
<%
}
%>
</table>


<a href="Pdswrite.jsp">자료 올리기</a>

<br><br>

<input type="text" id="search">
<button name="search" onclick="">검색</button>
</div>
</body>
</html>


















