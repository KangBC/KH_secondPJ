<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="/KH_SecondPJ/CSS/Member.css"/>
<title>로그인</title>
</head>
<body>

<div id=loginDiv>
<form action="/KH_SecondPJ/MemberController" method="post">
	<input type="hidden" name="command" value="login">
	<input class=loginTB type="text" name="id" placeholder="ID" >
	<input class=loginTB type="password" name="pw" placeholder="PASSWORD">
	<input class=btn type="submit" value="Login">
</form>
<a href="Regi.jsp">회원가입</a>
</div>

</body>
</html>