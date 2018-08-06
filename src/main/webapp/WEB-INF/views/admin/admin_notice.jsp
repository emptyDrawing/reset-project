<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.Date"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE>
<html>
<head>
<%@include file="/WEB-INF/views/template/admin_header.jsp"%>

<style type="text/css">

.modal, .container {
	font-family: NanumSquareR;
	font-size: 18px;
}

h1 {
	font-size: 3vmax;
	font-family: NanumSquareB;
	color: #303030;
}

.nohead, .nodiv, .naljahead, .naljadiv, .newhead, .newdiv, .titlehead,
	.titlediv {
	text-align: center;
	border-bottom: 1px solid #DDDDDD;
	display: inline-block;
	float: left;
	margin: none;
	border-collapse: collapse;
	padding: 10px;
	font-family: NanumSquareR;
	font-size: 20px;

}

.nohead, .nodiv {
	width: 20%;
}

.naljadiv, .naljahead {
	width: 15%;
}

.titlehead, .titlediv {
	width: 65%;
}

.titlediv {
	text-overflow: ellipsis;
	white-space: nowrap;
	overflow: hidden;
}

.mytable {
	border-collapse: collapse;
	text-align: center;
}

.newbtn {
	background-color: #d00b01;
	-moz-border-radius: 2px;
	-webkit-border-radius: 2px;
	border-radius: 8px;
	display: inline-block;
	cursor: pointer;
	color: #ffffff;
	font-family: Arial;
	font-size: 2px;
	padding: 3px 6px;
	text-decoration: none;
}

.modal-footer button {
	display: inline-block;
}

.deleteForm {
	display: inline-block;
}

.redbtn {
	background-color: #d00b01;
	-moz-border-radius: 3px;
	-webkit-border-radius: 3px;
	border-radius: 3px;
	border: 1px solid #D00B01;
	display: inline-block;
	cursor: pointer;
	color: #ffffff;
	font-family: Arial;
	font-size: 15px;
	font-weight: bold;
	padding: 11px 23px;
	text-decoration: none;
}

.redbtn:active {
	position: relative;
	top: 1px;
}

.greybtn {
	background-color: #D1D1D1;
	-moz-border-radius: 3px;
	-webkit-border-radius: 3px;
	border-radius: 3px;
	border: 1px solid #D1D1D1;
	display: inline-block;
	cursor: pointer;
	color: #ffffff;
	font-family: Arial;
	font-size: 15px;
	font-weight: bold;
	padding: 11px 23px;
	text-decoration: none;
}

.greybtn:active {
	position: relative;
	top: 1px;
}

.blackbtn {
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
	padding: 11px 23px;
	text-decoration: none;
	position: relative;
}

.blackbtn:active {
	position: relative;
	top: 1px;
}

.addbtns {
	display: inline-block;
	float: right;
}

.hidebtn {
	display: block;
	float: right;
}

.addNotice{
	margin-top : 30px;
	}

.notice_boder {
	border-bottom: 1px solid #DDDDDD;
}
</style>
    </head>
