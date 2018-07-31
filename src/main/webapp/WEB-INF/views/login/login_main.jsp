<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.security.SecureRandom"%>
<%@ page import="java.math.BigInteger"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="google-signin-client_id"
	content="1051220480905-p8890ral8a45q8c1q6201a57oqg75k7f.apps.googleusercontent.com">
<link href="${goRoot}css/bootstrap.min.css" rel="stylesheet">
<link href="${goRoot}css/bootstrap-theme.min.css" rel="stylesheet">
<link href="${goRoot}css/main.css" rel="stylesheet">
<link href="${goRoot }css/login/login_css.css" rel="stylesheet" >
<link href="${goRoot }css/jquery.bxslider.css" rel="stylesheet" >
<script src="${goRoot}js/jquery-1.12.4.js"></script>
<script src="${goRoot}js/bootstrap.min.js"></script>
<script src="${goRoot}js/login.js"></script>
<script src="${goRoot}js/ser.js"></script>
<script src="${goRoot}js/jquery.flexslider.js"></script>
<script src="https://apis.google.com/js/api:client.js"></script>
<script type="text/javascript" src="${goRoot }js/jquery.bxslider.js"></script>
<style type="text/css">
ul,ol,li{margin: 0px; padding: 0px; list-style: none;}
.slides img{
	max-width: 100%; 
}
.flexslider {
	z-index:-1;
	text-align: center;
	margin-top: 3%;
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
@media (max-width: 1199px) {
	.flexslider {
		margin-top: 9%;
	}
}
</style>
<!-- Latest compiled and minified JavaScript -->
<script>
	// 전부 login.js 로 넣을거임
	// 구글용
  var googleUser = {};
  var startGoogleApp = function() {
    gapi.load('auth2', function(){
      // Retrieve the singleton for the GoogleAuth library and set up the client.
      auth2 = gapi.auth2.init({
        client_id: '1051220480905-p8890ral8a45q8c1q6201a57oqg75k7f.apps.googleusercontent.com',
        cookiepolicy: 'single_host_origin',
        scope: 'profile email'
      });
      attachSignin(document.getElementById('google'));
    });
  };
	// 구글용
  function attachSignin(element) {
	$(element).on("click",function(){
		e.preventDefault();
	})
		
	auth2.attachClickHandler(element, {},
        function(googleUser) {
    	  var id_token = googleUser.getAuthResponse().id_token;
		  var xhr = new XMLHttpRequest();
    	  xhr.open('POST', 'http://localhost:8080/reset/login/google/');
    	  xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    	  xhr.send('idtoken=' + id_token);
    	  xhr.onreadystatechange = function () {
    		  if(xhr.readyState === 4 && xhr.status === 200) {
    	        var myJson = JSON.parse(this.responseText);
    	        // 200 성공, 201 회원가입, 300 연동
    	        if(myJson.result==200)alert("로그인성공");
    	        else if(myJson.result==201)alert("회원가입으로 이동");
    	        window.location.href = myJson.redirect;
    		  }
    		};
 		}, function(error) {
          alert(JSON.stringify(error, undefined, 2));
        });
  }
	// 그외 일반
  $(function(){
	startGoogleApp();
/* 	$('.slider').bxSlider();
 */	
	 $('.flexslider').flexslider({
			useCSS: true,
			animation: "slide",
		    controlsContainer: $(".custom-controls-container"),
		  });
  });
  </script>
<script>

	var forCompanySW = false;
$(function(){
	// 이벤트 달기
	$('#findPw').on("click",function(){
	    $('#myModal').modal({
		      show: true
		    });
	});
	$( "#forCompany" ).click(function() {
		$( "#for_company_info" ).toggle( "fast", function() {
			$("#bisnumFind").prop("disabled",forCompanySW);
			forCompanySW = !forCompanySW;
			if(forCompanySW){
				$("#forCompany").text("일반회원으로 찾기");
			}else{
				$("#forCompany").text("기업회원으로 찾기");
			}
		});
	});
	$("input").each(function(){
		$(this).on("focus",function(e){
	        $(e.target).val('');
	        $(this).css("color","black");
	        $(this).parent().find(".errM").remove();
	    });
	});
	
	$(".check-email").each(function(){
		$(this).on('blur',function(e){
			checkEmail(e.target);
		});
	});
	$(".only-num").on('keyup',onlyNumber);
	$(".only-num").on('keydown',onlyNumber);

	$("#goLogin").on('click',function(){
		if(submitCheck(document.getElementById("login_form"))){
			var tmpPW = $("#password").val();
			alert(tmpPW);
			//$("#password").val(SHA256(tmpPW));
			var form = document.getElementById("login_form");
			var password = document.createElement("input");
			password.setAttribute("type","hidden");
			password.setAttribute("name","password");
			password.setAttribute("value",SHA256(tmpPW));
			console.log(password);
			$(form).append(password);
			
			formData = $("#login_form").serialize();
			console.log(formData);
			$.post("./normal/",formData)
				.done(function(data) {
					if(data.result>=200 && data.result<400){
						alert(data.msg);
						window.location.href=data.redirect;
					}else{
						alert(data.msg);
					}
			  	})
			  	.fail(function() {
			    	alert( "알수 없는 오류" );
			  	});
		}	
	});// goLogin 클릭이벤트 끝
	
	$("#checkInfo").on('click',function(){
		var $bisnum = $("#bisnumFind");
		if($bisnum.val()=="") $("#bisnumFind").val(0);
		if(submitCheck(document.getElementById("findForm"))){
			var abc = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
			var newPw = Math.random().toString(22).slice(5) 
					+ abc.charAt(Math.floor(Math.random() * abc.length));
			$("#tmp1").val(newPw);
			$("#tmp2").val(SHA256(newPw));
			formData = $("#findForm").serialize();
			$.post("../find/",formData)
			.done(function(data) {
				if(data.result>=200 && data.result<400){
					alert(data.msg);
				}else{
					alert(data.msg);
				}
		  	})
		  	.fail(function() {
		    	alert( "알수 없는 오류" );
		  	});
		}
	});// #checkInfo
		
});
</script>
</head>
<%
  	SecureRandom random = new SecureRandom();
  	String state = new BigInteger(130, random).toString();
  
  	String naver_clientId = "tfJeSZAfwMMgSJ0l4M9h";//애플리케이션 클라이언트 아이디값";
    String naver_redirectURI = URLEncoder.encode("http://localhost:8080/reset/login/naver/", "UTF-8");
    String naver_apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code"; 
    naver_apiURL += "&client_id=" + naver_clientId;
    naver_apiURL += "&redirect_uri=" + naver_redirectURI;
    naver_apiURL += "&state=" + state;
    session.setAttribute("state", state);

    String kakao_clientId = "f709273524fdad8902b81660b68a0735";//애플리케이션 클라이언트 아이디값";
	String kakao_redirectURI = "http://localhost:8080/reset/login/kakao/"; // TODO 나중에 바꿀거
    String kakao_apiURL = "https://kauth.kakao.com/oauth/authorize?response_type=code";
    kakao_apiURL += "&client_id=" + kakao_clientId;
    kakao_apiURL += "&redirect_uri=" + kakao_redirectURI;
    //kakao_apiURL += "&state=" + state;
%>
<body style="padding-top: 20px;">
<!------ Include the above in your HEAD tag ---------->

<section class="login-block">
	<div class="container">
		<div class="row">
		<div class="col-md-4 login-sec">
		    <h2 class="text-center">Login Now</h2>
		    <form id="login_form">
				<div class="form-group">
				  <label for="exampleInputEmail1" class="text-uppercase">Email</label>
				  <input type="email" name="email" id="email" class="form-control check-email" placeholder="">
				</div>
				
				<div class="form-group">
				  <label for="exampleInputPassword1" class="text-uppercase">Password</label>
				  <input type="password" id="password" class="form-control" placeholder="">
				</div>
    			<div class="loginBtn">
    				<span class="loginA">
	    				<a href="#" id="findPw"><strong class="loginB">비밀번호 찾기</strong></a>
	    				&nbsp;
	    				<a href="../sign/"><strong class="loginB">회원가입</strong></a>
    				</span>
					<a href="#" id="goLogin" class="btn btn-login float-right">로그인</a>
    			</div>
    			
    			<hr class="line"/>
    			<div class="webBtn">
    				<a href="<%=kakao_apiURL%>"><img alt="" src="${goRoot }imgs/login_imgs/kakao.png" class="webicon"></a>
    				<a href="<%=naver_apiURL%>"><img alt="" src="${goRoot }imgs/login_imgs/naver.png" class="webicon"></a>
    				<a href="#" id="google"><img alt="" src="${goRoot }imgs/login_imgs/google.png" class="webicon"></a>
    			</div>
			</form>
		</div><!-- <div class="col-md-4 login-sec"> end -->
		<div class="col-md-8 banner-sec">
          <%--  <div class="slider">
  			<div><img alt="" src="${goRoot }imgs/login_imgs/1.jpg"> </div>
 			 <div><img alt="" src="${goRoot }imgs/login_imgs/2.jpg"></div>
			</div> --%>
			
			<div class="flexslider">
			  <ul class="slides">
			    <li>
			      <img src="${goRoot }imgs/login_imgs/1.jpg" />
			    </li>
			    <li>
			      <img src="${goRoot }imgs/login_imgs/2.jpg" />
			    </li>
			  </ul>
			</div>
		</div><!-- banner-sec end -->
	</div>
</div><!-- container end -->
		<!-- login Modal -->
		<div class="modal" id="myModal" aria-hidden="true" style="display: none; z-index: 1050;">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title">비밀번호 찾기</h4>
					</div>
					<div class="container"></div>
					<div class="modal-body">
						비밀번호를 찾을려면 로그인 개인정보를 입력
						<form id="findForm">
			    			<button type="button" class="btn btn-default" id="forCompany">기업회원 찾기</button>
			  				<div class="form-group">
			  					<label for="emailFind">Email</label>
			  					<input type="email" name="emailFind" class="form-control check-email" id="emailFind" placeholder="email">
							</div>
			  				<div class="form-group">
			  					<label for="phoneFind">연락처</label>
			  					<input type="text" name="phoneFind" class="form-control only-num" id="phoneFind" placeholder="-제외한 숫자만 입력">
							</div>
							<div class="form-group" id="for_company_info" style="display:none">
			  					<label for="bisnumFind">사업자번호</label>
			  					<input type="text" name="bisnumFind" class="form-control only-num" id="bisnumFind" placeholder="-제외한 숫자만 입력" disabled="disabled">
							</div>
							<input type="hidden" name="tmp1" id="tmp1" value="0"/>
							<input type="hidden" name="tmp2" id="tmp2" value="0"/>
			    			<div>
			    				<button type="button" class="btn btn-default" id="checkInfo">확인하기</button>
			    			</div>
						</form>
						<div id="result"></div>						
					</div>
				</div>
			</div>
		</div>
		<!-- login Modal end -->
</section>
<%@ include file="/WEB-INF/views/template/ajax_loading.jsp" %>
	<!-- footer 들어가야됨 -->
</body>
</html>