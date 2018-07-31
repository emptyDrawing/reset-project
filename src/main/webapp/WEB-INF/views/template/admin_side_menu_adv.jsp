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
	$(function(){
		// 30초 watch
		
		// 30초 watch
		setInterval(function(){
			
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
                <li><a href="${goRoot}logout/">LOGOUT</a></li>
        	</ul>

	<!-- Sidebar Menu Items - These collapse to the responsive navigation menu on small screens -->
<div class="collapse navbar-collapse navbar-ex1-collapse">
		<ul class="nav navbar-nav side-nav">
			<li class="active"><a href="${goRoot}admin/">Dashboard</a></li>
			<li><a href="${goRoot}admin/notice">공지사항</a></li>
			<li><a href="${goRoot}admin/reviews/list/">리뷰</a></li>
			<li><a href="${goRoot}admin/magazines/list/">매거진</a></li>
			<li><a href="${goRoot}admin/events/list/">이벤트</a></li>
			<li><a href="javascript:;" data-toggle="collapse" data-target="#menu3">통계</a>
				<ul id="menu3" class="collapse">
					<li><a href="${goRoot}admin/chart/review/">리뷰</a></li>
					<li><a href="${goRoot}admin/chart/magzine/">매거진</a></li>
					<li><a href="${goRoot}admin/chart/event/">이벤트</a></li>
				</ul>
			</li>
		</ul>
	</div>
</nav>
<!-- /.navbar-collapse -->