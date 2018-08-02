<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/WEB-INF/views/template/head.jsp"%>
<link rel="stylesheet" href="${goRoot }css/ranking_review/item_detail.css" type="text/css">
<script type="text/javascript">
<!-- TODO:[sch] 1.ajax로 리스트 크롤링 -->
var page='${fn:length(review_bean) }';/* 해당 페이지 리스트 갯수 */
var	pageTot=${tot};/* 리스트 총 갯수 */
$(document).ready(function(){
	var email="";
	email="${login_email}";
	if(email!=""){
		cartCheck(email);
	}
	if(page>=pageTot){
		$("#listAdd>img").hide();
	}
	
	$("#listAdd").click(function(){
		if(page>=pageTot){
			$("#listAdd>img").hide();
		}else{
			reviewListadd();
		}
	});
	$("#cartAdd").click(function(){
		if(email!=''){
			cartAdd();
		}
	});
	$("#cartDel").click(function(){
		if(email!=''){
			cartDel();
		}	
	});
	
	$('#review_write').on('shown.bs.modal', function () {
	})	 
	
	
	$("#reivewAdd").on("click",function(){
		var result=reviewCheck();
		if(result){
		var item=${item_bean.item};
		var formData = new FormData($('#review')[0]);
		    $.ajax({
				type:"post",
				enctype: 'multipart/form-data',
				data : formData,
				url: "/item/"+item,
				contentType: false,
				processData: false,
				dataType: "text"
			}) 
			.done(function(data){
				expUp("review");
				console.log(data);
				if(data=="1"){
					window.location.href=item;
				} else if(data=="0"){
					alert("글쓰기에 실패하였습니다.");
				}
		 	})
			.fail(function () { // 실패했을때 불러질 함수
				console.error('데이터 입력 실패');
			})
		};
		})
		
	
});

/* 리스트 추가 버튼 클릭시 실행 */
function reviewListadd(){
	
	var item=${item_bean.item};
	var Data= {"page": page};
	$.ajax({
	        type: 'GET', // get 방식으로 요청
			dataType: 'text', // json 타입
			url: "reviewListadd?item="+item, // 데이터를 불러오는 json-server 주소입니다 .
			data: Data
	})
	.done(function(data){
 		$('#listAdd').prev().after(data);
 		page=page-0+5;
		if(page>=pageTot){
			$("#listAdd>img").hide();
		}
	})
	.fail(function (data) { // 실패했을때 불러질 함수
		console.error('데이터 불러오기 실패'+data);
	})
} 
function cartCheck(email){
	var item=${item_bean.item};
	//var nick=${login_email}; // TODO:[sch] 찜목록저장시 아이디 수정
	$.ajax({
	        type: 'GET', // get 방식으로 요청
			dataType: 'json', // json 타입
			url: "cart?item="+item+"&email="+email // 데이터를 불러오는 json-server 주소입니다 .
	})
	.done(function(data){
		if(data==1){//이미 찜하기 하였음
			console.log("찜함");
			$('#cartAdd').hide();
		}else if(data==0){//찜하기 안함.
			console.log("찜하기 안함");
			$('#cartDel').hide();	
		}
	})
	.fail(function () { // 실패했을때 불러질 함수
		console.log('실패');
	}) 
}

