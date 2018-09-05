<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false&language=ko"></script>
<title>Insert title here</title>
</head>
<body onload="initialize()">
<jsp:include page="Header.jsp" flush="false"></jsp:include>

<div style="width:1020px; margin: 50px auto 30px; text-align: center;">
<h2>Location</h2>
</div>
<hr style="width: 1020px; border-color: black;">
<div id="map_canvas" style="width:1020px; height:433px; margin: 30px auto 30px;"></div> 
<hr style="width: 1020px; border-color: black;">

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

	var infowindow = new google.maps.InfoWindow({ 
				content: "<h3>KH정보교육원</h3>", 
				maxWidth: 300 
	}); 

	google.maps.event.addListener(marker, 'click', function() { 
		infowindow.open(map, marker); 
	}); 
} 

</script> 
<div style="width:1020px; height:433px; margin: 30px auto 30px;">


<table>
	<tr>
		<td rowspan="2" style="vertical-align: top; width: 300px; "><h4 style="margin: 10px 0 0 10px ;">오시는 길</h4></td>
		<td style="width: 720px; ">
			<strong>주소</strong><br>
			<p>서울특별시 강남구 강남구 테헤란로14길 6</p>
			<hr style="border-color: black;">
		</td>
	</tr>
	<tr>
		<td style="width: 720px; ">
			<strong>전화안내</strong><br>
			<p>000-0000-0000</p>
		</td>
	</tr>
</table>
<hr style=" width: 1020px; border-color: black;">
</div>
</body>
</html>