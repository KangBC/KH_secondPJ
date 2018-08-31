<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Dto.*, Dao.*, java.util.*"%>

<!DOCTYPE html>
<html>
<head>

<link rel='stylesheet' href='./fullcalendar/fullcalendar.min.css' />
<script src="./fullcalendar/lib/jquery.min.js"></script>
<script src='./fullcalendar/lib/moment.min.js'></script>
<script src='./fullcalendar/fullcalendar.min.js'></script>
<script src='./fullcalendar/locale/ko.js'></script>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">

<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>



<script>
$(function() {
	  $('#calendar').fullCalendar({

	  })

	});
</script>


<style type="text/css">
#calendar{
	margin: 20px auto;
}
.wrapper{
	text-align: center;
}
</style>




<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h1>상담 일정</h1>

<div id='calendar'></div>

<div class="wrapper">
<button id="btn" onclick="ReservController" type="button" class="btn btn-primary">상담예약</button>
</div>

<%
String json = (String)request.getAttribute("json");

%>

<script>
var arr = JSON.parse('<%=json%>');
//console.log(arr.title);
for(var i = 0; i < arr.length;i++ ){
	console.log(arr[i].start);
}


   $('#calendar').fullCalendar({
	
	eventSources: [{
		events: arr,
		  color: 'pink',
		textColor: 'white'
	}] 
  
});  

</script>

</body>
</html>


<!-- [
		    {
		      title  : 'event1',
		      start  : '2018-08-10'
		    },
		    {
		      title  : 'event2',
		      start  : '2018-08-10',
		      end    : '2018-08-14'
		    },
		    {
		      title  : 'event3',
		      start  : '2018-09-09T12:30:00',
		      allDay : false // will make the time show
		    }
		  ] -->