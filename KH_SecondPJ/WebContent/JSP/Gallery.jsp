<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Gallery</title>

<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link href="<%=request.getContextPath() %>/CSS/Gallery.css" rel="stylesheet" id="bootstrap-css">
<!-- 검색창 밑 backgraund_img.css -->
<link href="<%=request.getContextPath()%>/CSS/QAList.css" rel="stylesheet">

<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath() %>/JS/Gallery.js"></script>


</head>

<body>

	<jsp:include page="Header.jsp" flush="false"></jsp:include>


	<!--  최상단 이미지 부분 -->
	<div class="img">
		<!-- img_위에 망 덮어씌움  이유 : 이미지가 색이 강력크 .. ㅋㅌ 방지용  -->
		<div class="img-cover"></div>
	</div>

	<div style="width: 1020px; margin: 50px auto 30px; text-align: center;">

		<h2 style="font-size: 1.5em; font-weight: 680;">Gallery</h2>
	
	</div>

	<hr style="width: 1020px; border: 1px solid #333;">

	<!------ Include the above in your HEAD tag ---------->
	<link rel="stylesheet"
		href="https://use.fontawesome.com/releases/v5.0.13/css/all.css"
		integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp"
		crossorigin="anonymous">

	
		<div class="container" style="margin: 30px auto 120px; width: 1020px;">
			
				
				<div class="row">
					
					<div class="col-lg-3 col-md-4 col-xs-6 thumb">
						<a class="thumbnail" href="#" data-image-id="" data-toggle="modal"
							data-title="" data-image="/KH_SecondPJ/img/gallery01.jpg"
							data-target="#image-gallery"> <img class="img-thumbnail"
							src="/KH_SecondPJ/img/gallery01.jpg" alt="Another alt text">
						</a>
					</div>
					
					<div class="col-lg-3 col-md-4 col-xs-6 thumb">
						<a class="thumbnail" href="#" data-image-id="" data-toggle="modal"
							data-title="" data-image="/KH_SecondPJ/img/gallery02.jpg"
							data-target="#image-gallery"> <img class="img-thumbnail"
							src="/KH_SecondPJ/img/gallery02.jpg" alt="Another alt text">
						</a>
					</div>

					<div class="col-lg-3 col-md-4 col-xs-6 thumb">
						<a class="thumbnail" href="#" data-image-id="" data-toggle="modal"
							data-title="" data-image="/KH_SecondPJ/img/gallery03.jpg"
							data-target="#image-gallery"> <img class="img-thumbnail"
							src="/KH_SecondPJ/img/gallery03.jpg" alt="Another alt text">
						</a>
					</div>
					
					<div class="col-lg-3 col-md-4 col-xs-6 thumb">
						<a class="thumbnail" href="#" data-image-id="" data-toggle="modal"
							data-title="" data-image="/KH_SecondPJ/img/gallery04.jpg"
							data-target="#image-gallery"> <img class="img-thumbnail"
							src="/KH_SecondPJ/img/gallery04.jpg" alt="Another alt text">
						</a>
					</div>
					
					<div class="col-lg-3 col-md-4 col-xs-6 thumb">
						<a class="thumbnail" href="#" data-image-id="" data-toggle="modal"
							data-title="" data-image="/KH_SecondPJ/img/gallery05.jpg"
							data-target="#image-gallery"> <img class="img-thumbnail"
							src="/KH_SecondPJ/img/gallery05.jpg" alt="Another alt text">
						</a>
					</div>

					<div class="col-lg-3 col-md-4 col-xs-6 thumb">
						<a class="thumbnail" href="#" data-image-id="" data-toggle="modal"
							data-title="" data-image="/KH_SecondPJ/img/gallery06.jpg"
							data-target="#image-gallery"> <img class="img-thumbnail"
							src="/KH_SecondPJ/img/gallery06.jpg" alt="Another alt text">
						</a>
					</div>
					
					<div class="col-lg-3 col-md-4 col-xs-6 thumb">
						<a class="thumbnail" href="#" data-image-id="" data-toggle="modal"
							data-title="" data-image="/KH_SecondPJ/img/gallery07.jpg"
							data-target="#image-gallery"> <img class="img-thumbnail"
							src="/KH_SecondPJ/img/gallery07.jpg" alt="Another alt text">
						</a>
					</div>
					<div class="col-lg-3 col-md-4 col-xs-6 thumb">
						<a class="thumbnail" href="#" data-image-id="" data-toggle="modal"
							data-title="" data-image="/KH_SecondPJ/img/gallery08.jpg"
							data-target="#image-gallery"> <img class="img-thumbnail"
							src="/KH_SecondPJ/img/gallery08.jpg" alt="Another alt text">
						</a>
					</div>



					<div class="col-lg-3 col-md-4 col-xs-6 thumb">
						<a class="thumbnail" href="#" data-image-id="" data-toggle="modal"
							data-title="" data-image="/KH_SecondPJ/img/gallery09.jpg"
							data-target="#image-gallery"> <img class="img-thumbnail"
							src="/KH_SecondPJ/img/gallery09.jpg" alt="Another alt text">
						</a>
					</div>
				
					<div class="col-lg-3 col-md-4 col-xs-6 thumb">
						<a class="thumbnail" href="#" data-image-id="" data-toggle="modal"
							data-title="" data-image="/KH_SecondPJ/img/gallery10.jpg"
							data-target="#image-gallery"> <img class="img-thumbnail"
							src="/KH_SecondPJ/img/gallery10.jpg" alt="Another alt text">
						</a>
					</div>
				</div>

				<div class="modal fade" id="image-gallery" tabindex="-1"
					role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-dialog modal-lg">
						<div class="modal-content">
							<div class="modal-header">
								<h4 class="modal-title" id="image-gallery-title"></h4>
								<button type="button" class="close" data-dismiss="modal">
									<span aria-hidden="true">×</span><span class="sr-only">Close</span>
								</button>
							</div>
							<div class="modal-body">
								<img id="image-gallery-image" class="img-responsive col-md-12"
									src="">
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary float-left"
									id="show-previous-image">
									<i class="fa fa-arrow-left"></i>
								</button>

								<button type="button" id="show-next-image"
									class="btn btn-secondary float-right">
									<i class="fa fa-arrow-right"></i>
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>
	
	<jsp:include page="Footer.jsp"></jsp:include>
</body>
</html>