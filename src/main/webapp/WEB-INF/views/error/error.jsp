<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/resources/css/btn/btn.css" rel="stylesheet">
</head>
<style>
.page_container{
	max-width: 1080px;
	margin: 10% auto;
	text-align: center;
}
</style>
<body>
	<div class="page_container">
		<hr>
		<br>
		<!-- TODO: reset url 주소 수정 필요 -->
	<img alt="error" src="/reset/imgs/icon/error.png">
	<h1>페이지 오류 안내</h1>
	<p>홈페이지 이용에 불편을 드려 죄송합니다.</p>
	<p>잠시후 다시 이용해주십시요.</p>
	    <br>
    	<hr>
    	<!-- TODO : 홈으로 이동하는 URL 주소 수정 필요. home Controller에 있는 /test controller 삭제 필요 -->
    	<br>
    	<!-- TODO: reset url 주소 수정 필요 -->
    	<a href="/reset"><button type="button" class="redBtn">홈으로 이동</button></a>
    </div>
</body>
</html>