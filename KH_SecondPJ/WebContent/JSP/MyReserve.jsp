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
<link rel="stylesheet" href="/KH_SecondPJ/CSS/w3.css">
<link rel="stylesheet" type="text/css" href="/KH_SecondPJ/CSS/Table.css"/>
<title>MyReserve</title>
</head>
<body>


	<!--  최상단 이미지 부분 -->
	<div class="img">
		<!-- img_위에 망 덮어씌움  이유 : 이미지가 색이 강력크 .. ㅋㅌ 방지용  -->
		<div class="img-cover"></div>
	</div>


<div style="width:1020px; margin: 50px auto 10px; text-align: center; position:relative">
<button class="w3-button w3-display-left" onclick="plusDivs(-1)" style="outline:none; font-size: 20px; color: #555555; padding: 271px 20px;">&#10094;</button>
<button class="w3-button w3-display-right" onclick="plusDivs(+1)" style="outline:none; font-size: 20px; color: #555555; padding: 271px 20px;">&#10095;</button>


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
		<td> <input type="text" class="input_data" value="<%=dto.getId() %>" readonly style="border: 0;"></td>
		</tr>
		
		<tr>
		<th>예정시간</th>
		<td><input type="text" class="input_data" name="date" value='<%=dateori %> <%=timeori %>시' readonly style="border: 0;"></td>
		</tr>
		
		<tr>
		<th>신청시간</th>
		<td><input type="text" class="input_data" name="date" value='<%=dto.getWdate().substring(0, 16 )%>시'  readonly style="border: 0;"></td>
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
		<button  class="mainbut" id="update" type="button" onclick="updatesch(<%=dto.getSeq() %>)">예약변경</button>
		<button  class="mainbut" id="delete" type="button" onclick="deletesch(<%=dto.getSeq() %>)">예약취소</button>
		<button  class="mainbut" type="button" onclick="location='<%=request.getContextPath() %>/JSP/Calendar.jsp'" >일정보기</button>
		</div>
		
		
		<%
	}
	for(int i = 0; i<size;i++){

		%>
		<button class="btns mainbut_page"   onclick="showDivs2(<%=i%>)"><%=i+1 %></button>
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
        btns[i].style.color ="#777777";
    }
    console.log(slideIndex-1);
    x[slideIndex-1].style.display = "block"; 
    btns[slideIndex-1].style.borderStyle ="inset";
    btns[slideIndex-1].style.color ="pink";
    
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
        btns[i].style.color ="#777777";
    }
    x[index].style.display = "block"; 
    btns[index].style.borderStyle ="inset";
    btns[index].style.color ="pink";
}
</script>

<jsp:include page="Footer.jsp"></jsp:include>

</body>
</html>