function cartAdd(){
	var item=${item_bean.item};
	//var nick=${login_email};// TODO:[sch] 찜목록저장시 아이디 수정 
	var email='${login_email}';
	$.ajax({
	        type: 'GET', // get 방식으로 요청
			dataType: 'json', // json 타입
			url: "cartAdd?item="+item+"&email="+email // 데이터를 불러오는 json-server 주소입니다 .
	})
	.done(function(data){
		if(data==1){
			window.alert("찜하셨습니다.");	
			$('#cartAdd').hide();
			$('#cartDel').show();
		}else{
 			window.alert("실패하셨습니다.");
		}
	})
	.fail(function () { // 실패했을때 불러질 함수
		console.error('실패');
	})
} 
function cartDel(){
	var item=${item_bean.item}; 
	//var nick=${login_email}; // TODO:[sch] 찜목록저장시 아이디 수정 
	var email='${login_email}';
	$.ajax({
	        type: 'GET', // get 방식으로 요청
			dataType: 'json', // json 타입
			url: "cartDel?item="+item+"&email="+email // 데이터를 불러오는 json-server 주소입니다 .
	})
	.done(function(data){
		if(data==1){
			$('#cartAdd').show();
			$('#cartDel').hide();
			window.alert("찜하기를 취소하셨습니다.");
		}else{
 			window.alert("실패하셨습니다.");
		}
	})
	.fail(function () { // 실패했을때 불러질 함수
		console.error('실패');
	})
}
function expUp(type){
	<!-- //TODO: [sch] 밑에 세션 이메일로 바꿀것 -->
	var email ='${login_email}';
		var type = type;//review,comment,like
		$.ajax({
			type : 'POST',
			url : '/exp',
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
	
function reviewCheck(){
	 var star = $(':input[name=star]:radio:checked').val();
	 var good = $("#good");
	 var bad = $("#bad");
	 var tip = $("#tip");
     
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
	 
	 if(star){
    	 return true;
     } else{
         alert("별점을 선택해주세요.");
         $(".star").focus();
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
			<a href="/">HOME</a> <span class="slash">/</span> 로션
		</div>
	</div>
	<!--//header-->

	<!-- main contents -->
	<div class="page_container">
		<div class="contentsBox">
			<div class="ImgBox">
				<img src="${goRoot}${item_bean.img }" class="img-responsive"
					alt="Responsive image">
			</div>
			<div class="InfoBox">
				<h2>${item_bean.name }</h2>
				<table class="table">
					<tr>
						<td>브랜드</td>
						<td>${item_bean.brand }</td>
					</tr>
					<tr>
						<td>용량</td>
						<td>${item_bean.vol }</td>
					</tr>
					<tr>
						<td>판매가격</td>
						<td>${item_bean.price }원</td>
					</tr>
					<tr>
						<td>평점</td>
						<td>${item_bean.tot }</td>
					</tr>
					<tr>
						<td>기능성 성분</td>
						<td>${item_bean.comp }</td>
					</tr>
					<tr>
						<td>네이버 가격정보</td>
						<td><a
							href="https://search.shopping.naver.com/search/all.nhn?query=${item_bean.name}">바로가기</a></td>
					</tr>
				</table>
			</div>
		</div>
		<div class="avgBox">

			<p>
				<span>총 ${map.total }</span>명 <span>${item_bean.tot }</span>
			</p>
			<table class="table">
				<tr>
					<td><span>5점</span></td>
					<td>
						<div class="progress">
							<div class="progress-bar progress-bar bar1" role="progressbar"
								aria-valuemin="0" aria-valuemax="100"
								style="width: ${map.five }%">${map.five }%</div>
						</div>
					</td>
				</tr>
				<tr>
					<td><span>4점</span></td>
					<td>
						<div class="progress">
							<div class="progress-bar progress-bar bar2" role="progressbar"
								aria-valuemin="0" aria-valuemax="100"
								style="width: ${map.four }%">${map.four }%</div>
						</div>
					</td>
				</tr>
				<tr>
					<td><span>3점</span></td>
					<td>
						<div class="progress">
							<div class="progress-bar progress-bar bar3" role="progressbar"
								aria-valuemin="0" aria-valuemax="100"
								style="width: ${map.three }%">${map.three }%</div>
						</div>
					</td>
				</tr>
				<tr>
					<td><span>2점</span></td>
					<td>
						<div class="progress">
							<div class="progress-bar progress-bar bar4" role="progressbar"
								aria-valuemin="0" aria-valuemax="100"
								style="width: ${map.two }%">${map.two }%</div>
						</div>
					</td>
				</tr>
				<tr>
					<td><span>1점</span></td>
					<td>
						<div class="progress">
							<div class="progress-bar progress-bar bar5" role="progressbar"
								aria-valuemin="0" aria-valuemax="100"
								style="width: ${map.one }%">${map.one }%</div>
						</div>
					</td>
				</tr>
			</table>

		</div>
		
		<c:if test="${login_on=='true'}">
		<div class="btn-position">
			<!-- Button trigger modal -->
			<button type="button" class="btn btn-lg RedBtn" data-toggle="modal"
				data-target="#review_write">글쓰기</button>
			<button type="button" class="btn btn-lg RedBtn" id="cartAdd">
				찜하기</button>
			<button type="button" class="btn btn-lg RedBtn" id="cartDel">
				찜취소</button>
		</div>
		</c:if>
		
		<c:forEach items="${review_bean }" var="review">
			<a href="./${item_bean.item }/review/${review.rev_no}">
				<div class="reviewBox">
					<div class="left_img_box">
						<c:choose>
							<c:when test="${review.img != ''}">
								<img src="${goRoot}${review.img}" />
							</c:when>
							<c:when test="${review.img == ''}">
								<img class="emptyImg" src="${goRoot}imgs/thany.png" />
							</c:when>
						</c:choose>
					</div>
					<div class="right_content_box">
						<div class="right_content_top">
							<span class="rightBox"> <label><img
									src="${goRoot}imgs/icon/like.png"> ${review.pop }</label> <label>/
									${review.nalja }</label>
							</span>
						</div>
						<div class="right_content_bottom">
							<p>${review.writer }<br> <span class="sub-title">${review.age }세
									/ ${review.skin } / ${review.gender } / </span>
							</p>
							<c:choose>
								<c:when test="${review.star == 1}">
									<div class="starRating1">
										<img class="star" src="${goRoot}imgs/icon/grade_img.png">
									</div>
								</c:when>
								<c:when test="${review.star == 2}">
									<div class="starRating2">
										<img class="star" src="${goRoot}imgs/icon/grade_img.png">
									</div>
								</c:when>
								<c:when test="${review.star == 3}">
									<div class="starRating3">
										<img class="star" src="${goRoot}imgs/icon/grade_img.png">
									</div>
								</c:when>
								<c:when test="${review.star == 4}">
									<div class="starRating4">
										<img class="star" src="${goRoot}imgs/icon/grade_img.png">
									</div>
								</c:when>
								<c:when test="${review.star == 5}">
									<div class="starRating5">
										<img class="star" src="${goRoot}imgs/icon/grade_img.png">
									</div>
								</c:when>
							</c:choose>
							<br> <br>
							<p>${review.good }</p>
							<br>
							<p>${review.bad }</p>
						</div>
					</div>
				</div>
			</a>
		</c:forEach>
		<div id="listAdd" class="icon">
			<img class="listAddBtn" src="${goRoot}imgs/icon/grey-bottom.png"
				onmouseover="this.src='${goRoot}imgs/icon/red-bottom.png'"
				onmouseout="this.src='${goRoot}imgs/icon/grey-bottom.png'">
		</div>
	</div>
	<!-- //main contents -->

	<!-- Modal -->
	<div class="modal fade" id="review_write" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">리뷰 쓰기</h4>
				</div>
				<div class="modal-body">
					<form id="review" action="/item/${item_bean.item}"
						name="review" method="post" enctype="multipart/form-data">
						<input type="hidden" name="writer" value="${login_nick }" />

						<div class="form-group">
							<label>좋은점</label>
							<textarea class="form-control textbox" rows="3" name="good" id="good"></textarea>
						</div>
						<div class="form-group">
							<label>나쁜점</label>
							<textarea class="form-control textbox" rows="3" name="bad" id="bad"></textarea>
						</div>
						<div class="form-group">
							<label>꿀팁</label>
							<textarea class="form-control textbox" rows="3" name="tip" id="tip"></textarea>
						</div>

						<div class="radi">
							<label>별점</label> 
							<label class="radio-inline" for="star">1</label>점
							<input type="radio" name="star" value="1" /> 
							<label class="radio-inline" for="star">2</label>점 
							<input type="radio" name="star" value="2" /> 
							<label class="radio-inline" for="star">3</label>점
							<input type="radio" name="star" value="3" /> 
							<label class="radio-inline" for="star">4</label>점 
							<input type="radio"	name="star" value="4" /> 
							<label class="radio-inline" for="star">5</label>점
							<input type="radio" name="star" value="5" /><br>
						</div>
						<br>

						<div class="imgDiv">
							<label for="img">대표이미지</label> <input type="file" name="img"
								id="img" class="darkBtn">
						</div>
					</form>
					<div id="img_preview">
						<img src="#" /> <br /> <a href="#">Remove</a>
					</div>

				</div>
				<div class="modal-footer">
					<button type="button" id="close" class="btn-lg darkBtn"	data-dismiss="modal">닫기</button>
					<button type="button" id="reivewAdd" class="btn-lg RedBtn">등록</button>
				</div>
			</div>
		</div>
	</div>
	<!-- //modal -->

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
        }
    });

    $('#img_preview a').bind('click', function() {
        resetFormElement($('#img')); //전달한 양식 초기화
        $('#img').slideDown(); //파일 양식 보여줌
        $(this).parent().slideUp(); //미리 보기 영역 감춤
        return false; //기본 이벤트 막음
    });
    $('#close').bind('click', function() {
        resetFormElement($('#img')); //전달한 양식 초기화
        resetFormElement($('#review')); //전달한 양식 초기화
        $('#img').slideDown(); //파일 양식 보여줌
        $('#img_preview').slideUp(); //미리 보기 영역 감춤
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
    }
        	
    </script>
</body>
</html>