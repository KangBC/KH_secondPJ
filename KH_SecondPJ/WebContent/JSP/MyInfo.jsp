<%@page import="Dao.MemberDao"%>
<%@page import="Dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="/KH_SecondPJ/CSS/Member.css"/>
<title>내 정보</title>
</head>
<body>
<jsp:include page="Header.jsp"></jsp:include>
<%
	MemberDao dao = MemberDao.getInstance();

	HttpSession memberSession = request.getSession(false);
	
	MemberDto member = null;
	member = (MemberDto)memberSession.getAttribute("kh_member");
	
	if(member != null){
		member = dao.getMember(member.getId());
		%>
		<div id=myInfoDiv style="margin-top: 6%">
<form action="/KH_SecondPJ/MemberController" onsubmit="return validityCk()"> 
<!-- <form action="" id="loginForm"> -->
	<input type="hidden" name="command" value="updateInfo" >
<table>
	<tr>
		<td>
			<label>ID</label>
		</td>
		<td>
			<input class=myInfoTB type="text" id="id" name="id" value="<%=member.getId()%>" readonly="readonly" style="cursor: default;">
		</td>
	</tr>
	<tr>
		<td>
			<label>이름</label>
		</td>
		<td>
			<input class=myInfoTB type="text" id="name" name="name" value="<%=member.getName()%>" placeholder="이름" >
		</td>
	</tr>
	<tr>
		<td>
			<label>배우자 이름</label>
		</td>
		<td>
			<input class=myInfoTB type="text" id="partner" name="partner" value="<%=member.getPartner()%>" placeholder="배우자 이름">
		</td>
	</tr>
	<tr>
		<td>
			<label>전화번호</label>
		</td>
		<td>
			<input class=myInfoTB type="text" id="phone" name="phone" value="<%=member.getPhone()%>" placeholder="전화번호">
		</td>
	</tr>
	<tr>
		<td>
			<label>e-mail</label>
		</td>
		<td>
			<input class=myInfoTB type="text" id="email" name="email" value="<%=member.getEmail()%>" placeholder="E-MAIL">
		</td>
	</tr>
</table>
<input class="btn" type="submit" value="수정"> 
<!-- <button class="btn" id="btn">수정</button> -->
</form>
</div>

<script type="text/javascript">
/* $(document).ready(function () {
	$("#btn").click(function () {
		alert("수정");
		
		$("#loginForm").attr({"target":"_self", "action":"/KH_SecondPJ/MemberController"}).submit();
	});	
}); */
function validityCk() {
 	var name = $("#name").val().trim();
	var partner = $("#partner").val().trim();
	var phone = $("#phone").val().trim();
	var email = $("#email").val().trim();
	
	var _name = "<%=member.getId()%>";
	var _partner = "<%=member.getPartner()%>";
	var _phone = "<%=member.getPhone()%>";
	var _email = "<%=member.getEmail()%>";

	var phoneRule = /^\d{3}-\d{3,4}-\d{4}$/;
	var emailRule = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
	
	if(name.length<1){
		alert("이름을 입력해 주세요");
		return false;
	} else if(phone.length<1){
		alert("전화번호를 입력해 주세요");
		return false;
	} else if(phone.length<1){
		alert("email을 입력해 주세요");
		return false;
	} else if(!phoneRule.test(phone)){
		alert("전화번호를 형식에 맞게 입력해 주세요");
		return false;
	} else if(!emailRule.test(email)){
		alert("이메일을 형식에 맞게 입력해 주세요");
		return false;
	}
	if(name == _name.trim() && partner == _partner.trim() && phone == _phone.trim() && email == _email.trim()){
		return false;
	} 
}
</script>
		<%
	}else{
		%>
		<script> alert("로그아웃되어서 내 정보를 볼수 없습니다."); location  = "/KH_SecondPJ/JSP/About.jsp";</script>
		<%
	}
%>
</body>
</html>