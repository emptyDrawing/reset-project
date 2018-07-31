<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<%@include file="/WEB-INF/views/template/admin_header.jsp" %>
<script src="${goRoot}ckeditor/ckeditor.js"></script>
<link href="${goRoot }css/btn/btn.css" rel="stylesheet">
<script type="text/javascript">
 $(function(){
	 $("#listBack").click(function(){
		 window.history.go(-2);
		});
	 
	 $("#com_email").val("${detail.com_email}").prop("selected", true);
	 
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
	            $('#Existing_img').hide();
	            $(this).slideUp(); //파일 양식 감춤
	        }
	    });
	 $('#preview button').bind('click', function() {
	        resetFormElement($('#img')); //전달한 양식 초기화
	        $('#img').slideDown(); //파일 양식 보여줌
	        $(this).parent().slideUp(); //미리 보기 영역 감춤
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
	 var title = $("#title");
	 var cate = $("#cate option:selected");
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
	/* 미리보기 이미지 사이즈 */
	#control_img { /* div에 주는것도 좋은 방법임. */
		width: 300px;
	}
	#preview{
		width: 570px;
		height: 350px;
	}
	.delImgBtn{
		display: block;
	}
	.imgDiv label { 
		display: inline-block; 
		padding: .5em .75em; 
		font-size: inherit; 
		line-height: normal;
		color:#ffffff; 
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
		clip:rect(0,0,0,0); 
		border: 0; 
		}
</style>
</head>
<body>
<div id="wrapper">
<%@include file="/WEB-INF/views/template/admin_side_menu.jsp" %>
   <div id="page-wrapper">
       <div class="container-fluid">
       <!-- 컨탠츠 시작 -->
				<!-- main contents -->
				<div class="page_container">
					<!-- 내용 입력 시작-->
					<!-- Magazine update-page 입니다. -->
					<form method="post"
						action="/reset/admin/magazine/${detail.mag_no}/update"
						enctype="multipart/form-data" id="magazine_updateForm"
						onsubmit="return magazineCheck()">
						<!-- <input type="hidden" name="_method" value="put"/> -->
						<div>
							<label for="mag_no"></label> <input type="hidden" name="mag_no"
								id="mag_no" value="${detail.mag_no }">
						</div>
						<div class="imgDiv">
							<label for="img">대표이미지 수정</label>
							<div name="Existing_img" id="Existing_img">
								<img src="${goRoot}${detail.img}">
							</div>
							<input type="file" name="img" id="img" class="darkBtn" value="${detail.img}">
						</div>
						<div id="preview">
							<img src="#" id="control_img">
							<button type="button" class="redBtn delImgBtn">대표이미지 삭제</button>
						</div>
						<div>
							<label for="title">제목</label> <input type="text" name="title"
								id="title" value="${detail.title }" class="form-control">
						</div>
						<div>
							<label for="con">내용</label>
							<textarea name="con" id="con">${detail.con }</textarea>
							<!-- ckeditor를 사용하여 서버로 이미지를 올리고 다시 불러오는 설정입니다. -->
							<script>
				    $(function(){
				         
				        CKEDITOR.replace( 'con', {//해당 이름으로 된 textarea에 에디터를 적용
				            width:'100%',
				            height:'400px',
				            filebrowserImageUploadUrl: '/reset/add/img' //여기 경로로 파일을 전달하여 업로드 시킨다.
				        });
				         
				         
				        CKEDITOR.on('dialogDefinition', function( ev ){
				            var dialogName = ev.data.name;
				            var dialogDefinition = ev.data.definition;
				          
				            switch (dialogName) {
				                case 'image': //Image Properties dialog
				                    //dialogDefinition.removeContents('info');
				                    dialogDefinition.removeContents('Link');
				                    dialogDefinition.removeContents('advanced');
				                    break;
				            }
				        });
				         
				    });
				</script>
						</div>
						<div>
							<label for="cate">카테고리</label> <select name="cate" id="cate">
								<option value=1 <c:if test="${detail.cate}==1">selected</c:if>>신상&amp;트렌드</option>
								<option value=2 <c:if test="${detail.cate}==2">selected</c:if>>화장품
									펙트체크</option>
								<option value=3 <c:if test="${detail.cate}==3">selected</c:if>>인기템
									리뷰</option>
								<option value=4 <c:if test="${detail.cate}==4">selected</c:if>>다이어트&amp;운동</option>
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

						<button type="submit" class="redBtn" id="updateBtn">수정</button>
						<button type="reset" class="darkBtn" id="listBack">목록</button>
					</form>
					<script type="text/javascript">
	       	 $("#updateBtn").on('submit',function(event){
	       		 event.preventDefault();
	    		 var mag_no=${detail.mag_no};
	    		 console.log(eve_no);
	    		 var formData = new FormData($("#magazine_updateForm")[0]);
	    		 console.log(formData);
	    		 
	    	     $.ajax({
	    	       type:'post',
	    	       enctype: 'multipart/form-data',
	    	       data : formData,
	    	       url: '/reset/admin/magazine/'+mag_no+'/update',
	    	       contentType: false,
	    	       processData: false,
	    	       dataType: "Text"
	    	    }) 
	    	    .done(function(data){
	    	       console.log("전송"); 
	    	     })
	    	    .fail(function () { // 실패했을때 불러질 함수
	    	       console.error('데이터 입력 실패');
	    	    })  
	    	 });
            
            </script>
					<!-- 내용 입력 끝 -->
				</div>
				<!-- //main contents -->
				<!-- 컨탠츠 끝 -->
			</div><!-- /.container-fluid -->
   </div><!-- /#page-wrapper -->
</div><!-- /#wrapper -->  
</body>
</html>