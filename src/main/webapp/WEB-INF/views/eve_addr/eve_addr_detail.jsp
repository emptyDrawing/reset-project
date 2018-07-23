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
            <div>총 참가인원 : ${tot }</div>
            <!-- 아코디언 시작 -->
            <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
            <c:forEach items="${detail }" var="bean" varStatus="status">
			  <div class="panel panel-default">
			    <div class="panel-heading" role="tab" id="headingOne">
			      <h4 class="panel-title">
			        <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse_${bean.add_no}" aria-expanded="true" aria-controls="collapseOne">
			          <span>${(tot - status.index) - ( (paging.currentPageNo - 1)  *  10 ) } </span>
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
			<div>
				<form action="/reset/admin/eveaddr/${eve_no }" method="post">
					<span><input type="text" name="eventNum" id="eventNum"></span>
					<span><button type="submit">당첨자 조회</button></span>
				</form>
			</div>
			
            <!-- 내용 입력 끝 -->
            <div>
		<!-- 페이징  -->
		<c:choose>
		<c:when test="${paging.numberOfRecords ne NULL and paging.numberOfRecords ne '' and paging.numberOfRecords ne 0}">
		<div class="text-center marg-top">
			<ul class="pagination">
				<c:if test="${paging.currentPageNo gt 5}">  											  <!-- 현재 페이지가 5보다 크다면(즉, 6페이지 이상이라면) -->
					<li><a href="javascript:goPage(${paging.prevPageNo}, ${paging.maxPost})">이전</a></li> <!-- 이전페이지 표시 -->
				</c:if>
				<!-- 다른 페이지를 클릭하였을 시, 그 페이지의 내용 및 하단의 페이징 버튼을 생성하는 조건문-->
					<c:forEach var="i" begin="${paging.startPageNo}" end="${paging.endPageNo}" step="1"> <!-- 변수선언 (var="i"), 조건식, 증감식 -->
		            <c:choose>
		                <c:when test="${i eq paging.currentPageNo}"> 
		                      <li class="active"><a href="javascript:goPage(${i}, ${paging.maxPost})">${i}</a></li> <!-- 1페이지부터 10개씩 뽑아내고, 1,2,3페이지순으로 나타내라-->
		                </c:when>
		                	<c:otherwise>
		                    <li><a href="javascript:goPage(${i}, ${paging.maxPost})">${i}</a></li> 
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<!-- begin에 의해서 변수 i는 1이기 때문에, 처음에는 c:when이 수행된다. 그 후 페이징의 숫자 2를 클릭하면 ${i}는 2로변하고, 현재는 ${i}는 1이므로 otherwise를 수행한다
					         그래서 otherwise에 있는 함수를 수행하여 2페이지의 게시물이 나타나고, 반복문 실행으로 다시 forEach를 수행한다. 이제는 i도 2이고, currentPageNo도 2이기 때문에
					     active에 의해서 페이징부분의 2에 대해서만 파란색으로 나타난다. 그리고 나머지 1,3,4,5,이전,다음을 표시하기위해 다시 c:otherwise를 수행하여 페이징도 나타나게한다.-->
				<!-- // 다른 페이지를 클릭하였을 시, 그 페이지의 내용 및 하단의 페이징 버튼을 생성하는 조건문-->
										
				<!-- 소수점 제거 =>-->
				<fmt:parseNumber var="currentPage" integerOnly="true" value="${(paging.currentPageNo-1)/5}"/>
				<fmt:parseNumber var="finalPage" integerOnly="true" value="${(paging.finalPageNo-1)/5}"/>
					
				<c:if test="${currentPage < finalPage}"> <!-- 현재 페이지가 마지막 페이지보다 작으면 '다음'을 표시한다. -->
					<li><a href="javascript:goPage(${paging.nextPageNo}, ${paging.maxPost})">다음</a></li>
				</c:if> 
			</ul>
		</div>
		</c:when>
		</c:choose>
		</div>
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
<script>
function goPage(pages, lines) {
    location.href = '?' + "pages=" + pages;
}
</script>  
</body>
</html>
