<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.Date"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<%@include file="/WEB-INF/views/template/admin_header.jsp" %>

<style type="text/css">

.container {
	font-family: NanumSquareR;
	font-size: 20px;
}

.newbtn {
	background-color:#d00b01;
	-moz-border-radius:2px;
	-webkit-border-radius:2px;
	border-radius:8px;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size: 2px;
	padding:3px 6px;
	text-decoration:none;
}
 
h1 {
	font-size: 3vmax;
	font-family: NanumSquareB;
	color: #303030;
}
    
a{
color: black;
text-decoration: none;
}

.qano-cell{
	width : 7%;
	text-align: center;
}

.nalja-cell{
	width: 10%;
}

.qatype-cell{
	width: 20%;
	
}


.mystyle{
	width: 605px;
	height: 40px;
	white-space:nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
 	display :inline-block;
}



.answer-cell{
	width: 10%;
}


</style>
 </head>
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
		<th class="qano-cell">글번호</th>
		<th class="nalja-cell">날짜</th>
		<th class="qatype-cell">질문유형</th>
		<th class="con-cell">내용</th>
		<th class="answer-cell">답변</th>
		</tr>
	<tbody>
	<c:forEach items="${alist }" var="bean">
	<tr class="trheight">
		<td class="qano-cell"><a href="./qna/${bean.qa_no }">${bean.qa_no }</a></td>
        <td class="nalja-cell"><a href="./qna/${bean.qa_no }"><fmt:formatDate value="${bean.nalja}" pattern="MM/dd" /></a></td>
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
		<% pageContext.setAttribute("newLineChar", "\r\n"); %>
		<td class="con-cell mystyle"><c:if test="${nalja == nowdate}">
										&nbsp;&nbsp;<a href="#" class="newbtn">new</a>
								</c:if><a href="./qna/${bean.qa_no }">${fn:replace(bean.con, newLineChar, "<br/>")}</a>
						
</td> 
		<td class="answer-cell"><a href="./qna/${bean.qa_no }">
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

