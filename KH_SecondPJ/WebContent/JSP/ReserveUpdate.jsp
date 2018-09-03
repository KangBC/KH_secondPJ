<%@page import="Dto.ReserveDto"%>
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
request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("utf-8");
ReserveDto dto = (ReserveDto)request.getAttribute("dto");

String dateori = dto.getRdate().substring(0, 4) + "-"+ dto.getRdate().substring(4, 6)+ "-"+  dto.getRdate().substring(6, 8);
String timeori = dto.getRdate().substring(8, 12);
%>
<form action="<%=request.getContextPath() %>/ReserveController?command=updateAF" method="post">
<input type="hidden" name="seq" value="<%=dto.getSeq()%>">
<table border="1">
<col width="100"><col width="250">
<tr>
<th>아이디</th>
<td><input type="text" value='<%=dto.getId() %>' readonly></td>
</tr>

<tr>
<th>제목</th>
<td><input name="title" type="text" value='<%=dto.getTitle() %>'></td>
</tr>

<tr>
<th>신청시간</th>
<td><%=dto.getWdate()%></td>
</tr>

<tr>
<td>예정일자</td>
<td><input type="date" name="date" value='<%=dateori %>'></td>
</tr>

<tr>
<td>예정시간</td>
<td>
<select name="time" required id="time">
<option value="0900">9:00 AM</option>
<option value="1100">11:00 AM</option>
<option value="1400">2:00 PM</option>
<option value="1600">4:00 PM</option>
</select>
</td>
</tr>




<tr>
<th>내용</th>
<td><textarea name="content" rows="4" cols="50" ><%=dto.getContent() %></textarea></td>
</tr>

<tr>
<td colspan="2"><input type="submit" value="예약 변경"></td>
</tr>

</table>
</form>

<button type="button" onclick="location='<%=request.getContextPath() %>/JSP/Calendar.jsp'" >일정보기</button>

<script>
var arr = document.getElementsByTagName("option");

for(var i =0;i<arr.length;i++){
	if(arr[i].value == <%=timeori%>){
		arr[i].setAttribute("selected", true);
	}
}
</script>
</body>
</html>