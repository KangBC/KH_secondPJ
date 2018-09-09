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

		String rs = "<img src='img/arrow.png' width='20px' height='20px'/>";
		String nbsp = "&nbsp;&nbsp;&nbsp;&nbsp;"; // depth의 간격
		String ts = "";

		for (int i = 0; i < depth; i++) {
			ts += nbsp;
		}
		return depth == 0 ? "" : ts + rs;
	}
	%>
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

<style>
textarea{
	resize: none;
}
.btns{
	margin-right: 0;
    margin-left: auto;
}
</style>

</head>
<body>
	<div align="center">
		<a href="Login.jsp">로그아웃</a>

		<h1>상세 글 보기</h1>

	</div>
	<%
	MemberDto mem = (MemberDto)session.getAttribute("kh_member");
    boolean idcheck = true;
    String temp ="";
 	if(mem == null){
		idcheck = false;
 	}else{
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

	<div class="center">
		<form action="../QAController?command=QADetail" method="post">
			<table class="table table-bordered" style="width: 700px"
				height="500px" align="center">
				<col width="100px"><col width="500px"><col width="100px">

				<tr>
					<td>ID:</td>
					<td><input readonly type="text" placeholder="제목을 입력하세요. " name="id"
						class="form-control" value="<%=dto.getId()%>"></td>

				</tr>

				<tr>
					<td>제목:</td>
					<td><input readonly type="text" placeholder="제목을 입력하세요. " name="title"
						class="form-control" value="<%=dto.getTitle()%>"></td>
				</tr>

				<tr>
					<td>작성일:</td>
					<td><input readonly type="text" name="wdate" class="form-control"
						value="<%=dto.getWdate()%>"></td>
				</tr>

				<tr>
					<td>조회수:</td>
					<td><input readonly type="text" name="readcount" class="form-control"
						value="<%=dto.getReadcount()%>"></td>
				</tr>


				<tr>
					<td>내용</td>
					<td><textarea readonly cols="700" placeholder="내용을 입력하세요. "
							name="content" class="form-control"> <%=dto.getContent()%> </textarea>
					</td>
				</tr>

			</table>
		</form>

		<!-- 댓글기능  -->
		<div align="center">

			<button onclick="answerTable(this)" value="0">답글달기</button>

			<button onclick="Upsubmit()">수정</button>

			<button onclick="delsubmit()">삭제</button>
			
			<input type="button" value="글 목록 " class=""
			onclick="javascript:location.href='<%=request.getContextPath() %>/QAController?command=list&searchfor=0'" />

		</div>

	<hr>
	<div>
	<table class="table table-bordered" style="width: 700px" align="center" id="replysection">
	<col width="100px"><col width="530px">
	<%
	if(replysize != 0){
		for(int i =0; i < replysize; i++){
			ReplyDto reply = replylist.get(i);
		%>
			<tr>
				<th><%=reply.getId() %></th>
				<th>
					<table>
					<tr><%=arrow(reply.getDepth()) %>
					<input type="text" readonly value="<%=reply.getContent() %>">
					</tr>
					
					<tr height="40px">
					<td><font size="1" color="gray"><%=reply.getWdate() %></font></td>
					</tr>
					</table>
				</th>
				<td><button onclick="changeReply(this)" value="<%=reply.getSeq() %> <%=reply.getId() %>">수정</button>
					<button onclick="delReply(this)" value="<%=reply.getSeq() %> <%=reply.getId() %>">삭제</button>
					<button onclick="answerTable(this)" value="<%=reply.getSeq() %>">답글</button>
				</td>
			</tr>
		
		<%
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
		if('<%=temp%>' == '<%=dto.getId() %>'){
		
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
		if('<%=temp%>' == '<%=dto.getId() %>'){
		
			var result = confirm("정말 변경하시겠습니까?");
			if(result){
				location = "../QAController?command=QAdelete&seq=<%=dto.getSeq()%>";
			}else{
				return
			}
		}else{
			alert('작성자만 글을 변경할 수 있습니다.');
		    return;
		}
		
	}else{
		alert('로그인하셔야 합니다.');
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
				
				if(element.style.borderStyle == 'inset'){

					var tr = document.createElement('tr');
					var th1 = document.createElement('th');
					th1.appendChild(document.createTextNode('<%=temp%>'));
					
					var th2 = document.createElement('th');
					var texta = document.createElement('textarea');
					texta.setAttribute('id', 'repcont');
					texta.setAttribute('name', 'repcont');
					texta.setAttribute('cols', '700');
					texta.setAttribute('class', 'form-control');
					th2.appendChild(texta);
					
					var td3 = document.createElement('td');
					var btn = document.createElement('button');
					
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
					
					var row = reptbl.insertRow(element.parentElement.parentElement.rowIndex+1);

					//var tr = document.createElement('tr');
					var th1 = document.createElement('th');
					th1.appendChild(document.createTextNode('<%=temp%>'));
					
					var th2 = document.createElement('th');
					var texta = document.createElement('textarea');
					texta.setAttribute('id', 'repcont');
					texta.setAttribute('name', 'repcont');
					texta.setAttribute('cols', '700');
					texta.setAttribute('class', 'form-control');
					th2.appendChild(texta);
					
					var td3 = document.createElement('td');
					var btn = document.createElement('button');
					
					btn.setAttribute('onclick', "makeReply(this)");
					btn.setAttribute('value', element.value);
					btn.appendChild(document.createTextNode('reply'))
					td3.appendChild(btn);
		
					row.appendChild(th1);
					row.appendChild(th2);
					row.appendChild(td3);
					//reptbl.insertBefore(tr, reptbl.children[element.parentElement.parentElement.rowIndex+1].nextSibling);
				}else{
					reptbl.deleteRow(element.parentElement.parentElement.rowIndex+1);
				}
				
				
			}
		}else{
		alert('로그인해주세요');
	    return;
	}
}

function delReply(element){
	if (idcheck) {
		var arr = element.value.split(" ");
		if('<%=temp%>' == arr[1]){
		
			var result = confirm("정말 삭제하시겠습니까?");
			if(result){
				location = "../QAController?command=repdelete&seq="+arr[0]+"&ref=<%=dto.getRef() %>";
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
					location = "../QAController?command=repupdate&seq="+arr[0]+"&content="+str+"&ref=<%=dto.getRef() %>";
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

</body>
</html>

