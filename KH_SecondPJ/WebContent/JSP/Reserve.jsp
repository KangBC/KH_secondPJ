<%@page import="Dto.MemberDto"%>
<%@page import="java.time.LocalDateTime"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%-- <link rel="stylesheet" href="<%=request.getContextPath()%>/CSS/form.css"> --%>
<link rel="stylesheet" type="text/css" href="/KH_SecondPJ/CSS/Table.css"/>
<title>Insert title here</title>
</head>
<body>
<%
LocalDateTime now = LocalDateTime.now();
String today = now.toString().substring(0, 10);

response.setContentType("text/html; charset=utf-8");
request.setCharacterEncoding("utf-8");

MemberDto dto = (MemberDto)session.getAttribute("kh_member");
%>
<jsp:include page="Header.jsp"></jsp:include>

	<!--  최상단 이미지 부분 -->
	<div class="img">
		<!-- img_위에 망 덮어씌움  이유 : 이미지가 색이 강력크 .. ㅋㅌ 방지용  -->
		<div class="img-cover"></div>
	</div>


	<div class="outer-container">
		<h2>Reserve</h2>
		<br>

		<form
			action="<%=request.getContextPath() %>/ReserveController?command=reserve"
			method="post">
			<div class="inner-container">
				<table border="0" style="border-collapse: collapse">
					<col width="100">
					<col width="920">
					<tr>
						<td>이름</td>
						<td><input type="text" class="input_data" name="title"
							readonly value="<%=dto.getName() %>"
							style="padding-left: 2px; border: 0;"></td>
					</tr>

					<tr>
						<td>일자</td>
						<td><input type="date" class="input_data" name="date"
							value='<%=today %>' id="date" style="width: 170px; border: 0;"></td>
					</tr>

					<tr>
						<td>시간</td>
						<td><select class="input_data" name="time" required>
								<option value="0900">9:00 AM</option>
								<option value="1100">11:00 AM</option>
								<option value="1400">2:00 PM</option>
								<option value="1600">4:00 PM</option>
						</select></td>
					</tr>
					<tr style="border-bottom: 0;">
						<td style="vertical-align: top; padding-top: 8px;">내용</td>
						<td style="padding-top: 8px;"><textarea class="input_data"
								rows="4" cols="50" name="content" required
								style="width: 90%; height: 500px;"></textarea></td>
					</tr>

				</table>
			</div>
			<hr>
			<input type="submit"  class="mainbut" value="예약하기">
			<button type="button" class="mainbut"
				onclick="location='<%=request.getContextPath() %>/JSP/Calendar.jsp'">일정보기</button>
		</form>

		<%-- <div class="form-style-5">
<form>
<fieldset>
<legend><span class="number">1</span> 회원 정보 </legend>
<input type="text" name="name"  value="<%=dto.getName() %>" readonly>
<input type="date" name="date" value='<%=today %>' id="date">
<textarea name="field3" placeholder="About yourself"></textarea>
<label for="job">Interests:</label>

<select id="job" name="time">
<option value="0900">9:00 AM</option>
<option value="1100">11:00 AM</option>
<option value="1400">2:00 PM</option>
<option value="1600">4:00 PM</option>
</select>      

</fieldset>
<fieldset>
<legend><span class="number">2</span> Additional Info</legend>
<textarea name="field3" placeholder="About Your School"></textarea>
</fieldset>
<input type="submit" value="Apply" />
</form>
</div>
 --%>

	</div>
	<jsp:include page="Footer.jsp"></jsp:include>

</body>
</html>