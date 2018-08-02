<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<%@include file="/WEB-INF/views/template/admin_header.jsp" %>
<style type="text/css">
    /* 전체 container */
    .page_container{
    	width: 80%;
        border: 1px solid rgb(217, 222, 232);
    }
    .contentsBox{
        width: 100%;
        height: 500px;
    }
    .ImgBox{
        width: 50%;
        float: left;
    }
    .ImgBox>img{
    	max-width: 100%;
    }
    .InfoBox{
        width: 50%;
        margin: 100px 0px;
        float: left;
    }
    
    .ImgBox>img{
		max-height: 400px;
		margin: 0px auto;
    }
    .avgBox{
    	width: 95%;
    	margin: 0px auto;
   		border: 1px solid #e5e5e5;
    }
    .avgBox>table>tbody>tr>td:first-child{
    	width: 10%;
    	text-align: center;
    }
    .bar1{
    	background-image: -webkit-linear-gradient(top,#FDEB71 0,#F8D800 100%);
    }
    .bar2{
    	background-image: -webkit-linear-gradient(top,#ABDCFF 0,#0396FF 100%);
    }
    .bar3{
    	background-image: -webkit-linear-gradient(top,#FEB692 0,#EA5455 100%);
    }
    .bar4{
    	background-image: -webkit-linear-gradient(top,#CE9FFC 0,#7367F0 100%);
    }
    .bar5{
    	background-image: -webkit-linear-gradient(top,#90F7EC 0,#32CCBC 100%);
    }
    .reviewBox{
    	width: 95%;
    	border: 1px solid #e5e5e5;
    	margin: 0px auto;
    }
    .icon{
   	    text-align: center;
   	    margin: 5px 0px;
    }
   	.btn-color{
   		color: white;
   		background-image: -webkit-gradient(linear,left top,left bottom,from(#F5515F),to(#A1051D));
   	}
   	.btn-position{
   	    text-align: center;
   	    margin: 5px 0px;
   	}
   	.btn-file {
	    position: relative;
	    overflow: hidden;
	}
	.btn-file input[type=file] {
	    position: absolute;
	    top: 0;
	    right: 0;
	    min-width: 100%;
	    min-height: 100%;
	    font-size: 100px;
	    text-align: right;
	    filter: alpha(opacity=0);
	    opacity: 0;
	    outline: none;
	    background: white;
	    cursor: inherit;
	    display: block;
	}
	#img_preview img{
		width: 100%;
	}
</style>
<script type="text/javascript">

$(document).ready(function(){
	
	$("#itemUpdate").on("click",function(){
		    var item=${item_bean.item};
            var formData = new FormData($('#item')[0]);
		    console.log(formData);
		    $.ajax({
				type:"post",
				enctype: 'multipart/form-data',
				data : formData,
				url: "/admin/itemUpdate/"+item,
				contentType: false,
				processData: false,
				dataType: "text"
			}) 
			.done(function(data){
				console.log(data);
				if(data=="1"){
					window.location.href=item;
				} else if(data=="0"){
					alert("수정에 실패하였습니다.");
				}
		 	})
			.fail(function () { // 실패했을때 불러질 함수
				console.error('데이터 입력 실패');
			})    
		})
	$("#itemDelete").on("click",function(){
		    var item=${item_bean.item};
            var formData = new FormData($('#item')[0]);
		    console.log(formData);
		    $.ajax({
				type:"delete",
				enctype: 'multipart/form-data',
				data : formData,
				url: "/admin/item/"+item,
				contentType: false,
				processData: false,
				dataType: "text"
			}) 
			.done(function(data){
				console.log(data);
				if(data=="1"){
					window.history.back();
				} else if(data=="0"){
					alert("삭제에 실패하였습니다.");
				}
		 	})
			.fail(function () { // 실패했을때 불러질 함수
				console.error('데이터 입력 실패');
			})    
		})
		
	
});

</script>
</head>
<body>
	<!--header-->
    <div id="wrapper">
	<%@include file="/WEB-INF/views/template/admin_side_menu.jsp" %>
        <div id="page-wrapper">
            <div class="container-fluid">
                <!-- Page Heading -->
     
    <!-- main contents -->
   <div class="page_container">
        <div class="contentsBox">
            <div class="ImgBox">
                <img src="${goRoot}${item_bean.img }" class="img-responsive" alt="Responsive image">
            </div>
            <div class="InfoBox">
                <h4>${item_bean.name }</h4>
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
                        <td>태그</td>
                        <td>
                        	<c:forEach var="tag" items="${tags}">
								<span>${tag }</span>
							</c:forEach>
						</td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="avgBox">
        	
            <p>점수 총 <span>${map.total }</span>명 <span>${item_bean.tot }</span>점</p>
            <table class="table">
            	<tr>
         			<td>
         				<span>5점</span>
            		</td>
         			<td>
         				<div class="progress">
							<div class="progress-bar progress-bar bar1" role="progressbar" aria-valuemin="0" aria-valuemax="100" style="width: ${map.five }%">
						    	${map.five }%
							</div>
						</div>
            		</td>
            	</tr>
            	<tr>
         			<td>
         				<span>4점</span>
            		</td>
         			<td>
         				<div class="progress">
						  <div class="progress-bar progress-bar bar2" role="progressbar" aria-valuemin="0" aria-valuemax="100" style="width: ${map.four }%">
						    ${map.four }%
						  </div>
						</div>
            		</td>
            	</tr>
            	<tr>
         			<td>
         				<span>3점</span>
            		</td>
         			<td>
         				<div class="progress">
						  <div class="progress-bar progress-bar bar3" role="progressbar" aria-valuemin="0" aria-valuemax="100" style="width: ${map.three }%">
						    ${map.three }%
						  </div>
						</div>
            		</td>
            	</tr>
            	<tr>
         			<td>
         				<span>2점</span>
            		</td>
         			<td>
						<div class="progress">
							<div class="progress-bar progress-bar bar4" role="progressbar" aria-valuemin="0" aria-valuemax="100" style="width: ${map.two }%">
						    	${map.two }%
					    	</div>
						</div>
            		</td>
            	</tr>
            	<tr>
         			<td>
         				<span>1점</span>
            		</td>
         			<td>
						<div class="progress">
						  <div class="progress-bar progress-bar bar5" role="progressbar" aria-valuemin="0" aria-valuemax="100" style="width: ${map.one }%">
						    ${map.one }%
						  </div>
						</div>
            		</td>
            	</tr>
            </table>
			
        </div>
        
        <div class="btn-position">
	        <!-- Button trigger modal -->
			<button type="button" class="btn btn-lg btn-color" data-toggle="modal" data-target="#item_edit">
			  수정
			</button>
			<button type="button" class="btn btn-lg btn-color" data-toggle="modal" data-target="#item_delete">
			  삭제
			</button>
		</div>
        
	</div>
    <!-- //main contents -->
    
		<!-- Modal -->
		<div class="modal fade" id="item_edit" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="myModalLabel">제품 수정</h4>
		      </div>
		      <div class="modal-body">
		      <form id="item" name="item" method="post" enctype="multipart/form-data">
		      <input type="hidden" id="option" name="option" value="1"/>
		      <input type="hidden" id="preimg" name="preimg" value="${item_bean.img }"/>
		      <input type="hidden" id="tot" name="tot" value="${item_bean.tot }"/>
			    <table class="table">
                	<tr>
                    	<td>분류</td>
                        <td>
	                        <select class="form-control" name="cate" id="cate">
							  <option>essence</option>
							  <option>lotion</option>
							  <option>skin</option>
							</select>
						</td>
                    </tr>
                    <tr>
                    	<td>브랜드</td>
                        <td><input type="text" name="brand" id="brand" value="${item_bean.brand }"></td>
                    </tr>
                    <tr>
                    	<td>이름</td>
                        <td><input type="text" name="name" id="name" value="${item_bean.name }"></td>
                    </tr>
                    <tr>
                        <td>용량</td>
                        <td><input type="text" name="vol" id="vol" value="${item_bean.vol }"></td>
                    </tr>
                    <tr>
                        <td>판매가격</td>
                        <td><input type="number" name="price" id="price" value="${item_bean.price }">원</td>
                    </tr>
                    <tr>
                    	<td>피부타입</td>
                        <td>
	                        <select class="form-control" name="type" id="type">
							  <option>oil</option>
							  <option>dry</option>
							  <option>sen</option>
							</select>
						</td>
                    </tr>
                    <tr>
                        <td>기능성 성분</td>
                        <td><input type="text" name="comp" id="comp" value="${item_bean.comp }"></td>
                    </tr>
                    <tr>
                        <td>태그</td>
                        <td><input type="text" name="tags" id="tags" value="${item_bean.tags }"></td>
                    </tr>
                </table>
                	<label for="img">이미지 업로드</label>
		        	<input type="file" name="img" id="img" />
               </form>
			    
			    <div id="img_preview">
			        <img src="${goRoot}${item_bean.img }" />
			        <br />
			        <a href="${goRoot}${item_bean.img }">Remove</a>
			    </div>
			  
		      </div>
		      <div class="modal-footer">
		        <button type="button" id="close" class="btn btn-default" data-dismiss="modal">닫기</button>
		        <button type="button" id="itemUpdate" class="btn btn-primary">수정</button>
		      </div>
		    </div>
		  </div>
		</div>
    <!-- //modal -->
	<div class="modal fade" id="item_delete" >
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title">제품 삭제</h4>
	      </div>
	      <div class="modal-body">
	        <p>제품을 삭제하시겠습니까?&hellip;</p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
	        <button type="button" class="btn btn-danger" id="itemDelete">제품 삭제</button>
	      </div>
	    </div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	
    <!--footer-->
            </div><!-- /.container-fluid -->
        </div><!-- /#page-wrapper -->
    </div><!-- /#wrapper -->

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
            $('#option').attr('value',2);
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
        resetFormElement($('#item_edit')); //전달한 양식 초기화
        $('#img').slideUp(); //파일 양식 감춤
        $('#img_preview').slideDown(); //미리 보기 영역 보여줌
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
        $('#img_preview img').attr("src","${goRoot}${item_bean.img }");
        $('#img_preview img').css('width', '100%');
        $('#img_preview a').attr("href","${goRoot}${item_bean.img }");
    }
        	
    </script> 
</body>
</html>