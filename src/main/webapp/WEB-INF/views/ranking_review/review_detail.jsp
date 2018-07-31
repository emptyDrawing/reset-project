<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<%@include file="/WEB-INF/views/template/head.jsp"%>
	<style type="text/css">
	/* 전체 container */
    .page_container{
    	width: 80%;
        border: 1px solid rgb(217, 222, 232);
    }
    .avgBox{
    	width: 95%;
    	margin: 0px auto;
   		border: 1px solid #e5e5e5;
    }
    .avgBox>table>tbody>tr>td:first-child{
    	width: 10%;
    	text-align: center;
    }
    .bar1 {
		background-image: -webkit-linear-gradient(top, #bd0026 0, #bd0026 100%);
	}
	
	.bar2 {
		background-image: -webkit-linear-gradient(top, #f03b20 0, #f03b20 100%);
	}
	
	.bar3 {
		background-image: -webkit-linear-gradient(top, #fd8d3c 0, #fd8d3c 100%);
	}
	
	.bar4 {
		background-image: -webkit-linear-gradient(top, #fecc5c 0, #fecc5c 100%);
	}
	
	.bar5 {
		background-image: -webkit-linear-gradient(top, #fee0d2 0, #fee0d2 100%);
	}
    .reviewBox{
    	width: 95%;
    	border: 1px solid #e5e5e5;
    	margin: 0px auto;
    }
    .reviewBox>img{
    	width: 100%;
    }
    .reviewBox>p{
    	display: inline-block;
    	margin: 20px 0px 0px 20px;
    }
    .reviewBox>label{
    	margin: 0px 0px 0px 20px;
    }
    .icon{
   	    text-align: center;
   	    margin: 5px 0px;
    }
   	.btn-color{
   		color: white;
   		background-image: -webkit-gradient(linear,left top,left bottom,from(#F5515F),to(#A1051D));
   	}
   	.btn-position{
   	    text-align: center;
   	    margin: 5px 0px;
   	}
   	.btn-file {
	    position: relative;
	    overflow: hidden;
	}
	.btn-file input[type=file] {
	    position: absolute;
	    top: 0;
	    right: 0;
	    min-width: 100%;
	    min-height: 100%;
	    font-size: 100px;
	    text-align: right;
	    filter: alpha(opacity=0);
	    opacity: 0;
	    outline: none;
	    background: white;
	    cursor: inherit;
	    display: block;
	}
	#img_preview img{
		width: 100%;
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
	}
	
	.RedBtn:hover {
		color: #fff;
		background-color: #d00b01;
	}
	
	.RedBtn:active {
		position: relative;
		top: 1px;
	}
	
	.darkBtn {
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
	    padding: 5px 15px;
	    margin: 5px 5px;
	    text-decoration: none;
	}
	
	.darkBtn:hover {
		color: #fff;
		background-color: #313131;
	}
	
	.darkBtn:active {
		position: relative;
		top: 1px;
	}
	.sub-title {
		color: #84868e;
	}
	.star {
		width: 80px;
	}
	
	.starRating1 {
		display: inline-block;
		overflow: hidden;
		width: 16px;
		margin: 0px 0px -3px 0px;
	}
	
	.starRating2 {
		display: inline-block;
		overflow: hidden;
		width: 32px;
		margin: 0px 0px -3px 0px;
	}
	
	.starRating3 {
		display: inline-block;
		overflow: hidden;
		width: 48x;
		margin: 0px 0px -3px 0px;
	}
	
	.starRating4 {
		display: inline-block;
		overflow: hidden;
		width: 64px;
		margin: 0px 0px -3px 0px;
	}
	
	.starRating5 {
		display: inline-block;
		overflow: hidden;
		width: 80px;
		margin: 0px 0px -3px 0px;
	}
	.btn.focus, .btn:focus, .btn:hover{
		color: #fff;
	}
	.btimg{/* 좋아요 아이콘 */
		margin: 2% 1%;
		width: 4.7%;
	}
	.popDiv{
	    text-align: center;
	}
	/* modal */
	.form-group {
		height: 90px;
	}
	.form-group>label {
		text-align: center;
	}
	
	.imgDiv label {
		display: inline-block;
		padding: .5em .75em;
		font-size: inherit;
		line-height: normal;
		color: #ffffff;
		vertical-align: middle;
		background-color: #313131;
		cursor: pointer;
		border: 1px solid #313131;
		border-bottom-color: #313131;
		border-radius: .25em;
	}
	
	.imgDiv input[type="file"] { /* 파일 필드 숨기기 */
		position: absolute;
		width: 1px;
		height: 1px;
		padding: 0;
		margin: -1px;
		overflow: hidden;
		clip: rect(0, 0, 0, 0);
		border: 0;
	}
	.textbox{
		width:100%;
	}
	/* 댓글 스타일 */
	.com_div{
		display: inline-block;
		margin-bottom: 10px;
	}
	
	.com_nalja{
		margin-left: 85%;
	}
	.com_hr{
		width: 100%;
		margin-bottom: 1%;
	}
	.comBtn{
		margin-left: 90%;
	}
	
	</style>
<script type="text/javascript">
$(document).ready(function(){
	var option=1;
	$('#review_update').on('shown.bs.modal', function () {
	})	
	 
	$("#reivewUpdate").on("click",function(){
		    var item=${review_bean.item};
		    var rev_no=${review_bean.rev_no };
		    var preview_img=$('#img_preview img').first().attr("src");
		    if(preview_img==""){
		    	console.log("null");
		    	$('#option').attr("value","3");
		    }else{
		    	console.log("null아님");
		    }
            var formData = new FormData($('#review')[0]);
		    console.log(formData);
		    $.ajax({
				type:"post",
				enctype: 'multipart/form-data',
				data : formData,
				url: "/reset/item/"+item+"/review/"+rev_no,
				contentType: false,
				processData: false,
				dataType: "text",
				success:function(data){
					console.log(data);
					if(data=="1"){
						console.log("성공");
							window.location.href="/reset/item/"+item+"/review/"+rev_no;
					} else if(data=="0"){
						alert("글수정에 실패하였습니다.");
					}
				},
				beforeSend:function(){
			        $('.wrap-loading').removeClass('display-none');
			    },
			    complete:function(){
			        $('.wrap-loading').addClass('display-none');
			    }
			}) 
	/* 		.done(function(data){
				console.log(data);
				if(data=="1"){
					console.log("성공");
					window.location.href="/reset/item/"+item+"/review/"+rev_no;
					
				} else if(data=="0"){
					alert("글수정에 실패하였습니다.");
				}
		 	}) */
			.fail(function () { // 실패했을때 불러질 함수
				console.error('데이터 수정 실패');
			})    
		})
		$("#reivewDelete").on("click",function(){
			var item=${item_bean.item};
		    var rev_no=${review_bean.rev_no };
			var formData = new FormData($('#review')[0]);
			$.ajax({
				type:"delete",
				enctype: 'multipart/form-data',
				data : formData,
				url: "/reset/item/"+item+"/review/"+rev_no,
				contentType: false,
				processData: false,
				dataType: "text"
			}) 
			.done(function(data){
				expDown("review");
				console.log(data);
				if(data=="1"){
					console.log("성공");
					window.location.href="/reset/item/"+item;
				} else if(data=="0"){
					alert("글삭제에 실패하였습니다.");
				}
		 	})
			.fail(function () { // 실패했을때 불러질 함수
				console.error('데이터 삭제 실패');
			}) 
		})
		
		/* 좋아요 시작 */
		
		var email=$("#email").val();
	    /* var email=${email}; */
	    var p_no=$("#p_no").val();
	    /* var p_no=${p_no}; */
		var type="review";	    
		/* var type=${type}; */		    
	    $.ajax({
	    	type:'post',
			url: '/reset/like/'+type+'/'+p_no,
			data : JSON.stringify({
				email : email,
				type : type,
				p_no : p_no
			}),
			headers:{
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "POST"
			},
			dataType: "text"
		}) 
		.done(function(data){
			$("#result").val(data);
			if($('#result').val()=="unlike"){
				$('#unLikes').hide();
			}else if($('#result').val()=="like"){
				$('#Likes').hide();
			}
	 	})
		.fail(function () { // 실패했을때 불러질 함수
			console.error('데이터 수정 실패');
		})     
		
		
		if($('#result').val()=="like"){
			console.log("좋아요를 이미 누르셨습니다");
		}else{
		$("#Likes").on("click",function(){
			    var email=$("#email").val();
			    /* var email=${email}; */
			    var p_no=$("#p_no").val();
			    /* var p_no=${p_no}; */
				var type="review";	    
				/* var type=${type}; */		    
			    $.ajax({
			    	type:'PUT',
					url: '/reset/likes/'+encodeURI(type)+'/'+encodeURI(p_no),
					data : JSON.stringify({
						email : email,
						type : type,
						p_no : p_no
					}),
					headers:{
						"Content-Type" : "application/json",
						"X-HTTP-Method-Override" : "PUT"
					}
				}) 
				.done(function(data){
					expUp("like");
					console.log(data);
				 	if(data.result=="1"){
						console.log("성공");
						$("#Likes").hide();
						$("#unLikes").show();
						$("#result").val("like");
						$("#su").text(data.like);
					} else if(data=="0"){
						alert("실패하였습니다.");
					} 
			 	})
				.fail(function () { // 실패했을때 불러질 함수
					console.error('데이터 수정 실패');
				})     
			})
		}
			
	    if($('#result').val()=="unlike"){
	    	console.log("좋아요를 누르지 않았습니다");
	    }else{
		$("#unLikes").on("click",function(){
			    var email=$("#email").val();
			    /* var email=${email}; */
			    var p_no=$("#p_no").val();
			    /* var p_no=${p_no}; */
				var type="review";   
				/* var type=${type}; */		    
			    $.ajax({
			    	type:'DELETE',
					url: '/reset/likes/'+encodeURI(type)+'/'+encodeURI(p_no),
					data : JSON.stringify({
						email : email,
						type : type,
						p_no : p_no
					}),
					headers:{
						"Content-Type" : "application/json",
						"X-HTTP-Method-Override" : "DELETE"
					}
				}) 
				.done(function(data){
					expDown("like");
					console.log(data);
					if(data.result=="1"){
						console.log("성공");
						$("#Likes").show();
						$("#unLikes").hide();
						$("#result").val("unlike");
						$("#su").text(data.like);
					} else if(data=="0"){
						alert("실패하였습니다.");
					} 
			 	})
				.fail(function () { // 실패했을때 불러질 함수
					console.error('데이터 수정 실패');
				})     
			})
	    }
	    /* 좋아요 끝 */
		
});
	function expUp(type){
	/* var email =${login_email}; */
		var type = type;//review,comment,like
		$.ajax({
			type : 'POST',
			url : '/reset/exp',
			data : JSON.stringify({
				email : email,
				type : type
			}),
			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "POST"
			},
			dataType : "text"
		}).done(function(data) {
			console.log(data);
		}).fail(function() { // 실패했을때 불러질 함수
			console.error('데이터 수정 실패');
		})
	}
	function expDown(type){
	/* 	var email = ${login_email}; */
		var type = type;//review,comment,like
		$.ajax({
			type : 'DELETE',
			url : '/reset/exp',
			data : JSON.stringify({
				email : email,
				type : type
			}),
			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "DELETE"
			},
			dataType : "text"
		}).done(function(data) {
			console.log(data);
		}).fail(function() { // 실패했을때 불러질 함수
			console.error('데이터 수정 실패');
		})
	}
	function reviewCheck(){
		 var star = $(':input[name=star]:radio:checked').val();
		 var good = $("#good");
		 var bad = $("#bad");
		 var tip = $("#tip");
	     
	     if(star){
	    	 return true;
	     } else{
	         alert("별점을 선택해주세요.");
	         $(".star").focus();
	         return false;
	     }
	     
		 if(good.val() == ""){
			 alert("좋은점을 입력해 주세요.");
			 $("#good").focus();
			 return false;
		 }
		 if(bad.val() == ""){
			 alert("나쁜점을 입력해 주세요.");
			 $("#bad").focus();
			 return false;
		 }
		 if(tip.val() == ""){
			 alert("팁을 입력해 주세요.");
			 $("#tip").focus();
			 return false;
		 }
		 
	};
</script>
</head>
<body>
	<!--header-->
    <%@include file="/WEB-INF/views/template/menu.jsp"%>
    <div class="breadcrumb">
    	<div>
   		<a href="/reset/">HOME</a>
   		<span class="slash">/</span>
   		랭킹
   		</div>
    </div>
    <!--//header-->    
     
    <!-- main contents -->
   <div class="page_container">    
        <div class="avgBox">
        	
            <p>점수 총 <span>${map.total }</span>명 <span>${item_bean.tot }</span>점</p>
            <table class="table">
            	<tr>
         			<td>
         				<span>5점</span>
            		</td>
         			<td>
         				<div class="progress">
							<div class="progress-bar progress-bar bar1" role="progressbar" aria-valuemin="0" aria-valuemax="100" style="width: ${map.five }%">
						    	${map.five }%
							</div>
						</div>
            		</td>
            	</tr>
            	<tr>
         			<td>
         				<span>4점</span>
            		</td>
         			<td>
         				<div class="progress">
						  <div class="progress-bar progress-bar bar2" role="progressbar" aria-valuemin="0" aria-valuemax="100" style="width: ${map.four }%">
						    ${map.four }%
						  </div>
						</div>
            		</td>
            	</tr>
            	<tr>
         			<td>
         				<span>3점</span>
            		</td>
         			<td>
         				<div class="progress">
						  <div class="progress-bar progress-bar bar3" role="progressbar" aria-valuemin="0" aria-valuemax="100" style="width: ${map.three }%">
						    ${map.three }%
						  </div>
						</div>
            		</td>
            	</tr>
            	<tr>
         			<td>
         				<span>2점</span>
            		</td>
         			<td>
						<div class="progress">
							<div class="progress-bar progress-bar bar4" role="progressbar" aria-valuemin="0" aria-valuemax="100" style="width: ${map.two }%">
						    	${map.two }%
					    	</div>
						</div>
            		</td>
            	</tr>
            	<tr>
         			<td>
         				<span>1점</span>
            		</td>
         			<td>
						<div class="progress">
						  <div class="progress-bar progress-bar bar5" role="progressbar" aria-valuemin="0" aria-valuemax="100" style="width: ${map.one }%">
						    ${map.one }%
						  </div>
						</div>
            		</td>
            	</tr>
            </table>
			
        </div>
		
		<c:if test="${login_on=='true' && (login_nick==review_bean.writer)}">
		<div class="btn-position">
	        <!-- Button trigger modal -->
			<button type="button" class="btn-lg darkBtn" data-toggle="modal" data-target="#review_update" >
			  수정
			</button>
			<button type="button" class="btn-lg RedBtn" data-toggle="modal" data-target="#review_delete" >
			  삭제
			</button>
		</div>
		</c:if>
		
       <div class="reviewBox">
      		<c:choose>
				<c:when test="${review_bean.img != ''}">
            		<img src="${goRoot}${review_bean.img }"/>
				</c:when>
			</c:choose>
			<br>
            <p>${review_bean.writer }<br> 
            <span class="sub-title">${review_bean.age }세 / ${review_bean.skin } / ${review_bean.gender } / </span>
			</p>
			<c:choose>
				<c:when test="${review_bean.star == 1}">
					<div class="starRating1">
						<img class="star" src="${goRoot}imgs/icon/grade_img.png">
					</div>
				</c:when>
				<c:when test="${review_bean.star == 2}">
					<div class="starRating2">
						<img class="star" src="${goRoot}imgs/icon/grade_img.png">
					</div>
				</c:when>
				<c:when test="${review_bean.star == 3}">
					<div class="starRating3">
						<img class="star" src="${goRoot}imgs/icon/grade_img.png">
					</div>
				</c:when>
				<c:when test="${review_bean.star == 4}">
					<div class="starRating4">
						<img class="star" src="${goRoot}imgs/icon/grade_img.png">
					</div>
				</c:when>
				<c:when test="${review_bean.star == 5}">
					<div class="starRating5">
						<img class="star" src="${goRoot}imgs/icon/grade_img.png">
					</div>
				</c:when>
			</c:choose>
			<span class="sub-title">${review_bean.nalja }</span>
			<br> <br>
			<label>좋은점</label><br>
			<p>${review_bean.good }</p>
			<br><br>
			<label>나쁜점</label><br>
			<p>${review_bean.bad }</p>
			<br><br>
			<label>꿀팁</label><br>
			<p>${review_bean.tip }</p>
			
			<!-- 좋아요. -->
			<c:if test="${login_on=='true'}">
            <div class="popDiv dis">
				<input id="p_no" type="hidden" value="${review_bean.rev_no }" />
				<img alt="Likes" src="${goRoot}imgs/icon/grey_like.png" id="Likes" class="likeBtn btimg">
				<img alt="unLikes" src="${goRoot}imgs/icon/red_like.png" id="unLikes" class="likeBtn btimg">
				<input id="result" type="hidden" value="" />
				<span><strong id="su">${review_bean.pop }</strong></span>
            </div>
        	</c:if>
            <!-- 좋아요 끝 -->
			
			<!-- TODO: event 댓글입력(comment) 시작 -->
			<div>
				<div class="box box-success">
					<div class="box-header">
						<h3 class="box-title">댓글</h3>
					</div>
					<div class="box-body">
						<!-- 고정값 및 임의값 -->
						<!-- TODO: event_댓글 로그인 세션에서 받아와야함 -->
						<input class="form-control" type="hidden" name="writer"
							id="writer" value="${login_nick }">
						<!-- 댓글 글쓰는곳 -->
						<textarea rows="5" class="form-control" type="text" name="content"
							id="content"></textarea>
						<!-- 고정값 및 임의값 -->
						<!-- TODO: event_댓글 로그인 세션에서 받아와야함 -->
						<input class="form-control" type="hidden" name="email" id="email"
							value="${login_email }">
					</div>
					<!-- TODO: event 댓글 입력버튼 -->
					<c:if test="${login_on=='true'}">
						<div class="box-footer">
							<button type="submit" class="redBtn" id="comment_addBtn">댓글입력</button>
						</div>
					</c:if>
				</div>
			</div>
			<!-- TODO: event 댓글입력 끝 -->
			<!-- TODO: event 댓글수정 버튼 클릭시 모달 시작 -->
			<div id="modDiv" style="display: none;">
				<div class="modal-title">
					<input type="hidden" id="commentnum"> 댓글 수정
				</div>
				<div>
					<textarea rows="5" class="form-control" type="text"
						id="commenttext"></textarea>
				</div>
				<div>
					<button type="button" id="commentModBtn" class="redBtn">수정</button>
					<button type="button" id="commentDelBtn" class="redBtn">삭제</button>
					<button type="button" id="closeBtn" class="darkBtn">닫기</button>
				</div>
			</div>
			<!-- TODO: event 댓글수정 버튼 클릭시 모달 끝 -->
			<!-- TODO: event 댓글 리스트 시작 -->
			<div>
				<div id="comment"></div>
			</div>
			<!-- TODO: event 댓글 리스트 끝 -->

		</div>
    <!-- //main contents -->
    
    		<!-- Modal -->
		<div class="modal fade" id="review_update" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="myModalLabel">리뷰 수정</h4>
		      </div>
		      <div class="modal-body">
		      <form id="review" action="/reset/item/${item_bean.item}" name="review" enctype="multipart/form-data" onsubmit="return reviewCheck()">
	        	<input type="hidden" id="option" name="option" value="1"/>
	        	<input type="hidden" id="rev_no" name="rev_no" value="${review_bean.rev_no}"/>
	        	<input type="hidden" id="preimg" name="preimg" value="${review_bean.img }"/>
			    <input type="hidden" name="writer" value="${review_bean.writer }"/>
			    <input type="hidden" name="pop" value="${review_bean.pop }"/>

		        <div class="form-group">
					<label>좋은점</label>
					<textarea class="form-control textbox" rows="3" name="good" id="good">${review_bean.good }</textarea>
				</div>
				<div class="form-group">
					<label>나쁜점</label>
					<textarea class="form-control textbox" rows="3" name="bad" id="bad">${review_bean.bad }</textarea>
				</div>
				<div class="form-group">
					<label>꿀팁</label>
					<textarea class="form-control textbox" rows="3" name="tip" id="tip">${review_bean.tip }</textarea>
				</div>
		        
				<div class="radi">
					<label>별점</label> <label class="radio-inline" for="star">1</label>점
					<input type="radio" name="star" value="1" /> <label
						class="radio-inline" for="star">2</label>점 <input type="radio"
						name="star" value="2" /> <label class="radio-inline" for="star">3</label>점
					<input type="radio" name="star" value="3" /> <label
						class="radio-inline" for="star">4</label>점 <input type="radio"
						name="star" value="4" /> <label class="radio-inline" for="star">5</label>점
					<input type="radio" name="star" value="5" /><br>
				</div>
			   	<br>
				<div class="imgDiv">
					<label for="img">대표이미지</label> <input type="file" name="img"
						id="img" class="darkBtn">
				</div>
			    </form>
			    
				<c:choose>
					<c:when test="${review_bean.img != ''}">
						<div id="img_preview">
							<img src="${goRoot}${review_bean.img }"/>
							<a href="${goRoot}${review_bean.img }">Remove</a>
						</div>
					</c:when>
					<c:when test="${review_bean.img == ''}">
						<div id="img_preview" style="display:none;">
							<img src=""/>
							<a href="">Remove</a>
						</div>
					</c:when>
				</c:choose>
				<br />
			  
		      </div>
		      <div class="modal-footer">
		        <button type="button" id="close" class="btn-lg darkBtn" data-dismiss="modal">닫기</button>
		        <button type="button" id="reivewUpdate" class="btn-lg RedBtn">등록</button>
		      </div>
		    </div>
		  </div>
		</div>
    <!-- //modal -->
    <div class="modal fade" id="review_delete" >
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title">리뷰 삭제</h4>
	      </div>
	      <div class="modal-body">
	        <p>리뷰를 삭제하시겠습니까?&hellip;</p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn-lg darkBtn" data-dismiss="modal">닫기</button>
	        <button type="button" class="btn-lg RedBtn" id="reivewDelete">삭제</button>
	      </div>
	    </div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	</div>
    <!--footer-->
    <%@include file="/WEB-INF/views/template/footer.jsp"%>
    <!--//footer--> 
      
<script type="text/javascript">

    $('#img').on('change', function() {
        ext = $(this).val().split('.').pop().toLowerCase(); //확장자
        
        //배열에 추출한 확장자가 존재하는지 체크
        if($.inArray(ext, ['gif', 'png', 'jpg', 'jpeg']) == -1) {
            resetFormElement($(this)); //폼 초기화
            window.alert('이미지 파일이 아닙니다! (gif, png, jpg, jpeg 만 업로드 가능)');
        } else {
            file = $('#img').prop("files")[0];
            blobURL = window.URL.createObjectURL(file);
            $('#img_preview img').attr('src', blobURL);
            $('#img_preview img').css('width', '400px');
            $('#img_preview').slideDown(); //업로드한 이미지 미리보기 
            $(this).slideUp(); //파일 양식 감춤
            $('#option').attr('value',2);
        }
    });

    $('#img_preview a').bind('click', function() {
        resetFormElement($('#img')); //전달한 양식 초기화
        $(this).parent().slideUp(100); //미리 보기 영역 감춤
        $('#img').slideDown(100); //파일 양식 보여줌
        $('#option').attr('value',3);
        return false; //기본 이벤트 막음
    });
    $('#close').bind('click', function() {
        resetFormElement($('#review')); //전달한 양식 초기화
        $('#option').attr('value',1);
    	$('#img_preview').css('display','');
    });

    /** 
    * 폼요소 초기화 
    */
    function resetFormElement(e) {
        e.wrap('<form>').closest('form').get(0).reset(); 
        //리셋하려는 폼양식 요소를 폼(<form>) 으로 감싸고 (wrap()) , 
        //요소를 감싸고 있는 가장 가까운 폼( closest('form')) 에서 Dom요소를 반환받고 ( get(0) ),
        //DOM에서 제공하는 초기화 메서드 reset()을 호출
        e.unwrap(); //감싼 <form> 태그를 제거
        $('#img_preview img').attr("src","${goRoot}${review_bean.img }");
        $('#img_preview img').css('width', '100%');
        $('#img_preview a').attr("href","${goRoot}${review_bean.img }");
        
    }
    
    /* 댓글  */
	var p_no=${review_bean.rev_no };
	var co_type="review";
	
	<!-- TODO: event 댓글 제이쿼리 -->
		/* 댓글  */
		function settingModifyBtn(){
			var email = "${login_email}";
			$(".comBtn").each(function(){
			 	checkEmail=$(this).attr("email");
				if(email != checkEmail){
					$(this).css("display","none")
				};
			});
		};
		<%//TODO 댓글 리스트%>
		//댓글 리스트 받아오기.
		function getAllList(){
			$.getJSON('/reset/'+co_type+"/"+p_no+"/comment",function(data){
				var str="";
				/*//TODO: 댓글 수정 버튼을 세션에 맞게 보여야함.  */
				$(data).each(
					function(){
					str+=
						"<div class='commentLi'>"
						+"<hr class='com_hr'/>"
						+"<div class='com_writer com_div'><strong>"+this.writer+"</strong></div>"
						+"<div  class='com_nalja com_div'>"+this.nalja+"</div>"
						+"<div data-co_no='"+this.co_no+"' class='textCo'>"+this.content+"</div>"
						+"<div class='com_btn'><button class='comBtn redBtn' email="+this.email+">댓글수정</button></div>"
						+"</div>";
					});
				$("#comment").html(str);
				settingModifyBtn();
			});// AJAX
		};//getAllList end
		
		$(function(){
			getAllList();
		}); // 최초로드 end
	 
		//댓글 추가 버튼
		$("#comment_addBtn").on("click",function(){
			var writer =$("#writer").val();
			var content =$("#content").val().replace(/(?:\r\n|\r|\n)/g,"<br/>");
			var email =$("#email").val();
			<%//TODO url 경로 변경해야함.%>
			$.ajax({
				type:'post',
				url: '/reset/'+co_type+'/'+p_no+'/'+'comment/add',
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method_Override" : "POST"		
				},
				dataType:'text',
				data : JSON.stringify({
					writer : writer,
					email : email,
					content : content,
					co_type : co_type,
					p_no : p_no
				}),
				success : function(result){
					if(result == 'SUCCESS'){
						alert("등록 되었습니다.");
						$("#content").val("");
						getAllList();
					}
				}
			});
		}); //comment add end
	
		//댓글수정 버튼 클릭시 모달이 나옴.
		$("#comment").on("click",".commentLi button",function(){
			var comment=$(this).parent().parent().find(".textCo");
			var co_no = comment.attr("data-co_no");
			
			var replytext=comment.text();
			$("#commentnum").val(co_no);
			$("#commenttext").val(replytext);
			$("#modDiv").show("slow");
		});
		
		//댓글 수정 버튼 클릭시
		$("#commentModBtn").on("click",function(){
			var co_no=$("#commentnum").val();
			//var content=$("#commenttext").val();
			var content =$("#commenttext").val().replace(/(?:\r\n|\r|\n)/g,"<br/>");
			$.ajax({
				type: 'put',
				url:'/reset/'+co_type+'/'+p_no+'/comment/'+co_no,
				headers:{
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "PUT"
				},
				data:JSON.stringify({content:content}),
				dataType:'text',
				success:function(result){
					console.log("result:"+result);
					if(result=='SUCCESS'){
						$("#modDiv").hide("slow");
						getAllList();
					}
				}
			});
		});
		
		//댓글 삭제 버튼 클릭시
		$("#commentDelBtn").on("click",function(){
			var co_no=$("#commentnum").val();
			$.ajax({
				type: 'delete',
				url: '/reset/'+co_type+'/'+p_no+'/comment/'+co_no,
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "DELETE"
				},
				dataType : 'text',
				success : function(result){
					console.log("result:"+result);
					if(result=='SUCCESS'){
						alert("삭제되었습니다");
						$("#modDiv").hide("slow");
						getAllList();
					}
				}
			});
		});
		
</script> 
</body>
</html>