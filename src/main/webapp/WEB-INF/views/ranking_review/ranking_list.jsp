<%@page import="com.fasterxml.jackson.annotation.JsonInclude.Include"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<%@include file="/WEB-INF/views/template/head.jsp"%>
<link rel="stylesheet" href="${goRoot }css/ranking_review/ranking_list.css" type="text/css">
<script type="text/javascript">
$(function(){
	var su=0;
        $(window).scroll(function(){
       	var maxHeight = $(document).height();
    	    var currentScroll = $(window).scrollTop() + $(window).height();
    	    if(maxHeight <= currentScroll + 600) {
    	    	if(su==0){add()}
    	    	su=1;
    	    }
	})
})

function add(){
	var num=11;
	var cate=${cate};
	$.ajax({
	        type: 'GET', // get 방식으로 요청
			dataType: 'json', // json 타입
			url: "rankingadd?id="+cate, // 데이터를 불러오는 json-server 주소입니다 .
	})
	.done(function(data){
 		data.forEach(function (data) { // 데이터의 갯수에 따라서 div를 추가해줬습니다
  			$('.page_container').append(
  					"<a href='./item/"+data.item+"'>"+
  					"<div class='contentsbox'>"+
  					"<div class='numbox box'>"+
  					"<label>"+num+"</label>"+
  					"</div>"+
  					"<div class='imgbox box'>"+
  					"<img src='"+data.img+"'>"+
  					"</div>"+
  					"<div class='conbox box'>"+
  					"<p class='rankingBrand rankingP'>"+data.brand+"</p>"+
					"<p class='rankingName rankingP'>"+data.name+"</p>"+
					"<p><span class='rankingvol rankingP'>"+data.vol+"</span>"+
					"<span class='rankingPrice rankingP'>"+data.price+"원</span></p>"+
  					"</div>"+
  					"</div>"+
  					"</a>");
  			num=num+1;
		})
	})
	.fail(function () { // 실패했을때 불러질 함수
		console.error('데이터 불러오기 실패');
	})
}
    	    	
</script>
</head>
<body>
	<!--header-->
    <%@include file="/WEB-INF/views/template/menu.jsp"%>
    <div class="breadcrumb">
    	<div>
   		<a href="/">HOME</a>
   		<span class="slash">/</span>
   		랭킹
   		</div>
    </div>
    <!--//header-->    
     
    <!-- main contents -->
    <div class="page_container">
    	<c:set var="num" value="1" />
    	<c:forEach items="${alist }" var="bean" end="9">
	    	<a href="./item/${bean.item }">
			<div class="contentsbox">
				<div class="numbox box">
					<c:choose>
						<c:when test="${num==1}">
							<img alt="rankingImg" src="${goRoot }imgs/icon/crown_${num}.png" class="rankingImg"><c:set var="num" value="${num+1}"  /> 
						</c:when>
						<c:when test="${num==2}">
							<img alt="rankingImg" src="${goRoot }imgs/icon/crown_${num}.png" class="rankingImg"><c:set var="num" value="${num+1}"  /> 
						</c:when>
						<c:when test="${num==3}">
							<img alt="rankingImg" src="${goRoot }imgs/icon/crown_${num}.png" class="rankingImg"><c:set var="num" value="${num+1}"  /> 
						</c:when>
						<c:otherwise>
					         <label class="labelNum">${num}&nbsp;&nbsp;</label><c:set var="num" value="${num+1}"  /> 
						</c:otherwise>
					</c:choose>
				</div>
				<div class="imgbox box">
				     <img src="${bean.img }">
				</div>
				<div class="conbox box">
	                <p class="rankingBrand rankingP">${bean.brand }</p>
					<p class="rankingName rankingP">${bean.name }</p>
					<p><span class="rankingvol rankingP">${bean.vol }</span><span class="rankingPrice rankingP">${bean.price }원</span></p>
				</div>
			</div>
       		</a>
       </c:forEach>
    </div>
    <!-- //main contents -->

    <!--footer-->
    <%@include file="/WEB-INF/views/template/footer.jsp"%>
    <!--//footer-->    

</body>
</html>
