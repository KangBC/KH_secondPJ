<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<!-- 버튼  -->
<link href="<%=request.getContextPath() %>/CSS/SUMBut_welcome.css" rel="stylesheet">

<!-- 배경 & 글씨 액션  주석처리 --> 
<link href="<%=request.getContextPath() %>/CSS/SUMimg_welcome.css" rel="stylesheet">

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>SUM_Welcome</title>

</head>

<body>

	<h1 id="hom">2조</h1>

	<p>
		<span id="anim"></span>
		<span id="shuffle"></span>
	
	<div class="col-md-3 col-sm-3 col-xs-6">
	<a href="Login.jsp" class="btn btn-sm animated-button victoria-one">시작합니다</a>
	</div>
	</p>


	<script type="text/javascript">
var $ = function(id) {
	  return document.getElementById(id);
	};
	var inc = 0;
	var out = 0;
	var str = 'KH(정보교육원)2조 Project 시작합니다.';
	var chars = 'ABCDEFG@$%&';
	var t;

	var anim = function() {
	  inc++;
	  if (inc % 7 === 0 && out < str.length) {
	    $('anim').appendChild(document.createTextNode(str[out]));
	    out++;
	  } else if (out >= str.length) {
	    $('shuffle').innerHTML = '';
	    removeInterval(t);
	  }
	  $('shuffle').innerHTML =
	    chars[Math.floor(Math.random() * chars.length)];
	};
	t = setInterval(anim, 50);
	$('anim').innerHTML = '';

	
</script>
</body>
</html>