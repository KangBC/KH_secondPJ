<%@page import="Dto.ReplyDto"%>
<%@page import="java.util.List"%>
<%@page import="Dto.MemberDto"%>
<%@page import="Dto.QADto"%>
<%@page import="Dao.QADao"%>
<%@page import="Dto.QADto"%>
<%@page import="Dao.QADao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%!// 댓글!!
	public String arrow(int depth) {

		String rs = "<img src='../img/arrow.png' width='20px' height='20px'/>";
		String nbsp = "&nbsp;&nbsp;&nbsp;&nbsp;"; // depth의 간격
		String ts = "";

		for (int i = 0; i < depth; i++) {
			ts += nbsp;
		}
		return depth == 0 ? "" : ts + rs;
	}%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<!--  수정 삭제 글목록 버튼 -->
<link href="<%=request.getContextPath()%>/CSS/mainbutton.css"
	rel="stylesheet">


<link href="<%=request.getContextPath()%>/CSS/Table.css"
	rel="stylesheet">

<title>QADetail</title>

</head>

<body>

	<%
		MemberDto mem = (MemberDto) session.getAttribute("kh_member");
		boolean idcheck = true;
		String temp = "";
		if (mem == null) {
			idcheck = false;
		} else {
			temp = mem.getId();
		}
		String sseq = request.getParameter("seq");
		int seq = Integer.parseInt(sseq.trim());

		QADao dao = QADao.getInstance();

		// 조회수를 증가
		dao.QAreadcount(seq);
		QADto dto = dao.getBbs(seq);

		List<ReplyDto> replylist = dao.getreplist(seq);

		int replysize = replylist.size();

		System.out.println("답변 수: " + replysize);
	%>

	<jsp:include page="Header.jsp"></jsp:include>

	<!--  최상단 이미지 부분 -->
	<div class="img">
		<!-- img_위에 망 덮어씌움  이유 : 이미지가 색이 강력크 .. ㅋㅌ 방지용  -->
		<div class="img-cover"></div>
	</div>

	<div class="outer-container">

		<div
			style="width: 1020px; margin: 50px auto 30px; text-align: center;">
			<h2 style="font-size: 1.5em; font-weight: 680;"> Q&A Detail </h2>
		</div>

		<br>

		<div class="inner-container">
			<table border="0" style="border-collapse: collapse">
				<col width="100">
				<col width="920">

				<tr>
					<td>이름</td>
					<td><input type="text" class="input_data" name="id" readonly
						value="<%=dto.getId()%>" style="padding-left: 2px; border: 0;"></td>
				</tr>

				<tr>
					<td>작성일</td>
					<td><input type="text" class="input_data" name="Wdate"
						readonly value="<%=dto.getWdate().substring(0, 16)%>"
						style="padding-left: 2px; border: 0;"></td>
				</tr>

				<tr>
					<td>조회수</td>
					<td><input type="text" class="input_data" name="readcount"
						readonly value="<%=dto.getReadcount()%>"
						style="padding-left: 2px; border: 0;"></td>
				</tr>


				<tr>
					<td>제목</td>
					<td><input type="text" class="input_data" name="title"
						readonly value="<%=dto.getTitle()%>" style="padding-left: 2px; border: 0;"></td>
				</tr>


				<tr style="border-bottom: 0;">

					<td style="vertical-align: top; padding-top: 8px;">내용</td>
					<td style="padding-top: 8px;"><textarea class="input_data"
							id="content" name="content" readonly rows="4" cols="50"
							style="width: 90%; height: 500px; ; outline: none"> <%=dto.getContent()%> </textarea></td>
				</tr>
			</table>
		</div>

		<button class="mainbut" onclick="answerTable(this)" value="0">답글달기</button>

		<button class="mainbut" onclick="Upsubmit()">수정</button>

		<button class="mainbut" onclick="delsubmit()">삭제</button>

		<input type="button" value="글 목록 " class="mainbut"
			onclick="javascript:location.href='<%=request.getContextPath()%>/QAController?command=list&searchfor=0'" />

		<br> <br>

		<div>
			<!--  작업중 -->
			<table class="table table-bordered" style="width: 1020px"
				align="center" id="replysection">
				<col width="150px">
				<col width="770px">
				<col width="100px">
				<%
					if (replysize != 0) {
						for (int i = 0; i < replysize; i++) {
							ReplyDto reply = replylist.get(i);
							if (reply.getDel() == 0) {
				%>
				<tr>
					<td colspan="3">
						<div
							style="text-align: left; border: 1px solid #aaa; padding: 20px; margin: 20px">
							<!-- 아이디 -->
							<span
								style="display: inline-block; font-weight: 700; margin-right: 5px;"><%=reply.getId()%></span>
							<!-- 날짜 -->
							<span style="display: inline-block; font-size: 12px; color: #555"><%=reply.getWdate()%></span>
							<hr
								style="border: none; border-bottom: 1px solid #aaa; width: 100%;">
							<p style="margin-top: 10px; word-wrap: break-word;"><%=arrow(reply.getDepth())%><%=reply.getContent()%></p>

							<div style="text-align: right;">
								<button class="mainbut" onclick="changeReply(this)"
									value="<%=reply.getSeq()%> <%=reply.getId()%>">수정</button>
								<button class="mainbut" onclick="delReply(this)"
									value="<%=reply.getSeq()%> <%=reply.getId()%>">삭제</button>
								<button class="mainbut" onclick="answerTable(this)"
									value="<%=reply.getSeq()%>">답글</button>
							</div>
						</div>
					</td>
				</tr>
				<%
					} else {
				%>
				<tr>
					<td colspan="3">
						<div
							style="text-align: left; border: 1px solid #aaa; padding: 20px; margin: 20px">
							<!-- 아이디 -->
							<span
								style="display: inline-block; font-weight: 700; margin-right: 5px;">-</span>
							<!-- 날짜 -->
							<span style="display: inline-block; font-size: 12px; color: #555"><%=reply.getWdate()%></span>
							<hr
								style="border: none; border-bottom: 1px solid #aaa; width: 100%;">
							<p style="margin-top: 10px; word-wrap: break-word;"><%=arrow(reply.getDepth())%>이
								글은 삭제된 글입니다.
							</p>

						</div>
					</td>
				</tr>
				<%
					}
						}
					}
				%>

			</table>
		</div>
	</div>


	<script type="text/javascript">
