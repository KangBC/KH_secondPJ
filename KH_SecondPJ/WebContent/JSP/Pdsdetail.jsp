<%@page import="Dto.MemberDto"%>
<%@page import="Dto.PdsDto"%>
<%@page import="Dao.PdsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<%=request.getContextPath()%>/CSS/Table.css" rel="stylesheet">
<title>Pdsdetail</title>
</head>
<body>


<%
MemberDto mdo =(MemberDto) session.getAttribute("kh_member");
boolean idcheck = false;
String idstr = "";

if(mdo != null){
	idcheck = true;
	idstr = mdo.getId();
}

String wk =request.getParameter("seq");
int pdsid=Integer.parseInt(wk);
PdsDao dao = PdsDao.getInstance();

dao.pdsReadCount(pdsid);
PdsDto dto =dao.getPDS(pdsid); 
%>
<jsp:include page="../JSP/Header.jsp"></jsp:include>
<!--  최상단 이미지 부분 -->
	<div class="img">
		<!-- img_위에 망 덮어씌움  이유 : 이미지가 색이 강력크 .. ㅋㅌ 방지용  -->
		<div class="img-cover"></div>
	</div>
	
	<div style="width: 1020px; margin: 50px auto 30px; text-align: center;">
		<h2 style="font-size: 1.5em; font-weight: 680;"> Pdsdetail </h2>
	</div>


<div class="outer-container">
<form action="../PdsController?command=detailPds" method="post">
<div class="inner-container">
<table border="0" style="border-collapse: collapse;">
<col width="100">
<col width="920">

<tr>
	<td>작성자</td>
	<td style="text-align: left; padding-left: 10px;"><%=dto.getId() %></td>
</tr>

<tr>
	<td>제목</td>
	<td style="text-align: left; padding-left: 10px;"><%=dto.getTitle() %></td>
</tr>

<tr>
	<td>작성일</td>
	<td style="text-align: left; padding-left: 10px;"><%=dto.getRegdate() %></td>
</tr>

<tr>
	<td>다운로드</td>
	<td><input type="button" name="btndown" value="<%=dto.getFilename() %>" style="float: left; margin-left: 10px;" 
	onclick="location='<%=request.getContextPath() %>/PdsController?command=download&filename=<%=dto.getFilename()%>&seq=<%=dto.getSeq()%>'"></td>
</tr>



<tr style="border-bottom: 0;">
	<td style="vertical-align: top; padding-top: 8px;">내용</td>
	<td><textarea class="input_data" name="content" style="width: 90%; height: 500px; outline: none" readonly="readonly"><%=dto.getContent() %></textarea></td>
</tr>


</table>
</div>
</form>

<form action="<%=request.getContextPath()%>/PdsController" method="post">
<input type="hidden" name="command" value="delete">
<input type="hidden" name="seq" value="<%=dto.getSeq()%>">
<input   class="mainbut" id="delete" type="submit" value="삭제">
<button  class="mainbut" id="update" type="button" onclick="location.href = '<%=request.getContextPath()%>/JSP/Pdsupdate.jsp?seq=<%=dto.getSeq()%>'" >수정하기</button>
</form>


</div>

<jsp:include page="../JSP/Footer.jsp"></jsp:include>
<script>
var del = document.getElementById("delete");
var up = document.getElementById("update");


if(<%=!idcheck %> || '<%=idstr %>' !== '<%=dto.getId()%>'){
	del.setAttribute("disabled", "disabled");
	up.setAttribute("disabled", "disabled");
}
</script>

</body>
</html>


















