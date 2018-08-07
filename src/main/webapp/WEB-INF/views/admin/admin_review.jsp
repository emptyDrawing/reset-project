<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<%@include file="/WEB-INF/views/template/admin_header.jsp" %>
	<link rel="stylesheet" href="${goRoot }css/ranking_review/item_detail.css" type="text/css">
	<script>
	var getList = function(ele,command,start,cnt){
		var $target = $(ele);
		var sendData = "resultType=list";
		if('${login_comName}' != 'reset')sendData +="&where=${login_email}";
		$.post("${goRoot}admin/ajax/"+command,sendData)
		.done(function(data){
			var resultHTML= data;
			$(resultHTML).appendTo($target);
		});
	}
	
	// 문서 온로드 시점
	$(function(){
		if($("#list_target").length>0){
			getList($("#list_target"),"review",0,10000); // 페이징 나중에
		}	
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
                        <h1 class="page-header">리뷰 관리</h1>
                    </div>
                </div><!-- /.row -->
				<div class="row">
					<div class="well col-xs-8 col-xs-offset-2" id="list_target"><!-- list start-->
					</div><!-- list end-->					
				</div><!-- end row -->
            </div><!-- /.container-fluid -->
        </div><!-- /#page-wrapper -->
    </div><!-- /#wrapper -->
</body>
</html>