<body>
	<div id="wrapper">
		<%@include file="/WEB-INF/views/template/admin_side_menu.jsp"%>
		<div id="page-wrapper">
			<div class="container-fluid">
				<!-- 컨탠츠 시작 -->

				<!-- 입력하기 -->
				<div class="modal fade bs-example-modal-lg" tabindex="-1"
					role="dialog" aria-labelledby="myLargeModalLabel">
					<div class="modal-dialog modal-lg" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h4>입력페이지</h4>
							</div>
							<div class="modal-body">
								<form action="/admin/notice/${bean.no_no }" method="post">
									<!-- TODO [jihyun] reset -->
									<div class="form-group">
										<label for="name">제목</label> <input type="text"
											class="form-control" name="title" id="title" placeholder="제목을 입력하세요" />
									</div>
									<div class="form-group">
										<label for="content">내용</label> <!-- <input type="text"
											class="form-control" name="content" id="content"
											placeholder="공지사항 내용" /> -->
									<textarea class="form-control" rows="5" name="content" id="content"
													placeholder="공지내용을 입력하세요"></textarea>
									</div>
									<div class="addbtns">
										<button type="submit" class="redbtn">입력</button>
										<button type="button" class="greybtn" data-dismiss="modal">Close</button>
									</div>
								</form>
								<br> <br>
							</div>

						</div>
					</div>
				</div>

				<!-- 입력페이지 끝-->


				<!-- list 시작 -->
				<div class="container">

					<h1>공지사항</h1>
					<br> <br>
					<div class="nohead mytable">글번호</div>
					<div class="titlehead mytable">제목</div>
					<div class="naljahead mytable">날짜</div>

					<c:forEach items="${alist }" var="bean">
						<jsp:useBean id="now" class="java.util.Date" />
						<c:set var="nowdate" scope="request">
							<fmt:formatDate value="${now}" />
						</c:set>
						<c:set var="nalja" scope="request">
							<fmt:formatDate value="${bean.nalja}" />
						</c:set>


						<div data-toggle="modal" data-target="#myModal-${bean.no_no }">
							<div class="notice_border">
								<!-- 	<!-- 배너 새 글 작성시에만 뜨도록 choose문 작성할 것-->
								<!-- <div class="badge pull-right">New</div> -->
								<div class="nodiv mytable">${bean.no_no }</div>
								<div class="titlediv mytable">
									<c:if test="${nalja == nowdate}">
									<a href="#" class="newbtn">new</a>
									</c:if>&nbsp;&nbsp;${bean.title }
								</div>
								<div class="naljadiv mytable">${bean.nalja }</div>
							</div>
						</div>
						<!-- Modal -->
						<div class="modal fade yourModal" id="myModal-${bean.no_no }"
							tabindex="-1" role="dialog"
							aria-labelledby="myModalLabel-${bean.no_no }">
							<div class="modal-dialog" role="document">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal"
											aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
										<h4 class="modal-title" id="myModalLabel-${bean.no_no }">${bean.no_no }번
											공지사항</h4>
									</div>
									<div class="modal-body">
										<form action="/admin/notice/${bean.no_no }"
											method="POST" class="detailForm" accept-charset="UTF-8">
											<input type="hidden" name="_method" value="put">
											<div class="form-group">
												<label for="no_no">글번호</label>
												<div class="well well-sm">${bean.no_no }</div>
												<input type="hidden" value="${bean.no_no }"
													class="form-control" name="no_no" id="no_no"
													placeholder="사번" />
											</div>
											<div class="form-group">
												<label>작성일</label>
												<div class="well well-sm">${bean.nalja }</div>
											</div>
											<div class="form-group">
												<label for="title">제목</label>
												<div class="well well-sm well-input">${bean.title }</div>
												<input type="text" value="${bean.title }"
													class="form-control" name="title" id="title"
													placeholder="제목을 입력하세요" />
											</div>
											<div class="form-group">
												<label for="content">내용</label>
												<div class="well well-sm well-input">${bean.content }</div>
												<textarea value="${bean.content }" class="form-control" rows="5" name="content" id="content"
													placeholder="내용을 입력하세요"></textarea>
											<%-- 	<input type="text" value="${bean.content }"
													class="form-control" name="content" id="content"
													placeholder="내용" /> --%>
											</div>
											<div class="hidebtn">
												<input type="submit" class="blackbtn" value="수정" /> <input
													type="button" class="greybtn" data-dismiss="modal"
													value="Close" id="close" />
											</div>
										</form>
										<script type="text/javascript">
											function detail() {
												$('.detailForm input').hide();
												$('.modal-title').html('상세페이지');
												$('.well-input').show();
												$('.modal-footer').show();
											}
											function edit() {
												$('.detailForm input').show();
												$('.modal-title').html('수정페이지');
												$('.modal-footer').hide();
											}

											$(function() {
												detail();
												$('.edit')
														.click(
																function() {
																	edit();
																	$('#close')
																			.click(
																					function() {
																						detail();
																					});
																});

											});
										</script>
									</div>
									<!-- TODO 수정하기 -->

									<div class="modal-footer">
										<button type="button" class="greybtn showlistbtn"
											data-dismiss="modal">목록보기</button>
										<button type="button" class="blackbtn edit">수정</button>

										<form action="/admin/notice/${bean.no_no }"
											method="POST" class="deleteForm">
											<input type="hidden" name="_method" value="delete" />
											<button type="submit" class="redbtn delete">삭제</button>
										</form>

									</div>
									<!-- modal footer end  -->

								</div>
							</div>
						</div>
					</c:forEach>

					<!-- TODO [jihyun]notice - 관리자 로그인시 보이게 되는 입력버튼 -->
					<%-- <c:if test="${login_on==true && !(login_user_type='일반')}">--%>
					<button type="button" class="addNotice redbtn pull-right"
						data-toggle="modal" data-target=".bs-example-modal-lg">입력하기</button>
					<%--</c:if> --%>
				</div>
				<br>
				<br>
				<!-- 컨탠츠 끝 -->
			</div>
			<!-- /.container-fluid -->
		</div>
		<!-- /#page-wrapper -->
	</div>
	<!-- /#wrapper -->

</body>
</html>
