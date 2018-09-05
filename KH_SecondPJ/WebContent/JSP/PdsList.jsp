<%@page import="Dao.PdsDao"%>
<%@page import="Dto.PdsDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>PdsList</title>
</head>
<body>
<jsp:include page="Header.jsp"></jsp:include>
	<%
	List<PdsDto> pdslist = (List<PdsDto>) request.getAttribute("pdslist");
	%>


	<h3>자료실!</h3>

	<div align="center">
		<form action="PdsController" method="post">
			<input type="hidden" name="command" value="muldel">
			<table border="1">
				<col width="50">
				<col width="100">
				<col width="400">
				<col width="100">
				<col width="100">
				<col width="100">

				<tr bgcolor="pink">
					<th>번호</th>
					<th>작성자</th>
					<th>제목</th>
					<th>조회수</th>
					<th>작성일</th>
				</tr>

				<%
					if (pdslist == null || pdslist.size() == 0) {
				%>
				<tr>
					<td colspan="3">작성된 글이 없습니다</td>
				</tr>

				<%
					}
					int Articlenumber = 0; //글번호

						for (int i = 0; i < pdslist.size(); i++) {
							PdsDto pds = pdslist.get(i);
							
							//삭제
							if(pds.getDel() == 0){
								Articlenumber++;
				%>

				<tr align="center" height="10">
					<td><%=Articlenumber%></td>
					<td><%=pds.getId()%></td>
					<td><a href="<%=request.getContextPath() %>/JSP/Pdsdetail.jsp?seq=<%=pds.getSeq()%>"> <%=pds.getTitle()%>
					</a></td>

					<td><%=pds.getReadcount()%></td>
					<td><%=pds.getRegdate()%></td>

				</tr>
				<%
					}
					}
				%>
			</table>


			<a href="<%=request.getContextPath() %>/JSP/Pdswrite.jsp">자료 올리기</a> 
			<br> <br> 
 			<select id="option">
			<option value="0">전체보기</option>
			<option value="1">아이디</option>
			<option value="2">제목</option>
			</select>
			<input type="text" id="search">
			
			<button type="button" name="search" onclick="srch()">검색</button> 
		</form>
	</div>
	
 	<script>
	function srch(){
		var search = document.getElementById("search");
		var option = document.getElementById("option");
		var str = "<%=request.getContextPath() %>/PdsController?command=search&str=" + search.value + "&option="+option.value;
		
		location = str;
	}
	
	</script> 
	</body>
</html>