var idcheck = <%=idcheck%>;

//삭제
function delsubmit() {
	if (idcheck) {
		if('<%=temp%>' == '<%=dto.getId()%>'){
		
			var result = confirm("정말 삭제하시겠습니까?");
			if(result){
				location = "../QAController?command=QAdelete&seq=<%=dto.getSeq()%>";
			}else{
				return
			}
		}else{
			alert('작성자만 글을 지울 수 있습니다.');
		    return;
		}
		
	}else{
		alert('로그인하셔야 합니다.');
	    return;
	}
}
	
	
//수정
function Upsubmit() {
		if (idcheck) {

		if('<%=temp%>' == '<%=dto.getId()%>'){
				var result = confirm("정말 수정하시겠습니까?");
				
				if(result){
					location = "QAupdatel.jsp?seq="+<%=dto.getSeq()%>;
				}else{
					return;
				}
		}else{
			alert('아이디가 일치 하지 않습니다.');
		    return;
		}

	}else{
		alert('로그인 부탁드립니다..');
	    return;
	}
}	


function makeReply(element){
	
	var content = element.parentElement.parentElement.children[1].children[0].value;
/* 	document.getElementById("repcont").value; */
	
	console.log(content);
	
	location = '../QAController?command=reply&content='+content+'&ref=<%=dto.getSeq()%>&id=<%=temp%>&parent='+element.value;
	
}

