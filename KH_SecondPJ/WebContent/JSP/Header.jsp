<%@page import="Dao.MemberDao"%>
<%@page import="Dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
  
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

</head>
<body >

 <%
	MemberDao dao = MemberDao.getInstance();

	HttpSession memberSession = request.getSession(false);
	MemberDto member = (MemberDto)memberSession.getAttribute("kh_member");
	if(member != null){
		member = dao.getMember(member.getId());
	}
%> 

<nav class="navbar navbar-inverse"> 

  <div class="container-fluid"><!-- 컨테이너 값이 전체화면을 쓴다는 속성, width값이 100% -->

    <div class="navbar-header">

      <a class="navbar-brand" href="#">KH_WEDDING</a> <!--네비게이션 제목 -->

    </div>

    <div>

      <ul class="nav navbar-nav">

        <li class="active"><a href="<%=request.getContextPath()%>/JSP/About.jsp">About Us</a></li> <!-- li속성에 active값을 주면 실행된 값이 보임 -->

		<li><a href="<%=request.getContextPath()%>/JSP/Contact.jsp">Contact Us</a></li>

        <li><a href="#">Gallary</a></li>

        <li><a href="<%=request.getContextPath()%>/JSP/Calendar.jsp">Calendar</a></li>

        <li><a href="<%=request.getContextPath()%>/PdsController?command=list">Pds</a></li>

        <li><a href="<%=request.getContextPath()%>/QAController?command=list">QA</a></li>

      </ul>

    </div>

	<div class="" style="float: right">
	<ul class="nav navbar-nav">
 	<%if(member != null)	{%>
		<li><a href="<%=request.getContextPath()%>/JSP/MyInfo.jsp">내 정보</a></li>
		<li><a href="<%=request.getContextPath()%>/JSP/Contact.jsp">로그아웃</a></li>	<!-- 세션 파괴 작업 필요 -->
		<%}else{
		%>
			<li><a href="<%=request.getContextPath()%>/JSP/Login.jsp">로그인</a></li>
		<%}%>
	</ul>
	
	</div>
  </div>

</nav>

</body>
</html>