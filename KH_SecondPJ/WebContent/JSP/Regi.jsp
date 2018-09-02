<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="/KH_SecondPJ/CSS/Member.css"/>
<title>회원가입</title>
</head>
<body>
<div id=registDiv>
<form action="/KH_SecondPJ/MemberController" id="regist" method="post" onsubmit="return validityCk()">
	<input type="hidden" name="command" value="regist_submit">
	<input class=registTB type="text" id="id" name="id" value="" placeholder="ID">
	<input class=registTB type="password" id="pw" name="pw" placeholder="비밀번호">
	<input class=registTB type="password" id="pw_check" name="pw_check" placeholder="비밀번호 확인">
	<input class=registTB type="text" id="name" name="name" placeholder="이름">
	<input class=registTB type="text" id="partner" name="partner" placeholder="배우자 이름">
	<input class=registTB type="text" id="phone" name="phone" placeholder="전화번호">
	<input class=registTB type="text" id="email" name="email" placeholder="E-MAIL">
	<input class=btn type="submit" value="회원가입">
</form>
</div>

<script type="text/javascript">
function validityCk() {
	var id = $("#id").val();
	var pw = $("#pw").val();
	var pw_check = $("#pw_check").val();
	var name = $("#name").val();
	var phone = $("#phone").val();
	var email = $("#email").val();
		
	if(id.trim().length<1){
		alert("아이디를 입력해 주세요")
		return false;
	}else if(pw.trim().length<1){
		alert("비밀번호를 입력해 주세요")
		return false;
	}else if(pw!=pw_check){
		alert("비밀번호와 비밀번호 확인이 동일하지 않습니다.")
		return false;
	}else if(phone.trim().length<1){
		alert("전화번호를 입력해 주세요")
		return false;
	}else if(email.trim().length<1){
		alert("email을 입력해 주세요")
		return false;
	}
};
</script>
</body>
</html>