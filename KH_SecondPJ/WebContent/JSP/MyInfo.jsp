<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="../CSS/Member.css"/>
<title>내 정보</title>
</head>
<body>

<div id=myInfoDiv>
<form action="">
	<input type="hidden" name="command" value="">
<table>
	<tr>
		<td>
			<label>ID</label>
		</td>
		<td>
			<input class=myInfoTB type="text" name="id" value="" readonly="readonly" style="cursor: default;">
		</td>
	</tr>
	<tr>
		<td>
			<label>이름</label>
		</td>
		<td>
			<input class=myInfoTB type="text" name="name" >
		</td>
	</tr>
	<tr>
		<td>
			<label>전화번호</label>
		</td>
		<td>
			<input class=myInfoTB type="text" name="email" >
		</td>
	</tr>
	<tr>
		<td>
			<label>e-mail</label>
		</td>
		<td>
			<input class=myInfoTB type="text" name="email" >
		</td>
	</tr>
</table>
<input class="btn" type="submit" value="수정">
</form>
</div>

</body>
</html>