<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style type="text/css">
.top-text{
	padding:15px;
	line-height: 20px;
	color: #999;
}
</style>
<script>
	var getCountSession = function(){
		var $target = $("#nowSession");
		var sendData = "resultType=int";
		$.post("${goRoot}admin/ajax/session-cnt",sendData)
		.done(function(data){
			if(data.result==200){
				$target.text(data.result_data);
			}
		});

	}
	
	var getCountLogin = function(){
		var $target = $("#nowLogin");
		var sendData = "resultType=int";
		$.post("${goRoot}admin/ajax/login-cnt",sendData)
		.done(function(data){
			if(data.result==200){
				$target.text(data.result_data);
			}
		});
	}
	
	$(function(){
		// 30초 watch
		getCountSession();
		getCountLogin();
		
		// 30초 watch
		setInterval(function(){
			getCountSession();
			getCountLogin();
		},30000);
		
	})
</script>
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
	<!-- Brand and toggle get grouped for better mobile display -->
	<div class="navbar-header">
		<button type="button" class="navbar-toggle" data-toggle="collapse"
			data-target=".navbar-ex1-collapse">
			<span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span>
			<span class="icon-bar"></span> <span class="icon-bar"></span>
		</button>
		<a class="navbar-brand" href="${goRoot}admin/">${login_comName}-Admin</a>
	</div>
         <!-- Top Menu Items -->
            <ul class="nav navbar-right top-nav">
                <li><p class="top-text">방문객&nbsp; &nbsp;<span class="badge" id="nowSession">0</span></p></li>                   
				<li><p class="top-text">로그인&nbsp; &nbsp;<span class="badge" id="nowLogin">0</span></p></li>
                <li><a href="${goRoot}logout/">LOGOUT</a></li>
        	</ul>

	<!-- Sidebar Menu Items - These collapse to the responsive navigation menu on small screens -->
<div class="collapse navbar-collapse navbar-ex1-collapse">
		<ul class="nav navbar-nav side-nav">
			<li class="active"><a href="${goRoot}admin/">Dashboard</a></li>
			<li><a href="javascript:;" data-toggle="collapse" data-target="#menu1">회원관리</a>
				<ul id="menu1" class="collapse">
					<li><a href="${goRoot}admin/member/normal/">일반회원</a></li>
					<li><a href="${goRoot}admin/member/company/">기업회원</a></li>
					<li><a href="${goRoot}admin/member/emp/">직원관리</a></li>
					<li><a href="${goRoot}admin/sign/add/">회원등록</a></li>
				</ul>
			</li>
			<li><a href="javascript:;" data-toggle="collapse" data-target="#menu2">홈페이지관리</a>
				<ul id="menu2" class="collapse">
					<!-- TODO:[kss]나중에 추가 <li><a href="${goRoot}admin/page/login/">로그인페이지</a></li> -->
					<li><a href="${goRoot}admin/qna">문의사항</a></li>
					<li><a href="${goRoot}admin/notice">공지사항</a></li>
				</ul>
			</li>
			<!-- <li><a href="${goRoot}admin/review">리뷰</a></li> -->
			<li><a href="${goRoot}admin/magazine">매거진</a></li>
			<li><a href="${goRoot}admin/event">이벤트</a></li>
			<li><a href="${goRoot}admin/item">상품관리</a></li>
			<li><a href="javascript:;" data-toggle="collapse" data-target="#menu3">통계</a>
				<ul id="menu3" class="collapse">
					<li><a href="${goRoot}admin/chart/login/">접속자수</a></li>
					<li><a href="${goRoot}admin/chart/review/">리뷰</a></li>
					<li><a href="${goRoot}admin/chart/magzine/">매거진</a></li>
					<li><a href="${goRoot}admin/chart/event/">이벤트</a></li>
					<li><a href="${goRoot}admin/chart/like/">좋아요</a></li>
				</ul>
			</li>
			<li><a href="javascript:;" data-toggle="collapse" data-target="#menu4">로그</a>
				<ul id="menu4" class="collapse">
					<li><a href="${goRoot}admin/log/normal/">전체로그</a></li>
					<li><a href="${goRoot}admin/log/error/">에러로그</a></li>
				</ul>
			</li>
		</ul>
	</div>
</nav>
<!-- /.navbar-collapse -->