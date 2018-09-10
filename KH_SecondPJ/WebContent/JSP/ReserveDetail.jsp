<%@page import="Dto.MemberDto"%>
<%@page import="Dto.ReserveDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/KH_SecondPJ/CSS/Table.css"/>
</head>

<body>
<%
response.setCharacterEncoding("utf-8");
ReserveDto dto = (ReserveDto)request.getAttribute("dto");

String dateori = dto.getRdate().substring(0, 4) + "-"+ dto.getRdate().substring(4, 6)+ "-"+  dto.getRdate().substring(6, 8);
String timeori = dto.getRdate().substring(8, 10)+":"+dto.getRdate().substring(10, 12);


MemberDto loginmember = (MemberDto)session.getAttribute("kh_member");
String idcheck = null;
if(loginmember != null){
	idcheck = loginmember.getId();
}

%>
<jsp:include page="Header.jsp"></jsp:include>

<div class="outer-container">
<h2>상담예약 확인</h2>
<hr><br>

<div class="inner-container">
<table border="0" style="border-collapse:collapse;">
<col width="100"><col width="920">
<tr>
<th>신청인</th>
<td><input type="text" class="input_data" value="<%=dto.getId() %>" style="border: 0;" readonly></td>
</tr>

<tr>
<th>예정시간</th>
<td><input type="text" class="input_data" name="date" value='<%=dateori %> <%=timeori %>' style="border: 0;" readonly></td>
</tr>

<tr>
<th>신청시간</th>
<td><input type="text" class="input_data" name="date" value='<%=dto.getWdate()%>' style="border: 0;" readonly></td>
</tr>

<tr style="border-bottom: 0;">
<th style="vertical-align: top; padding-top: 8px;">내용</th>
<td style="padding-top: 8px;">
<textarea class="input_data" rows="4" cols="50" style="width: 90%; height:500px;"  readonly><%=dto.getContent() %></textarea>
</td>
</tr>

</table>
</div>
<hr>
<button id="update" type="button" onclick="updatesch()">예약변경</button>
<button id="delete" type="button" onclick="deletesch()">예약취소</button>
<button type="button" onclick="location='<%=request.getContextPath() %>/JSP/Calendar.jsp'" >일정보기</button>
</div>
<jsp:include page="Footer.jsp"></jsp:include>
<script>
function deletesch(){
	var result = confirm("정말 지우시겠습니까");
	if(result){
		location = '<%=request.getContextPath() %>/ReserveController?command=delete&seq=<%=dto.getSeq()%>';
	}else{
		return
	}
}
function updatesch(){
	var result = confirm("정말 변경하시겠습니까");
	if(result){
		location = '<%=request.getContextPath() %>/ReserveController?command=update&seq=<%=dto.getSeq()%>';
	}else{
		return
	}
}
<%-- console.log(<%=dto.getId()%>);
console.log(<%=loginmember.getId() %>); --%>

if('<%=dto.getId()%>' !== '<%=idcheck %>'){
	var up = document.getElementById("update");
	var del = document.getElementById("delete");
	
	up.setAttribute("disabled", "disabled");
	del.setAttribute("disabled", "disabled");
}

</script>
</body>
</html>