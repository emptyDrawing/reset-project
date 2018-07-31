<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@include file="/WEB-INF/views/template/admin_header.jsp" %>
	<!-- 생각해봐야됨. -->
	<script>
	var getNums = function() {
		var $targets = $(".getNum");
		var sendData = "resultType=int";
		$target.each(function(){
			
			$.post(); // TODO :[KSS] 지금 하고 있는 부분.
		});
	};
	
	var getChart = function(ele,type,day,no){
		var $target = $(ele);
		var data;
		var sendData ="log_day="+day+"&no="+no;
		var test = $.post("${goRoot}admin/chart/"+type,sendData);
		
		test.done(function(data){
			$target.html(data);
		});
	}
	
	
	$(function(){
		var login_chart = $("#chart-target");
		getChart(login_chart,"login",7,-1);
		
		// 30초 watch	
		setInterval(function(){
		},30000);

		// 45초 watch
		setInterval(function(){
			getChart(login_chart,"event",7,-1);
		},45000);
		
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
                        <h1 class="page-header">
                            Dashboard <small>Overview</small>
                        </h1>
                    </div>
                </div>
                <!-- /.row -->
                <div class="row">
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-9">
                                        <div class="huge">리뷰</div>
                                    </div>
                                    <div class="col-xs-3 text-right">
                                        <div class="huge getNum" id="review_num"></div>
                                    </div>
                                </div>
                            </div>
                            <a href="./reviews/list/">
                                <div class="panel-footer">
                                    <span class="pull-left">리스트 보기</span>
                                    <span class="pull-right"></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-green">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-8">
                                        <div class="huge">매거진</div>
                                    </div>
                                    <div class="col-xs-4 text-right">
                                        <div class="huge getNum" id="mag_num"></div>
                                    </div>
                                </div>
                            </div>
                            <a href="./magzines/list/">
                                <div class="panel-footer">
                                    <span class="pull-left">리스트 보기</span>
                                    <span class="pull-right"></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-yellow">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-8">
                                        <div class="huge">이벤트</div>
                                    </div>
                                    <div class="col-xs-4 text-right">
                                        <div class="huge getNum" id="eve_num"></div>
                                    </div>
                                </div>
                            </div>
                            <a href="./events/list/">
                                <div class="panel-footer">
                                    <span class="pull-left">리스트 보기</span>
                                    <span class="pull-right"></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-red">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-8">
                                        <div class="huge">화장품</div>
                                    </div>
                                    <div class="col-xs-4 text-right">
                                        <div class="huge getNum" id="itm_num">13</div>
                                    </div>
                                </div>
                            </div>
                            <a href="./items/list/">
                                <div class="panel-footer">
                                    <span class="pull-left">리스트보기</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
                <!-- /.row -->
                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title"><i class="fa fa-bar-chart-o fa-fw"></i>로그인현황</h3>
                            </div>
                            <div id="chart-target" class="panel-body">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /.container-fluid -->

        </div>
        <!-- /#page-wrapper -->
    </div>
    <!-- /#wrapper -->
</body>
