<%@page import="Dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;  charset=EUC-KR">

<link href="<%=request.getContextPath()%>/CSS/Table.css" rel="stylesheet">

<title>QAwrite</title>

</head>

<body>

	<%
		Object ologin = session.getAttribute("kh_member");
		MemberDto mem = null;
		mem = (MemberDto) ologin;
	%>

	<jsp:include page="Header.jsp"></jsp:include>

	<!--  최상단 이미지 부분 -->
	<div class="img">
		<!-- img_위에 망 덮어씌움  이유 : 이미지가 색이 강력크 .. ㅋㅌ 방지용  -->
		<div class="img-cover"></div>
	</div>

	<div class="outer-container">

	<div style="width: 1020px; margin: 50px auto 30px; text-align: center;">
		<h2 style="font-size: 1.5em; font-weight: 680;">Q&A write</h2>
	</div>

		<br>
		<form
			action="<%=request.getContextPath()%>/QAController?command=regist_add"
			method="post">

			<div class="inner-container">
				<table border="0" style="border-collapse: collapse">
					<col width="100">
					<col width="920">
					<tr>
						<td>이름</td>
						<td><input type="text" class="input_data" name="id" readonly
							value="<%=mem.getId()%>" style="padding-left: 2px; border: 0; "></td>
					</tr>

					<tr>
						<td>제목</td>
						<td><input type="text" class="input_data" name="title"
							placeholder="제목을 입력하세요. " required id="title"
							style="width: 170px;"></td>
					</tr>

					<tr style="border-bottom: 0;">

						<td style="vertical-align: top; padding-top: 8px;">내용</td>
						<td style="padding-top: 8px;"><textarea class="input_data"
								id="content" name="content" rows="4" cols="50"
								placeholder="내용을 입력하세요." required
								style="width: 90%; height: 500px;"></textarea></td>

					</tr>
				</table>

			</div>
			<div align="center">
				<tr>
					
					<td colspan="2"><input type="submit" value="등록" class="mainbut" /> 
						
						<input type="button" value="글 목록 " class="mainbut"
						onclick="javascript:location.href='<%=request.getContextPath()%>/QAController?command=list&searchfor=0'" />
					</td>
				</tr>
			</div>
		</form>
	</div>

	<!-- Footer -->
	<jsp:include page="Footer.jsp"></jsp:include>

</body>
</html>
