<%@page import="Dto.MemberDto"%>
<%@page import="Dto.ReserveDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
List<ReserveDto> list = (List<ReserveDto>)request.getAttribute("mylist");

int size = list.size();

response.setCharacterEncoding("utf-8");


MemberDto loginmember = (MemberDto)session.getAttribute("kh_member");
String idcheck = null;
if(loginmember != null){
	idcheck = loginmember.getId();
}
%>

<jsp:include page="Header.jsp"></jsp:include>



<!DOCTYPE html>
<html>
<head>

<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/notosanskr.css);
.slides{
width: 100%;
} 
</style>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" type="text/css" href="/KH_SecondPJ/CSS/Table.css"/>
<title>Insert title here</title>
</head>
<body>
<div style="width:1020px; margin: 50px auto 10px; text-align: center;">


<button class="w3-button w3-display-left" onclick="plusDivs(-1)" style="top:50%; left: 16%">&#10094;</button>
<button class="w3-button w3-display-right" onclick="plusDivs(+1)" style="top:50%; right: 16%">&#10095;</button>


<%
if(size == 0){
	%>
	<p>예약된 일정이 없습니다.</p>
	<%
}else{
	for(int i =0; i < size;i++){
		ReserveDto dto = list.get(i);
		System.out.println(dto.getRdate());

		String dateori = dto.getRdate().substring(0, 4) + "-"+ dto.getRdate().substring(4, 6)+ "-"+  dto.getRdate().substring(6, 8);
		String timeori = dto.getRdate().substring(8, 10)+":"+dto.getRdate().substring(10, 12);

	%>
		<div class="slides outer-container">
		<h2>상담예약 확인</h2>
		<hr><br>
		
		<div class="inner-container">
		<table border="0" style="border-collapse:collapse;">
		<col width="100"><col width="920">
		<tr>
		<th>신청인</th>
		<td><input type="text" class="input_data" value="<%=dto.getId() %>" readonly></td>
		</tr>
		
		<tr>
		<th>예정시간</th>
		<td><input type="text" class="input_data" name="date" value='<%=dateori %> <%=timeori %>시' readonly></td>
		</tr>
		
		<tr>
		<th>신청시간</th>
		<td><input type="text" class="input_data" name="date" value='<%=dto.getWdate()%>' readonly></td>
		</tr>
		
		<tr style="border-bottom: 0;">
		<th style="vertical-align: top; padding-top: 8px;">내용</th>
		<td style="padding-top: 8px;">
		<textarea class="input_data" rows="4" cols="50" style="width: 90%; height:400px;" readonly><%=dto.getContent() %></textarea>
		</td>
		</tr>
		
		</table>
		</div>
		<hr>
		<button id="update" type="button" onclick="updatesch(<%=dto.getSeq() %>)">예약변경</button>
		<button id="delete" type="button" onclick="deletesch(<%=dto.getSeq() %>)">예약취소</button>
		<button type="button" onclick="location='<%=request.getContextPath() %>/JSP/Calendar.jsp'" >일정보기</button>
		</div>
		
		
		<%
	}
	for(int i = 0; i<size;i++){

		%>
		<button class="btns"  onclick="showDivs2(<%=i%>)"><%=i+1 %></button>
		<%
	}
	
}
%>
</div>



<script type="text/javascript">
function deletesch(seq){
	var result = confirm("정말 지우시겠습니까");
	if(result){
		location = '<%=request.getContextPath() %>/ReserveController?command=delete&seq='+seq;
	}else{
		return
	}
}
function updatesch(seq){
	var result = confirm("정말 변경하시겠습니까");
	if(result){
		location = '<%=request.getContextPath() %>/ReserveController?command=update&seq='+seq;
	}else{
		return
	}
}

var slideIndex = 1;
showDivs(slideIndex);

function plusDivs(n) {

    showDivs(slideIndex += n);
}

function showDivs(n) {
    var i;
    var x = document.getElementsByClassName("slides");
    var btns = document.getElementsByClassName("btns");
    if (n > x.length) {slideIndex = 1} ;
    if (n < 1) {slideIndex = x.length} ;
    for (i = 0; i < x.length; i++) {
        x[i].style.display = "none"; 
        btns[i].style.borderStyle ="outset";
    }
    console.log(slideIndex-1);
    x[slideIndex-1].style.display = "block"; 
    btns[slideIndex-1].style.borderStyle ="inset";
    
}

function showDivs2(index) {
	console.log("showdiv2" +index);
	slideIndex = index + 1;
    var i;
    var x = document.getElementsByClassName("slides");
    var btns = document.getElementsByClassName("btns");
    for (i = 0; i < x.length; i++) {
        x[i].style.display = "none"; 
        btns[i].style.borderStyle ="outset";
    }
    x[index].style.display = "block"; 
    btns[index].style.borderStyle ="inset";
}
</script>

</body>
</html>