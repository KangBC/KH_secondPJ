<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="initial-scale=1.0">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false&language=ko"></script>
<title>Insert title here</title>
<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/notosanskr.css);

</style>
</head>
<body onload="initialize()">
<jsp:include page="Header.jsp" flush="false"></jsp:include>

<div style="width:1020px; margin: 50px auto 30px; text-align: center;">
<h2>Location</h2>
</div>
<hr style="width: 1020px; border-color: #333;">
<div id="map_canvas" style="width:1020px; height:433px; margin: 30px auto 30px;"></div> 
<hr style="width: 1020px; border-color: #333;">

<script> 
function initialize() { 

	var myLatlng = new google.maps.LatLng(37.499095, 127.032909); // y, x좌표값
	
	var mapOptions = { 
		zoom: 17, 
		center: myLatlng, 
		mapTypeId: google.maps.MapTypeId.ROADMAP 
	} 

	var map = new google.maps.Map(document.getElementById('map_canvas'), mapOptions);

	var marker = new google.maps.Marker({ 
		position: myLatlng, 
		map: map, 
		title: "KH정보교육원" 
	}); 

	/* var infowindow = new google.maps.InfoWindow({ 
				content: "<h3>KH정보교육원</h3>", 
				maxWidth: 300  
	}); 

	google.maps.event.addListener(marker, 'click', function() { 
		infowindow.open(map, marker); 
	});  */
} 

</script> 
<%-- <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCD7f2RC5S3e68fd0paJO1vu-BndKmAqaA&callback=initialize" async defer></script>--%>
<div style="width:1020px; height:433px; margin: 30px auto 30px;">


<table style="font-family: Noto Sans KR, sans-serif;">
	<tr>
		<td rowspan="2" style="vertical-align: top; width: 300px; "><h4 style="margin: 10px 0 0 10px ;"><strong>오시는 길</strong></h4></td>
		<td style="width: 720px; ">
			<strong>주소</strong><br>
			<p style="margin-top: 5px;">서울특별시 강남구 테헤란로 14길 6 남도빌딩 2F, 3F, 4F, 5F</p>
			<hr style="border-color: #d1d1d1;">
		</td>
	</tr>
	<tr>
		<td style="width: 720px; ">
			<strong>전화안내</strong><br>
			<p style=" margin-top: 5px;">T: 1544-9970 / F: 02-562-2378</p>
		</td>
	</tr>
</table>
<hr style=" margin-top:30px; width: 1020px; border-color: #333;">

<table style="font-family: Noto Sans KR, sans-serif;">	
	<tr>
		<td rowspan="2" style="vertical-align: top; width: 300px; "><h4 style="margin: 10px 0 0 10px ;"><strong>오시는 방법</strong></h4></td>
		<td style="width: 720px; ">
			<strong>버스</strong><br>
			<p style="margin-top: 5px;">역삼역.포스코P&S타워 정류장</p>
			<p style="margin-top: 5px;">( 146 / 740 / 341 / 360 / 1100 / 1700 / 2000 / 7007 / 8001 ) </p>
			<hr style="border-color: #d1d1d1;">
		</td>
	</tr>
	<tr>
		<td style="width: 720px; ">
			<strong>지하철</strong><br>
			<p style=" margin-top: 5px;">지하철 2호선 역삼역 3번출구 100m</p>
		</td>
	</tr>
</table>
<hr style=" margin-top:30px; width: 1020px; border-color: #333;">
</div>
<jsp:include page="Footer.jsp"></jsp:include>
</body>
</html>