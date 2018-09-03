<%@page import="Dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;  charset=EUC-KR">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Write something else you want</title>


<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
 
<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
 
<!-- Latest compiled and minified JavaScript-->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

</head>
<body>
<%
Object ologin = session.getAttribute("member");

MemberDto mem = null;

if(ologin == null){
	%>
	<script type="text/javascript">
	alert("다시 로그인 해 주십시오");
	location.href = "index.jsp";
	</script>
	<%
	return;
}

mem = (MemberDto)ologin;
%>


<div class="container">
<form action="../QAController?command=add" method="post" >
<table class="table table-bordered" style="width: 700px" height="500px" align="center">

    <col width="50px"> 
           <tr>
                <th>ID: </th>
                <td><input type="text" placeholder="제목을 입력하세요. " name="id" class="form-control" value="<%=mem.getId()%>"></td>
            </tr>
        
            <tr>
                <th>제목: </th>
                <td><input type="text" placeholder="제목을 입력하세요. " name="title" class="form-control"/></td>
            </tr>
            <tr>
                <th>내용: </th>
                <td><textarea cols="700" placeholder="내용을 입력하세요. " name="content" class="form-control"></textarea></td>
            </tr>
         
            <tr>
                <td colspan="2">
                    <input type="submit" value="등록" class="pull-right"/>
                    <input type="button" value="reset" class="pull-left"/>
                    <input type="button" value="글 목록 " class="pull-right" onclick="javascript:location.href='QAList.jsp'"/>
                </td>
            </tr>

</table>
 </form>
</div>
</body>
</html>
