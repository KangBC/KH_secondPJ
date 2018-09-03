<%@page import="java.time.LocalDateTime"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
LocalDateTime now = LocalDateTime.now();
String today = now.toString().substring(0, 10);


%>

<h1>Temp님 안녕하세요!</h1>

<form action="ReservController?command=reserve" method="post">
<table border="1">
<col width="70"><col width="500">
<tr><td colspan="2" align="center">Reservation Form</td></tr>
<tr>
<td>이름</td>
<td><input type="text" readonly value="temp"></td>
</tr>

<tr>
<td>제목</td>
<td><input type="text" name="title" required placeholder="제목을 입력해주세요"></td>
</tr>

<tr>
<td>일자</td>
<td><input type="date" name="date" value='<%=today %>'></td>
</tr>

<tr>
<td>시간</td>
<td>
<select name="time" required>
<option value="0900">9:00 AM</option>
<option value="1100">11:00 AM</option>
<option value="1400">2:00 PM</option>
<option value="1600">4:00 PM</option>
</select>


</td>
</tr>

<tr>
<td>내용</td>
<td><textarea rows="4" cols="50" name="content" required>
At w3schools.com you will learn how to make a website. We offer free tutorials in all web development technologies. 
</textarea></td>
</tr>

<tr>
<td colspan="2"><input type="submit" value="예약하기"><button type="button" onclick="location='<%=request.getContextPath() %>/JSP/Calendar.jsp'" >돌아가기</button></td>
</tr>
</table>
</form>

</body>
</html>