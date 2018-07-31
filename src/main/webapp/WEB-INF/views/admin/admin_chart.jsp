<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<%@include file="/WEB-INF/views/template/admin_header.jsp" %>
	<script>
	// 이문서의 필드
	
	var getList = function(ele,command,start,cnt){
		var $target = $(ele);
		var sendData = "resultType=list&itemList=true";
		if(! ('${login_comName}' == 'reset'))sendData +="&where=${login_email}";
		
		$.post("${goRoot}admin/ajax/"+command,sendData)
		.done(function(data){
			var resultHTML= data;
			$(resultHTML).appendTo($target);
			setEventBtn();
		});
	}
	var setEventBtn = function(){
		$('.chartBtn').each(function(){
			var $target = $(this);
			$target.on("click",function(){
				var command = $target.attr("data-type");
				var no = $target.attr("data-id");
				var canvas = $("#chart-target");
				getChart(canvas,command,7,no);
			});
		});
	}
	
	
	var getChart = function(ele,type,day,no){
		var $target = $(ele);
		var data;
		var sendData ="log_day="+day+"&no="+no;
		var test = $.post("${goRoot}admin/chart/"+type,sendData);
		
		test.done(function(data){
			$target.html(data);
		});
	}
	
	
	// 문서 온로드 시점
	$(function(){
		if($("#chart-itemlist").length>0){
			getList($("#chart-itemlist"),"${command}",0,1000); // 페이징 나중에
		}else{
			var target = $("#chart-target");
			var type = '${command}';
			getChart(target,type,7,-1);
		}
	});
	</script>
</head>

<body>
    <div id="wrapper">
	<%@include file="/WEB-INF/views/template/admin_side_menu.jsp" %>
        <div id="page-wrapper">
            <div class="container-fluid">
            <!-- 컨탠츠 시작 -->
            	<c:choose>
					<c:when test="${command eq 'event' || command eq 'magzine' || command eq 'review' }">
		           	<div class="row">    
				        <div class="col-lg-12">
							<div class="panel panel-default">
								<div class="panel-heading">
                    	            <h3 class="panel-title">${command} 리스트</h3>
                        	    </div>
                       		<div id="chart-itemlist" class="panel-body"></div>
                       	</div>
			        </div>
				</div><!-- end row -->
					</c:when>
            	</c:choose>
                <!-- /.row -->
                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">${command} 차트</h3>
                            </div>
                            <div id="chart-target" class="panel-body"></div>
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