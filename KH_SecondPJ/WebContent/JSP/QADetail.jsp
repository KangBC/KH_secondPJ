<%@page import="Dto.QADto"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
    
<%
/* cust -> �̸������ض�. �ӽ÷� �������  */
QADto cust = (QADto)request.getAttribute("cust");

System.out.println("cust:" + cust.toString());

%>  
    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>��������</title>
</head>
<body>

<h3>��������</h3>

<div align="center">

<table style="width: 600">
<col width="200"><col width="400">

<tr>
	<td height="2" bgcolor="#0000ff" colspan="2"></td>
</tr>

<tr bgcolor="#f6f6f6">
	<td>���̵�</td>
	<td><%=cust.getId() %> </td>	
</tr>

<tr>
	<td height="2" bgcolor="#0000ff" colspan="2"></td>
</tr>

<tr bgcolor="#f6f6f6">
	<td>�̸�</td>
	<td><%=cust.getName() %> </td>	
</tr>

<tr>
	<td height="2" bgcolor="#0000ff" colspan="2"></td>
</tr>

<tr bgcolor="#f6f6f6">
	<td>�ּ�</td>
	<td><%=cust.getAddress() %> </td>	
</tr>

<tr>
	<td height="2" bgcolor="#0000ff" colspan="2"></td>
</tr>

<tr bgcolor="#f6f6f6">
	<td>����������</td>
	<td>
		<form action="CustUserControl" method="post">
			<input type="hidden" name="command" value="updateBf">
			<input type="hidden" name="id" value="<%=cust.getId() %>">
			<input type="submit" value="���庸����">
		</form>
		<form action="CustUserControl" method="post">
			<input type="hidden" name="command" value="delete">
			<input type="hidden" name="id" value="<%=cust.getId() %>">
			<input type="submit" value="���庸����">
		</form>
		
	</td>

</tr>



</table>


</div>




</body>
</html>

