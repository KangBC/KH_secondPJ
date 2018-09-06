<%@page import="Dto.QADto"%>
<%@page import="java.util.*"%>
<%@page import="Dao.QADao"%>
<%@page import="Dto.MemberDto"%>

<%
	String findword = request.getParameter("findword");
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

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

		String rs = "<img src='image/arrow.png' width='20px' height='20px'/>";
		String nbsp = "&nbsp;&nbsp;&nbsp;&nbsp;"; // depth의 간격
		String ts = "";

		for (int i = 0; i < depth; i++) {
			ts += nbsp;
		}

		return depth == 0 ? "" : ts + rs;
	}%>

<jsp:include page="Header.jsp"></jsp:include>	

	  <%  
	  	MemberDto mem = (MemberDto)session.getAttribute("kh_member");
	     boolean idcheck = true;
	  	 if(mem == null){
			idcheck = false;
	  	}
	 
		QADao dao = QADao.getInstance();
		List<QADto> QAlist = (List<QADto>)request.getAttribute("QAList");
		
 	%> 

	<div align="center">
		<table class="table table-hover">
			
			<col width="50">
			<col width="100">
			<col width="200">
			<col width="50">
			<col width="100">
			<col width="50">

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
				<td><%=Articlenumber%></td>
				<td><%=arrow(QAbbs.getDepth())%>  
				<a href="./JSP/QADetail.jsp?seq=<%=QAbbs.getSeq()%>"> <%=QAbbs.getTitle()%>
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
<br>
<br>
	<div align="center">
		<!-- 게시판 테이블 기능 -->
			<button onclick="QAwrite()">글쓰기</button>
		
		<br><br> 
		
		<div class="inner">
		<!-- 검색 -->
		<div class="search_form">
				<fieldset>
					<legend>게시판 검색폼</legend>
					<div class="inner">
						<select class="slct w100" id="searchbox" name="searchbox">
							<option value="1">작성자</option>
							<option value="2">제목</option>
							<option value="3">내용</option>
						</select>
						<input type="text" class="txt w100" id="search" name="search" maxlength="20" >
						<span class="btn btnC_04 btnP_04">
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
			location.href = "./QAController?command=list&searchfor="+searchfor + "&findword=" + msg;
		
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

</body>

</html>