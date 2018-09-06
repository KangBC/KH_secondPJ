<%@page import="Dto.MemberDto"%>
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
<td><input type="date" name="date" value='<%=dateori %>' readonly><%=timeori %>시</td>
</tr>

<tr>
<th>신청시간</th>
<td><%=dto.getWdate()%></td>
</tr>

<tr>
<th>내용</th>
<td><textarea rows="4" cols="50" readonly><%=dto.getContent() %></textarea></td>
</tr>

</table>

<button id="update" type="button" onclick="updatesch()">예약변경</button>
<button id="delete" type="button" onclick="deletesch()">예약취소</button>
<button type="button" onclick="location='<%=request.getContextPath() %>/JSP/Calendar.jsp'" >일정보기</button>


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