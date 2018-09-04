<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%
String error = request.getParameter("error");

if(error.equals("schedule")){
	%>
	<script>alert("신청하신 시간에 다른 상담이 예약되어 있습니다.");
	location = "<%=request.getContextPath() %>/JSP/Calendar.jsp";
	</script>
	<%
	
}

if(error.equals("weekend")){
	%>
	<script>alert("주말에는 상담을 진행하지 않습니다.");
	location = "<%=request.getContextPath() %>/JSP/Calendar.jsp";
	</script>
	<%
	
}





%>