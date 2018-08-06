<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<%@include file="/WEB-INF/views/template/head.jsp"%>
<script src="js/jquery.flexslider.js"></script>
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
		      itemWidth: 200,
		      itemMargin: 20,
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
		      itemWidth: 200,
		      itemMargin: 20,
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
				url:'/ranking/ajax?id=1',
				dataType:'text',
				success:function(result){
					$("#rankingList1").html(result);
				}
			});
    	$.ajax({
				type: 'get',
				url:'/ranking/ajax?id=2',
				dataType:'text',
				success:function(result){
					$("#rankingList2").html(result);
				}
			});
    	$.ajax({
				type: 'get',
				url:'/ranking/ajax?id=3',
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
		      <img src="imgs/main_imgs/1.jpg" />
		    </li>
		    <li>
		      <img src="imgs/main_imgs/2.jpg" />
		    </li>
		    <li>
		      <img src="imgs/main_imgs/3.jpg" />
		    </li>
		    <li>
		      <img src="imgs/main_imgs/4.jpg" />
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
				      <a href="magazine/${magazine.mag_no}"><img src="${magazine.img }" /></a>
				      <a href="magazine/${magazine.mag_no}"><p class="flex-caption">${magazine.title }</p></a>
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
				      <a href="event/${event.eve_no}"><img src="${event.img }" /></a>
				      <a href="event/${event.eve_no}"><p class="flex-caption">${event.title }</p></a>
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
