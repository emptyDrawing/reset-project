<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="${goRoot }js/jquery-1.12.4.js"></script>
<script src="${goRoot }js/bootstrap.min.js"></script>
<link href="${goRoot }css/bootstrap.min.css" rel="stylesheet">
<link href="${goRoot }css/bootstrap-theme.min.css" rel="stylesheet">
<link href="${goRoot }css/main.css" rel="stylesheet">
	<title>Home</title>
</head>
<body>
	<!--header-->
    <div class="header">
    	<div class="wrap">
            <nav class="main_menu container">
                <div class="menu_img">
                    <img src="imgs/header_logo.png">
                </div>
                <div class="menu_login">
                    <form class="form-inline">
                        <div class="form-group">
                            <label class="sr-only" for="search">검색</label>
                            <input type="text" class="form-control input_box" placeholder="검색">
                        </div>
                        <button type="submit" class="btn send_btn"><span class="main_font">검색</span></button>
                        <button type="submit" class="btn send_btn"><span class="main_font">로그인</span></button>
                        <button type="submit" class="btn send_btn"><span class="main_font">회원가입</span></button>
                    </form>
                </div>
                <div class="menu_bar">
                    <ul class="nav">
                      <li class="current"><a href="index.html">홈</a></li>
                      <li><a href="about.html">랭킹</a></li>
                      <li class="top-menu"><a href="javascript:{}">화플</a>
                          <ul class="sub-menu">
                              <li><a href="scaffolding.html">Scaffolding</a></li>
                              <li><a href="typography.html">Typography</a></li>
                              <li><a href="shortcodes.html">Shortcodes</a></li>
                              <li><a href="tables.html">Tables</a></li>
                          </ul>
                      </li>
                      <li class="top-menu"><a href="javascript:{}">이벤트</a>
                           <ul class="sub-menu">
                              <li><a href="portfolio_2columns.html">2 Columns</a></li>
                              <li><a href="portfolio_3columns.html">3 Columns</a></li>
                              <li><a href="portfolio_4columns.html">4 Columns</a></li>
                          </ul>
                      </li>                                  
                      <li class="top-menu"><a href="javascript:{}">리뷰</a>
                           <ul class="sub-menu">
                              <li><a href="blog.html">Blog with right sidebar</a></li>
                              <li><a href="blog_post.html">Blog post</a></li>
                          </ul>
                      </li>
                      <li><a href="contacts.html">문의</a></li>
                    </ul>
                </div>
             </nav>                
             
        </div>    
    </div>
    <!--//header-->    
     
    <!-- main contents -->
    <div class="page_container">
        <hr>
            <!-- 내용 입력 시작 -->
            <div><h1>당첨자 결과</h1></div>
            <!-- 아코디언 시작 -->
            <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
            <c:forEach items="${detail }" var="bean" varStatus="status">
			  <div class="panel panel-default">
			    <div class="panel-heading" role="tab" id="headingOne">
			      <h4 class="panel-title">
			        <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse_${bean.add_no}" aria-expanded="true" aria-controls="collapseOne">
			          ${bean.add_no} : ${bean.name}
			        </a>
			      </h4>
			    </div>
			    <div id="collapse_${bean.add_no}" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
			      <div class="panel-body">
			     	<div>
			     		<label for="name">이름 : </label>
			     		<span id="name" name="name">${bean.name}</span>
			     	</div>
			     	<div>
			     		<label for="email">이메일 : </label>
			     		<span id="email" name="email">${bean.email}</span>
			     	</div>
			     	<div>
			     		<label for="phone">전화번호 : </label>
			     		<span id="phone" name="phone">${bean.phone}</span>
			     	</div>
			     	<div>
			     		<label for="postcode">우편번호 : </label>
			     		<span id="postcode" name="postcode">${bean.postcode }</span>
			     	</div>
			     	<div>
			     		<label for="address">주소 : </label>
			     		<span id="address" name="address">${bean.address }</span>
			     	</div>
			      </div>
			    </div>
			  </div>
			  </c:forEach>
			</div><!-- 아코디언 끝 -->
            <!-- 내용 입력 끝 -->
        <hr>
    </div>
    <!-- //main contents -->

    <!--footer-->
    <div class="footer">
        <div class="wrap">
            <div class="container">
                <div class="row">
                    <div class="footer_L">
                        <div class="foot_logo"><a href="index.html"><img src="imgs/footer_logo.png" alt="" /></a></div>
                        <div class="copyright">&copy; 2020 Jessica White. Professional Fashion Photography. All Rights Reserved.</div>                        
                    </div>
                    <div class="footer_R">
                        <div class="fright">
                            <form action="#" method="post">
                                <input class="inp_search" name="name" type="text" value="   Search the Site" onfocus="if (this.value == 'Search the Site') this.value = '';" onblur="if (this.value == '') this.value = 'Search the Site';" />
                            </form>
                        </div>
                        <div class="footer_menu">
                            <ul class="nav">
                                <li><a href="index.html" class="current">홈</a></li>
                                <li><a href="about.html">랭킹</a></li>
                                <li><a href="scaffolding.html">화플</a></li>
                                <li><a href="portfolio_2columns.html">이벤트</a></li>
                                <li><a href="blog.html">리뷰</a></li>
                                <li><a href="contacts.html">문의</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--//footer-->   
</body>
</html>
