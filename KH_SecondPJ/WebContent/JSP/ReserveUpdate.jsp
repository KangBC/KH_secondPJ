<%@page import="Dto.ReserveDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/KH_SecondPJ/CSS/Table.css"/>
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
<jsp:include page="Header.jsp"></jsp:include>

<div class="outer-container">
<h2>상담예약 수정</h2>
<hr><br>

<form action="<%=request.getContextPath() %>/ReserveController?command=updateAF" method="post">
<div class="inner-container">
<input type="hidden" name="seq" value="<%=dto.getSeq()%>">
<table border="0" style="border-collapse:collapse;">
<col width="100"><col width="920">
<tr>
<th>이름</th>
<td><input type="text" class="input_data" name="title" value='<%=dto.getTitle() %>' style="border: 0;" readonly></td>
</tr>

<tr>
<th>신청시간</th>
<td><input type="text" class="input_data" value="<%=dto.getWdate().substring(0,16)%>" style="border: 0;" readonly></td>
</tr>

<tr>
<th>예정일자</th>
<td><input type="date" class="input_data" name="date" value='<%=dateori %>'></td>
</tr>

<tr>
<th>예정시간</th>
<td>
<select class="input_data" name="time" required id="time">
<option value="0900">9:00 AM</option>
<option value="1100">11:00 AM</option>
<option value="1400">2:00 PM</option>
<option value="1600">4:00 PM</option>
</select>
</td>
</tr>




<tr>
<th>내용</th>
<td><textarea class="input_data" name="content" rows="4" cols="50" style="width: 90%; height:500px;"><%=dto.getContent() %></textarea></td>
</tr>


</table>
</div>
<hr>
<input type="submit" value="예약 변경">
<button type="button" onclick="location='<%=request.getContextPath() %>/JSP/Calendar.jsp'" >일정보기</button>
</form>

</div>
<script>
var arr = document.getElementsByTagName("option");

for(var i =0;i<arr.length;i++){
	if(arr[i].value == <%=timeori%>){
		arr[i].setAttribute("selected", true);
	}
}
</script>
<jsp:include page="Footer.jsp"></jsp:include>
</body>
</html>