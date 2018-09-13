<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="/KH_SecondPJ/CSS/Member.css"/>
<link rel="stylesheet" type="text/css" href="/KH_SecondPJ/CSS/Regilion.css"/>
<title>회원가입</title>
</head>
<body>

<!-- 로그인  -->
<div id=registDiv style="margin-top: 100px; background:  RGBA(255,255,255,0.2); box-shadow:none;"  >

<form action="/KH_SecondPJ/MemberController" id="regist" method="post" onsubmit="return validityCk()">
	<input type="hidden" name="command" value="regist_submit" >
	<input class=registTB type="text" id="id" name="id" value="" placeholder="*ID (6~12자의 영어, 숫자)" autocomplete="off" onblur="idCheck()" onfocus="$('#id').css('background-color','#f2f2f2');">
	<input class=registTB type="password" id="pw" name="pw" placeholder="*비밀번호 (특수문자, 숫자를 포함한 8~15자)">
	<input class=registTB type="password" id="pw_check" name="pw_check" placeholder="*비밀번호 확인">
	<input class=registTB type="text" id="name" name="name" placeholder="*이름" autocomplete="off">
	<input class=registTB type="text" id="partner" name="partner" placeholder="배우자 이름" autocomplete="off">
	<input class=registTB type="text" id="phone" name="phone" placeholder="*전화번호 (010-1234-1234)" autocomplete="off">
	<input class=registTB type="text" id="email" name="email" placeholder="*E-MAIL (abc@naver.com)" autocomplete="off">
	<input class=btn type="submit" value="회원가입">
</form>
</div>

<script type="text/javascript">
var idok = false;
function idCheck(){
 	var id = $("#id").val();
	var idRule = /^[A-Za-z0-9]{6,12}$/;
	
	if(id.trim().length<1){
		alert("아이디를 입력해 주세요");
		idok = false;
		return;
	}else if(!idRule.test(id)){
		alert("아이디는 영어와 숫자를 이용하여 6-12자리로 입력해 주세요.");
		idok = false;
		return;
	} 
	
	$.ajax({
		url : "/KH_SecondPJ/MemberController?command=idCheck",
	    type:"get",
	    data : { id:$("#id").val() },
	    success : function(msg){
	    		var jsonObj = JSON.parse(msg);

	    		if(jsonObj.duplicated){
	    			$("#id").css("background-color","#FFB4B4");
	    			alert("이미 존재하는 아이디입니다.")
	    			idok = false;
	    		}else{
	    			idok = true;
	    		}
	    	},
	    error: function(xhr , status){
	    	alert(xhr + " : " + status)
	    }
	});
};

function validityCk() {
	var pw = $("#pw").val();
	var pw_check = $("#pw_check").val();
	var name = $("#name").val();
	var phone = $("#phone").val();
	var email = $("#email").val();
		
	var pwRule = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
	var phoneRule = /^\d{3}-\d{3,4}-\d{4}$/;
	var emailRule = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;

	if(!idok){
		alert("아이디를 확인해 주세요");
		return false;
	}else if(pw.trim().length<1){
		alert("비밀번호를 입력해 주세요");
		return false;
	}else if(pw!=pw_check){
		alert("비밀번호와 비밀번호 확인이 동일하지 않습니다.");
		return false;
	}else if(namee.trim().length<1){
		alert("이름을 입력해 주세요");
		return false;
	}else if(phone.trim().length<1){
		alert("전화번호를 입력해 주세요");
		return false;
	}else if(email.trim().length<1){
		alert("email을 입력해 주세요");
		return false;
	}else if(!pwRule.test(pw)){
		alert("pw false");
		return false;
	}else if(!phoneRule.test(phone)){
		alert("전화번호를 형식에 맞게 입력해 주세요");
		return false;
	}else if(!emailRule.test(email)){
		alert("이메일을 형식에 맞게 입력해 주세요");
		return false;
	}
};


</script>
</body>
</html>