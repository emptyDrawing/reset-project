<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<%@include file="/WEB-INF/views/template/admin_header.jsp" %>
	<script>
	// 이문서의 필드
	var totNum;
	var nowlistNum;
	var saveType;
	var saveTxt;
	
	var getList = function(ele,type,start,cnt,searchType,txt){
		var $target = $(ele);
		var data;
		var sendData ="resultType=list&type="+type
				+"&start="+start+"&cnt="+cnt
				+"&searchType="+searchType+"&txt="+txt;
		var test = $.post("${goRoot}admin/ajax/member",sendData);
		test.done(function(data){
			var resultHTML= data
			$(resultHTML).appendTo($target);
			addEventForDetail();
			//updateNum();
		});
	}
	
	var updateNum = function(ele){
		var $target = $(ele);
		var $div = $target.find("#tmps");
		totNum = $div.attr("data-cnt");
		nowlistNum += $div.attr("list-size");
		alert(totNum+"/"+nowlistNum);
		// 여기서 더보기 만들어야됨.
	}

	var addEventForSearBar = function(){
	    $('.search-panel .dropdown-menu').find('a').click(function(e) {
			e.preventDefault();
			var param = $(this).attr("href").replace("#","");
			var concept = $(this).text();
			$('.search-panel span#search_concept').text(concept);
			$('.input-group #search_param').val(param);
		});
	    $("#ajax-search").on("click",function(){
	    	var searchType = $('.input-group #search_param').val();
	    	var txt = $("#search_txt").val();
	       	saveType = searchType // 더보기를 위해서 저장
	    	saveTxt = txt // 더보기를 위해서 저장
	    	clearList($("#list_target"))
	    	getList($("#list_target"),"${command}",0,1000,searchType,txt); // 우선 더보기 생략
	    });
	}
	
	var clearList = function(ele){
		var $target = $(ele);
		$target.empty();
	}	
	
	var addEventForDetail = function(){
	    var panels = $('.user-infos');
	    var panelsButton = $('.dropdown-user');
	    panels.hide();

	    //Click dropdown
	    panelsButton.click(function() {
	        //get data-for attribute
	        var dataFor ="#"
	        dataFor += $(this).attr('data-for');
	        var idFor = $(dataFor);
	        //current button
	        var currentButton = $(this);
	        idFor.slideToggle(400, function() {
	            //Completed slidetoggle
	            if(idFor.is(':visible')){currentButton.html('<i class="glyphicon glyphicon-chevron-up text-muted"></i>');}
	            else{currentButton.html('<i class="glyphicon glyphicon-chevron-down text-muted"></i>');}
	        })
	    });
	    $('[data-toggle="tooltip"]').tooltip();
	}

	
	// 문서 온로드 시점
	$(function(){
		addEventForSearBar();
		getList($("#list_target"),"${command}",0,1000); // 페이징 나중에
	});
	
	
	</script>
</head>

<body>
    <div id="wrapper">
	<%@include file="/WEB-INF/views/template/admin_side_menu.jsp" %>
        <div id="page-wrapper">
            <div class="container-fluid">
            
                <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">회원관리</h1>
                    </div>
                </div><!-- /.row -->
			    <div class="row">    
			        <div class="col-xs-8 col-xs-offset-2">
					    <div class="input-group">
			                <div class="input-group-btn search-panel">
			                    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
			                    	<span id="search_concept">검색조건</span> <span class="caret"></span>
			                    </button>
			                    <ul class="dropdown-menu" role="menu">
			                    <c:if test="${command eq 'normal'}">
			                      <li><a href="#email">이메일</a></li>
			                      <li><a href="#nick">닉네임</a></li>
			                      <li><a href="#pointUp">포인트 ? 이상</a></li>
			                      <li><a href="#pointDown">포인트 ? 이하</a></li>
			                    </c:if>
			                    <c:if test="${command eq 'company'}">
			                      <li><a href="#email">이메일</a></li>
			                      <li><a href="#manager">담당자</a></li>
			                      <li><a href="#bisnum">사업자번호</a></li>
			                      <li><a href="#company">기업이름</a></li>
			                    </c:if>
			                    <c:if test="${command eq 'emp'}">
			                      <li><a href="#email">이메일</a></li>
			                      <li><a href="#manager">담당자</a></li>
			                    </c:if>
			                    </ul>
			                </div>
			                <input type="hidden" name="searchType" value="all" id="search_param"><!-- 검색조건 -->       
			                <input type="text" class="form-control" name="txt" id="search_txt" placeholder="검색조건 ...">
			                <span class="input-group-btn">
			                    <button class="btn btn-default" id="ajax-search" type="button"><span class="glyphicon glyphicon-search"></span></button>
			                </span>
			            </div>
			        </div>
				</div><!-- end row -->
				<div class="row">
					<div class="well col-xs-8 col-xs-offset-2" id="list_target"><!-- list start-->

					</div><!-- list end-->					
				</div><!-- end row -->
            </div><!-- /.container-fluid -->
        </div><!-- /#page-wrapper -->
    </div><!-- /#wrapper -->
</body>
</html>