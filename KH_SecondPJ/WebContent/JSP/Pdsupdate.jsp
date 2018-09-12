<%@page import="Dto.PdsDto"%>
<%@page import="Dao.PdsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>KH_Wedding QA 수정</title>
<link href="<%=request.getContextPath()%>/CSS/Table.css" rel="stylesheet">
</head>
<body>

<%
String wk =request.getParameter("seq");
int pdsid=Integer.parseInt(wk);

PdsDao dao = PdsDao.getInstance();

PdsDto dto =dao.getPDS(pdsid);
%>
<jsp:include page="../JSP/Header.jsp"></jsp:include>

<!--  최상단 이미지 부분 -->
	<div class="img">
		<!-- img_위에 망 덮어씌움  이유 : 이미지가 색이 강력크 .. ㅋㅌ 방지용  -->
		<div class="img-cover"></div>
	</div>

<div align="center" style="margin: 80px auto 0;">
<h2>QA 수정</h2>
</div>
<hr style="width: 100px; border-color: black; margin: 0 auto;">

<div class="outer-container" style="margin-bottom: 80px;">
<form action="<%=request.getContextPath() %>/PdsController" method="post">
<input type="hidden" name="seq" value="<%=pdsid %>">
<input type="hidden" name="command" value="update">
<div class="inner-container">
<table border="0" style="border-collapse: collapse;">
<col width="100">
<col width="920">
<tr>
	<td>작성자</td>
	<td><input type="text" class="input_data" name="id" value="<%=dto.getId() %>" style="border: 0;" readonly></td>
</tr>

<tr>
	<td>작성일</td>
	<td><input type="text" class="input_data" name="wdate" value="<%=dto.getRegdate() %>" style="border: 0;" readonly></td>
</tr>

<tr>
	<td>제목</td>
	<td><input type="text" class="input_data" name="title" value="<%=dto.getTitle() %>"></td>
</tr>

<tr style="border-bottom: 0;">
	<td style="vertical-align: top; padding-top: 8px;">내용</td>
	<td style="padding-top: 8px;"><textarea class="input_data" id="content" name="content"
		style="width: 90%; height: 500px;" placeholder="내용을 입력하세요."><%=dto.getContent() %></textarea></td>
</tr>


</table>
</div>
	<input  class="mainbut" type="submit" value="수정하기">
</form>
</div>
<jsp:include page="../JSP/Footer.jsp"></jsp:include>
</body>
</html>














