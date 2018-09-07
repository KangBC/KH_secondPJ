<%@page import="Dto.QADto"%>
<%@page import="java.util.*"%>
<%@page import="Dao.QADao"%>
<%@page import="Dto.MemberDto"%>

<%
	String findword = request.getParameter("findword");
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<jsp:include page="Header.jsp"></jsp:include>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>


<head>
<link href="<%=request.getContextPath() %>/CSS/QAList.css" rel="stylesheet">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
 


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>QAList</title>

</head>
<body>
	<%!// 댓글!!
	public String arrow(int depth) {

		String rs = "<img src='img/arrow.png' width='20px' height='20px'/>";
		String nbsp = "&nbsp;&nbsp;&nbsp;&nbsp;"; // depth의 간격
		String ts = "";

		for (int i = 0; i < depth; i++) {
			ts += nbsp;
		}
		return depth == 0 ? "" : ts + rs;
	}
	%>

	<%  
	  	MemberDto mem = (MemberDto)session.getAttribute("kh_member");
	     boolean idcheck = true;
	  	 if(mem == null){
			idcheck = false;
	  	}
	 
		QADao dao = QADao.getInstance();
 		List<QADto> QAlist = (List<QADto>)request.getAttribute("list");	
 		
 		String totalstr = (String)request.getAttribute("count"); //
 		int total = 0;
 		String currstr = (String)request.getAttribute("currentPage");
 		int curr = 0;
 		
 		String searchmode = (String)request.getAttribute("search");
 		String searchstr = (String)request.getAttribute("str");
 		int searchint = 0;
 		if(searchmode != null){
 			searchint = Integer.parseInt(searchmode);
 		}
 		
 		if(totalstr != null){
 			total = Integer.parseInt(totalstr);
 		}
 		if(currstr != null){
 			curr = Integer.parseInt(currstr);
 		}
 		int pagenums = 0;
 		//page 번호
 		if(total%10 == 0){
 			pagenums = total/10;
 		}else{
 			pagenums = total/10 +1;
 		}
 		
 		
 		int[] pagenumbers = new int[9];
 		
 		boolean dotbefore = true;
 		boolean dotafter = true;
 		
 		if(pagenums <= 9){
 			dotbefore = false;
 			dotafter = false;
 			for(int i =0; i < pagenums; i++){
 				pagenumbers[i] = i+1;
 			}
 		}else if(curr - 1 <= 4 ){
 			// 1234 56789
 		      for(int i = 0; i < 9; i++){
 		         pagenumbers[i] = i+1;
 		      }
 		      dotbefore = false;
 		 }else if(pagenums - curr <= 4){
 			// ..   34 56789 10 11 12
 		      int j = 8;
 		      
 		      for(int i = 0; i < 9; i++){
 		         pagenumbers[i] = pagenums - j;
 		         j--;
 		      }
 		      dotafter= false;
 		 }else{
 		      int j = -4;
 		      for(int i = 0; i < 9; i++){
 		    	 
 		         pagenumbers[i] = curr + j;
 		         j++;
 		      }
 		 }
 					
 	%>
	<!--  최상단 이미지 부분 -->
	<div class="img">
		<div class="content">
			<div>
				<p class="p">텍스트창</p>
			</div>
		</div>

		<div class="img-cover"></div>
	</div>

	<!-- 게시판 table -->
	<div align="center">

		<table class="table">

			<col width="50">
			<col width="100">
			<col width="200">
			<col width="50">
			<col width="100">
			<col width="80">

			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">제목</th>
					<th scope="col">내용</th>
					<th scope="col">작성자</th>
					<th scope="col">날자</th>
					<th scope="col">조회수</th>
				</tr>
			</thead>


			<%
				if (QAlist == null || QAlist.size() == 0) {
			%>

			<tr>
				<td colspan="3">작성된 글이 없습니다</td>
			</tr>


			<%
				}else{
				
				int Articlenumber = 0; //글번호
				
				for (int i = 0; i < QAlist.size(); i++) {
					QADto QAbbs = QAlist.get(i);
					
					//삭제
					if(QAbbs.getDel() == 0){
						Articlenumber++;
			%>
			<tr>
				<td><%=QAbbs.getRownum()%></td>
				<td><%=arrow(QAbbs.getDepth())%> <a
					href="./JSP/QADetail.jsp?seq=<%=QAbbs.getSeq()%>"> <%=QAbbs.getTitle()%>
				</a></td>
				<td><%=QAbbs.getContent()%></td>
				<td><%=QAbbs.getId()%></td>
				<td><%=QAbbs.getWdate() %></td>
				<td><%=QAbbs.getReadcount()%></td>

			</tr>

			<%
					}
				}
			}
			%>

		</table>
	</div>
	<div style="text-align: center;">
		<%
	String link = "";
	
	if(searchint == 0){
		link = request.getContextPath()+"/QAController?command=list&searchfor=0&pageNum=";
	}else if(searchint == 1){
		link = request.getContextPath()+"/QAController?command=list&searchfor=1&findword="+ searchstr +"&pageNum=";
	}else if(searchint == 2){
		link = request.getContextPath()+"/QAController?command=list&searchfor=2&findword="+ searchstr +"&pageNum=";
	}else if(searchint == 3){
		link = request.getContextPath()+"/QAController?command=list&searchfor=3&findword="+ searchstr +"&pageNum=";
	}
	System.out.println(link);
	%>
		<a href="<%=link%>1">첫페이지</a>
		<c:if test="<%=dotbefore %>">..</c:if>

		<%
	for(int i = 0; i < 9; i++){
		if(pagenumbers[i] != 0){
			if(pagenumbers[i] == curr){
				%>
		<font color="red"><%=pagenumbers[i] %></font>
		<%
			}else{
				%>
		<a href="<%=link %><%=pagenumbers[i]%>"> <%=pagenumbers[i] %></a>
		<%
			}
		}
	}
	%>

		<c:if test="<%=dotafter %>">..</c:if>
		<a href="<%=link%><%=pagenums%>">마지막페이지</a>

	</div>

	<br>
	<br>
	<div align="center">
		<!-- 게시판 테이블 기능 -->
		<button onclick="QAwrite()">글쓰기</button>

		<br> <br>

		<div class="inner">
			<!-- 검색 -->
			<div class="search_form">
				<fieldset>
					<legend>게시판 검색폼</legend>
					<div class="inner">
						<select class="slct w100" id="searchbox" name="searchbox">

							<option value="0">전체보기</option>
							<option value="1">작성자</option>
							<option value="2">제목</option>
							<option value="3">내용</option>
						</select> <input type="text" class="txt w100" id="search" name="search"
							maxlength="20"> <span class="btn btnC_04 btnP_04">
							<button id="searchQA" name="searchQA" onclick="searchQA()">검색</button>
						</span>
					</div>
				</fieldset>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		function searchQA() {
			var sel = document.getElementById("searchbox");
			var searchfor = sel.options[sel.selectedIndex].value;
			
			var msg = document.getElementById("search").value;
			location.href = "./QAController?command=list&searchfor="+searchfor + "&findword=" + msg ;
		
		}
		//글쓰기
		function QAwrite() {
			var idcheck = <%=idcheck%>;
			if (idcheck) {
				var result = confirm("글쓰기를 작성합니다.");
				
				if(result){
					location = "<%=request.getContextPath()%>/JSP/QAwrite.jsp";
				}else{
					return
				}
			}else{
				alert('로그인을 해주세요.');
			    return;
			}
		}
	</script>


	<jsp:include page="Footer.jsp"></jsp:include>

</body>

</html>