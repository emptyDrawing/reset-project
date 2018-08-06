<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<%@include file="/WEB-INF/views/template/admin_header.jsp" %>
<style type="text/css">

.container {
	font-family: NanumSquareR;
	font-size: 20px;
}    
    
.textareadiv{
margin-top : 15px;
visibility:hidden;
}

#answer{
width:100%;
display: hidden;
}

.well {
	background: white;
	border-style: none;

}
.redbtnForanswer {
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
	padding: 11px 46px;
	text-decoration: none;
}

.redbtnForanswer:active {
	position: relative;
	top: 1px;
}

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

.redbtn:active {
	position: relative;
	top: 1px;
}

.redbtnFormail {
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
	padding: 11px 46px;
	text-decoration: none;
}

.redbtnFormail:active {
	position: relative;
	top: 1px;
}

.greybtn {
	background-color: #D1D1D1;
	-moz-border-radius: 3px;
	-webkit-border-radius: 3px;
	border-radius: 3px;
	border: 1px solid #D1D1D1;
	display: inline-block;
	cursor: pointer;
	color: #ffffff;
	font-family: Arial;
	font-size: 15px;
	font-weight: bold;
	padding: 11px 23px;
	text-decoration: none;
}

.greybtn:active {
	position: relative;
	top: 1px;
}

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
	position: relative;
}

.blackbtn:active {
	position: relative;
	top: 1px;
}

.blackbtn {
	left-margin: 300px;
}

.btn_container {
	top_margin: 100px;
	diplay:inline-block;
	float: right;
}
</style>

<script type="text/javascript">
	$(document).ready(function() {
		var answerSave = $('#answerSave'); // 답변저장
		var answerWrite = $('#answerWrite'); //답변작성하기
		var answer = $('#answer'); //답변 input
		var answerCancel = $('#answerCancel'); //디테일로 돌아가는 취소창
		var mailSend = $('#mailSend');
		var target = $('#target');
		var saveCancelBtns = $('.saveCancelBtns');
		
		/* answer.hide(); */  // 답변 textarea hide
		answerWrite.css("diplay","block"); //답변 작성하기 보여줌
		mailSend.css("diplay","hidden");
		saveCancelBtns.hide();

			answerWrite.click(function() {
			answer.css("visibility", "visible");
 			answerWrite.hide(); 
			/* answerWrite.css("diplay","hidden"); */
			saveCancelBtns.show();
			answer.show();
			if (target.val() == "등록된 답변이 없습니다. 답변을 입력해주세요") {
			mailSend.css("diplay","hidden");
			}
		}); //답변쓰기 클릭
		
	/* 	answer.hide(); // 답변 textarea hide
		answerWrite.show(); //답변 작성하기 보여줌
		mailSend.hide();
		saveCancelBtns.hide();

			answerWrite.click(function() {
			answerWrite.hide();
			answerWrite.css("diplay","hidden");
			saveCancelBtns.show();
			answer.css("visibility", "visible");
			if (target.val() == "등록된 답변이 없습니다. 답변을 입력해주세요") {
				mailSend.hide();
			}
		}); //답변쓰기 클릭 */ 

		answerSave.click(function() {
			if (answer.val().length < 1) {
				alert("내용을 입력하세요"); //답변 null값이 들어가지 않도록 막음

			} else {
				/* event.preventDefault(); */
				$.ajax({
					type : 'post',
					enctype : 'multipart/form-data',
					url : '/admin/qna/${bean.qa_no }',
					//TODO [jihyun]reset

					dataype : 'text',
					headers : {
						//"Context-Type" : "application/json",
						"X-HTTP-Method-Override" : "POST",

					},
					data : "answer=" + answer.val(),
					success : function(data) {
						console.log(data.result);

						if (data.result == 1) {
							alert("등록되었습니다");
							$("#target").text(data.new_answer);
							$("#mailSend").css("display", "inline-block");
							/* answer.css("visibility", "hidden"); */
							answerSave.css("display", "none");
							answerCancel.css("display", "none");
							answer.css("visibility","hidden");
							
						}
					}
				}); //ajax 답변보여주기 - 답변저장
			} //else end
		});

		mailSend.click(function() {
			$.ajax({ // ajax 이메일전송
				type : "post",
				url : '/mail/qna/${bean.qa_no }',
				//TODO [jihyun]reset
				success : function(data) {
					if (data == 456) {
						/* conform */
						alert('이메일전송완료!');
					}
				}
			}); // ajax 이메일 전송 end
		});//이메일전송 버튼 클릭 이벤트
	}); //document ready end
	
</script>


</head>

<body>
    <div id="wrapper">
	<%@include file="/WEB-INF/views/template/admin_side_menu.jsp" %>
        <div id="page-wrapper">
            <div class="container-fluid">
            <!-- 컨탠츠 시작 -->


	<div class="container">
	<div class="well">
		<h3>글번호 ${bean.qa_no} 상세페이지</h3>

		<hr>
		<form action="${bean.qa_no }" method="post">
			<div class="form-group row">
				<label for="qa_no" class="col-sm-2 col-form-label">글번호</label>
				<%-- <input class="form-control" type="text" placeholder="${bean.qa_no }" readonly> --%>

				<div class="col-sm-10">${bean.qa_no }</div>
			</div>
			<div class="form-group row">
				<label for="nalja" class="col-sm-2 col-form-label">날짜</label>
				<div class="col-sm-10">${bean.nalja }</div>
			</div>
			<div class="form-group row">
				<label for="" class="col-sm-2 col-form-label">이메일</label>
				<div class="col-sm-10">${bean.email }</div>
			</div>
			<div class="form-group row">
				<label for="qa_type" class="col-sm-2 col-form-label">질문유형</label>
				<div class="col-sm-10">${bean.qa_type }</div>
			</div>
			<div class="form-group row">
				<label for="con" class="col-sm-2 orm-label">내용</label>
				<div class="col-sm-10">${bean.con }</div>
			</div>
			<div class="form-group row">
				<label for="answer" class="col-sm-2 control-label">답변</label>
				<div class="col-sm-10">
					<c:choose>
						<c:when test="${empty bean.answer}">
							<span id="target">등록된 답변이 없습니다. 답변을 입력해주세요</span>
						</c:when>
						<c:otherwise>
							<span id="target">${bean.answer }</span>
						</c:otherwise>
					</c:choose>
				</div>				
				
				
				<!-- 답변 answer textarea -->
				<div class="col-sm-2"></div>
				<div class="col-sm-10 textareadiv">
					<textarea name="answer" id="answer" class="answer-input" rows="5" placeholder="답변을 작성하세요"></textarea>
				</div>
				<!-- 답변 answer textarea end-->
				
			</div>
			</div><!-- well end -->

			<div class="form-group">
				<div class="col-sm-9"></div>
				<div class="btn_container col-sm-3">
					<button type="button" id="listbtn" class="blackbtn">목록</button>
					<button type="button" id="answerWrite" class="redbtnForanswer">답변</button>
					<span id="target">
					<button type="button" id="mailSend" name="mailSend" class="redbtnFormail"
						style="display: none">메일전송</button></span>
					<span class="saveCancelBtns">
						<button type="button" id="answerSave" class="redbtn">저장</button>
						<button type="button" id="answerCancel" class="greybtn">취소</button>
					</span>
				</div>
			</div>

		</form>
	</div>
	
	            <!-- 컨탠츠 끝 -->
            </div><!-- /.container-fluid -->
        </div><!-- /#page-wrapper -->
    </div><!-- /#wrapper -->
	
</body>
</html>