<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<%@include file="/WEB-INF/views/template/head.jsp"%>
<script src="js/jquery.flexslider.js"></script>
<style type="text/css">

@font-face {
  font-family: NanumSquareB;
  src: url(${goRoot}fonts/NanumSquareB.ttf) format("truetype");
}

@font-face {
  font-family: NanumSquareEB;
  src: url(${goRoot}fonts/NanumSquareEB.ttf) format("truetype");
}

ul,ol,li{margin: 0px; padding: 0px; list-style: none;}

.mainRankTitle{
	text-align: center;
	font-family: NanumSquareB;
	color: #303030;
	border: 2px solid #303030;
	border-radius: 30px;
	width: 160px;
	margin: 0px auto;
	margin-top: 50px;
}

.mainRankSub{
	font-size: 20px;
	font-family: NanumSquareB;
	width: 400px;
	margin: 0px auto;
	text-align: center;
	margin-top: 20px;
}
.strongWord{
	color: #cf0902;
	font-size: 25px;
	font-family: NanumSquareEB;
}
.divide_line{
	background-color: #ebebeb;
	height: 4px;
	margin-bottom: 30px;
	margin-top: 30px;
}
.mainTitle{
	font-family: NanumSquareB;
	margin-left: 2%;
}
.slides img{
	max-width: 100%; 
}
.flexslider {
	z-index:-1;
	text-align: center;
}
.flex-control-paging {
	display: inline-block;
}
.flex-control-paging:after {
	display: block;
	content: '';
	clear: both;
}
.flex-control-paging li {
	float: left;
	display: inline-block;
}
.flex-control-paging a {
	display: inline-block;
	margin: 3px;
	width: 10px;
	height: 10px;
	border-radius: 50%;
	background-color: #42A1F6;
	font-size: 0;
	line-height: 0;
}
.flex-control-paging a.flex-active{
	background-color:#335574;
}
.flex-direction-nav li a {
	text-decoration: none;
	font-size: 43px;
	font-weight: bold;
	color: #000;
}
.flex-direction-nav li.flex-nav-prev {
	bottom: 20px;
	left: 15px;
	display: none;
}
.flex-direction-nav li.flex-nav-next {
	right: 15px;
	display: none;
} 
.flexslider2{
	text-align: center;
}
.flex-caption {
  width: 100%;
  padding: 2%;
  background: rgba(0,0,0,.4);
  color: #fff;
  text-shadow: 0 -1px 0 rgba(0,0,0,.3);
  font-size: 14px;
  line-height: 18px;
}

</style>

	<script type="text/javascript">
	  $(function(){
		  $('.flexslider').flexslider({
			useCSS: true,
			animation: "slide",
		    controlsContainer: $(".custom-controls-container"),
		  });
		 
		// 매거진 캐러셀
		// store the slider in a local variable
		  var $window = $(window),
		      flexslider2 = { vars:{} };
		 
		  // tiny helper function to add breakpoints
		  function getGridSize() {
		    return (window.innerWidth < 600) ? 2 :
		           (window.innerWidth < 900) ? 3 : 4;
		  }
		 
		 /*  $(function() {
		    SyntaxHighlighter.all();
		  }); */
		 
		  $window.load(function() {
		    $('.flexslider2').flexslider({
		      animation: "slide",
		      animationLoop: false,
		      itemWidth: 400,
		      itemMargin: 5,
		      minItems: getGridSize(), // use function to pull in initial value
		      maxItems: getGridSize() // use function to pull in initial value
		    });
		  });
		 
		  // check grid size on resize event
		  $window.resize(function() {
		    var gridSize = getGridSize();
		 
		    flexslider2.vars.minItems = gridSize;
		    flexslider2.vars.maxItems = gridSize;
		  });
		// store the slider in a local variable
		  var $window = $(window),
		      flexslider3 = { vars:{} };
		 
		  // tiny helper function to add breakpoints
		  function getGridSize() {
		    return (window.innerWidth < 600) ? 2 :
		           (window.innerWidth < 900) ? 3 : 4;
		  }
		 
		 /*  $(function() {
		    SyntaxHighlighter.all();
		  }); */
		 
		  $window.load(function() {
		    $('.flexslider3').flexslider({
		      animation: "slide",
		      animationLoop: false,
		      itemWidth: 400,
		      itemMargin: 5,
		      minItems: getGridSize(), // use function to pull in initial value
		      maxItems: getGridSize() // use function to pull in initial value
		    });
		  });
		 
		  // check grid size on resize event
		  $window.resize(function() {
		    var gridSize = getGridSize();
		 
		    flexslider3.vars.minItems = gridSize;
		    flexslider3.vars.maxItems = gridSize;
		  });
		  // 매거진 캐러셀 끝
		  
		rankingLlist();
      });
	  function rankingLlist(){
		  $.ajax({
				type: 'get',
				url:'/reset/ranking/ajax?id=1',
				dataType:'text',
				success:function(result){
					$("#rankingList1").html(result);
				}
			});
    	$.ajax({
				type: 'get',
				url:'/reset/ranking/ajax?id=2',
				dataType:'text',
				success:function(result){
					$("#rankingList2").html(result);
				}
			});
    	$.ajax({
				type: 'get',
				url:'/reset/ranking/ajax?id=3',
				dataType:'text',
				success:function(result){
					$("#rankingList3").html(result);
				}
			});
	  }
	</script>
