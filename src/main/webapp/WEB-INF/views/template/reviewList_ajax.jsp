<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:forEach items="${alist}" var="review">
			<a href="./${item }/review/${review.rev_no}">
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
							<span class="rightBox"> <label><img
									src="${goRoot}imgs/icon/like.png"> ${review.pop }</label> <label>/
									${review.nalja }</label>
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
		</c:forEach>