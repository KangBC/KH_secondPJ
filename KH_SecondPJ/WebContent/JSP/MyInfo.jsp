<%@page import="Dao.MemberDao"%>
<%@page import="Dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="/KH_SecondPJ/CSS/Member.css"/>
<title>내 정보</title>
</head>
<body>
<%
	MemberDao dao = MemberDao.getInstance();

	HttpSession memberSession = request.getSession(false);
	MemberDto member = (MemberDto)memberSession.getAttribute("kh_member");
	if(member == null){
		System.out.println("null");
		return;
	}
	member = dao.getMember(member.getId());

%>
<div id=myInfoDiv>
<form action="">
	<input type="hidden" name="command" value="">
<table>
	<tr>
		<td>
			<label>ID</label>
		</td>
		<td>
			<input class=myInfoTB type="text" name="id" value="<%=member.getId()%>" readonly="readonly" style="cursor: default;">
		</td>
	</tr>
	<tr>
		<td>
			<label>이름</label>
		</td>
		<td>
			<input class=myInfoTB type="text" name="name" value="<%=member.getName()%>">
		</td>
	</tr>
	<tr>
		<td>
			<label>배우자 이름</label>
		</td>
		<td>
			<input class=myInfoTB type="text" name="partner" value="<%=member.getPartner()%>">
		</td>
	</tr>
	<tr>
		<td>
			<label>전화번호</label>
		</td>
		<td>
			<input class=myInfoTB type="text" name="phone" value="<%=member.getPhone()%>">
		</td>
	</tr>
	<tr>
		<td>
			<label>e-mail</label>
		</td>
		<td>
			<input class=myInfoTB type="text" name="email" value="<%=member.getEmail()%>">
		</td>
	</tr>
</table>
<input class="btn" type="submit" value="수정">
</form>
</div>

</body>
</html>