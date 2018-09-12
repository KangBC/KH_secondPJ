<%@page import="Dao.MemberDao"%>
<%@page import="Dto.PdsDto"%>
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
<link href="<%=request.getContextPath()%>/CSS/QAList.css" rel="stylesheet">

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>자료실</title>

</head>


<body>
	<!-- mamber Session -->
	<% List<PdsDto> pdslist = (List<PdsDto>)request.getAttribute("pdslist");
	
	System.out.println("listsize: " + pdslist.size());

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
	
	/* boolean c_login = false;
	if(member != null){
		c_login = true;
	} */
	
	
	boolean idcheck = true;
	if (member == null) {
		idcheck = false;
	}
	
%> 


	<!--  최상단 이미지 부분 -->
	<div class="img">
		<div class="content">
			<!-- 검색 -->
			<div class="inner_MAIN">
				<div class="search_form">
				<fieldset>
					<div class="botton_main">
						<!-- butt -->

						
							<div class="inner_SUB">
								<select class="search_Group" id="option" name="searchbox">
									<option value="0">전체보기</option>
									<option value="1">작성자</option>
									<option value="2">제목</option>
								</select> <input type="text" class="text_1" id="search" name="search"
									maxlength="20" style="margin: -27px;">


								<div class="button-row">
									<div>
										<a id="searchQA" name="searchQA" onclick="srch()"
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
	<div style="width: 1020px; margin: 50px auto 30px; text-align: center;">
		<h2 style="font-size: 1.5em; font-weight: 680;">자료실</h2> 
	</div>

	<!-- 게시판 table -->
	<div style="min-height: 220px" align="center">

		<table style="width: 1100px;" class="table">

			<col width="100">
			<col width="200">
			<col width="300">
			<col width="100">
			<col width="150">
			<thead>
			
				<tr>
					<th scope="col">번호</th>
					<th scope="col">작성자</th>
					<th scope="col">제목</th>
					<th scope="col">조회수</th>
					<th scope="col">날자</th>
				</tr>
			</thead>


			<%	/* List 사이즈 정의 */
				if (pdslist == null || pdslist.size() == 0) {
			%>

			<tr>
				<td colspan="3">작성된 글이 없습니다</td>
			</tr>

			<%
				} else {

					int Articlenumber = 0; //글번호(삭제,글 나타나기 선언 객체)
					
					/* List 뿌려주기  */
					for (int i = 0; i < pdslist.size(); i++) {
					     PdsDto pds = pdslist.get(i);
			%>

				<tr>
					<td><%=pds.getDel()%></td>
					<td><%=pds.getId()%></td>
					<td>
					<a style="text-decoration: none;" href="<%=request.getContextPath() %>/JSP/Pdsdetail.jsp?seq=<%=pds.getSeq()%>"> <%=pds.getTitle()%>
					</a></td>
					<td><%=pds.getReadcount()%></td>
					<td><%=pds.getRegdate()%></td>

				</tr>

			<%
						}
					}
			%>

		</table>
	</div>

	 <!-- 글쓰기 버튼  -->
	<div align="center">
		<div class="border_Button" onclick="QAwrite()">
			<p style="text-decoration: none;">자료올리기</p>
		</div>
	</div>

	<!-- Page페이징 글자 표기 view -->
	<div style="text-align: center;">
		
			<%
			String link = "";
			if(search != null){
				link = request.getContextPath() + "/PdsController?command=search&str=" + searchstr +"&option=" + option + "&pagenumber=";
			}else{
				link = request.getContextPath() + "/PdsController?command=list&pagenumber=";
			}
			%>
		

		<img id="pageimg" src="./img/Page_left-arrow_1.png" alt="이미지없음"
			class="btn" onclick="location='<%=link%>1'">
		<c:if test="<%=dotbefore%>">..</c:if>

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

		<c:if test="<%=dotafter%>">..</c:if>
		<img id="pageimg" src="./img/Page_Right-arrow_1.png" alt="이미지없음"
			class="btn" onclick="location='<%=link%><%=pagenums%>'">


	</div>

	<br>

	<!-- 검색 -->
	<script type="text/javascript">

	<!-- 검색 --> 
		function srch(){
			var search = document.getElementById("search");
			var option = document.getElementById("option");
			var str = "<%=request.getContextPath() %>/PdsController?command=search&str=" + search.value + "&option="+option.value;
			
			location = str;
		}
		
	
		//자료올리기(완료)
		function QAwrite() {
			var idcheck = <%=idcheck%>; // 아이디값 불러옴
			
			if (idcheck){
				var result = confirm("자료올리기.");
				
				if(result){
					location = "<%=request.getContextPath() %>/JSP/Pdswrite.jsp";
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