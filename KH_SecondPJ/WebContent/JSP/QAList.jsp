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
<!-- 글쓰기 버튼 -->
<link
	href='http://fonts.googleapis.com/css?family=Yanone+Kaffeesatz:700'
	rel='stylesheet' type='text/css'>


<!-- bootstrapk table 링크  -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">

<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
	integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
	crossorigin="anonymous"></script>

<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
	integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
	crossorigin="anonymous"></script>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
	integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
	crossorigin="anonymous"></script>

<!-- 검색창 밑 backgraund_img.css -->
<link href="<%=request.getContextPath()%>/CSS/QAList.css"
	rel="stylesheet">

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>QAList</title>

</head>


<body>
	<!-- 댓글!! -->
	<%! public String arrow(int depth) {

		String rs = "<img src='img/arrow.png' width='20px' height='20px'/>";
		String nbsp = "&nbsp;&nbsp;&nbsp;&nbsp;"; // depth의 간격
		String ts = "";

		for (int i = 0; i < depth; i++) {
			ts += nbsp;
		}
		return depth == 0 ? "" : ts + rs;
	} %>


	<!-- mamber Session -->
	<% MemberDto mem = (MemberDto) session.getAttribute("kh_member");
		
		boolean idcheck = true;
		if (mem == null) {
			idcheck = false;
		}

		QADao dao = QADao.getInstance();
		List<QADto> QAlist = (List<QADto>) request.getAttribute("list");

		//Page페이징 
		String totalstr = (String) request.getAttribute("count");
		int total = 0;
		String currstr = (String) request.getAttribute("currentPage");
		int curr = 0;

		String searchmode = (String) request.getAttribute("search");
		String searchstr = (String) request.getAttribute("str");
		int searchint = 0;
		if (searchmode != null) {
			searchint = Integer.parseInt(searchmode);
		}

		if (totalstr != null) {
			total = Integer.parseInt(totalstr);
		}
		if (currstr != null) {
			curr = Integer.parseInt(currstr);
		}
		int pagenums = 0;
		//page 번호
		if (total % 10 == 0) {
			pagenums = total / 10;
		} else {
			pagenums = total / 10 + 1;
		}

		int[] pagenumbers = new int[9];

		boolean dotbefore = true;
		boolean dotafter = true;

		if (pagenums <= 9) {
			dotbefore = false;
			dotafter = false;
			for (int i = 0; i < pagenums; i++) {
				pagenumbers[i] = i + 1;
			}
		} else if (curr - 1 <= 4) {
			// 1234 56789
			for (int i = 0; i < 9; i++) {
				pagenumbers[i] = i + 1;
			}
			dotbefore = false;
		} else if (pagenums - curr <= 4) {
			// ..   34 56789 10 11 12
			int j = 8;

			for (int i = 0; i < 9; i++) {
				pagenumbers[i] = pagenums - j;
				j--;
			}
			dotafter = false;
		} else {
			int j = -4;
			for (int i = 0; i < 9; i++) {

				pagenumbers[i] = curr + j;
				j++;
			}
		}%>

	<!--  최상단 이미지 부분 -->
	<div class="img">
		<div class="content">
			<!-- 검색 -->
			<div class="inner_MAIN">
				<div class="search_form">
					<div class="botton_main">
						<!-- butt -->

						<fieldset>
							<div class="inner_SUB">
								<select class="search_Group" id="searchbox" name="searchbox">
									<option value="0">전체보기</option>
									<option value="1">작성자</option>
									<option value="2">제목</option>
									<option value="3">내용</option>
								</select> <input type="text" class="text_1" id="search" name="search"
									maxlength="20">

								<div class="button-row">
									<div>
										<a id="searchQA" name="searchQA" onclick="searchQA()"
											title="검색"> </a>
									</div>
								</div>
							</div>
					</div>
					</fieldset>
				</div>
			</div>
		</div>

		<!-- img_위에 망 덮어씌움  이유 : 이미지가 색이 강력크 .. ㅋㅌ 방지용  -->
		<div class="img-cover"></div>
	</div>

	<!-- 게시판 table -->
	<div style="min-height: 220px" align="center">
		<table class="table">

			<col width="10">
			<col width="200">
			<col width="300">
			<col width="100">
			<col width="150">
			<col width="10">
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


			<%	/* List 사이즈 정의 */
				if (QAlist == null || QAlist.size() == 0) {
			%>

			<tr>
				<td colspan="3">작성된 글이 없습니다</td>
			</tr>


			<%
				} else {

					int Articlenumber = 0; //글번호(삭제,글 나타나기 선언 객체)
					
					/* List 뿌려주기  */
					for (int i = 0; i < QAlist.size(); i++) {
					     QADto QAbbs = QAlist.get(i);

						//삭제
						if (QAbbs.getDel() == 0) {
							Articlenumber++;
			%>

			<tr>
				<td><%=QAbbs.getRownum()%></td>
				<td><a style="text-decoration: none;"
					href="./JSP/QADetail.jsp?seq=<%=QAbbs.getSeq()%>"> <%=QAbbs.getTitle()%>
				</a> re:<%=QAbbs.getStep() %></td>
				<td><%=QAbbs.getContent()%></td>
				<td><%=QAbbs.getId()%></td>
				<td><%=QAbbs.getWdate()%></td>
				<td><%=QAbbs.getReadcount()%></td>
			</tr>

			<%
						}
					}
				}
			%>

		</table>
	</div>

	<!-- 글쓰기 버튼  -->
	<div align="center">
		<div class="border_Button">
			<a style="text-decoration: none;" href="#" onclick="QAwrite()">글쓰기</a>
		</div>
	</div>

	<!-- Page페이징 글자 표기 view -->
	<div style="text-align: center;">
		<%
			String link = "";

			if (searchint == 0) {
				link = request.getContextPath() + "/QAController?command=list&searchfor=0&pageNum=";
			} else if (searchint == 1) {
				link = request.getContextPath() + "/QAController?command=list&searchfor=1&findword=" + searchstr
						+ "&pageNum=";
			} else if (searchint == 2) {
				link = request.getContextPath() + "/QAController?command=list&searchfor=2&findword=" + searchstr
						+ "&pageNum=";
			} else if (searchint == 3) {
				link = request.getContextPath() + "/QAController?command=list&searchfor=3&findword=" + searchstr
						+ "&pageNum=";
			}
		%>

		<img id="pageimg" src="./img/Page_left-arrow_1.png" alt="이미지없음"
			class="btn" onclick="location='<%=link%>1'">
		<c:if test="<%=dotbefore%>">..</c:if>

		<%
			for (int i = 0; i < 9; i++) {
				if (pagenumbers[i] != 0) {
					if (pagenumbers[i] == curr) {
		%>
		<font color="red"><%=pagenumbers[i]%></font>
		<%
			} else {
		%>
		<a href="<%=link%><%=pagenumbers[i]%>"> <%=pagenumbers[i]%></a>
		<%
			}
				}
			}
		%>

		<c:if test="<%=dotafter%>">..</c:if>
		<img id="pageimg" src="./img/Page_Right-arrow_1.png" alt="이미지없음"
			class="btn" onclick="location='<%=link%><%=pagenums%>'">


	</div>

	<br>

	<!-- 검색 -->
	<script type="text/javascript">
		function searchQA() {
			var sel = document.getElementById("searchbox");
			var searchfor = sel.options[sel.selectedIndex].value;
			
			var msg = document.getElementById("search").value;
			location.href = "./QAController?command=list&searchfor="+searchfor + "&findword=" + msg ;
		
		}
		//글쓰기
		function QAwrite() {
			var idcheck = <%=idcheck%>; // 아이디값 불러옴
			
			if (idcheck){
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

	<!-- Footer -->
	<jsp:include page="Footer.jsp"></jsp:include>

</body>

</html>