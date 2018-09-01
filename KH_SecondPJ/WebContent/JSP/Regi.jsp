<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="../CSS/Member.css"/>
<title>회원가입</title>
</head>
<body>

<div id=registDiv>
<form action="../MemberController" method="post">
	<input type="hidden" name="command" value="regist_submit">
	<input class=registTB type="text" name="id" placeholder="ID">
	<input class=registTB type="password" name="pw" placeholder="비밀번호">
	<input class=registTB type="password" name="pw_check" placeholder="비밀번호 확인">
	<input class=registTB type="text" name="name" placeholder="이름">
	<input class=registTB type="text" name="partner" placeholder="배우자 이름">
	<input class=registTB type="text" name="phone" placeholder="전화번호">
	<input class=registTB type="text" name="email" placeholder="E-MAIL">
	<input class=btn type="submit" value="회원가입">
</form>
</div>

</body>
</html>