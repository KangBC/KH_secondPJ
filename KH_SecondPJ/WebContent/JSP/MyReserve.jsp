<%@page import="Dto.ReserveDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
List<ReserveDto> list = (List<ReserveDto>)request.getAttribute("mylist");

int size = list.size();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<% 
if(size == 0){
	%>
	<p>예약된 일정이 없습니다.</p>
	<%
}else{
	for(int i =0; i < size;i++){
		ReserveDto dto = list.get(i);
	%>
		<table border="1">
		<col width="100"><col width="250">
		<tr>
		<th>아이디</th>
		<td><%=dto.getId() %></td>
		</tr>
		
		<tr>
		<th>제목</th>
		<td><%=dto.getTitle() %></td>
		</tr>
		
		<tr>
		<td>예정시간</td>
		<td><input type="text" name="date" value='<%=dto.getRdate() %>' readonly></td>
		</tr>
		

		<th>신청시간</th>
		<td><%=dto.getWdate()%></td>
		</tr>
		
		<tr>
		<th>내용</th>
		<td><textarea rows="4" cols="50" readonly><%=dto.getContent() %></textarea></td>
		</tr>
		
		</table>
	
	<%
	}
}
%>

<button type="button" onclick="location='<%=request.getContextPath() %>/JSP/Calendar.jsp'" >일정보기</button>

</body>
</html>