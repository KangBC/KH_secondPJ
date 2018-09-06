<%@page import="Dto.MemberDto"%>
<%@page import="Dto.QADto"%>
<%@page import="Dao.QADao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>QAanswer</title>

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">

<!-- Optional theme -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"
	integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp"
	crossorigin="anonymous">

<!-- Latest compiled and minified JavaScript-->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
	integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
	crossorigin="anonymous"></script>

<%
	String sseq = request.getParameter("seq");
	int seq = Integer.parseInt(sseq.trim());

	QADao dao = QADao.getInstance();

	dao.QAreadcount(seq);
	QADto dto = dao.getBbs(seq);
%>

</head>
<body>
	<div align="center">
		<a href="login.jsp">로그아웃</a>
		<h1>원글 보기</h1>
	</div>

	<div class="center">
		<table class="table table-bordered" style="width: 700px"
			height="500px" align="center">
			<col width="100px">

			<tr>
				<td>ID:</td>
				<td><%=dto.getId()%>"></td>
			</tr>


			<tr>
				<td>제목:</td>
				<td><%=dto.getTitle()%>"></td>
			</tr>

			<tr>
				<td>작성일:</td>
				<td><%=dto.getWdate()%>"></td>
			</tr>


			<tr>
				<td>조회수:</td>
				<td><%=dto.getReadcount()%>"></td>
			</tr>

			<tr>
				<td>정보</td>
				<td><%=dto.getRef()%>-<%=dto.getStep()%>-<%=dto.getDepth()%></td>
			</tr>

			<tr>
				<td>내용</td>
				<td><textarea cols="700" name="content" readonly="readonly"
						class="form-control"> <%=dto.getContent()%> </textarea></td>
			</tr>

		</table>
	</div>

	<hr>

	<%
		Object ologin = session.getAttribute("kh_member");
		MemberDto mem = (MemberDto) ologin;
	%>

	<div align="center">
		<h1>답글달기</h1>
	</div>

	<div class="center">
		<form action="../QAController?command=QAanswer" method="post">
		<input type="hidden" name="seq" value=<%=seq%>>
			<table class="table table-bordered" style="width: 700px"
				height="500px" align="center">
				<col width="100px">

				<tr>
					<td>ID:</td>
					<td><input type="text" name="id" class="form-control"
						value="<%=mem.getId()%>"></td>
				</tr>


				<tr>
					<td>제목:</td>
					<td><input type="text" name="title" placeholderclass="title" "form-control"></td>
				</tr>

				<tr>
					<td>내용</td>
					<td><textarea cols="700" placeholder="내용을 입력하세요. "
							name="content" class="form-control"></textarea></td>
				</tr>

				<tr>
					<td colspan="2"><input type="submit" value="답글"></td>
				</tr>

			</table>
		</form>
	</div>
</body>
</html>