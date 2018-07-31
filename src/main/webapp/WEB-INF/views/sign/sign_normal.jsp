<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/views/template/head.jsp" %>

<link href="${goRoot }css/login/sign_css.css" rel="stylesheet">
<link href="${goRoot }css/btn/btn.css" rel="stylesheet">
<script src="${goRoot}js/ser.js"></script>
<script src="${goRoot}js/sign.js"></script>
<script type="text/javascript">
	$(function() {
		addFormEvent();

		$("#form").submit(function(e) {
			e.preventDefault();
			var result = submitCheck();
			if (result) {
				var form = document.getElementById("form");
				var password = document.createElement("input");
				password.setAttribute("type","hidden");
				password.setAttribute("name","password");
				
					var pw = $("#password").val();
					//$("#password").val(SHA256(pw));
					password.setAttribute("value",SHA256(pw));
					$(form).append(password);
				var data = $('#form').serialize();
				console.log(data);
				$.post(".", data, function(output) {
					if (output.result == 200) {
						window.location.href = output.url;
					} else {
						alert("알수 없는 이유로 회원가입이 실패하였습니다. 잠시후 다시 이용해주세요");
					}
				});// end $.post
			}// end if
		});// end submit event
	});
</script>
<style>
/* label 글씨속성  */
.page_container label{
font-weight: bold;
font-size : 15px;
} 

/* 붉은색 테두리 
 .row-setting {
	background: white;
	border-radius: 3px;
	border: 1px solid #dd2d25;
	padding: 50px 50px 50px -100px;
} */

/* 회원가입 */
.entry-title {
	margin-bottom: 30px;
	font-weight: 800;
	font-size: 30px;
	color: #D00B01;
	margin-left: auto;
    margin-right: auto;
} 

/* 회원가입 아래 바 */
.entry-title:after {
    content: " ";
    width: 100px;
    height: 5px;
    background: #D00B01;
    display: block;
    margin-top: 20px;
    border-radius: 3px;

}

/* input style */
.page_container .form-control{
border-radius: 0px;
background-color: #D1D1D1;
opacity: 0.6; 
height: 50px;
}

/* input placeholder색 옅게 */
.form-control::placeholder {
    color: black;
   opacity: 0.5; 
}
 
/* 입력수정버튼 위치조정 */ 
 .btn-group{
margin-top: 30px;}

/* 입력버튼 css */
.redbtn {
	background-color: #d00b01;
	-moz-border-radius: 3px;
	-webkit-border-radius: 3px;
	border-radius: 3px;
	border: 1px solid #D00B01;
	display: inline-block;
	cursor: pointer;
	color: #ffffff;
	font-family: Arial;
	font-size: 15px;
	font-weight: bold;
	padding: 11px 23px;
	text-decoration: none;
}
/* 입력버튼 css */
.redbtn:active {
	position: relative;
	top: 1px;
}


/* 취소버튼 css */
.blackbtn {
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
	padding: 11px 23px;
	text-decoration: none;
}
/* 취소버튼 css */
.blackbtn:active {
	position: relative;
	top: 1px;
}





</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/template/menu.jsp" %>
    <!-- main contents -->
    <div class="container">
		<div class="row">
	<form action="./" method="post" id="form" class="form-horizontal">
		    <h1 class="entry-title"><span>회원가입</span></h1>
        	<hr>
		<div class="form-group">
			 <label  for="email" class="control-label col-sm-2">Email ID </label>
			 <div class="col-md-8 col-sm-6">	
			 	<div class="input-group">
			 	    <span class="input-group-addon">@</span>
					<input type="email" name="email" id="email" class="form-control" value="${login_email }" placeholder="이메일입력"/>
	         	</div>
	         </div>
		</div>
		<div class="form-group">
			<label for="nick" class="control-label col-sm-2">닉네임 </label>
			<div class="col-md-8 col-sm-6">	
				<div class="input-group">
					<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
					<input type="text" name="nick" id="nick" class="form-control" placeholder="닉네임 입력"/>
				</div>
			</div>
		</div>
		<c:if test="${login_route eq 'normal' }">
		<div class="form-group">
			<label for="password" class="control-label col-sm-2">password </label>
			<div class="col-md-8 col-sm-6">
				<div class="input-group">
					<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
					<input type="password" id="password" class="form-control" placeholder="영소대문자,숫자 포함. 10자이상"/>
				</div>
			</div>
		</div>
		<div class="form-group">
			<label for="pwchk"  class="control-label col-sm-2">확인 </label>
			<div class="col-md-8 col-sm-6">
				<div class="input-group">
					<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
					<input type="password" id="pwchk" class="form-control"/>
				</div>
			</div>
		</div>
		</c:if>
		<div class="form-group">
			<label for="phone" class="control-label col-sm-2">연락처</label>
			<div class="col-md-8 col-sm-6">
				<div class="input-group">
              		<span class="input-group-addon"><i class="glyphicon glyphicon-phone"></i></span>
					<input type="text" name="phone" id="phone" class="form-control" placeholder="-를 제외한 숫자만 입력"/>
				</div>
			</div>
		</div>
		<div class="form-group">
			<label for="gender" class="control-label col-sm-2">age</label>
			<div class="col-md-8 col-sm-6">
				<div class="input-group">
					<span class="input-group-addon"><i class="glyphicon glyphicon-plus"></i></span>
					<input type="number" name="age" id="age" class="form-control" value="30"  min="1" max="150" step="1"/>
					<span class="input-group-addon"><i class="glyphicon glyphicon-minus"></i></span>
				</div>
			</div>	
		</div>
		<div class="form-group">
			<label for="gender" class="control-label col-sm-2">성별</label>
			<div class="col-md-8 col-sm-6 funkyradio">
				<div class="funkyradio-primary">
					<input type="radio" name="gender" id="gender_1" value="남성" />
					<label for="gender_1">남성</label><br>
 				</div>
        		<div class="funkyradio-success">
 					<input type="radio" name="gender" id="gender_2" value="여성" checked/>
 					<label for="gender_2">여성</label><br>
				</div>
			</div>
		</div>
		<div class="form-group">
			<label for="gender" class="control-label col-sm-2">피부타입</label>
			<div class="col-md-8 col-sm-6 funkyradio">
				<div class="funkyradio-danger">
					<input type="radio" name="skin" id="skin_1" value="지성" checked/><label for="skin_1">지성</label><br>
	 			</div>
				<div class="funkyradio-warning">
	 				<input type="radio" name="skin" id="skin_2" value="건성" /><label for="skin_2">건성</label><br>
	 			</div>
				<div class="funkyradio-info">
	 				<input type="radio" name="skin" id="skin_3" value="민감성"/><label for="skin_3">민감성</label><br>
	 			</div>
			</div>	
  		</div>
  		<input type="hidden" name="join_route" value="${login_route}" />
		<input type="hidden" name="user_type"value="일반" />
		<input type="hidden" name="cart" value=";"/>
		<input type="hidden" name="exp" value="0"/>
		<div>
			<div class="col-sm-2"></div>
			<div role="group" class="btn-group col-md-8 col-sm-6">
				<button type="submit" class="btn redBtn">입력</button>
				<button type="reset" class="btn darkBtn">취소</button>
			</div>
		</div>
	</form>
	</div><!-- end Row -->
	</div><!--  end container -->
    <!-- //main contents -->
	<%@ include file="/WEB-INF/views/template/footer.jsp" %>
    <!--footer-->
    
    <!--//footer-->    

</body>
</html>
