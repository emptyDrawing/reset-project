<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/WEB-INF/views/template/admin_header.jsp"%>
<link href="${goRoot }css/btn/btn.css" rel="stylesheet">
<style type="text/css">
#eventNum {
	width: 20%;
	display: inline-block;
}
.eve_addrTitle{
	font-size: 3vmax;
}
.eve_addrTot{
	font-size: 2vmax;
	margin-top: 30px;
	margin-bottom: 30px;
}

</style>
</head>
<body>
	<div id="wrapper">
		<%@include file="/WEB-INF/views/template/admin_side_menu.jsp"%>
		<div id="page-wrapper">
			<div class="container-fluid">
				<!-- 컨탠츠 시작 -->
				<!-- main contents -->
				<div class="page_container">
					<!-- 내용 입력 시작 -->
					<div class="eve_addrTitle">${event_detail.title}</div>
					<div class="eve_addrTot">총 참가인원 : ${tot }</div>
					<!-- 아코디언 시작 -->
					<div class="panel-group" id="accordion" role="tablist"
						aria-multiselectable="true">
						<c:forEach items="${detail }" var="bean" varStatus="status">
							<div class="panel panel-default">
								<div class="panel-heading" role="tab" id="headingOne">
									<h4 class="panel-title">
										<a role="button" data-toggle="collapse"
											data-parent="#accordion" href="#collapse_${bean.add_no}"
											aria-expanded="true" aria-controls="collapseOne"> <span>${(tot - status.index) - ( (paging.currentPageNo - 1)  *  10 ) }
										</span> ${bean.add_no} : ${bean.name}
										</a>
									</h4>
								</div>
								<div id="collapse_${bean.add_no}"
									class="panel-collapse collapse" role="tabpanel"
									aria-labelledby="headingOne">
									<div class="panel-body">
										<div>
											<label for="name">이름 : </label> <span id="name" name="name">${bean.name}</span>
										</div>
										<div>
											<label for="email">이메일 : </label> <span id="email"
												name="email">${bean.email}</span>
										</div>
										<div>
											<label for="phone">전화번호 : </label> <span id="phone"
												name="phone">${bean.phone}</span>
										</div>
										<div>
											<label for="postcode">우편번호 : </label> <span id="postcode"
												name="postcode">${bean.postcode }</span>
										</div>
										<div>
											<label for="address">주소 : </label> <span id="address"
												name="address">${bean.address }</span>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
					<!-- 아코디언 끝 -->
					<div>
						<form action="/reset/admin/eveaddr/${eve_no }" method="post">
							<span><input type="text" name="eventNum" id="eventNum"
								class="form-control" placeholder="당첨인원수를 적어주세요."></span> <span><button
									type="submit" class="darkBtn">당첨자 조회</button></span>
						</form>
					</div>

					<!-- 내용 입력 끝 -->
					<div>
						<!-- 페이징  -->
						<c:choose>
							<c:when
								test="${paging.numberOfRecords ne NULL and paging.numberOfRecords ne '' and paging.numberOfRecords ne 0}">
								<div class="text-center marg-top">
									<ul class="pagination">
										<c:if test="${paging.currentPageNo gt 5}">
											<!-- 현재 페이지가 5보다 크다면(즉, 6페이지 이상이라면) -->
											<li><a
												href="javascript:goPage(${paging.prevPageNo}, ${paging.maxPost})">이전</a></li>
											<!-- 이전페이지 표시 -->
										</c:if>
										<!-- 다른 페이지를 클릭하였을 시, 그 페이지의 내용 및 하단의 페이징 버튼을 생성하는 조건문-->
										<c:forEach var="i" begin="${paging.startPageNo}"
											end="${paging.endPageNo}" step="1">
											<!-- 변수선언 (var="i"), 조건식, 증감식 -->
											<c:choose>
												<c:when test="${i eq paging.currentPageNo}">
													<li class="active"><a
														href="javascript:goPage(${i}, ${paging.maxPost})">${i}</a></li>
													<!-- 1페이지부터 10개씩 뽑아내고, 1,2,3페이지순으로 나타내라-->
												</c:when>
												<c:otherwise>
													<li><a
														href="javascript:goPage(${i}, ${paging.maxPost})">${i}</a></li>
												</c:otherwise>
											</c:choose>
										</c:forEach>
										<!-- begin에 의해서 변수 i는 1이기 때문에, 처음에는 c:when이 수행된다. 그 후 페이징의 숫자 2를 클릭하면 ${i}는 2로변하고, 현재는 ${i}는 1이므로 otherwise를 수행한다
							         그래서 otherwise에 있는 함수를 수행하여 2페이지의 게시물이 나타나고, 반복문 실행으로 다시 forEach를 수행한다. 이제는 i도 2이고, currentPageNo도 2이기 때문에
							     active에 의해서 페이징부분의 2에 대해서만 파란색으로 나타난다. 그리고 나머지 1,3,4,5,이전,다음을 표시하기위해 다시 c:otherwise를 수행하여 페이징도 나타나게한다.-->
										<!-- // 다른 페이지를 클릭하였을 시, 그 페이지의 내용 및 하단의 페이징 버튼을 생성하는 조건문-->

										<!-- 소수점 제거 =>-->
										<fmt:parseNumber var="currentPage" integerOnly="true"
											value="${(paging.currentPageNo-1)/5}" />
										<fmt:parseNumber var="finalPage" integerOnly="true"
											value="${(paging.finalPageNo-1)/5}" />

										<c:if test="${currentPage < finalPage}">
											<!-- 현재 페이지가 마지막 페이지보다 작으면 '다음'을 표시한다. -->
											<li><a
												href="javascript:goPage(${paging.nextPageNo}, ${paging.maxPost})">다음</a></li>
										</c:if>
									</ul>
								</div>
							</c:when>
						</c:choose>
					</div>
				</div>
				<!-- //main contents -->
				<!-- 컨탠츠 끝 -->
			</div>
			<!-- /.container-fluid -->
		</div>
		<!-- /#page-wrapper -->
	</div>
	<!-- /#wrapper -->



	<script>
		function goPage(pages, lines) {
			location.href = '?' + "pages=" + pages;
		}
	</script>
</body>
</html>
