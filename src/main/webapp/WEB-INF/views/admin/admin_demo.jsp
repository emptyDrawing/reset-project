<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<%@include file="/WEB-INF/views/template/admin_header.jsp" %>
	<script>
	// 이문서의 필드
	var getLog = function(ele,type,start,cnt){
		var $target = $(ele);
		var data;
		var sendData = "log_start_num="+start+"&nextNum="cnt+"&more_Log=true"+"&mode=detail";
		var test = $.post("${goRoot}admin/log/"+type,sendData);
		test.done(function(data){
			$target.html(data);
		});
	}
	// 문서 온로드 시점
	$(function(){
		getlog($("#log-target"),"${command}",0,1000); // 페이징 나중에
	});
	</script>
</head>

<body>
    <div id="wrapper">
	<%@include file="/WEB-INF/views/template/admin_side_menu.jsp" %>
        <div id="page-wrapper">
            <div class="container-fluid">
            <!-- 컨탠츠 시작 -->
                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">${command}로그</h3>
                            </div>
                            <div id="log-target" class="panel-body">
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.row -->
            <!-- 컨탠츠 끝 -->
            </div><!-- /.container-fluid -->
        </div><!-- /#page-wrapper -->
    </div><!-- /#wrapper -->
</body>
</html>