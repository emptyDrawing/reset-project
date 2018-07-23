<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="${goRoot}js/jquery-1.12.4.js"></script>
<script src="${goRoot}js/bootstrap.min.js"></script>
<link href="${goRoot}css/bootstrap.min.css" rel="stylesheet">
<link href="${goRoot}css/bootstrap-theme.min.css" rel="stylesheet">
<link href="${goRoot}css/main.css" rel="stylesheet">
<link href="${goRoot}css/btn/btn.css" rel="stylesheet">
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
	<title>Home</title>
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
</script>
<style type="text/css">
.page_container{
	max-width: 1080px;
	margin: 0px auto;
}
.contents_container{
	display: inline-block;
	margin: 0px auto;
}
body {
    background: #fff;
	font-family: 'Roboto', sans-serif;
	color:#333;
	line-height: 22px;	
}
h1, h2, h3, h4, h5, h6 {
	font-family: 'Roboto Condensed', sans-serif;
	font-weight: 400;
	color:#111;
	margin-top:5px;
	margin-bottom:5px;
}
h1, h2, h3 {
	text-transform:uppercase;
}

input.upload {
    position: absolute;
    top: 0;
    right: 0;
    margin: 0;
    padding: 0;
    font-size: 12px;
    cursor: pointer;
    opacity: 1;
    filter: alpha(opacity=1);    
}

