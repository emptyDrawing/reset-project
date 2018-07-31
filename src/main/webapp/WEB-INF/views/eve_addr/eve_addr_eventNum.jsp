<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/WEB-INF/views/template/admin_header.jsp"%>
<link href="${goRoot }css/btn/btn.css" rel="stylesheet">
</head>
<body>
	<script>
		jArray = new Array();
	</script>
	<div id="wrapper">
		<%@include file="/WEB-INF/views/template/admin_side_menu.jsp"%>
		<div id="page-wrapper">
			<div class="container-fluid">
				<!-- 컨탠츠 시작 -->
				<div class="page_container">
					<!-- 내용 입력 시작 -->
					<div>
						<h1>${event_detail.title }당첨자 결과</h1>
					</div>
					<!-- 아코디언 시작 -->
					<form action="/reset/admin/eveaddr/${eve_no}/print" method="post">
						<div class="panel-group" id="accordion" role="tablist"
							aria-multiselectable="true">
							<c:forEach items="${detail }" var="bean" varStatus="status">
								<div class="panel panel-default">
									<div class="panel-heading" role="tab" id="headingOne">
										<h4 class="panel-title">
											<a role="button" data-toggle="collapse"
												data-parent="#accordion" href="#collapse_${bean.add_no}"
												aria-expanded="true" aria-controls="collapseOne">
												${bean.add_no} : ${bean.name} </a>
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
								<script>
									var obj = new Object();
									obj.title = "${event_detail.title }";
									obj.name = "${bean.name}";
									obj.email = "${bean.email}";
									obj.phone = "${bean.phone}";
									obj.postcode = "${bean.postcode}";
									obj.address = "${bean.address}";
									jArray.push(obj);
								</script>
							</c:forEach>
						</div>
						<div>
							<button type="button" id="extractionBtn" class="redBtn">txt파일로 추출</button>
							<span id="extractionText">
							
							</span>
						</div>
					</form>
					<script type="text/javascript">
						$("#extractionBtn").on("click",function(event) {
								event.preventDefault();
								$.ajax({
									url : "/reset/admin/eveaddr/${eve_no}/print",
									type : "POST",
									data : JSON
											.stringify(jArray),
									contentType : "application/json",
									success : function(data) {
										console.log("성공");
									},
									error : function(data) {
										console.log("실패");
									}
								}).done(function(data) {
									console.log(data);
								var str = "<a href='/reset/admin/eveaddr/download?text="
										+ data
										+ "'><span class='darkBtn'>"
										+ data
										+ "</span></a>";
								$("#extractionText").html(str);
									});
						});
					</script>
					<!-- 아코디언 끝 -->
					<!-- 내용 입력 끝 -->
				</div>
				<!-- //main contents -->
				<!-- 컨탠츠 끝 -->
			</div>
			<!-- /.container-fluid -->
		</div>
		<!-- /#page-wrapper -->
	</div>
	<!-- /#wrapper -->
	<!-- main contents -->
</body>
</html>
