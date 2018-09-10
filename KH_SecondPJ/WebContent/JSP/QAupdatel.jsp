<%@page import="Dto.MemberDto"%>
<%@page import="Dto.QADto"%>
<%@page import="Dao.QADao"%>
<%@page import="Dto.QADto"%>
<%@page import="Dao.QADao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>QAupdatel</title>

<link href="<%=request.getContextPath()%>/CSS/Table.css" rel="stylesheet">
</head>
<body>
<%
	Object ologin = session.getAttribute("kh_member");
	MemberDto mem = null;
	mem = (MemberDto) ologin;

	String sseq = request.getParameter("seq");
	int seq = Integer.parseInt(sseq.trim());

	QADao dao = QADao.getInstance();
	QADto dto = dao.getBbs(seq);
%>
	
<jsp:include page="../JSP/Header.jsp"></jsp:include>
<div class="outer-container">
	<form action="../QAController" method="post">
		<input type="hidden" name="seq" value="<%=seq%>"> <input type="hidden" name="command" value="QAupdate">
		<div class="inner-container">
			<table border="0" style="border-collapse: collapse">
				<col width="100">
				<col width="920">

				<tr>
					<td>ID</td>
					<td><input type="text" placeholder="제목을 입력하세요. " name="id"
						class="input_data" value="<%=dto.getId()%>" style="border: 0;" readonly></td>
				</tr>


				<tr>
					<td>작성일</td>
					<td><input type="text" name="wdate" class="input_data"
						value="<%=dto.getWdate()%>" style="border: 0;" readonly></td>
				</tr>

				<tr>
					<td>조회수</td>
					<td><input type="text" name="readcount" class="input_data"
						value="<%=dto.getReadcount()%>" style="border: 0;" readonly></td>
				</tr>

				<tr>
					<td>제목</td>
					<td><input type="text" placeholder="제목을 입력하세요. " name="title"
						class="input_data" value="<%=dto.getTitle()%>"></td>
				</tr>
				<tr style="border-bottom: 0;">
					<td style="vertical-align: top; padding-top: 8px;">내용</td>
						<td style="padding-top: 8px;"><textarea class="input_data"
								id="content" name="content"
								style="width: 90%; height: 500px; placeholder="내용을 입력하세요."> <%=dto.getContent()%> </textarea></td>
				</tr>



			</table>
		</div>
		<input type="submit" value="수정하기">
		<input type="button" value="글 목록 "
		class="pull-right" onclick="javascript:location.href='<%=request.getContextPath() %>/QAController?command=list&searchfor=0'" />
	</form>
</div>

<jsp:include page="../JSP/Footer.jsp"></jsp:include>
</body>
</html>

