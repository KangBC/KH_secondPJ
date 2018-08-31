<%@page import="Dto.QADto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
    
    
<%
/* List 생성  */
List<QADto> QAList = (List<QADto>)request.getAttribute("QAList");

for(int i = 0;i < QAList.size(); i++){
	System.out.println(QAList.get(i).toString());	
}
request.setAttribute("QAlist", QAList);
%> 
 
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>QAList(1)</title>
</head>

<body>

<div align="center"> 

<form action="QAController" method="get">

<input type="hidden" name ="command" value="muldel">

<table border="1"> 

<!-- checkbox        번호                         제목                          작성자        -->
<col width="50"><col width="80"><col width="300"><col width="250">
	
<tr bgcolor="#f6f6f6">
	<td bgcolor="#f6f6f6" align="center">
		<input type="checkbox" name="alldel" onclick="checkall(this)">
		
		<th>작성번호</th> 
		
		<th>제목</th> 
		
		<th>작성자</th>
	
	</td>
</tr>
	
	<!-- 데이터가 없으면 -->
	<c:if test="${ QAList.size() == 0}">
	
	<tr>
		 <td colspan="4" align="center">게시글 존재하지 않습니다</td>
	</tr>
	
	</c:if>
	
	<!-- 데이터가 있으면  -->
	<c:if test="${ QAList.size() > 0}">
	
	<c:forEach var="obj" items="${QAList }" step="1" varStatus="i">
		
		<tr bgcolor="#f6f6f6">
				<td align="center" bgcolor="white">
					<input type="checkbox" name="delck" value="${obj.getId()}">
				</td>
			
				<td>${obj.getId()}</td>
				
				<td>
					<!--   사용자 게시글이 맞으면 디테일로 이동해라  -->
					<a href="QAController?command=QADetail&id=${obj.getId()}">
						${obj.getName()}
					</a>
				</td>	
			</tr>	
	
	</c:forEach>
	</c:if>
	
</table>
</div>
<hr>

<!-- 다음 view로 이동  -->
<div align="center">
<a href="QAwrite.jsp">글쓰기</a>

<br><br>
<!-- 기능추가  -->
<input type="text" id="search">
<button name="search" onclick="searchQA()">검색</button> <br><br><br>

<!-- 기능추가 -->
<tr>
	<td align="center" height="1" bgcolor="#c0c0c0" colspan="4">
		<input type="submit" value="고객정보 삭제">
	</td>
</tr>

</div>

<script>

//멀티 체크 삭제
function checkall(input){
	var x = input.checked;
	
	var arr = document.getElementsByName("delck");
	
	for(i = 0;i < arr.length; i++){
		
		arr[i].checked = x;
	}
}
</script>

</body>
</html>