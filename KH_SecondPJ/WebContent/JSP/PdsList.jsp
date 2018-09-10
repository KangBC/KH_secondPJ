<%@page import="Dto.MemberDto"%>
<%@page import="Dao.MemberDao"%>
<%@page import="Dao.PdsDao"%>
<%@page import="Dto.PdsDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>PdsList</title>
</head>
<body>
<jsp:include page="Header.jsp"></jsp:include>
<%
	List<PdsDto> pdslist = (List<PdsDto>)request.getAttribute("pdslist");

	String search = request.getParameter("mode");
	String searchstr = request.getParameter("str");
	String optionstr = request.getParameter("option");
	int option = 0;
	if(optionstr != null){
		option = Integer.parseInt(optionstr);
	}

	String totalstr = (String)request.getAttribute("total");
	int total = 0;
	if(totalstr != null){
		total = Integer.parseInt(totalstr);
	}
	
	String currstr = (String)request.getAttribute("currpage");
	int curr = 0;
	if(currstr != null){
		curr = Integer.parseInt(currstr);
	}
	
	
	int pagenums = 0;
	
	if(total%10 == 0){
			pagenums = total/10;
		}else{
			pagenums = total/10 +1;
		}
	
	System.out.println("" + total + " "+ curr + " " + pagenums);
	
	int[] arr = new int[5];
	
	//보통 앞에 두개 뒤에 두갠데
	//그게 없을경우 앞에 하나더 ㄱ
	
	boolean dotbefore = true;
	boolean dotafter = true;
	
	//페이지 전후로 점점이 있냐 없냐
	if(pagenums <= 5){
		dotbefore = false;
		dotafter = false;
		for(int i =1; i <= pagenums;i++){
			arr[i-1] = i;
		}
	}else if(curr - 1 <= 2 ){
		for(int i = 0; i < 5; i++){
			arr[i] = i+1;
		}
		dotbefore = false;
	}else if(pagenums - curr <= 2){
		int j = 4;
		
		for(int i = 0; i < 5; i++){
			arr[i] = pagenums - j;
			j--;
		}
		dotafter= false;
	}else{
		int j = -2;
		for(int i = 0; i < 5; i++){
			arr[i] = curr + j;
			j++;
		}
	}
	
	
	for(int i = 0; i < 5; i++){
		System.out.println(arr[i]);
	}
	
	// 12345      56789
		
		
	

	MemberDao dao = MemberDao.getInstance();

	HttpSession memberSession = request.getSession(false);
	MemberDto member = null;
	if(memberSession!=null){
		member = (MemberDto)memberSession.getAttribute("kh_member");
	}
	
	boolean c_login = false;
	if(member != null){
		c_login = true;
	}
%> 


	<h3>자료실!</h3>

	<div align="center">
		<form action="PdsController" method="post">
			<input type="hidden" name="command" value="muldel">
			<table border="1">
				<col width="50">
				<col width="100">
				<col width="400">
				<col width="100">
				<col width="100">
				<col width="100">

				<tr bgcolor="pink">
					<th>번호</th>
					<th>작성자</th>
					<th>제목</th>
					<th>조회수</th>
					<th>작성일</th>
				</tr>

				<%
					if (pdslist == null || pdslist.size() == 0) {
				%>
				<tr>
					<td colspan="3">작성된 글이 없습니다</td>
				</tr>

				<%
					}
					int Articlenumber = 0; //글번호

						for (int i = 0; i < pdslist.size(); i++) {
							PdsDto pds = pdslist.get(i);

				%>

				<tr align="center" height="10">
					<td><%=pds.getDel()%></td>
					<td><%=pds.getId()%></td>
					<td><a href="<%=request.getContextPath() %>/JSP/Pdsdetail.jsp?seq=<%=pds.getSeq()%>"> <%=pds.getTitle()%>
					</a></td>

					<td><%=pds.getReadcount()%></td>
					<td><%=pds.getRegdate()%></td>

				</tr>
				<%

					}
				%>
			</table>
			<div id=page style="text-align: center;">
			
			
			<%
			String link = "";
			if(search != null){
				link = request.getContextPath() + "/PdsController?command=search&str=" + searchstr +"&option=" + option + "&pagenumber=";
			}else{
				link = request.getContextPath() + "/PdsController?command=list&pagenumber=";
			}
			%>
			<a href="<%=link%>1">첫페이지</a>
			<c:if test="<%= dotbefore %>">..</c:if>
			<%
			for(int i = 0; i < 5; i++){
				if(arr[i] != 0){
					if(curr == arr[i]){
						%>
						<font size="3" color="red"><%=arr[i]%></font>
						<%
					}else{

					%>
					<a class="pages" href="<%=link%><%=arr[i]%>" ><%=arr[i]%></a>
					<%
					}
				}
			}
			%>
	        
	        

			
			<c:if test="<%= dotafter %>">..</c:if>
			<a href="<%=link%><%=pagenums%>">마지막페이지</a>
			</div>


			<a onclick="return ck_login()" href="<%=request.getContextPath() %>/JSP/Pdswrite.jsp">자료 올리기</a> 
			<br> <br> 
 			<select id="option">
			<option value="0">전체보기</option>
			<option value="1">아이디</option>
			<option value="2">제목</option>
			</select>
			<input type="text" id="search">
			
			<button type="button" name="search" onclick="srch()">검색</button> 
		</form>
	</div>
	
	<%
	if(search != null){
		%>
		<h1><%=option==1?"아이디: ":"제목: " %> <%= searchstr %>로 검색한 결과입니다.</h1>
		
		<%
	}
	%>
	
 	<script>
	function srch(){
		var search = document.getElementById("search");
		var option = document.getElementById("option");
		var str = "<%=request.getContextPath() %>/PdsController?command=search&str=" + search.value + "&option="+option.value;
		
		location = str;
	}
	
	function ck_login(){
		if(<%=c_login%>){
			return true;
		}else{
			alert("로그인해주세요");
			return false;
		}
	}
	</script> 
	</body>
</html>