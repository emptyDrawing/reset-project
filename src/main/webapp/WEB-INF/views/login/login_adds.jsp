<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.security.SecureRandom"%>
<%@ page import="java.math.BigInteger"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/views/template/head.jsp" %>
<meta name="google-signin-client_id"
	content="1051220480905-p8890ral8a45q8c1q6201a57oqg75k7f.apps.googleusercontent.com">
<script src="https://apis.google.com/js/api:client.js"></script>
<link href="${goRoot }css/btn/btn.css" rel="stylesheet">
<script>
	$(function(){
		$("button[bt='on']").on("click",function(){
			console.log($(this).attr("id"));
			$.post(".","command="+$(this).attr("id"))
				.done(function(data){
					if(data.result==200){
						alert("성공적으로 연동되었습니다.")
					}
					window.location.href=data.redirect;
				});// post End
		})// button click end
	}); // function() end

</script>
</head>
<body>
	<!--header-->
	<%@ include file="/WEB-INF/views/template/menu.jsp" %>
	<!--//header-->
 <style>
            .addEve h1 {
                margin: 0 10px;
                font-size: 50px;
                text-align: center;
            }
            .addEve h1 span {
                color: #bbb;
            }
            .addEve p {
                margin: 1em 0;
            }
            .addEve ul {
                padding: 0 0 0 40px;
                margin: 1em 0;
            }
            .addEve {
                max-width: 80%;
                _width: 80%;
                margin: 0 auto;
                padding: 30px 20px 50px;
                border: 1px solid #b3b3b3;
                border-radius: 4px;
                margin: 0 auto;
                box-shadow: 0 1px 10px #a7a7a7, inset 0 1px 0 #fff;
                font-size: 20px;
                line-height: 1.4;
                color: #737373;
                -webkit-text-size-adjust: 100%;
                -ms-text-size-adjust: 100%;
            }
	</style>
		<h1>Not found <span>:(</span></h1>
            <p>죄송합니다. 입력하신 내용으로 결과를 찾을수 없었습니다.</p>
            <p>다른 검색어/필터를 이용해주세요</p>
	<!-- main contents -->
	<div class="page_container">
	<div class="addEve">
		<div class="row">
			<h1>기존에 <span>[${join_route}]</span> 로 연동하셨습니다. </h1>
			<br/><br/>
			<h2>혹시 <span>[${login_route}]</span>도 연동하시겠습니까?</h2>
			<button bt="on" id="adds_yes" class="redBtn">예</button>
			<button bt="on" id="adds_no" class="darkBtn">로그인다시하기</button>
			<button bt="on" id="adds_back" class="darkBtn">이전경로로 가기</button>
		</div>
	</div>
		
	</div>
	<!-- //main contents -->

	<!--footer-->
		<%@ include file="/WEB-INF/views/template/footer.jsp" %>
	<!--//footer-->
</body>
</html>