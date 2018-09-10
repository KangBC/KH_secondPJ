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

<link href="<%=request.getContextPath()%>/CSS/Table.css"
	rel="stylesheet">

<title>QAdetail</title>
</head>

<body>

	<%
		MemberDto mem = (MemberDto) session.getAttribute("kh_member");
		String tempid;
		boolean idcheck = true;
		if (mem == null) {
			idcheck = false;
			tempid = "";
		} else {
			tempid = mem.getId();
		}
		String sseq = request.getParameter("seq");
		int seq = Integer.parseInt(sseq.trim());

		QADao dao = QADao.getInstance();

		// 조회수를 증가
		dao.QAreadcount(seq);
		QADto dto = dao.getBbs(seq);
	%>


	<jsp:include page="Header.jsp"></jsp:include>

	<div class="outer-container">

		<h2>QADetail</h2>
		<br>
		<form
			action="<%=request.getContextPath()%>/QAController?command=QADetail"
			method="post">

			<div class="inner-container">
				<table border="0" style="border-collapse: collapse">
					<col width="100">
					<col width="920">

					<tr>
						<td>이름</td>
						<td><input type="text" class="input_data" name="id" readonly
							value="<%=dto.getId()%>" style="padding-left: 2px;"></td>
					</tr>

					<tr>
						<td>제목</td>
						<td><input type="text" class="input_data" name="title"
							readonly value="<%=dto.getTitle()%>" style="padding-left: 2px;"></td>
					</tr>

					<tr>
						<td>작성일</td>
						<td><input type="text" class="input_data" name="Wdate"
							readonly value="<%=dto.getWdate()%>" style="padding-left: 2px;"></td>
					</tr>

					<tr>
						<td>조회수</td>
						<td><input type="text" class="input_data" name="readcount"
							readonly value="<%=dto.getReadcount()%>"
							style="padding-left: 2px;"></td>
					</tr>

					<tr>
						<td>정보</td>
						<td><input type="text" class="input_data" name="Ref" readonly
							value="<%=dto.getRef()%>" style="padding-left: 2px;"></td>
					</tr>


					<tr style="border-bottom: 0;">

						<td style="vertical-align: top; padding-top: 8px;">내용</td>
						<td style="padding-top: 8px;"><textarea class="input_data"
								id="content" name="content" rows="4" cols="50"
								style="width: 90%; height: 500px;"> <%=dto.getContent()%> </textarea></td>

					</tr>
				</table>
			</div>


			<!-- 댓글기능  -->
			<div align="center">

				<button onclick="QAanswer()">답글</button>

				<br>

				<button onclick="Upsubmit()">수정</button>

				<br>

				<button onclick="delsubmit()">삭제</button>

			</div>

			<input type="button" value="글 목록 " class="pull-right"
				onclick="javascript:location.href='<%=request.getContextPath()%>/QAController?command=list&searchfor=0'" />
	</div>


<script type="text/javascript">
	var idcheck = <%=idcheck%>;
//삭제
	function delsubmit() {
		if (idcheck) {
			if('<%=tempid%>' == '<%=dto.getId()%>'){ 			
				var result = confirm("정말 삭제하시겠습니까?");
				if(result){
					location = "../QAController?command=QAdelete&seq=<%=dto.getSeq()%>";
				}else{
					return
				}
		 	}else{
				alert('아이디가 다르다 니글아니야 슈발아.');
			    return;
		} 

	}else{
		alert('애미 로그인부터 하세여.');
	    return;
	}
}
	
	
//수정
function Upsubmit() {
		if (idcheck) {

		if('<%=tempid%>' == '<%=dto.getId()%>'){
				var result = confirm("정말 수정하시겠습니까?");
				
				if(result){
					location = "QAupdatel.jsp?seq="+<%=dto.getSeq()%>;
				}else{
					return
				}
		}else{
			alert('아이디가 다르다 니글아니야 슈발아.');
		    return;
		}

	}else{
		alert('애미 로그인부터 하세여.');
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

