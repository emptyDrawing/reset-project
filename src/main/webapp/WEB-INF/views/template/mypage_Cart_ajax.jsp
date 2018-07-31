<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<style type="text/css">
    .contentsbox{
        width: 85%;
        margin: 0px auto;
        display: flex;
        border-bottom: 0.5px solid rgb(217, 222, 232);
        padding: 5px 0px;
    }   
    .numbox{
        width: 20%;
        margin: auto 0px;
        font-size: 30pt;
        text-align: center;
    }
    .imgbox{
        width: 30%;
        text-align: center;
        height: 160.5px;
    }
    .imgbox>img{
    	width: 160px;
    	height: 160px;
    }
    .conbox{
        width: 50%;
        margin: auto 0px;
    }
    .conbox>p{
        margin: 6px 0px;
    }
    .conbox>p:first-child,.conbox>p:last-child{
        color: #84868e;
    }
</style>
	<c:forEach items="${alist }" var="bean">
	<a href="../item/${bean.item }">
		<div class="contentsbox">
			<div class="numbox box">
				<label>${num}</label>
			</div>
			<div class="imgbox box">
				<img src="../${bean.img }">
			</div>
			<div class="conbox box">
				<p>${bean.brand }</p>
				<p>${bean.name }</p>
				<p>${bean.vol }&nbsp;${bean.price }원</p>
			</div>
		</div>
	</a>
	</c:forEach>