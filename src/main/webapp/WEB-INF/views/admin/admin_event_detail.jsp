<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<%@include file="/WEB-INF/views/template/admin_header.jsp" %>
<script src="${goRoot }js/contents_img.js"></script>
<link href="${goRoot}css/btn/btn.css" rel="stylesheet">
<script type="text/javascript">
$(document).ready(function(){
	//전 페이지로 이동
	$("#listBack").click(function(){
		window.history.back();
	});
	
	//댓글 닫기 버튼 클릭시 모달 감추기
	$("#closeBtn").click(function(){
		$("#modDiv").hide();
	});
});
</script>
<style type="text/css">
.page_container{
	max-width: 1080px;
	margin: 0px auto;
}
.contents_container{
    text-align: center;
}
.btimg{/* 좋아요 아이콘 */
	margin: 2% 1%;
	width: 50px;
}
.viewimg{/* 조회수 아이콘 */
	width: 20px;
	margin-right: 10px;
}
.view{
	margin: 10px;
	color: #b2b0b0;
	text-align: right;
}
#popNum{
	font-size: 1vmax;
}
.funBtn{/* 목록,삭제,추가 버튼 */
	float: right;
}
.delForm{
	clear: both;
	float: right;
}
/* 제목표시줄 아래에 있는 줄 */
#titleHr{
	width: 85%;
	height:1px;
	margin-top: 5px;
	background-color:#313131;
}

#comment{
	margin-top: 20px;
	clear: both;
}
.title{
	font-size: 30px;
}
.nalja{
	font-size: 16px;
	text-align:right;
	color: #b2b0b0;
}
/* 항상위에 오는 버튼 */
.topbtn{
	width: 60px;
}

.alwaysBtn{
	margin-left:70%;
	bottom: 20px;
	position: fixed;
}
.box-title{
	clear: both;
}
.box-footer{/* 댓글 입력버튼 */
	margin-top: 20px;
	float: right;
}
.box-body{
	clear: both;
}
/* 댓글 스타일 */
.com_div{
	display: inline-block;
	margin-bottom: 10px;
}

.com_nalja{
	float: right;
}
.com_hr{
	width: 100%;
	margin-bottom: 1%;
}
.comBtn{
	float: right;
}

/* tags 안보이게 */
.com_emailDiv{
	visibility: hidden;
}
.copy{
	float: right;
}
.endHr{
	clear: both;
}
.cate{
	font-family: NanumSquareR;
	font-size: 15px;
}
.popDiv{
	clear: both;
}
.nalview{
	margin-top: 20px;
	margin-bottom: 20px;
}
/* com_email 안보이게 */
.com_emailDiv{
	visibility: hidden;
}
.addrBtn{
	background-color:#d00b01;
	-moz-border-radius:3px;
	-webkit-border-radius:3px;
	border-radius:3px;
	border:1px solid #d00b01;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:15px;
	font-weight:bold;
	padding:11px 23px;
	text-decoration:none;
	margin: 20px auto;
}
.addrBtn:hover {
	background-color:#d00b01;
}
.addrBtn:active {
	position:relative;
	top:1px;
}

