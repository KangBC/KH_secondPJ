<%@page import="Dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<title>Insert title here</title>
<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/notosanskr.css);

.slides{
width: 100%;
}


</style>
</head>
<body>
<jsp:include page="Header.jsp"></jsp:include>

<!-- 상단 그림 -->
<div style="width: 100%; min-width:1020px; height:35%;">
<img style="width: 100%; min-width:1020px; max-height: 40%;" src="<%=request.getContextPath() %>/img/wedding_top016rr.jpg">
</div>
<!--
 /////////////////////////////////////////////////////////////////////////////
 -->
<div style="width:1020px; margin: 0 auto 30px; text-align: center;">
<h2>About</h2>
<hr style="width: 1020px; border-color: black;">

<br>
<p style="font-family: Noto Sans KR, sans-serif; font-size: 17px;" >또 하나의 가족을 맞이하는 가슴 따뜻한 순간,
완벽해야만 하는 그날을 위해 각 분야 최고의 전문가들이 처음부터 끝까지
<br> 당신의 웨딩을 최고로 아릅답게  Design해 드립니다.<br>
인생의 모든 순간을 빛낼 일생에 단 하나뿐인 당신의 웨딩 축제<strong>KH_Wedding&Party</strong>  당신을 더욱 빛나게 합니다.
</p>


<!-- 자동 슬라이더 -->
<img class="slides" src="<%=request.getContextPath() %>/img/wedding_slide01.jpg">
<img class="slides" src="<%=request.getContextPath() %>/img/wedding_slide02.jpg">
<img class="slides" src="<%=request.getContextPath() %>/img/wedding_slide03.jpg">
<img class="slides" src="<%=request.getContextPath() %>/img/wedding_slide04.jpg">
<img class="slides" src="<%=request.getContextPath() %>/img/wedding_slide05.jpg">


<button class="w3-button w3-display-left" onclick="plusDivs(-1)" style="top:120%; left: 16%">&#10094;</button>
<button class="w3-button w3-display-right" onclick="plusDivs(+1)" style="top:120%; right: 16%">&#10095;</button>
<hr style="width: 1020px; border-color: black;">




<p style="font-family: Noto Sans KR, sans-serif; font-size: 18px;" >

이세상 누구보다 아름다운 당신, 행복함과 설레임으로 다가올 당신의 가장 소중한 순간을 위해 준비했습니다.<br>
전통과 격식을 존중한 클래식한 감성은 물론, 모던하고 내추럴한 세련된 감각의 품격있는 웨딩까지  <br>
다양한 웨딩 스타일을 제안하며 럭셔리하고 차별화된 데코레이션과
최상의 요리와 세심한 서비스, <br> 
일생에 단한번뿐인 당신의 소중한 순간을 가슴속에 남겨드리겠습니다.</p>

</font>

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

<hr style="width: 1020px; border-color: black;">

</div>


<script type="text/javascript">
var slideIndex = 0;
showDivs(slideIndex);


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
    setTimeout(carousel, 4000); // Change image every 4 seconds
}

function plusDivs(n) {
    showDivs(slideIndex += n);
}

function showDivs(n) {
    var i;
    var x = document.getElementsByClassName("slides");
    if (n > x.length) {slideIndex = 1} 
    if (n < 1) {slideIndex = x.length} ;
    for (i = 0; i < x.length; i++) {
        x[i].style.display = "none"; 
    }
    x[slideIndex-1].style.display = "block"; 
}
</script>

<jsp:include page="Footer.jsp"></jsp:include>
</body>
</html>