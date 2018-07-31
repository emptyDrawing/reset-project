<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<%@include file="/WEB-INF/views/template/admin_header.jsp" %>
<link href="${goRoot }css/main.css" rel="stylesheet">

<style type="text/css">
    /* 컨텐츠 contatiner */
	.page_container{
		width: 80%;
        border: 0.5px solid rgb(217, 222, 232);
	}
    .page_container>a{
        text-decoration: none;
        color: black;
    }
    .page_container>a:hover{
    	text-decoration: none;
    	color: black;
    }
    .contentsbox{
        width: 85%;
        margin: 0px auto;
        display: flex;
        border-bottom: 0.5px solid rgb(217, 222, 232);
    }   
    .numbox{
        width: 20%;
        margin: auto 0px;
        font-size: 30pt;
        text-align: center;
    }
    .imgbox{
        width: 30%;
        text-align: center;
        height: 160.5px;
    }
    .imgbox>img{
    	width: 160px;
    	height: 160px;
    }
    .conbox{
        width: 50%;
        margin: auto 0px;
    }
    .conbox>p{
        margin: 6px 0px;
    }
    .conbox>p:first-child,.conbox>p:last-child{
        color: #84868e;
    }
    .searchBox{
    	display: inline-block;
    }
    .RedBtn {
		background-color: #dd2d25;
		-moz-border-radius: 3px;
		-webkit-border-radius: 3px;
		border-radius: 3px;
		border: 1px solid #dd2d25;
	    display: inline-block;
	    cursor: pointer;
	    color: #ffffff;
	    font-family: Arial;
	    font-size: 15px;
	    font-weight: bold;
	    padding: 5px 15px;
	    margin: 5px 5px;
	    text-decoration: none;
	    color: white !important;
	    float: right;
	}
	
	.RedBtn:hover {
		color: #fff;
		background-color: #d00b01;
	}
	
	.RedBtn:active {
		position: relative;
		top: 1px;
	}
</style>
<script type="text/javascript">

$(document).ready(function(){
	$("#search").on("click",function(){
		$('.brand').empty();
		$('.name').empty();
		search_brand();
		search_name();
	})
})

function search_brand(){
	var search=$('#search_input').val();
	var type="brand";
	$.ajax({
	        type: 'GET', // get 방식으로 요청
			dataType: 'json', // json 타입
			url: "/reset/itemSearch?search="+search+"&type="+type, // 데이터를 불러오는 json-server 주소입니다 .
	})
	.done(function(data){
 		data.forEach(function (data) { // 데이터의 갯수에 따라서 div를 추가해줬습니다
 			console.log(data.img);
  			$('.brand').append(
  					"<a href='./item/"+data.item+"'>"+
  					"<div class='contentsbox'>"+
  					"<div class='numbox box'>"+
  					"<label>○</label></div>"+
  					"<div class='imgbox box'>"+
  					"<img src='${goRoot }"+data.img+"'>"+
  					"</div>"+
  					"<div class='conbox box'>"+
  					"<p>"+data.brand+"</p>"+
  					"<p>"+data.name+"</p>"+
  					"<p>"+data.vol+"&nbsp;"+data.price+"원</p>"+
					"</div></div></a>");
		})
	})
	.fail(function () { // 실패했을때 불러질 함수
		console.error('데이터 불러오기 실패');
	})
}
function search_name(){
	var search=$('#search_input').val();
	var type="name";
	$.ajax({
	        type: 'GET', // get 방식으로 요청
			dataType: 'json', // json 타입
			url: "/reset/itemSearch?search="+search+"&type="+type, // 데이터를 불러오는 json-server 주소입니다 .
	})
	.done(function(data){
 		data.forEach(function (data) { // 데이터의 갯수에 따라서 div를 추가해줬습니다
  			$('.name').append(
  					"<a href='./item/"+data.item+"'>"+
  					"<div class='contentsbox'>"+
  					"<div class='numbox box'>"+
  					"<label>○</label></div>"+
  					"<div class='imgbox box'>"+
  					"<img src='${goRoot }"+data.img+"'>"+
  					"</div>"+
  					"<div class='conbox box'>"+
  					"<p>"+data.brand+"</p>"+
  					"<p>"+data.name+"</p>"+
  					"<p>"+data.vol+"&nbsp;"+data.price+"원</p>"+
					"</div></div></a>");
		})
	})
	.fail(function () { // 실패했을때 불러질 함수
		console.error('데이터 불러오기 실패');
	})
}
function searchCheck(){
	 var search_input = $("#search_input");
	 if(search_input.val() == ""){
		 alert("검색어를 입력해 주세요.");
		 $("#search_input").focus();
		 return false;
	 }
	 
}; 	
</script>
</head>
<body>
    <div id="wrapper">
	<%@include file="/WEB-INF/views/template/admin_side_menu.jsp" %>
        <div id="page-wrapper">
            <div class="container-fluid">
                <!-- Page Heading -->  
     
    <!-- main contents -->
    <div class="page_container">
    <form class="form-inline searchBox">
        <div class="form-group">
            <label class="sr-only" for="search">검색</label>
            <input id="search_input"type="text" class="form-control input_box" placeholder="검색">
        </div>
        <button id="search" type="button" class="btn send_btn"><span class="main_font">검색</span></button>
    </form>
    <a class="btn-lg RedBtn" href="./itemAdd">아이템 추가</a>
    	<h1>브랜드</h1>
    	<div class="brand">
    	</div>
    	<br>
    	<h1>이름</h1>
    	<div class="name">
    	</div>
    	<br>
    	<h1>모든 제품</h1>
    	<div>
    	<c:forEach items="${alist }" var="bean">
	    	<a href="./item/${bean.item }">
				<div class="contentsbox">
					<div class="numbox box">
				         <label>○</label>
					</div>
					<div class="imgbox box">
					     <img src="${goRoot}${bean.img }">
					</div>
					<div class="conbox box">
		                <p>${bean.brand }</p>
					    <p>${bean.name }</p>
					    <p>${bean.vol }&nbsp;${bean.price }원</p>
					</div>
				</div>
       		</a>
     	</c:forEach>
    	</div>
    </div>
    <!-- //main contents -->

    <!--footer-->
                </div><!-- /.container-fluid -->
        </div><!-- /#page-wrapper -->
    </div><!-- /#wrapper -->
    <!--//footer-->    

</body>
</html>