@media (max-width: 991px) {
 	.title{
		font-size: 20px;
	}
	.copy{
		display:inline-block;
		text-align: center;
	}
	.changeDiv{
		display: block;
	}
	.viewimg{/* 조회수 아이콘 */
		width: 13px;
		margin-right: 10px;
	}
	.nalja{
		font-size: 13px;
		text-align:right;
		color: #b2b0b0;
	}
	.topbtn{
		width: 40px;
	}
}
</style>
</head>
<body>
	<!--header-->
    <div id="wrapper">
	<%@include file="/WEB-INF/views/template/admin_side_menu.jsp" %>
        <div id="page-wrapper">
            <div class="container-fluid">
            <!-- 컨탠츠 시작 -->
    <!-- main contents -->
    <div class="page_container">
        <hr>
            <!-- detail-page 입니다. -->
            <!-- 내용 입력 -->
            <div class="contents_container">
            <form method="post" action="/admin/event/${detail.eve_no}">
	            <div>
	            	<span><img src="${goRoot}${detail.img }"></span>
	            </div>
	            <div style="padding: 0 7.5%" class="nalview">
		            <div class="nalja">
		            	<span><strong>${detail.nalja }</strong></span>
		            </div>
		            <div style="clear:both"></div>
		            <div class="view">
		            	<span><img alt="view" src="${goRoot}imgs/icon/view_g.png" class="viewimg"><strong>조회수 ${detail.view}</strong></span>
		            </div>
		        </div>
		        <div style="clear:both"></div>
	            <div>
	            	<span class="title"><strong>${detail.title }</strong></span>
	            	<hr id="titleHr"/>
	            </div>
	            <div>
	            	<span class="con_img">${detail.con }</span>
	            </div>
	            <script type="text/javascript">
	            	var windowWidth=$(window).width();
	            	$(window).resize(function(){
	            		if(windowWidth >= 1200){
	            			con_img(900);
	            			location.reload();
	            		} else if(windowWidth >= 992 && windowWidth < 1200){
	            			con_img(700);
	            			location.reload();
	            		} else if(windowWidth >= 768 && windowWidth < 992){
	            			con_img(500);
	            			location.reload();
	            		} else {
	            			con_img(300);
	            			location.reload();
	            		}
	            	});
	            	$(function(){
	            		if(windowWidth >= 1200){
	            			con_img(900);
	            		} else if(windowWidth >= 992 && windowWidth < 1200){
	            			con_img(700);
	            		} else if(windowWidth >= 768 && windowWidth < 992){
	            			con_img(500);
	            		} else {
	            			con_img(300);
	            		}
	            	});
	            </script>
	            <div class="com_emailDiv">
	            	<span>${detail.com_email }</span>
	            </div>
	            <!-- TODO:이벤트 주소입력 으로 가는곳입니다. -->
				<!-- TODO:이벤트 주소입력 끝 -->
				<c:if test="${login_on=='true'}">
				<!-- 좋아요. -->
	            <div class="popDiv dis">
					<img alt="unLikes" src="${goRoot}imgs/icon/red_like.png" id="unLikes" class="likeBtn btimg">
					<span><strong id="su">${detail.pop }</strong></span>
	            </div>
	            </c:if>
	            <!-- 좋아요 끝 -->
	        <div class="funBtn">
				<button type="reset" id="listBack" class="listBtn darkBtn">목록</button>
			<c:if test="${login_on=='true' && (login_user_type=='CEO' || login_user_type=='직원')}">
				<button type="submit" class="editBtn redBtn">수정</button>
			</c:if>
			</div>
			</form>
			<c:if test="${login_on=='true' && (login_user_type=='CEO' || login_user_type=='직원')}">
			<form method="post" action="/admin/event/${detail.eve_no}" class="delForm">
				<input type="hidden" name="_method" value="delete">
				<input type="hidden" name="img" id="img" value="${detail.img }">
				<button type="submit" class="deleteBtn redBtn">삭제</button>
			</form>
			</c:if>
			</div>
			<!-- 항상 화면 위에 이동버튼 -->
			<div class="alwaysBtn">
				<a href="#content">
					<img alt="goCom" class="topbtn comAlbtn" src="${goRoot}imgs/icon/grey-comment.png" onmouseover="this.src='${goRoot}imgs/icon/red-comment.png'" onmouseout="this.src='${goRoot}imgs/icon/grey-comment.png'">
				</a>
				<a href="#">
					<img alt="goTop" class="topbtn topAlbtn" src="${goRoot}imgs/icon/grey-top.png" onmouseover="this.src='${goRoot}imgs/icon/red-top.png'" onmouseout="this.src='${goRoot}imgs/icon/grey-top.png'">
				</a>
			</div>
			<!-- 내용 끝 -->
			<!-- TODO: event 댓글입력(comment) 시작 -->
			<div>
				<div class="box box-success">
					<div class="box-header">
						<h3 class="box-title">댓글</h3>
					</div>
					<div class="box-body">
						<!-- 고정값 및 임의값 -->
						<!-- TODO: event_댓글 로그인 세션에서 받아와야함 -->
						<input class="form-control" type="hidden" name="writer" id="writer" value="${login_nick }">
						<!-- 댓글 글쓰는곳 -->
						<textarea rows="5" class="form-control" type="text" name="content" id="content"></textarea>
						<!-- 고정값 및 임의값 -->
						<!-- TODO: event_댓글 로그인 세션에서 받아와야함 -->
						<input class="form-control" type="hidden" name="email" id="email" value="${login_email }">
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
			<div id="modDiv" style="display : none;">
				<div class="modal-title">
					<input type="hidden" id="commentnum" >
				</div>
				<div>
					<textarea rows="5" class="form-control" type="text" id="commenttext"></textarea>
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
		   	 	<div id="comment">
				
				</div>
			</div>
			<!-- TODO: event 댓글 리스트 끝 -->
         <hr class="endHr">
    </div>
    <!-- //main contents -->
            <!-- 컨탠츠 끝 -->
            </div><!-- /.container-fluid -->
        </div><!-- /#page-wrapper -->
    </div><!-- /#wrapper -->
<!-- TODO: event 댓글 제이쿼리 -->
<script type="text/javascript">
		/* 댓글  */
		var p_no=${detail.eve_no};
		var co_type="event";
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
			$.getJSON('/'+co_type+"/"+p_no+"/comment",function(data){
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
				url: '/'+co_type+'/'+p_no+'/'+'comment/add',
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
				url:'/'+co_type+'/'+p_no+'/comment/'+co_no,
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
				url: '/'+co_type+'/'+p_no+'/comment/'+co_no,
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
