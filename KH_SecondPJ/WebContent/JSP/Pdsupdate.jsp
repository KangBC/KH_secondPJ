<%@page import="Dto.PdsDto"%>
<%@page import="Dao.PdsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
String wk =request.getParameter("seq");
int pdsid=Integer.parseInt(wk);
PdsDao dao = PdsDao.getInstance();
dao.pdsReadCount(pdsid);
PdsDto dto =dao.getPDS(pdsid);
%>
<h3>자료 수정</h3>

<table border="1">

<tr>
	<td>작성자</td>
	<td><%=dto.getId() %></td>
</tr>

<tr>
	<td>제목</td>
	<td><%=dto.getTitle() %></td>
</tr>

<tr>
	<td>작성일</td>
	<td><%=dto.getRegdate() %></td>
</tr>


<tr>
	<td>내용</td>
	<td><textarea name="content" rows="20" cols="40"><%=dto.getContent() %></textarea></td>
</tr>

</table>

<a href="PdsList.jsp">수정완료</a>

</body>
</html>