.form-inline .form-group{
    margin-left: 0;
    margin-right: 0;
}
.control-label {
    color:#333333;
}
</style>
</head>
<body>
	<!--header-->
    <div class="header">
    	<div class="wrap">
            <nav class="main_menu container">
                <div class="menu_img">
                    <img src="imgs/header_logo.png">
                </div>
                <div class="menu_login">
                    <form class="form-inline">
                        <div class="form-group">
                            <label class="sr-only" for="search">검색</label>
                            <input type="text" class="form-control input_box" placeholder="검색">
                        </div>
                        <button type="submit" class="btn send_btn"><span class="main_font">검색</span></button>
                        <button type="submit" class="btn send_btn"><span class="main_font">로그인</span></button>
                        <button type="submit" class="btn send_btn"><span class="main_font">회원가입</span></button>
                    </form>
                </div>
                <div class="menu_bar">
                    <ul class="nav">
                      <li class="current"><a href="index.html">홈</a></li>
                      <li><a href="about.html">랭킹</a></li>
                      <li class="top-menu"><a href="javascript:{}">화플</a>
                          <ul class="sub-menu">
                              <li><a href="scaffolding.html">Scaffolding</a></li>
                              <li><a href="typography.html">Typography</a></li>
                              <li><a href="shortcodes.html">Shortcodes</a></li>
                              <li><a href="tables.html">Tables</a></li>
                          </ul>
                      </li>
                      <li class="top-menu"><a href="javascript:{}">이벤트</a>
                           <ul class="sub-menu">
                              <li><a href="portfolio_2columns.html">2 Columns</a></li>
                              <li><a href="portfolio_3columns.html">3 Columns</a></li>
                              <li><a href="portfolio_4columns.html">4 Columns</a></li>
                          </ul>
                      </li>                                  
                      <li class="top-menu"><a href="javascript:{}">리뷰</a>
                           <ul class="sub-menu">
                              <li><a href="blog.html">Blog with right sidebar</a></li>
                              <li><a href="blog_post.html">Blog post</a></li>
                          </ul>
                      </li>
                      <li><a href="contacts.html">문의</a></li>
                    </ul>
                </div>
             </nav>                
             
        </div>    
    </div>
    <!--//header-->    
     
    <!-- main contents -->
    <div class="page_container">
        <hr>
            <!-- 내용 입력 시작-->
            <div class="contents_container">
	       	<div class="row">
   			<div class="col-md-8">
   			<h1 class="entry-title"><span>이벤트 참가 주소입력</span></h1>
   			<hr>
			<form method="post" action="/reset/event/${event}/addr">
				<div>
					<input type="hidden" name="eve_no" id="eve_no" value="${event}">
				</div>
				<div class="form-group">
		          <label class="control-label col-sm-3">Email ID<span class="text-danger">*</span></label>
		          <div class="col-md-8 col-sm-9">
		              <div class="input-group">
			              <span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
			              <input type="email" class="form-control" name="email" id="email" placeholder="연락 받으실  Email 주소를 적어주세요." value="">
		              </div>
		            	<small><br></small> 
		          </div>
		        </div>
				<div class="form-group">
		          <label class="control-label col-sm-3">참가하시는분 성함 <span class="text-danger">*</span></label>
		          <div class="col-md-8 col-sm-9">
		            <input type="text" class="form-control" name="name" id="name" placeholder="성함을 적어주세요." value="">
		          	<small><br></small>
		          </div>
		        </div>
		        
		        <div class="form-group">
		          <label class="control-label col-sm-3">주소 <span class="text-danger">*</span></label>
		          <div class="col-md-8 col-sm-9">
		            <input type="text" style="width:70px;" class="form-control" id="zipNo"  name="zipNo" readonly="readonly"/>
		          	<small><br></small>
		          </div>
		          <label class="control-label col-sm-3"></label>
		          <div class="col-md-8 col-sm-9">
		            <input type="text" class="form-control" id="roadAddrPart1"  name="roadAddrPart1" readonly="readonly"/>
		          	<small><br></small>
		          </div>
		          <label class="control-label col-sm-3"></label>
		          <div class="col-md-8 col-sm-9">
		            <input type="text" class="form-control" id="addrDetail"  name="addrDetail" placeholder="상세주소를 입력해 주세요."/>
		          	<small><br></small>
		          </div>
		          <label class="control-label col-sm-3"></label>
		          <div class="col-md-8 col-sm-9">
		          	<a href=""  class="redBtn"  data-toggle="modal" data-target=".bs-example-modal-sm">주소검색</a>
		          	<small><br><br></small>
		          </div>
		        </div>
		        

		        <div class="form-group">
		          <label class="control-label col-sm-3">전화번호 <span class="text-danger">*</span></label>
		          <div class="col-md-8 col-sm-9">
		          	<div class="input-group">
		              <span class="input-group-addon"><i class="glyphicon glyphicon-phone"></i></span>
		              <input type="text" class="form-control" name="phone" id="phone" placeholder="연락받으실 전화번호를 적어주세요." value="">
		            </div>
		            <small><br></small>
		          </div>
		        </div>
		       
		        <div class="form-group">
		          <div class="col-xs-offset-3 col-xs-10">
   					<button type="submit" class="darkBtn">이벤트 참가</button>
					<button type="reset" class="redBtn">취소</button>
		          </div>
		        </div>
			</form>
			</div><!-- col-md-8 end -->
			</div><!-- row end -->
			</div>
			<div id="address_modal" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
			  <div class="modal-dialog modal-sm" role="document">
			    <div id="layer" class="modal-content"></div>
			  </div>
			</div>
           	<!-- 내용 입력 끝 -->
        <hr>
    </div>
    <!-- //main contents -->
	<%@include file="../../views/template/ajax_loading.jsp" %>
    <!--footer-->
    <div class="footer">
        <div class="wrap">
            <div class="container">
                <div class="row">
                    <div class="footer_L">
                        <div class="foot_logo"><a href="index.html"><img src="imgs/footer_logo.png" alt="" /></a></div>
                        <div class="copyright">&copy; 2020 Jessica White. Professional Fashion Photography. All Rights Reserved.</div>                        
                    </div>
                    <div class="footer_R">
                        <div class="fright">
                            <form action="#" method="post">
                                <input class="inp_search" name="name" type="text" value="   Search the Site" onfocus="if (this.value == 'Search the Site') this.value = '';" onblur="if (this.value == '') this.value = 'Search the Site';" />
                            </form>
                        </div>
                        <div class="footer_menu">
                            <ul class="nav">
                                <li><a href="index.html" class="current">홈</a></li>
                                <li><a href="about.html">랭킹</a></li>
                                <li><a href="scaffolding.html">화플</a></li>
                                <li><a href="portfolio_2columns.html">이벤트</a></li>
                                <li><a href="blog.html">리뷰</a></li>
                                <li><a href="contacts.html">문의</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--//footer-->
</body>
</html>
