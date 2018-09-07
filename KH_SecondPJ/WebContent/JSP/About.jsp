<%@page import="Dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
.slides{
width: 100%;
}

.font{
font-size: 1em; 
}
</style>
</head>
<body>
<jsp:include page="Header.jsp"></jsp:include>
<div style="width:1020px; margin: 50px auto 30px; text-align: center;">
<h2>About</h2>
<hr style="width: 1020px; border-color: black;">


<img class="slides" src="<%=request.getContextPath() %>/img/wedding_slide01.jpg">
<img class="slides" src="<%=request.getContextPath() %>/img/wedding_slide02.jpg">
<img class="slides" src="<%=request.getContextPath() %>/img/wedding_slide03.jpg">
<img class="slides" src="<%=request.getContextPath() %>/img/wedding_slide04.jpg">
<img class="slides" src="<%=request.getContextPath() %>/img/wedding_slide05.jpg">

<hr style="width: 1020px; border-color: black;">


<p class="font">또 하나의 가족을 맞이하는 가슴 따뜻한 순간,
완벽해야만 하는 그날을 위해 각 분야 최고의 전문가들이 처음부터 끝까지 당신의 웨딩을 Design해 드립니다.</p>

<h5>일생에 단 하나뿐인 당신의 웨딩<strong>THE VALENTI Wedding&Party</strong>  당신을 더욱 빛나게 합니다.</h5>
<p class="font"> 이세상 누구보다 아름다운 당신, 눈부심과 설레임으로 다가오는 당신의 가장 소중한 순간을 준비했습니다.<br> 

전통과 격식을 존중한 클래식한 감성은 물론, 모던하고 내추럴한 세련된 감각의 품격있는 웨딩까지 다양한 웨딩 스타일을 제안하며 <br>럭셔리하고 차별화된 데코레이션과
최상의 요리와 세심한 서비스, 일생에 단한번뿐인 당신의 소중한 순간을 가슴속에 남겨드리겠습니다.</p>

<hr style="width: 1020px; border-color: black;">

<table style="width: 1020px;  border-color: black;  cellspacing="0" cellpadding="0">
            <tbody>
            <tr>
                <td><img style="width: 100%"  src="<%=request.getContextPath() %>/img/wedding_slide01.jpg"></td>
                <td width="497" valign="middle" style="border-right: 1px solid #E1E1E1; border-top: 1px solid #E1E1E1; padding: 0px 40px; line-height: 180%;" bgcolor="white">
                 <h4>Wedding</h4>
                	웨딩에 관련된 모든분야의 전문 스텝들이 고객님의 스타일에 맞는 <br>가장 감동적인 장면을 연출 해 드립니다.<br>
                </td>
            </tr>
            <tr>
                <td width="497" valign="middle" style="border-left: 1px solid #E1E1E1; border-bottom: 1px solid #E1E1E1;  padding: 0px 40px; line-height: 180%;" bgcolor="white">
						<h4>Lobby</h4>
                	내집으로 귀빈을 모시는 듯한 분위기를 여유롭고 편안하게 자아냅니다.<br>
                <td><img style="width: 100%"  src="<%=request.getContextPath() %>/img/wedding_slide06.jpg"></td>
                </td>
            </tr> 
           </tbody>
</table>


</div>






<script type="text/javascript">
var slideIndex = 0;
carousel();

function carousel() {
    var i;
    var x = document.getElementsByClassName("slides");
    for (i = 0; i < x.length; i++) {
      x[i].style.display = "none"; 
    }
    slideIndex++;
    if (slideIndex > x.length) {slideIndex = 1} 
    x[slideIndex-1].style.display = "block"; 
    setTimeout(carousel, 2000); // Change image every 2 seconds
}
</script>

<jsp:include page="Footer.jsp"></jsp:include>
</body>
</html>