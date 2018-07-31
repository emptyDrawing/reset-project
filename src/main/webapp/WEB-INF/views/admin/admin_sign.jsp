<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/WEB-INF/views/template/admin_header.jsp"%>
<link href="${goRoot }css/login/sign_css.css" rel="stylesheet">
<link href="${goRoot }css/btn/btn.css" rel="stylesheet">
<script src="${goRoot}js/ser.js"></script>
<script src="${goRoot}js/sign.js"></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>

<script type="text/javascript">
var element_layer;
function sample2_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
            var fullAddr = data.address; // 최종 주소 변수
            var extraAddr = ''; // 조합형 주소 변수

            // 기본 주소가 도로명 타입일때 조합한다.
            if(data.addressType === 'R'){
                //법정동명이 있을 경우 추가한다.
                if(data.bname !== ''){
                    extraAddr += data.bname;
                }
                // 건물명이 있을 경우 추가한다.
                if(data.buildingName !== ''){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('zipNo').value = data.zonecode; //5자리 새우편번호 사용
            document.getElementById('roadAddrPart1').value = fullAddr;
            element_layer.style.display = 'none';
        },
        width : '100%',
        height : '100%',
        maxSuggestItems : 5,
        onclose: function(state) {
            if(state === 'FORCE_CLOSE'){
                //사용자가 브라우저 닫기 버튼을 통해 팝업창을 닫았을 경우, 실행될 코드를 작성하는 부분입니다.
				$('#address_modal').modal('hide')
            } else if(state === 'COMPLETE_CLOSE'){
                //사용자가 검색결과를 선택하여 팝업창이 닫혔을 경우, 실행될 코드를 작성하는 부분입니다.
                //oncomplete 콜백 함수가 실행 완료된 후에 실행됩니다.
                $('#address_modal').modal('hide')
            }
        }
    }).embed(element_layer,{autoClose:true});

    // iframe을 넣은 element를 보이게 한다.
    element_layer.style.display = 'block';
    initLayerPosition();
}
function initLayerPosition(){
    var width = 500; //우편번호서비스가 들어갈 element의 width
    var height = 500; //우편번호서비스가 들어갈 element의 height
    var borderWidth = 1; //샘플에서 사용하는 border의 두께

    // 위에서 선언한 값들을 실제 element에 넣는다.
    //element_layer.style.width = width + 'px';
    element_layer.style.height = height + 'px';
    element_layer.style.border = borderWidth + 'px solid';
}
$(function(){
	$('#address_modal').on('show.bs.modal', function (e) {
		element_layer = document.getElementById('layer');
		sample2_execDaumPostcode();
		});
	$('#address_modal').on('hide.bs.modal',function(e){
	    $('#addrDetail').focus();
	});
});// end document.onload

	function addFormEve() {
		//
		$("#form input").each(function() {
			$(this).on("focus", function() {
				$(this).val('');
				$(this).css("color", "black");
				$(this).parent().parent().find(".errM").remove();
			});
		});

		$("#email").on("blur", function(e) {
			checkEmail(e.target)
		});
		if ($("#password").length > 0) {
			$("#password").on("blur", function(e) {
				checkPW(e.target)
			});
			$("#pwchk").on("blur", function(e) {
				checkRePW(e.target)
			});
		}
		$("#phone").on("blur", function(e) {
			checkPhone(e.target)
		});
		$("#phone").on("keydown", function(e) {
			onlyNumber(e)
		});
		$("#phone").on("keyup", function(e) {
			onlyNumber(e)
		});
		//$("#bisnum").on("blur",function(e){checkBisNum(e)}); 이거했다가 재앙임
		$("#bisnum").on("keydown", function(e) {
			onlyNumber(e)
		});
		$("#bisnum").on("keyup", function(e) {
			onlyNumber(e)
		});

	}// addFormEvent();
	// 문서 온로드 시점
	$(function() {
		addFormEve();

		$("#form").submit(function(e) {
			e.preventDefault();
			var result = submitCheck();
			if (result) {
				var form = document.getElementById("form");
				var password = document.createElement("input");
				password.setAttribute("type","hidden");
				password.setAttribute("name","password");
					var pw = $("#password").val();
					alert("패스워드:"+pw);
					password.setAttribute("value",SHA256(pw));
				// 주소 병함해야됨.
				var zipVal =$("#zipNo").val();
				var addr1= $("#roadAddrPart1").val();
				var addr2 = $("#addrDetail").val();
				
				
				var postcode = document.createElement("input");
				postcode.setAttribute("type","hidden");
				postcode.setAttribute("name","postcode");
				postcode.setAttribute("value",zipVal);
				
				var address = document.createElement("input");
				address.setAttribute("type","hidden");
				address.setAttribute("name","address");
				address.setAttribute("value",addr1+" "+addr2);
				
				$(form).append(postcode);
				$(form).append(address);
				$(form).append(password);
				var data = $('#form').serialize();
				console.log(data);
				// TODO :[KSS] 경로 수정해야됨
 				$.post("/reset/sign/", data, function(output) {
					if (output.result == 200) {
						alert("회원등록 완료");
						window.location.href = "${goRoot}admin/";
					} else {
						alert("알수 없는 이유로 회원등록이 실패하였습니다. 잠시후 다시 이용해주세요");
					}
				});// end $.post 
			}// end if
		});// end submit event
	});
