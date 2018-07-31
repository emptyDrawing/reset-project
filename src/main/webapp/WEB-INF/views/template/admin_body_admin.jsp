<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<script>
	var getNums = function() {
		var $targets = $(".getNum");
		$targets.each(function(){
			var $target = $(this)
			// rev-cnt/ mag-cnt/ eve-cnt / itm-cnt
			var cntType= $target.attr('id');
			var sendData = "resultType=int";
			$.post("${goRoot}admin/ajax/"+cntType,sendData)
			.done(function(data){
				if(data.result==200){
					$target.text(data.result_data);
				}
			}); 
		});
	};
	var getLogForMain = function(ele,type,cnt){
		var $target = $(ele);
		var data;
		var sendData = "log_start_num="+cnt+"&more_Log=false";
		var test = $.post("${goRoot}admin/log/"+type,sendData);
		test.done(function(data){
			$target.html(data);
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
	
	
	$(function(){
		var log_normal = $("#log_normal");
		var log_err = $("#log_err");
		var login_chart = $("#chart-target");
		getLogForMain(log_normal,"normal",10);
		getLogForMain(log_err,"error",10);
		getChart(login_chart,"login",7,-1);
		getNums();
		// 30초 watch	
		setInterval(function(){
			getNums();
		},30000);

		// 45초 watch
		setInterval(function(){
			getLogForMain(log_normal,"normal",10);
			getLogForMain(log_err,"error",10);
			getChart(login_chart,"login",7,-1);
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
                                        <div class="huge getNum" id="rev-cnt"></div>
                                    </div>
                                </div>
                            </div>
                            <a href="./review">
                                <div class="panel-footer">
                                    <span class="pull-left">리스트 보기</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
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
                                        <div class="huge getNum" id="mag-cnt"></div>
                                    </div>
                                </div>
                            </div>
                            <a href="./magazine">
                                <div class="panel-footer">
                                    <span class="pull-left">리스트 보기</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
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
                                        <div class="huge getNum" id="eve-cnt"></div>
                                    </div>
                                </div>
                            </div>
                            <a href="./event">
                                <div class="panel-footer">
                                    <span class="pull-left">리스트 보기</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
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
                                        <div class="huge getNum" id="itm-cnt"></div>
                                    </div>
                                </div>
                            </div>
                            <a href="./item">
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
                <!-- /.row -->
                <div class="row">
                    <div class="col-lg-6">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title"><i class="fa fa-clock-o fa-fw"></i>실시간 활동</h3>
                            </div>
                            <div id="log_normal" class="panel-body">
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title"><i class="fa fa-money fa-fw"></i>에러로그</h3>
                            </div>
                            <div id="log_err" class="panel-body">
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.row -->

            </div>
            <!-- /.container-fluid -->

        </div>
        <!-- /#page-wrapper -->
    </div>
    <!-- /#wrapper -->
</body>
