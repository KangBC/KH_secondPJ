<%@page import="Dto.MemberDto"%>
<%@page import="Dto.PdsDto"%>
<%@page import="Dao.PdsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<%=request.getContextPath()%>/CSS/Table.css" rel="stylesheet">
<title>Insert title here</title>
</head>
<body>
<%

MemberDto dto = (MemberDto)session.getAttribute("kh_member");

%>
<jsp:include page="../JSP/Header.jsp"></jsp:include>

<div class="outer-container" align="center">
<form action="Pdsupload.jsp" method="post" enctype="multipart/form-data" >
<input type="hidden" name="command" value="write">
<div class="inner-container">
<table border="0" style="border-collapse: collapse">	
<col width="100"><col width="920">

<tr>
	<td>아이디</td>
	<td>
		<input type="text" class="input_data" name="id" value="<%=dto.getId() %>" readonly="readonly">
	</td>
</tr>

<tr>
	<td>제목</td>
	<td>
		<input type="text" class="input_data" name="title" required >
	</td>
</tr>

<tr>
	<td>파일 업로드</td>
	<td>
		<input type="file" class="input_data" name="fileload" style="width: 400px" required>
	</td>
</tr>

<tr style="border-bottom: 0;">
	<td style="vertical-align: top; padding-top: 8px;">내용</td>
	<td style="padding-top: 8px;">
		<textarea class="input_data" name="content" style="width:90%; height: 500px; " placeholder="내용을 입력하세요."></textarea>
	</td>
</tr>

</table>
</div>
		<input type="submit" value="올리기">
		<button type="button" onclick="location= '<%=request.getContextPath() %>/PdsController?command=list'">돌아가기</button>
</form>
</div>

<jsp:include page="../JSP/Footer.jsp"></jsp:include>

</body>
</html>
