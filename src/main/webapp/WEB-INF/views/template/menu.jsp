<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<!--header-->
    <div class="header">
    	<div class="wrap">
            <nav class="main_menu container">
                <div class="menu_img">
                <a href="/reset/">
                    <img src="${goRoot}imgs/header_logo.png">
                    </a>
                </div>
                <div class="menu_empty"></div>
                <div class="menu_login_bar">
                    <div class="login-group" >
                    	<c:if test="${login_on eq true}">
							<c:choose>
	                    		<c:when test="${login_user_type eq '일반' }"><a href="${goRoot}mypage/"></c:when>
								<c:otherwise><a href="${goRoot}admin/"></c:otherwise>	                    	
							</c:choose>
                    	</c:if>
                    	<c:if test="${login_on eq null || login_on eq false }">
	                    	<a href="${goRoot}login/">
                    	</c:if>
                    	<img class="loginAndOut topicon" src="${goRoot}imgs/icon/grey-19.png" onmouseover="this.src='${goRoot}imgs/icon/red-19.png' "onmouseover="this.src='${goRoot}imgs/icon/red-19.png'" onmouseout="this.src='${goRoot}imgs/icon/grey-19.png'"></a>
                        <!-- <label class="sr-only" for="search">검색</label> -->
                        <a href="${goRoot}item"><img class="search topicon" src="${goRoot}imgs/icon/grey-49.png" onmouseover="this.src='${goRoot}imgs/icon/red-49.png' "onmouseover="this.src='${goRoot}imgs/icon/red-49.png'" onmouseout="this.src='${goRoot}imgs/icon/grey-49.png'"></a>
                    </div>
                    <div class="menu_bar">
                        <ul class="nav">
                          <li class="top-menu"><a href="/reset/">랭킹</a>
                            <div class="space">
                              <ul class="sub-menu">
                                  <li><a href="${goRoot }ranking?id=1">스킨</a></li>
                                  <li><a href="${goRoot }ranking?id=2">로션</a></li>
                                  <li><a href="${goRoot }ranking?id=3">에센스</a></li>
                              </ul>
                            </div>
                          </li>
                          <li><a href="${goRoot }magazine">화플</a></li>
                          <li><a href="${goRoot }event">이벤트</a>
                          </li>                                  
                          <li class="top-menu"><a href="/reset/">고객상담</a>
                            <div class="space">
                              <ul class="sub-menu">
                                  <li><a href="${goRoot }notice">공지사항</a></li>
                                  <li><a href="${goRoot }qna">문의</a></li>
                              </ul>
                            </div>
                          </li>
                        </ul>
                    </div>
                </div>
             </nav>                
        </div>    
    </div>
    <!--//header--> 