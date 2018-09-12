<%@page import="Dao.MemberDao"%>
<%@page import="Dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
  
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="/KH_SecondPJ/CSS/Nav.css"/>
<link href="<%=request.getContextPath()%>/CSS/mainbutton.css" rel="stylesheet">

<!-- 검색창 밑 backgraund_img.css -->
<link href="<%=request.getContextPath()%>/CSS/QAList.css" rel="stylesheet">

<style type="text/css">

</style>
</head>
<body style="margin: 0;">

 <%
	MemberDao dao = MemberDao.getInstance();

	HttpSession memberSession = request.getSession(false);
	MemberDto member = null;
	if(memberSession!=null){
		member = (MemberDto)memberSession.getAttribute("kh_member");
	}else{
		
	}
%> 


<div id="nav_outer_container" >
<div id="nav_inner_container" >
	<div id="main_nav" >

		<a href="<%=request.getContextPath()%>/JSP/SUB_Welcome.jsp" style="font-size: 20px;">KH_WEDDING</a> <!--네비게이션 제목 -->

	</div>

	<div id="page_nav">

		<ul id="page_list">

			<li><a href="<%=request.getContextPath()%>/JSP/About.jsp">About Us</a></li> 

			<li><a href="<%=request.getContextPath()%>/JSP/Gallery.jsp">Gallery</a></li>
	
	        <li><a href="<%=request.getContextPath()%>/JSP/Calendar.jsp">상담 신청</a></li>
	
	        <li><a href="<%=request.getContextPath()%>/PdsController?command=list">자료 올리기</a></li>

			<li><a href="<%=request.getContextPath()%>/QAController?command=list&searchfor=0">QA</a></li>

			<li><a href="<%=request.getContextPath()%>/JSP/Contact.jsp">Contact Us</a></li>
		</ul>

	</div>

	<div id="member_nav" style="float: right; display: inline-block; margin-top: 15px;">
	<ul style="margin: 16px 0 16px 0">
 	<%if(member != null)	{%>
		<li style="margin-left: 0;"><a href="<%=request.getContextPath()%>/JSP/MyInfo.jsp">내 정보</a></li>
		<li><a onclick="logout()" style="cursor: pointer; margin: 0">로그아웃</a></li>
		<%}else{
		%>
			<li><a href="<%=request.getContextPath()%>/JSP/Login.jsp">로그인</a></li>
		<%}%>
	</ul>
	
	</div>
  </div>
</div>
<script type="text/javascript">
function logout() {
	$.ajax({
		url : "/KH_SecondPJ/MemberController?command=logout",
	    type:"get",
	    success : function(){
			alert("로그아웃되었습니다.");
			location.href="<%=request.getContextPath()%>/JSP/About.jsp";
	    },
	    error: function(xhr , status){
	    	alert(xhr + " : " + status)
	    }
	});
	
}

</script>
</body>
</html>