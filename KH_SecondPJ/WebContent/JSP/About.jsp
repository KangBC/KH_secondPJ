<%@page import="Dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="Header.jsp"></jsp:include>

<a href="<%=request.getContextPath()%>/JSP/Calendar.jsp">Calendar</a><br>
<a href="<%=request.getContextPath()%>/QAController?command=list">QAList</a><br>
<a href="<%=request.getContextPath()%>/PdsController?command=list">Pds</a>

</body>
</html>