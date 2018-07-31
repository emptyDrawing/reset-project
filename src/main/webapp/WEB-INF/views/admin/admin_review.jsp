<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<%@include file="/WEB-INF/views/template/admin_header.jsp" %>
	<style type="text/css">
	
.category-list-card{
   background-color: #fff;
    border-radius: 3px;
    border: 1px solid #eee;
    cursor: pointer;
    display: block;
    margin: 5px 15px;
    padding: 8px 0;
}
.category-image{
    display: inline-block;
    text-align: center;
    height: 160px;
    vertical-align: top;
    width: 208px;
    margin-right:15px;
}
.category-name{
    display: inline-block;
    margin-left: 10px;
    font-size: 18px;
    margin-top: 42px;
    width: 49%;
}
.right-arrow-div{
    float:right;
    margin-right:10px;
    margin-top:70px;
    font-size:20px;
}
.categor-name h3{
    color: #333;
    margin-bottom: 10px;
}
	
	</style>
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
						<c:forEach items="${rev_list }" var="bean">
									<div class="col-md-6">
									    <div class="category-list-card">
									        <div class="category-image">
									            <img src="http://crushlobby.com/bootsnipp_img/vege.png">
									        </div>
									        <div class="category-name">
									            <h3>Fruits & Vegetables</h3>
									            <p>Fruit & Vegetable Baskets, Fruits, Vegetables, Cut Fresh & Herbs, Mangoes</p>
									        </div>
									         <div class="right-arrow-div">
									           <i class="fa fa-angle-right"></i>
									       </div>
									    </div>
									</div>
						</c:forEach>

					</div><!-- list end-->					
				</div><!-- end row -->
            </div><!-- /.container-fluid -->
        </div><!-- /#page-wrapper -->
    </div><!-- /#wrapper -->
</body>
</html>