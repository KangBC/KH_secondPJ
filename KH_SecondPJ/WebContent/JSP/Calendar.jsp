<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Dto.*, Dao.*, java.util.*"%>
<%
request.setCharacterEncoding("utf-8");

MemberDto dto = (MemberDto)session.getAttribute("kh_member");

boolean logincheck = false;

if(dto != null){
	logincheck = true;
}
%>
<jsp:include page="Header.jsp"></jsp:include>

<!DOCTYPE html>
<html>
<head>

<link rel='stylesheet' href='../fullcalendar/fullcalendar.min.css' />
<script src="../fullcalendar/lib/jquery.min.js"></script>
<script src='../fullcalendar/lib/moment.min.js'></script>
<script src='../fullcalendar/fullcalendar.min.js'></script>
<script src='../fullcalendar/locale/ko.js'></script>


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
	width: 1020px;
}
.wrapper{
	text-align: center;
}

</style>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div style="width:1020px; margin: 50px auto 30px; text-align: center;">
<h2>Reservation</h2>

<hr style="width: 1020px; border-color: black;">

<div id='calendar'></div>


<button id="btn" class="btn btn-primary" type="button" onclick="location = '<%=request.getContextPath() %>/JSP/About.jsp'" >돌아가기</button>
<button id="btn" class="btn btn-primary" onclick="reserve()" type="button" >상담예약</button>
<button id="btn" class="btn btn-primary" onclick="mylist()" type="button" >내 예약 보기</button>


<br>
<br>
<script>


function reserve(){

	if(!<%= logincheck%>){
		alert("로그인 해 주십시오");
	}else{
		location='<%=request.getContextPath() %>/JSP/Reserve.jsp';
	}
	
	
}

function mylist(){

	if(!<%= logincheck%>){
		alert("로그인 해 주십시오");
	}else{
		location='<%=request.getContextPath() %>/ReserveController?command=mylist';
	}
}


</script>
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