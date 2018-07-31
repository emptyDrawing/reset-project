<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/WEB-INF/views/template/head.jsp"%>
<style type="text/css">
	.table, th, td{
		text-align: center;
	}
	//리뷰
	.reviewBox {
		width: 95%;
		border: 1px solid #e5e5e5;
		margin: 0px auto;
		clear: both;
	}
	/* reviewBox 위치 */
	.left_img_box {
		width: 25%;
		display: inline-block;
		float: left;
		text-align: center;
		margin: 6px 0px;
	}
	
	.right_content_box {
		width: 75%;
		float: right;
	}
	
	.right_content_box p {
		margin: 0px;
		display: inline-block;
	}
	
	.rightBox>label>img {
		width: 15px;
	}
	
	.emptyImg {
		width: 133px;
		margin: 24px 0px;
	}
	
	.right_content_top {
		float: right;
	}
	
	.right_content_bottom {
		margin-top: 5px;
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
	/* reviewBox 위치 */
</style>
<script type="text/javascript">
	  $(function(){
		cartList();
      });
	 
	  function cartList(){
		  	var email="cus1@naver.com";
			var Data= {"email":email};
			$.ajax({
			        type: 'POST', // get 방식으로 요청
					dataType: 'text',
					url: "${goRoot}item/cart", // 데이터를 불러오는 json-server 주소입니다 .
					data: Data,
					success:function(result){
						$("#cart").html(result);
					}
			})
			.fail(function () { // 실패했을때 불러질 함수
				console.error('데이터 불러오기 실패');
			})
		} 
	
	</script>
</head>
<body>
	<%@include file="/WEB-INF/views/template/menu.jsp"%>

	<!-- main contents -->
	<div class="page_container">

		<h1>회원정보</h1>
		<div id="info">
			<table class="table">
				<tr>
					<th>이메일</th>
					<th>닉네임</th>
					<th>성별</th>
					<th>나이</th>
					<th>피부타입</th>
					<th>핸드폰 번호</th>
					<th>참여도</th>
				</tr>
				<tr>
					<td>${bean.email }</td>
					<td>${bean.nick }</td>
					<td>${bean.gender }</td>
					<td>${bean.age }</td>
					<td>${bean.skin }</td>
					<td>${bean.phone }</td>
					<td>${bean.exp }</td>
				</tr>
			</table>
		</div>

		<h1>찜목록</h1>
		<div class="welcome_line">
			<img src="${goRoot }imgs/welcome_bg.png">
		</div>
		<div id="cart"></div>
		<h1>리뷰</h1>
		<div class="welcome_line">
			<img src="${goRoot }imgs/welcome_bg.png">
		</div>
		<div id="review">
			<c:choose>
				<c:when test="${review_alist == '[]'}">
				</c:when>
				<c:when test="${review_alist != '[]'}">
					<c:forEach items="${review_alist }" var="review">
						<a href="${goRoot }item/${review.item }/review/${review.rev_no}">
							<div class="reviewBox">
								<div class="left_img_box">
									<c:choose>
										<c:when test="${review.img != ''}">
											<img src="${goRoot}${review.img}" />
										</c:when>
										<c:when test="${review.img == ''}">
											<img class="emptyImg" src="${goRoot}imgs/thany.png" />
										</c:when>
									</c:choose>
								</div>
								<div class="right_content_box">
									<div class="right_content_top">
										<span class="rightBox"> <label> <img
												src="${goRoot}imgs/icon/like.png"> ${review.pop }
										</label> <label>/ ${review.nalja }</label>
										</span>
									</div>
									<div class="right_content_bottom">
										<p>${review.writer }<br> <span class="sub-title">${review.age }세
												/ ${review.skin } / ${review.gender } / </span>
										</p>
										<c:choose>
											<c:when test="${review.star == 1}">
												<div class="starRating1">
													<img class="star" src="${goRoot}imgs/icon/grade_img.png">
												</div>
											</c:when>
											<c:when test="${review.star == 2}">
												<div class="starRating2">
													<img class="star" src="${goRoot}imgs/icon/grade_img.png">
												</div>
											</c:when>
											<c:when test="${review.star == 3}">
												<div class="starRating3">
													<img class="star" src="${goRoot}imgs/icon/grade_img.png">
												</div>
											</c:when>
											<c:when test="${review.star == 4}">
												<div class="starRating4">
													<img class="star" src="${goRoot}imgs/icon/grade_img.png">
												</div>
											</c:when>
											<c:when test="${review.star == 5}">
												<div class="starRating5">
													<img class="star" src="${goRoot}imgs/icon/grade_img.png">
												</div>
											</c:when>
										</c:choose>
										<br> <br>
										<p>${review.good }</p>
										<br>
										<p>${review.bad }</p>
									</div>
								</div>
							</div>
						</a>
						<img src="${goRoot }imgs/welcome_bg.png">
					</c:forEach>
				</c:when>
			</c:choose>
		</div>
		
		<h1>댓글</h1>
		<div class="welcome_line">
			<img src="${goRoot }imgs/welcome_bg.png">
		</div>
		<div id="comment">
			<c:choose>
				<c:when test="${comment_alist == '[]'}">
				</c:when>
				<c:when test="${comment_alist != '[]'}">
					${comment_alist }
				</c:when>
			</c:choose>
		</div>
	</div>
	<!-- //main contents -->


	<%@include file="/WEB-INF/views/template/footer.jsp"%>
</body>
</html>
