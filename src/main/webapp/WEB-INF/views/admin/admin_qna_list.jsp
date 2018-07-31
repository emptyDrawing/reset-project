<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.Date"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<%@include file="/WEB-INF/views/template/admin_header.jsp" %>
</head>
<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/nanumgothic.css);

h1{
margin-botton : 50px;
color : #D00B01;
font-weight: bold;
}

h1:after {
    content: " ";
    width: 130px;
    height: 5px;
    background: #DDDDDD;
    display: block;
    margin-top: 20px;
    border-radius: 3px;
}


a{
color: black;
text-decoration: none;
}

.container{
    font-family: "Nanum Gothic", sans-serif;
    font-size: 18px;
}


</style>
<body>
    <div id="wrapper">
	<%@include file="/WEB-INF/views/template/admin_side_menu.jsp" %>
        <div id="page-wrapper">
            <div class="container-fluid">
            <!-- 컨탠츠 시작 -->


<div class="container">

       <form action="qna/${qa_no}" method="GET">
	<h1>문의하기</h1>
	<br>
	<table class="table">
	<thead>
	<tr>
		<th>글번호</th>
		<th>날짜</th>
		<th>질문유형</th>
		<th>내용</th>
		<th>답변</th>
		</tr>
	<tbody>
	<c:forEach items="${alist }" var="bean">
	<tr>
		<td><a href="./qna/${bean.qa_no }">${bean.qa_no }</a></td>
		<td><a href="./qna/${bean.qa_no }">${bean.nalja }</a></td>
		<td><a href="./qna/${bean.qa_no }">
		
			<c:choose>
	<c:when test="${bean.qa_type == '1' }">쇼핑문의
	</c:when>
	<c:when test="${bean.qa_type == '2' }">이벤트 문의
	</c:when>
	<c:when test="${bean.qa_type == '3' }">서비스 불편, 오류 제의
	</c:when>
	<c:when test="${bean.qa_type == '4' }">사용방법, 기타 문의
	</c:when>
	<c:when test="${bean.qa_type == '5' }">아이디어 제안, 칭찬
	</c:when>
	<c:when test="${bean.qa_type == '6' }">제휴문의
	</c:when>
	</c:choose>
	<jsp:useBean id="now" class="java.util.Date"/>
<c:set var="nowdate" scope="request"><fmt:formatDate value="${now}"/></c:set>
<c:set var="nalja" scope="request"><fmt:formatDate value="${bean.nalja}"/></c:set>
		</a></td>
		<td><a href="./qna/${bean.qa_no }">${bean.con }</a>
		
		<c:if test="${nalja == nowdate}">
    	 <font color="red">new</font>
			</c:if>
</td> 
		<td><a href="./qna/${bean.qa_no }">
			<c:choose> 
				<c:when test="${empty bean.answer}">미답변</c:when>  
				<c:otherwise>답변완료</c:otherwise>
			</c:choose>
			</a></td>
		</tr>
		</c:forEach>
		</tbody>
	</table>
       </form>     
</div><!-- 컨테이너 끝 -->
            <!-- 컨탠츠 끝 -->
            </div><!-- /.container-fluid -->
        </div><!-- /#page-wrapper -->
    </div><!-- /#wrapper -->
</body>
</html>

