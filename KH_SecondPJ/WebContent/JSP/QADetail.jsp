<%@page import="Dto.MemberDto"%>
<%@page import="Dto.QADto"%>
<%@page import="Dao.QADao"%>
<%@page import="Dto.QADto"%>
<%@page import="Dao.QADao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>QAdetail</title>


<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">


<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"
	integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp"
	crossorigin="anonymous">

<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
	integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
	crossorigin="anonymous"></script>
<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script> -->

</head>
<body>
	<div align="center">
		<a href="Login.jsp">로그아웃</a>

		<h1>상세 글 보기</h1>

	</div>
	<%
	MemberDto mem = (MemberDto)session.getAttribute("kh_member");
    boolean idcheck = true;
 	 if(mem == null){
		idcheck = false;
 	}
		String sseq = request.getParameter("seq");
		int seq = Integer.parseInt(sseq.trim());

		QADao dao = QADao.getInstance();

		// 조회수를 증가
		dao.QAreadcount(seq);
		QADto dto = dao.getBbs(seq);
	%>

	<div class="center">
		<form action="../QAController?command=QADetail" method="post">
			<table class="table table-bordered" style="width: 700px"
				height="500px" align="center">
				<col width="100px">

				<tr>
					<td>ID:</td>
					<td><input type="text" placeholder="제목을 입력하세요. " name="id"
						class="form-control" value="<%=dto.getId()%>"></td>

				</tr>

				<tr>
					<td>제목:</td>
					<td><input type="text" placeholder="제목을 입력하세요. " name="title"
						class="form-control" value="<%=dto.getTitle()%>"></td>
				</tr>

				<tr>
					<td>작성일:</td>
					<td><input type="text" name="wdate" class="form-control"
						value="<%=dto.getWdate()%>"></td>
				</tr>

				<tr>
					<td>조회수:</td>
					<td><input type="text" name="readcount" class="form-control"
						value="<%=dto.getReadcount()%>"></td>
				</tr>

				<tr>
					<td>정보</td>
					<td><%=dto.getRef()%>-<%=dto.getStep()%>-<%=dto.getDepth()%></td>
				</tr>

				<tr>
					<td>내용</td>
					<td><textarea cols="700" placeholder="내용을 입력하세요. "
							name="content" class="form-control"> <%=dto.getContent()%> </textarea>
					</td>
				</tr>

			</table>
		</form>

		<!-- 댓글기능  -->
		<div align="center">

			<button onclick="QAanswer()">답글</button>

			<br>

			<button onclick="Upsubmit()">수정</button>

			<br>

			<button onclick="delsubmit()">삭제</button>

		</div>

		<input type="button" value="글 목록 " class="pull-right"
			onclick="javascript:location.href='<%=request.getContextPath() %>/QAController?command=list&searchfor=0'" />


	</div>

<script type="text/javascript">
	var idcheck = <%=idcheck%>;
//삭제
function delsubmit() {
	

	if (idcheck) {
		var result = confirm("정말 삭제하시겠습니까?");
		if(result){
			location = "../QAController?command=QAdelete&seq=<%=dto.getSeq()%>";
		}else{
			return
		}
	}else{
		alert('작성자만 글을 지울수 있습니다.');
	    return;
	}
}
	
//수정
function Upsubmit() {
		if (idcheck) {
			var result = confirm("정말 수정하시겠습니까?");
			if(result){
				location = "QAupdatel.jsp?seq="+<%=dto.getSeq()%>;
			}else{
				return
			}
		}else{
			alert('작성자만 수정할수있습니다.');
		    return;
		}
	}
	
	
//답글
function QAanswer() {
	if (idcheck) {
		var result = confirm("댓글란으로 이동합니다.?");
		if(result){
			location = "QAanswer.jsp?seq="+<%=dto.getSeq()%>;
		}else{
			return
		}
	}else{
		alert('로그인해주세요');
	    return;
	}
}
	
</script>

</body>
</html>