function answerTable(element){
	
	if(idcheck){
		
		element.style.borderStyle = (element.style.borderStyle!=='inset' ? 'inset' : 'outset'); 
		var reptbl = document.getElementById('replysection');
			
			if(element.value == 0){
				/* 작업중 */
				if(element.style.borderStyle == 'inset'){

					var tr = document.createElement('tr');
					var th1 = document.createElement('th');
					th1.appendChild(document.createTextNode('<%=temp%>'));
					
					var th2 = document.createElement('th');
					var texta = document.createElement('textarea');
					texta.setAttribute('id', 'repcont');
					texta.setAttribute('name', 'repcont');
					texta.setAttribute('cols', '120%');
					texta.setAttribute('class', 'form-control');
					th2.appendChild(texta);
					
					var td3 = document.createElement('td');
					var btn = document.createElement('button');
					
					btn.setAttribute('class', "mainbut");
					btn.setAttribute('onclick', "makeReply(this)");
					btn.setAttribute('value', element.value);
					btn.appendChild(document.createTextNode('reply'))
					td3.appendChild(btn);
					
		
					tr.appendChild(th1);
					tr.appendChild(th2);
					tr.appendChild(td3);
					reptbl.insertBefore(tr, reptbl.children[0]);
				}else{
					reptbl.removeChild(reptbl.children[0]);
				}
				
			}else{
				
				console.log(element.value);
				console.log(element.parentElement.parentElement.rowIndex);
				
				if(element.style.borderStyle == 'inset'){
					
					var row = reptbl.insertRow(element.parentElement.parentElement.parentElement.parentElement.rowIndex+1);

					//var tr = document.createElement('tr');
					var th1 = document.createElement('th');
					th1.appendChild(document.createTextNode('<%=temp%>'));
					
					var th2 = document.createElement('th');
					var texta = document.createElement('textarea');
					texta.setAttribute('id', 'repcont');
					texta.setAttribute('name', 'repcont');
					texta.setAttribute('cols', '120%');
					texta.setAttribute('class', 'form-control');
					th2.appendChild(texta);
					
					var td3 = document.createElement('td');
					var btn = document.createElement('button');
					btn.setAttribute('class', "mainbut");
					btn.setAttribute('onclick', "makeReply(this)");
					btn.setAttribute('value', element.value);
					btn.appendChild(document.createTextNode('reply'))
					td3.appendChild(btn);
		
					row.appendChild(th1);
					row.appendChild(th2);
					row.appendChild(td3);
				}else{
					reptbl.deleteRow(element.parentElement.parentElement.parentElement.parentElement.rowIndex+1);
				}
				
				
			}
		}else{
		alert('로그인해주세요');
	    return;
	}
}
//삭제
function delReply(element){
	if (idcheck) {
		var arr = element.value.split(" ");
		//temp: 부모글 arr:자식글???
		if('<%=temp%>' == arr[1]){
			var result = confirm("정말 삭제하시겠습니까?");
			if(result){
				location = "../QAController?command=repdelete&seq="+arr[0]+"&ref=<%=dto.getRef()%>";
			}else{
				return
			}
		}else{
			alert('작성자만 글을 지울 수 있습니다.');
		    return;
		}
		
	}else{
		alert('로그인하셔야 합니다.');
	    return;
	}
}
// 수정
function changeReply(element){
	if (idcheck) {
		var arr = element.value.split(" ");
		console.log(arr[1]);
		if('<%=temp%>' == arr[1]){
		
			var result = confirm("정말 변경하시겠습니까?");
			if(result){
				var str = prompt("새로운 내용을 적어주세요");
				if(str == null){
					return
				}else{
					location = "../QAController?command=repupdate&seq="+arr[0]+"&content="+str+"&ref=<%=dto.getRef()%>";
				}
			}else{
				return
			}
		}else{
			alert('작성자만 글을 지울 수 있습니다.');
		    return;
		}
	}else{
		alert('로그인하셔야 합니다.');
	    return;
	}
}

</script>

	<!-- Footer -->
	<jsp:include page="Footer.jsp"></jsp:include>

</body>
</html>

