<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Dto.*, Dao.*, java.util.*"%>
<%
request.setCharacterEncoding("utf-8");
%>

<!DOCTYPE html>
<html>
<head>

<link rel='stylesheet' href='../fullcalendar/fullcalendar.min.css' />
<script src="../fullcalendar/lib/jquery.min.js"></script>
<script src='../fullcalendar/lib/moment.min.js'></script>
<script src='../fullcalendar/fullcalendar.min.js'></script>
<script src='../fullcalendar/locale/ko.js'></script>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">

<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>


<%-- <%=request.getContextPath() %>/ReservController --%>
<script>
$(function() {
	  $('#calendar').fullCalendar({
		  navLinks: true,
		  header: {
		      left: 'prev,next today',
		      center: 'title',
		      right: 'month,agendaWeek,agendaDay'
		    },
		  navLinkDayClick: function(date, jsEvent) {
			    console.log('day', date.format()); // date is a moment
			    
			    location = '<%=request.getContextPath() %>/JSP/CalendarDay.jsp?date='+ date.format();
			  },
		  viewRender: function(view,element){
				var moment = view.intervalStart;
					//$('#calendar').fullCalendar('getDate');
				var year = moment.year();
				var month = moment.month()+1;
				var arr;
				var str = "<%=request.getContextPath() %>/ReserveController?command=list&year="+year+"&month="+month;

				$.get(str, function(data, status){
					console.log(data);
					arr = JSON.parse(data);
					
					
					for(var i = 0; i< arr.length;i++){
						console.log(arr[i].start);
					}
					
					$('#calendar').fullCalendar('removeEventSources');
					$('#calendar').fullCalendar('addEventSource', arr);
					
				});
			},
			
		  eventClick: function(eventObj) {
		      if (eventObj.url) {
		        location.href = eventObj.url;
		      } else {
		        alert('Clicked ' + eventObj.title);
		      }
		    
		  }

			
	  });

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
<button id="btn" onclick="location.href='<%=request.getContextPath() %>/ReserveController?command=reservepage'" type="button" class="btn btn-primary">상담예약</button>
</div>



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