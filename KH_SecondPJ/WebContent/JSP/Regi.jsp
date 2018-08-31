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
<form action="">
	<input type="hidden" name="command" value="regist_submit">
	<input class=registTB type="text" name="id" placeholder="ID">
	<input class=registTB type="password" name="pw" placeholder="PASSWORD">
	<input class=registTB type="password" name="pw_check" placeholder="PASSWORD CHECK">
	<input class=registTB type="text" name="name" placeholder="NAME">
	<input class=registTB type="text" name="email" placeholder="E-MAIL">
	<input class=btn type="submit" value="회원가입">
</form>
</div>

</body>
</html>