</script>
<style>
<
style> /* label 글씨속성  */ .page_container label {
	font-weight: bold;
	font-size: 15px;
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
.page_container .form-control {
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
.btn-group {
	margin-top: 30px;
}

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
	<div id="wrapper">
		<%@include file="/WEB-INF/views/template/admin_side_menu.jsp"%>
		<div id="page-wrapper">
			<div class="container-fluid">
				<!-- Page Heading -->
				<div class="row">
					<div class="col-lg-12">
						<h1 class="page-header">계정등록</h1>
					</div>
				</div>
				<!-- /.row -->
				<div class="row">
					<div class="col-xs-8 col-xs-offset-2">
						<!-- main contents -->
						<div class="row">
							<form action="./" method="post" id="form" class="form-horizontal">
								<div class="form-group">
									<label for="email" class="control-label col-sm-2">Email</label>
									<div class="col-md-8 col-sm-6">
										<div class="input-group">
											<span class="input-group-addon">@</span>
											<input type="email"	name="email" id="email" class="form-control" placeholder="이메일입력" />
										</div>
									</div>
								</div>
								<div class="form-group">
									<label for="password" class="control-label col-sm-2">password</label>
									<div class="col-md-8 col-sm-6">
										<div class="input-group">
											<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
											<input type="password" id="password" class="form-control" placeholder="영소대문자,숫자 포함. 10자이상" />
										</div>
									</div>
								</div>
								<div class="form-group">
									<label for="pwchk" class="control-label col-sm-2">확인 </label>
									<div class="col-md-8 col-sm-6">
										<div class="input-group">
											<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
											<input type="password" id="pwchk" class="form-control" />
										</div>
									</div>
								</div>
								<div class="form-group">
									<label for="company" class="control-label col-sm-2">기업이름</label>
									<div class="col-md-8 col-sm-6">
										<div class="input-group">
											<span class="input-group-addon"><i class="glyphicon glyphicon-briefcase"></i></span>
											<input type="text" name="company" id="company" class="form-control" placeholder="담당자-호칭까지 입력" />
										</div>
									</div>
								</div>
								<div class="form-group">
									<label for="bisnum" class="control-label col-sm-2">사업자번호</label>
									<div class="col-md-8 col-sm-6">
										<div class="input-group">
											<span class="input-group-addon"><i class="glyphicon glyphicon-asterisk"></i></span>
											<input type="text" name="bisnum" id="bisnum" class="form-control" placeholder="-제외하고 입력" />
										</div>
									</div>
								</div>
								<div class="form-group">
									<label for="manager" class="control-label col-sm-2">담당자</label>
									<div class="col-md-8 col-sm-6">
										<div class="input-group">
											<span class="input-group-addon">
											<i class="glyphicon glyphicon-user"></i></span>
											<input type="text" name="manager" id="manager" class="form-control" placeholder="담당자-호칭까지 입력" />
										</div>
									</div>
								</div>
								<!-- 기업주소 넣어야됨 -->
								<div class="form-group">
									<label for="" class="control-label col-sm-2">주소</label>
									<div class="col-md-8 col-sm-6">
										<div class="input-group">
										<a href="#"  class="redBtn"  data-toggle="modal" data-target=".bs-example-modal-sm">주소검색</a>
			           					<input type="text" style="width:150px;" class="form-control" id="zipNo" readonly="readonly" placeholder="우편번호"/>
			            				<input type="text" class="form-control" id="roadAddrPart1"  readonly="readonly"placeholder="기본주소"/>
			            				<input type="text" class="form-control" id="addrDetail"  placeholder="상세주소를 입력해 주세요."/>
			          					</div>
			          				</div>
		          				</div>
		          				<div id="address_modal" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
									  <div class="modal-dialog modal-sm" role="document">
									    <div id="layer" class="modal-content"></div>
									  </div>
								</div>
		          				
								<div class="form-group">
									<label for="phone" class="control-label col-sm-2">연락처</label>
									<div class="col-md-8 col-sm-6">
										<div class="input-group">
											<span class="input-group-addon">
											<i class="glyphicon glyphicon-phone"></i></span>
											<input type="text" name="phone" id="phone" class="form-control" placeholder="-를 제외한 숫자만 입력" />
										</div>
									</div>
								</div>
								<div class="form-group">
									<label for="user_type" class="control-label col-sm-2">계정유형</label>
									<div class="col-md-8 col-sm-6 funkyradio">
										<div class="funkyradio-danger">
											<input type="radio" name="user_type" id="user_1" value="광고주"
												checked /><label for="user_1">광고주</label><br>
										</div>
										<div class="funkyradio-warning">
											<input type="radio" name="user_type" id="user_2" value="직원" /><label for="user_2">직원</label><br>
										</div>
										<div class="funkyradio-warning">
											<input type="radio" name="user_type" id="user_3" value="CEO" /><label for="user_3">관리자</label><br>
										</div>
									</div>
								</div>
								<input type="hidden" name="join_route" value="normal" />
								<div>
									<div class="col-sm-2"></div>
									<div role="group" class="btn-group col-md-8 col-sm-6">
										<button type="submit" class="btn redBtn">입력</button>
										<button type="reset" class="btn darkBtn">취소</button>
									</div>
								</div>
							</form>
						</div>
						<!-- end Row -->
					</div>
					<!--  end container -->
					<!-- //main contents -->
				</div>
				<!-- end row -->
			</div>
			<!-- /.container-fluid -->
		</div>
		<!-- /#page-wrapper -->
	</div>
	<!-- /#wrapper -->
</body>
</html>