</head>
<body>
<%@include file="/WEB-INF/views/template/menu.jsp" %>
    
    <!-- main contents -->
    <div class="page_container">
		<div class="flexslider">
		  <ul class="slides">
		    <li>
		      <img src="imgs/main_imgs/13.jpg" />
		    </li>
		    <li>
		      <img src="imgs/main_imgs/14.jpg" />
		    </li>
		    <li>
		      <img src="imgs/main_imgs/15.jpg" />
		    </li>
		    <li>
		      <img src="imgs/main_imgs/16.jpg" />
		    </li>
		  </ul>
		</div>
		
    	<div class="divide_line"></div>
    	
		<div class="rankTitleDiv">
			<h2 class="mainRankTitle">스킨 랭킹</h2>
		</div>
		<div class="mainRankSub">유저들이 뽑은 <span class="strongWord">스킨</span> 랭킹</div>
    	<div class="welcome_line"><img src="${goRoot }imgs/welcome_bg.png"></div>
    	<div id="rankingList1"></div>
    	
    	<div class="divide_line"></div>
    	
    	<div class="rankTitleDiv">
    		<h2 class="mainRankTitle">로션 랭킹</h2>
    	</div>
    	<div class="mainRankSub">유저들이 뽑은 <span class="strongWord">로션</span> 랭킹</div>
    	<div class="welcome_line"><img src="${goRoot }imgs/welcome_bg.png"></div>
   		<div id="rankingList2"></div>
   		
    	<div class="divide_line"></div>
   		
   		<div class="rankTitleDiv">
    		<h2 class="mainRankTitle">에센스 랭킹</h2>
    	</div>
    	<div class="mainRankSub">유저들이 뽑은 <span class="strongWord">에센스</span> 랭킹</div>
    	<div class="welcome_line"><img src="${goRoot }imgs/welcome_bg.png"></div>
    	<div id="rankingList3"></div>
       
       	<h1 class="mainTitle">매거진</h1>
    	<div class="divide_line"></div>
    	<div class="magazine">
    		<!-- Place somewhere in the <body> of your page -->
			<div class="flexslider2 carousel">
			  <ul class="slides">
			    <c:forEach items="${magazine_alist }" var="magazine">
			      <li>
				      <img src="/reset/imgs/${magazine.img }" />
				      <p class="flex-caption">${magazine.title }</p>
			      </li>
			    </c:forEach>
			    <!-- items mirrored twice, total of 12 -->
			  </ul>
			</div>
    	</div>
       	<h1 class="mainTitle">이벤트</h1>
    	<div class="divide_line"></div>
    	<div class="event">
    		<!-- Place somewhere in the <body> of your page -->
			<div class="flexslider3 carousel">
			  <ul class="slides">
			    <c:forEach items="${event_alist }" var="event">
			      <li>
				      <img src="/reset/imgs/${event.img }" />
				      <p class="flex-caption">${event.title }</p>
			      </li>
			    </c:forEach>
			    <!-- items mirrored twice, total of 12 -->
			  </ul>
			</div>
    	</div>
       	
    </div>
    <!-- //main contents -->
    
    
<%@include file="/WEB-INF/views/template/footer.jsp"%>
</body>
</html>
