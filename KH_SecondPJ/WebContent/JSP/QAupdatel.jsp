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


</head>
<body>
	<div align="center">
		<a href="Login.jsp">로그아웃</a>
		<h1>수정</h1>
	</div>
	<%
		Object ologin = session.getAttribute("kh_member");
		MemberDto mem = null;
		mem = (MemberDto) ologin;

		String sseq = request.getParameter("seq");
		int seq = Integer.parseInt(sseq.trim());

		QADao dao = QADao.getInstance();
		QADto dto = dao.getBbs(seq);
	%>

	<div class="center">
		<form action="../QAController" method="post">
			<input type="hidden" name="seq" value="<%=seq%>"> <input
				type="hidden" name="command" value="QAupdate">
			<table class="table table-bordered" style="width: 700px"
				height="500px" align="center">
				<col width="100px">

				<tr>
					<td>ID:</td>
					<td><input type="text" placeholder="제목을 입력하세요. " name="id"
						class="form-control" value="<%=dto.getId()%>"></td>
				</tr>

				<tr>
					<td>제목:</td>
					<td><input type="text" placeholder="제목을 입력하세요. " name="title"
						class="form-control" value="<%=dto.getTitle()%>"></td>
				</tr>

				<tr>
					<td>작성일:</td>
					<td><input type="text" name="wdate" class="form-control"
						value="<%=dto.getWdate()%>"></td>
				</tr>

				<tr>
					<td>조회수:</td>
					<td><input type="text" name="readcount" class="form-control"
						value="<%=dto.getReadcount()%>"></td>
				</tr>

				<tr>
					<td>정보</td>
					<td><%=dto.getRef()%>-<%=dto.getStep()%>-<%=dto.getDepth()%></td>
				</tr>

				<tr>
					<td>내용</td>
					<td><textarea cols="700" placeholder="내용을 입력하세요. "
							name="content" class="form-control"> <%=dto.getContent()%> </textarea>
					</td>
				</tr>

				<tr>
					<td colspan="2"><input type="submit" value="수정하기"></td>
				</tr>


			</table>
		</form>
	</div>

<input type="button" value="글 목록 "
class="pull-right" onclick="javascript:location.href='<%=request.getContextPath() %>/QAController?command=list&searchfor=0'" />

</body>
</html>

