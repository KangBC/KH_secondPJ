<%@page import="Dto.QADto"%>
<%@page import="java.util.*"%>
<%@page import="Dao.QADao"%>
<%@page import="Dto.MemberDto"%>

<%
	String findword = request.getParameter("findword");
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>QAList</title>
</head>

<body>
	<%!// 댓글!!
	public String arrow(int depth) {

		String rs = "<img src='image/arrow.png' width='20px' height='20px'/>";
		String nbsp = "&nbsp;&nbsp;&nbsp;&nbsp;"; // depth의 간격
		String ts = "";

		for (int i = 0; i < depth; i++) {
			ts += nbsp;
		}

		return depth == 0 ? "" : ts + rs;
	}%>

<%--  Member 연결해줄떄 사용
<%
Object ologin = session.getAttribute("login");

MemberDto mem = null;

if(ologin == null){
	%>
	<script type="text/javascript">
	alert("다시 로그인 해 주십시오");
	location.href = "index.jsp";
	</script>
	<%
	return;
}

mem = (MemberDto)ologin;
%>
 --%>

	<!-- 임시로그인  -->
	<%
		String mem = "hyunwoo";
	%>

	<h3>
		환영합니다
		<%=mem%>님 반갑습니다
	</h3>

	<!-- session 해방 && index로 -->
	<a href="Login.jsp">로그아웃</a>
	<hr>

	<%
		QADao dao = QADao.getInstance();
		List<QADto> QAlist = dao.getList();

		/* if(findword == null || findword.equals("")){
			bbslist = dao.getList();
		} else {
			bbslist = dao.getBbsFindList(findword);
		} */
	%>

	<div align="center">
		<table border="1">
			<col width="70">
			<col width="500">
			<col width="100">

			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
			</tr>

			<%
				if (QAlist == null || QAlist.size() == 0) {
			%>
			<tr>
				<td colspan="3">작성된 글이 없습니다</td>
			</tr>
			<%
				}
				for (int i = 0; i < QAlist.size(); i++) {
					QADto bbs = QAlist.get(i);
			%>
			<tr>
				<td><%=i + 1%></td>
				<td><%=arrow(bbs.getDepth())%>  
				<a href="QAupdatel.jsp?seq=<%=bbs.getSeq()%>"> <%=bbs.getTitle()%>
				</a></td>
				<td><%=bbs.getId()%></td>
			</tr>
			<%
				}
			%>

		</table>
	</div>
<br>
<br>
	<div align="center">
		<!-- 게시판 테이블 기능 -->
		<a href="./JSP/QAwrite.jsp">글쓰기</a> <br>
		<br> <input type="text" id="search">
		<button name="search" onclick="searchQA()">검색</button>
	</div>



	<script type="text/javascript">
		function searchQA() {
			var msg = document.getElementById("search").value;
			location.href = "QAlist.jsp?findword=" + msg;
		}
	</script>

</body>

</html>