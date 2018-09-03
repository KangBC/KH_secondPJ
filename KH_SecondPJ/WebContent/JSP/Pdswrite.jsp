<%@page import="Dto.PdsDto"%>
<%@page import="Dao.PdsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>


<h3>자료 쓰기!</h3>

<div align="center">


<form action="Pdsupload.jsp" method="post" enctype="multipart/form-data">

<table border="1" bgcolor="pink">
<col width="200"><col width="500">

<tr>
	<td>아이디</td>
	<td>
		<input type="text" name="id" value="tttt">
	</td>
</tr>

<tr>
	<td>제목</td>
	<td>
		<input type="text" name="title" size="75" >
	</td>
</tr>

<tr>
	<td>파일 업로드</td>
	<td>
		<input type="file" name="fileload" style="width: 400px">
	</td>
</tr>

<tr>
	<td>내용</td>
	<td >
		<textarea rows="30" cols="77" name="content"></textarea>
	</td>
</tr>



<tr align="center">
	<td colspan="2">
		<input type="submit" value="올리기">
	</td>
</tr>

</table>
</form>
<a href="PdsList.jsp">완료</a>



</div>


</body>
</html>



















