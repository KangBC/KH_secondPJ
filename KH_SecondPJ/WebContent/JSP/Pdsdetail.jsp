<%@page import="Dto.MemberDto"%>
<%@page import="Dto.PdsDto"%>
<%@page import="Dao.PdsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Pdsdetail</title>
</head>
<body>


<%
MemberDto mdo =(MemberDto) session.getAttribute("kh_member");
boolean idcheck = false;
String idstr = "";

if(mdo != null){
	idcheck = true;
	idstr = mdo.getId();
}

String wk =request.getParameter("seq");
int pdsid=Integer.parseInt(wk);
PdsDao dao = PdsDao.getInstance();

dao.pdsReadCount(pdsid);
PdsDto dto =dao.getPDS(pdsid); 
%>

<form action="../PdsController?command=detailPds" method="post">
<table border="2">

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
	<td>다운로드</td>
	<td><input type="button" name="btndown" value="파일" 
	onclick="location='<%=request.getContextPath() %>/PdsController?command=download&filename=<%=dto.getFilename()%>&seq=<%=dto.getSeq()%>'"></td>
</tr>



<tr>
	<td>내용</td>
	<td><textarea name="content" rows="20" cols="40" readonly="readonly"><%=dto.getContent() %></textarea></td>
</tr>


</table>
</form>

<form action="<%=request.getContextPath()%>/PdsController" method="post">
<input type="hidden" name="command" value="delete">
<input type="hidden" name="seq" value="<%=dto.getSeq()%>">
<input id="delete" type="submit" value="삭제">
</form>

<button id="update" onclick="location = '<%=request.getContextPath()%>/JSP/Pdsupdate.jsp?seq=<%=dto.getSeq()%>'" >수정하기</button>
<!-- <input type="submit" id="update" value="수정하기"
onclick="javascript:document.location.href='Pdsupdate.jsp?'"> -->

<script>
var del = document.getElementById("delete");
var up = document.getElementById("update");


if(<%=!idcheck %> || '<%=idstr %>' !== '<%=dto.getId()%>'){
	del.setAttribute("disabled", "disabled");
	up.setAttribute("disabled", "disabled");
}
</script>


</body>
</html>


















