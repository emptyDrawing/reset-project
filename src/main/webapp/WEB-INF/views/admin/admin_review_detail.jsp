<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/WEB-INF/views/template/admin_header.jsp"%>
<style type="text/css">
/* 전체 container */
.page_container {
	width: 80%;
	border: 1px solid rgb(217, 222, 232);
}

.avgBox {
	width: 95%;
	margin: 0px auto;
	border: 1px solid #e5e5e5;
}

.avgBox>table>tbody>tr>td:first-child {
	width: 10%;
	text-align: center;
}

.bar1 {
	background-image: -webkit-linear-gradient(top, #bd0026 0, #bd0026 100%);
}

.bar2 {
	background-image: -webkit-linear-gradient(top, #f03b20 0, #f03b20 100%);
}

.bar3 {
	background-image: -webkit-linear-gradient(top, #fd8d3c 0, #fd8d3c 100%);
}

.bar4 {
	background-image: -webkit-linear-gradient(top, #fecc5c 0, #fecc5c 100%);
}

.bar5 {
	background-image: -webkit-linear-gradient(top, #fee0d2 0, #fee0d2 100%);
}

.reviewBox {
	width: 95%;
	border: 1px solid #e5e5e5;
	margin: 0px auto;
}

.reviewBox>img {
	width: 100%;
}

.reviewBox>p {
	display: inline-block;
	margin: 20px 0px 0px 20px;
}

.reviewBox>label {
	margin: 0px 0px 0px 20px;
}

.icon {
	text-align: center;
	margin: 5px 0px;
}

.btn-color {
	color: white;
	background-image: -webkit-gradient(linear, left top, left bottom, from(#F5515F),
		to(#A1051D));
}

.btn-position {
	text-align: center;
	margin: 5px 0px;
}

.btn-file {
	position: relative;
	overflow: hidden;
}

.btn-file input[type=file] {
	position: absolute;
	top: 0;
	right: 0;
	min-width: 100%;
	min-height: 100%;
	font-size: 100px;
	text-align: right;
	filter: alpha(opacity = 0);
	opacity: 0;
	outline: none;
	background: white;
	cursor: inherit;
	display: block;
}

#img_preview img {
	width: 100%;
}

.RedBtn {
	background-color: #dd2d25;
	-moz-border-radius: 3px;
	-webkit-border-radius: 3px;
	border-radius: 3px;
	border: 1px solid #dd2d25;
	display: inline-block;
	cursor: pointer;
	color: #ffffff;
	font-family: Arial;
	font-size: 15px;
	font-weight: bold;
	padding: 5px 15px;
	margin: 5px 5px;
	text-decoration: none;
}

.RedBtn:hover {
	color: #fff;
	background-color: #d00b01;
}

.RedBtn:active {
	position: relative;
	top: 1px;
}

.darkBtn {
	background-color: #313131;
	-moz-border-radius: 3px;
	-webkit-border-radius: 3px;
	border-radius: 3px;
	border: 1px solid #313131;
	display: inline-block;
	cursor: pointer;
	color: #ffffff;
	font-family: Arial;
	font-size: 15px;
	font-weight: bold;
	padding: 5px 15px;
	margin: 5px 5px;
	text-decoration: none;
}

.darkBtn:hover {
	color: #fff;
	background-color: #313131;
}

.darkBtn:active {
	position: relative;
	top: 1px;
}

.sub-title {
	color: #84868e;
}

.star {
	width: 80px;
}

.starRating1 {
	display: inline-block;
	overflow: hidden;
	width: 16px;
	margin: 0px 0px -3px 0px;
}

.starRating2 {
	display: inline-block;
	overflow: hidden;
	width: 32px;
	margin: 0px 0px -3px 0px;
}

.starRating3 {
	display: inline-block;
	overflow: hidden;
	width: 48x;
	margin: 0px 0px -3px 0px;
}

.starRating4 {
	display: inline-block;
	overflow: hidden;
	width: 64px;
	margin: 0px 0px -3px 0px;
}

.starRating5 {
	display: inline-block;
	overflow: hidden;
	width: 80px;
	margin: 0px 0px -3px 0px;
}

.btn.focus, .btn:focus, .btn:hover {
	color: #fff;
}

.btimg { /* 좋아요 아이콘 */
	margin: 2% 1%;
	width: 4.7%;
}

.popDiv {
	text-align: center;
}
/* modal */
.form-group {
	height: 90px;
}

.form-group>label {
	text-align: center;
}

.imgDiv label {
	display: inline-block;
	padding: .5em .75em;
	font-size: inherit;
	line-height: normal;
	color: #ffffff;
	vertical-align: middle;
	background-color: #313131;
	cursor: pointer;
	border: 1px solid #313131;
	border-bottom-color: #313131;
	border-radius: .25em;
}

.imgDiv input[type="file"] { /* 파일 필드 숨기기 */
	position: absolute;
	width: 1px;
	height: 1px;
	padding: 0;
	margin: -1px;
	overflow: hidden;
	clip: rect(0, 0, 0, 0);
	border: 0;
}

.textbox {
	width: 100%;
}
/* 댓글 스타일 */
.com_div {
	display: inline-block;
	margin-bottom: 10px;
}

.com_nalja {
	margin-left: 85%;
}

.com_hr {
	width: 100%;
	margin-bottom: 1%;
}

.comBtn {
	margin-left: 90%;
}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		var option = 1;

		$("#reivewDelete").on("click", function() {
			var item = ${item_bean.item	};
			var rev_no = ${review_bean.rev_no};
			var formData = new FormData($('#review')[0]);
			$.ajax({
				type : "delete",
				enctype : 'multipart/form-data',
				data : formData,
				url : "/admin/" + item + "/review/" + rev_no,
				contentType : false,
				processData : false,
				dataType : "text"
			}).done(function(data) {
				expDown("review");
				console.log(data);
				if (data == "1") {
					console.log("성공");
					window.location.href = "/item/" + item;
				} else if (data == "0") {
					alert("글삭제에 실패하였습니다.");
				}
			}).fail(function() { // 실패했을때 불러질 함수
				console.error('데이터 삭제 실패');
			})
		})

	});
</script>
</head>
<body>
	<!--header-->
	<div id="wrapper">
		<%@include file="/WEB-INF/views/template/admin_side_menu.jsp"%>
		<div id="page-wrapper">
			<div class="container-fluid">
				<!-- Page Heading -->
				<!-- main contents -->
				<div class="page_container">
					<div class="avgBox">
						<p>
							점수 총 <span>${map.total }</span>명 <span>${item_bean.tot }</span>점
						</p>
						<table class="table">
							<tr>
								<td><span>5점</span></td>
								<td>
									<div class="progress">
										<div class="progress-bar progress-bar bar1" role="progressbar"
											aria-valuemin="0" aria-valuemax="100"
											style="width: ${map.five }%">${map.five }%</div>
									</div>
								</td>
							</tr>
							<tr>
								<td><span>4점</span></td>
								<td>
									<div class="progress">
										<div class="progress-bar progress-bar bar2" role="progressbar"
											aria-valuemin="0" aria-valuemax="100"
											style="width: ${map.four }%">${map.four }%</div>
									</div>
								</td>
							</tr>
							<tr>
								<td><span>3점</span></td>
								<td>
									<div class="progress">
										<div class="progress-bar progress-bar bar3" role="progressbar"
											aria-valuemin="0" aria-valuemax="100"
											style="width: ${map.three }%">${map.three }%</div>
									</div>
								</td>
							</tr>
							<tr>
								<td><span>2점</span></td>
								<td>
									<div class="progress">
										<div class="progress-bar progress-bar bar4" role="progressbar"
											aria-valuemin="0" aria-valuemax="100"
											style="width: ${map.two }%">${map.two }%</div>
									</div>
								</td>
							</tr>
							<tr>
								<td><span>1점</span></td>
								<td>
									<div class="progress">
										<div class="progress-bar progress-bar bar5" role="progressbar"
											aria-valuemin="0" aria-valuemax="100"
											style="width: ${map.one }%">${map.one }%</div>
									</div>
								</td>
							</tr>
						</table>

					</div>
					<c:if test="${login_on=='true' && (login_user_type == 'CEO' || login_user_type=='직원') }">
						<div class="btn-position">
							<button type="button" class="btn-lg RedBtn" data-toggle="modal"
								data-target="#review_delete">삭제</button>
						</div>
					</c:if>

					<div class="reviewBox">
						<c:choose>
							<c:when test="${review_bean.img != ''}">
								<img src="${goRoot}${review_bean.img }" />
							</c:when>
						</c:choose>
						<br>
						<p>${review_bean.writer }<br> <span class="sub-title">${review_bean.age }세
								/ ${review_bean.skin } / ${review_bean.gender } / </span>
						</p>
						<c:choose>
							<c:when test="${review_bean.star == 1}">
								<div class="starRating1">
									<img class="star" src="${goRoot}imgs/icon/grade_img.png">
								</div>
							</c:when>
							<c:when test="${review_bean.star == 2}">
								<div class="starRating2">
									<img class="star" src="${goRoot}imgs/icon/grade_img.png">
								</div>
							</c:when>
							<c:when test="${review_bean.star == 3}">
								<div class="starRating3">
									<img class="star" src="${goRoot}imgs/icon/grade_img.png">
								</div>
							</c:when>
							<c:when test="${review_bean.star == 4}">
								<div class="starRating4">
									<img class="star" src="${goRoot}imgs/icon/grade_img.png">
								</div>
							</c:when>
							<c:when test="${review_bean.star == 5}">
								<div class="starRating5">
									<img class="star" src="${goRoot}imgs/icon/grade_img.png">
								</div>
							</c:when>
						</c:choose>
						<span class="sub-title">${review_bean.nalja }</span> <br> <br>
						<label>좋은점</label><br>
						<p>${review_bean.good }</p>
						<br> <br> <label>나쁜점</label><br>
						<p>${review_bean.bad }</p>
						<br> <br> <label>꿀팁</label><br>
						<p>${review_bean.tip }</p>

					</div>
				</div>
				<!--footer-->
			</div>
			<!-- /.container-fluid -->
		</div>
		<!-- /#page-wrapper -->
	</div>
	<!-- /#wrapper -->
	<!--//footer-->
</body>
</html>