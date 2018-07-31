<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:forEach items="${itemList}" var="bean">
	<button class="btn darkBtn chartBtn" data-type="${command }" data-id="${bean.no}">${bean.title}</button>
</c:forEach>