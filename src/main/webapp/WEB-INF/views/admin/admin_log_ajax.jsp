<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<div class="list-group" >
	<c:forEach items="${log_list }" var="line">
		<c:if test="${mode ne 'detail' }">
		<a class="list-group-item" style="width:100%; text-overflow: ellipsis;">
			<p>${line.msg}<span class="badge text-right">${line.nalja}</span></p>
		</a>	
		</c:if>
		<c:if test="${mode eq 'detail' }">
		<a class="list-group-item" style="width:100%;">
			<span>[${line.logCate}]</span>		
			<p>@${line.cate}@-${line.msg}<span class="badge text-right">${line.nalja}</span></p>
		</a>	
		</c:if>
	</c:forEach>
</div>
<c:if test="${more_Log && logLine ne 0 }">
   <div class="text-right">
   		<a href="#end${endPoint}" class="btn darkBtn logLine" data-size=${logLine}>더보기</a>
   </div>
   <div id="end${endPoint}"></div>
</c:if>

