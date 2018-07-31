<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/WEB-INF/views/template/admin_header.jsp"%>
<script src="${goRoot }ckeditor/ckeditor.js"></script>
<link href="${goRoot }css/btn/btn.css" rel="stylesheet">
<script type="text/javascript">
 $(function(){
	 $('#preview').hide();
	 
	 $('#img').on('change', function() {
	        
	        ext = $(this).val().split('.').pop().toLowerCase(); //확장자
	        
	        //배열에 추출한 확장자가 존재하는지 체크
	        if($.inArray(ext, ['gif', 'png', 'jpg', 'jpeg']) == -1) {
	            resetFormElement($(this)); //폼 초기화
	            window.alert('이미지 파일이 아닙니다! (gif, png, jpg, jpeg 만 업로드 가능)');
	        } else {
	            file = $('#img').prop("files")[0];
	            blobURL = window.URL.createObjectURL(file);
	            $('#preview img').attr('src', blobURL);
	            $('#preview').slideDown(); //업로드한 이미지 미리보기 
	            $(this).slideUp(); //파일 양식 감춤
	            $('.imgDiv').hide();
	        }
	    });
	 $('#preview button').bind('click', function() {
	        resetFormElement($('#img')); //전달한 양식 초기화
	        $('#img').slideDown(); //파일 양식 보여줌
	        $(this).parent().slideUp(); //미리 보기 영역 감춤
	        $('.imgDiv').show();
	        return false; //기본 이벤트 막음
	    });
	 
	 function resetFormElement(e) {
	        e.wrap('<form>').closest('form').get(0).reset(); 
	        //리셋하려는 폼양식 요소를 폼(<form>) 으로 감싸고 (wrap()) , 
	        //요소를 감싸고 있는 가장 가까운 폼( closest('form')) 에서 Dom요소를 반환받고 ( get(0) ),
	        //DOM에서 제공하는 초기화 메서드 reset()을 호출
	        e.unwrap(); //감싼 <form> 태그를 제거
	    }
	  
 });
 
 function magazineCheck(){
	 var img= $("#img");
	 var title = $("#title");
	 var cate = $("#cate option:selected");
	 if(img.val()== ""){
		 alert("썸네일을 올려 주세요");
		 return false;
	 }
	 if(title.val() == ""){
		 alert("제목을 입력해 주세요");
		 $("#title").focus();
		 return false;
	 }
	 if(CKEDITOR.instances.con.getData()==""){
		 alert("내용을 입력해 주세요");
		 CKEDITOR.instances.con.focus();
		 return false;
	 }
	 if(cate.val()==99){
		 alert("카테고리를 골라주세요");
		 $("#cate").focus();
		 return false;
	 }
 };
</script>
<style type="text/css">
#control_img { /* div에 주는것도 좋은 방법임. */
	width: 300px;
}

#preview {
	width: 570px;
	height: 350px;
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

.delimgBtn {
	display: block;
}
</style>
</head>
<body>
	<div id="wrapper">
		<%@include file="/WEB-INF/views/template/admin_side_menu.jsp"%>
		<div id="page-wrapper">
			<div class="container-fluid">
				<!-- 컨탠츠 시작 -->
				<!-- main contents -->
				<div class="page_container">
					<!-- 내용 입력 -->
					<!-- TODO: 김형준 magazine 내용입력 -->
					<!-- magazine add-page 입니다. -->
					<form action="/reset/admin/magazine" method="post"
						enctype="multipart/form-data" id="magazine_addForm"
						onsubmit="return magazineCheck()">
						<div class="imgDiv">
							<label for="img">대표이미지</label> <input type="file" name="img"
								id="img" class="darkBtn">
						</div>
						<div id="preview">
							<img src="#" id="control_img">
							<button type="button" class="redBtn delimgBtn">대표이미지 삭제</button>
						</div>
						<div>
							<label for="title">제목</label> <input type="text" name="title"
								id="title" class="form-control">
						</div>
						<div>
							<label for="con">내용</label>
							<textarea name="con" id="con"
								style="width: 700px; height: 400px;"></textarea>
							<!-- ckeditor를 사용하여 서버로 이미지를 올리고 다시 불러오는 설정입니다. -->
							<script>
								$(function() {

									CKEDITOR
											.replace(
													'con',
													{//해당 이름으로 된 textarea에 에디터를 적용
														width : '100%',
														height : '400px',
														filebrowserImageUploadUrl : '/reset/add/img' //여기 경로로 파일을 전달하여 업로드 시킨다.
													});

									CKEDITOR
											.on(
													'dialogDefinition',
													function(ev) {
														var dialogName = ev.data.name;
														var dialogDefinition = ev.data.definition;

														switch (dialogName) {
														case 'image': //Image Properties dialog
															//dialogDefinition.removeContents('info');
															dialogDefinition
																	.removeContents('Link');
															dialogDefinition
																	.removeContents('advanced');
															break;
														}
													});

								});
							</script>
						</div>
						<div>
							<label for="cate">카테고리</label> <select name="cate" id="cate">
								<option value=99>카테고리 선택</option>
								<option value=1>신상&amp;트렌드</option>
								<option value=2>화장품 펙트체크</option>
								<option value=3>인기템 리뷰</option>
								<option value=4>다이어트&amp;운동</option>
							</select>
						</div>
						<div>
							<label for="com_email">광고주 Email</label>
							<div>
								<select class="form-control" name="com_email" id="com_email">
									<option value="">광고주 Email을 선택해주세요</option>
									<c:forEach items="${companyList }" var="companyList">
										<option value="${companyList.email}">${companyList.company}/${companyList.manager}/${companyList.email}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<!-- //TODO : writer를 받아야함. 로그인 정보로 받기.-->
						<dvi> <input type="hidden" name="writer" id="writer"
							value="${login_nick}"> </dvi>
						<div>
							<button type="submit" id="addBtn" class="redBtn">등록</button>
							<button type="reset" class="darkBtn">취소</button>
						</div>
					</form>
					<script type="text/javascript">
						$("#addBtn").on(
								'submit',
								function(event) {
									event.preventDefault();
									var formData = new FormData(
											$("#magazine_addForm")[0]);

									$.ajax({
										type : "post",
										enctype : 'multipart/form-data',
										data : formData,
										url : "/reset/admin/magazine",
										contentType : false,
										processData : false,
										dataType : "Text"
									}).done(function(data) {
										console.log("전송");

									}).fail(function() { // 실패했을때 불러질 함수
										console.error('데이터 입력 실패');
									})
								});
					</script>
					<!-- 내용 끝 -->
				</div>
				<!-- //main contents -->
				<!-- 컨탠츠 끝 -->
			</div>
			<!-- /.container-fluid -->
		</div>
		<!-- /#page-wrapper -->
	</div>
	<!-- /#wrapper -->


</body>
</html>